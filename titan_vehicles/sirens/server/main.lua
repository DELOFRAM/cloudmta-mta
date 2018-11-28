------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-08-11 15:32:03

function turnSirenOn(veh, loop, subType)
	triggerClientEvent("turnSirenOn", source, veh, loop, subType)
end
addEvent("turnSirenOn", true)
addEventHandler("turnSirenOn", root, turnSirenOn)

function changeLights(veh)
	if isVeh(veh) then
		local vehInfo = getVehInfo(veh:getData("vehID"))
		if vehInfo then
			if vehInfo.flashType > 0 then
				local isVehHaveFlash = getElementData(veh, "flashType")
				if tonumber(isVehHaveFlash) then
					turnVehFlash(veh)
				else
					turnVehFlash(veh, true, vehInfo.flashType)
				end
			end
		end
	end
end
addEvent("changeLights", true)
addEventHandler("changeLights", root, changeLights)