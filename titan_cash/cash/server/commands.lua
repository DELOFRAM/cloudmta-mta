----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:40
-- Ostatnio zmodyfikowano: 2016-01-09 15:44:43
----------------------------------------------------

function cmdConvert(player, command, ...)
local arg = {...}
	local legend = "pieniadze"
	arg1 = string.lower(tostring(arg[1]))
	if arg1 == "pieniadze" then	
		local arg2 = arg[2]
		if not tonumber(arg2) then
			return exports.titan_noti:showBox(player,"/"..command.." "..arg1.." [wartośc]")
		end
		arg2 = tonumber(arg2)
		local itemSlotID = exports.titan_items:getPlayerFreeSlotID(player)
		if(not itemSlotID or itemSlotID > 35) then
			exports.titan_noti:showBox(player, "Nie masz miejsca w ekwipunku.")
			return
		end
		local cash = getPlayerCash(player)
		if cash < arg2 then
			exports.titan_noti:showBox(player, "Nie posiadasz tyle pieniędzy!")
			return
		end

	if(arg2 <= 0) then
		exports.titan_noti:showBox(player, "Wartość musi być większa od zera.")
		return
	end
		
		if arg2 > 1 then
			name = "Dolary"
		else
			name = "Dolar"
		end
		if exports.titan_items:itemCreate(1, getElementData( player, "charID"), name, 25, itemSlotID, 5, arg2, 1, 0) then
			exports.titan_noti:showBox(player, "Pomyślnie przekowertowane twoje pieniądze jako przedmiot.")
			takePlayerCash( player, arg2 )
			return true
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd podczas kowertowania pieniędzy na przedmiot.")
		end
	else
		return exports.titan_noti:showBox(player, "TIP: /konwertuj ["..legend.."]")
	end
end
addCommandHandler("konwertuj", cmdConvert, false, false)

function cmdPay(player, command, playerID, price)
	if(not exports.titan_login:isLogged(player)) then return end

	if(not tonumber(playerID) or not tonumber(price)) then
		exports.titan_noti:showBox(player, string.format("TIP: /%s [ID gracza] [kwota]", string.lower(tostring(command))))
		return
	end
	playerID = tonumber(playerID)
	price = math.floor(tonumber(price))
	local target = exports.titan_login:getPlayerByID(playerID)
	if(not isElement(target)) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o danym ID, lub nie jest on zalogowany.")
		return
	end
	if(player == target) then
		exports.titan_noti:showBox(player, "Nie możesz dać pieniędzy samemu sobie.")
		return
	end
	local pX, pY, pZ = getElementPosition(player)
	local tX, tY, tZ = getElementPosition(target)
	if(getDistanceBetweenPoints3D(pX, pY, pZ, tX, tY, tZ) > 5.0) then
		exports.titan_noti:showBox(player, "Gracz jest za daleko.")
		return
	end
	if(price <= 0) then
		exports.titan_noti:showBox(player, "Wartość musi być większa od zera.")
		return
	end
	if(getPlayerCash(player) < price) then
		exports.titan_noti:showBox(player, "Nie posiadasz tylu pieniędzy.")
		return
	end
	if(takePlayerCash(player, price)) then
		exports.titan_logs:playerLog(player, "cash", string.format("Oddano pieniądze dla: (Komenda) %s (UID: %d, CID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(target), target:getData("memberID"), target:getData("charID"), price))
		addPlayerCash(target, price)
		exports.titan_logs:playerLog(target, "cash", string.format("Otrzymano pieniądze od: (Komenda) %s (UID: %d, CID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(player), player:getData("memberID"), player:getData("charID"), price))
		exports.titan_chats:sendPlayerLocalMeRadiusCash(player, target, 10.0)
		exports.titan_noti:showBox(target, string.format("* Otrzymałeś $%d od %s.", price, exports.titan_chats:getPlayerICName(player)))
		exports.titan_noti:showBox(player, string.format("* Dałeś %s $%d.", exports.titan_chats:getPlayerICName(target), price))
	end
	return true
end
addCommandHandler("pay", cmdPay, false, false)
addCommandHandler("plac", cmdPay, false, false)

function cmdBank(player, command, arg1)
	if not exports.titan_login:isLogged(player) then return end
	if not isPlayerInBank(player) then return end
	arg1 = string.lower(tostring(arg1))
	if arg1 == "zarzadzaj" then
		local accounts = exports.titan_db:query("SELECT ID, accountID, balance, name FROM _accounts WHERE ownerType = '1' AND owner = ?", player:getData("charID"))
		if #accounts == 0 then return exports.titan_noti:showBox(player, "Nie posiadasz żadnego konta bankowego.") end
		triggerClientEvent(player, "chooseGui.create", player, accounts)
	elseif arg1 == "stworz" then
		local accounts = exports.titan_db:query("SELECT ID, accountID, name FROM _accounts WHERE ownerType = '1' AND owner = ?", player:getData("charID"))
		if #accounts >= 3 then return exports.titan_noti:showBox(player, "Możesz posiadać maksymalnie trzy konta bankowe.") end

		local accountID = exports.titan_misc:generateAccountID()
		exports.titan_db:query_free("INSERT INTO _accounts SET accountID = ?, ownerType = '1', owner = ?, name = 'Konto bankowe', balance = '0'", accountID, player:getData("charID"))
		exports.titan_noti:showBox(player, "Konto zostało utworzone pomyślnie. Domyślny PIN to: 0000.\nNumer konta: "..accountID)
		setElementData(player, "accountID", accountID)
		setElementData(player, "accountMoney", 0)
	elseif arg1 == "karta" then
		local accounts = exports.titan_db:query("SELECT ID, accountID, name FROM _accounts WHERE ownerType = '1' AND owner = ?", player:getData("charID"))
		if #accounts == 0 then return exports.titan_noti:showBox(player, "Nie posiadasz żadnych kont bankowych.") end
		triggerClientEvent(player, "chooseGui.createCard", player, accounts)
	else
		return exports.titan_noti:showBox(player, "TIP: /bank [stworz, zarzadzaj, karta]")
	end
end
addCommandHandler("bank", cmdBank, false, false)

function cmdBankomat(player)
	if not exports.titan_login:isLogged(player) then return end
	if not getNearATM(player) then return exports.titan_noti:showBox(player, "W pobliżu nie ma żadnego bankomatu.") end
	-- @TODO exports.titan_items:getPlayerATMCards()
	local playerCards = exports.titan_items:getPlayerATMCards(player)
	if not playerCards or #playerCards == 0 then return exports.titan_noti:showBox(player, "Nie posiadasz w ekwipunku żadnej karty bankomatowej.") end
	triggerClientEvent(player, "atmFunc.chooseCreate", player, playerCards)
end
addCommandHandler("bankomat", cmdBankomat, false, false)