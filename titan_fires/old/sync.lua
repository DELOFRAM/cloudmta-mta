Server = {}
Server.Fires = {}

function randomFireType()
local rand = math.random(1,#data.Type)
local fire = data.Type[rand]
local HP = math.random(fire[2][1], fire[2][2])
local maxHP = fire[1]
local effect = fire[3]
local size = fire[4]
return maxHP, HP, effect, size
end

function FireHitElement( Element )
if isElementWithinColShaper( Element, source ) then
	local type = getElementType( Element )
		if type == "player" or type == "ped" then
			if getPedOccupiedVehicle( Element ) then return end
			if getElementData(Element,"player:nomex") then return end
			setPedOnFire( Element, true )
		elseif type == "vehicle" then
			takeElementHealth(Element,source)
		end
	end
end

function CreateFires(x, y, z, dimension, interior, value, random)
local UID = #Server.Fires+1
Server.Fires[UID] = {}
local maxHP, HP, effect, size = randomFireType()
colission = createColSphere( x, y, z, size )
setElementData(colission,"fire:uid",UID)
setElementData(colission,"fire:value",value)
setElementData(colission,"fire:HPMax",maxHP)
setElementData(colission,"fire:HP",HP)
setElementData(colission,"fire:position",{x,y,z,dimension,interior})
table.insert(Server.Fires[UID],colission)
triggerClientEvent("synchronization:client", getRootElement(  ), x, y, z, dimension, interior, colission, value, UID, effect )
local x, y, z = getElementPosition( colission )
setTimer(CreateFire, math.random(1,5)*1000, 1, UID, x, y, z, dimension, interior, value, random)
addEventHandler ( "onColShapeHit", colission, FireHitElement )
end
addEvent( "createFires", true )
addEventHandler( "createFires", getRootElement(  ), CreateFires )

function isColShapeCreatePosition(x, y, z)
    for k, v in ipairs(getElementsByType("colshape",resourceRoot)) do
    	local cx,cy,cz = getElementPosition( v )
    	local distance = getDistanceBetweenPoints3D( cx, cy, cz, x, y, z )
    	if distance <= 2 then
    		return false
    	end
    end
    return true
end


function CreateFire(UID, x, y, z, dimension, interior, value, random, single)
if not(Server.Fires[UID]) then
Server.Fires[UID] = {}
end	
	if #Server.Fires[UID] < value then
		if random then
			x,y = RandomPosittion(x,y,z)
		end

		if random and not(isColShapeCreatePosition(x,y,z)) then CreateFire(UID, x, y, z, dimension, interior, value) return end
		if not(random) and not(isColShapeCreatePosition(x,y,z)) then return end
		local maxHP, HP, effect, size = randomFireType()
		colission = createColSphere( x, y, z, size )
		setElementData(colission,"fire:uid",UID)
		setElementData(colission,"fire:id",#Server.Fires[UID]+1)
		setElementData(colission,"fire:HPMax",maxHP)
		setElementData(colission,"fire:HP",HP)
		setElementData(colission,"fire:position",{x,y,z,dimension,interior})
		table.insert(Server.Fires[UID],colission)
		triggerClientEvent("synchronization:client", getRootElement(  ), x, y, z, dimension, interior, colission, value, UID, effect )
		local x, y, z = getElementPosition( colission )
		
		if not(single) then
			setTimer(CreateFire, math.random(1,5)*1000, 1, UID, x, y, z, dimension, interior, value, random)
		end

		addEventHandler ( "onColShapeHit", colission, FireHitElement )
	end
end
addEvent( "createFire", true )
addEventHandler( "createFire", getRootElement(  ), CreateFire )

function removeFire(Element)
	for i,v in ipairs(getElementsByType("player")) do
		triggerClientEvent( v,"unsynchronization:client", v, Element )
	end

	if isElement(Element) then
		local UID = getElementData(Element,"fire:uid")
		destroyElement( Element )
		table.remove(Server.Fires[UID],1)
	end

end
addEvent( "Fire:remove", true )
addEventHandler( "Fire:remove", getRootElement(  ), removeFire )


function FireSyncedJoinPlayer( )
	for i,v in ipairs(getElementsByType("colshape",resourceRoot)) do
		if getElementData(v,"fire:id") then
			local pos = getElementData(v,"fire:position")
			local UID = getElementData(v,"fire:uid")
			local value = getElementData(v,"fire:value")
			--outputChatBox("[Client Synced] #"..i)
			--outputChatBox("x="..pos[1]..", y="..pos[2]..", z="..pos[3]..", dim="..pos[4].." int="..pos[5])
			setTimer (triggerClientEvent,5000,1,source,"synchronization:client", source, pos[1], pos[2], pos[3], pos[4], pos[5], v, value, UID)
		end
	end
end
addEvent( "FireSyncedJoinPlayer", true )
addEventHandler( "FireSyncedJoinPlayer", getRootElement(  ), FireSyncedJoinPlayer )



function explodeSyncedFire()
	local x,y,z = getElementPosition(source)
	local int, dim = getElementInterior(source), getElementDimension( source )
    triggerClientEvent("sync:PositionGround", source, math.random(999,9999), x, y, z, dim, int, math.random(1,5), true )
end
addEventHandler("onVehicleExplode", getRootElement(), explodeSyncedFire)


fireTruck = createVehicle( 407, 2142.37, -1109.52, 25.60 )
setElementData(fireTruck,"water",{5000,10000})