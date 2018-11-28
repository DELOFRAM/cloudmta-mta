----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:45
-- Ostatnio zmodyfikowano: 2016-01-19 22:01:41
----------------------------------------------------

local playerEvents = {}

function addPlayerCash(player, cash)
	local playerCash = getPlayerCash(player)
	if(not playerCash) then return false end
	if(not tonumber(cash)) then return false end
	cash = tonumber(cash)
	if cash < 0 then return false end
	setElementData(player, "money", playerCash + cash)
	exports.titan_db:query_free("UPDATE _characters SET money = ? WHERE ID = ?", getElementData(player, "money"), getElementData(player, "charID"))
	exports.titan_hud:cashClick(player)
	return true
end

function takePlayerCash(player, cash)
	local playerCash = getPlayerCash(player)
	if(not playerCash) then return false end
	if(not tonumber(cash)) then return false end
	cash = tonumber(cash)
	if cash < 0 then return false end
	setElementData(player, "money", playerCash - cash)
	exports.titan_db:query_free("UPDATE _characters SET money = ? WHERE ID = ?", getElementData(player, "money"), getElementData(player, "charID"))
	exports.titan_hud:cashClick(player)
	return true
end

function getPlayerCash(player)
	return tonumber(getElementData(player, "money")) or 0
end

function isPlayerInBank(player)
	if player:getDimension() == 0 then
		local playerZone = exports.titan_spheres:getPlayerZone(player)
		if not playerZone then return false end
		if exports.titan_spheres:doesOwnerHasPerm(playerZone, -1, 0) then return true end
		return false
	end
	local doorInfo = exports.titan_doors:getDoorInfoFromDimension(player:getDimension())
	if not doorInfo then return false end
	if doorInfo.ownerType == -1 then return true end
	--if doorInfo.name ~= "Los Santos Bank" then exports.titan_noti:showBox(player, "Ten budynek nie jest bankiem.") return false end
	return false
end

function getAccountInfo(ID)
	local query = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", ID)
	if #query == 0 then return false end
	return query[1]
end


function playerEvents.playerChooseAccount(ID2, code, fid)
	if not isPlayerInBank(source) then return end
	if fid > 0 then
		local q = exports.titan_db:query("SELECT ID, name, cash FROM _groups WHERE ID = ?", ID2.ID)
		setElementData(source, "accountID", q[1].ID or "ERR")
		setElementData(source, "accountMoney", q[1].cash or "ERR")
		triggerClientEvent(source, "bankGui.create2", source, q[1].name or "ERR", q[1].ID or "ERR", q[1].cash or "ERR")
		return
	end
	local query = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", ID2)
	if #query == 0 then return exports.titan_noti:showBox(source, "Nie znaleziono takiego konta bankowego.") end
	query = query[1]
	if query.code ~= code then return exports.titan_noti:showBox(source, "Podany kod PIN nie jest poprawny.") end
	setElementData(source, "accountID", query.accountID)
	setElementData(source, "accountMoney", query.balance)
	triggerClientEvent(source, "bankGui.create", source, query)
	return
end
addEvent("playerEvents.playerChooseAccount", true)
addEventHandler("playerEvents.playerChooseAccount", root, playerEvents.playerChooseAccount)

function playerEvents.changeAccountName(ID, name)
	if not isPlayerInBank(source) then
		exports.titan_noti:showBox(source, "Nie jesteś w banku.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	local accountInfo = getAccountInfo(ID)
	if not accountInfo then
		exports.titan_noti:showBox(source, "Nie znaleziono takiego konta bankowego.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	if accountInfo.ownerType ~= 1 or accountInfo.owner ~= source:getData("charID") then
		exports.titan_noti:showBox(source, "To konto bankowe nie należy do Ciebie.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	exports.titan_db:query_free("UPDATE _accounts SET name = ? WHERE ID = ?", name, ID)
	exports.titan_noti:showBox(source, "Nazwa konta została zmieniona pomyślnie.")

	triggerClientEvent(source, "bankGui.setInfo", source, "accountName", name)
	local query = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", ID)
	setElementData(source, "accountID", query[1].accountID)
	setElementData(source, "accountMoney", query[1].balance)
	return triggerClientEvent(source, "bankGui.toggleOn", source, "accountNameButton")
end
addEvent("playerEvents.changeAccountName", true)
addEventHandler("playerEvents.changeAccountName", root, playerEvents.changeAccountName)

function playerEvents.cashWplac(ID, cash)
	if not isPlayerInBank(source) then
		exports.titan_noti:showBox(source, "Nie jesteś w banku.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	local accountInfo = getAccountInfo(ID)
	if not accountInfo then
		exports.titan_noti:showBox(source, "Nie znaleziono takiego konta bankowego.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	if accountInfo.ownerType ~= 1 or accountInfo.owner ~= source:getData("charID") then
		exports.titan_noti:showBox(source, "To konto bankowe nie należy do Ciebie.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	local playerCash = getPlayerCash(source)
	if playerCash < cash then
		exports.titan_noti:showBox(source, "Nie posiadasz tyle gotówki w portfelu.")
		return triggerClientEvent(source, "bankGui.toggleOn", source, "cashWplacButton")
	end
	if takePlayerCash(source, cash) then
		exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", cash, ID)
		exports.titan_db:query_free("INSERT INTO _accounts_logs SET data = UNIX_TIMESTAMP(), accountID = ?, title = ?, cash = ?, actualBalance = ?", ID, "Wpłata pieniędzy w banku", cash, accountInfo.balance + cash)
		exports.titan_noti:showBox(source, "Na konto wpłacono $"..cash..".")
		triggerClientEvent(source, "bankGui.setInfo", source, "accountBalance", "Środki: $"..accountInfo.balance + cash)
		triggerClientEvent(source, "bankGui.setInfo", source, "cashWplac", "")
		setElementData(source, "accountID", accountInfo.accountID)
		setElementData(source, "accountMoney", accountInfo.balance)
		return triggerClientEvent(source, "bankGui.toggleOn", source, "cashWplacButton")
	end
end
addEvent("playerEvents.cashWplac", true)
addEventHandler("playerEvents.cashWplac", root, playerEvents.cashWplac)

function playerEvents.cashWyplac(ID, cash)
	if not isPlayerInBank(source) then
		exports.titan_noti:showBox(source, "Nie jesteś w banku.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	local accountInfo = getAccountInfo(ID)
	if not accountInfo then
		exports.titan_noti:showBox(source, "Nie znaleziono takiego konta bankowego.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	if accountInfo.ownerType ~= 1 or accountInfo.owner ~= source:getData("charID") then
		exports.titan_noti:showBox(source, "To konto bankowe nie należy do Ciebie.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	if accountInfo.balance - cash < 0 then
		exports.titan_noti:showBox(source, "Nie posiadasz tyle gotówki na tym koncie bankowym.")
		return triggerClientEvent(source, "bankGui.toggleOn", source, "cashWyplacButton")
	end
	if addPlayerCash(source, cash) then
		exports.titan_logs:playerLog(source, "cash", string.format("Otrzymano pieniądze od: (Konto bankowe) %s (UID: %d), Kwota: $%d.", tostring(accountInfo.accountID), accountInfo.ID, cash))
		exports.titan_db:query_free("UPDATE _accounts SET balance = balance - ? WHERE ID = ?", cash, ID)
		exports.titan_db:query_free("INSERT INTO _accounts_logs SET data = UNIX_TIMESTAMP(), accountID = ?, title = ?, cash = ?, actualBalance = ?", ID, "Wypłata pieniędzy z banku", -cash, accountInfo.balance - cash)
		exports.titan_noti:showBox(source, "Z konta wypłacono $"..cash..".")
		triggerClientEvent(source, "bankGui.setInfo", source, "accountBalance", "Środki: $"..accountInfo.balance - cash)
		triggerClientEvent(source, "bankGui.setInfo", source, "cashWyplac", "")
		local query = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", ID)
		setElementData(source, "accountID", query[1].accountID)
		setElementData(source, "accountMoney", query[1].balance)
		return triggerClientEvent(source, "bankGui.toggleOn", source, "cashWyplacButton")
	end
end
addEvent("playerEvents.cashWyplac", true)
addEventHandler("playerEvents.cashWyplac", root, playerEvents.cashWyplac)

function playerEvents.transferCash(ID, accountID, title, cash)
	if not isPlayerInBank(source) then
		exports.titan_noti:showBox(source, "Nie jesteś w banku.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	local accountInfo = getAccountInfo(ID)
	if not accountInfo then
		exports.titan_noti:showBox(source, "Nie znaleziono takiego konta bankowego.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	if accountInfo.ownerType ~= 1 or accountInfo.owner ~= source:getData("charID") then
		exports.titan_noti:showBox(source, "To konto bankowe nie należy do Ciebie.")
		return triggerClientEvent(source, "bankGui.destroy", source)
	end
	if accountInfo.accountID == accountID then
		exports.titan_noti:showBox(source, "Przesyłanie gotówki na swoje konto bankowe jest co najmniej głupie.")
		return triggerClientEvent(source, "bankGui.toggleOn", source, "paymentAccept")
	end
	if accountInfo.balance - cash < 0 then
		exports.titan_noti:showBox(source, "Nie posiadasz tyle gotówki na tym koncie bankowym.")
		return triggerClientEvent(source, "bankGui.toggleOn", source, "paymentAccept")
	end
	local accInfo = exports.titan_db:query("SELECT ID, balance FROM _accounts WHERE accountID = ?", accountID)
	if #accInfo == 0 then
		exports.titan_noti:showBox(source, "Konto o podanym numerze nie istnieje.")
		return triggerClientEvent(source, "bankGui.toggleOn", source, "paymentAccept")
	end
	exports.titan_db:query_free("UPDATE _accounts SET balance = balance - ? WHERE ID = ?", cash, ID)
	exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", cash, accInfo[1].ID)
	exports.titan_db:query_free("INSERT INTO _accounts_logs SET data = UNIX_TIMESTAMP(), accountID = ?, title = ?, cash = ?, actualBalance = ?", accInfo[1].ID, string.format("%s (%d) ", title, accountInfo.accountID), cash, accInfo[1].balance + cash)
	exports.titan_db:query_free("INSERT INTO _accounts_logs SET data = UNIX_TIMESTAMP(), accountID = ?, title = ?, cash = ?, actualBalance = ?", ID, string.format("%s (%d) ", title, accountID), -cash, accountInfo.balance - cash)
	exports.titan_noti:showBox(source, string.format("Na rachunek o numerze %d przelano $%d.", accountID, cash))
	triggerClientEvent(source, "bankGui.setInfo", source, "accountBalance", "Środki: $"..accountInfo.balance - cash)
	triggerClientEvent(source, "bankGui.setInfo", source, "paymentWplac", "")
	triggerClientEvent(source, "bankGui.setInfo", source, "paymentTitle", "")
	triggerClientEvent(source, "bankGui.setInfo", source, "paymentAccountID", "")
	setElementData(source, "accountID", accountInfo.accountID)
	setElementData(source, "accountMoney", accountInfo.balance)
	return
end
addEvent("playerEvents.transferCash", true)
addEventHandler("playerEvents.transferCash", root, playerEvents.transferCash)

function getGroupsDetails() -- value
	local group = {}
	local groups = exports.titan_orgs:getGroupsToDashboard(source)
	for k,v in pairs(groups) do
		if exports.titan_orgs:doesPlayerHaveGroupLeader(source, v.groupInfo.ID) then
			local q = exports.titan_db:query("SELECT * FROM _groups WHERE ID=?", v.groupInfo.ID)
			table.insert(group, q[1])
		end
	end
	triggerClientEvent(source, "setGroupsDetails", source, group)
end
addEvent("getGroupsDetails", true)
addEventHandler("getGroupsDetails", getRootElement(), getGroupsDetails)


-- value - konta grupowe
function wplacGroup(id, cash)
	local accountMoney = getElementData(source, "accountMoney")
	local towplata = accountMoney+tonumber(cash)
	local query = exports.titan_db:query("UPDATE _groups SET cash=? WHERE ID=?", towplata, id)
	if query then
		exports.titan_noti:showBox(source, "Pomyślnie wpłacasz $"..cash.." na konto grupy")
		setElementData(source, "money", getElementData(source, "money")-tonumber(cash))
		local query2 = exports.titan_db:query("UPDATE _characters SET money=? WHERE ID=?", getElementData(source, "money"), getElementData(source, "charID"))

		local charID = getElementData(source, "charID")
		local accountID = getElementData(source, "accountID")
		local log1 = exports.titan_db:query("INSERT INTO _groups_cash_bilance SET groupID=?, playerID=?, type=1, bilanceType=1, cash=?, bilance=?, timestamp=?", accountID, charID, tonumber(cash), towplata, getTimestamp())
	else
		exports.titan_noti:showBox(source, "Wystąpił problem podczas wpłacania, zgłoś to administracji na forum")
	end
	triggerClientEvent(source, "bankGui.destroy", source)
end
addEvent("wplacGroup", true)
addEventHandler("wplacGroup", getRootElement(), wplacGroup)

function wyplacGroup(id, cash)
	local accountMoney = getElementData(source, "accountMoney")
	local towplata = accountMoney-tonumber(cash)
	local query = exports.titan_db:query("UPDATE _groups SET cash=? WHERE ID=?", towplata, id)
	if query then
		exports.titan_noti:showBox(source, "Pomyślnie wpłacasz $"..cash.." na konto grupy")
		setElementData(source, "money", getElementData(source, "money")+tonumber(cash))
		local query2 = exports.titan_db:query("UPDATE _characters SET money=? WHERE ID=?", getElementData(source, "money"), getElementData(source, "charID"))

		local charID = getElementData(source, "charID")
		local accountID = getElementData(source, "accountID")
		local log1 = exports.titan_db:query("INSERT INTO _groups_cash_bilance SET groupID=?, playerID=?, type=1, bilanceType=2, cash=?, bilance=?, timestamp=?", accountID, charID, tonumber(cash), towplata, getTimestamp())
	else
		exports.titan_noti:showBox(source, "Wystąpił problem podczas wpłacania, zgłoś to administracji na forum")
	end
	triggerClientEvent(source, "bankGui.destroy", source)
end
addEvent("wyplacGroup", true)
addEventHandler("wyplacGroup", getRootElement(), wyplacGroup)

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
 
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
 
    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
 
    return timestamp
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getNearATM(player)
	local sphere = createColSphere(player:getPosition(), 2.0)
	local objects = getElementsWithinColShape(sphere, "object")
	destroyElement(sphere)
	for k, v in ipairs(objects) do
		if getElementModel(v) == 2942 then return true end
	end
	return false
end

function createPlayerATMCard(player, accountID)
	local query = exports.titan_db:query("SELECT * FROM _accounts WHERE ID = ?", accountID)
	if #query == 0 then return exports.titan_noti:showBox(player, "Nie znaleziono takiego konta bankowego.") end
	local pin = math.random(1111, 9999)
	local itemSlotID = exports.titan_items:getPlayerFreeSlotID(player)
	if(not itemSlotID or itemSlotID > 35) then
		exports.titan_noti:showBox(player, "Nie masz miejsca w ekwipunku.")
		return
	end
	exports.titan_items:itemCreate(1, player:getData("charID"), query[1].name, 11, itemSlotID, 5, query[1].ID, pin, query[1].accountID)
	return exports.titan_noti:showBox(player, "Karta bankomatowa została stworzona. Jej PIN to: "..pin..". Nie zgub go!")
end
addEvent("createPlayerATMCard", true)
addEventHandler("createPlayerATMCard", root, createPlayerATMCard)

function getPlayerAccounts(player)
	local accounts = exports.titan_db:query("SELECT * FROM _accounts WHERE ownerType = '1' AND owner = ?", player:getData("charID"))
	if #accounts == 0 then return {} end
	return accounts
end