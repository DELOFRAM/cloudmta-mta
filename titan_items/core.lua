----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 16:02:37
-- Ostatnio zmodyfikowano: 2016-01-10 15:25:04
----------------------------------------------------

itemTypes = {}
itemTypeFunc = {}


---------------------------------------------
-- BROŃ WYŁĄCZONA DLA ZWYKŁEGO UŻYTKOWNIKA --
---------------------------------------------

disabledWeapons = {}
--disabledWeapons[35] = true -- Wyrzutnia RPG
--disabledWeapons[36] = true -- Samonaprowadzająca bazooka
disabledWeapons[37] = true -- Miotacz ognia
disabledWeapons[38] = true -- Minigun

-----------------
-- BROŃ CIĘŻKA --
-----------------

heavyWeapons = {}
heavyWeapons[2] = true -- Kij Golfowy
heavyWeapons[5] = true -- Kij Baseballowy
heavyWeapons[6] = true -- Łopata
heavyWeapons[8] = true -- Katana
heavyWeapons[9] = true -- Piła Łańcuchowa
heavyWeapons[25] = true -- Strzelba
-- heavyWeapons[26] = true -- Obrzyn
heavyWeapons[27] = true -- SPAZ-12
heavyWeapons[29] = true -- MP5
heavyWeapons[30] = true -- AK-47
heavyWeapons[31] = true -- M4
heavyWeapons[33] = true -- Wiatrówka (Country Rifle)
heavyWeapons[34] = true -- Snajperka
heavyWeapons[35] = true -- Wyrzutnia RPG
heavyWeapons[36] = true -- Samonaprowadzająca bazooka
heavyWeapons[37] = true -- Miotacz ognia
heavyWeapons[38] = true -- Minigun
heavyWeapons[42] = true -- Gaśnica

itemTypes.weapon = 1
itemTypes.ammo = 2
itemTypes.clothes = 3
itemTypes.megaphone = 4
itemTypes.kevlar = 5
itemTypes.food = 6
itemTypes.body = 7
itemTypes.phone = 8
itemTypes.gloves = 9
itemTypes.key = 10
itemTypes.atmCard = 11
itemTypes.CD = 12
itemTypes.drugs = 13
itemTypes.taser = 14
itemTypes.attachedObject = 15
itemTypes.mask = 16
itemTypes.drivingLicense = 17
itemTypes.handCuff = 18
itemTypes.boombox = 19
itemTypes.policeSiren = 20
itemTypes.alcohol = 21
itemTypes.cube = 22
itemTypes.vehmTuning = 23
itemTypes.ramDoors = 24
itemTypes.money = 25
itemTypes.Diagnostics = 26
itemTypes.gymEntry = 27
itemTypes.vehiclePart = 28
itemTypes.vehRepair = 29

function getItemsOwner(ownerID,ownerType)
	local tmpTable = {}
	for k, v in ipairs(itemsData) do
		if (v ~= 0 and v.ownerType == tonumber(ownerType) ) then
			if(v.owner == tonumber(ownerID)) then
				table.insert(tmpTable, v)
			end
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function getPlayerItems(player)
	local tmpTable = {}
	for k, v in ipairs(itemsData) do
		if(v ~= 0 and v.ownerType == 1) then
			if(v.owner == getElementData(player, "charID")) then
				table.insert(tmpTable, v)
			end
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function getPlayerATMCards(player)
	local tmpTable = {}
	for k, v in ipairs(itemsData) do
		if(v ~= 0 and v.ownerType == 1 and v.type == itemTypes.atmCard) then
			if(v.owner == getElementData(player, "charID")) then
				table.insert(tmpTable, v)
			end
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function getUsedWeapons(player)
	if not isElement(player) then return false end
	local pItems = getPlayerItems(player)
	if #pItems == 0 then return 0 end
	local pUsedWeapons = 0
	for k, v in ipairs(pItems) do
		if v.type == itemTypes.weapon or v.type == itemTypes.taser then
			if v.used == 1 then pUsedWeapons = pUsedWeapons + 1 end
		end
	end
	return pUsedWeapons
end

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z
end

function getVehicleItems(vehID)
	local tmpTable = {}
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.ownerType == 3) then
				if(v.owner == vehID) then
					table.insert(tmpTable, v)
				end
			end
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function doesVehicleHasItemType(vehID, itemType)
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.ownerType == 3) then
				if(v.owner == vehID) then
					if(v.type == itemType) then return true end
				end
			end
		end
	end
	return false
end

function getInteriorItems(interiorID)
	local tmpTable = {}
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.ownerType == 4) then
				if(v.owner == interiorID) then
					table.insert(tmpTable, v)
				end
			end
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function getItemInfo(itemID)
	if(not itemsIndex[itemID]) then return false end
	return itemsData[itemsIndex[itemID]]
end

function doesPlayerHaveItemType(player, itemType)
	for k, v in ipairs(itemsData) do
		if(v ~= 0 and v.ownerType == 1 and v.owner == getElementData(player, "charID")) then
			if(v.type == itemType) then return true end
		end
	end
	return false
end

function itemCreate(ownerType, ownerUID, itemName, itemType, itemSlotID, itemVolume, itemVal1, itemVal2, itemVal3, playerDie)
	--if itemType == 11 then return false end
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _items SET name = ?, ownerType = ?, owner = ?, type = ?, slotID = ?, val1 = ?, val2 = ?, val3 = ?, volume = ?, created = UNIX_TIMESTAMP()", tostring(itemName), ownerType, ownerUID, itemType, itemSlotID, tostring(itemVal1), tostring(itemVal2), tostring(itemVal3), tonumber(itemVolume))
	if(tonumber(lastID)) then
		local index = getFreeTableIndex()
		itemsData[index] =
		{
			ID = lastID,
			name = itemName,
			ownerType = tonumber(ownerType),
			owner = tonumber(ownerUID),
			type = tonumber(itemType),
			slotID = itemSlotID,
			val1 = itemVal1,
			val2 = itemVal2,
			val3 = itemVal3,
			volume = tonumber(itemVolume),
			created = getRealTime().timestamp,
			lastUsed = 0,
			lastUsedID = 0,
			used = 0,
			x = x,
			y = y,
			z = z,
			rx = 0,
			ry = 0,
			rz = 0
		}

		itemsIndex[lastID] = index

		if isElement(playerDie) then
			local pX, pY, pZ, rX, rY, rZ = getPotisionsForPlayerItem(playerDie, itemType, itemVal1)
			createItemObject(lastID, pX, pY, pZ, rX, rY, rZ, itemType, itemVal1, getElementInterior(playerDie), getElementDimension(playerDie))
			itemsData[index].x = pX
			itemsData[index].y = pY
			itemsData[index].z = pZ
			itemsData[index].rx = rX
			itemsData[index].ry = rY
			itemsData[index].rz = rZ
			itemsData[index].dimension = playerDie:getDimension()
			itemsData[index].interior = playerDie:getInterior()
			exports.titan_db:query_free("UPDATE _items SET x = ?, y = ?, z = ?, rx = ?, ry = ?, rz = ?, dimension = ?, interior = ? WHERE ID = ?", pX, pY, pZ, rX, rY, rZ, playerDie:getDimension(), playerDie:getInterior(), lastID)
		end
		return true, lastID
	end
	return false
end

function playerUseItem(player, itemID, itemArg1)
	if exports.titan_bw:doesPlayerHaveBW(player) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Nie możesz używać przedmiotu w momencie trwania BW.")
		return false, 1
	end
	if getElementData(player, "driveBy") then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Nie możesz używać przedmiotu w trakcie trwania drive by.")
		return false, 1
	end
	local itemInfo = getItemInfo(itemID)
	if(not itemInfo) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Nie znaleziono podanego przemiotu.")
		return false, 1
	end

	if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
		return false, 2
	end

	if(itemInfo.type == itemTypes.weapon) then
		if player:getData("gym:training") then
			exports.titan_noti:showBox(player, "Nie możesz użyć broni w momencie treningu.")
			guiFunc.updatePlayerEquip(player)
		end
		if(itemInfo.used == 1) then
			itemInfo.used = 0
			takeWeapon(player, itemInfo.val1)
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s broń %s.", getElementData(player, "sex") == 1 and "schował" or "schowała", itemInfo.name), 10.0)
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
			guiFunc.updatePlayerEquip(player)
			removeElementData(player, "weaponID")
		else
			if player:getData("boomboxInHand") then
				exports.titan_noti:showBox(player, "Nie możesz użyć broni w momencie, gdy trzymasz boomboxa w ręku.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			if disabledWeapons[itemInfo.val1] and not exports.titan_admin:isPlayerAdmin(player) then
				removeItem(itemInfo.ID)
				exports.titan_noti:showBox(player, "Ta broń jest niedozwolona, więc została Ci ona zabrana.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			if(getSlotFromWeapon(itemInfo.val1) and getSlotFromWeapon(itemInfo.val1) ~= 1 and itemInfo.val2 <= 0) then
				exports.titan_noti:showBox(player, string.format("W broni %s skończyła się amunicja.", itemInfo.name))
				guiFunc.updatePlayerEquip(player)
				return
			end
			local pUsedWeapons = getUsedWeapons(player)
			if not pUsedWeapons or (tonumber(pUsedWeapons) and pUsedWeapons >= 3) then
				exports.titan_noti:showBox(player, "Można mieć użyte maksymalnie 3 bronie.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			local slot = getSlotFromWeapon(itemInfo.val1)
			if(not slot) then
				exports.titan_noti:showBox(player, "Niepoprawne ID broni.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			if(getPedWeapon(player, slot) ~= 0 and getPedTotalAmmo(player, slot) > 0) then
				exports.titan_noti:showBox(player, "Ten slot broni jest już zajęty.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			addPlayerUseDNA(player, itemInfo.ID)
			itemInfo.used = 1
			giveWeapon(player, itemInfo.val1, itemInfo.val2, true)
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s broń %s.", getElementData(player, "sex") == 1 and "wyciągnął" or "wyciągnęła", itemInfo.name), 10.0)
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, lastUsedHistory = ? WHERE ID = ?", itemInfo.used, getElementData(player, "charID"), toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
			if not isPedInVehicle(player) then
				if heavyWeapons[itemInfo.val1] then
					setPedAnimation(player, "CARRY", "liftup", 2000, false, false, false, false)
					-- exports.titan_anims:playerStartAnim(player, "podnies")
					-- setTimer(triggerEvent, 2000, 1, "playerStopAnim", player, player)
				else
					setPedAnimation(player, "KISSING", "gift_give", 3000, false, false, false, false)
					-- exports.titan_anims:playerStartAnim(player, "dajprezent")
					-- setTimer(triggerEvent, 2000, 1, "playerStopAnim", player, player)
				end
			end
			guiFunc.updatePlayerEquip(player)
			setElementData(player, "weaponID", itemInfo.val1)
		end
	elseif(itemInfo.type == itemTypes.ammo) then
		if(not tonumber(itemArg1)) then
			exports.titan_noti:showBox(player, "TIP: /p uzyj [ID przedmiotu magazynku] [ID przedmiotu broni]")
			guiFunc.updatePlayerEquip(player)
			return false
		end

		itemArg1 = tonumber(itemArg1)
		local weaponItemInfo = getItemInfo(itemArg1)
		if(not weaponItemInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu broni o podanym ID.")
			return false
		end

		if(weaponItemInfo.ownerType ~= 1 or weaponItemInfo.owner ~= getElementData(player, "charID")) then
			exports.titan_noti:showBox(player, "Podany przedmiot broni nie należy do Ciebie.")
			return
		end

		if(weaponItemInfo.type ~= 1) then
			exports.titan_noti:showBox(player, "Podany przedmiot nie jest bronią.")
			return false
		end

		if(weaponItemInfo.val1 ~= itemInfo.val1) then
			exports.titan_noti:showBox(player, "Amunicja nie pasuje do tej broni.")
			return false
		end

		if(weaponItemInfo.used == 1) then
			exports.titan_noti:showBox(player, "Broń nie może być używana.")
			return false
		end

		weaponItemInfo.val2 = weaponItemInfo.val2 + itemInfo.val2
		removeItem(itemInfo.ID)
		exports.titan_noti:showBox(player, string.format("Załadowano amunicję do broni %s.", weaponItemInfo.name))
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s amunicję w broni %s.", getElementData(player, "sex") == 1 and "przeładował" or "przeładowała", weaponItemInfo.name), 10.0)
	elseif(itemInfo.type == itemTypes.clothes) then
		if isPlayerUsingItemType(player, 3) and itemInfo.used == 0 then
			exports.titan_noti:showBox(player, "Używasz już jakiegoś ubrania.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if itemInfo.used == 1 then
			itemInfo.used = 0
			exports.titan_db:query_free("UPDATE _characters SET skin = ? WHERE ID = ?", getElementData(player, "defaultSkin"), getElementData(player, "charID"))
			exports.titan_db:query_free("UPDATE _items SET used = 0, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, lastUsedHistory = ? WHERE ID = ?", getElementData(player, "charID"), toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s się.", getElementData(player, "sex") == 1 and "przebrał" or "przebrała"), 10.0)
			setElementModel(player, getElementData(player, "defaultSkin"))
			guiFunc.updatePlayerEquip(player)
		else
			itemInfo.used = 1
			addPlayerUseDNA(player, itemInfo.ID)
			exports.titan_db:query_free("UPDATE _items SET used = 1, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, lastUsedHistory = ? WHERE ID = ?", getElementData(player, "charID"), toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
			exports.titan_db:query_free("UPDATE _characters SET skin = ? WHERE ID = ?", itemInfo.val1, getElementData(player, "charID"))
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s się.", getElementData(player, "sex") == 1 and "przebrał" or "przebrała"), 10.0)
			guiFunc.updatePlayerEquip(player)
			setElementModel(player, itemInfo.val1)
		end
	elseif(itemInfo.type == itemTypes.megaphone) then
		outputChatBox("TIP: /m(egafon) [treść]", player)
		guiFunc.updatePlayerEquip(player)
		return
	elseif(itemInfo.type == itemTypes.kevlar) then
		if(itemInfo.used == 1) then
			itemInfo.used = 0
			itemInfo.val1 = math.floor(getPedArmor(player))
			if(itemInfo.val1 <= 0) then
				exports.titan_noti:showBox(player, "Twoja kamizelka jest całkowicie zniszczona.")
				removeItem(itemInfo.ID)
				guiFunc.updatePlayerEquip(player)
				removeElementData(player, "player:kevlar")
				return
			end
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val1= ? WHERE ID = ?", itemInfo.used, getElementData(player, "charID"), itemInfo.val1, itemInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s kamizelkę kuloodporną.", getElementData(player, "sex") == 1 and "zdjął" or "zdjęła"), 10.0)
			setPedArmor(player, 0.0)
			guiFunc.updatePlayerEquip(player)
			removeElementData(player, "player:kevlar")
			return
		else
			if(itemInfo.val1 <= 0) then
				exports.titan_noti:showBox(player, "Twoja kamizelka jest całkowicie zniszczona.")
				removeItem(itemInfo.ID)
				guiFunc.updatePlayerEquip(player)
				return
			end
			if tonumber(getPlayerArmorUID(player)) then
				exports.titan_noti:showBox(player, "Posiadasz już kamizelkę kuloodporną w użyciu.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			addPlayerUseDNA(player, itemInfo.ID)
			itemInfo.used = 1
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val1 = ?, lastUsedHistory = ? WHERE ID = ?", itemInfo.used, getElementData(player, "charID"), itemInfo.val1, toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s kamizelkę kuloodporną.", getElementData(player, "sex") == 1 and "założył" or "założyła"), 10.0)
			setElementData(player, "player:kevlar", itemInfo.ID)
			setPedArmor(player, itemInfo.val1)
			guiFunc.updatePlayerEquip(player)
			return
		end
	elseif(itemInfo.type == itemTypes.food) then
		setPedAnimation(player, "FOOD", "EAT_Burger", -1, false, false, false, false)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s jedzenie (%s).", getElementData(player, "sex") == 1 and "spożył" or "spożyła", itemInfo.name), 10.0)
		setElementData(player, "hungryLevel", getElementData(player, "hungryLevel") + itemInfo.val1)
		if getElementData(player, "hungryLevel") > 100 then setElementData(player, "hungryLevel", 100) end
		exports.titan_db:query_free("UPDATE _characters SET hungryLevel = ? WHERE ID = ?", getElementData(player, "hungryLevel"), getElementData(player, "charID"))
		exports.titan_noti:showBox(player, "Spożywając jedzenie zapełniasz swój pasek głodu. Gdy jego wartość jest wyższa niż 90%, co kilka sekund odzyskujesz kilka procent swojego życia.")
		removeItem(itemInfo.ID, true)
		guiFunc.updatePlayerEquip(player)
	elseif(itemInfo.type == itemTypes.taser) then
		--if tonumber(player:getData("memberID")) == 3 then return exports.titan_noti:showBox(player, "Serio, spierdalaj Szychu.") end
		if(itemInfo.used == 1) then
			itemInfo.used = 0
			takeWeapon(player, itemInfo.val1)
			player:removeData("taserID")
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s %s.", getElementData(player, "sex") == 1 and "schował" or "schowała", itemInfo.name), 10.0)
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
			guiFunc.updatePlayerEquip(player)
		else
			if player:getData("boomboxInHand") then
				exports.titan_noti:showBox(player, "Nie możesz użyć broni w momencie, gdy trzymasz boomboxa w ręku.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			if(getSlotFromWeapon(itemInfo.val1) and getSlotFromWeapon(itemInfo.val1) ~= 1 and itemInfo.val2 <= 0) then
				exports.titan_noti:showBox(player, string.format("W urządzeniu wyczerpał się akumulator.", itemInfo.name))
				guiFunc.updatePlayerEquip(player)
				return
			end
			local slot = getSlotFromWeapon(itemInfo.val1)
			if(not slot) then
				exports.titan_noti:showBox(player, "Niepoprawne ID broni.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			if(getPedWeapon(player, slot) ~= 0 and getPedTotalAmmo(player, slot) > 0) then
				exports.titan_noti:showBox(player, "Ten slot broni jest już zajęty.")
				guiFunc.updatePlayerEquip(player)
				return
			end

			local taserID = getElementData(player, "taserID")
			if(tonumber(taserID)) then
				exports.titan_noti:showBox(player, "Używasz już innego paralizatora.")
				guiFunc.updatePlayerEquip(player)
				return
			end

			local pUsedWeapons = getUsedWeapons(player)
			if not pUsedWeapons or (tonumber(pUsedWeapons) and pUsedWeapons >= 3) then
				exports.titan_noti:showBox(player, "Można mieć użyte maksymalnie 3 bronie.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			addPlayerUseDNA(player, itemInfo.ID)
			itemInfo.used = 1
			giveWeapon(player, itemInfo.val1, itemInfo.val2, true)
			setElementData(player, "taserID", itemInfo.val1)
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s %s.", getElementData(player, "sex") == 1 and "wyciągnął" or "wyciągnęła", itemInfo.name), 10.0)
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, lastUsedHistory = ? WHERE ID = ?", itemInfo.used, getElementData(player, "charID"), toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
			guiFunc.updatePlayerEquip(player)
			
			if heavyWeapons[itemInfo.val1] then
				setPedAnimation(player, "CARRY", "liftup", 2000, false, false, false, false)
				-- exports.titan_anims:playerStartAnim(player, "podnies")
				-- setTimer(triggerEvent, 2000, 1, "playerStopAnim", player, player)
			else
				setPedAnimation(player, "KISSING", "gift_give", 3000, false, false, false, false)
				-- exports.titan_anims:playerStartAnim(player, "dajprezent")
				-- setTimer(triggerEvent, 2000, 1, "playerStopAnim", player, player)
			end
		end
	elseif(itemInfo.type == itemTypes.boombox) then
		guiFunc.closeEquip(player)
		local tmpTable = {}
		tmpTable.turnOn = itemInfo.used == 1 and true or false
		tmpTable.onGround = itemInfo.onGround and true or false
		tmpTable.inHand = itemInfo.inHand and true or false
		tmpTable.itemID = itemInfo.ID
		triggerClientEvent(player, "createBoomboxGUIMenu", player, tmpTable)
	elseif(itemInfo.type == itemTypes.CD) then
		if(string.len(tostring(itemInfo.val3)) < 3) then
			guiFunc.closeEquip(player)
			triggerClientEvent(player, "createCDGUIMenu", player, itemInfo.ID)
		else
			local ID = itemArg1
			if(not tonumber(ID)) then
				if isPedInVehicle(player) then
					local veh = getPedOccupiedVehicle(player)
					if exports.titan_vehicles:isVeh(veh) then
						if not exports.titan_vehicles:doesPlayerHaveDrivePerm(player, veh:getData("vehID")) then return exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień.") end
						local vehInfo = exports.titan_vehicles:getVehInfo(veh:getData("vehID"))
						if vehInfo.caraudio ~= 1 then return exports.titan_noti:showBox(player, "Pojazd nie posiada zamontowanego Car Audio.") end
						veh:setData("carAudio", itemInfo.val3)
						guiFunc.updatePlayerEquip(player)
						exports.titan_noti:showBox(player, "Płyta została umieszczona w Car Audio.")
						return
					end
				end
				guiFunc.updatePlayerEquip(player)
				exports.titan_noti:showBox(player, "Przeciągnij przedmiot płyty na boomboxa, aby jej użyć.")
				return
			end
			ID = tonumber(ID)

			local bItemInfo = getItemInfo(ID)
			if(not bItemInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o takim ID.")
				return
			end

			if(bItemInfo.ownerType ~= 1 or bItemInfo.owner ~= getElementData(player, "charID")) then
				exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
				return
			end

			if(bItemInfo.type ~= itemTypes.boombox) then
				exports.titan_noti:showBox(player, "Przedmiot nie jest boomboxem.")
				return
			end

			if(bItemInfo.used == 1) then
				exports.titan_noti:showBox(player, "Aby zmienić płytę musisz wyłączyć boomboxa.")
				return
			end
			bItemInfo.val1 = itemInfo.ID
			exports.titan_db:query_free("UPDATE _items SET val1 = ? WHERE ID = ?", itemInfo.ID, bItemInfo.ID)
			exports.titan_noti:showBox(player, "Płyta została umieszczona w boomboxie.")
			return
		end
	elseif(itemInfo.type == itemTypes.policeSiren) then
		exports.titan_noti:showBox(player, "Aby użyć koguta zostaw go w pojeździe i użyj komendy /v kogut.")
		guiFunc.updatePlayerEquip(player)
		return
	elseif(itemInfo.type == itemTypes.phone) then
		if(itemInfo.used == 1) then

			if(getElementData(player, "phoneState")) then
				exports.titan_noti:showBox(player, "Najpierw schowaj telefon.")
				guiFunc.updatePlayerEquip(player)
				return
			end

			if(phoneFunction.doesPlayerHaveConversation(player)) then
				exports.titan_noti:showBox(player, "Rozmawiasz teraz przez telefon.")
				guiFunc.updatePlayerEquip(player)
				return
			end

			exports.titan_noti:showBox(player, "Telefon został wyłączony.")
			itemInfo.used = 0
			exports.titan_db:query_free("UPDATE _items SET used = '0' WHERE ID = ?", itemInfo.ID)
			guiFunc.updatePlayerEquip(player)
			return
		else
			if(getPlayerUsedPhoneInfo(player)) then
				exports.titan_noti:showBox(player, "Można używać tylko jednego telefonu na raz.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			addPlayerUseDNA(player, itemInfo.ID)
			exports.titan_noti:showBox(player, "Telefon został włączony.")
			itemInfo.used = 1
			exports.titan_db:query_free("UPDATE _items SET used = '1', lastUsedHistory = ? WHERE ID = ?", toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
			guiFunc.updatePlayerEquip(player)
			return
		end
	elseif itemInfo.type == itemTypes.cube then
		local rand = math.random(1, itemInfo.val1)
		local letter = "oczko"
		if rand == 1 then letter = "oczko"
		elseif rand > 1 and rand < 5 then letter = "oczka"
		else letter = "oczek" end
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s kostką wyrzucając %d %s.", getElementData(player, "sex") == 1 and "rzucił" or "rzuciła", rand, letter), 10.0, false)
		guiFunc.updatePlayerEquip(player)
	elseif itemInfo.type == itemTypes.vehiclePart then
		exports.titan_noti:showBox(player, "To jest część do pojazdu. Musisz ja zamontować.")
		guiFunc.updatePlayerEquip(player)
	elseif itemInfo.type == itemTypes.vehRepair then
		exports.titan_noti:showBox(player, "To jest część do pojazdu. Musisz ja zamontować.")
		guiFunc.updatePlayerEquip(player)
	elseif itemInfo.type == itemTypes.attachedObject then
		if itemInfo.used == 1 then
			itemInfo.used = 0
			for k, v in pairs(getElementsByType("object")) do
				if getElementModel(v) == itemInfo.val1 and getElementData(v, "itemOwner") == player then
				destroyElement(v)
				break end
			end
			exports.titan_noti:showBox(player, "Zdjęto obiekt z ciała.")
		else
			guiFunc.closeEquip(player)
			triggerClientEvent(player, "createAttachMenu", player, itemInfo.ID, itemInfo.val2, itemInfo.val1)
			itemInfo.used = 1
		end
		guiFunc.updatePlayerEquip(player)
		return
	elseif itemInfo.type == itemTypes.vehmTuning then
		--exports.titan_noti:showBox(player, "Dupka.")
		guiFunc.updatePlayerEquip(player)
		return
	elseif itemInfo.type == itemTypes.ramDoors then
		local doorID = player:getData("nearestDoorID")
		if not tonumber(doorID) then
			exports.titan_noti:showBox(player, "Musisz być obok drzwi, aby użyć tego przedmiotu.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		local pickInfo = exports.titan_doors:getPickupInfo(doorID)
		if not pickInfo then
			exports.titan_noti:showBox(player, "Coś poszło nie tak.")
			guiFunc.updatePlayerEquip(player)
			return
		end

		if pickInfo.locked == 0 then
			exports.titan_noti:showBox(player, "Drzwi są otwarte.")
			guiFunc.updatePlayerEquip(player)
			return
		end

		exports.titan_doors:changePickupData(doorID, "locked", 0)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s drzwi za pomocą łomu.", getElementData(player, "sex") == 1 and "wyważył" or "wyważyła"), 10.0)
		itemInfo.val1 = itemInfo.val1 - 1
		if itemInfo.val1 <= 0 then
			exports.titan_noti:showBox(player, "Przedmiot zniszczył się.")
			removeItem(itemInfo.ID)
		else 
			addPlayerUseDNA(player, itemInfo.ID)
			exports.titan_db:query_free("UPDATE _items SET lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val1 = ?, lastUsedHistory = ? WHERE ID = ?", getElementData(player, "charID"), itemInfo.val1, toJSON(itemInfo.lastUsedHistory), itemInfo.ID)
		end

		guiFunc.updatePlayerEquip(player)
		return
	elseif itemInfo.type == itemTypes.body then
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)
		if not playerDuty then
			exports.titan_noti:showBox(player, "Musisz być na duty grupy.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "bodies") then
			exports.titan_noti:showBox(player, "Nie posiadasz dostępu do badania zwłok.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if not tonumber(itemInfo.val1) then
			exports.titan_noti:showBox(player, "Te zwłoki są uszkodzone.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		local bInfo = getBodyInfo(tonumber(itemInfo.val1))
		if not bInfo then
			exports.titan_noti:showBox(player, "Te zwłoki są uszkodzone.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		guiFunc.closeEquip(player)
		triggerClientEvent(player, "bodyGUI.create", player, bInfo.name, bInfo.killTime, bInfo.DNA, bInfo.killerDNA, bInfo.weaponID, bInfo.weaponData, bInfo.location)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s zwłoki.", getElementData(player, "sex") == 1 and "zbadał" or "zbadała"), 10.0)
	elseif itemInfo.type == itemTypes.gloves then
		addPlayerUseDNA(player, itemInfo.ID)
		if itemInfo.val1 <= 0 then
			exports.titan_noti:showBox(player, "Przedmiot zniszczył się.")
			removeItem(itemInfo.ID)
			player:removeData("gloves")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if itemInfo.used == 1 then
			player:removeData("gloves")
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s rękawiczki z rąk.", getElementData(player, "sex") == 1 and "ściągnął" or "ściągnęła"), 10.0)
			itemInfo.used = 0
			guiFunc.updatePlayerEquip(player)
			return
		else
			if doesPlayerUsingGloves(player) then
				exports.titan_noti:showBox(player, "Masz już rękawiczki na rękach.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s rękawiczki na ręce.", getElementData(player, "sex") == 1 and "założył" or "założyła"), 10.0)
			player:setData("gloves", true)
			itemInfo.val1 = itemInfo.val1 - 1
			exports.titan_db:query_free("UPDATE _items SET lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val1 = ? WHERE ID = ?", getElementData(player, "charID"), itemInfo.val1, itemInfo.ID)
			itemInfo.used = 1
			guiFunc.updatePlayerEquip(player)
			return
		end


	elseif itemInfo.type == itemTypes.mask then
		if itemInfo.val1 <= 0 then
			exports.titan_noti:showBox(player, "Przedmiot zniszczył się.")
			removeItem(itemInfo.ID)
			player:removeData("mask")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if itemInfo.used == 1 then
			player:removeData("mask")
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s maskę z twarzy.", getElementData(player, "sex") == 1 and "ściągnął" or "ściągnęła"), 10.0)
			itemInfo.used = 0
			guiFunc.updatePlayerEquip(player)
			return
		else
			if doesPlayerUsingMask(player) then
				exports.titan_noti:showBox(player, "Masz już maskę na sobie.")
				guiFunc.updatePlayerEquip(player)
				return
			end
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s maskę na twarz.", getElementData(player, "sex") == 1 and "założył" or "założyła"), 10.0)
			player:setData("mask", true)
			itemInfo.val1 = itemInfo.val1 - 1
			exports.titan_db:query_free("UPDATE _items SET lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val1 = ? WHERE ID = ?", getElementData(player, "charID"), itemInfo.val1, itemInfo.ID)
			itemInfo.used = 1
			guiFunc.updatePlayerEquip(player)
			return
		end
	elseif itemInfo.type == itemTypes.alcohol then
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("wypił %s", itemInfo.name), 10.0)
		exports.titan_noti:showBox(player, string.format("Wypiłeś %s", itemInfo.name))
		removeItem(itemInfo.ID, true)
		triggerEvent("setDrunkLevel", player, itemInfo.val1, itemInfo.val2)
	-- elseif itemInfo.type == itemTypes.ID then
		-- if type(player:getData("ssn")) ~= "table" then return exports.titan_noti:showBox(player, "Nie posiadasz dowodu osobistego.") end
		-- guiFunc.closeEquip(player)
		-- local data = {}
		-- local bDate = player:getData("birthday")
		-- local ssn = player:getData("ssn")
		-- local cDate = getRealTime(ssn[2])
		-- table.insert(data, {"Nazwisko", player:getData("lastname")})
		-- table.insert(data, {"Imię", player:getData("name")})
		-- table.insert(data, {"Płeć", player:getData("sex") == 1 and "Mężczyzna" or player:getData("sex") == 2 and "Kobieta" or "Nieznana"})
		-- table.insert(data, {"Data urodzenia", string.format("%0.2d.%0.2d.%0.4dr", bDate.day, bDate.month, bDate.year)})
		-- table.insert(data, {"Numer SSN", ssn[1]})
		-- table.insert(data, {"Data wydania dowodu", string.format("%0.2d.%0.2d.%0.4dr", cDate.monthday, cDate.month, cDate.year + 1900)})
		-- table.insert(data, {"Miejsce urodzenia", getElementData(player, "birthplace")})
		-- table.insert(data, {"Kolor oczu", getElementData(player, "eyes") == 1 and "Zielone" or getElementData(player, "eyes") == 2 and "Niebieskie" or getElementData(player, "eyes") == 1 and "Brązowe"})
		-- table.insert(data, {"Wzrost", getElementData(player, "height")})
		-- triggerClientEvent(player, "ssnFunc.create", player, "Dowód osobisty", data)
	elseif itemInfo.type == itemTypes.handCuff then
		exports.titan_noti:showBox(player, "/skuj [ID gracza]")
		guiFunc.updatePlayerEquip(player)
		return
	elseif itemInfo.type == itemTypes.drugs then
		outputChatBox("DEBUG: DO OSKRYPTOWANIA", player)
		guiFunc.updatePlayerEquip(player)
		return
	elseif itemInfo.type == itemTypes.money then
		exports.titan_noti:showBox(player, string.format("Przekonwertowałeś %s na gotówkę In Game.", itemInfo.name))
		exports.titan_cash:addPlayerCash(player, itemInfo.val1)
		removeItem(itemInfo.ID, true)
		guiFunc.updatePlayerEquip(player)
		return
	elseif itemInfo.type == itemTypes.Diagnostics then
		return exports.titan_noti:showBox(player, "Przedmiot w przygotowaniu.")
	elseif itemInfo.type == itemTypes.key then
		return exports.titan_chats:sendPlayerLocalMeRadius(player,"spogląda na klucze.", 10.0)
	else
		exports.titan_noti:showBox(player, "Nieznany typ przedmiotu.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	return true, itemInfo
end

function takeItemFromPlayer(player, fromPlayer, itemID)
	if exports.titan_login:isLogged(player) and exports.titan_login:isLogged(fromPlayer) then
		local itemInfo = getItemInfo(itemID)
		if not itemInfo then return false end
		if itemInfo.ownerType ~= 1 or itemInfo.owner ~= fromPlayer:getData("charID") then return false end
		
	end
	return false
end

function changeItemOwner(itemID, ownerType, owner)
	exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ? WHERE ID = ?", ownerType, owner, itemID)
	local index = itemsIndex[itemID]
	if(tonumber(index)) then
		itemsData[index].ownerType = ownerType
		itemsData[index].owner = owner
	end
	return true
end

function changeItemSlot(itemID, slotID)
	exports.titan_db:query_free("UPDATE _items SET slotID = ? WHERE ID = ?", slotID, itemID)
	local index = itemsIndex[itemID]
	if(tonumber(index)) then
		itemsData[index].slotID = slotID
	end
	return true
end

function playerAllItemsOnGround(player)
	if exports.titan_login:isLogged(player) then
		local items = getPlayerItems(player)
		if items then
			for k, v in pairs(items) do
				if v.used == 1 then
					v.used = 0
					exports.titan_db:query("UPDATE _items SET used = '0' WHERE ID = ?", v.val1, v.ID)
				end
				local pX, pY, pZ, rX, rY, rZ = getPotisionsForPlayerItem(player, v.type, v.val1)
				exports.titan_db:query_free("UPDATE _items SET ownerType = '0', owner = '0', slotID = '0', used = '0', x = ?, y = ?, z = ?, rx = ?, ry = ?, rz = ?, interior = ?, dimension = ? WHERE ID = ?", pX, pY, pZ, rX, rY, rZ, getElementInterior(player), getElementDimension(player), v.ID)
				createItemObject(v.ID, pX, pY, pZ, rX, rY, rZ, v.type, v.val1, getElementInterior(player), getElementDimension(player))
				v.ownerType = 0
				v.owner = 0
				v.slot = 0
				v.x = pX
				v.y = pY
				v.z = pZ
				v.rx = rX
				v.ry = rY
				v.rz = rZ
				v.dimension = getElementDimension(player)
				v.interior = getElementInterior(player)
			end
		end
	end
end

function disarmPlayer(player)
	player:removeData("taserID")
	player:removeData("mask")
	player:removeData("boomboxID")
	for k, v in ipairs(itemsData) do
		if(v ~= 0 and v.ownerType == 1 and v.owner == getElementData(player, "charID")) then
			if(v.type == itemTypes.weapon or v.type == itemTypes.taser) then
				if(v.used == 1) then
					itemsData[k].used = 0
					exports.titan_db:query_free("UPDATE _items SET val2 = ?, used = '0' WHERE ID = ?", getPedTotalAmmo(player, getSlotFromWeapon(v.val1)), v.ID)
					takeWeapon(player, v.val1)
				end
			elseif(v.type == itemTypes.boombox) then
				if(v.used == 1) then
					if(isElement(v.boomboxObject)) then destroyElement(v.boomboxObject) end
					if(isTimer(v.timer)) then killTimer(v.timer) end
					v.inHand = false
					v.onGround = false
					v.used = 0
					exports.titan_db:query("UPDATE _items SET used = '0' WHERE ID = ?", v.val1, v.ID)
				end
			elseif v.type == itemTypes.kevlar then
				if v.used == 1 then
					setPedArmor(player, 0)
					v.used = 0
					exports.titan_db:query("UPDATE _items SET used = '0' WHERE ID = ?",  v.ID)
					removeElementData(player, "player:kevlar")
				end
			elseif v.type == itemTypes.Mask then
				if v.used == 1 then
					v.used = 0
					player:removeData("Mask")
					exports.titan_db:query("UPDATE _items SET used = '0' WHERE ID = ?",  v.ID)
				end
			elseif v.type == itemTypes.mask then
				v.used = 0
				player:removeData("mask")
				exports.titan_db:query("UPDATE _items SET used = '0' WHERE ID = ?", v.ID)
			end
		end
	end
end

function removeItem(itemID, hardRemove)
	if not hardRemove then
		exports.titan_db:query_free("UPDATE _items SET destroyed = '1' WHERE ID = ?", itemID)
	else
		exports.titan_db:query_free("DELETE FROM _items WHERE ID = ?", itemID)
	end
	if(tonumber(itemsIndex[itemID])) then
		if(type(itemsData[itemsIndex[itemID]]) == "table") then
			itemsData[itemsIndex[itemID]] = 0
			itemsIndex[itemID] = 0
		end
	end
end

function getPlayerFreeSlotID(player)
	local time = getTickCount()
	if(not exports.titan_login:isLogged(player)) then return false end

	local items = getPlayerItems(player)
	if not items then return 1 end
	if #items >= 35 then return false end
	local tmpTable = {}
	for k, v in ipairs(items) do
		if tonumber(v.slotID) then
			tmpTable[v.slotID] = true
		end
	end
	for i = 1, 35 do
		if not tmpTable[i] then return i end
	end
	return false
end

function isPlayerHaveFreeSlot(player, slotID)
	local query = exports.titan_db:query("SELECT ID FROM _items WHERE ownerType = 1 AND owner = ? AND slotID = ? AND destroyed = 0", player:getData("charID"), tonumber(slotID))
	if #query <= 0 then return true else return false end
end

function getPhoneItemFromNumber(number)
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.type == itemTypes.phone and v.used == 1 and v.ownerType == 1) then
				if(v.val1 == number) then return v end
			end
		end
	end
	return false
end

function getPhoneItemFromNumber2(number)
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.type == itemTypes.phone and v.ownerType == 1) then
				if(v.val1 == number) then return v end
			end
		end
	end
	return false
end

function getPlayerArmorUID(player)
	--local playerID = getElementData(player, "charID")
	--local res = exports.titan_db:query("SELECT ID FROM _items WHERE type = ? AND ownerType = '1' AND owner = ? AND used = '1'", itemTypes.kevlar, playerID)
	--if #res > 0 then
	--	res = res[1]
	--	return res.ID
	--end
	local armorUID = getElementData(player, "player:kevlar")
	if tonumber(armorUID) then return armorUID end
	return false
end

function callTo911()
	exports.titan_orgs:createAlarmPhoneGUI(source)
	setElementData(source, "ediall", getPlayerUsedPhoneInfo(source))
end
addEvent("callTo911", true)
addEventHandler("callTo911", root, callTo911)

function callTo4444()
	triggerClientEvent(source, "showGUI.c", source)
	setElementData(source, "ddiall", getPlayerUsedPhoneInfo(source))
end
addEvent("callTo4444", true)
addEventHandler("callTo4444", root, callTo4444)

function doesPlayerUsingMask(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	local playerItems = getPlayerItems(player)
	if(not playerItems) then return false end
	for k, v in pairs(playerItems) do
		if(v.type == itemTypes.Mask and v.used == 1) then return true end
	end
	return false
end

function getPlayerVehiclePart(player, partName)
	local playerItems = getPlayerItems(player)
	if not playerItems then return false end
	for k, v in pairs(playerItems) do
		if v.type == itemTypes.vehRepair and v.val3 == partName then return v end
	end
	return false
end

function doesPlayerUsingGloves()
	if(not exports.titan_login:isLogged(player)) then return false end
	local playerItems = getPlayerItems(player)
	if(not playerItems) then return false end
	for k, v in pairs(playerItems) do
		if(v.type == itemTypes.Gloves and v.used == 1) then return true end
	end
	return false
end

function getBodyInfo(bodyID)
	if not tonumber(bodyID) then return false end
	bodyID = tonumber(bodyID)
	local query = exports.titan_db:query("SELECT * FROM _corpses WHERE ID = ? LIMIT 1", bodyID)
	if not query or #query <= 0 then return false end
	return query[1]
end

function getPlayerUsedGunWeaponIDVal3(player, weaponID)
	if not exports.titan_login:isLogged(player) then return false end
	for k, v in ipairs(getPlayerItems(player)) do
		if v.type == itemTypes.weapon then
			if v.val1 == weaponID then
				if v.used == 1 then return v.val3 end
			end
		end
	end
	return false
end

function addPlayerUseDNA(player, itemID)
	if exports.titan_login:isLogged(player) then
		local itemInfo = getItemInfo(itemID)
		if itemInfo then
			local playerDNA = player:getData("DNA")
			if player:getData("gloves") then
				playerDNA = string.sub( playerDNA, 1, math.random( string.len(playerDNA)/2, string.len(playerDNA) ) )
			end
			if type(itemInfo.lastUsedHistory) ~= "table" then itemInfo.lastUsedHistory = {} end
			if itemInfo.lastUsedHistory[#itemInfo.lastUsedHistory] ~= playerDNA then
				if #itemInfo.lastUsedHistory > 10 then
					table.remove(itemInfo.lastUsedHistory, 1)
				end
				table.insert(itemInfo.lastUsedHistory, playerDNA)
			end
		end
	end
end

function isPlayerUsingItemType(player, itemType)
	if not player then return false end
	if not itemType then return false end
	local que = exports.titan_db:query("SELECT * FROM _items WHERE ownerType = 1 AND owner = ? AND used = 1 AND type = ?", getElementData(player, "charID"), itemType)
	if #que <= 0 then return false end
	return true
end

function saveAttachItemPos(player, itemID, x, y, z, rx, ry, rz)
	if not exports.titan_login:isLogged(player) then return end
	local itemInfo = getItemInfo(itemID)
	if not itemInfo then return exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.") end
	if itemInfo.ownerType ~= 1 or itemInfo.owner ~= player:getData("charID") then return exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.") end
	itemInfo.val3 = toJSON({x, y, z, rx, ry, rz})
	exports.titan_db:query_free("UPDATE _items SET val3 = ? WHERE ID = ?", itemInfo.val3, itemInfo.ID)
	exports.titan_noti:showBox(player, "Pozycja została pomyślnie zapisana.")
end
addEvent("saveAttachItemPos", true)
addEventHandler("saveAttachItemPos", root, saveAttachItemPos)

function takeAttachedItemOn(player, itemID)
	if not exports.titan_login:isLogged(player) then return end
	local itemInfo = getItemInfo(itemID)
	if not itemInfo then return exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.") end
	if itemInfo.ownerType ~= 1 or itemInfo.owner ~= player:getData("charID") then return exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.") end
	local pos = fromJSON(itemInfo.val3)
	if type(pos) ~= "table" then return exports.titan_noti:showBox(player, "Najpierw ustal pozycję na ciele.") end

	local object = createObject(itemInfo.val1, 0, 0, 0)
	exports.titan_boneAttach:attachElementToBone(object, player, itemInfo.val2, pos[1], pos[2], pos[3], pos[4], pos[5], pos[6])
	exports.titan_noti:showBox(player, "Pomyślnie założono przedmiot.")
end
addEvent("takeAttachedItemOn", true)
addEventHandler("takeAttachedItemOn", root, takeAttachedItemOn)

function triggerKillPed(ped, attacker, weapon, bodypart)
	killPed(ped, attacker, weapon, bodypart)
end
addEvent("triggerKillPed", true)
addEventHandler("triggerKillPed", root, triggerKillPed)