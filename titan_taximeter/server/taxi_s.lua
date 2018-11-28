----------------------------------------------------
-- CloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Value
-- Stworzono:   2016-07-24 20:47:22
----------------------------------------------------

function startTaxi(plr, target)
	setElementData(target, "taxi:is", true)
	setElementData(target, "taxi:dist", 0)
	setElementData(target, "taxi:target", plr)

	setElementData(plr, "taxi:is", true)
	setElementData(plr, "taxi:dist", 0)
	setElementData(plr, "taxi:target", target)

	triggerClientEvent(plr, "createTaxometr", plr)
	triggerClientEvent(target, "createTaxometr", target)
end

function taxiEnd(player, target, money)
	local forDriver = math.floor(money*0.25) -- Kierowca dostaje 25% pieniędzy za przejazd
	local forCorp = math.floor(money-forDriver) -- Firma dostaje 75% pieniędzy za przejazd
	--outputChatBox("Dla kierowcy: "..forDriver.." Dla firmy: "..forCorp, target)
	exports.titan_noti:showBox(player, "Zakończyłeś kurs. Twoja firma zarobiła $"..forCorp..".") -- Wiadomość dla kierowcy
	exports.titan_noti:showBox(target, "Zapłaciłeś $"..money.." za przejazd.") -- Wiadomość dla pasażera
	local pDuty = exports.titan_groups:getPlayerDuty(player)
	if not pDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end

	if exports.titan_cash:takePlayercash(target, money) then
		exports.titan_cash:addPlayerCash(player, forDriver)
		exports.titan_orgs:giveGroupMoney(pDuty, forCorp)
	end

--	outputChatBox("Otrzymałeś $"..forDriver.." za skończony kurs", player) -- Wiadomość dla kierowcy
	return
end
addEvent("taxiEnd", true)
addEventHandler("taxiEnd", getRootElement(), taxiEnd)