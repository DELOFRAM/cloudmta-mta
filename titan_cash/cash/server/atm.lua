----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local atmFunc = {}

function atmFunc.accountLogin(cardID, pin)
	local itemInfo = exports.titan_items:getItemInfo(cardID)
	if not itemInfo then
		triggerClientEvent(source, "atmFunc.cancelChooseGui", resourceRoot)
		return exports.titan_noti:showBox(source, "Taka karta bankomatowa nie istnieje.")
	end
	if itemInfo.ownerType ~= 1 or itemInfo.owner ~= source:getData("charID") then
		triggerClientEvent(source, "atmFunc.cancelChooseGui", resourceRoot)
		return exports.titan_noti:showBox(source, "Ta karta bankomatowa nie należy do Ciebie.")
	end
	if tonumber(itemInfo.val2) ~= tonumber(pin) then
		triggerClientEvent(source, "atmFunc.enableChooseGui", resourceRoot)
		return exports.titan_noti:showBox(source, "Wprowadziłeś niepoprawny kod PIN.")
	end
	local accountInfo = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", itemInfo.val1)
	if #accountInfo == 0 then
		triggerClientEvent(source, "atmFunc.cancelChooseGui", resourceRoot)
		return exports.titan_noti:showBox(source, "Karta bankomatowa sparowana jest z nie istniejacym już kontem bankowym.")
	end
	triggerClientEvent(source, "atmFunc.cancelChooseGui", resourceRoot)
	triggerClientEvent(source, "atmFunc.createAtmGui", resourceRoot, itemInfo.ID, accountInfo[1].balance)
	return exports.titan_noti:showBox(source, "Zalogowałeś się pomyślnie.")
end
addEvent("atmFunc.accountLogin", true)
addEventHandler("atmFunc.accountLogin", root, atmFunc.accountLogin)

function atmFunc.accountPayout(cardID, money)
	local itemInfo = exports.titan_items:getItemInfo(cardID)
	if not itemInfo then
		triggerClientEvent(source, "atmFunc.atmCancel", resourceRoot)
		return exports.titan_noti:showBox(source, "Taka karta bankomatowa nie istnieje.")
	end
	if itemInfo.ownerType ~= 1 or itemInfo.owner ~= source:getData("charID") then
		triggerClientEvent(source, "atmFunc.atmCancel", resourceRoot)
		return exports.titan_noti:showBox(source, "Ta karta bankomatowa nie należy do Ciebie.")
	end
	local accountInfo = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", itemInfo.val1)
	if #accountInfo == 0 then
		triggerClientEvent(source, "atmFunc.atmCancel", resourceRoot)
		return exports.titan_noti:showBox(source, "Karta bankomatowa sparowana jest z nie istniejacym już kontem bankowym.")
	end
	if accountInfo[1].balance < money then
		triggerClientEvent(source, "atmFunc.atmTurnOn", resourceRoot)
		return exports.titan_noti:showBox(source, "Nie posiadasz tyle pieniędzy na koncie bankowym.")
	end
	if addPlayerCash(source, money) then
		exports.titan_logs:playerLog(source, "cash", string.format("Otrzymano pieniądze od: (Konto bankowe) %s (UID: %d), Kwota: $%d.", tostring(accountInfo.accountID), accountInfo.ID, money))
		exports.titan_db:query_free("UPDATE _accounts SET balance = balance - ? WHERE ID = ?", money, itemInfo.val1)
		exports.titan_db:query_free("INSERT INTO _accounts_logs SET accountID = ?, title = ?, cash = ?, actualBalance = ?", itemInfo.val1, "Wypłata pieniędzy z bankomatu ("..getZoneName(source:getPosition())..")", -money, accountInfo[1].balance - money)
		triggerClientEvent(source, "atmFunc.atmCancel", resourceRoot)
		exports.titan_chats:sendPlayerLocalMeRadius(source, string.format("%s wypłacił pieniadze z bankomatu.", getElementData(source, "sex") == 1 and "wypłacił" or "wypłaciła"), 10.0)
		return exports.titan_noti:showBox(source, "Z konta wypłacono $"..money..".")
	end
end
addEvent("atmFunc.accountPayout", true)
addEventHandler("atmFunc.accountPayout", root, atmFunc.accountPayout)