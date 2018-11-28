Fire = {}
Player = false
Col = false
Info = false

function SyncClientEffect(UID, x, y, z, dimension, interior, colission, amount, Effect_Name)
	if not( Fire[UID] ) or Fire[UID] == nil or #Fire[UID] == 0 then
		Fire[UID] = {}
	end
	if #Fire[UID] < amount then
		local z = getGroundPosition( x, y, z )
		effect = createEffect(Effect_Name, x, y, z+0.5)
		if isElement( effect ) then
			local data = getElementData(colission,"data:fire")
			data[8] = effect
			table.insert(Fire[UID],{effect,#Fire[UID]+1})
		end
	end
end
addEvent( "synchronization:client:Effect", true )
addEventHandler( "synchronization:client:Effect", getRootElement(  ), SyncClientEffect )

function unSyncClientEffect(Element, all)
	if isElement(Element) then
		local data = getElementData(Element,"data:fire")
		if data[3] and data[4] then
			local UID = data[3]
			for i,v in ipairs(Fire[UID]) do
				if v[2] == data[4] then
					destroyElement( v[1] )
					if not(all) then
						table.remove(Fire[UID],data[4])
					end
				end
			end

			if #Fire[UID] == 0 then
				Fire[UID] = {}
			end
		end
	end
end
addEvent( "unsynchronization:client:Effect", true )
addEventHandler( "unsynchronization:client:Effect", getRootElement(  ), unSyncClientEffect )


-- function PositionGround(UID, x, y, z, dimension, interior, value, random, single)
-- local z = getGroundPosition( x, y, z)
-- triggerServerEvent( "addFire", localPlayer, UID, x, y, z+1, dimension, interior, value, random, single )
-- end
-- addEvent( "sync:PositionGround", true )
-- addEventHandler( "sync:PositionGround", getRootElement(  ), PositionGround )

function ClientisElementWithinColShaper(Element,shape)
local data = getElementData(shape,"data:fire")
	if isElementWithinColShape(Element,shape) and getElementDimension( Element ) == data[6] and getElementInterior( Element ) == data[7] then
		return true
	else
		return false
	end
end

function takeOxygenLevel()
	if getPedOxygenLevel( Player ) > 0 then
		setPedOxygenLevel( Player, getPedOxygenLevel( Player )-5 )
	else
		if Info == false then
			exports.titan_noti:showBox("Twoja postać zaczyna się dusić z powodu braku tlenu!" )
			Info = true
		end
		setElementHealth( Player, getElementHealth( Player ) - 0.05 )
	end
end

skin = {
[277] = true,
[278] = true,
[279] = true,	
}



function cancelFire()
	if isPedOnFire ( localPlayer ) and skin[getElementModel( localPlayer )] then
		setPedOnFire( localPlayer, false )
		setElementHealth( localPlayer, getElementHealth( localPlayer ) + 0.5 )
	end
end
addEventHandler( "onClientRender", getRootElement(  ), cancelFire )


function getOxygenLevel(Element,shape)
	if ClientisElementWithinColShaper(Element,shape) then
		Player = Element
		Col = shape
		Info = false
		addEventHandler( "onClientRender", getRootElement(  ), takeOxygenLevel )
	end
end
addEvent( "synchronization:client:oxygen", true )
addEventHandler( "synchronization:client:oxygen", getRootElement(  ), getOxygenLevel )


function revOxygenLevel(Element)
setPedOxygenLevel( Element, 100 )
removeEventHandler( "onClientRender", getRootElement(  ), takeOxygenLevel )
end
addEvent( "synchronization:client:oxygen:off", true )
addEventHandler( "synchronization:client:oxygen:off", getRootElement(  ), revOxygenLevel )

function PlayerSyncFireHose()
	for i,v in ipairs( getElementsByType("vehicle") ) do
		if getElementData(v,"firehose") then

			for _,tab in ipairs( getElementData(v,"firehose") ) do
				if isElement(tab.attach) then
					local pos1 = Vector3(tab.x, tab.y, tab.z)
					local pos2 = Vector3(getElementPosition(tab.attach))
					dxDrawLine3D( pos1, pos2, tocolor(0,0,0,255), 5 )
					if getElementData(v,"water") and getElementType(tab.attach) == "object" then
						local w = getElementData(v,"water")
						if w[2] > w[1] then
							w[1] = w[1]+1
							setElementData(v,"water",w)
						end
					else
						setElementData(v,"water",{0,10000})
					end


				end
			end
		end
	end
end
addEventHandler( "onClientRender", getRootElement(  ), PlayerSyncFireHose )