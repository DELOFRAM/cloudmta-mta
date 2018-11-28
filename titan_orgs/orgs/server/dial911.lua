----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local dials911 = {}

function addNew911Dial(text, groupsID)
	local groupsTable = {}
	for k, v in ipairs(groupsID) do
		local groupInfo = getGroupInfo(v)
		if groupInfo then table.insert(groupsTable, {ID = groupInfo.ID, name = groupInfo.name, tag = groupInfo.tag, stateElement = nil}) end
	end
	local x, y, z = getElementPosition(source)
	local tmpTable =
	{
		name = exports.titan_chats:getPlayerICName(source),
		phone = exports.titan_items:getPlayerUsedPhoneInfo(source),
		time = getRealTime().timestamp,
		groups = groupsTable,
		zone = getZoneName(source:getPosition()),
		text = text,
		element = source,
		x = x,
		y = y,
		z = z
	}
	if type(tmpTable.phone) == "table" then tmpTable.phone = tmpTable.phone.val1 else tmpTable.phone = 0 end
	local ind = getFreeDial911Index()
	tmpTable.index = ind
	table.insert(dials911, tmpTable)

	for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
			local duty = getPlayerDuty(v)
			if tonumber(duty) then
				if getIDFromTable(groupsTable, tonumber(duty)) then
					exports.titan_noti:showBox(v, "Właśnie nadeszło zgłoszenie na 911. Sprawdź zgłoszenia swojej grupy.")
				end
			end
		end
	end
	refreshPlayers()
end
addEvent("addNew911Dial", true)
addEventHandler("addNew911Dial", root, addNew911Dial)

function getFreeDial911Index()
	local i = 1
	while true do
		if type(dials911[i]) ~= "table" then return i end
		i = i + 1
	end
end

function getIDFromTable(table, ID)
	for k, v in ipairs(table) do
		if v.ID == ID then return k end
	end
	return false
end

function getDialsToGroup(groupID)
	local dials = {}
	for k, v in pairs(dials911) do
		if getIDFromTable(v.groups, groupID) then
			table.insert(dials, v)
		end
	end
	return dials
end

function getIndexFromIndex(index)
	for k, v in pairs(dials911) do
		if v.index == index then return k end
	end
	return false
end

function getAllDials() return dials911 end

function toggleDialStatus(dialIndex)
	dialIndex = getIndexFromIndex(dialIndex)
	if not dialIndex then return exports.titan_noti:showBox(source, "Takie zgłoszenie nie istnieje") end
	local playerDuty = getPlayerDuty(source)
	if not playerDuty then return exports.titan_noti:showBox(source, "Nie jesteś na duty żadnej grupy.") end
	local groupInfo = getGroupInfo(playerDuty)
	if not groupInfo then return exports.titan_noti:showBox(source, "Grupa na której duty jesteś nie istnieje.") end
	local dial = dials911[dialIndex]
	if type(dial) ~= "table" then refreshPlayers() return exports.titan_noti:showBox(source, "Takie zgłoszenie nie istnieje") end
	local index = getIDFromTable(dial.groups, tonumber(playerDuty))
	if not index then refreshPlayers() return exports.titan_noti:showBox(source, "To zgłoszenie nie należy do Twojej grupy.") end

	if isElement(dial.groups[index].stateElement) then
		if dial.groups[index].stateElement ~= source then return exports.titan_noti:showBox(source, string.format("To zgłoszenie zostało przyjęte przez gracza %s", exports.titan_chats:getPlayerICName(dial.groups[index].stateElement))) end
		table.remove(dial.groups, index)
		if #dial.groups <= 0 then
			table.remove(dials911, dialIndex)
		end
		refreshPlayers()
		exports.titan_noti:showBox(source, "Zgłoszenie zostało zakonczone pomyślnie.")
		if isElement(dial.blip) then
			destroyElement(dial.blip)
		end
		return 
	else
		dial.groups[index].stateElement = source
		refreshPlayers()
		exports.titan_noti:showBox(source, "Pomyślnie przyjąłeś zgłoszenie.")
		if isElement(dial.element) then exports.titan_noti:showBox(dial.element, string.format("Twoje zgłoszenie dla %s zostało przyjęte.", groupInfo.name)) end
		dial.blip = createBlip(dial.x, dial.y, dial.z, 0, 3, 255, 0, 0, 255, 0, nil, source)
		local nick = exports.titan_chats:getPlayerICName(source)
		for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
				local duty = getPlayerDuty(v)
				if tonumber(duty) then
					if tonumber(duty) == tonumber(playerDuty) and v ~= source then
						exports.titan_noti:showBox(v, string.format("Zgłoszenie od %s zostało przyjęte przez %s.", dial.name, nick))
					end
				end
			end
		end
		return
	end
end
addEvent("toggleDialStatus", true)
addEventHandler("toggleDialStatus", root, toggleDialStatus)

function refreshPlayers()
	for k, v in ipairs(getElementsByType("player")) do
		if v:getData("guiOpen:zgloszenia") then
			triggerClientEvent(v, "reportsGroup.funcRefreshData", v, dials911)
		end
	end
end