----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmdPos(player)
	outputChatBox(string.format("%0.2f, %0.2f, %0.2f", getElementPosition(player)), player)
end
addCommandHandler("pos", cmdPos, false, false)

function cmdRot(player)
	outputChatBox(string.format("%0.2f, %0.2f, %0.2f", getElementRotation(player)), player)
end
addCommandHandler("rot", cmdRot, false, false)

function cmdDrzwi(player, command, arg1)
	if(not exports.titan_login:isLogged(player)) then return end
	if(isPedInVehicle(player)) then return end
	local legend = "zamknij, obiekty"
	if(string.lower(tostring(arg1)) == "zamknij") then
		local doorID = getElementData(player, "nearestDoorID")
		local doorType = getElementData(player, "nearestDoorType")
		if(not tonumber(doorID)) then
			exports.titan_noti:showBox(player, "Nie stoisz przy żadnych drzwiach.")
			return
		end

		if not doesPlayerHavePermToDoors(player, doorID) then
			return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien.")
		end

		local pickupInfo = exports.titan_doors:getPickupInfo(doorID)
		if(not pickupInfo) then return end

		if(not doesPlayerHavePermToDoors(player, doorID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień.")
			return
		end
		if(pickupInfo.locked == 0) then
			changePickupData(doorID, "locked", 1)
			--exports.titan_db:query_free("UPDATE _doorspickup SET locked = 1 WHERE ID = ?", pickupInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, "zamyka drzwi.", 10.0)
			setPedAnimation(player, "INT_HOUSE", "wash_up", -1, false, false, false, false)
			if(doorType == 1) then
				triggerClientEvent(player, "giveDataFromServerAboutDoorInfo", player, {toggle = true, doorName = pickupInfo.name, doorLocked = true})
			end
		else
			changePickupData(doorID, "locked", 0)
			--exports.titan_db:query_free("UPDATE _doorspickup SET locked = 0 WHERE ID = ?", pickupInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, "otwiera drzwi.", 10.0)
			setPedAnimation(player, "INT_HOUSE", "wash_up", -1, false, false, false, false)
			if(doorType == 1) then
				triggerClientEvent(player, "giveDataFromServerAboutDoorInfo", player, {toggle = true, doorName = pickupInfo.name, doorLocked = false})
			end
		end
	elseif string.lower(tostring(arg1)) == "obiekty" then
		local doorID = getElementData(player, "nearestDoorID")
		local doorType = getElementData(player, "nearestDoorType")
		if(not tonumber(doorID)) then
			exports.titan_noti:showBox(player, "Nie stoisz przy żadnych drzwiach.")
			return
		end
		if not doesPlayerHavePermToDoors(player, doorID) then
			return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien.")
		end
		local pickupInfo = exports.titan_doors:getPickupInfo(doorID)
		if(not pickupInfo) then return end
		if(not doesPlayerHavePermToDoors(player, doorID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień.")
			return
		end
		exports.titan_objects:createLoadObjects(player, doorID)
	else
		exports.titan_noti:showBox(player, string.format("TIP: /drzwi [%s]", legend))
		return
	end	
end
addCommandHandler("drzwi", cmdDrzwi, false, false)

function cmdDK(player, command, ...)
	if not exports.titan_login:isLogged(player) then return end
	if isPedInVehicle(player) then return end
	local message = table.concat({...}, " ")
	local doorID = getElementData(player, "nearestDoorID")
	local doorType = getElementData(player, "nearestDoorType")
	if not tonumber(doorID) or not tonumber(doorType) then return exports.titan_noti:showBox(player, "Nie stoisz przy żadnych drzwiach.") end
	local pickupInfo = exports.titan_doors:getPickupInfo(doorID)
	if not pickupInfo then return exports.titan_noti:showBox(player, "Nie stoisz przy żadnych drzwiach.") end

	if string.len(message) <= 1 then return exports.titan_noti:showBox(player, "TIP: /dk [wiadomość]") end
	message = exports.titan_chats:firstToUpper(message).."!"
	exports.titan_chats:sendPlayerLocalMessageRadiusPosition(player, message, 20.0, Vector3(pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ), pickupInfo.inDim, pickupInfo.inInt, "krzyczy (do drzwi)")
	exports.titan_chats:sendPlayerLocalMessageRadiusPosition(player, message, 20.0, Vector3(pickupInfo.outX, pickupInfo.outY, pickupInfo.outZ), pickupInfo.outDim, pickupInfo.outInt, "krzyczy (do drzwi)")
end
addCommandHandler("dk", cmdDK, false, false)

function cmdInt(player, command, arg1, arg2, arg3)
	if(not exports.titan_login:isLogged(player)) then return end
	local legend = "info, drzwi, schowek, magazyn"
	local dimension = getElementDimension(player)
	if(dimension == 0) then return end

	local doorInfo = getDoorInfoFromDimension(dimension)
	if(not doorInfo) then
		exports.titan_noti:showBox(player, "Na tym virtualworldzie nie ma stworzonego interioru.")
		return
	end

	if tonumber(doorInfo.hotelData) and doorInfo.hotelData > 0 then
		return exports.titan_noti:showBox(player, "W hotelu nie masz dostępu do tej komendy.")
	end

	if not doesPlayerHavePermToInterior(player, doorInfo.ID) then
		return exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnien do użycia tej komendy.")
	end

	arg1 = string.lower(tostring(arg1))
	if(arg1 == "info") then
		outputChatBox("---Informacje:", player, 255, 0 ,0)
		outputChatBox("* UID interioru: "..doorInfo.ID, player)
		outputChatBox("* Nazwa interioru: "..doorInfo.name, player)
		outputChatBox("* VirtualWorld: "..doorInfo.dimension, player)
		outputChatBox("* OwnerType: "..doorInfo.ownerType, player)
		outputChatBox("* Owner: "..doorInfo.owner, player)
		return
	elseif(arg1 == "drzwi") then
		local dData = getDoorsOnDimension(dimension)
		if(not dData) then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnych drzwi prowadzących do tego interioru.")
			return
		end

		outputChatBox("---Drzwi podpisane pod interior:", player, 255, 0 ,0)
		for k, v in ipairs(dData) do
			outputChatBox(string.format("* [UID: %d] %s (%s) [%s]", v.ID, v.name, v.type == 1 and "wejście" or "wyjście", v.locked == 1 and "zamknięte" or "otwarte"), player)
		end
		return
	elseif(arg1 == "schowek") then
		arg2 = string.lower(tostring(arg2))
		if(arg2 == "wyjmij") then
			if(not tonumber(arg3)) then
				exports.titan_noti:showBox(player, "TIP: /int schowek wyjmij [ID przedmiotu]")
				return
			end
			arg3 = tonumber(arg3)

			local itemInfo = exports.titan_items:getItemInfo(arg3)
			if(not itemInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.")
				return
			end

			if(itemInfo.ownerType ~= 4 or itemInfo.owner ~= doorInfo.ID) then
				exports.titan_noti:showBox(player, "Przedmiot nie znajduje się w schowku.")
				return
			end

			exports.titan_items:changeItemOwner(itemInfo.ID, 1, getElementData(player, "charID"))
			exports.titan_chats:sendPlayerLocalMeRadius(player, "wyciągnął przedmiot ze schowka.", 10.0)
		else
			local items = exports.titan_items:getInteriorItems(doorInfo.ID)
			if(not items) then
				exports.titan_noti:showBox(player, "W schowku nie ma żadnych przedmiotów.")
				return
			end
			triggerClientEvent(player, "createGUICloset", player, items)
		end
	elseif(arg1 == "magazyn") then
		local magazineItems = getMagazineItems(doorInfo.ID)
		if(not magazineItems) then
			exports.titan_noti:showBox(player, "Magazyn jest pusty.")
			return
		end
		triggerClientEvent(player, "createMagazineGUI", player, magazineItems)
		return
	else
		exports.titan_noti:showBox(player, string.format("TIP: /int [%s]", legend))
		return
	end
end
addCommandHandler("int", cmdInt, false, false)

function cmdKup(player)
	if(not exports.titan_login:isLogged(player)) then return end
	local dimension = getElementDimension(player)
	if(dimension == 0) then return end
	local doorInfo = getDoorInfoFromDimension(dimension)
	if(not doorInfo) then return end
	local products = getIntProductsTable(doorInfo.ID)
	if(not products) then return end
	triggerClientEvent(player, "createBuyGUI", player, products)
end
addCommandHandler("kup", cmdKup, false, false)

function cmdUbranie(player)
	if(not exports.titan_login:isLogged(player)) then return end
	local dimension = getElementDimension(player)
	if(dimension == 0) then return end
	local doorInfo = getDoorInfoFromDimension(dimension)
	if(not doorInfo) then return end
	local clothes = getIntClothesTable(doorInfo.ID)
	if(not clothes) then return end
	triggerClientEvent(player, "createClothesGUI", player, clothes)
end
addCommandHandler("ubranie", cmdUbranie, false, false)

------------
-- EVENTY --
------------

function onPlayerTriedToOpenDoor(player)
	cmdDrzwi(player, "drzwi", "zamknij")
end
addEvent("onPlayerTriedToOpenDoor", true)
addEventHandler("onPlayerTriedToOpenDoor", root, onPlayerTriedToOpenDoor)