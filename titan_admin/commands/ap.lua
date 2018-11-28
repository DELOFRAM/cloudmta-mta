----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:09
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:11
----------------------------------------------------

function cmdAp(player, command, ...)
	if not doesAdminHavePerm(player, "items") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local legend = "stworz, ownertypes, itemtypes, info, bron"

	arg[1] = string.lower(tostring(arg[1]))
	if(arg[1] == "stworz") then
		local ownerUID = arg[2]
		local itemType = arg[3]
		local itemVolume = arg[4]
		local itemVal1 = arg[5]
		local itemVal2 = arg[6]
		local itemVal3 = arg[7]
		local itemName = table.concat({...}, " ", 8)

		--Wyłączone bronie
		local disabledWeapons = {
		[39]=true, 
		[40]=true, 
		[37]=true, 
		[38]=true,}

		if(not tonumber(ownerUID) or not tonumber(itemType) or not tonumber(itemVolume) or not tonumber(itemVal1) or not tonumber(itemVal2) or not tostring(itemVal3) or string.len(tostring(itemName)) < 4) then
			exports.titan_noti:showBox(player, "TIP: /ap stworz [ID gracza] [itemType] [itemVolume] [itemVal1] [itemVal2] [itemVal3] [itemName]")
			return
		end

		ownerType = 1
		ownerUID = tonumber(ownerUID)
		itemType = tonumber(itemType)
		itemVolume = tonumber(itemVolume)
		itemVal1 = tonumber(itemVal1)
		itemVal2 = tonumber(itemVal2)
		itemVal3 = tostring(itemVal3)

		local elem = exports.titan_login:getPlayerByID(tonumber(ownerUID))
		if(not elem) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end
		ownerUID = getElementData(elem, "charID")
		itemName = tostring(itemName)

		local itemSlotID = exports.titan_items:getPlayerFreeSlotID(elem)
		if(not itemSlotID or itemSlotID > 35) then
			exports.titan_noti:showBox(player, "Gracz nie ma już miejsca w ekwipunku.")
			return
		end

		if itemType == 1 and disabledWeapons[tonumber(itemVal1)] then exports.titan_noti:showBox(player,"Ta broń jest zablokowana") return end
		local state, itemID = exports.titan_items:itemCreate(ownerType, ownerUID, itemName, itemType, itemSlotID, itemVolume, itemVal1, itemVal2, itemVal3)
		if(state) then
			exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono przedmiot o nazwie \"%s\" (UID: %d).", itemName, itemID))
			exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) stworzył przedmiot %s (Typ: %d, UID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), itemName, itemType, itemID))
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie tworzenia przedmiotu")
		end
		return
	elseif arg[1] == "usun" then
		local ID = arg[2]
		if(not tonumber(ID)) then
			exports.titan_noti:showBox(player, "TIP: /ap usun [ID przedmiotu]")
			return
		end
		ID = tonumber(ID)

		local itemInfo = exports.titan_items:getItemInfo(ID)
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(itemInfo.used == 1) then
			exports.titan_noti:showBox(player, "Przedmiot nie może być używany.")
			return
		end
		exports.titan_items:removeItem(ID, true)
		exports.titan_noti:showBox(player, "Przedmiot zniszczony.")
	elseif(arg[1] == "ownertypes") then

		outputConsole("--== BEGIN Typy właścicieli ==--", player)
		outputConsole("* 1 - Gracz", player)
		outputConsole("* 2 - Pojazd (wnętrze)", player)
		outputConsole("* 3 - Pojazd (bagażnik)", player)
		outputConsole("* 4 - Drzwi", player)
		outputConsole("--== Typy właścicieli END ==--", player)

		exports.titan_noti:showBox(player, "Lista typów włascicieli została wydrukowana w konsoli.")
		return
	elseif(arg[1] == "itemtypes") then
		outputConsole("--== BEGIN Typy przedmiotów ==--", player)
		outputConsole("* 1 - Broń", player)
		outputConsole("* 2 - Amunicja", player)
		outputConsole("* 3 - Ubranie", player)
		outputConsole("* 4 - Megafon", player)
		outputConsole("* 5 - Kevlar", player)
		outputConsole("* 6 - Jedzenie", player)
		outputConsole("* 7 - Ciało", player)
		outputConsole("* 8 - Telefon", player)
		outputConsole("* 9 - Rękawiczki", player)
		outputConsole("* 10 - Kluczyk", player)
		outputConsole("* 11 - Dowód osobisty", player)
		outputConsole("* 12 - Płyta CD", player)
		outputConsole("* 13 - Narkotyki", player)
		outputConsole("* 14 - Paralizator", player)
		outputConsole("* 15 - Obiekt przyczepialny", player)
		outputConsole("* 16 - Maska / Kominiarka", player)
		outputConsole("* 17 - Prawo jazdy", player)
		outputConsole("* 18 - Kajdanki", player)
		outputConsole("* 19 - Boombox", player)
		outputConsole("* 20 - Kogut policyjny", player)
		outputConsole("* 21 - Alkohol", player)
		outputConsole("* 22 - Kostka do gry", player)
		outputConsole("* 23 - Tuning pojazdu", player)
		outputConsole("* 24 - Łom do wyważania drzwi", player)
		outputConsole("--== Typy przedmiotów END ==--", player)

		exports.titan_noti:showBox(player, "Lista typów przedmiotów została wydrukowana w konsoli.")
	elseif arg[1] == "info" then
		local itemID = arg[2]
		if not tonumber(itemID) then
			return exports.titan_noti:showBox(player, "TIP: /ap info [ID przedmiotu]")
		end
		exports.titan_items:showItemInfoGUI(player, tonumber(itemID))

	elseif(arg[1] == "bron") then
		outputConsole("----- ID broni = v1 || ilosc_amunicji (v2) || v3 ustawiacie na 0 -----", player)

		outputConsole("* ID: 1 - Kastet", player)
		outputConsole("* ID: 2 - Kij golfowy", player)
		outputConsole("* ID: 3 - Pałka policyjna", player)
		outputConsole("* ID: 4 - Nóż", player)
		outputConsole("* ID: 5 - Kij baseballowy", player)
		outputConsole("* ID: 6 - Łopata", player)
		outputConsole("* ID: 7 - Kij bilardowy", player)
		outputConsole("* ID: 8 - Katana", player)
		outputConsole("* ID: 9 - Piła", player)
		outputConsole("* ID: 10 - Dildo krzywe", player)
		outputConsole("* ID: 11 - Dildo proste", player)
		outputConsole("* ID: 12 - Wibrator", player)
		outputConsole("* ID: 13 - Srebrny wibrator", player)
		outputConsole("* ID: 14 - Kwiatki", player)
		outputConsole("* ID: 15 - Laska", player)
		outputConsole("* ID: 16 - Granat", player)
		outputConsole("* ID: 17 - Gaz łzawiący", player)
		outputConsole("* ID: 18 - Koktajl mołotowa", player)
		outputConsole("* ID: 22 - 9mm", player)
		outputConsole("* ID: 23 - 9mm z tłumikiem", player)
		outputConsole("* ID: 24 - Deagle", player)
		outputConsole("* ID: 25 - Strzelba", player)
		outputConsole("* ID: 26 - Olbrzyn", player)
		outputConsole("* ID: 27 - Strzelba bojowa", player)
		outputConsole("* ID: 28 - UZI", player)
		outputConsole("* ID: 29 - MP5", player)
		outputConsole("* ID: 32 - Tec-9", player)
		outputConsole("* ID: 30 - AK-47", player)
		outputConsole("* ID: 31 - M4", player)
		outputConsole("* ID: 33 - Rifle", player)
		outputConsole("* ID: 34 - Snajperka", player)
		outputConsole("* ID: 35 - RPG", player)
		outputConsole("* ID: 36 - HS Rocket", player)
		outputConsole("* ID: 37 - Miotacz ognia", player)
		outputConsole("* ID: 38 - Minigun", player)
		outputConsole("* ID: 39 - Ładunek wybuchowy", player)
		outputConsole("* ID: 40 - Detonator ładunku wybuchowego", player)
		outputConsole("* ID: 41 - Spray", player)
		outputConsole("* ID: 42 - Gaśnica", player)
		outputConsole("* ID: 43 - Kamera", player)
		outputConsole("* ID: 44 - Gogle noktowizyjne", player)
		outputConsole("* ID: 45 - Gogle na podczerwień", player)
		outputConsole("* ID: 46 - Spadochron", player)

		exports.titan_noti:showBox(player, "Lista ID broni została wydrukowana w konsoli.")	
		
	else
		exports.titan_noti:showBox(player, string.format("TIP: /ap [%s]", legend))
		return
	end
end
addCommandHandler("ap", cmdAp, false, false)

function cmdMyCharID(player)
	if(not exports.titan_login:isLogged(player)) then return end
	exports.titan_noti:showBox(player, string.format("Twoje UID postaci to: %d.", getElementData(player, "charID")))
end
addCommandHandler("charid", cmdMyCharID, false, false)