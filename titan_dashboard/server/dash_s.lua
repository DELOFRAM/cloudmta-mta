addEvent("getDane", true)
addEventHandler("getDane", getRootElement(), function (skin)
	triggerClientEvent(source, "setDane", source, exports.titan_orgs:getGroupsToDashboard(source), exports.titan_vehicles:getVehiclesToDashboard(source), exports.titan_doors:getPlayerInteriors(source))
end)