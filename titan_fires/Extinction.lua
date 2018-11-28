local showRender = false

local function createWaterBar(ex,ey,ez, Water, maxWater, text)
  local x,y = getScreenFromWorldPosition ( ex, ey, ez-0.25, 0.06 )
  if not x then return end
  local px,py,pz = getElementPosition( localPlayer )
  if getPedOccupiedVehicle( localPlayer ) then
      px,py,pz = getElementPosition( localPlayer )
      value = 1.5
  else
      value = 2
  end
  local scale = getDistanceBetweenPoints3D( ex, ey, ez, px,py,pz )/value
  local startHP = maxWater
  local sizeX, sizeY = 200/scale, 20/scale
  local Water = 1 - (Water / maxWater)
  dxDrawRectangle(x - sizeX / 2 - 4, y - sizeY / 2 - 4, sizeX + 8, sizeY + 8, tocolor(0, 0, 0, 150))
  dxDrawRectangle(x - sizeX / 2, y - sizeY / 2, sizeX, sizeY, tocolor(0, 0, 172, 50))
  dxDrawRectangle(x - sizeX / 2, y - sizeY / 2, sizeX - (sizeX * Water), sizeY, tocolor(0, 0, 172, 200))
	if text then
		dxDrawText(text, x - sizeX / 2 + sizeX/2, y - sizeY / 2, sizeX, sizeY, tocolor(255,255,255,200), scale/2, "default")
	end
end

local function createHP(ex,ey,ez, HP, maxHP, distance,text)
local xs, ys, ds = getScreenFromWorldPosition ( ex, ey, ez-0.25, 0.06 )
	if xs and ys then
	local scale = 1.5/(ds/distance)
	local sizeX, sizeY = 200, 20
	local HP = 1 - (HP / maxHP)
		dxDrawRectangle(xs - sizeX / 2 - 4, ys - sizeY / 2 - 4, sizeX + 8, sizeY + 8, tocolor(0, 0, 0, 150))
  		dxDrawRectangle(xs - sizeX / 2, ys - sizeY / 2, sizeX, sizeY, tocolor(172, 0, 0, 50))
  		dxDrawRectangle(xs - sizeX / 2, ys - sizeY / 2, sizeX - (sizeX * HP), sizeY, tocolor(172, 0, 0, 200))
		if text then
			dxDrawText(text, xs - sizeX / 2 + sizeX/2, ys - sizeY / 2, sizeX, sizeY, tocolor(255,255,255,200), scale/2, "default")
		end
	end
end


function renderFire()
  for i, v in ipairs(getElementsByType("colshape",resourceRoot)) do
      if getElementData(v,"data:fire") then
        local x, y, z = getElementPosition ( v )
        local px, py, pz = 0,0,0
        if getPedOccupiedVehicle( getLocalPlayer(  ) ) then
          local veh = getPedOccupiedVehicle( getLocalPlayer(  ) )
          px,py,pz = getElementPosition( veh )
          distance = 40
          ds = 60
        else
          px,py,pz = getElementPosition(localPlayer)
          distance = 10
          ds = 8
        end
       

      if getDistanceBetweenPoints3D( x, y, z, px, py, pz ) < distance then
          local data = getElementData(v,"data:fire")
          createHP(x, y, z, data[2], data[1], ds, false )
        end
      end
  end
end

function SwitchExtinguisher ( prevSlot, newSlot )
  if getPedWeapon(getLocalPlayer(),newSlot) == 42 then
      addEventHandler( "onClientRender", getRootElement(  ), renderFire )
  else
      if isEventHandlerAdded("onClientRender", getRootElement(  ), renderFire ) then
        removeEventHandler( "onClientRender", getRootElement(  ), renderFire )
      end
  end
end
addEventHandler ( "onClientPlayerWeaponSwitch", getRootElement(), SwitchExtinguisher )


function checkTurret()
  local veh = getPedOccupiedVehicle(localPlayer)
  if not veh then return end
  if getElementModel(veh) == 407 then
    renderFire()

  local water = getElementData(veh,"water")
    if not(water) then
      toggleControl( "vehicle_fire", false ) 
      toggleControl( "vehicle_secondary_fire", false ) 
      return 
    elseif water[1] <= 0 then 
      toggleControl( "vehicle_fire", false ) 
      toggleControl( "vehicle_secondary_fire", false ) 
      return 
    elseif water[1] > 0 then 
      toggleControl( "vehicle_fire", true ) 
      toggleControl( "vehicle_secondary_fire", true )  
    end
   
   if not getControlState("vehicle_fire") and not getControlState("vehicle_secondary_fire") then return end
    setElementData(veh,"water",{water[1]-1,water[2]})

    local fX,fY,fZ = getElementPosition(veh)
    local turretPosX,turretPosY = getVehicleTurretPosition(veh)
    local turretPosX = math.deg(turretPosX)
    if turretPosX < 0 then turretPosX = turretPosX+360 end
    local rotX,rotY,rotZ = getElementRotation(veh)
    local turretPosX = turretPosX+rotZ-360
    if turretPosX < 0 then turretPosX = turretPosX+360 end
      for i,v in ipairs(getElementsByType("colshape",resourceRoot)) do
        local bX,bY,bZ = getElementPosition(v)
        if getDistanceBetweenPoints2D(bX,bY,fX, fY)<30 and getElementData(v,"data:fire") then 
          local neededRot = findRotation(fX,fY,bX,bY)
            if turretPosX > neededRot-10 and turretPosX < neededRot+10 and math.random(1,25)==1 then
            	local data = getElementData(v,"data:fire")
                if data[2] <= 0 then
                  triggerServerEvent( "destroyFire", localPlayer, v )
                elseif data[2] <= 2 then
                  data[2] = data[2]-1
                  setElementData(v,"data:fire",data)
                else
                  local rand = math.random(data[2]/4,data[2]/2)
                  data[2] = data[2] - rand
                  setElementData(v,"data:fire",data)
                end
              end
          end
       end
    end                                                   
end

function enterFireTruck(veh,seat)
  if getElementModel(veh) ~= 407 or seat > 0 then return end
     if not showRender then
      addEventHandler("onClientRender",root,checkTurret)
      addEventHandler("onClientRender",root, renderVehicleWater)
    end
end
addEventHandler("onClientPlayerVehicleEnter",localPlayer,enterFireTruck)

function exitFireTruck()  
  if showRender then 
      removeEventHandler("onClientRender",root,checkTurret)
      removeEventHandler("onClientRender",root, renderVehicleWater)
  end
end
addEventHandler("onClientPlayerVehicleExit",localPlayer,exitFireTruck)
addEventHandler("onClientPlayerWasted",localPlayer,exitFireTruck)


function findRotation(x1,y1,x2,y2)
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t+360 end
  return t
end


function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
  if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
    local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
    if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
      for i, v in ipairs( aAttachedFunctions ) do
        if v == func then
          return true
        end
      end
    end
  end
  return false
end

function createExtinguisher(wep,_,_,hitX,hitY,hitZ)
  if wep == 42 then 
    for k, v in ipairs(getElementsByType("colshape",resourceRoot)) do
            local fX,fY,fZ = getElementPosition(v)
            local dist = getDistanceBetweenPoints2D(hitX,hitY,fX,fY)
            if dist < 4 and getElementData(v,"data:fire") then
            	local data = getElementData(v,"data:fire")
                if data[2] <= 0 then
                  triggerServerEvent( "destroyFire", localPlayer, v )
                elseif math.random(1,9) == 1 then
                  data[2] = data[2]-1
                  setElementData(v,"data:fire",data )
              end
            end
        end
    elseif wep == 37 and math.random(1,5) == 1 then
        cancelEvent(  )
        local hitZ = getGroundPosition( hitX,hitY,hitZ )
        --triggerServerEvent("createFire", root, getElementData(localPlayer,"player:uid"), hitX, hitY, hitZ+1, getElementDimension(localPlayer), getElementInterior(localPlayer),  5, false, true)
    end
end
addEventHandler("onClientPlayerWeaponFire",localPlayer,createExtinguisher)


function cancelExtinguisherChoking(weaponID, responsiblePed)
  if (weaponID==42) then
    cancelEvent()
  end
end
addEventHandler("onClientPlayerChoke", getLocalPlayer(), cancelExtinguisherChoking)

function stopExtinguisherDamage ( attacker, weapon, bodypart )
  if ( weapon == 42 ) then
    cancelEvent()
  end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopExtinguisherDamage )



function renderVehicleWater()
local veh = getPedOccupiedVehicle( localPlayer )
      if veh and getElementModel(veh) == 407 and getElementData(veh,"water") then
        local seat = getVehicleOccupant( veh, 0 )
          if seat then
          local fX,fY,fZ = getElementPosition(veh)
          local x,y,z = getElementPosition( localPlayer )
          if getDistanceBetweenPoints3D( fX,fY,fZ, x, y, z ) < 5 then
            local water = getElementData(veh,"water")
            -- createWaterBar(fX,fY,fZ,water[1],water[2],(water[1]/water[2])*100 .."%")
            createWaterBar(fX,fY,fZ,water[1],water[2],water[1].." l")
          end
      end
  end
end