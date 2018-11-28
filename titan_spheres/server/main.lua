----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local spheresFunc = {}
local spheresData = {}

function spheresFunc.main()
	exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_spheres` (`ID` INT(11) NOT NULL AUTO_INCREMENT, `name` VARCHAR(255) NULL DEFAULT '0', `members` MEDIUMTEXT NULL, `coords` TEXT NULL, `flags` TEXT NULL, PRIMARY KEY (`ID`)) COLLATE='utf8_general_ci' ENGINE=InnoDB")
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _spheres")
	for k, v in ipairs(query) do
		local coords = fromJSON(v.coords)
		v.members = fromJSON(v.members)
		v.flags = fromJSON(v.flags)
		if type(v.members) ~= "table" then v.members = {} end
		if type(v.flags) ~= "table" then v.flags = {} end
		table.insert(spheresData, v)

		v.polygon = createColPolygon(coords[1], coords[2], unpack(coords))
		if isElement(v.polygon) then
			setElementData(v.polygon, "sphere:bool", true)
			setElementData(v.polygon, "sphere:ID", v.ID)
		else
			spheresFunc.removeSphere(v.ID)
		end
	end
	outputDebugString(string.format("[SPHERES] Załadowano sfery (%d). | %d ms", #query, getTickCount() - time))
end
addEventHandler("onResourceStart", resourceRoot, spheresFunc.main)

function spheresFunc.addNewSphere(name, coords)
	local query, rows, lastID = exports.titan_db:query("INSERT INTO _spheres SET name = ?, coords = ?, members = ?, flags = ?", name, toJSON(coords), toJSON({}), toJSON({}))
	local tempTable = 
	{
		ID = lastID,
		name = name,
		members = {},
		coords = coords,
		flags = {},
		objectsLimit = 20

	}
	tempTable.polygon = createColPolygon(coords[1], coords[2], unpack(coords))
	setElementData(tempTable.polygon, "sphere:bool", true)
	setElementData(tempTable.polygon, "sphere:ID", tempTable.ID)
	table.insert(spheresData, tempTable)
	outputDebugString(string.format("[SPHERES] Dodano nowa sferę [UID: %d, Nazwa: %s].", lastID, name))
	return lastID
end
addEvent("spheresFunc.addNewSphere", true)
addEventHandler("spheresFunc.addNewSphere", root, spheresFunc.addNewSphere)

function spheresFunc.removeSphere(sphereID)
	local sphereInfo, sphereInfoKey = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		if isElement(sphereInfo.polygon) then
			destroyElement(sphereInfo.polygon)
		end
		for k, v in ipairs(getElementsByType("player")) do
			if v:getData("playerSphere:ID") and v:getData("playerSphere:ID") == sphereInfo.ID then
				v:setData("playerSphere:ID", false)
			end
		end
		exports.titan_db:query_free("DELETE FROM _spheres WHERE ID = ?", sphereInfo.ID)
		table.remove(spheresData[sphereInfoKey])
		return true
	end
	return false
end
removeSphere = spheresFunc.removeSphere

function spheresFunc.getSphereInfo(sphereID)
	if tonumber(sphereID) then
		for k, v in ipairs(spheresData) do
			if v.ID == sphereID then
				return v, k
			end
		end
		return false
	end
	return false
end
getSphereInfo = spheresFunc.getSphereInfo

function spheresFunc.isSphere(element)
	if isElement(element) and getElementData(element, "sphere:bool") and tonumber(getElementData(element, "sphere:ID")) then return true end
	return false
end
isSphere = spheresFunc.isSphere

function spheresFunc.addSphereMember(sphereID, data)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		table.insert(sphereInfo.members, data)
		exports.titan_db:query_free("UPDATE _spheres SET members = ? WHERE ID = ?", toJSON(sphereInfo.members), sphereInfo.ID)
		return true
	end
	return false
end
addSphereMember = spheresFunc.addSphereMember

function spheresFunc.removeSphereMember(sphereID, ownerType, owner)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		for k, v in ipairs(sphereInfo.members) do
			if v.ownerType == ownerType and v.owner == owner then
				table.remove(sphereInfo.members, k)
				break
			end
		end
		exports.titan_db:query_free("UPDATE _spheres SET members = ? WHERE ID = ?", toJSON(sphereInfo.members), sphereInfo.ID)
		return true
	end
	return false
end
removeSphereMember = spheresFunc.removeSphereMember

function spheresFunc.getSphereFlags(sphereID)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		return sphereInfo.flags
	end
	return false
end
getSphereFlags = spheresFunc.getSphereFlags

function spheresFunc.doesOwnerHasPerm(sphereID, ownerType, owner)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		if type(sphereInfo.members) == "table" then
			for k, v in ipairs(sphereInfo.members) do
				if v.ownerType == ownerType and v.owner == owner then return true end
			end
		end
	end
	return false
end
doesOwnerHasPerm = spheresFunc.doesOwnerHasPerm

function spheresFunc.getPlayerZone(player)
	if getElementData(player, "playerSphere:ID") then
		return getElementData(player, "playerSphere:ID")
	end
	return false
end
getPlayerZone = spheresFunc.getPlayerZone

function spheresFunc.setSphereData(sphereID, name, flags)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		sphereInfo.name = name
		sphereInfo.flags = flags
		exports.titan_db:query_free("UPDATE _spheres SET name = ?, flags = ? WHERE ID = ?", name, toJSON(flags), sphereInfo.ID)
		return true
	end
	return false
end
setSphereData = spheresFunc.setSphereData

function spheresFunc.doesSphereHasFlag(sphereID, flagName)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		if type(sphereInfo.flags) == "table" then
			if sphereInfo.flags[flagName] then return true end
		end
	end
	return false
end
doesSphereHasFlag = spheresFunc.doesSphereHasFlag

function spheresFunc.getSphereMaxObjects(sphereID)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		return sphereInfo.objectsLimit
	end
	return false
end
getSphereMaxObjects = spheresFunc.getSphereMaxObjects

function spheresFunc.changeSphereObjectsLimit(sphereID, objectsLimit)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		sphereInfo.objectsLimit = objectsLimit
		exports.titan_db:query_free("UPDATE _spheres SET objectsLimit = ? WHERE ID = ?", objectsLimit, sphereInfo.ID)
		return true
	end
	return false
end
changeSphereObjectsLimit = spheresFunc.changeSphereObjectsLimit

function spheresFunc.changeSphereInterior(sphereID, intID)
	local sphereInfo = spheresFunc.getSphereInfo(sphereID)
	if sphereInfo then
		sphereInfo.intID = intID
		exports.titan_db:query_free("UPDATE _spheres SET intID = ? WHERE ID = ?", intID, sphereInfo.ID)
		return true
	end
	return false
end
changeSphereInterior = spheresFunc.changeSphereInterior