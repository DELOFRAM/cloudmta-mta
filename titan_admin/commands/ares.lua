local skrypty = {}
addCommandHandler("ares", function(player)
	if not doesAdminHavePerm(player, "masteradmin") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	
	for k,v in pairs(getResources()) do
		if getResourceState(v) == "running" then
			table.insert(skrypty, getResourceName(v))
		end
	end
	
	triggerClientEvent(player, "showResourcesGUI", player, skrypty)
	skrypty = {}
end)