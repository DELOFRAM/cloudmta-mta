function cmdLista(player)
	if(not exports.titan_login:isLogged(player)) then return end
	if getElementData(player, "additionalItemsMenuActive") then return end
	if(getElementData(player, "itemGUIOpened")) then
		setElementData(player, "itemGUIOpened", false)
		triggerClientEvent(player, "closeItemGUI", player)
	else
		if exports.titan_bw:doesPlayerHaveBW(player) then return exports.titan_noti:showBox(player, "W trakcie BW nie możesz używać przedmiotów.") end
		local playerItems = getPlayerItems(player)
		if(not playerItems) then playerItems = {} end
		local nearestItems
		if isPedInVehicle(player) then
			local veh = getPedOccupiedVehicle(player)
			if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
				nearestItems = {}
			else
				local tmpTable = getVehicleItems(getElementData(veh, "vehID"))
				if(not tmpTable) then
					nearestItems = {}
				else
					nearestItems = tmpTable
				end
			end
		else
			nearestItems = getNearestPlayerItems(player)
			if not nearestItems then nearestItems = {} end
		end
		
		setElementData(player, "itemGUIOpened", true)
		triggerClientEvent(player, "openItemGUI", player, playerItems, nearestItems)
	end
end
addCommandHandler("plista", cmdLista)

function cmdPrzedmiot(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then
		return false
	end
	local legend = "lista, uzyj, obejrzyj, odloz, podnies, schowek"
	local arg = {...}
	if(not arg[1]) then
		exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) ["..legend.."]")
		return
	end
	if exports.titan_bw:doesPlayerHaveBW(player) then return exports.titan_noti:showBox(player, "W trakcie BW nie możesz używać przedmiotów.") end
	if(string.lower(arg[1]) == "lista") then
		if(getElementData(player, "itemGUIOpened")) then
			setElementData(player, "itemGUIOpened", false)
			triggerClientEvent(player, "closeItemGUI", player)
		else
			local playerItems = getPlayerItems(player)
			if(not playerItems) then playerItems = {} end
			local nearestItems
			if isPedInVehicle(player) then
				local veh = getPedOccupiedVehicle(player)
				if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
					nearestItems = {}
				else
					local tmpTable = getVehicleItems(getElementData(veh, "vehID"))
					if(not tmpTable) then
						nearestItems = {}
					else
						nearestItems = tmpTable
					end
				end
			else
				nearestItems = getNearestPlayerItems(player)
				if not nearestItems then nearestItems = {} end
			end
			
			setElementData(player, "itemGUIOpened", true)
			triggerClientEvent(player, "openItemGUI", player, playerItems, nearestItems)
		end
	--[[
	elseif(string.lower(arg[1]) == "zniszcz") then
		local ID = arg[2]
		if(not tonumber(ID)) then
			exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) zniszcz [ID przedmiotu]")
			return
		end
		ID = tonumber(ID)

		local itemInfo = getItemInfo(ID)
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
			exports.titan_noti:showBox(player, "Ten przedmiot nie należy do Ciebie.")
			return
		end

		if(itemInfo.used == 1) then
			exports.titan_noti:showBox(player, "Przedmiot nie może być używany.")
			return
		end
		removeItem(ID)
		exports.titan_noti:showBox(player, "Przedmiot zniszczony.")
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("niszczy przedmiot %s.", itemInfo.name), 10.0, false)
		guiFunc.updatePlayerEquip(player)
	--]]
	elseif(string.lower(arg[1]) == "uzyj") then
		if(exports.titan_bw:doesPlayerHaveBW(player)) then
			exports.titan_noti:showBox(player, "Nie możesz używać przedmiotów w trakcie stanu nieprzytomności.")
			return
		end

		if(not tonumber(arg[2])) then
			exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) uzyj [ID przedmiotu]")
			return
		end

		playerUseItem(player, tonumber(arg[2]), arg[3])
		return
	
	elseif(string.lower(arg[1]) == "obejrzyj") then
		if(not tonumber(arg[2])) then
			exports.titan_chats:sendPlayerChatMessage(player, "TIP: /p(rzedmiot) obejrzyj [ID przedmiotu]", 255, 255, 255, false)
			return
		end

		local itemInfo = getItemInfo(tonumber(arg[2]))
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
			exports.titan_noti:showBox(player, "Ten przedmiot nie należy do Ciebie.")
			return
		end

		if(itemInfo.type == itemTypes.weapon) then
			exports.titan_chats:sendPlayerChatMessage(player, string.format("** Na bocznej części broni widnieje numer seryjny: %s", itemInfo.val3), 154, 156, 205, false)
		elseif(itemInfo.type == itemTypes.ammo) then
			exports.titan_chats:sendPlayerChatMessage(player, string.format("** Pudełeczko z amunicją, %d sztuk.", itemInfo.val2), 154, 156, 205, false)
		elseif(itemInfo.type == itemTypes.clothes) then
			exports.titan_chats:sendPlayerChatMessage(player, string.format("** Ubranie o numerze %d.", itemInfo.val1), 154, 156, 205, false)
		elseif(itemInfo.type == itemTypes.megaphone) then
			exports.titan_chats:sendPlayerChatMessage(player, string.format("** Zwykły megafon."), 154, 156, 205, false)
		elseif(itemInfo.type == itemTypes.kevlar) then
			if(itemInfo.val1 <= 0) then
				exports.titan_chats:sendPlayerChatMessage(player, string.format("** Zniszczona kamizelka, nie nadaje się do użytku.", itemInfo.val2), 154, 156, 205, false)
			else
				exports.titan_chats:sendPlayerChatMessage(player, string.format("** Kamizelka kuloodporna, stan: %d procent", itemInfo.val1), 154, 156, 205, false)
			end
		elseif(itemInfo.type == itemTypes.food) then
			exports.titan_chats:sendPlayerChatMessage(player, string.format("** Wygląda to na jedzenie."), 154, 156, 205, false)
		elseif(itemInfo.type == itemTypes.taser) then
			exports.titan_chats:sendPlayerChatMessage(player, string.format("** Na bocznej części paralizatora widnieje numer seryjny: %s", itemInfo.val3), 154, 156, 205, false)
		elseif(itemInfo.type == itemTypes.handCuff) then
			exports.titan_chats:sendPlayerChatMessage(player, "** Kajdanki.", 154, 156, 205, false)
		end
		return
	elseif(string.lower(arg[1]) == "podnies") or (string.lower(arg[1]) == "p") then
		if(exports.titan_bw:doesPlayerHaveBW(player)) then
			exports.titan_noti:showBox(player, "Nie możesz podnosić przedmiotów w trakcie stanu nieprzytomności.")
			return
		end

		if(not tonumber(arg[2])) then
			if(isPedInVehicle(player)) then
				local veh = getPedOccupiedVehicle(player)
				if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
					exports.titan_noti:showBox(player, "Ten pojazd nie został stworzony przez moduł systemu pojazdów.")
					return
				end

				local tmpTable = getVehicleItems(getElementData(veh, "vehID"))
				if(not tmpTable) then
					exports.titan_noti:showBox(player, "Nie znaleziono żadnych przedmiotów w środku pojazdu.")
					return
				end
				exports.titan_chats:sendPlayerChatMessage(player, "---=== PRZEDMIOTY W POJEŹDZIE ===---", 255, 0, 0, false)
					for k, v in ipairs(tmpTable) do
						exports.titan_chats:sendPlayerChatMessage(player, string.format("%s (UID: %d)", v.name, v.ID), 255, 255, 255)
					end
				return
			end

			local tmpTable = getNearestPlayerItems(player)
			if(tmpTable and #tmpTable > 0) then
				exports.titan_chats:sendPlayerChatMessage(player, "---=== PRZEDMIOTY W POBLIŻU ===---", 255, 0, 0, false)

				for k, v in ipairs(tmpTable) do
					exports.titan_chats:sendPlayerChatMessage(player, string.format("%s (UID: %d)", v.name, v.ID), 255, 255, 255, false)
				end
			else
				exports.titan_noti:showBox(player, "Nie znaleziono żadnych przedmiotów w pobliżu.")
			end
			exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) podnies [ID przedmiotu]")
			return
		end
		arg[2] = tonumber(arg[2])
		local itemInfo = getItemInfo(arg[2])
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
				exports.titan_noti:showBox(player, "Ten pojazd nie został stworzony przez moduł systemu pojazdów.")
				return
			end

			if(itemInfo.ownerType ~= 3) then
				exports.titan_noti:showBox(player, "Ten przedmiot nie został znaleziony w pojeździe.")
				return
			end
			if(itemInfo.owner ~= getElementData(veh, "vehID")) then
				exports.titan_noti:showBox(player, "Ten przedmiot nie został znaleziony w pojeździe.")
				return
			end

			local itemSlot = getPlayerFreeSlotID(player)
			if(not itemSlot) then
				exports.titan_noti:showBox(player, "Nie posiadasz wolnego slotu w ekwipunku.")
				return
			end

			if(itemInfo.type == itemTypes.policeSiren) then
				if(getElementData(veh, "doesKogutActive")) then
					setElementData(veh, "doesKogutActive", false)
					local kogutElement = getElementData(veh, "kogutElement")
					if(isElement(kogutElement)) then
						destroyElement(kogutElement)
					end
				end
			end


			itemInfo.ownerType = 1
			itemInfo.owner = getElementData(player, "charID")
			itemInfo.slotID = itemSlot
			itemInfo.x = 0
			itemInfo.y = 0
			itemInfo.z = 0
			itemInfo.rx = 0
			itemInfo.ry = 0
			itemInfo.rz = 0
			itemInfo.interior = 0
			itemInfo.dimension = 0
			exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ?, slotID = ?, used = '0', x = '0', y = '0', z = '0', rx = '0', ry = '0', rz = '0', interior = '0', dimension = '0' WHERE ID = ?", itemInfo.ownerType, itemInfo.owner, itemInfo.slotID, itemInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, "podniósł "..string.lower(itemInfo.name).." z pojazdu.", 10.0)
			guiFunc.updatePlayerEquip(player)
			return
		end

		if(itemInfo.ownerType ~= 0) then
			exports.titan_noti:showBox(player, "Ten przedmiot należy do kogoś innego.")
			return
		end

		local pX, pY, pZ = getElementPosition(player)
		if(getDistanceBetweenPoints3D(pX, pY, pZ, itemInfo.x, itemInfo.y, itemInfo.z) > 3.0) then
			exports.titan_noti:showBox(player, "Ten przedmiot jest zbyt daleko od Ciebie.")
			return
		end

		local itemSlot = getPlayerFreeSlotID(player)
		if(not itemSlot) then
			exports.titan_noti:showBox(player, "Nie posiadasz wolnego slotu w ekwipunku.")
			return
		end

		itemInfo.ownerType = 1
		itemInfo.owner = getElementData(player, "charID")
		itemInfo.slotID = itemSlot
		itemInfo.x = 0
		itemInfo.y = 0
		itemInfo.z = 0
		itemInfo.rx = 0
		itemInfo.ry = 0
		itemInfo.rz = 0
		itemInfo.interior = 0
		itemInfo.dimension = 0

		exports.titan_chats:sendPlayerLocalMeRadius(player, "podniósł "..(itemInfo.name).." z ziemi.", 10.0)
		guiFunc.updatePlayerEquip(player)
		exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ?, slotID = ?, used = '0', x = '0', y = '0', z = '0', rx = '0', ry = '0', rz = '0', interior = '0', dimension = '0' WHERE ID = ?", itemInfo.ownerType, itemInfo.owner, itemInfo.slotID, itemInfo.ID)
		setPedAnimation(player, "BOMBER", "BOM_Plant", -1, false, false, false, false)

		if(isElement(itemsModels[itemInfo.ID])) then
			destroyElement(itemsModels[itemInfo.ID])
		end
	elseif(string.lower(arg[1]) == "schowek") then
		if(exports.titan_bw:doesPlayerHaveBW(player)) then
			exports.titan_noti:showBox(player, "Nie możesz odkładać przedmiotów w trakcie stanu nieprzytomności.")
			return
		end

		local pDim = getElementDimension(player)
		if(pDim == 0) then
			exports.titan_noti:showBox(player, "Musisz być w interiorze, aby zostawić przedmiot w schowku.")
			return
		end

		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(pDim)
		if(not doorInfo) then
			exports.titan_noti:showBox(player, "Nie jesteś w żadnym interiorze.")
			return
		end

		if(not exports.titan_doors:doesPlayerHavePermToInterior(player, doorInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień.")
			return
		end

		if(not tonumber(arg[2])) then
			exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) schowek [ID przedmiotu]")
			return
		end
		arg[2] = tonumber(arg[2])

		local itemInfo = getItemInfo(arg[2])
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
			exports.titan_noti:showBox(player, "Ten przedmiot nie należy do Ciebie.")
			return
		end

		if(itemInfo.used == 1) then
			exports.titan_noti:showBox(player, "Przedmiot nie może być używany.")
			return
		end

		changeItemOwner(itemInfo.ID, 4, doorInfo.ID)
		exports.titan_chats:sendPlayerLocalMeRadius(player, "schował przedmiot do schowka.", 10.0)
		guiFunc.updatePlayerEquip(player)
	elseif(string.lower(arg[1]) == "odloz") then
		if(exports.titan_bw:doesPlayerHaveBW(player)) then
			exports.titan_noti:showBox(player, "Nie możesz odkładać przedmiotów w trakcie stanu nieprzytomności.")
			return
		end

		if(not tonumber(arg[2])) then
			exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) odloz [ID przedmiotu]")
			return
		end

		local itemInfo = getItemInfo(tonumber(arg[2]))
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
			exports.titan_noti:showBox(player, "Ten przedmiot nie należy do Ciebie.")
			return
		end

		if(itemInfo.used == 1) then
			exports.titan_noti:showBox(player, "Przedmiot nie może być używany.")
			return
		end

		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
				exports.titan_noti:showBox(player, "Ten pojazd nie został stworzony przez moduł systemu pojazdów.")
				return
			end
			changeItemOwner(itemInfo.ID, 3, getElementData(veh, "vehID"))
			exports.titan_chats:sendPlayerLocalMeRadius(player, "odłożył \""..string.lower(itemInfo.name).."\" w pojeździe.", 10.0)
			guiFunc.updatePlayerEquip(player)
			return
		end

		local pX, pY, pZ, rX, rY, rZ = getPotisionsForPlayerItem(player, itemInfo.type, itemInfo.val1)
		exports.titan_chats:sendPlayerLocalMeRadius(player, "odłożył \""..string.lower(itemInfo.name).."\" na ziemię.", 10.0)
		exports.titan_db:query_free("UPDATE _items SET ownerType = '0', owner = '0', slotID = '0', used = '0', x = ?, y = ?, z = ?, rx = ?, ry = ?, rz = ?, interior = ?, dimension = ? WHERE ID = ?", pX, pY, pZ, rX, rY, rZ, getElementInterior(player), getElementDimension(player), itemInfo.ID)
		createItemObject(itemInfo.ID, pX, pY, pZ, rX, rY, rZ, itemInfo.type, itemInfo.val1, getElementInterior(player), getElementDimension(player))

		setPedAnimation(player, "BOMBER", "BOM_Plant", -1, false, false, false, false)

		itemInfo.ownerType = 0
		itemInfo.owner = 0
		itemInfo.slot = 0
		itemInfo.x = pX
		itemInfo.y = pY
		itemInfo.z = pZ
		itemInfo.rx = rX
		itemInfo.ry = rY
		itemInfo.rz = rZ
		itemInfo.dimension = getElementDimension(player)
		itemInfo.interior = getElementInterior(player)
		guiFunc.updatePlayerEquip(player)
		return	
	--[[elseif(string.lower(arg[1]) == "p") then
		if(exports.titan_bw:doesPlayerHaveBW(player)) then
			exports.titan_noti:showBox(player, "Nie możesz podnosić przedmiotów w trakcie stanu nieprzytomności.")
			return
		end

		if(not tonumber(arg[2])) then
			if(isPedInVehicle(player)) then
				local veh = getPedOccupiedVehicle(player)
				if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
					exports.titan_noti:showBox(player, "Ten pojazd nie został stworzony przez moduł systemu pojazdów.")
					return
				end

				local tmpTable = getVehicleItems(getElementData(veh, "vehID"))
				if(not tmpTable) then
					exports.titan_noti:showBox(player, "Nie znaleziono żadnych przedmiotów w środku pojazdu.")
					return
				end
				outputChatBox("---=== PRZEDMIOTY W POJEŹDZIE ===---", player, 255, 0, 0)
					for k, v in ipairs(tmpTable) do
						outputChatBox(string.format("%s (UID: %d)", v.name, v.ID), player)
					end
				return
			end

			local tmpTable = getNearestPlayerItems(player)
			if(tmpTable and #tmpTable > 0) then
				outputChatBox("---=== PRZEDMIOTY W POBLIŻU ===---", player, 255, 0, 0)

				for k, v in ipairs(tmpTable) do
					outputChatBox(string.format("%s (UID: %d)", v.name, v.ID), player)
				end
			else
				exports.titan_noti:showBox(player, "Nie znaleziono żadnych przedmiotów w pobliżu.")
			end
			outputChatBox("TIP: /p(rzedmiot) podnies [ID przedmiotu]", player, 140, 140, 140)
			return
		end
		arg[2] = tonumber(arg[2])
		local itemInfo = getItemInfo(arg[2])
		if(not itemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o podanym ID.")
			return
		end

		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
				exports.titan_noti:showBox(player, "Ten pojazd nie został stworzony przez moduł systemu pojazdów.")
				return
			end

			if(itemInfo.ownerType ~= 3) then
				exports.titan_noti:showBox(player, "Ten przedmiot nie został znaleziony w pojeździe.")
				return
			end
			if(itemInfo.owner ~= getElementData(veh, "vehID")) then
				exports.titan_noti:showBox(player, "Ten przedmiot nie został znaleziony w pojeździe.")
				return
			end

			local itemSlot = getPlayerFreeSlotID(player)
			if(not itemSlot) then
				exports.titan_noti:showBox(player, "Nie posiadasz wolnego slotu w ekwipunku.")
				return
			end

			if(itemInfo.type == itemTypes.policeSiren) then
				if(getElementData(veh, "doesKogutActive")) then
					setElementData(veh, "doesKogutActive", false)
					local kogutElement = getElementData(veh, "kogutElement")
					if(isElement(kogutElement)) then
						destroyElement(kogutElement)
					end
				end
			end


			itemInfo.ownerType = 1
			itemInfo.owner = getElementData(player, "charID")
			itemInfo.slotID = itemSlot
			itemInfo.x = 0
			itemInfo.y = 0
			itemInfo.z = 0
			itemInfo.rx = 0
			itemInfo.ry = 0
			itemInfo.rz = 0
			itemInfo.interior = 0
			itemInfo.dimension = 0
			exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ?, slotID = ?, used = '0', x = '0', y = '0', z = '0', rx = '0', ry = '0', rz = '0', interior = '0', dimension = '0' WHERE ID = ?", itemInfo.ownerType, itemInfo.owner, itemInfo.slotID, itemInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, "podniósł "..string.lower(itemInfo.name).." z pojazdu.", 10.0)
			guiFunc.updatePlayerEquip(player)
			return
		end

		if(itemInfo.ownerType ~= 0) then
			exports.titan_noti:showBox(player, "Ten przedmiot należy do kogoś innego.")
			return
		end

		local pX, pY, pZ = getElementPosition(player)
		if(getDistanceBetweenPoints3D(pX, pY, pZ, itemInfo.x, itemInfo.y, itemInfo.z) > 3.0) then
			exports.titan_noti:showBox(player, "Ten przedmiot jest zbyt daleko od Ciebie.")
			return
		end

		local itemSlot = getPlayerFreeSlotID(player)
		if(not itemSlot) then
			exports.titan_noti:showBox(player, "Nie posiadasz wolnego slotu w ekwipunku.")
			return
		end

		itemInfo.ownerType = 1
		itemInfo.owner = getElementData(player, "charID")
		itemInfo.slotID = itemSlot
		itemInfo.x = 0
		itemInfo.y = 0
		itemInfo.z = 0
		itemInfo.rx = 0
		itemInfo.ry = 0
		itemInfo.rz = 0
		itemInfo.interior = 0
		itemInfo.dimension = 0

		exports.titan_chats:sendPlayerLocalMeRadius(player, "podniósł "..string.lower(itemInfo.name).." z ziemi.", 10.0)
		guiFunc.updatePlayerEquip(player)
		exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ?, slotID = ?, used = '0', x = '0', y = '0', z = '0', rx = '0', ry = '0', rz = '0', interior = '0', dimension = '0' WHERE ID = ?", itemInfo.ownerType, itemInfo.owner, itemInfo.slotID, itemInfo.ID)
		setPedAnimation(player, "BOMBER", "BOM_Plant", -1, false, false, false, false)

		if(isElement(itemsModels[itemInfo.ID])) then
			destroyElement(itemsModels[itemInfo.ID])
		end]]
	else
		exports.titan_noti:showBox(player, "TIP: /p(rzedmiot) ["..legend.."]")
		return
	end
end
addCommandHandler("p", cmdPrzedmiot, false, false)
addCommandHandler("przedmiot", cmdPrzedmiot, false, false)