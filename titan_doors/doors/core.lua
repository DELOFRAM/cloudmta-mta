----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

COLSPHERE_RADIUS = 0.9

pickupData = {}
pickupIndex = {}

doorsData = {}
--doorsDimension = {}
--doorsIndex = {}

function getDoorInfo(doorID)
	for k, v in ipairs(doorsData) do if v and v.ID == doorID then return v, k end end
	return false
end

function getDoorsByOwner(ownerType, owner)
	local tempTable = {}
	for k, v in ipairs(doorsData) do
		if v.ownerType == ownerType and v.owner == owner then
			table.insert(tempTable, v)
		end
	end
	if #tempTable == 0 then return false end
	return tempTable
end

function getDoorIndex(doorID)
	for k, v in ipairs(doorsData) do if v.ID == doorID then return k end end
	return false
end

function getPickupIndex(pickupID)
	local index = pickupIndex[pickupID]
	if(not tonumber(index)) then return false end
	return index
end

function getPickupInfo(pickupID)
	local index = pickupIndex[pickupID]
	if(not tonumber(index)) then return false end
	if(type(pickupData[index]) ~= "table") then return false end
	return pickupData[index]
end

function getDoorInfoFromDimension(dimension)
	if(not tonumber(dimension)) then return false end
	if(dimension == 0) then return false end
	for k, v in ipairs(doorsData) do
		if v.dimension == dimension then return v end
	end
	return false
end

function doesPlayerHavePermToDoors(player, doorID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(exports.titan_admin:isPlayerAdmin(player)) then return true end
	local pickupInfo = getPickupInfo(doorID)
	if(not pickupInfo) then return false end
	local doorInfo = getDoorInfo(pickupInfo.parentID)
	if(not doorInfo) then return false end

	if(doorInfo.ownerType == 1) then
		if(doorInfo.owner == getElementData(player, "charID")) then return true else return false end
	elseif(doorInfo.ownerType == 2) then
		if(exports.titan_orgs:doesPlayerHaveGroup(player, doorInfo.owner)) then return true else return false end
	else 
		return false
	end
	return false
end 

function doesPlayerHavePermToInterior(player, interiorID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if exports.titan_admin:isPlayerAdmin(player) then return true end
	local doorInfo = getDoorInfo(interiorID)
	if not doorInfo then return false end
	if(doorInfo.ownerType == 1) then
		if(doorInfo.owner == getElementData(player, "charID")) then return true else return false end
	elseif(doorInfo.ownerType == 2) then
		if(exports.titan_orgs:doesPlayerHaveGroup(player, doorInfo.owner)) then return true else return false end
	end
	return false
end

function getEntryPickups(doorID)
	local tmpTable = {}
	for k, v in ipairs(pickupData) do
		if(v.parentID == doorID) then
			if(v.outDim == 0 and v.outInt == 0) then
				table.insert(tmpTable, v)
			end
		end
	end
	if(#tmpTable <= 0) then return end
	return tmpTable
end

function getFirstPickup(doorID)
	for k, v in ipairs(pickupData) do
		if v.parentID == doorID then
			if v.outDim == 0 and v.outInt == 0 then
				return v
			end
		end
	end
	return false
end

function getDoorsOnDimension(dimension)
	local tmpTable = {}
	for k, v in pairs(pickupData) do
		if(v and v.inDim == dimension) then
			local tab = {}
			tab.name = v.name
			tab.locked = v.locked
			tab.ID = v.ID
			tab.type = 2
			table.insert(tmpTable, tab)
		end

		if(v and v.outDim == dimension) then
			local tab = {}
			tab.name = v.name
			tab.locked = v.locked
			tab.ID = v.ID
			tab.type = 1
			table.insert(tmpTable, tab)
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function getMagazineItems(intID)
	local query = exports.titan_db:query("SELECT * FROM `_deposite` WHERE `intID` = ?", intID)
	if(#query <= 0) then return false end
	return query
end

function getMagazineItem(intID, itemID)
	local query = exports.titan_db:query("SELECT * FROM `_deposite` WHERE `intID` = ? AND `ID` = ?", intID, itemID)
	if(#query <= 0) then return false end
	return query[1]
end

function giveMagazineItem(player, intID, itemID)
	if(isElement(player)) then
		local itemInfo = getMagazineItem(intID, itemID)
		if(not itemInfo) then return false end

		if itemInfo.itemVal3 == "gun-generate" then
			itemInfo.itemVal3 = exports.titan_misc:generateGunID()
		end		

		local itemSlot = exports.titan_items:getPlayerFreeSlotID(player)
		if(not itemSlot) then
			exports.titan_noti:showBox(player, "Nie posiadasz miejsca w ekwipunku.")
			return
		end

		if(itemInfo.stock <= 0) then
			exports.titan_db:query_free("DELETE FROM `_deposite` WHERE `ID` = ?", itemInfo.ID)
			return false
		end
		exports.titan_items:itemCreate(1, getElementData(player, "charID"), itemInfo.name, itemInfo.itemType, itemSlot, itemInfo.itemVolume, itemInfo.itemVal1, itemInfo.itemVal2, itemInfo.itemVal3)
		itemInfo.stock = itemInfo.stock - 1
		if(itemInfo.stock <= 0) then
			exports.titan_db:query_free("DELETE FROM `_deposite` WHERE `ID` = ?", itemInfo.ID)
		else
			exports.titan_db:query_free("UPDATE `_deposite` SET `stock` = ? WHERE `ID` = ?", itemInfo.stock, itemInfo.ID)
		end
		return true
	end
end

function getNearestDimensionID()
	local res = exports.titan_db:query("SELECT (`dimension` + 1) AS `dimension` FROM `_doors` WHERE (`dimension` + 1) NOT IN (SELECT `dimension` FROM `_doors`) LIMIT 1")
	if #res <= 0 then return 1 end
	if(tonumber(res[1].dimension)) then
		if(res[1].dimension == 0) then return 1 end
		return res[1].dimension
	end
	return false
end

function getDoorNearestIndex()
	local i = 1
	while(true) do
		if(type(doorsData[i]) ~= "table") then return i end
		i = i + 1
	end
end

function getDoorPickupNearestIndex()
	local i = 1
	while(true) do
		if(type(pickupData[i]) ~= "table") then return i end
		i = i + 1
	end
end

function doorCreate(ownerType, owner, name, hotelData)
	local time = getTickCount()
	if not hotelData or hotelData == nil then hotelData = 0 end
	local dimID = getNearestDimensionID()
	--local index = getDoorNearestIndex()
	local res, rows, lastID = exports.titan_db:query("INSERT INTO `_doors` SET `ownerType` = ?, `owner` = ?, `name` = ?, `dimension` = ?, `hotelData` = ?", tonumber(ownerType), tonumber(owner), tostring(name), dimID, hotelData)
	table.insert(doorsData,
	{
		ID = lastID,
		ownerType = ownerType,
		owner = owner,
		dimension = dimID,
		name = name,
		hotelData = hotelData,
		objectsLimit = 50
	})
	outputDebugString(string.format("[DOORS] Stworzono drzwi: %s (%d) [owner: %d, %d]. | %d ms", name, lastID, ownerType, owner, getTickCount() - time))
	return lastID, dimID
end

function doorDestroy(doorID)
	local doorInfo, doorKey = getDoorInfo(doorID)
	if not doorInfo then return false end

	local pickups = getDoorsOnDimension(doorInfo.dimension)
	if type(pickups) == "table" then
		for k, v in ipairs(pickups) do
			doorPickupDestroy(v.ID)
		end
	else pickups = {} end
	outputDebugString(string.format("Skasowano pickupy interioru: %d (%d).", doorID, #pickups))
	exports.titan_db:query_free("DELETE FROM `_doors` WHERE `ID` = ?", doorInfo.ID)
	local objects = exports.titan_objects:getDimensionObjects(doorInfo.dimension)
	if objects then
		for k, v in ipairs(objects) do
			exports.titan_objects:delObject(v.ID)
		end
		outputDebugString(string.format("Skasowano obiekty interioru: %d (%d).", doorID, #objects))
	end
	outputDebugString(string.format("Skasowano interior (%d).", doorID))
	table.remove(doorInfo, doorKey)
	
	for k,v in pairs(getElementsByType("player")) do
		if getElementData(v, "nearestDoorID") == doorID then
			triggerClientEvent(v, "giveDataFromServerAboutDoorInfo", v, {toggle = false})
		end
	end
	return true
end



function changeInteriorData(intID, dataName, data)
	local time = getTickCount()
	local doorInfo = getDoorInfo(intID)
	if not doorInfo then return false end
	doorInfo[dataName] = data
	exports.titan_db:query_free(string.format("UPDATE `_doors` SET %s = ? WHERE `ID` = ?", tostring(dataName)), tostring(data), tonumber(doorInfo.ID))
	return true
end

function doorPickupDestroy(doorID)
	local index = getPickupIndex(doorID)
	if(tonumber(index)) then
		if(not getPickupInfo(doorID)) then return false end
		exports.titan_db:query_free("DELETE FROM `_doorspickup` WHERE `ID` = ?", doorID)
		
		if(isElement(pickupData[index].inPickup)) then
			destroyElement(pickupData[index].inPickup)
		end
		if(isElement(pickupData[index].inSphere)) then
			destroyElement(pickupData[index].inSphere)
		end
		if(isElement(pickupData[index].outPickup)) then
			destroyElement(pickupData[index].outPickup)
		end
		if(isElement(pickupData[index].outSphere)) then
			destroyElement(pickupData[index].outSphere)
		end
		pickupData[index] = false
		pickupIndex[doorID] = false
		
		for k,v in pairs(getElementsByType("player")) do
			if getElementData(v, "nearestDoorID") == doorID then
			triggerClientEvent(v, "giveDataFromServerAboutDoorInfo", v, {toggle = false})
			end
		end
		
		return true
	else
		return false
	end
end

function doorPickupEnterChange(doorID, x, y, z, rz, int, dim, model)
	local index = getPickupIndex(doorID)
	if(tonumber(index)) then
		if(not getPickupInfo(doorID)) then return false end
		exports.titan_db:query_free("UPDATE `_doorspickup` SET `outX` = ?, `outY` = ?, `outZ` = ?, `outDim` = ?, `outInt` = ?, `outAngle` = ?, `outModel` = ? WHERE `ID` = ?", x, y, z, dim, int, rz, model, doorID)
		pickupData[index].outX = x
		pickupData[index].outY = y
		pickupData[index].outZ = z
		pickupData[index].outAngle = rz
		pickupData[index].outInt = int
		pickupData[index].outDim = dim

		if(isElement(pickupData[index].outPickup)) then
			destroyElement(pickupData[index].outPickup)
		end

		pickupData[index].outPickup = createPickup(x, y, z, 3, model, 0)
		if(isElement(pickupData[index].outPickup)) then
			setElementDimension(pickupData[index].outPickup, dim)
			setElementInterior(pickupData[index].outPickup, int)
		end

		if(isElement(pickupData[index].outSphere)) then
			destroyElement(pickupData[index].outSphere)
		end

		pickupData[index].outSphere = createColSphere(x, y, z, COLSPHERE_RADIUS)
		if(isElement(pickupData[index].outSphere)) then
			setElementDimension(pickupData[index].outSphere, dim)
			setElementInterior(pickupData[index].outSphere, int)

			setElementData(pickupData[index].outSphere, "pickupID", pickupData[index].ID)
			setElementData(pickupData[index].outSphere, "doorType", 1)
		end
		return true
	else
		return false
	end
end

function doorPickupLeaveCreate(doorID, x, y, z, rz, int, dim, model)
	local index = getPickupIndex(doorID)
	if(tonumber(index)) then
		if(not getPickupInfo(doorID)) then return false end
		exports.titan_db:query_free("UPDATE `_doorspickup` SET `inX` = ?, `inY` = ?, `inZ` = ?, `inDim` = ?, `inInt` = ?, `inAngle` = ?, `inModel` = ? WHERE `ID` = ?", x, y, z, dim, int, rz, model, doorID)
		pickupData[index].inX = x
		pickupData[index].inY = y
		pickupData[index].inZ = z
		pickupData[index].inAngle = rz
		pickupData[index].inInt = int
		pickupData[index].inDim = dim

		if(isElement(pickupData[index].inPickup)) then
			destroyElement(pickupData[index].inPickup)
		end

		pickupData[index].inPickup = createPickup(x, y, z, 3, model, 0)
		if(isElement(pickupData[index].inPickup)) then
			setElementDimension(pickupData[index].inPickup, dim)
			setElementInterior(pickupData[index].inPickup, int)
		end

		if(isElement(pickupData[index].inSphere)) then
			destroyElement(pickupData[index].inSphere)
		end

		pickupData[index].inSphere = createColSphere(x, y, z, COLSPHERE_RADIUS)
		if(isElement(pickupData[index].inSphere)) then
			setElementDimension(pickupData[index].inSphere, dim)
			setElementInterior(pickupData[index].inSphere, int)

			setElementData(pickupData[index].inSphere, "pickupID", pickupData[index].ID)
			setElementData(pickupData[index].inSphere, "doorType", 2)
		end
		return true
	else
		return false
	end
end

function doorPickupEnterCreate(parentID, modelID, x, y, z, rz, int, dim, name)
	local index = getDoorPickupNearestIndex()
	local res, rows, lastID = exports.titan_db:query("INSERT INTO `_doorspickup` SET `parentID` = ?, `name` = ?, `inX` = '0', `inY` = '0', `inZ` = '0', `outX` = ?, `outY` = ?, `outZ` = ?, `inDim` = '0', `outDim` = ?, `inInt` = '0', `outInt` = ?, `outModel` = ?, `inModel` = '0', `inAngle` = '0', `outAngle` = ?", parentID, name, x, y, z, dim, int, modelID, rz)
	pickupData[index] = 
	{
		ID = lastID,
		parentID = parentID,
		name = name,
		inX = 0,
		inY = 0,
		inZ = 0,
		outX = x,
		outY = y,
		outZ = z,
		inDim = 0,
		outDim = dim,
		inInt = 0,
		outInt = int,
		outModel = model,
		inModel = 0,
		inAngle = 0,
		outAngle = rz,
		locked = 0
	}
	pickupIndex[lastID] = index

	pickupData[index].outPickup = createPickup(x, y, z, 3, modelID, 0)
	if(isElement(pickupData[index].outPickup)) then
		setElementDimension(pickupData[index].outPickup, dim)
		setElementInterior(pickupData[index].outPickup, int)
	end
	pickupData[index].outSphere = createColSphere(x, y, z, COLSPHERE_RADIUS)
	if(isElement(pickupData[index].outSphere)) then
		setElementDimension(pickupData[index].outSphere, dim)
		setElementInterior(pickupData[index].outSphere, int)

		setElementData(pickupData[index].outSphere, "pickupID", lastID)
		setElementData(pickupData[index].outSphere, "doorType", 1)
	end
	return lastID
end

function changePickupData(doorID, dataName, value)
	local pInfo = getPickupInfo(doorID)
	if pInfo then
		pInfo[dataName] = value
		exports.titan_db:query("UPDATE `_doorspickup` SET "..dataName.." = ? WHERE `ID` = ?", value, doorID)
	end
end

function getIntProductsTable(intID)
	if(not tonumber(intID)) then return false end
	intID = tonumber(intID)

	local query = exports.titan_db:query("SELECT * FROM `_shops` WHERE `shopID` = ?", intID)
	if(#query <= 0) then return false end
	return query
end

function getIntProductInfo(itemID)
	if(not tonumber(itemID)) then return false end
	itemID = tonumber(itemID)
	local query = exports.titan_db:query("SELECT * FROM `_shops` WHERE `ID` = ?", itemID)
	if(#query <= 0) then return false end
	return query[1]
end

-----------------
-- CIUCHOLANDY --
-----------------

function getIntClothesTable(intID)
	if(not tonumber(intID)) then return false end
	intID = tonumber(intID)

	local query = exports.titan_db:query("SELECT * FROM `_clothes` WHERE `shopID` = ?", intID)
	if(#query <= 0) then return false end
	return query
end

function getIntClothInfo(itemID)
	if(not tonumber(itemID)) then return false end
	itemID = tonumber(itemID)
	local query = exports.titan_db:query("SELECT * FROM `_clothes` WHERE `ID` = ?", itemID)
	if(#query <= 0) then return false end
	return query[1]
end

function getPlayerInteriors(player)
	local doors = {}
	for k, v in pairs(doorsData) do
		if type(v) == "table" then 
			if v.ownerType == 1 and v.owner == player:getData("charID") then
				table.insert(doors, v)
			end
		end
	end
	return doors
end