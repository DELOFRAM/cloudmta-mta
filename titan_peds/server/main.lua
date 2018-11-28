----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local pedFunc = {}
local pedData = {}

function pedFunc.freeIndex()
	local i = 1
	while true do
		if type(pedData[i]) ~= "table" then return i end
		i = i + 1
	end
end

function pedFunc.getIndexFromID(ID)
	for k, v in pairs(pedData) do
		if v and v.ID == ID then return k end
	end
	return false
end

function pedFunc.load()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM `_peds`")
	for k, v in ipairs(query) do
		local index = pedFunc.freeIndex()
		pedData[index] = query
		pedData[index].ped = createPed(v.skin, v.x, v.y, v.z, v.a, false)
		if isElement(pedData[index].ped) then
			setElementDimension(pedData[index].ped, v.dimension)
			setElementInterior(pedData[index].ped, v.interior)
			setElementFrozen(pedData[index].ped, true)
			setElementData(pedData[index].ped, "pedType", v.type)
			setElementData(pedData[index].ped, "name", v.name)
			setElementData(pedData[index].ped, "pedID", v.ID)
		end
	end
	outputDebugString(string.format("[PEDS] Załadowany pedy (%d). | %d ms", #query, getTickCount() - time))
end
addEventHandler("onResourceStart", resourceRoot, pedFunc.load)

function pedFunc.create(skin, x, y, z, a, interior, dimension, pedType, name)
	local testPed = createPed(skin, x, y, z, a, false)
	if not isElement(testPed) then return false end
	local query, rows, lastID = exports.titan_db:query("INSERT INTO `_peds` SET `name` = ?, `interior` = ?, `dimension` = ?, `type` = ?, `x` = ?, `y` = ?, `z` = ?, `a` = ?, `skin` = ?", name, interior, dimension, pedType, x, y, z, a, skin)
	if not lastID then return false end
	local index = pedFunc.freeIndex()
	pedData[index] = 
	{
		ID = lastID,
		name = name,
		interior = interior,
		dimension = dimension,
		type = pedType,
		x = x,
		y = y,
		z = z,
		a = a,
		skin = skin
	}
	pedData[index].ped = testPed
	if isElement(pedData[index].ped) then
		setElementDimension(pedData[index].ped, dimension)
		setElementInterior(pedData[index].ped, interior)
		setElementFrozen(pedData[index].ped, true)
		setElementData(pedData[index].ped, "pedType", pedType)
		setElementData(pedData[index].ped, "name", name)
		setElementData(pedData[index].ped, "pedID", lastID)
	end
	outputDebugString(string.format("[PEDS] Stworzono peda o ID %d.", lastID))
	return true
end
pedCreate = pedFunc.create

function pedFunc.destroy(pedID)
	local index = pedFunc.getIndexFromID(pedID)
	if not index then return false end
	if isElement(pedData[index].ped) then destroyElement(pedData[index].ped) end
	exports.titan_db:query_free("DELETE FROM _peds WHERE ID = ?", pedID)
	pedData[index] = nil
	outputDebugString(string.format("[PEDS] Usunięto peda o ID %d.", pedID))
	return true
end
pedDestroy = pedFunc.destroy

function pedFunc.isPedNear(player, pedType, radius)
	local defaultRadius = 5.0
	local nearData = 
	{
		dist = radius and radius or defaultRadius
	}
	local dim, int = player:getDimension(), player:getInterior()
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius and radius or defaultRadius)
	local vehicles = getElementsWithinColShape(sphere, "ped")
	destroyElement(sphere)
	for k, v in ipairs(vehicles) do
		if v:getInterior() == int and v:getDimension() == dim and v:getData("pedType") == pedType then
			local vX, vY, vZ = getElementPosition(v)
			local tmpDist = getDistanceBetweenPoints3D(pX, pY, pZ, vX, vY, vZ)
			if tmpDist < nearData.dist then
				nearData.dist = tmpDist
				nearData.elem = v
			end
		end
	end
	if not nearData.elem then return false end
	return nearData.elem:getData("pedID")
end
isPedNear = pedFunc.isPedNear