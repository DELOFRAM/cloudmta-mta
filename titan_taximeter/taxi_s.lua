addCommandHandler("taksi", function (plr, cmd, trg)
	local target = exports.titan_login:getPlayerByID(trg)
	if not isPedInVehicle(plr) or not isPedInVehicle(target) then return end
	outputChatBox("TAXI: Naliczanie dla "..getPlayerName(target), plr)
	outputChatBox("TAXI: Uruchomiono dla ciebie taksometr", target)
	setElementData(target, "taxi:is", true)
	setElementData(target, "taxi:dist", 0)
	setElementData(target, "taxi:target", plr)
	
	setElementData(plr, "taxi:is", true)
	setElementData(plr, "taxi:dist", 0)
	setElementData(plr, "taxi:target", target)
	
	triggerClientEvent(plr, "createTaxometr", plr)
	triggerClientEvent(target, "createTaxometr", target)
end)

addCommandHandler("taksi.reset", function (plr, cmd)
	setElementData(plr, "taxi:is", false)
	setElementData(plr, "taxi:dist", 0)
end)