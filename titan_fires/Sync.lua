Fire = {}
Fire.skin = {
[277] = true,
[278] = true,
[279] = true,	
}


function FireHitElement( Element )
if isElementWithinColShaper( Element, source ) then
	local type = getElementType( Element )
		if type == "player" or type == "ped" then
			if getPedOccupiedVehicle( Element ) then return end
			if Fire.skin[getElementModel( Element )] then return end
			setPedOnFire( Element, true )
		elseif type == "vehicle" then
			takeElementHealth(Element,source)
		end
	end
end

function AirTakePlayer(Element)
	if getElementType(Element) == "player" and isElementWithinColShaper( Element, source ) then 
		triggerClientEvent( Element,"synchronization:client:oxygen", Element, Element, source )
	end
end

function AirRemovePlayer(Element)
	if getElementType(Element) == "player" then 
		triggerClientEvent( Element,"synchronization:client:oxygen:off", Element, Element )
	end
end




function NewcreateFire(x, y, z, dimension, interior, amount, size, Maxhealth, health, time, effect_name)
local UID = #Fire+1
Fire[UID] = {}
-- colission = createColSphere( x, y, z, size )
-- setElementDimension( colission, dimension )
-- setElementInterior( colission, interior )
-- setElementData(colission,"data:fire",{Maxhealth, health,UID,1,time,interior,dimension,effect_name,amount})
-- table.insert(Fire[UID],colission)
-- triggerClientEvent("synchronization:client:Effect", getRootElement(  ), UID, x, y, z, dimension, interior, colission, amount, effect_name )
-- local x, y, z = getElementPosition( colission )
-- addEventHandler ( "onColShapeHit", colission, FireHitElement )

addFire(UID, x+math.random(-2,2), y+math.random(-2,2), z, dimension, interior, amount, size, Maxhealth, health, time, effect_name)

if amount < 1 then
	setTimer(addFire,time*1000, 1, UID, x+math.random(-2,2), y+math.random(-2,2), z, dimension, interior, amount, size, Maxhealth, health, time, effect_name)
end
	
	if dimension ~= 0 and interior ~= 0 and not(Fire[UID].air) then
		Fire[UID].air = createColSphere( x, y, z, 20 )
		setElementDimension( Fire[UID].air, dimension )
		setElementInterior( Fire[UID].air, interior )		
		setElementData(Fire[UID].air,"data:fire",{Maxhealth, health,UID,1,time,interior,dimension,effect_name,amount})
		addEventHandler ( "onColShapeHit", Fire[UID].air, AirTakePlayer )
		addEventHandler ( "onColShapeLeave", Fire[UID].air, AirRemovePlayer )
	end

end
addEvent( "createFire", true )
addEventHandler( "createFire", getRootElement(  ), NewcreateFire )


function addFire(UID, x, y, z, dimension, interior, amount, size, Maxhealth, health, time, effect_name)
	if #Fire[UID] < amount then
		local ID = #Fire[UID]+1
		colission = createColSphere( x, y, z, size )
		setElementDimension( colission, dimension )
		setElementInterior( colission, interior )
		setElementData(colission,"data:fire",{Maxhealth, health,UID,ID,time,interior,dimension,effect_name,amount})
		table.insert(Fire[UID],colission)
		local x, y, z = getElementPosition( colission )
		triggerClientEvent("synchronization:client:Effect", getRootElement(  ), UID, x, y, z, dimension, interior, colission, amount, effect_name )
		setTimer(addFire,time*1000, 1, UID, x+math.random(-2,2), y+math.random(-2,2), z, dimension, interior, amount, size, Maxhealth, health, time, effect_name)
		addEventHandler ( "onColShapeHit", colission, FireHitElement )
	end
end
addEvent( "addFire", true )
addEventHandler( "addFire", getRootElement(  ), addFire )

function destroyFire(Element,ID)
	if type(Element) == "userdata" then
		for i,v in ipairs(getElementsByType("player")) do
			triggerClientEvent( v,"unsynchronization:client:Effect", v, Element )
		end
	
		if isElement(Element) then
			local data = getElementData(Element,"data:fire")
			local UID = data[3]
			table.remove(Fire[UID], data[4] )
			destroyElement( Element )
		end
	elseif type(Element) == "table" then
		
		for i,v in ipairs(Element) do
			for i,p in ipairs(getElementsByType("player")) do
				triggerClientEvent( p,"unsynchronization:client:Effect", p, v, true )
			end
			if isElement(v) then
				destroyElement( v )
			end
		end
		Fire[ID] = nil

	end
end
addEvent( "destroyFire", true )
addEventHandler( "destroyFire", getRootElement(  ), destroyFire )


function SyncedFire(player)
	for i,v in ipairs(getElementsByType("colshape",resourceRoot)) do
		if getElementData(v,"data:fire") then
			local data = getElementData(v,"data:fire")
			local x,y,z = getElementPosition( v )
			setTimer (triggerClientEvent,5000,1,player,"synchronization:client:Effect", player, data[3], x, y, z, data[7], data[6], v, data[9], data[8])
		end
	end
end
addEvent( "FireSyncedJoinPlayer", true )
addEventHandler( "FireSyncedJoinPlayer", getRootElement(  ), SyncedFire )

function onJoin()
setTimer(SyncedFire,5000,1,source)
end
addEventHandler ( "onPlayerJoin", getRootElement(), onJoin)