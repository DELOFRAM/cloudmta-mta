local checkBuildings = true
local checkVehicles = true
local checkPlayers = true
local checkObjects = true
local checkDummies = true
local seeThroughStuff = true
local ignoreSomeObjectsForCamera = true
local shootThroughStuff = true
local includeWorldModelInformation = true
local bIncludeCarTyres = true
local ignoredElement = getLocalPlayer(  )

FillWater = {
[1211] = true,
}

VehicleModel = {
[407] = true,
}

addCommandHandler("waz", function(cmd, key)
	if key == "podlacz" then
		addFireHose(getLocalPlayer(  ))
	elseif key == "odlacz" then
		removeFireHose(getLocalPlayer(  ))
	end
end)


function removeFireHose(plr)
local x,y,z = getElementPosition( plr )
local rot = 360-getPedRotation( plr )
local rot = math.rad(rot)
local x = x + 0 * math.sin(rot)
local y = y + 0 * math.cos(rot)
local x1 = x + 1 * math.sin(rot)
local y1 = y + 1 * math.cos(rot)
local z = z+0.05
local hit,hx,hy,hz,he,nx,ny,nz,material,lighting,piece,wmodelid, wmx, wmy, wmz, wmrx, wmry, wmrz = processLineOfSight ( x, y, z, x1, y1, z, checkBuildings,checkVehicles,checkPlayers,checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,shootThroughStuff, ignoredElement,includeWorldModelInformation,bIncludeCarTyres  )
	if hit then
		if getElementType(he) == "vehicle" and VehicleModel[getElementModel(he)] == true then
			local firehose = getElementData(plr,"firehose")
			if not(firehose) then outputChatBox("Nie posiadasz żadnego węża w ręce.") return end
			local id = firehose.id
			local firehose = getElementData(he,"firehose")

			if firehose[id].attach == plr then 
				table.remove(firehose, id)
				--outputChatBox("Pomyślnie odłączyłeś wąż od pojazdu.")
				setElementData(he,"firehose",firehose)
			end
		elseif getElementType(he) == "object" and FillWater[wmodelid] == true then
			if not( getElementData(he,"attach") ) then outputChatBox("Przy hydrancie nie ma żadnego wężą.") return end
			local tab = getElementData(he,"attach")
			--outputChatBox("Pomyślnie odłączyłeś wąż od hydrnatu")
			local firehose = getElementData(tab[1],"firehose")
			firehose[tab[2]].attach = plr
			setElementData(tab[1],"firehose",firehose)
			setElementData(plr,"firehose",firehose[tab[2]])
			setElementData(he,"attach",false)
		end
	end
end


function addFireHose(plr)
local x,y,z = getElementPosition( plr )
local rot = 360-getPedRotation( plr )
local rot = math.rad(rot)
local x = x + 0 * math.sin(rot)
local y = y + 0 * math.cos(rot)
local x1 = x + 1 * math.sin(rot)
local y1 = y + 1 * math.cos(rot)
local z = z+0.05
local hit,hx,hy,hz,he,nx,ny,nz,material,lighting,piece,wmodelid, wmx, wmy, wmz, wmrx, wmry, wmrz = processLineOfSight ( x, y, z, x1, y1, z, checkBuildings,checkVehicles,checkPlayers,checkObjects,checkDummies,seeThroughStuff,ignoreSomeObjectsForCamera,shootThroughStuff, ignoredElement,includeWorldModelInformation,bIncludeCarTyres  )
	if hit then
		if getElementType(he) == "vehicle" and VehicleModel[getElementModel(he)] == true then
			if getElementData(plr,"firehose") then outputChatBox("Posiadasz już jeden wąż w ręce") return end

			if not( getElementData(he,"firehose") ) then
				firehose = {}
			end
			local firehose = getElementData(he,"firehose")
			if not( type(firehose) == "table") then firehose = {} end
			local ox, oy, oz = getElementPosition( he )
			table.insert(firehose,{id=#firehose+1, x=ox, y=oy, z=oz, attach=plr, vehicle=he}  )
			setElementData(he,"firehose",firehose)
			setElementData(plr,"firehose",firehose[#firehose])
			--outputChatBox("Pomyślnie podłączono wąż do pojazdu.")
		elseif getElementType(he) == "object" and FillWater[wmodelid] == true then
			if not( getElementData(plr,"firehose") ) then outputChatBox("Nie posiadasz w ręcę węża.") return end
			if getElementData(he,"attach") then outputChatBox("Do tego hydrnatu już jest podłączony wąż.") return end 


			local firehose = getElementData(plr,"firehose")
			setElementData(plr,"firehose",false)

			local id = firehose.id
			local veh = firehose.vehicle
			local firehose = getElementData(veh,"firehose")
			firehose[id].attach = he
			setElementData(veh,"firehose",firehose)
			setElementData(he,"attach",{veh,id})
			outputChatBox("Pomyślnie podłączono wąż do hydrantu.")
		end
	end
end