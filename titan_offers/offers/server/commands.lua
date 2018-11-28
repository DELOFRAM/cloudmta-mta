----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local tip = 
{
	{"przedmiot", false},
	{"pojazd", false},
	{"przywitanie", false},
	{"pocalunek", false},
	{"tankowanie", false},
	{"reklama", "sendad"},
	{"wywiad", "interview"},
	{"taxi", "Taxi"},
	{"montaz", "tuning"},
	{"demontaz", "tuning"},
	{"podaj", "give"},
	{"leczenie", "heal"},
	{"karnet", "gym"},
	{"mandat", "tickets"},
	{"naprawa", "vehfix"}
}


local taxiVehs = { 
	[420]=true,
}

function cmdOferuj(player, command, option, val1, val2, val3)
	if not exports.titan_login:isLogged(player) then return end
	option = string.lower(tostring(option))
	if option == "przywitanie" then
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) przywitanie [ID gracza]") end
		val1 = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować przywitania samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz oferować przywitania będąc w pojeździe.") end
		if isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz nie może być w pojeździe.") end
		createNewOffer(player, target, "interaction", {name = "Przywitanie", price = 0})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	elseif option == "pocalunek" then
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) pocalunek [ID gracza]") end
		val1 = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować przywitania samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz oferować pocałunku będąc w pojeździe.") end
		if isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz nie może być w pojeździe.") end
		createNewOffer(player, target, "interaction", {name = "Pocałunek", price = 0})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	elseif option == "pojazd" then
		if not tonumber(val1) or not tonumber(val2) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) pojazd [ID gracza] [cena]") end
		val1, val2 = tonumber(val1), tonumber(val2)
		if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.") end
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować pojazdu samemu sobie.") end
		if not doesPlayerHaveAppropriateDist(player, target, 5.0) then return exports.titan_noti:showBox(player, "Jesteś za daleko od gracza.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if val2 < 0 or val2 > 9999999 then return exports.titan_noti:showBox(player, "Kwota musi mieścić się w przedziale [0 - 9999999].") end
		local veh = getPedOccupiedVehicle(player)
		local vehInfo = exports.titan_vehicles:getVehInfo(veh:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Nie znaleziono informacji o tym pojeździe w bazie danych.") end
		if vehInfo.ownerType ~= 1 or vehInfo.ownerID ~= player:getData("charID") then return exports.titan_noti:showBox(player, "Ten pojazd nie należy do Ciebie.") end
		createNewOffer(player, target, "car", {name = getVehicleNameFromModel(veh:getModel()), price = val2, vehID = vehInfo.ID})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	elseif option == "przedmiot" then
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) przedmiot [ID gracza]") end
		val1 = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować przedmiotu samemu sobie.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Jesteś za daleko od gracza.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		local items = exports.titan_items:getPlayerItems(player)
		if not items then return exports.titan_noti:showBox(player, "Nie posiadasz żadnych przedmiotów.") end
		triggerClientEvent(player, "offerItem.gCreate", player, items, target)
	elseif option == "wywiad" then
		if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
		local groupInfo = exports.titan_orgs:getGroupInfo(exports.titan_orgs:getPlayerDuty(player))
		if not groupInfo then return exports.titan_noti:showBox(player, "Nie udało się pobrać danych dot. grupy gracza.") end
		if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "interview") then return exports.titan_noti:showBox(player, "Twoja grupa nie ma uprawnień do korzystania z wywiadów!") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, groupInfo.ID, "interview") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z wywiadów!") end
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) wywiad [ID gracza]") end
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie ma gracza o podanym ID") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować wywiadu samemu sobie.") end
		createNewOffer(player, target, "interview", {name = "Wywiad", price = 0})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	elseif option == "reklama" then
		if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
		local groupInfo = exports.titan_orgs:getGroupInfo(exports.titan_orgs:getPlayerDuty(player))
		if not groupInfo then return exports.titan_noti:showBox(player, "Nie udało się pobrać danych dot. grupy gracza.") end
		if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "sendad") then return exports.titan_noti:showBox(player, "Twoja grupa nie ma uprawnień do korzystania z reklam!") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, groupInfo.ID, "sendad") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z reklam!") end
		if not tonumber(val1) or not tonumber(val2) or not tonumber(val3) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) reklama [ID gracza] [Ilośc minut] [Cena za minutę]") end
		local target = exports.titan_login:getPlayerByID(tonumber(val1))
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie ma gracza o podanym ID") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować reklam samemu sobie.") end
		if tonumber(val2) == 0 then return exports.titan_noti:showBox(player, "Reklama musi pojawić się na bloku na minimum minutę!") end
		if tonumber(val3) == 0 then return exports.titan_noti:showBox(player, "Nie możesz oferować darmowych reklam!") end
		createNewOffer(player, target, "ad", {name = "Reklama", price = tonumber(val2) * tonumber(val3), minutes = tonumber(val3)})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	--[[elseif option == "dowodstworz" then 
		if offers[offer].value.price > 0 then 
		  if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then 
			exports.titan_gov:addGovermentCash(offers[offer].value.price, "Zapłata za dowód osobisty.") 
		  end 
		end 
		local tmpTable = {exports.titan_misc:generateSSN(), getRealTime().timestamp} 
		offers[offer].offerTo:setData("ssn", tmpTable) 
		exports.titan_db:query_free("UPDATE `_characters` SET `ssn` = ? WHERE `ID` = ?", toJSON(tmpTable), offers[offer].offerTo:getData("charID")) 
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.") 
		exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerFrom, "odebrał dowód osobisty od urzędnika.", 10.0, false) 
		killOffer(offer, false)]]
	elseif option == "mandat" then
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) mandat [ID gracza]") end
		val1 = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować przejazdu samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)

		if not playerDuty or not tonumber(playerDuty) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "tickets") then return exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnien do wystawiania mandatow.") end
		
		exports.titan_orgs:offerMandat(player, target)
		--ptFunc.offerMandat
	elseif option == "taxi" then
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) taxi [ID gracza]") end
		val1 = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować przejazdu samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "Taxi") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z tego.") end
		if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Musisz być w pojeździe, aby to zrobić.") end
		if not isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz musi być w pojeździe, aby to zrobić.") end
		local veh1 = getPedOccupiedVehicle(player)
		local veh2 = getPedOccupiedVehicle(target)
		if veh1 ~= veh2 then return exports.titan_noti:showBox(player, "Musicie być w tych samych pojazdach.") end
		if not taxiVehs[getElementModel(veh1)] then return exports.titan_noti:showBox(player, "Musisz być w pojeździe TAXI.") end
		if getElementData(target, "taxi:is") then return exports.titan_noti:showBox(player, "Ten gracz ma już uruchomiony taksometr.") end
		if getElementData(player, "taxi:is") then return exports.titan_noti:showBox(player, "Posiadasz już uruchiomiony traksometr.") end
		local seat = getPedOccupiedVehicleSeat(player)
		if seat ~= 0 then return exports.titan_noti:showBox(player, "Musisz byc kierowcą, aby to zrobić.") end
		createNewOffer(player, target, "taxi", {name = "Przejazd", price = 0})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	elseif option == "montaz" then
		if not exports.titan_login:isLogged(player) then return end
		if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "tuning") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z tego.") end
		if not tonumber(val1) or not tonumber(val2) or not tonumber(val3) then return exports.titan_noti:showBox(player, "TIP: /montaz [ID gracza] [UID przedmiotu] [cena]") end
		price = tonumber(val3)
		itemUID = tonumber(val2)
		playerID = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end			
		if getElementData(player, "bwTime") then return end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		--if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować montażu samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end			
		local target = exports.titan_login:getPlayerByID(tonumber(playerID))
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		local playerVehicle = getPedOccupiedVehicle(target)
		if not isElement(playerVehicle) then return exports.titan_noti:showBox(player, "Gracz musi siedzieć w pojeździe.") end
		local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie znaleziono w systemie, nie można w nim nic zamontować.") end
		createNewOffer(player, target, "montaz", {name = "Montaż", price = tonumber(price), itemUID = tonumber(itemUID) })
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target))) 	
	elseif option == "demontaz" then
		if not exports.titan_login:isLogged(player) then return end
		if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "tuning") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z tego.") end
		if not tonumber(val1) or not tonumber(val2) or not tonumber(val3) then return exports.titan_noti:showBox(player, "TIP: /demontaz [ID gracza] [ID slotu pojazdu] [cena]") end
		price = tonumber(val3)
		itemUID = tonumber(val2)
		playerID = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end			
		if getElementData(player, "bwTime") then return end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		--if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować montażu samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end			
		local target = exports.titan_login:getPlayerByID(tonumber(playerID))
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		local playerVehicle = getPedOccupiedVehicle(target)
		if not isElement(playerVehicle) then return exports.titan_noti:showBox(player, "Gracz musi siedzieć w pojeździe.") end
		local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie znaleziono w systemie, nie można w nim nic zamontować.") end
		createNewOffer(player, target, "demontaz", {name = "Demontaż", price = tonumber(price), itemUID = tonumber(itemUID) })
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target))) 	
	elseif option == "tankowanie" then
		local price = 3
		if not tonumber(val1) or not tonumber(val2) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) tankowanie [ID gracza] [ilość w litrach]") end
		val1 = tonumber(val1)
		val2 = math.floor(tonumber(val2))
		local sphere = createColSphere(player:getPosition(), 5.0)
		local objects = getElementsWithinColShape(sphere, "object")
		destroyElement(sphere)
		local isObject = false
		for k, v in ipairs(objects) do
			if v:getData("isObject") then
				if v:getInterior() == player:getInterior() and v:getDimension() == player:getDimension() then
					if v:getModel() == 1676 then isObject = true end
				end
			end
		end
		if not isObject then return exports.titan_noti:showBox(player, "Nie znajdujesz się obok dystrybutora.") end
		if val2 <= 0 then return exports.titan_noti:showBox(player, "Możesz zatankować co najmniej 1 litr.") end
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować przejazdu samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz musi być w pojeździe, aby to zrobić.") end
		local pVeh = getPedOccupiedVehicle(target)
		local vehInfo = exports.titan_vehicles:getVehInfo(pVeh:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie można zatankować.") end
		if math.floor(vehInfo.fuel) >= math.floor(vehInfo.maxfuel) then return exports.titan_noti:showBox(player, "Bak pojazdu jest pełny.") end
		if vehInfo.fuel + val2 > vehInfo.maxfuel then
			return exports.titan_noti:showBox(player, string.format("W baku zmieści się maksymalne %d litrów paliwa.", math.floor(vehInfo.maxfuel - vehInfo.fuel)))
		end
		local newPrice = price * val2
		newPrice = newPrice - math.floor(newPrice * 0.2)
		if newPrice <= 0 then newPrice = 1 end
		createNewOffer(player, target, "fuel", {name = "Tankowanie", price = newPrice, fuel = val2})
	elseif option == "leczenie" then
		exports.titan_orgs:PlayerHeal(player, command, val1)
	elseif option == "podaj" then 
		exports.titan_orgs:PlayerGiveItem(player, command, val1)
	elseif option == "karnet" then
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)
		if not playerDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "gym") then return exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnien do użycia tej komendy.") end
		if not tonumber(val1) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) karnet [ID gracza]") end
		val1 = tonumber(val1)
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować karnetu samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz oferować karnetu będąc w pojeździe.") end
		if isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz nie może być w pojeździe.") end
		createNewOffer(player, target, "gym", {name = "Karnet na siłownię", price = 25, groupID = playerDuty})
		return exports.titan_noti:showBox(player, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", exports.titan_chats:getPlayerICName(target)))
	elseif option == "naprawa" then
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)
		if not playerDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
		if not exports.titan_orgs:doesGroupHavePerm(playerDuty, "vehfix") then return exports.titan_noti:showBox(player, "Grupa nie posiada odpowiednich uprawnien.") end
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "vehfix") then return exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnien do użycia tej komendy.") end
		if not tonumber(val1) or not tonumber(val2) then return exports.titan_noti:showBox(player, "TIP: /o(feruj) naprawa [ID gracza] [cena]") end
		val1 = tonumber(val1)
		val2 = tonumber(val2)
		if val2 < 0 or val2 > 10000 then return exports.titan_noti:showBox(player, "Kwota musi zawierać się w przedziale $[0 - 10000].") end
		local target = exports.titan_login:getPlayerByID(val1)
		if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
		if doesPlayerHaveOffer(player) then return exports.titan_noti:showBox(player, "Masz aktywną inną ofertę.") end
		if player == target then return exports.titan_noti:showBox(player, "Nie możesz oferować naprawy samemu sobie.") end
		if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(player, "Gracz posiada już inną ofertę.") end
		if not doesPlayerHaveAppropriateDist(player, target) then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
		if not isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz musi być w pojeździe.") end
		if exports.titan_mechanic:doesPlayerDoingRepair(player) then return exports.titan_noti:showBox(player, "Prowadzisz już inna naprawę.") end

		local playerVehicle = getPedOccupiedVehicle(target)
		local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie znaleziono w systemie, nie można go naprawić.") end
		exports.titan_mechanic:createRepairGUI(player, target, val2)
	else
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)
		local text = ""
		for i,v in ipairs(tip) do
			if playerDuty then
				if v[2] ~= false and exports.titan_orgs:doesGroupHavePerm(playerDuty, v[2]) and exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, v[2]) then 
					if i == 1 then
						text =  v[1]
					else
						text = text..", "..v[1]
					end
				end
			end
			if v[2] == false and i == 1 then
				text = v[1]
			elseif v[2] == false then
				text = text..", "..v[1]
			end
		end
		return exports.titan_noti:showBox(player, string.format("TIP: /o(feruj) [%s]", text))
	end
end
addCommandHandler("o", cmdOferuj, false, false)
addCommandHandler("oferuj", cmdOferuj, false, false)