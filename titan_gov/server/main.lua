----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local govFunc = {}

function govFunc.addToGovAccount(cash, info)
	local govAccount = 8
	local query = exports.titan_db:query("SELECT ID, balance FROM _accounts WHERE ID = ?", govAccount)
	if #query <= 0 then return end
	exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", cash, query[1].ID)
	exports.titan_db:query_free("INSERT INTO _accounts_logs SET accountID = ?, title = ?, cash = ?, actualBalance = ?", query[1].ID, info, cash, query[1].balance + cash)
end
addGovermentCash = govFunc.addToGovAccount

function govFunc.cmdDowod(player, command, arg1, arg2)
	if not exports.titan_login:isLogged(player) then return end
	arg1 = string.lower(tostring(arg1))
	if arg1 == "stworz" then
		if player:getData("depType") == 1 then return exports.titan_noti:showBox(player, "Nie możesz wyrobić dowodu osobistego będac imigrantem!") end
		if type(player:getData("ssn")) == "table" then return exports.titan_noti:showBox(player, "Posiadasz już dowód osobisty.") end
		if not tonumber(exports.titan_peds:isPedNear(player, "urzad", 5.0)) then return exports.titan_noti:showBox(player, "Nie znajdujesz się obok urzędnika.") end
		exports.titan_offers:createNewOffer("Pracownik urzędu", player, "dowodstworz", {price = 50, name = "Dowód osobisty"})
		-- exports.titan_items:itemCreate(1, getElementData(player, "charID"), "Dowód Osobisty", 11, exports.titan_items:getPlayerFreeSlotID(player), 1, 1, 1, 1)
	elseif arg1 == "pokaz" then
		if type(getElementData(player, "ssn")) ~= "table" then return exports.titan_noti:showBox(player,"Nie posiadasz dowodu osobistego.") end
		--if exports.titan_items:doesPlayerHasItemType(player, 11) then return exports.titan_noti:showBox(player, "Nie posiadasz dowodu osobistego.") end
		if not tonumber(arg2) then return exports.titan_noti:showBox(player, "TIP: /dowod pokaz [ID gracza]") end
		arg2 = tonumber(arg2)
		local target = exports.titan_login:getPlayerByID(arg2)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if not exports.titan_offers:doesPlayerHaveAppropriateDist(player, target, 3.0) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		local data = {}
		local bDate = player:getData("birthday")
		local ssn = player:getData("ssn")
		local cDate = getRealTime(ssn[2])
		table.insert(data, {"Nazwisko", player:getData("lastname")})
		table.insert(data, {"Imię", player:getData("name")})
		table.insert(data, {"Płeć", player:getData("sex") == 1 and "Mężczyzna" or player:getData("sex") == 2 and "Kobieta" or "Nieznana"})
		table.insert(data, {"Data urodzenia", string.format("%0.2d.%0.2d.%0.4dr", bDate.day, bDate.month, bDate.year)})
		table.insert(data, {"Numer SSN", ssn[1]})
		table.insert(data, {"Data wydania dowodu", string.format("%0.2d.%0.2d.%0.4dr", cDate.monthday, cDate.month + 1, cDate.year + 1900)})
		table.insert(data, {"Miejsce urodzenia", getElementData(player, "birthplace")})
		table.insert(data, {"Kolor oczu", getElementData(player, "eyes") == 1 and "Zielone" or getElementData(player, "eyes") == 2 and "Niebieskie" or getElementData(player, "eyes") == 3 and "Brązowe"})
		table.insert(data, {"Wzrost", getElementData(player, "height")})
		triggerClientEvent(target, "ssnFunc.create", target, "Dowód osobisty", data)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s dowód osobisty %s.", getElementData(player, "sex") == 1 and "pokazał" or "pokazała", exports.titan_chats:getPlayerICName(target)), 10.0, false)
	else
		return exports.titan_noti:showBox(player, "TIP: /dowod [stworz, pokaz]")
	end
end
addCommandHandler("dowod", govFunc.cmdDowod, false, false)

function govFunc.cmdPrawko(player, command, arg1, arg2)
	if not exports.titan_login:isLogged(player) then return end
	arg1 = string.lower(tostring(arg1))
	if arg1 == "stworz" then
		if player:getData("depType") == 1 then return exports.titan_noti:showBox(player, "Nie możesz wyrobić prawa jazdy będac imigrantem!") end
		if tonumber(player:getData("vehLicense")) > 0 then return exports.titan_noti:showBox(player, "Posiadasz już prawo jazdy.") end
		if not tonumber(exports.titan_peds:isPedNear(player, "urzad", 5.0)) then return exports.titan_noti:showBox(player, "Nie znajdujesz się obok urzędnika.") end
		exports.titan_offers:createNewOffer("Pracownik urzędu", player, "prawkostworz", {price = 200, name = "Prawo jazdy"})
	elseif arg1 == "pokaz" then
		if not tonumber(player:getData("vehLicense")) or tonumber(player:getData("vehLicense")) == 0 then return exports.titan_noti:showBox(player,"Nie posiadasz prawa jazdy.") end
		if not tonumber(arg2) then return exports.titan_noti:showBox(player, "TIP: /prawko pokaz [ID gracza]") end
		arg2 = tonumber(arg2)
		local target = exports.titan_login:getPlayerByID(arg2)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if not exports.titan_offers:doesPlayerHaveAppropriateDist(player, target, 3.0) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		local data = {}
		local bDate = player:getData("birthday")
		local cDate = getRealTime(player:getData("vehLicense"))
		table.insert(data, {"Nazwisko", player:getData("lastname")})
		table.insert(data, {"Imię", player:getData("name")})
		table.insert(data, {"Płeć", player:getData("sex") == 1 and "Mężczyzna" or player:getData("sex") == 2 and "Kobieta" or "Nieznana"})
		table.insert(data, {"Data urodzenia", string.format("%0.2d.%0.2d.%0.4dr", bDate.day, bDate.month, bDate.year)})
		table.insert(data, {"Data wydania prawa jazdy", string.format("%0.2d.%0.2d.%0.4dr", cDate.monthday, cDate.month + 1, cDate.year + 1900)})
		table.insert(data, {"Miejsce urodzenia", getElementData(player, "birthplace")})
		triggerClientEvent(target, "ssnFunc.create", target, "Prawo jazdy", data)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s prawo jazdy %s.", getElementData(player, "sex") == 1 and "pokazał" or "pokazała", exports.titan_chats:getPlayerICName(target)), 10.0, false)
	else
		return exports.titan_noti:showBox(player, "TIP: /prawko [stworz, pokaz]")
	end
end
addCommandHandler("prawko", govFunc.cmdPrawko, false, false)