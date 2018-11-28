------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-07 14:16:46

function setTowVehicleState(veh, towedVeh, state)
	if exports.titan_login:isLogged(source) then
		if getPedOccupiedVehicle(source) == veh then
			if state then
				veh:setData("towedVeh", towedVeh)
				towedVeh:setData("towedBy", veh)
				towedVeh:attach(veh, 0, -6, 0)
			else
				local tVeh = veh:getData("towedVeh")
				if isElement(tVeh) then
					tVeh:setData("towedBy", false)
					veh:detach(tVeh)
					
				end
				veh:setData("towedVeh", false)
			end
		end
	end
end
addEvent("setTowVehicleState", true)
addEventHandler("setTowVehicleState", root, setTowVehicleState)