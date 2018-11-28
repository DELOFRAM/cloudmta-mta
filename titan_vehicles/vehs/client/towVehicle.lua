------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-07 13:50:11

function towVehicle()
	if localPlayer:getData("loggedIn") == 1 then
		if localPlayer:isInVehicle() and localPlayer:getOccupiedVehicleSeat() == 0 then
			local veh = localPlayer:getOccupiedVehicle()
			--if veh:getModel() == 525 then
				if isElement(veh:getData("towedBy")) then
					exports.titan_noti:showBox("Pojazd, którym jeździsz jest już holowany przez inny pojazd.")
					return
				end
				if isElement(veh:getData("towedVeh")) then
					triggerServerEvent("setTowVehicleState", localPlayer, veh, false, false)
					return
				else
					veh:setData("towedVeh", false)
					local vPos = veh:getPosition()
					local x0, y0, z0, x1, y1, z1 = getElementBoundingBox (veh)
					vPos.x, vPos.y = getXY(veh, y0)
					local x, y = getXY(veh, -5)
					local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(vPos.x, vPos.y, vPos.z, x, y, vPos.z, false, true, false, false)

					if hit then
						if getElementType(hitElement) == "vehicle" then
							triggerServerEvent("setTowVehicleState", localPlayer, veh, hitElement, true)
							return
						end
					end
				end
				return
			--end
		end
	end
end
--bindKey("mouse1", "down", towVehicle)

function getXY(elem, dist)
	local x, y, z = getElementPosition(elem)
	local rx, ry, rz = getElementRotation(elem)

	local nX = x + math.sin(math.rad(-rz)) * dist
	local nY = y + math.cos(math.rad(-rz)) * dist
	return nX, nY
end