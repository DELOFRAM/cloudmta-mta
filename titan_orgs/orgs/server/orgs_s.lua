----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

groupsData = {}
groupsIndex = {}
playerGroups = {}
playerGroupsIndex = {}
blockadeData = {}

arrestData = {}

govTaxes = {}

function onStart()
	--paydayFunc()
	--createDMV()
	loadGroups()
	loadPlayerGroups()
	loadBlockades()
	loadArrestData()
	loadGovTaxes()
end

function onStop()
	exports.titan_db:query_free("UPDATE _groups_duty SET end = UNIX_TIMESTAMP(), afkTime = '0' WHERE end = '0'")
end

function loadGovTaxes()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _govTaxes")
	for k, v in pairs(query) do
		govTaxes[v.name] = v.value
	end
	outputDebugString(string.format("[ORGS] Załadowano podatki (%d). | %d ms", #query, getTickCount() - time))
end

function loadGroups()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _groups")
	for k, v in ipairs(query) do
		local index = #groupsData + 1
		v.perms = fromJSON(tostring(v.perms))
		if(type(v.perms) ~= "table") then v.perms = {} end
		groupsData[index] = v
		groupsIndex[v.ID] = index
		--outputChatBox(string.format("ID: %d, cash: %d", v.ID, v.cash))
	end
	--outputChatBox(groupsData[5].cash)
	--outputChatBox(groupsData[5]["cash"])

	outputDebugString(string.format("[ORGS] Załadowano grupy (%d). | %d ms", #query, getTickCount() - time))
end

function loadPlayerGroups()
	local time = getTickCount()
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			loadGroupsForPlayer(v)
			removeElementData(v, "groupDutyID")
			removeElementData(v, "groupDutyColor")
			removeElementData(v, "GroupDutyTag")
		end
	end
	outputDebugString(string.format("[ORGS] Załadowano grupy graczy. | %d ms", getTickCount() - time))
end

function loadBlockades()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _blockades")
	for k, v in ipairs(query) do
		table.insert(blockadeData, v)
	end
	outputDebugString(string.format("[ORGS] Załadowano blokady (%d). | %d ms", #query, getTickCount() - time))
end

function onPQuit()
	if exports.titan_login:isLogged(source) then
		exports.titan_db:query_free("UPDATE _groups_duty SET end = UNIX_TIMESTAMP(), afkTime = ? - afkTime WHERE userID = ? AND end = '0'", source:getData("afkTime"), source:getData("charID"))
		playerGroups[source] = nil
		playerGroupsIndex[source] = nil
	end
end
addEventHandler("onPlayerQuit", root, onPQuit)

function loadArrestData()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _arrests")
	for k, v in ipairs(query) do
		table.insert(arrestData, v)
	end
	outputDebugString(string.format("[ORGS] Załadowano areszty (%d). | %d ms", #query, getTickCount() - time))
end

addEventHandler("onResourceStart", resourceRoot, onStart)
addEventHandler("onResourceStart", resourceRoot, onStop)

-- GUI DLA GRACZY
local playerGuiFunc = {}
function playerGuiFunc.show(groupID)
	if not exports.titan_login:isLogged(source) then return end
	if not doesPlayerHaveGroup(source, groupID) then return exports.titan_noti:showBox(source, "Nie posiadasz takiej grupy.") end
	local groupInfo = getGroupInfo(groupID)
	if not groupInfo then return exports.titan_noti:showBox(source, "Taka grupa nie istnieje.") end
	local pGroupInfo = getPlayerGroupInfo(source, groupID)
	if not pGroupInfo then return exports.titan_noti:showBox(source, "Nie posiadasz zapisanych informacji o tej grupie.") end
	local groupVehicles = exports.titan_vehicles:getGroupVehicles(groupInfo.ID)
	if not groupVehicles then groupVehicles = {} end
	local groupPlayers = getPlayersInGroup(groupID)
	if not groupPlayers then groupPlayers = {} end
	triggerClientEvent(source, "groupMenuGUI.manage.create", source, groupInfo, pGroupInfo, groupVehicles, groupPlayers)
end
addEvent("playerGuiFunc.show", true)
addEventHandler("playerGuiFunc.show", root, playerGuiFunc.show)

function playerGuiFunc.setDuty(groupID, state)
	if not exports.titan_login:isLogged(source) then return end
	if not doesPlayerHaveGroup(source, groupID) then return exports.titan_noti:showBox(source, "Nie posiadasz takiej grupy.") end
	local groupInfo = getGroupInfo(groupID)
	if not groupInfo then return exports.titan_noti:showBox(source, "Taka grupa nie istnieje.") end
	local pGroupInfo = getPlayerGroupInfo(source, groupID)
	if not pGroupInfo then return exports.titan_noti:showBox(source, "Nie posiadasz zapisanych informacji o tej grupie.") end
	setPlayerDuty(source, groupID, state)
	if state then
		exports.titan_noti:showBox(source, string.format("Rozpocząłeś służbę w grupie %s.", groupInfo.name))
	else
		exports.titan_noti:showBox(source, string.format("Zakończyłeś służbę w grupie %s.", groupInfo.name))
	end
end
addEvent("playerGuiFunc.setDuty", true)
addEventHandler("playerGuiFunc.setDuty", root, playerGuiFunc.setDuty)

-- vehiclesMenu.lua
function playerGuiFunc.spawnUnspawnVehicle(vehInfo)
	local vehInfo = exports.titan_vehicles:getVehInfo(vehInfo)
	if not vehInfo then return exports.titan_noti:showBox(source, "Nie znaleziono pojazdu o podanym ID.") end

	if vehInfo.ownerType ~= 2 then return exports.titan_noti:showBox(source, "Ten pojazd nie należy do grupy.") end
	if not doesPlayerHaveGroupLeader(source, vehInfo.ownerID) then return exports.titan_noti:showBox(source, "Nie posiadasz odpowiednich uprawnien do spawnowania pojazdów.") end
	if isElement(vehInfo.veh) and not isVehicleEmpty(vehInfo.veh) then return exports.titan_noti:showBox(source, "Pojazd nie jest pusty.") end
	if isElement(vehInfo.veh) then
		exports.titan_vehicles:uSVehicle(vehInfo.ID)
		exports.titan_noti:showBox(source, string.format("Pojazd %s (UID: %d) został odspawnowany.", vehInfo.name, vehInfo.ID))
		return
	else
		exports.titan_vehicles:sVehicle(vehInfo.ID)
		exports.titan_noti:showBox(source, string.format("Pojazd %s (UID: %d) został zespawnowany.", vehInfo.name, vehInfo.ID))
		return
	end
end
addEvent("playerGuiFunc.spawnUnspawnVehicle", true)
addEventHandler("playerGuiFunc.spawnUnspawnVehicle", root, playerGuiFunc.spawnUnspawnVehicle)

function playerGuiFunc.locateVehicle(vehInfo)
	local vehInfo = exports.titan_vehicles:getVehInfo(vehInfo)
	if not vehInfo then return exports.titan_noti:showBox(source, "Nie znaleziono pojazdu o podanym ID.") end

	if vehInfo.ownerType ~= 2 then return exports.titan_noti:showBox(source, "Ten pojazd nie należy do grupy.") end
	if not doesPlayerHavePerm(source, vehInfo.ownerID, "vehicles") then return exports.titan_noti:showBox(source, "Nie posiadasz odpowiednich uprawnien do spawnowania pojazdów.") end
	exports.titan_vehicles:locateVehicle(source, vehInfo.ID)
end
addEvent("playerGuiFunc.locateVehicle", true)
addEventHandler("playerGuiFunc.locateVehicle", root, playerGuiFunc.locateVehicle)

function isVehicleEmpty( vehicle )
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end
 
	local passengers = getVehicleMaxPassengers( vehicle )
	if type( passengers ) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant( vehicle, seat ) then
				return false
			end
		end
	end
	return true
end