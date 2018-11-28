addEvent("addComponent", true)
addEventHandler("addComponent", getRootElement(), function (veh, component)
	setVehicleComponentVisible(veh, component, not getVehicleComponentVisible(veh, component))
end)

-- local veh = getPedOccupiedVehicle(localPlayer)
-- local components = getVehicleComponents(veh)
-- for k in pairs(components) do
-- 	outputChatBox(k)
-- end
