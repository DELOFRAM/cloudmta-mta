Client = {}
Client.Fires = {}



function SyncClient(x, y, z, dimension, interior, colission, value, UID, effect)
	if not( Client.Fires[UID] ) then
		Client.Fires[UID] = {}
	end
	if #Client.Fires[UID] < value then
		local z = getGroundPosition( x, y, z )
		es = createEffect(effect, x, y, z+0.5)
		setElementData(colission,"fire:effect",es)
		setElementData(colission,"fire:cid",#Client.Fires[UID]+1)
		table.insert(Client.Fires[UID],{es,#Client.Fires[UID]+1})
	end
end
addEvent( "synchronization:client", true )
addEventHandler( "synchronization:client", getRootElement(  ), SyncClient )


function UNSyncClient(Element)
	if isElement(Element) then
		local UID = getElementData(Element,"fire:uid")
		local id = getElementData(Element,"fire:cid")
		if UID and id then
			for i,v in ipairs(Client.Fires[UID]) do
				if v[2] == id then
					destroyElement( v[1] )
					table.remove(Client.Fires[UID],id)
				end
			end
		end

		if Client.Fires[UID] == 0 then
			Client.Fires[UID] = {}
		end
	end
end
addEvent( "unsynchronization:client", true )
addEventHandler( "unsynchronization:client", getRootElement(  ), UNSyncClient )


function PositionGround(UID, x, y, z, dimension, interior, value, random, single)
local z = getGroundPosition( x, y, z)
triggerServerEvent( "createFire", localPlayer, UID, x, y, z+1, dimension, interior, value, random, single )
end
addEvent( "sync:PositionGround", true )
addEventHandler( "sync:PositionGround", getRootElement(  ), PositionGround )