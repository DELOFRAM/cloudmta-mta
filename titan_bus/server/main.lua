----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:08
-- Ostatnio zmodyfikowano: 2016-01-09 15:44:10
----------------------------------------------------

local busFunc = {}
local busData = {}

function busFunc.load()
	busData = {}
	local time = getTickCount()
	local loaded = 0
	local query = exports.titan_db:query("SELECT * FROM _buses")
	for k, v in ipairs(query) do
		local objectInfo = exports.titan_objects:getObjectInfo(v.objectID)
		if objectInfo then
			if isElement(objectInfo.object) then
				objectInfo.object:setData("isBus", true)
				objectInfo.object:setData("busID", v.ID)
			end
			v.object = objectInfo.object
			table.insert(busData, v)
			loaded = loaded + 1
		end
	end
	outputDebugString(string.format("[BUS] Załadowano przystanki (%d). | %d ms", loaded, getTickCount() - time))
end
busLoad = busFunc.load

function busFunc.create(player, name, objectID)
	local time = getTickCount()
	local objectInfo = exports.titan_objects:getObjectInfo(objectID)
	if not objectInfo then return exports.titan_noti:showBox(player, "Nie znaleziono obiektu o podanym ID.") end
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _buses SET name = ?, objectID = ?", tostring(name), tonumber(objectID))
	if tonumber(lastID) then
		local tmpTable = 
		{
			ID = tonumber(lastID),
			name = tostring(name),
			objectID = tonumber(objectID),
			object = objectInfo.object
		}
		table.insert(busData, tmpTable)
		outputDebugString(string.format("[BUS] Dodano nowy przystanek. | %d ms", getTickCount() - time))
		return lastID
	end
end
busCreate = busFunc.create

function busFunc.getInfo(busID)
	for k, v in ipairs(busData) do
		if v.ID == busID then return k, v end
	end
	return false
end

function busFunc.remove(busID)
	local time = getTickCount()
	local busKey, busInfo = busFunc.getInfo(busID)
	if not busKey then return false end
	table.remove(busData, busKey)

	local objectInfo = exports.titan_objects:getObjectInfo(busInfo.objectID)
	if objectInfo then
		objectInfo.object:removeData("isBus")
		objectInfo.object:removeData("busID")
	end
	exports.titan_db:query_free("DELETE FROM _buses WHERE ID = ?", busID)
	outputDebugString(string.format("[BUS] Usunięto przystanek. | %d ms", getTickCount() - time))
end
busRemove = busFunc.remove

function busFunc.getBuses(ignoredBus)
	local tmpTable = {}
	for k, v in ipairs(busData) do
		if v.ID ~= ignoredBus then
			table.insert(tmpTable, v)
		end
	end
	if #tmpTable <= 0 then return false end
	return tmpTable
end

function busFunc.startTravel(busID, price, time)
	if not exports.titan_login:isLogged(source) then return end
	local busKey, busInfo = busFunc.getInfo(busID)
	if not busInfo or not isElement(busInfo.object) then return exports.titan_noti:showBox(source, "Nie znaleziono danych o tym przystanku.") end
	local money = exports.titan_cash:getPlayerCash(source)
	if price > money then return exports.titan_noti:showBox(source, "Nie masz wystarczającej ilości gotówki.") end
	if exports.titan_bw:doesPlayerHaveBW(source) then return exports.titan_noti:showBox(source, "Nie możesz podróżować będąc nieprzytomnym.") end
	if exports.titan_cash:takePlayerCash(source, price) then
		local x, y, z = exports.titan_misc:getXYZInFrontOfPlayer(busInfo.object, 1.0)
		triggerClientEvent(source, "busFunc.startTravel", source, time, x, y, z)
		exports.titan_hud:hideSGamingHUD(source)
		exports.titan_hud:toggleRadarVisible(source, false)
		exports.titan_chats:sendPlayerLocalMeRadius(source, string.format("%s do autobusu i %s się w kierunku przystanku \"%s\".", getElementData(source, "sex") == 1 and "wsiadł" or "wsiadła", getElementData(source, "sex") == 1 and "udał" or "udała", busInfo.name), 10.0)
		source:setData("busTravel", true)
	end
end
addEvent("busFunc.startTravel", true)
addEventHandler("busFunc.startTravel", root, busFunc.startTravel)

function busFunc.endTravel()
	exports.titan_hud:showSGamingHUD(source)
	exports.titan_hud:toggleRadarVisible(source, true)
	source:removeData("busTravel")
end
addEvent("busFunc.endTravel", true)
addEventHandler("busFunc.endTravel", root, busFunc.endTravel)

function busFunc.cmd(player)
	if not exports.titan_login:isLogged(player) then return end
	if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz siedzieć w pojeździe.") end
	if exports.titan_bw:doesPlayerHaveBW(source) then return exports.titan_noti:showBox(source, "Nie możesz podróżować będąc nieprzytomnym.") end
	local sphere = createColSphere(player:getPosition(), 5.0)
	local objects = getElementsWithinColShape(sphere, "object")
	destroyElement(sphere)

	local busID = 0
	for k, v in ipairs(objects) do
		if v:getData("isObject") then
			if v:getData("isBus") then
				if tonumber(v:getData("busID")) then
					busID = v
					break
				end
			end
		end
	end
	if busID == 0 then return exports.titan_noti:showBox(player, "Nie jesteś obok żadnego przystanku.") end
	local busObject = busID
	busID = busID:getData("busID")
	local busesData = busFunc.getBuses(busID)
	if not busesData then return exports.titan_noti:showBox(player, "Nie ma żadnych zdefinowanych przystanków.") end
	triggerClientEvent(player, "busFunc.create", player, busesData, busObject)
end
addCommandHandler("bus", busFunc.cmd, false, false)