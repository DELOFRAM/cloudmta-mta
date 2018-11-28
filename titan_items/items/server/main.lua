itemsData = {}
itemsIndex = {}
itemsModels = {}

function loadItems()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _items WHERE destroyed = 0")
	for k, v in ipairs(query) do
		local index = #itemsData + 1
		itemsData[index] = v
		itemsIndex[v.ID] = index
		if itemsData[index].lastUsedHistory then
			itemsData[index].lastUsedHistory = fromJSON(itemsData[index].lastUsedHistory)
		else
			itemsData[index].lastUsedHistory = {}
		end
		if type(itemsData[index].lastUsedHistory) ~= "table" then
			itemsData[index].lastUsedHistory = {}
		end
		if(v.ownerType == 0 and v.x and v.y and v.z) then
			createItemObject(v.ID, v.x, v.y, v.z, v.rx, v.ry, v.rz, v.type, v.val1, v.interior, v.dimension)
		end
	end
	outputDebugString(string.format("[ITEMS] Załadowano przedmioty (%d). | %d ms", #query, getTickCount() - time))

	for k, v in ipairs(getElementsByType("player")) do
		bindKey(v, "r", "down", reloadWeapon)
		bindKey(v, "i", "down", "plista")
		bindKey(v, "end", "down", "tel")
	end
end
addEventHandler("onResourceStart", resourceRoot, loadItems)

local function playerJoinFunc()
	bindKey(source, "r", "down", reloadWeapon)
	bindKey(source, "i", "down", "plista")
	bindKey(source, "end", "down", "tel")
end
addEventHandler("onPlayerJoin", root, playerJoinFunc)

function reloadWeapon(player)
	reloadPedWeapon(player)
end

function createItemObject(itemID, x, y, z, rx, ry, rz, typ, val1, interior, dimension)
	if(typ == itemTypes.weapon or typ == itemTypes.taser) then
		local weapModel = getWeaponModel(val1)
		if(weapModel) then
			if(isElement(itemsModels[itemID])) then destroyElement(itemsModels[itemID]) end
			itemsModels[itemID] = createObject(weapModel, x, y, z, rx, ry, rz)
			if(isElement(itemsModels[itemID])) then
				setElementInterior(itemsModels[itemID], interior)
				setElementDimension(itemsModels[itemID], dimension)
				setElementData(itemsModels[itemID], "isItem", true)
				setElementData(itemsModels[itemID], "itemID", itemID)
			end
		end
	else
		if(type(itemObjects[typ]) == "table") then
			if(isElement(itemsModels[itemID])) then destroyElement(itemsModels[itemID]) end
			itemsModels[itemID] = createObject(itemObjects[typ].object, x, y, z, rx, ry, rz)
			if(isElement(itemsModels[itemID])) then
				setElementInterior(itemsModels[itemID], interior)
				setElementDimension(itemsModels[itemID], dimension)

				setElementCollisionsEnabled(itemsModels[itemID], not itemObjects[typ].turnOffCollisions)
				setObjectScale(itemsModels[itemID], itemObjects[typ].scale)
			end
		end
	end
end

function getPotisionsForPlayerItem(player, itemType, itemVal1)
	local pX, pY, pZ = getElementPosition(player)
	if(type(itemObjects[itemType]) == "table") then
		return pX + itemObjects[itemType].pos.x, pY + itemObjects[itemType].pos.y, pZ + itemObjects[itemType].pos.z, itemObjects[itemType].pos.rotx, itemObjects[itemType].pos.roty, itemObjects[itemType].pos.rotz
	end
	return false
end

function getWeaponModel(weaponid)
	if(weaponid == 1) then return 331 end --kastet
	if(weaponid == 2) then return 333 end --kij golfowy
	if(weaponid == 3) then return 334 end --pałka policyjna
	if(weaponid == 4) then return 335 end --nóz
	if(weaponid == 5) then return 336 end --kij do baseballa
	if(weaponid == 6) then return 337 end --łopata
	if(weaponid == 7) then return 338 end --kij bilardowy
	if(weaponid == 8) then return 339 end --katana
	if(weaponid == 9) then return 341 end --piła
	if(weaponid >= 22 and weaponid <= 29) then return tonumber(weaponid) + 324 end
	if(weaponid == 30 or weaponid == 31) then return tonumber(weaponid) + 325 end
	if(weaponid == 32) then return 372 end
	if(weaponid >= 33 and weaponid <= 45) then return tonumber(weaponid) + 324 end
	if(weaponid == 16) then return 342 end --granat
	if(weaponid == 17) then return 343 end --gaz łzawiący
	if(weaponid == 18) then return 344 end --koktajl
	if(weaponid == 10) then return 321 end --dildo
	if(weaponid == 11) then return 322 end --dildo
	if(weaponid == 12) then return 323 end --wibrator
	if(weaponid == 14) then return 325 end --kwiatki
	if(weaponid == 15) then return 326 end --laska
	return false
end

function getNearestPlayerItems(player)
	if(not isElement(player)) then return false end
	local pX, pY, pZ = getElementPosition(player)
	local tmpTable = {}
	local interior = getElementInterior(player)
	local dimension = getElementDimension(player)
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.ownerType == 0) then
				if(v.interior == interior and v.dimension == dimension) then
					if v.x and v.y and v.z then
						local dist = getDistanceBetweenPoints3D(pX, pY, pZ, v.x, v.y, v.z)
						if(tonumber(dist) and dist < 3.0) then
							table.insert(tmpTable, v)
						end
					else
						outputDebugString(string.format("[ITEMS] Przedmiot o ID %d leżący na ziemi nie posiada nadanych X Y i Z!", v.ID))
					end
				end
			end
		end
	end
	return tmpTable
end

function getPlayerUsedWeaponItem(player, weaponID)
	for k, v in ipairs(itemsData) do
		if(v ~= 0 and v.ownerType == 1 and v.owner == getElementData(player, "charID")) then
			if(v.type == itemTypes.weapon) then
				if(v.used == 1) then
					if(v.val1 == weaponID) then return k end
				end
			end
		end
	end
	return false
end

function getPlayerUsedTaserItem(player, weaponID)
	for k, v in ipairs(itemsData) do
		if(v ~= 0 and v.ownerType == 1 and v.owner == getElementData(player, "charID")) then
			if(v.type == itemTypes.taser) then
				if(v.used == 1) then
					if(v.val1 == weaponID) then return k end
				end
			end
		end
	end
	return false
end

function getFreeTableIndex()
	local i = 1
	while(true) do
		if(type(itemsData[i]) ~= "table") then return i end
		i = i + 1
	end
	return false
end

function getPlayerUsedPhoneInfo(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	local playerItems = getPlayerItems(player)
	if(not playerItems) then return false end
	for k, v in pairs(playerItems) do
		if(v.type == itemTypes.phone and v.used == 1) then return v end
	end
	return false
end

------------
-- EVENTY --
------------

function onPlayerWeapFire(weapon)
	local taserID = getElementData(source, "taserID")
	if(tonumber(taserID) and taserID == weapon) then
		local taserItem = getPlayerUsedTaserItem(source, weapon)
		if(not taserItem) then
			exports.titan_noti:showBox(source, "Nie znaleziono takiego tasera w Twoim ekwipunku. Został Ci on zabrany.")
			takeWeapon(source, weapon)
			setElementData(source, "taserID", false)
			return
		end

		local slot = getSlotFromWeapon(itemsData[taserItem].val1)
		if(slot ~= 1 and slot ~= 0) then
			itemsData[taserItem].val2 = itemsData[taserItem].val2 - 1
			setWeaponAmmo(source, weapon, itemsData[taserItem].val2)
		end

		if(itemsData[taserItem].val2 <= 0) then
			exports.titan_noti:showBox(source, string.format("Akumulator w \"%s\" wyczerpał się.", itemsData[taserItem].name))
			takeWeapon(source, weapon)
			itemsData[taserItem].used = 0
			setElementData(source, "taserID", false)
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val2 = '0' WHERE ID = ?", 0, getElementData(source, "charID"), itemsData[taserItem].ID)
			return
		end
	else
		local weaponItem = getPlayerUsedWeaponItem(source, weapon)
		if(not weaponItem) and not getElementData(source, "weaponID") then
			exports.titan_noti:showBox(source, "Nie znaleziono takiej broni w Twoim ekwipunku. Została Ci ona zabrana.")
			takeWeapon(source, weapon)
			return
		end

		local slot = getSlotFromWeapon(itemsData[weaponItem].val1)
		if(slot ~= 1 and slot ~= 0) then
			itemsData[weaponItem].val2 = itemsData[weaponItem].val2 - 1
			setWeaponAmmo(source, weapon, itemsData[weaponItem].val2)
		end

		if(itemsData[weaponItem].val2 <= 0) then
			exports.titan_noti:showBox(source, string.format("Amunicja w broni (%s) skończyła się.", itemsData[weaponItem].name))
			takeWeapon(source, weapon)
			itemsData[weaponItem].used = 0
			exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ?, val2 = '0' WHERE ID = ?", 0, getElementData(source, "charID"), itemsData[weaponItem].ID)
			return
		end
	end
	return
end
addEvent("onPlayerWeapFire", true)
addEventHandler("onPlayerWeapFire", root, onPlayerWeapFire)

function playerDmg(attacker)
	if exports.titan_login:isLogged(source) then
		if isElement(attacker) then
			local armor = getPedArmor(source)
			local armorUID = getPlayerArmorUID(source)
			if not armorUID then
				setPedArmor(source, 0)
			else
				if armor <= 0 then
					exports.titan_noti:showBox(source, "Kamizelka została zniszczona.")
					local armorInfo = getItemInfo(armorUID)
					if armorInfo then
						armorInfo.used = 0
						exports.titan_db:query("UPDATE _items SET used = '0' WHERE ID = ?", armorUID)
						-- dodałem usuwanie przedmiotu permanentne w komentarzu // Tost
						-- dodałem usuwanie przedmiotu permanentne w komentarzu // Tost
						-- dodałem usuwanie przedmiotu permanentne w komentarzu // Tost
						-- dodałem usuwanie przedmiotu permanentne w komentarzu // Tost
						-- dodałem usuwanie przedmiotu permanentne w komentarzu // Tost
						removeItem(armorUID)
					end
				end
			end
		end
	end
end
addEventHandler("onPlayerDamage", root, playerDmg)

function synchronizeBoomboxesToPlayer(player)
	for k, v in ipairs(itemsData) do
		if(v ~= 0) then
			if(v.type == itemTypes.boombox) then
				if(v.used == 1) then
					if(isElement(v.boomboxObject)) then
						if(tonumber(v.val1) and tonumber(v.val1) > 0) then
							local cdItemInfo = getItemInfo(v.val1)
							if(cdItemInfo) then
								if(string.len(tostring(cdItemInfo.val3)) > 4) then
									triggerClientEvent(player, "setMusicToElementModel", player, v.boomboxObject, cdItemInfo.val3)
								end
							end
						end
					end
				end
			end
		end
	end
end

function onResStop()
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			disarmPlayer(v)
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, onResStop)



---------
-- GUI --
---------
guiFunc = {}

function guiFunc.updatePlayerEquip(player)
	triggerEvent("hud.items.s", player)
	if(getElementData(player, "itemGUIOpened")) then
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
		triggerClientEvent(player, "updatePlayerItems", player, playerItems, nearestItems)
	end
end
addEvent("guiFunc.updatePlayerEquip", true)
addEventHandler("guiFunc.updatePlayerEquip", root, guiFunc.updatePlayerEquip)


addEvent("updatePlayerEquip", true)
addEventHandler("updatePlayerEquip", root, guiFunc.updatePlayerEquip)

function guiFunc.throwItem(player, itemID)
	if not exports.titan_login:isLogged(player) then return end
	local itemInfo = getItemInfo(itemID)
	if not itemInfo then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	if itemInfo.ownerType ~= 1 or itemInfo.owner ~= player:getData("charID") then
		exports.titan_noti:showBox(player, "Ten przedmiot nie należy do Ciebie.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	if itemInfo.used == 1 then
		exports.titan_noti:showBox(player, "Przedmiot nie może być używany.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	
	if itemInfo.type == 18 and isElement(getElementData(player, "cuffedPlayer")) then
		exports.titan_noti:showBox(player, "Nie możesz odłożyć kajdanek kiedy ktoś został przez Ciebie skuty.")
		return
	end
	
	if isPedInVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		if(not exports.titan_vehicles:isVeh(veh) or not tonumber(getElementData(veh, "vehID"))) then
			exports.titan_noti:showBox(player, "Ten pojazd nie został stworzony przez moduł systemu pojazdów.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		local vehItems = getVehicleItems(getElementData(veh, "vehID"))
		if vehItems then
			if #vehItems >= 15 then
				exports.titan_noti:showBox(player, "Nie ma miejsca w pojeździe.")
				guiFunc.updatePlayerEquip(player)
				return
			end
		end
		changeItemOwner(itemInfo.ID, 3, getElementData(veh, "vehID"))
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s "..string.lower(itemInfo.name).." w pojeździe.", getElementData(player, "sex") == 1 and "odłożył" or "odłożyła"), 10.0)
		guiFunc.updatePlayerEquip(player)
		return
	else
		local pX, pY, pZ, rX, rY, rZ = getPotisionsForPlayerItem(player, itemInfo.type, itemInfo.val1)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s "..string.lower(itemInfo.name).." na ziemię.", getElementData(player, "sex") == 1 and "odłożył" or "odłożyła"), 10.0)
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
	end
end
addEvent("guiFunc.throwItem", true)
addEventHandler("guiFunc.throwItem", root, guiFunc.throwItem)

function guiFunc.pickItem(player, itemID, slotID)
	if not exports.titan_login:isLogged(player) then return end
	local itemInfo = getItemInfo(itemID)
	if not itemInfo then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	if isPedInVehicle(player) then
		local veh = getPedOccupiedVehicle(player)
		if itemInfo.ownerType ~= 3 or itemInfo.owner ~= veh:getData("vehID") then
			exports.titan_noti:showBox(player, "Ten przedmiot należy do kogoś innego.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		local vehInfo = exports.titan_vehicles:getVehInfo(veh:getData("vehID"))
		if not vehInfo then
			exports.titan_noti:showBox(player, "Przedmiot w tym pojeździe nie istnieje.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if vehInfo.ownerType == 1 and vehInfo.ownerID ~= player:getData("charID") then
			exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do wyciagania przedmiotów z tego pojazdu.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if vehInfo.ownerType == 3 and not exports.titan_orgs:doesPlayerHavePerm(player, vehInfo.ownerID, "vehicles") then
			exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do wyciagania przedmiotów z tego pojazdu.")
			guiFunc.updatePlayerEquip(player)
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
		itemInfo.slotID = slotID
		itemInfo.x = 0
		itemInfo.y = 0
		itemInfo.z = 0
		itemInfo.rx = 0
		itemInfo.ry = 0
		itemInfo.rz = 0
		itemInfo.interior = 0
		itemInfo.dimension = 0
		exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ?, slotID = ?, used = 0, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, interior = 0, dimension = 0 WHERE ID = ?", itemInfo.ownerType, itemInfo.owner, itemInfo.slotID, itemInfo.ID)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s przedmiot \"%s\" z pojazdu.", getElementData(player, "sex") == 1 and "podniósł" or "podniosła", string.lower(itemInfo.name)), 10.0)
		guiFunc.updatePlayerEquip(player)
		return
	end
	if itemInfo.ownerType ~= 0 then
		exports.titan_noti:showBox(player, "Ten przedmiot należy do kogoś innego.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	local pX, pY, pZ = getElementPosition(player)
	if(getDistanceBetweenPoints3D(pX, pY, pZ, itemInfo.x, itemInfo.y, itemInfo.z) > 3.0) then
		exports.titan_noti:showBox(player, "Ten przedmiot jest zbyt daleko od Ciebie.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	if not isPlayerHaveFreeSlot(player, slotID) then
		exports.titan_noti:showBox(player, "Ten slot jest zajęty przez inny przedmiot.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	itemInfo.ownerType = 1
	itemInfo.owner = getElementData(player, "charID")
	itemInfo.slotID = slotID
	itemInfo.x = 0
	itemInfo.y = 0
	itemInfo.z = 0
	itemInfo.rx = 0
	itemInfo.ry = 0
	itemInfo.rz = 0
	itemInfo.interior = 0
	itemInfo.dimension = 0
	exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s przedmiot \"%s\" z ziemi.", getElementData(player, "sex") == 1 and "podniósł" or "podniosła", string.lower(itemInfo.name)), 10.0)
	exports.titan_db:query_free("UPDATE _items SET ownerType = ?, owner = ?, slotID = ?, used = 0, x = 0, y = 0, z = 0, rx = 0, ry = 0, rz = 0, interior = '0', dimension = '0' WHERE ID = ?", itemInfo.ownerType, itemInfo.owner, itemInfo.slotID, itemInfo.ID)
	setPedAnimation(player, "BOMBER", "BOM_Plant", -1, false, false, false, false)
	if(isElement(itemsModels[itemInfo.ID])) then
		destroyElement(itemsModels[itemInfo.ID])
	end
	guiFunc.updatePlayerEquip(player)
end
addEvent("guiFunc.pickItem", true)
addEventHandler("guiFunc.pickItem", root, guiFunc.pickItem)

function guiFunc.closeEquip(player)
	if(getElementData(player, "itemGUIOpened")) then
		setElementData(player, "itemGUIOpened", false)
		triggerClientEvent(player, "closeItemGUI", player)
	end
	triggerEvent("hud.items.s", player)
end

function guiFunc.moveItemInEquip(player, itemID, newSlot)
	if(not exports.titan_login:isLogged(player)) then return end
	local itemInfo = getItemInfo(itemID)
	if(not itemInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
		exports.titan_noti:showBox(player, "Ten przedmiot nie należy do Ciebie.")
		guiFunc.updatePlayerEquip(player)
		return
	end
	itemInfo.slotID = newSlot
	exports.titan_db:query_free("UPDATE _items SET slotID = ? WHERE ID = ?", newSlot, itemInfo.ID)
	guiFunc.updatePlayerEquip(player)
end
addEvent("guiFunc.moveItemInEquip", true)
addEventHandler("guiFunc.moveItemInEquip", root, guiFunc.moveItemInEquip)

function guiFunc.useItem(player, itemID)
	playerUseItem(player, itemID)
	triggerEvent("hud.items.s", player)
end
addEvent("guiFunc.useItem", true)
addEventHandler("guiFunc.useItem", root, guiFunc.useItem)

function guiFunc.loadWeapon(player, weaponID, ammoID)
	if not exports.titan_login:isLogged(player) then return end
	local ammoInfo = getItemInfo(ammoID)
	if not ammoInfo then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox("Nie znaleziono podanego przemiotu.")
		return
	end
	local weaponInfo = getItemInfo(weaponID)
	if not weaponInfo then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox("Nie znaleziono podanego przemiotu.")
		return
	end
	if ammoInfo.ownerType ~= 1 or ammoInfo.owner ~= player:getData("charID") then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
		return
	end
	if weaponInfo.ownerType ~= 1 or weaponInfo.owner ~= player:getData("charID") then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
		return
	end
	if weaponInfo.used == 1 then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Nie możesz używać broni, jeśli chcesz ja przeładować.")
		return
	end
	weaponInfo.val2 = weaponInfo.val2 + ammoInfo.val2
	removeItem(ammoInfo.ID)
	exports.titan_noti:showBox(player, string.format("Załadowano amunicję do broni %s.", weaponInfo.name))
	exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s amunicję w broni (%s).", getElementData(player, "sex") == 1 and "przeładował" or "przeładowała", weaponInfo.name), 10.0)
	exports.titan_db:query_free("UPDATE _items SET val2 = ? WHERE ID = ?", ammoInfo.val2, weaponInfo.ID)
	guiFunc.updatePlayerEquip(player)
	return
end
addEvent("guiFunc.loadWeapon", true)
addEventHandler("guiFunc.loadWeapon", root, guiFunc.loadWeapon)

function guiFunc.loadBoombox(player, boomboxID, discID)
	if(not exports.titan_login:isLogged(player)) then return end
	local boomboxInfo = getItemInfo(boomboxID)
	if(not boomboxInfo) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox("Nie znaleziono podanego przemiotu.")
		return
	end

	local discInfo = getItemInfo(discID)
	if(not discInfo) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Nie znaleziono podanego przemiotu.")
		return
	end

	if(boomboxInfo.ownerType ~= 1 or boomboxInfo.owner ~= getElementData(player, "charID")) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
		return
	end

	if(discInfo.ownerType ~= 1 or discInfo.owner ~= getElementData(player, "charID")) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
		return
	end

	if(string.len(tostring(discInfo.val3)) < 3) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Najpierw musisz zapisać coś na płycie.")
		return
	end

	if(boomboxInfo.used == 1) then
		guiFunc.updatePlayerEquip(player)
		exports.titan_noti:showBox(player, "Aby zmienić płytę musisz wyłączyć boomboxa.")
		return
	end
	boomboxInfo.val1 = discInfo.ID
	exports.titan_db:query_free("UPDATE _items SET val1 = ? WHERE ID = ?", discInfo.ID, boomboxInfo.ID)
	exports.titan_noti:showBox(player, "Płyta została umieszczona w boomboxie.")
	guiFunc.updatePlayerEquip(player)
	return
end
addEvent("guiFunc.loadBoombox", true)
addEventHandler("guiFunc.loadBoombox", root, guiFunc.loadBoombox)

function showItemInfoGUI(player, itemID)
	local itemInfo = getItemInfo(itemID)
	if not itemInfo then return exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu o takim ID.") end
	local owner = "n/d"
	if itemInfo.ownerType == 1 then
		local query = exports.titan_db:query("SELECT c.name, c.lastname, m.members_display_name FROM _characters c LEFT JOIN ipb_members m ON (m.member_id = c.memberID) WHERE c.ID = ? LIMIT 1", itemInfo.owner)
		if query then
			query = query[1]
			owner = string.format("%s %s (%s)", query.name, query.lastname, query.members_display_name)
		end
	end
	local tmpTable = 
	{
		[1] = 
		{
			title = "ID",
			color = {255, 255, 255},
			text = itemInfo.ID
		},
		[2] = 
		{
			title = "Nazwa",
			color = {255, 255, 255},
			text = itemInfo.name
		},
		[3] = 
		{
			title = "Typ właściciela",
			color = {255, 255, 255},
			text = itemInfo.ownerType == 1 and "Gracz" or itemInfo.ownerType == 0 and "Żaden" or "Nieznany"
		},
		[4] = 
		{
			title = "Właściciel",
			color = {255, 255, 255},
			text = owner
		},
		[5] = 
		{
			title = "Typ",
			color = {255, 255, 255},
			text = itemInfo.type
		},
		[6] = 
		{
			title = "Slot",
			color = {255, 255, 255},
			text = itemInfo.slotID
		},
		[7] = 
		{
			title = "Wartość I",
			color = {255, 255, 255},
			text = itemInfo.val1
		},
		[8] = 
		{
			title = "Wartość II",
			color = {255, 255, 255},
			text = itemInfo.val2
		},
		[9] = 
		{
			title = "Wartość III",
			color = {255, 255, 255},
			text = itemInfo.val3
		},
		[10] = 
		{
			title = "Objętość",
			color = {255, 255, 255},
			text = itemInfo.volume
		},
		[11] = 
		{
			title = "Stworzony",
			color = {255, 255, 255},
			text = itemInfo.created
		},
		[12] = 
		{
			title = "Ostatnio użyty",
			color = {255, 255, 255},
			text = itemInfo.lastUsed
		},
		[13] = 
		{
			title = "Ostatnio użyty przez",
			color = {255, 255, 255},
			text = itemInfo.lastUsedID
		},
		[14] = 
		{
			title = "Używany",
			color = itemInfo.used == 1 and {0, 255, 0} or {255, 255, 255},
			text = itemInfo.used == 1 and "Tak" or "Nie"
		},
		[15] = 
		{
			title = "X",
			color = {255, 255, 255},
			text = itemInfo.x
		},
		[16] = 
		{
			title = "Y",
			color = {255, 255, 255},
			text = itemInfo.y
		},
		[17] = 
		{
			title = "Z",
			color = {255, 255, 255},
			text = itemInfo.z
		},
		[18] = 
		{
			title = "rX",
			color = {255, 255, 255},
			text = itemInfo.rx
		},
		[19] = 
		{
			title = "rY",
			color = {255, 255, 255},
			text = itemInfo.ry
		},
		[20] = 
		{
			title = "rZ",
			color = {255, 255, 255},
			text = itemInfo.rz
		},
		[21] = 
		{
			title = "Interior",
			color = {255, 255, 255},
			text = itemInfo.interior
		},
		[22] = 
		{
			title = "VW",
			color = {255, 255, 255},
			text = itemInfo.dimension
		},

	}
	triggerClientEvent(player, "iinfogui.show", player, tmpTable)
end