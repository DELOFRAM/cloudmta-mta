----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

--setDevelopmentMode(true)

local objectsData = {}
local objectsIndex = {}
local objectsBuffer = {}
local streamerSettings = 
{
	bufferUpdateTime 		= 100,
	loadUpdateTime 			= 500,
	bufferLoadObjectsCount	= 10,
	objectMaxDistance = 200.0,

	bufferBlock = false

}

function mainFunction()
	setTimer(loadUpdate, streamerSettings.loadUpdateTime, 0)
	setTimer(bufferUpdate, streamerSettings.bufferUpdateTime, 0)

	triggerServerEvent("playerLoadObjectsOnDimension", localPlayer, localPlayer, localPlayer:getDimension())
end

function getFreeObjectIndex()
	local index = 1
	while true do
		if type(objectsData[index]) ~= "table" then return index end
		index = index + 1
	end
	return false
end

function getObjectsDataFromServer(data)
	streamerSettings.bufferBlock = true
	unloadAllObjects()

	for k, v in ipairs(data) do
		local freeIndex = getFreeObjectIndex()
		if freeIndex then
			v.objectStreamed = false

			objectsData[freeIndex] = v
			objectsIndex[v.ID] = freeIndex
		end
	end
	loadUpdate()
	streamerSettings.bufferBlock = false
end
addEvent("getObjectsDataFromServer", true)
addEventHandler("getObjectsDataFromServer", root, getObjectsDataFromServer)

function unloadAllObjects()
	if #objectsData > 0 then
		for k, v in pairs(objectsData) do
			if v and isElement(v.objectElement) then
				destroyElement(v.objectElement)
			end
		end
		
		objectsData = {}
		objectsIndex = {}
		objectsBuffer = {}
	end
end

function unloadObject(objectID)
	local objectInfo = getObjectInfo(objectID)
	if not objectInfo then return false end

	if objectInfo.objectStreamed and isElement(objectInfo.objectElement) then
		destroyElement(objectInfo.objectElement)
		objectInfo.objectStreamed = false
		return true
	end
	return false
end

function loadUpdate()
	for k, v in pairs(objectsData) do
		if v and doesObjectHaveDistance(v.x, v.y, v.z) then
			if not v.objectStreamed and not isObjectInBuffer(v.ID) then
				table.insert(objectsBuffer, v.ID)
			end
		elseif not doesObjectHaveDistance(v.x, v.y, v.z) then
			if v.objectStreamed and isElement(v.objectElement) then
				unloadObject(v.ID)
			end
		end
	end
end

function isObjectInBuffer(objectID)
	for k, v in ipairs(objectsBuffer) do
		if v == objectID then return true end
	end
	return false
end

function bufferUpdate()
	if streamerSettings.bufferBlock then return true end
	
	local objectsLoaded = 0
	if localPlayer:getData("objectsLoading") then
		if #objectsBuffer <= 0 then
			triggerServerEvent("playerUnfreeze", localPlayer)
		end
	end
	for k, v in ipairs(objectsBuffer) do
		local objectInfo = getObjectInfo(v)
		if objectInfo then
			if not isElement(objectInfo.objectElement) then
				if doesObjectHaveDistance(objectInfo.x, objectInfo.y, objectInfo.z) then
					objectInfo.objectElement = createObject(objectInfo.model, objectInfo.x, objectInfo.y, objectInfo.z, objectInfo.rx, objectInfo.ry, objectInfo.rz)
					if isElement(objectInfo.objectElement) then
						-- _BEGIN ŁADOWANIE INFO
						setElementDimension(objectInfo.objectElement, objectInfo.dimension)
						setElementInterior(objectInfo.objectElement, objectInfo.interior)

						if type(objectInfo.textureData) == "table" then
							for k, v in ipairs(objectInfo.textureData) do
								local texName, texID = unpack(v)
								if texName and texID then
									setObjectTexture(objectInfo.objectElement, texName, texID)
								end
							end
						end

						if objectInfo.gateOpened then
							setElementPosition(objectInfo.objectElement, objectInfo.gx, objectInfo.gy, objectInfo.gz)
							setElementRotation(objectInfo.objectElement, objectInfo.grx, objectInfo.gry, objectInfo.grz)
						end

						setElementData(objectInfo.objectElement, "isObject", true, false)
						setElementData(objectInfo.objectElement, "objectID", objectInfo.ID)

						objectInfo.objectStreamed = true
						table.remove(objectsBuffer, k)
						objectsLoaded = objectsLoaded + 1
					end
				else
					table.remove(objectsBuffer, k)
				end
			end
		end
		if objectsLoaded >= streamerSettings.bufferLoadObjectsCount then
			break
		end
	end
	return true
end

function doesObjectHaveDistance(x, y, z)
	local pX, pY, pZ = getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(pX, pY, pZ, x, y, z) <= streamerSettings.objectMaxDistance then return true end
	return false
end

function getObjectInfo(objectID)
	local index = objectsIndex[objectID]
	if not index or not tonumber(index) then return false end
	if type(objectsData[index]) ~= "table" then return false end
	return objectsData[index]
end

function setObjectData(objectID, dataName, data)
	local objectInfo = getObjectInfo(objectID)
	if objectInfo then
		objectInfo[dataName] = data
	end
end
addEvent("setObjectData", true)
addEventHandler("setObjectData", root, setObjectData)

addEventHandler("onClientResourceStart", resourceRoot, mainFunction)

-- ADDITIONAL
function saveObjectTexture(objectID, textureData)
	local objectInfo = getObjectInfo(objectID)
	if not objectInfo then return false end

	if isElement(objectInfo.objectElement) then
		if type(textureData) == "table" then
			for k, v in ipairs(textureData) do
				local texName, texID = unpack(v)
				if texName and texID then 
					setObjectTexture(objectInfo.objectElement, texName, texID)
				end
			end
		end
	end
	objectInfo.textureData = textureData
end
addEvent("saveObjectTexture", true)
addEventHandler("saveObjectTexture", root, saveObjectTexture)

-- DEBUG

addEventHandler("onClientRender", root, function()
	local text = ""
	if localPlayer:getData("objectsLoading") then text = "| Ładuję obiekty..." end
	local streamed = 0
	for k, v in pairs(objectsData) do if v and v.objectStreamed then streamed = streamed + 1 end end
	dxDrawText(string.format("Obiektów załadowanych: %d | Obiektów w buforze: %d | Obiektów streamowanych: %d %s", #objectsData, #objectsBuffer, streamed, text), 0, 0)
end)

function getNearestObjects(distance)
	local pPos = localPlayer:getPosition()
	local objects = getElementsByType("object", resourceRoot, true)
	local objectsTable = {}
	for k, v in ipairs(objects) do
		if getDistanceBetweenPoints3D(pPos, v:getPosition()) <= distance then
			table.insert(objectsTable, v)
		end
	end
	if #objectsTable <= 0 then return false end
	return objectsTable
end

function toggleGate(objectID, stopPos, time, toggle)
	local objectInfo = getObjectInfo(objectID)
	if not objectInfo then return false end

	gFunc.new(objectInfo.objectElement, stopPos, time)
	objectInfo.gateOpened = toggle
end
addEvent("toggleGate", true)
addEventHandler("toggleGate", root, toggleGate)

local commandFunc = {}

function commandFunc.gate()
	local objects = getNearestObjects(10.0)
	if not objects then
		return exports.titan_noti:showBox("Nie znaleziono żadnej bramy w pobliżu.")
	end

	local gatesCount = 0
	for k, v in ipairs(objects) do
		if getElementData(v, "isObject") then
			local objectInfo = getObjectInfo(getElementData(v, "objectID"))
			if objectInfo then
				if objectInfo.isGate == 1 then
					gatesCount = gatesCount + 1
					triggerServerEvent("toggleGate", localPlayer, objectInfo.ID)
				end
			end
		end
	end
	if gatesCount == 0 then
		return exports.titan_noti:showBox("Nie znaleziono żadnej bramy w pobliżu.")
	end
end
addCommandHandler("brama", commandFunc.gate, false, false)