function checkDowod(player)
	if not exports.titan_items:doesPlayerHaveItemType(player, 11) then
		triggerClientEvent(player, "setBlockOrNot", player, false)
	else
		triggerClientEvent(player, "setBlockOrNot", player, true)
	end
end
addEvent("checkDowod", true)
addEventHandler("checkDowod", getRootElement(), checkDowod)