----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------
toggleControl("brake_reverse", true)
--[[addEventHandler("onClientRender", root, function()
local veh = getPedOccupiedVehicle(localPlayer)
if not veh then return end
	if getVehicleEngineState(veh) then
		if getVehicleType(veh) == "Automobile" or getVehicleType(veh) == "Monster Truck" or getVehicleType(veh) == "Train" or getVehicleType(veh) == "Plane" or getVehicleType(veh) == "Boat" then toggleControl("brake_reverse", true) end
	else
		if getVehicleType(veh) == "Automobile" or getVehicleType(veh) == "Monster Truck" or getVehicleType(veh) == "Train" or getVehicleType(veh) == "Plane" or getVehicleType(veh) == "Boat" then toggleControl("brake_reverse", false) end
	end
end)]]