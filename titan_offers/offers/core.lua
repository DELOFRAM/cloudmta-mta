----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

offers = {}
offersIndex = {}

-- TYPY
-- * "przedmiot" - przedmiot ze swojego ekwipunkup
-- * "magazyn" - przedmiot z magazynu

function getFreeOfferID()
	local i = 1
	while(true) do
		if(type(offers[i]) ~= "table") then return i end
		i = i + 1
	end
	return false
end

function doesPlayerHaveAppropriateDist(player, target, distance)
	local pX, pY, pZ = getElementPosition(player)
	local tX, tY, tZ = getElementPosition(target)
	if not distance then distance = 3.0 end
	if player:getInterior() ~= target:getInterior() or player:getDimension() ~= target:getDimension() then return false end
	if(getDistanceBetweenPoints3D(pX, pY, pZ, tX, tY, tZ) <= distance) then return true else return false end
end

function doesPlayerHaveOffer(player)
	local index = offersIndex[player]
	if(tonumber(index)) then return true end
	return false
end

function getPlayerOffer(player)
	local index = offersIndex[player]
	if(not tonumber(index)) then return false end
	return index
end

function createNewOffer(player, target, typ, value, offerType)
	if isElement(player) then if doesPlayerHaveOffer(player) then return false end end
	if isElement(target) then if doesPlayerHaveOffer(target) then return false end end
	local index = getFreeOfferID()

	offers[index] = {}
	if isElement(player) then offersIndex[player] = index end
	offersIndex[target] = index

	offers[index].offerFrom = player
	offers[index].offerTo = target

	offers[index].type = typ
	offers[index].value = value

	local playerID = isElement(player) and getElementData(player, "playerID") or "N/D"
	local nickname = isElement(player) and exports.titan_chats:getPlayerICName(player) or player
	exports.titan_hud:showClientOffer(target, typ, nickname, playerID, value.price, value.name)
	offers[index].timer = setTimer(killOffer, 1000 * 15, 1, index, true)
	return true
end

function killOffer(offerID, fromTimer)
	if(type(offers[offerID]) == "table") then
		if(isTimer(offers[offerID].timer)) then killTimer(offers[offerID].timer) end

		if(fromTimer) then
			if(isElement(offers[offerID].offerFrom)) then
				exports.titan_noti:showBox(offers[offerID].offerFrom, "Po 15 sekundach bezczynności oferta została anulowana.")
			end
			if(isElement(offers[offerID].offerTo)) then
				exports.titan_noti:showBox(offers[offerID].offerTo, "Po 15 sekundach bezczynności oferta została anulowana.")
				exports.titan_hud:hideClientOffer(offers[offerID].offerTo)
			end
		end
		offersIndex[offers[offerID].offerFrom] = false
		offersIndex[offers[offerID].offerTo] = false
		offers[offerID] = false
	end
end

function cancelOffer(player)
	local offer = getPlayerOffer(player)
	if(not tonumber(offer)) then
		exports.titan_noti:showBox(player, "Nie otrzymałeś żadnej oferty.")
		return
	end

	if(offers[offer].offerFrom == player) then
		exports.titan_noti:showBox(player, "Anulowałeś ofertę.")
		if(isElement(offers[offer].offerTo)) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Oferujący anulował swoją ofertę")
		end
		killOffer(offer, false)
		return
	end

	if(offers[offer].offerTo == player) then
		exports.titan_noti:showBox(player, "Anulowałeś ofertę.")
		if(isElement(offers[offer].offerFrom)) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz anulował Twoją ofertę.")
		end
		killOffer(offer, false)
		return
	end
end

function acceptOffer(player)
	local offer = getPlayerOffer(player)
	if(not tonumber(offer)) then return exports.titan_noti:showBox(player, "Nie otrzymałeś żadnej oferty.") end
	--if(offers[offer].offerFrom == player) then return exports.titan_noti:showBox(player, "Nie możesz zaakceptować oferty, którą wysłałeś innemu graczowi.") end
	if(offers[offer].value.price > 0) then
		local money = exports.titan_cash:getPlayerCash(offers[offer].offerTo)
		if(offers[offer].value.price > money) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Kupujący nie ma wystarczających środków aby dokończyć transakcję.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie posiadasz wystarczających środków.")
			killOffer(offer, false)
			return
		end
	end
	if offers[offer].offerFrom == "Pracownik urzędu" then
		if not tonumber(exports.titan_peds:isPedNear(player, "urzad", 5.0)) then
			killOffer(offer, false)
			exports.titan_noti:showBox(player, "Nie znajdujesz się obok urzędnika.") 
			return
		end
	elseif offers[offer].offerFrom == "Dealer pojazdów" then
		if not tonumber(exports.titan_peds:isPedNear(player, "salonsamochodowy", 5.0)) then
			killOffer(offer, false)
			exports.titan_noti:showBox(player, "Nie znajdujesz się obok przedstawiciela salonu samochodowego!") 
		return
		end
	else
		local x, y, z = getElementPosition(offers[offer].offerFrom)
		local px, py, pz = getElementPosition(offers[offer].offerTo)
		if getDistanceBetweenPoints3D(x, y, z, px, py, pz) >= 7 then
			exports.titan_noti:showBox(offers[offer].offerTo, "Znajdujesz się za daleko od gracza. Oferta została anulowana.")
			killOffer(offer, false)
			return
		end
	end
	if(offers[offer].type == "item") then
		local value = offers[offer].value
		if(not isElement(offers[offer].offerFrom)) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if(not doesPlayerHaveAppropriateDist(offers[offer].offerFrom, offers[offer].offerTo)) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		local itemInfo = exports.titan_items:getItemInfo(value.itemID)
		if(not itemInfo) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Nie znaleziono podanego przedmiotu.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(offers[offer].offerFrom, "charID")) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Przedmiot nie należy do Ciebie.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if(itemInfo.used == 1) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Przedmiot nie może być używany.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		local pSlot = exports.titan_items:getPlayerFreeSlotID(offers[offer].offerTo)
		if not pSlot then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Gracz nie posiada wolnego slotu w ekwipunku.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Nie posiadasz wolnego slotu w ekipunku.")
			killOffer(offer, false)
			return
		end

		if(offers[offer].value.price > 0) then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then
				exports.titan_cash:addPlayerCash(offers[offer].offerFrom, offers[offer].value.price)
				exports.titan_logs:playerLog(offers[offer].offerFrom, "cash", string.format("Otrzymano pieniądze od: (Oferta) %s (UID: %d, CID: %d) za przedmiot %s (UID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(offers[offer].offerTo), offers[offer].offerTo:getData("memberID"), offers[offer].offerTo:getData("charID"), itemInfo.name, itemInfo.ID, offers[offer].value.price))
				exports.titan_logs:playerLog(offers[offer].offerTo, "cash", string.format("Oddano pieniądze dla: (Oferta) %s (UID: %d, CID: %d) za przedmiot %s (UID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(offers[offer].offerFrom), offers[offer].offerFrom:getData("memberID"), offers[offer].offerFrom:getData("charID"), itemInfo.name, itemInfo.ID, offers[offer].value.price))
			end
		end
		local nickname2 = exports.titan_chats:getPlayerICName(offers[offer].offerTo)
		exports.titan_items:changeItemOwner(itemInfo.ID, 1, getElementData(offers[offer].offerTo, "charID"))
		exports.titan_items:changeItemSlot(itemInfo.ID, pSlot)
		exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerFrom, string.format("podał przedmiot graczowi %s.", nickname2), 10.0, false)
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)
		return
	elseif offers[offer].type == "gym" then
		local value = offers[offer].value
		if(not isElement(offers[offer].offerFrom)) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if(not doesPlayerHaveAppropriateDist(offers[offer].offerFrom, offers[offer].offerTo)) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		local pSlot = exports.titan_items:getPlayerFreeSlotID(offers[offer].offerTo)
		if not pSlot then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Gracz nie posiada wolnego slotu w ekwipunku.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Nie posiadasz wolnego slotu w ekipunku.")
			killOffer(offer, false)
			return
		end
		local playerDuty = exports.titan_orgs:getPlayerDuty(offers[offer].offerFrom)
		if not playerDuty then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Nie jesteś na duty żadnej grupy.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Gracz nie posiada uprawnien.")
			killOffer(offer, false)
			return
		end
		local groupInfo = exports.titan_orgs:getGroupInfo(playerDuty)
		if not groupInfo then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Grupa na której duty jesteś nie istnieje.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if not exports.titan_orgs:doesPlayerHavePerm(offers[offer].offerFrom, playerDuty, "gym") then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Nie posiadasz uprawnien.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Gracz nie posiada uprawnien.")
			killOffer(offer, false)
			return
		end
		if(offers[offer].value.price > 0) then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then
				local tax = exports.titan_orgs:getGovTax("taxGiveItem")
				if not tax then tax = 0 end
				local taxPrice = math.ceil(offers[offer].value.price * (tax / 100))
				if taxPrice < 0 then taxPrice = 0 end
				exports.titan_orgs:giveGroupMoney(groupInfo.ID, offers[offer].value.price - taxPrice, tax, string.format("%s sprzedał karnet graczowi %s.", exports.titan_chats:getPlayerICName(offers[offer].offerFrom), exports.titan_chats:getPlayerICName(offers[offer].offerTo)))
				if taxPrice > 0 then
					exports.titan_orgs:giveGovermentMoney(taxPrice, string.format("Podatek ze sprzedaży karnetu od grupy %s.", groupInfo.name))
				end
			end
		end
		local nickname2 = exports.titan_chats:getPlayerICName(offers[offer].offerTo)
		exports.titan_items:itemCreate(1, offers[offer].offerTo:getData("charID"), "Karnet do siłowni", 27, pSlot, 1, value.groupID, getRealTime().timestamp + 60 * 10, 0)
		exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerFrom, string.format("podał karnet graczowi %s.", nickname2), 10.0, false)
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)
	elseif offers[offer].type == "fuel" then
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
		if not isObject then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Nie jesteś przy dystrybutorze.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Gracz nie jest przy dystrybutorze.")
			killOffer(offer, false)
			return
		end
		if(not isElement(offers[offer].offerFrom)) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if(not doesPlayerHaveAppropriateDist(offers[offer].offerFrom, offers[offer].offerTo)) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		if not isPedInVehicle(offers[offer].offerTo) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Gracz nie jest w pojeździe.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Musisz siedzieć w pojeździe.")
			killOffer(offer, false)
			return
		end
		local pVeh = getPedOccupiedVehicle(offers[offer].offerTo)
		local vehInfo = exports.titan_vehicles:getVehInfo(pVeh:getData("vehID"))
		if not vehInfo then 
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Tego pojazdu nie można zatankować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Tego pojazdu nie można zatankować.")
			killOffer(offer, false)
			return
		end
		if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then
			local newFuel = vehInfo.fuel + offers[offer].value.fuel
			if newFuel > vehInfo.maxfuel then newFuel = vehInfo.maxfuel end
			changeVehicleData(vehInfo.ID, "fuel", newFuel)
			pVeh:setData("vehFuel", newFuel)
			exports.titan_cash:addPlayerCash(offers[offer].offerFrom, math.ceil(offers[offer].value.price * 0.3))
			exports.titan_logs:playerLog(offers[offer].offerFrom, "cash", string.format("Otrzymano pieniądze od: (Oferta - tankowanie paliwa) %s (UID: %d, CID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(offers[offer].offerTo), offers[offer].offerTo:getData("memberID"), offers[offer].offerTo:getData("charID"), math.ceil(offers[offer].value.price * 0.3)))
			exports.titan_logs:playerLog(offers[offer].offerTo, "cash", string.format("Oddano pieniądze dla: (Oferta - tankowanie paliwa) %s (UID: %d, CID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(offers[offer].offerFrom), offers[offer].offerFrom:getData("memberID"), offers[offer].offerFrom:getData("charID"), offers[offer].value.price))
		end
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		exports.titan_chats:sendPlayerLocalDoRadius(offers[offer].offerFrom, string.format("Pojazd %s został zatankowany.", vehInfo.name), 10.0)
		killOffer(offer, false)
	elseif offers[offer].type == "car" then
		local value = offers[offer].value
		if(not isElement(offers[offer].offerFrom)) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if(not doesPlayerHaveAppropriateDist(offers[offer].offerFrom, offers[offer].offerTo, 5.0)) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		local vehInfo = exports.titan_vehicles:getVehInfo(value.vehID)
		if(not vehInfo) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Nie znaleziono podanego pojazdu.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if(vehInfo.ownerType ~= 1 or vehInfo.ownerID ~= getElementData(offers[offer].offerFrom, "charID")) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta anulowana: Pojazd nie należy do Ciebie.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if(offers[offer].value.price > 0) then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then
				exports.titan_cash:addPlayerCash(offers[offer].offerFrom, offers[offer].value.price)
				exports.titan_logs:playerLog(offers[offer].offerFrom, "cash", string.format("Otrzymano pieniądze od: (Oferta - pojazd) %s (UID: %d, CID: %d) za pojazd %s (UID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(offers[offer].offerTo), offers[offer].offerTo:getData("memberID"), offers[offer].offerTo:getData("charID"), vehInfo.name, vehInfo.ID, offers[offer].value.price))
				exports.titan_logs:playerLog(offers[offer].offerTo, "cash", string.format("Oddano pieniądze dla: (Oferta - pojazd) %s (UID: %d, CID: %d) za pojazd %s (UID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(offers[offer].offerFrom), offers[offer].offerFrom:getData("memberID"), offers[offer].offerFrom:getData("charID"), vehInfo.name, vehInfo.ID, offers[offer].value.price))
			end
		end
		exports.titan_vehicles:assignVehicle(value.vehID, 1, getElementData(offers[offer].offerTo, "charID"))
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)
	elseif offers[offer].type == "interaction" then
		if not isElement(offers[offer].offerFrom) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if getDistanceBetweenPoints3D(offers[offer].offerFrom:getPosition(), offers[offer].offerTo:getPosition()) > 1.5 then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end

		local rotx, roty, rotz = getElementRotation(offers[offer].offerFrom)
		local x, y, z = exports.titan_misc:getXYZInFrontOfPlayer(offers[offer].offerFrom, 1.0)
		offers[offer].offerTo:setRotation(rotx, roty, rotz - 180)
		offers[offer].offerTo:setPosition(x, y, z)
		
		if offers[offer].value.name == "Przywitanie" then
			local rotx, roty, rotz = getElementRotation(offers[offer].offerFrom)
			local x, y, z = exports.titan_misc:getXYZInFrontOfPlayer(offers[offer].offerFrom, 1.0)
			offers[offer].offerTo:setRotation(rotx, roty, rotz - 180)
			offers[offer].offerTo:setPosition(x, y, z)
			setPedAnimation(offers[offer].offerFrom, "GANGS", "PRTIAL_HNDSHK_BIZ_01", -1, false, false, false, false)
			setPedAnimation(offers[offer].offerTo, "GANGS", "PRTIAL_HNDSHK_BIZ_01", -1, false, false, false, false)
		elseif offers[offer].value.name == "Pocałunek" then
			local rotx, roty, rotz = getElementRotation(offers[offer].offerFrom)
			local x, y, z = exports.titan_misc:getXYZInFrontOfPlayer(offers[offer].offerFrom, 0.9)
			offers[offer].offerTo:setRotation(rotx, roty, rotz - 180)
			offers[offer].offerTo:setPosition(x, y, z)
			--setPedAnimation(offers[offer].offerFrom, "BD_FIRE", "PLAYA_KISS_03", -1, false, false, false, false)
			--setPedAnimation(offers[offer].offerTo, "BD_FIRE", "Grlfrd_Kiss_03", -1, false, false, false, false)

			local pocalunekAnim = "PLAYA_KISS_03"
			local pocalunekAnim = "Grlfrd_Kiss_03"
			if getElementData(offers[offer].offerFrom,"sex") == 2 and getElementData(offers[offer].offerTo,"sex") == 1 then
				pocalunekAnim = "Grlfrd_Kiss_03"
				pocalunekAnim2 = "PLAYA_KISS_03"
			elseif getElementData(offers[offer].offerFrom,"sex") == 2 and getElementData(offers[offer].offerTo,"sex") == 2 then
				pocalunekAnim = "PLAYA_KISS_03"
				pocalunekAnim2 = "Grlfrd_Kiss_03"
			elseif getElementData(offers[offer].offerFrom,"sex") == 1 and getElementData(offers[offer].offerTo,"sex") == 2 then
				pocalunekAnim = "PLAYA_KISS_03"
				pocalunekAnim2 = "Grlfrd_Kiss_03"
			end
			setPedAnimation(offers[offer].offerFrom, "BD_FIRE", pocalunekAnim, -1, false, false, false, false)
			setPedAnimation(offers[offer].offerTo, "BD_FIRE", pocalunekAnim2, -1, false, false, false, false)
		end

		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)

	elseif offers[offer].type == "fix" then
		if not isElement(offers[offer].offerFrom) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if getDistanceBetweenPoints3D(offers[offer].offerFrom:getPosition(), offers[offer].offerTo:getPosition()) > 5.0 then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		local playerVehicle = getPedOccupiedVehicle(offers[offer].offerTo)
		if not isElement(playerVehicle) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz musi siedzieć w pojeździe.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Musisz siedzieć w pojeździe.")
			killOffer(offer, false)
			return
		end
		local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
		if not vehInfo then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Ten pojazd nie został stworzony przez system pojazdów.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Ten pojazd nie został stworzony przez system pojazdów.")
			killOffer(offer, false)
			return
		end
		exports.titan_mechanic:startRepair(offers[offer].offerFrom, offers[offer].offerTo, offers[offer].value.component, offers[offer].value.price)
		killOffer(offer, false)
	elseif offers[offer].type == "podaj" then
		local value = offers[offer].value
		if not isElement(offers[offer].offerFrom) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if getDistanceBetweenPoints3D(offers[offer].offerFrom:getPosition(), offers[offer].offerTo:getPosition()) > 4.0 or offers[offer].offerFrom:getInterior() ~= offers[offer].offerTo:getInterior() or offers[offer].offerTo:getDimension() ~= offers[offer].offerFrom:getDimension() then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		local playerDuty = exports.titan_orgs:getPlayerDuty(offers[offer].offerFrom)
		if not tonumber(playerDuty) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Nie jesteś na służbie żadnej grupy.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		local groupInfo = exports.titan_orgs:getGroupInfo(playerDuty)
		if not groupInfo then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Grupa na której duty jesteś nie istnieje.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if not exports.titan_orgs:doesGroupHavePerm(playerDuty, "give") or not exports.titan_orgs:doesPlayerHavePerm(offers[offer].offerFrom, playerDuty, "give") then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Nie posiadasz odpowiednich uprawnien do wykonania tej czynności.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		local doorInfo
		local can, err = exports.titan_orgs:isPlayerInInterior(offers[offer].offerFrom, groupInfo)
		if not can then
			if err then
				exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: "..err)
			else
				exports.titan_noti:showBox(offers[offer].offerFrom, "Wystąpił błąd w trakcie finalizowania oferty.")
			end
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if offers[offer].offerFrom:getDimension() == 0 then
			local sphereInfo = exports.titan_spheres:getSphereInfo(exports.titan_spheres:getPlayerZone(offers[offer].offerFrom))
			if not sphereInfo then
				exports.titan_noti:showBox(offers[offer].offerFrom, "Strefa nie istnieje.")
				exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
				killOffer(offer, false)
				return
			end
			if not sphereInfo.intID or sphereInfo.intID == 0 then
				exports.titan_noti:showBox(offers[offer].offerFrom, "Budynek nie istnieje (1).")
				exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
				killOffer(offer, false)
				return
			end
			doorInfo = exports.titan_doors:getDoorInfo(sphereInfo.intID)
			if not doorInfo then
				exports.titan_noti:showBox(offers[offer].offerFrom, "Budynek nie istnieje (2).")
				exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
				killOffer(offer, false)
				return
			end
		else
			doorInfo = exports.titan_doors:getDoorInfoFromDimension(offers[offer].offerFrom:getDimension())
			if not doorInfo then
				exports.titan_noti:showBox(offers[offer].offerFrom, "Budynek nie istnieje.")
				exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
				killOffer(offer, false)
				return
			end
		end
		if doorInfo.ownerType ~= 2 or doorInfo.owner ~= tonumber(playerDuty) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Interior nie należy do Twojej grupy.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		local magazineItem = exports.titan_doors:getMagazineItem(doorInfo.ID, value.itemID)
		if not magazineItem then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Nie znaleziono podanego produktu.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		if(value.price > 0) then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then
				local tax = exports.titan_orgs:getGovTax("taxGiveItem")
				if not tax then tax = 0 end
				local taxPrice = math.ceil(offers[offer].value.price * (tax / 100))
				if taxPrice < 0 then taxPrice = 0 end
				exports.titan_orgs:giveGroupMoney(groupInfo.ID, offers[offer].value.price - taxPrice, tax, string.format("%s sprzedał przedmiot \"%s\" graczowi %s.", exports.titan_chats:getPlayerICName(offers[offer].offerFrom), magazineItem.name, exports.titan_chats:getPlayerICName(offers[offer].offerTo)))
				if taxPrice > 0 then
					exports.titan_orgs:giveGovermentMoney(taxPrice, string.format("Podatek ze sprzedaży produktu \"%s\" od grupy %s.", magazineItem.name, groupInfo.name))
				end
			end
		end
		if exports.titan_doors:giveMagazineItem(offers[offer].offerTo, doorInfo.ID, value.itemID) then
			exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerFrom, "podał przedmiot z magazynu graczowi "..exports.titan_chats:getPlayerICName(offers[offer].offerTo)..".", 10.0)
		else
			exports.titan_noti:showBox(offers[offer].offerFrom, "Błąd: Nie znaleziono podanego produktu.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd w trakcie finalizowania oferty.")
			killOffer(offer, false)
			return
		end
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)
	elseif offers[offer].type == "interview" then 
		exports.titan_noti:showBox(offers[offer].offerFrom, "Od teraz wszystko co napiszesz trafi na pasek LSN.") 
		exports.titan_noti:showBox(offers[offer].offerTo, "Od teraz wszystko co napiszesz trafi na pasek LSN.") 
		setElementData(offers[offer].offerFrom, "interviewLSN", true) 
		setElementData(offers[offer].offerTo, "interviewLSN", true) 
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)
	elseif offers[offer].type == "ad" then
		if(offers[offer].value.price > 0) then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then
				exports.titan_cash:addPlayerCash(offers[offer].offerFrom, offers[offer].value.price)
				triggerClientEvent(offers[offer].offerTo, "showAdGUI", offers[offer].offerTo, offers[offer].value.minutes, offers[offer].offerFrom)
				exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
				exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
				killOffer(offer, false)
			end
		end
	elseif offers[offer].type == "dowodstworz" then
		if offers[offer].value.price > 0 then  
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then  
				exports.titan_orgs:giveGovermentMoney(offers[offer].value.price, string.format("Zapłata za dowód osobisty od %s.", exports.titan_chats:getPlayerICName(offers[offer].offerTo)))
			end  
		end  
		local tmpTable = {exports.titan_misc:generateSSN(), getRealTime().timestamp}  
		offers[offer].offerTo:setData("ssn", tmpTable)  
		exports.titan_db:query_free("UPDATE `_characters` SET `ssn` = ? WHERE `ID` = ?", toJSON(tmpTable), offers[offer].offerTo:getData("charID"))  
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")  
		exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerFrom, string.format("%s dowód osobisty od urzędnika.", getElementData(offers[offer].offerTo, "sex") == 1 and "odebrał" or getElementData(offers[offer].offerTo, "sex") == 2 and "odebrała"), 10.0, false)  
		killOffer(offer, false)
	elseif offers[offer].type == "prawkostworz" then
		if offers[offer].value.price > 0 then  
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then  
				exports.titan_orgs:giveGovermentMoney(offers[offer].value.price, string.format("Zapłata za prawo jazdy od %s.", exports.titan_chats:getPlayerICName(offers[offer].offerTo)))
			end  
		end  
		offers[offer].offerTo:setData("vehLicense", getRealTime().timestamp)  
		exports.titan_db:query_free("UPDATE `_characters` SET `vehLicense` = ? WHERE `ID` = ?", getRealTime().timestamp, offers[offer].offerTo:getData("charID"))  
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")  
		exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerFrom, string.format("%s prawo jazdy od urzędnika.", getElementData(offers[offer].offerTo, "sex") == 1 and "odebrał" or getElementData(offers[offer].offerTo, "sex") == 2 and "odebrała"), 10.0, false)  
		killOffer(offer, false)
	elseif offers[offer].type == "taxi" then
		if not isPedInVehicle(offers[offer].offerFrom) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz musi być w pojeździe, aby to zrobić!")
			exports.titan_noti:showBox(offers[offer].offerTo, "Musisz być w pojeździe, aby zaakceptować ofertę!")
			killOffer(offer, false)
			return
		end
		if not isPedInVehicle(offers[offer].offerTo) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Pasażer gracz musi być w pojeździe!")
			exports.titan_noti:showBox(offers[offer].offerTo, "Musisz być w pojeździe, aby zaakceptować ofertę!")
			killOffer(offer, false)
			return
		end
		local veh1= getPedOccupiedVehicle(offers[offer].offerFrom)
		local veh2= getPedOccupiedVehicle(offers[offer].offerTo)
		if veh1~=veh2 then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Musicie być w tych samych pojazdach!")
			exports.titan_noti:showBox(offers[offer].offerTo, "Musicie być w tych samych pojazdach!")
			killOffer(offer, false)
			return
		end
        exports.titan_noti:showBox(offers[offer].offerFrom, "Zaakceptowano oferte przejazdu taksówką!")
        exports.titan_noti:showBox(offers[offer].offerTo, "Zaakceptowałeś oferte przejazdu taksówką!")
        exports.titan_taximeter:startTaxi(offers[offer].offerFrom, offers[offer].offerTo)
        killOffer(offer, false)
        return
	elseif offers[offer].type == "montaz" then 
		if not isPedInVehicle(offers[offer].offerTo) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz musi siedzieć w pojeździe.")
			killOffer(offer, false)
			return
		end
		local playerVehicle = getPedOccupiedVehicle(offers[offer].offerTo)
		local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie znaleziono w systemie, nie można w nim nic zamontować.") end
		if exports.titan_tuning:installationVehicleComponent(offers[offer].offerFrom, offers[offer].offerTo,  offers[offer].value.price, offers[offer].value.itemUID) then
        	exports.titan_noti:showBox(offers[offer].offerFrom, "Zaakceptowano oferte montażu!")
        	exports.titan_noti:showBox(offers[offer].offerTo, "Zaakceptowałeś oferte montażu!")
		end
        killOffer(offer, false)
	elseif offers[offer].type == "demontaz" then 
		if not isPedInVehicle(offers[offer].offerTo) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz musi siedzieć w pojeździe.")
			killOffer(offer, false)
			return
		end
		local playerVehicle = getPedOccupiedVehicle(offers[offer].offerTo)
		local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie znaleziono w systemie, nie można w nim nic zdemonotwać.") end
		if exports.titan_tuning:UninstallationVehicleComponent(offers[offer].offerFrom, offers[offer].offerTo,  offers[offer].value.price, offers[offer].value.itemUID, false) then
        	exports.titan_noti:showBox(offers[offer].offerFrom, "Zaakceptowano oferte demontażu!")
        	exports.titan_noti:showBox(offers[offer].offerTo, "Zaakceptowałeś oferte demontażu!")
		end
        killOffer(offer, false)
	elseif offers[offer].type == "carsalon" then
		if offers[offer].value.price > 0 then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then  
				exports.titan_gov:addGovermentCash(offers[offer].value.price, "Kupno pojazdu "..offers[offer].value.name)  
			end
		end
		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		--exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerTo, string.format("%s dokumenty zakupu pojazdu i odebrał kluczyki.", getElementData(offers[offer].offerTo, "sex") == 1 and "podpisał" or getElementData(offers[offer].offerTo, "sex") == 2 and "podpisała"), 10.0, false)
		exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerTo, string.format("%s dokumenty zakupu pojazdu i %s kluczyki.", getElementData(offers[offer].offerTo, "sex") == 1 and "podpisał" or getElementData(offers[offer].offerTo, "sex") == 2 and "podpisała", getElementData(offers[offer].offerTo, "sex") == 1 and "odebrał" or getElementData(offers[offer].offerTo, "sex") == 2 and "odebrała"), 10.0, false)
		--exports.titan_chats:sendPlayerLocalMeRadius(offers[offer].offerTo, string.format("%s dokumenty zakupu pojazdu i odebrał kluczyki.", getElementData(offers[offer].offerTo, "sex") == 1 and "podpisał" or getElementData(offers[offer].offerTo, "sex") == 2 and "podpisała"), 10.0, false)
		local vehID = exports.titan_vehicles:vehCreate(1, offers[offer].offerTo:getData("charID"), offers[offer].value.model, 890.82, -1209.439, 17.00, 270.0, 0, 0, false)
		local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
		if vehInfo then
			local ownerUID = getElementData(offers[offer].offerTo, "charID")
			local itemName = "Klucze "..vehInfo.name.." ("..vehInfo.ID..")"
			local itemVolume = 15
			local itemVal1 = vehInfo.ID
			local itemVal2 = ownerUID
			local itemVal3 = getElementData(offers[offer].offerTo, "charID")
			local itemSlotID = exports.titan_items:getPlayerFreeSlotID(offers[offer].offerTo)
			if(not itemSlotID or itemSlotID > 35) then
				exports.titan_noti:showBox(offers[offer].offerTo, "Gracz nie ma już miejsca w ekwipunku.")
			else
				local state, itemID = exports.titan_items:itemCreate(1, ownerUID, itemName, 10, itemSlotID, itemVolume, itemVal1, itemVal2, itemVal3)
			end
		end
		killOffer(offer, false)
		--outputChatBox(tostring(vehID)) 
	elseif offers[offer].type == "ticket" then
		local value = offers[offer].value
		if(not isElement(offers[offer].offerFrom)) then
			exports.titan_noti:showBox(offers[offer].offerTo, "Nie znaleziono gracza, który złożył ofertę.")
			killOffer(offer, false)
			return
		end
		if(not doesPlayerHaveAppropriateDist(offers[offer].offerFrom, offers[offer].offerTo, 5.0)) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Gracz zaakceptował ofertę, ale był za daleko, aby kontynuować.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Gracz jest za daleko.")
			killOffer(offer, false)
			return
		end
		local playerDuty = exports.titan_orgs:getPlayerDuty(offers[offer].offerFrom)
		if not playerDuty or not tonumber(playerDuty) then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Nie jesteś na duty żadnej grupy.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Gracz nie jest na duty grupy.")
			killOffer(offer, false)
			return
		end

		if not exports.titan_orgs:doesPlayerHavePerm(offers[offer].offerFrom, playerDuty, "tickets") then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Nie posiadasz odpowiednich uprawnien.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Gracz nie posiada uprawnien do wydawania mandatów.")
			killOffer(offer, false)
			return
		end

		local groupInfo = exports.titan_orgs:getGroupInfo(playerDuty)
		if not groupInfo then
			exports.titan_noti:showBox(offers[offer].offerFrom, "Nie posiadasz takiej grupy.")
			exports.titan_noti:showBox(offers[offer].offerTo, "Wystąpił błąd: Gracz nie posiada uprawnien do wydawania mandatów.")
			killOffer(offer, false)
			return
		end

		if offers[offer].value.price > 0 then
			if exports.titan_cash:takePlayerCash(offers[offer].offerTo, offers[offer].value.price) then 
				local tax = exports.titan_orgs:getGovTax("taxMandate")
				if not tax then tax = 0 end
				local taxPrice = math.ceil(offers[offer].value.price * (tax / 100))
				if taxPrice < 0 then taxPrice = 0 end
				exports.titan_orgs:giveGroupMoney(groupInfo.ID, offers[offer].value.price - taxPrice, tax, string.format("%s wystawił mandat graczowi %s.", exports.titan_chats:getPlayerICName(offers[offer].offerFrom), exports.titan_chats:getPlayerICName(offers[offer].offerTo)))
				if taxPrice > 0 then
					exports.titan_orgs:giveGovermentMoney(taxPrice, string.format("Podatek z mandatu od grupy %s.", groupInfo.name))
				end
				--exports.titan_orgs:giveGroupMoney(playerDuty, offers[offer].value.price)
			end
		end

		exports.titan_db:query_free("INSERT INTO _police_tickets SET targetID = ?, officerID = ?, points = ?, price = ?, content = ?", getElementData(offers[offer].offerTo, "charID"), getElementData(offers[offer].offerFrom, "charID"), offers[offer].value.points, offers[offer].value.price, offers[offer].value.text)

		exports.titan_noti:showBox(offers[offer].offerTo, "Oferta zrealizowana pomyślnie.")
		exports.titan_noti:showBox(offers[offer].offerFrom, "Oferta zrealizowana pomyślnie.")
		killOffer(offer, false)		
	end
end