----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sx, sy = guiGetScreenSize()

setTimer(function()
	if getPedOccupiedVehicle(localPlayer) then return end
	local a=getPedAnimation(localPlayer)
	if (not a or a~="benchpress") then
		local tx, ty, tz = getWorldFromScreenPosition(sx / 2, sy / 2, 10)
		local lookAt = getElementData(localPlayer,"lookAt")
		
		if not(lookAt) then
			setElementData(localPlayer, "lookAt", { tx,ty,tz })
			lookAt = getElementData(localPlayer,"lookAt")
		end

		if lookAt[1] ~= tx or lookAt[2] ~= ty or  lookAt[3] ~= tz then
			local x,y,z = getPedBonePosition(localPlayer,8)
			setElementData(localPlayer, "lookAt", { tx,ty,tz })
			setPedAimTarget(localPlayer, lookAt[1], lookAt[2], lookAt[3])
			setPedLookAt(localPlayer,lookAt[1], lookAt[2], lookAt[3])
			--dxDrawLine3D(x,y,z, lookAt[1], lookAt[2], lookAt[3], tocolor(0,255,0,255))
	  end
	end


	for i,v in ipairs(getElementsByType("player")) do
		if v ~= localPlayer and getDistanceBetweenPoints3D( Vector3( getElementPosition( localPlayer ) ), Vector3( getElementPosition( v ) ) ) < 10 and getElementDimension(localPlayer) == getElementDimension(v) and getElementInterior(localPlayer) == getElementInterior(v) then
			local lookAt = getElementData(v,"lookAt")
			local x,y,z = getPedBonePosition(v,8)
			setPedAimTarget(v, lookAt[1], lookAt[2], lookAt[3])
			setPedLookAt(v,lookAt[1], lookAt[2], lookAt[3])
			--dxDrawLine3D(x,y,z, lookAt[1], lookAt[2], lookAt[3], tocolor(255,0,0,255))
		end
	end

	-- for i,v in ipairs(getElementsByType("ped")) do
	-- 	if getDistanceBetweenPoints3D( Vector3( getElementPosition( localPlayer ) ), Vector3( getElementPosition( v ) ) ) < 10 and getElementDimension(localPlayer) == getElementDimension(v) and getElementInterior(localPlayer) == getElementInterior(v) then
	-- 		local lookAt = getElementData(localPlayer,"lookAt")
	-- 		local x,y,z = getPedBonePosition(v,8)
	-- 		local px,py,pz = getElementPosition( localPlayer )
	-- 		setPedLookAt(v, 0.0, 0.0, 0.0, 3000, getLocalPlayer())
	
	-- 		dxDrawLine3D(x,y,z, lookAt[1], lookAt[2], lookAt[3], tocolor(255,0,0,255))
	-- 	end
	-- end



end, 100, 0)