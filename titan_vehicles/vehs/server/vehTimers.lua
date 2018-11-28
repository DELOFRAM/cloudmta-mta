----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function globalVehTimer()
	for k, v in ipairs(getElementsByType("vehicle")) do
		if getVehicleController(v) then
			local vUID = getElementData(v, "vehID")
			if(not tonumber(vUID)) then return end
			local vehInfo = getVehInfo(vUID)
			--if getElementModel(v) == 509 or getElementModel(v) == 481 or getElementModel(v) == 510 then return end
			--if isElement(getVehicleController(v)) and getElementData(getVehicleController(v), "adminFly") then return end
			if getElementModel(v) ~= 509 and getElementModel(v) ~= 481 and getElementModel(v) ~= 510 then
				if vehInfo then
					if(getVehicleEngineState(v)) then
						if(vehInfo.engineState) then
							local fuel = getElementData(v, "vehFuel") or 0
							if(fuel > 0) then
								local fuelCombustion = 0.005
								vehInfo.fuel = vehInfo.fuel - fuelCombustion
								setElementData(v, "vehFuel", vehInfo.fuel)
							else
								if vehInfo.ownerType == 3 and vehInfo.ownerID == 1 then
									vehInfo.fuel = 50
								else
									vehInfo.fuel = 0
									vehInfo.engineState = false
									setVehicleEngineState(v, false)
									saveVeh(vehInfo.ID)
									if isElement(getVehicleController(v)) then exports.titan_noti:showBox(getVehicleController(v), "W Twoim pojeździe skończyło się paliwo.") end
								end
							end
						else
							setVehicleEngineState(v, false)
						end
					end

					if isElementInWater(v) and getElementHealth(v) > 350 and getVehicleType(v) ~= "Boat" then
						setElementHealth(v, 350)
						vehInfo.broken = true
						vehInfo.engineState = false
						setVehicleEngineState(v, false)
						setElementData(v, "engineState", false)
						saveVeh(vehInfo.ID)
						if isElement(getVehicleController(v)) then exports.titan_noti:showBox(getVehicleController(v), "Twój pojazd został zalany. Odwiedź jak najszybciej mechanika!") end
					end

					-- if #getVehicleOccupants(v) == 0 and not getVehicleOccupant(v) then
					-- 	setVehicleDamageProof(v, true)
					-- else
					-- 	setVehicleDamageProof(v, false)
					-- end
				end
			end
		end
	end
end

local function startTimer()
	setTimer(globalVehTimer, 1000, 0)
end
addEventHandler("onResourceStart", resourceRoot, startTimer)

function getElementSpeed(target)
	local x, y, z = getElementVelocity(target)
	return math.sqrt(x * x + y * y + z * z) * 155
end
