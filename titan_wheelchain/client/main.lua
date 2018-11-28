----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function render()
	local veh = getPedOccupiedVehicle(localPlayer)
	if isElement(veh) and getVehicleOccupant(veh) == localPlayer then
	if getElementModel(veh) == 581 or getElementModel(veh) == 509 or getElementModel(veh) == 481 or getElementModel(veh) == 462 or getElementModel(veh) == 521 or getElementModel(veh) == 463 or getElementModel(veh) == 510 or getElementModel(veh) == 522 or getElementModel(veh) == 461 or getElementModel(veh) == 448 or getElementModel(veh) == 468 or getElementModel(veh) == 586 then return end
		local x1 = getComponentWorldPosition(veh, "wheel_lb_dummy")
		local x2 = getComponentWorldPosition(veh, "wheel_lf_dummy")
		local x1 = getComponentWorldPosition(veh, "wheel_rb_dummy")
		local x2 = getComponentWorldPosition(veh, "wheel_rf_dummy")

		local objects = getElementsByType("kolczatka")
		local vehPos = veh:getPosition()
		for k, v in ipairs(objects) do
			local object = getElementData(v, "object")
			if isElement(object) then
				local pos = object:getPosition()
				local rot = object:getRotation()

				if getDistanceBetweenPoints3D(vehPos, pos) < 50 then
					--dxDrawLine3D(vehPos, pos, tocolor(255, 0, 0, 255), 2.0, true)

					local wheel1 = getComponentWorldPosition(veh, "wheel_lb_dummy")
					local wheel2 = getComponentWorldPosition(veh, "wheel_lf_dummy")
					local wheel3 = getComponentWorldPosition(veh, "wheel_rb_dummy")
					local wheel4 = getComponentWorldPosition(veh, "wheel_rf_dummy")

					local wheel1Z = getGroundPosition(wheel1)
					local wheel2Z = getGroundPosition(wheel2)
					local wheel3Z = getGroundPosition(wheel3)
					local wheel4Z = getGroundPosition(wheel4)

					local x0, y0, z0, x1, y1, z1 = getElementBoundingBox(object)

					local relativePos = Vector3(x0, y0, 0)
					local matrix = Matrix(Vector3(0, 0, 0), Vector3(0, 0, rot.z))
					local newPos = matrix:transformPosition(relativePos)
					local l1 = Vector3(newPos.x + pos.x, newPos.y + pos.y, pos.z)

					local relativePos = Vector3(x0, y1, 0)
					local matrix = Matrix(Vector3(0, 0, 0), Vector3(0, 0, rot.z))
					local newPos = matrix:transformPosition(relativePos)
					local l2 = Vector3(newPos.x + pos.x, newPos.y + pos.y, pos.z)

					local relativePos = Vector3(x1, y0, 0)
					local matrix = Matrix(Vector3(0, 0, 0), Vector3(0, 0, rot.z))
					local newPos = matrix:transformPosition(relativePos)
					local r1 = Vector3(newPos.x + pos.x, newPos.y + pos.y, pos.z)

					local relativePos = Vector3(x1, y1, 0)
					local matrix = Matrix(Vector3(0, 0, 0), Vector3(0, 0, rot.z))
					local newPos = matrix:transformPosition(relativePos)
					local r2 = Vector3(newPos.x + pos.x, newPos.y + pos.y, pos.z)

					--local hit1 = isVetorOnVector(Vector3(pos.x + x0, pos.y + y0, pos.z + z0), Vector3(pos.x + x1, pos.y + y1, pos.z + z1), Vector3(wheel1))
					--local hit2 = isVetorOnVector(Vector3(pos.x + x0, pos.y + y0, pos.z), Vector3(pos.x + x1, pos.y + y1, pos.z), Vector3(wheel2))
					--local hit3 = isVetorOnVector(Vector3(pos.x + x0, pos.y + y0, pos.z), Vector3(pos.x + x1, pos.y + y1, pos.z), Vector3(wheel3))
					--local hit4 = isVetorOnVector(Vector3(pos.x + x0, pos.y + y0, pos.z), Vector3(pos.x + x1, pos.y + y1, pos.z), Vector3(wheel4))

					local hit1 = isOnKolczatka(l1, l2, r1, r2, Vector3(wheel1))
					local hit2 = isOnKolczatka(l1, l2, r1, r2, Vector3(wheel2))
					local hit3 = isOnKolczatka(l1, l2, r1, r2, Vector3(wheel3))
					local hit4 = isOnKolczatka(l1, l2, r1, r2, Vector3(wheel4))

					local t1, t2, t3, t4 = getVehicleWheelStates(veh)

					if hit2 and t1 ~= 1 then
						triggerServerEvent("synchronizeTires", localPlayer, veh, 1, -1, -1, -1)
					end
					if hit1 and t2 ~= 1 then
						triggerServerEvent("synchronizeTires", localPlayer, veh, -1, 1, -1, -1)
					end
					if hit3 and t4 ~= 1 then
						triggerServerEvent("synchronizeTires", localPlayer, veh, -1, -1, -1, 1)
					end
					if hit4 and t3 ~= 1 then
						triggerServerEvent("synchronizeTires", localPlayer, veh, -1, -1, 1, -1)
					end

					--outputChatBox(string.format("1: %s 2: %s 3: %s 4: %s", tostring(hit1), tostring(hit2), tostring(hit3), tostring(hit4)))

					--[[
					local screenX, screenY = getScreenFromWorldPosition(pos, 0, false)
					if screenX and screenY and x0 and x1 and y0 and y1 then 
						dxDrawText(string.format("x0: %0.2f\ny0: %0.2f\nx1: %0.2f\ny1: %0.2f\nRot: %0.2f", x0, y0, x1, y1, rot.z), screenX, screenY)
					end

					dxDrawLine3D(l1, l2, tocolor(0, 0, 255, 255), 2.0, true)
					dxDrawLine3D(l1, r1, tocolor(0, 0, 255, 255), 2.0, true)
					dxDrawLine3D(r1, r2, tocolor(0, 0, 255, 255), 2.0, true)
					dxDrawLine3D(l2, r2, tocolor(0, 0, 255, 255), 2.0, true)

					dxDrawLine3D(wheel1, wheel1.x, wheel1.y, wheel1Z, hit1 and tocolor(255, 0, 0, 255) or tocolor(255, 255, 255, 255), 2.0, true)
					dxDrawLine3D(wheel2, wheel2.x, wheel2.y, wheel2Z, hit2 and tocolor(255, 0, 0, 255) or tocolor(255, 255, 255, 255), 2.0, true)
					dxDrawLine3D(wheel3, wheel3.x, wheel3.y, wheel3Z, hit3 and tocolor(255, 0, 0, 255) or tocolor(255, 255, 255, 255), 2.0, true)
					dxDrawLine3D(wheel4, wheel4.x, wheel4.y, wheel4Z, hit4 and tocolor(255, 0, 0, 255) or tocolor(255, 255, 255, 255), 2.0, true)
					]]
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, render)

function triangleArea(A, B, C)
	return (C.x * B.y - B.x * C.y) - (C.x * A.y - A.x * C.y) + (B.x * A.y - A.x * B.y)
end

function isOnKolczatka(A, D, B, C, P)
	if triangleArea(A, B, P) > 0 or triangleArea(B, C, P) > 0 or triangleArea(C, D, P) > 0 or triangleArea(D, A, P) > 0 or P.z > A.z + 1 then return false end
	return true
end

function getComponentWorldPosition(veh, component)
	local m = getElementMatrix(veh)
	local x, y, z = getVehicleComponentPosition(veh, component)

	local wX = x * m[1][1] + y * m[2][1] + z * m[3][1] + m[4][1]
	local wY = x * m[1][2] + y * m[2][2] + z * m[3][2] + m[4][2]
	local wZ = x * m[1][3] + y * m[2][3] + z * m[3][3] + m[4][3]
	return Vector3(wX, wY, wZ)
end

function getNearestWheelChain()
	local distance = 10.0
	local element = nil
	local pos = localPlayer:getPosition()
	for k, v in ipairs(getElementsByType("kolczatka")) do
		if v:getData("owner") == localPlayer then
			local tmpDist = getDistanceBetweenPoints3D(pos, v:getData("object"):getPosition())
			if tmpDist < distance then
				distance = tmpDist
				element = v
			end
		end
	end
	if isElement(element) then
		return element
	else return false end
end

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad(-rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z
end

function onKolczatka(com, arg1)
	if isPedInVehicle(localPlayer) then return exports.titan_noti:showBox("Nie możesz zarządzać kolczatkami siedząc w pojeździe!") end
	local x, y, z = getElementPosition(localPlayer)
	local x, y = getXYInFrontOfPlayer(localPlayer, 5)
	if arg1 == "stworz" then
		local z = getGroundPosition(x, y, z)
		local rx, ry, rz = getElementRotation(localPlayer)
		triggerServerEvent("createKolczatka", localPlayer, localPlayer, x, y, z, rz)
		--exports.titan_noti:showBox("Stworzono kolczatkę")
	elseif arg1 == "usun" then
		local elem = getNearestWheelChain()
		if not elem then return exports.titan_noti:showBox("Nie znaleziono żadnej kolczatki w pobliżu postaci należącej do Ciebie.") end
		triggerServerEvent("destroyKolczatka", localPlayer, elem)
		exports.titan_noti:showBox("Kolczatka została usunięta.")
	else return exports.titan_noti:showBox("TIP: /kolczatka [stworz, usun]") end
end
addCommandHandler("kolczatka", onKolczatka, false, false)