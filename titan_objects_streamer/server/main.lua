----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local objectsData = {}

function loadObjects()
	local timeElapsed = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _objects")
	if query then
		for k, v in ipairs(query) do
			if v.texData then
				v.texData = fromJSON(v.texData)
				if type(v.texData) ~= "table" then v.texData = {} end
			else
				v.texData = {}
			end
			v.gateOpened = false
			table.insert(objectsData, v)
		end
	end
	outputDebugString(string.format("[STREAMER] Pobrano obiekty (%d). | %dms", #query, getTickCount() - timeElapsed))
end
addEventHandler("onResourceStart", resourceRoot, loadObjects)

function getObjectInfo(objectID)
	for k, v in ipairs(objectsData) do
		if v.ID == objectID then return v end
	end
	return false
end

function playerLoadObjectsOnDimension(player, dimension)
	if not exports.titan_login:isLogged(player) then return false end
	local objectsTable = {}
	for k, v in ipairs(objectsData) do
		if v.dimension == dimension then
			table.insert(objectsTable, v)
		end
	end
	triggerClientEvent(player, "getObjectsDataFromServer", resourceRoot, objectsTable)

	player:setFrozen(true)
	player:setData("objectsLoading", true)
end
addEvent("playerLoadObjectsOnDimension", true)
addEventHandler("playerLoadObjectsOnDimension", root, playerLoadObjectsOnDimension)

function playerUnfreeze()
	source:removeData("objectsLoading")
	source:setFrozen(false)
	return true
end
addEvent("playerUnfreeze", true)
addEventHandler("playerUnfreeze", root, playerUnfreeze)

function cmdGetObjects(player)
	playerLoadObjectsOnDimension(player, getElementDimension(player))
	exports.titan_noti:showBox(player, "Pobrano obiekty.")
end
addCommandHandler("obj", cmdGetObjects, false, false)

-- TEXTURES
function setObjectTexture(objectID, textureName, textureID)
	local objectInfo = getObjectInfo(objectID)
	if not objectInfo then return false end

	if type(objectInfo.textureData) == "table" then
		for k, v in ipairs(objectInfo.textureData) do
			local tName, tID = unpack(v)
			if tostring(tName) == tostring(textureName) then
				table.remove(objectInfo.textureData, k)
				break
			end
		end
	else
		objectInfo.textureData = {}
	end

	table.insert(objectInfo.textureData, {textureName, textureID})
	triggerClientEvent("saveObjectTexture", objectInfo.ID, textureName, textureID)
end

-- GATES
function toggleGate(objectID)
	local objectInfo = getObjectInfo(objectID)
	if objectInfo then
		if objectInfo.isGate == 1 then
			if objectInfo.gateOpened then
				objectInfo.gateOpened = false
				triggerClientEvent("toggleGate", resourceRoot, objectInfo.ID, {objectInfo.x, objectInfo.y, objectInfo.z, objectInfo.rx, objectInfo.ry, objectInfo.rz}, objectInfo.gAnimTime, false)
			else
				objectInfo.gateOpened = true
				triggerClientEvent("toggleGate", resourceRoot, objectInfo.ID, {objectInfo.gx, objectInfo.gy, objectInfo.gz, objectInfo.grx, objectInfo.gry, objectInfo.grz}, objectInfo.gAnimTime, true)
			end
		end
	end
end
addEvent("toggleGate", true)
addEventHandler("toggleGate", root, toggleGate)