----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local ptFunc = {}

function ptFunc.offerMandat(player, target)
	triggerClientEvent(player, "ptF.create", player, target)
end
offerMandat = ptFunc.offerMandat

function ptFunc.addTicket(player, price, points, text)
	if isElement(player) then
		exports.titan_offers:createNewOffer(source, player, "ticket", {name = "Mandat", price = price, points = points, text = text})
		return exports.titan_noti:showBox(source, "Oferta została wysłana.")
	else
		return exports.titan_noti:showBox(player, "Nie znaleizono gracza o podanym ID.")
	end
end
addEvent("ptFunc.addTicket", true)
addEventHandler("ptFunc.addTicket", root, ptFunc.addTicket)