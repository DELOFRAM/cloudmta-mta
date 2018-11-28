	----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

GROUP_LIMIT = 5 -- LIMIT GRUP DLA GRACZA

function loadGroupsForPlayer(player)
	playerGroups[player] = {}
	playerGroupsIndex[player] = {}
	local query = exports.titan_db:query("SELECT r.name, r.perms, m.groupID, m.cash FROM _groups_members m LEFT JOIN _groups_ranks r ON (m.rankID = r.ID) WHERE m.userID = ?", getElementData(player, "charID"))
	local i = 1
	for k, v in ipairs(query) do
		v.duty = false
		v.perms = fromJSON(tostring(v.perms))
		if(type(v.perms) ~= "table") then
			outputDebugString(string.format("[GROUPS] Wystapil blad z ladowaniem permow. ID gracza: %d. ID grupy: %d.", getElementData(player, "charID"), v.groupID))
			v.perms = {}
		end
		--outputChatBox(getElementData(player, "name"))
		--[[if doesGroupHavePerm(v.groupID, "gangzones") then
			for k, v in ipairs(getElementsByType("radararea")) do
				setElementVisibleTo(v, player, true)
			end
		end]]
		playerGroups[player][v.groupID] = v
		playerGroupsIndex[player][i] = v.groupID
		i = i + 1
	end
	return true
end

function reloadPlayerGroup(playerID, groupID)
	if not tonumber(playerID) or not tonumber(groupID) then return end
	playerID = tonumber(playerID)
	groupID = tonumber(groupID)
	local playerElement = nil
	for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
			if tonumber(v:getData("charID")) == playerID then
				playerElement = v
				break
			end
		end
	end
	if not isElement(playerElement) then return end
	local groupInfo = getGroupInfo(groupID)
	if groupInfo then
		local groupIndex = playerGroups[playerElement][groupID]
		if groupIndex then
			local pDuty = getPlayerDuty(playerElement)
			if pDuty and pDuty == groupID then
				setPlayerDuty(playerElement, groupID, false)
			end
			local query = exports.titan_db:query("SELECT r.name, r.perms, m.groupID, r.cash FROM _groups_members m LEFT JOIN _groups_ranks r ON (m.rankID = r.ID) WHERE m.userID = ? AND m.groupID = ? LIMIT 1", getElementData(playerElement, "charID"), tonumber(groupID))
			if query then
				query = query[1]
				query.duty = false
				query.perms = fromJSON(query.perms)
				if(type(query.perms) ~= "table") then
					outputDebugString(string.format("[GROUPS] Wystapil blad z ladowaniem permow. ID gracza: %d. ID grupy: %d.", getElementData(playerElement, "charID"), tonumber(groupID)))
					query.perms = {}
				end
				query.dutyData = fromJSON(tostring(query.dutyData))
				if type(query.dutyData) ~= "table" then query.dutyData = {} end
				if not query.dutyTime then
					query.dutyTime = 0
				end
				playerGroups[playerElement][groupID] = query
				outputChatBox("* Uprawnienia w grupie "..groupInfo.name.." zostały przeładowane (WEB).", playerElement, 255, 0, 0)
			end
		end
	end
	return
end

function doesPlayerHaveGroup(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroups[player]) == "table") then
		if(type(playerGroups[player][groupID]) == "table") then
			if(tonumber(playerGroups[player][groupID].groupID)) then return true end
		end
	end
	return false
end

function isGroup(groupID)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return false end
	return true
end

function doesPlayerHavePerm(player, groupID, permName)
	permName = string.lower(permName)
	if(not exports.titan_login:isLogged(player)) then return false end
	if exports.titan_admin:doesAdminHavePerm(player, "orgs") then return true end
	if(type(playerGroups[player]) == "table") then
		if(type(playerGroups[player][groupID]) == "table") then
			if(tonumber(playerGroups[player][groupID].groupID)) then
				if playerGroups[player][groupID].perms["leader"] then return true end
				if playerGroups[player][groupID].perms[permName] then return true end
			end
		end
	end
	return false
end

function getPlayerPerms(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroups[player]) == "table") then
		if(type(playerGroups[player][groupID]) == "table") then
			if(tonumber(playerGroups[player][groupID].groupID)) then
				if(type(playerGroups[player][groupID].perms) == "table") then
					return playerGroups[player][groupID].perms
				end
			end
		end
	end
	return false
end

function doesGroupHavePerm(groupID, permName)
	permName = string.lower(permName)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return false end
	if(type(groupInfo.perms) ~= "table") then return false end
	if(groupInfo.perms[permName]) then return true end
	return false
end

function getGroupColor(groupID)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return false end
	return groupInfo.r, groupInfo.g, groupInfo.b
end

function doesPlayerHaveGroupLeader(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroups[player]) == "table") then
		if(type(playerGroups[player][groupID]) == "table") then
			if(tonumber(playerGroups[player][groupID].groupID)) then
				if(playerGroups[player][groupID].perms["leader"]) then return true end
			end
		end
	end
	return false
end

function getPlayerGroupRankName(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroups[player]) == "table") then
		if(type(playerGroups[player][groupID]) == "table") then
			if(tonumber(playerGroups[player][groupID].groupID)) then
				return playerGroups[player][groupID].name
			end
		end
	end
	return "Brak"
end

function getDefaultGroupRank(groupID)
	local query, rows = exports.titan_db:query("SELECT ID, name, perms FROM _groups_ranks WHERE groupID = ? AND defaultRank = '1' LIMIT 1", groupID)
	if(rows <= 0) then return false end
	return query[1].ID, query[1].name, fromJSON(query[1].perms)
end

function getGroupInfo(groupID)
	local index = groupsIndex[groupID]
	if(not index or not tonumber(index)) then return false end
	if(type(groupsData[index]) ~= "table") then return false end
	--outputConsole(toJSON(groupsData[index]))
	return groupsData[index]
end

function getPlayerGroupFromSlot(player, slot)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroups[player]) ~= "table") then return false end
	if(type(playerGroupsIndex[player]) ~= "table") then return false end

	if(not tonumber(playerGroupsIndex[player][slot])) then return false end
	return tonumber(playerGroupsIndex[player][slot])
end

function getPlayerDuty(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	local pGroups = getPlayerGroupsEx(player)
	--outputChatBox(toJSON(pGroups))
	if(not pGroups) then return false end
	for k, v in ipairs(pGroups) do
		if(v.duty) then return tonumber(v.groupID) end
	end
	return false
end

function setPlayerDuty(player, groupID, state)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(not doesPlayerHaveGroup(player, groupID)) then return false end

	local pDuty = getPlayerDuty(player)
	if tonumber(pDuty) and pDuty ~= groupID then
		playerGroups[player][tonumber(pDuty)].duty = false
	end

	playerGroups[player][groupID].duty = state

	if(state) then
		local groupInfo = getGroupInfo(groupID)
		if(groupInfo) then
			setElementData(player, "groupDutyID", groupID)
			setElementData(player, "groupDutyColor", {groupInfo.r, groupInfo.g, groupInfo.b})
			setElementData(player, "GroupDutyTag", groupInfo.tag)
			if doesGroupHavePerm(groupInfo.ID, "cduty") then
				setElementData(player, "groupDutyTagOn", true)
			else
				if getElementData(player, "groupDutyTagOn") then
					removeElementData(player, "groupDutyTagOn")
				end
			end
		end
		setDutyTime(player, groupID, true)
	else
		removeElementData(player, "groupDutyID")
		removeElementData(player, "groupDutyColor")
		removeElementData(player, "GroupDutyTag")
		removeElementData(player, "groupDutyTagOn")
		setDutyTime(player, groupID, false)
	end
	return true
end

function getPlayerDutyInGroup(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(not doesPlayerHaveGroup(player, groupID)) then return false end
	return playerGroups[player][groupID].duty
end

function addPlayerToGroup(player, groupID, rankID, rankName, permsy)
	if(not exports.titan_login:isLogged(player)) then return false end
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return false end
	exports.titan_db:query_free("INSERT INTO _groups_members SET userID = ?, rankID = ?, groupID = ?", getElementData(player, "charID"), rankID, groupID)

	if(type(playerGroups[player]) ~= "table") then
		playerGroups[player] = {}
	end
	playerGroups[player][groupID] = 
	{
		name = rankName,
		perms = permsy,
		groupID = groupID,
		duty = false
	}
	local freeSlot = getFreePlayerGroupSlot(player)
	playerGroupsIndex[player][freeSlot] = groupID

	if doesGroupHavePerm(groupID, "gangzones") then
		for k, v in ipairs(getElementsByType("radararea")) do
			setElementVisibleTo(v, player, true)
		end
	end

	return true
end

function getFreePlayerGroupSlot(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	local i = 1
	while(true) do
		if(not tonumber(playerGroupsIndex[player][i])) then return i end
		i = i + 1
	end
	return false
end

function getSlotFromGroup(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroupsIndex[player]) ~= "table") then return false end
	
	for k, v in pairs(playerGroupsIndex[player]) do
		if(v == groupID) then return k end
	end
	return false
end

function removePlayerFromGroup(player, groupID)
	if(not exports.titan_login:isLogged(player)) then return false end
	exports.titan_db:query_free("DELETE FROM _groups_members WHERE groupID = ? AND userID = ?", groupID, getElementData(player, "charID"))
	playerGroups[player][groupID] = nil
	local groupSlot = getSlotFromGroup(player, groupID)
	if(tonumber(groupSlot)) then
		playerGroupsIndex[player][groupSlot] = nil
	end
	if doesGroupHavePerm(groupID, "gangzones") then
		for k, v in ipairs(getElementsByType("radararea")) do
			setElementVisibleTo(v, player, false)
		end
	end
	return true
end

function getPlayerGroupInfo(player, groupID)
	if not exports.titan_login:isLogged(player) then return false end
	if type(playerGroupsIndex[player]) ~= "table" then return false end
	if type(playerGroups[player][groupID]) == "table" then
			if tonumber(playerGroups[player][groupID].groupID) then
				return playerGroups[player][groupID]
			end
		end

end

function getPlayerGroupsEx(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroupsIndex[player]) ~= "table") then return false end
	local tempTab = {}
	local i = 0
	for k, v in pairs(playerGroupsIndex[player]) do
			i = i + 1
			local tempTab2 = {}
			tempTab2.slot = k
			tempTab2.rankName = playerGroups[player][v].name
			tempTab2.playerPerms = playerGroups[player][v].perms
			tempTab2.duty = playerGroups[player][v].duty
			tempTab2.cash = playerGroups[player][v].cash
			tempTab2.groupID = playerGroups[player][v].groupID
			tempTab[i] = tempTab2
	end
	if(#tempTab <= 0) then return false end
	return tempTab
end

function getPlayerGroups(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(type(playerGroupsIndex[player]) ~= "table") then return false end
	local tempTab = {}
	local i = 0
	for k, v in pairs(playerGroupsIndex[player]) do
		local groupInfo = getGroupInfo(v)
		if(groupInfo) then
			i = i + 1
			local tempTab2 = {}
			tempTab2.slot = k
			tempTab2.rankName = playerGroups[player][v].name
			tempTab2.playerPerms = playerGroups[player][v].perms
			tempTab2.duty = playerGroups[player][v].duty
			tempTab2.cash = playerGroups[player][v].cash
			tempTab2.groupInfo = groupInfo
			tempTab[i] = tempTab2
		end
	end
	if(#tempTab <= 0) then return false end
	return tempTab
end

function sendGroupICMessage(player, slotID, message)
	if(not exports.titan_login:isLogged(player)) then return false end
	local groupID = getPlayerGroupFromSlot(player, slotID)
	if(not groupID) then
		exports.titan_noti:showBox(player, "Nie posiadasz grupy o takim slocie.")
		return
	end
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then
		exports.titan_noti:showBox(player, "Grupa nie istnieje.")
		return
	end
	if(not doesGroupHavePerm(groupInfo.ID, "chatic")) then
		exports.titan_noti:showBox(player, "Grupa nie posiada uprawnień do korzystania z czatu IC.")
		return
	end
	local name = exports.titan_chats:getPlayerICName(player)
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			if(doesPlayerHaveGroup(v, groupID)) then
				local slot = getSlotFromGroup(v, groupID)
				if(tonumber(slot)) then
					local newMessage = string.format("!%d ** [%s] %s: %s **", slot, groupInfo.tag, name, message)
					if v:getData("sampChat") then
						exports.titan_chats:sendPlayerChatMessage(v, newMessage, groupInfo.r, groupInfo.g, groupInfo.b, false)
					else
						outputChatBox(newMessage, v, groupInfo.r, groupInfo.g, groupInfo.b)
					end
				end
			end
		end
	end
	exports.titan_logs:groupMessageIC(groupInfo.ID, groupInfo.name, string.format("%s: %s", name, message))
	return true
end

function sendGroupOOCMessage(player, slotID, message)
	if(not exports.titan_login:isLogged(player)) then return false end
	local groupID = getPlayerGroupFromSlot(player, slotID)
	if(not groupID) then return exports.titan_noti:showBox(player, "Nie posiadasz grupy o takim slocie.") end
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return exports.titan_noti:showBox(player, "Grupa nie istnieje.") end
	if(not doesGroupHavePerm(groupInfo.ID, "chatooc")) then return exports.titan_noti:showBox(player, "Grupa nie posiada uprawnień do korzystania z czatu OOC.") end
	local oocName = getElementData(player, "globalName")
	local r, g, b = groupInfo.r * 0.8, groupInfo.g * 0.8, groupInfo.b * 0.8
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			if(doesPlayerHaveGroup(v, groupID)) then
				local slot = getSlotFromGroup(v, groupID)
				if(tonumber(slot)) then
					local newMessage = string.format("@%d (( [%s] %s: %s ))", slot, groupInfo.tag, oocName, message)
					if v:getData("sampChat") then
						exports.titan_chats:sendPlayerChatMessage(v, newMessage, r, g, b, false)
					else
						exports.titan_chats:addPlayerOOCMessage(v, newMessage, r, g, b)
					end
				end
			end
		end
	end
	exports.titan_logs:groupMessageOOC(groupInfo.ID, groupInfo.name, string.format("%s: %s", oocName, message))
	return true
end

function changePlayerRank(player, groupID, rankID, rankName, rankPerms)
	if not exports.titan_login:isLogged(player) then return end
	local groupInfo = getGroupInfo(groupID)
	if not groupInfo then return end
	if not doesPlayerHaveGroup(player, groupInfo.ID) then return end

	if type(playerGroups[player][groupInfo.ID]) ~= "table" then return end
	playerGroups[player][groupInfo.ID].name = rankName
	playerGroups[player][groupInfo.ID].perms = rankPerms

	exports.titan_db:query_free("UPDATE _groups_members SET rankID = ? WHERE userID = ? AND groupID = ?", rankID, getElementData(player, "charID"), groupInfo.ID)
end

--[[function sendDepoMessage(player, message)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(not doesPlayerCanDepoChat(player)) then return false end
	local groupInfo = getGroupInfo(getPlayerDuty(player))
	if(not groupInfo) then return false end
	local faceCode = tostring(getElementData(player, "faceCode"))
	for k, v in ipairs(getElementsByType("player")) do
		if(doesPlayerCanDepoChat(v)) then
			local nick = exports.titan_chats:getPlayerSavedNameFromFaceCode(v, faceCode)
			outputChatBox(string.format("** [%s] %s: %s **", string.upper(tostring(groupInfo.tag)), nick, message), v)
		end
	end
	return true
end]]

function doesPlayerCanDepoChat(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	local playerDuty = getPlayerDuty(player)
	if(not playerDuty) then return false end
	if(not isGroup(playerDuty)) then return false end
	if(not doesGroupHavePerm(playerDuty, "ChatDept")) then return false end
	if(not doesPlayerHavePerm(player, playerDuty, "ChatDept")) then return false end
	return true
end

function getAvailableOrders(groupID)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return false end
	local categories = exports.titan_db:query("SELECT * FROM _orderscat WHERE (orderType <> '0' AND orderType = ?) OR (orderType = '0' AND orderOwner = ?)", groupInfo.orderType, groupInfo.ID)
	if(#categories <= 0) then return false end
	local numbers = {}
	for k, v in ipairs(categories) do
		table.insert(numbers, v.ID)
	end
	numbers = table.concat(numbers, ",")
	local orders = exports.titan_db:query("SELECT * FROM _orders WHERE catID IN ("..numbers..")")
	if(#orders <= 0) then return false end
	return categories, orders
end

function getPlayersInGroup(groupID)
	local tmpTable = {}
	for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
			if doesPlayerHaveGroup(v, groupID) then
				if getPlayerDuty(v) == groupID then table.insert(tmpTable, {player = v, duty = true})
				else table.insert(tmpTable, {player = v, duty = false}) end
			end
		end
	end
	if #tmpTable <= 0 then return false end
	return tmpTable
end

function getAvailableDelivers()
	local query = exports.titan_db:query("SELECT ID, name FROM _delivers WHERE deliverID = '0'")
	if(#query <= 0) then return false end
	return query
end

function getFreeIndex()
	local i = 1
	while(true) do
		if(type(groupsData[i]) ~= "table") then return i end
		i = i + 1
	end
end

function saveGroupEdit(groupID, name, tag, colorR, colorG, colorB, perms)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then
		return
	end

	local gangzones = false
	if doesGroupHavePerm(groupID, "gangzones") then
		gangzones = true
	end
	if not perms["gangzones"] then
		if gangzones then
			for k, v in ipairs(getElementsByType("player")) do
				if exports.titan_login:isLogged(v) then
					if doesPlayerHaveGroup(v, groupID) then
						for k1, v1 in ipairs(getElementsByType("radararea")) do
							setElementVisibleTo(v1, v, false)
						end
					end
				end
			end
		end
	else
		if not gangzones then
			for k, v in ipairs(getElementsByType("player")) do
				if exports.titan_login:isLogged(v) then
					if doesPlayerHaveGroup(v, groupID) then
						for k1, v1 in ipairs(getElementsByType("radararea")) do
							setElementVisibleTo(v1, v, true)
						end
					end
				end
			end
		end
	end

	groupInfo.name = name
	groupInfo.tag = tag
	groupInfo.r = colorR
	groupInfo.g = colorG
	groupInfo.b = colorB
	groupInfo.perms = perms
	exports.titan_db:query_free("UPDATE _groups SET name = ?, tag = ?, r = ?, g = ?, b = ?, perms = ? WHERE ID = ?", name, tag, colorR, colorG, colorB, tostring(toJSON(perms)), groupInfo.ID)
end

function createGroup(player, name, isPlayerGroup)
	local res, rows, groupID = exports.titan_db:query("INSERT INTO _groups SET name = ?, tag = 'XXXX', orderType = '0', mainLeader = ?", tostring(name), isPlayerGroup and player:getData("charID") or 0)
	local leaderPerms = '[{"leader": true}]'
	local res, rows, leaderRankID = exports.titan_db:query("INSERT INTO _groups_ranks SET name = 'Lider', groupID = ?, cash = '0', defaultRank = '0', perms = ?", groupID, leaderPerms)
	local defaultPerms = '[{}]'
	exports.titan_db:query_free("INSERT INTO _groups_ranks SET name = 'Default', groupID = ?, cash = '0', defaultRank = '1', perms = ?", groupID, defaultPerms)
	
	local index = getFreeIndex()

	groupsData[index] = 
	{
		ID = groupID,
		name = name,
		tag = "XXXX",
		r = 255,
		g = 255,
		b = 255,
		orderType = 0,
		perms = {},
		account = 0,
		mainLeader = isPlayerGroup and player:getData("charID") or 0
	}
	groupsIndex[groupID] = index

	addPlayerToGroup(player, groupID, leaderRankID, "Lider", fromJSON(leaderPerms))
	return groupID
end

function removeGroup(groupID)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then
		return false, 1
	end

	exports.titan_db:query_free("DELETE FROM _groups WHERE ID = ?", groupInfo.ID)
	exports.titan_db:query_free("DELETE FROM _groups_members WHERE groupID = ?", groupInfo.ID)
	exports.titan_db:query_free("DELETE FROM _groups_ranks WHERE groupID = ?", groupInfo.ID)
	exports.titan_db:query_free("DELETE FROM _couriers WHERE groupID = ?", groupInfo.ID)

	groupsData[groupsIndex[groupID]] = nil
	groupsIndex[groupID] = nil

	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			playerGroups[v][groupID] = nil
			local groupSlot = getSlotFromGroup(v, groupID)
			if(tonumber(groupSlot)) then
				playerGroupsIndex[v][groupSlot] = nil
				if v:getData("groupDutyID") and v:getData("groupDutyID") == groupID then
					removeElementData(v, "groupDutyID")
					removeElementData(v, "groupDutyColor")
					removeElementData(v, "GroupDutyTag")
				end
				exports.titan_noti:showBox(v, string.format("Grupa %s w której byłeś została usunięta przez osobę do tego uprawnioną.", groupInfo.name))
			end
		end
	end
	
	return true
end

function changeGroupData(groupID, dataName, data)
	if not tonumber(groupsIndex[groupID]) then return false end
	local index = groupsIndex[groupID]
	if type(groupsData[index]) ~= "table" then return false end
	--outputConsole(toJSON(groupsData[index]))
	groupsData[index][dataName] = data
	--local groupInfo = getGroupInfo(groupID)
	--if(not groupInfo) then return false end
	--local oldData = groupsData[groupsIndex[groupInfo.ID]][dataName]
	--outputConsole(toJSON(groupInfo))
	--groupsData[groupsIndex[groupInfo.ID]][dataName] = data
	--outputChatBox(string.format("No to teraz tak: Zmieniliśmy %s, stara wartość: %s, nowa %s w grupie ID %s.", tostring(dataName), tostring(oldData), tostring(data), tostring(groupID)))
	exports.titan_db:query_free("UPDATE _groups SET ?? = ? WHERE ID = ?", tostring(dataName), tostring(data), groupsData[index].ID)
	return true
end


------------
-- EVENTY --
------------

function onClientOrderFinalize(player, groupID, intID, orderID, stock)
	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then
		exports.titan_noti:showBox(player, "Grupa nie istnieje.")
		return
	end
	if(not doesPlayerHaveGroupLeader(player, groupID)) then
		exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień do składania zamówień.")
		return
	end

	local orderInfo = exports.titan_db:query("SELECT * FROM _orders WHERE ID = ? LIMIT 1", orderID)
	if(#orderInfo <= 0) then 
		exports.titan_noti:showBox(player, "Nie znaleziono takiego zamówienia w bazie danych.")
		return
	end
	orderInfo = orderInfo[1]
	local verify = exports.titan_db:query("SELECT orderType, orderOwner FROM _orderscat WHERE ID = ? LIMIT 1", orderInfo.catID)
	if(#verify <= 0) then
		exports.titan_noti:showBox(player, "Zamówienie znajduje się w kategorii do której nie masz dostępu.")
		return
	end
	verify = verify[1]
	if((verify.orderType == groupInfo.orderType) or (verify.orderType == 0 and verify.orderOwner == groupInfo.ID)) then
		--exports.titan_db:query_free("INSERT INTO _delivers SET intID = ?, pieces = ?, name = ?, data = ?", intID, stock, groupInfo.name, orderInfo.data)
		
		local allPay = 0
		for i = 1, stock do
			allPay = allPay + orderInfo.price
		end

		if groupInfo.account < allPay then
			return exports.titan_noti:showBox(player, "Grupa nie posiada tyle pieniędzy na koncie.")
		end

		takeGroupMoney(groupInfo.ID, allPay, string.format("%s zamówił \"%s\" w ilości %d sztuk.", exports.titan_chats:getPlayerICName(player), orderInfo.name, stock))

		for i = 1, stock do
			exports.titan_db:query_free("INSERT INTO _couriers SET groupID = ?, intID = ?, name = ?, timeStart = UNIX_TIMESTAMP(), data = ?, price = ?", groupID, intID, groupInfo.name, orderInfo.data, orderInfo.price)
		end
		exports.titan_noti:showBox(player, string.format("Zamówiono %d sztuk(i) \"%s\" dla grupy \"%s\".", stock, orderInfo.name, groupInfo.name))
		return
	else
		exports.titan_noti:showBox(player, "Zamówienie znajduje się w kategorii do której nie masz dostępu.")
		return
	end
end
addEvent("onClientOrderFinalize", true)
addEventHandler("onClientOrderFinalize", root, onClientOrderFinalize)

function getGroupRanks(groupID)
	local query = exports.titan_db:query("SELECT * FROM _groups_ranks WHERE groupID = ?", groupID)
	if #query <= 0 then return false end
	return query
end

function showGroupInfoTable(player, groupInfo, admin)
	local gRanks = {}
	if admin then gRanks = getGroupRanks(groupInfo.ID) end
	triggerClientEvent(player, "createGroupInfoGUI", player, groupInfo, admin and {} or getPlayerPerms(player, groupInfo.ID), admin, gRanks)
end

function getAllGroups()
	if(#groupsData <= 0) then return false end
	return groupsData
end

function getGroupsToDashboard(player)
	if(exports.titan_login:isLogged(player)) then
		local groups = getPlayerGroups(player)
		if(not groups) then groups = {} end
		--exports.titan_dashboard:setPlayerGroups(player, groups)
		return groups
	end
end

function getGroupsListedIn911()
	local groups = {}
	for k, v in ipairs(groupsData) do
		if type(v.perms) == "table" then
			if v.perms["ediall"] then
				table.insert(groups, v)
			end
		end
	end
	return groups
end

function createAlarmPhoneGUI(player)
	if exports.titan_login:isLogged(player) then
		triggerClientEvent(player, "createAlarmPhoneGUI", player, getGroupsListedIn911())
	end
end

function createBlockade(model, x, y, z, rx, ry, rz)
	local pDuty = getPlayerDuty(source)
	if not pDuty then
		exports.titan_noti:showBox(source, "Nie jesteś na duty żadnej grupy.")
		return
	end
	if not doesGroupHavePerm(pDuty, "blockade") then
		exports.titan_noti:showBox(source, "Twoja grupa nie posiada uprawnień do stawiania blokad.")
		return
	end
	if not doesPlayerHavePerm(source, pDuty, "blockade") then
		exports.titan_noti:showBox(source, "Nie posiadasz nadanych uprawnień umożliwiających stawianie blokad.")
		return
	end
	local groupInfo = getGroupInfo(pDuty)

	--Opuszczenie blokad na ziemie
	if (model == 1238) then
	    z = z - 0
	elseif (model == 1282) then
	    z = z - 0.55
	elseif (model == 1434) then
		z = z - 0.2
	end

	if groupInfo then
		local object = createObject(model, x, y, z, rx, ry, rz)
		if isElement(object) then
			object:setData("isBlockade", true)
			object:setData("blockadeGroup", groupInfo.tag)
			object:setData("blockadeGroupID", pDuty)
			object:setData("notBreakable", true)
			object:setData("isFrozen", true)

			object:setInterior(source:getInterior())
			object:setDimension(source:getDimension())
		end
	end
end
addEvent("createBlockade", true)
addEventHandler("createBlockade", root, createBlockade)

function removeBlockade(blockade)
	if isElement(blockade) then
		local pDuty = getPlayerDuty(source)
		if not pDuty then
			exports.titan_noti:showBox(source, "Nie jesteś na duty żadnej grupy.")
			return
		end
		if not doesGroupHavePerm(pDuty, "blockade") then
			exports.titan_noti:showBox(source, "Twoja grupa nie posiada uprawnień do stawiania blokad.")
			return
		end
		if not doesPlayerHavePerm(source, pDuty, "blockade") then
			exports.titan_noti:showBox(source, "Nie posiadasz nadanych uprawnień umożliwiających stawianie blokad.")
			return
		end
		if not blockade:getData("isBlockade") then
			exports.titan_noti:showBox(source, "Ten obiekt nie jest blokadą.")
			return
		end
		if blockade:getData("blockadeGroupID") ~= pDuty then
			exports.titan_noti:showBox(source, "Blokada nie należy do Twojej grupy.")
			return
		end
		exports.titan_noti:showBox(source, "Blokadę usunięto pomyślnie.")
		destroyElement(blockade)
	end
end
addEvent("removeBlockade", true)
addEventHandler("removeBlockade", root, removeBlockade)

function getArrestsDataFromInterior(interiorID)
	local tmpTable = {}
	for k, v in ipairs(arrestData) do
		if v.interior == interiorID then table.insert(tmpTable, v) end
	end
	if #tmpTable <= 0 then return false end
	return tmpTable
end

function getArrestData(ID)
	for k,v in ipairs(arrestData) do
		if v.ID == ID then
			return v
		end
	end
	return false
end

function getNearestArrest(player, interiorID, x, y, z, radius)
	local arrests = getArrestsDataFromInterior(interiorID)
	local nearData = 
	{
		dist = radius and radius or 10.0
	}
	local dim, int = player:getDimension(), player:getInterior()
	for k, v in ipairs(arrests) do
		if v.int == int and v.dim == dim then
			local tmpDist = getDistanceBetweenPoints3D(x, y, z, v.x, v.y, v.z)
			if tmpDist < nearData.dist then
				nearData.dist = tmpDist
				nearData.ID = k
			end
		end
	end
	if not nearData.ID then return false end
	return arrests[nearData.ID]
end

function getArrestKeyFromID(arrestID)
	for k, v in ipairs(arrestData) do
		if v.ID == arrestID then return k end
	end
	return false
end

function createNewArrest(interiorID, x, y, z, name, int, dim)
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _arrests SET name = ?, interior = ?, x = ?, y = ?, z = ?, `int` = ?, dim = ?", name, interiorID, x, y, z, int, dim)
	if not tonumber(lastID) then return false end

	local tmpTable = 
	{
		ID = lastID,
		name = name,
		interior = interiorID,
		x = x,
		y = y,
		z = z,
		int = int,
		dim = dim
	}
	table.insert(arrestData, tmpTable)
	return true
end

-- CZAS NA DUTY
function setDutyTime(player, groupID, dutyState)
	if type(playerGroups[player][groupID]) == "table" then
		if dutyState then
			local query, rows, lastID = exports.titan_db:query("INSERT INTO _groups_duty SET groupID = ?, userID = ?, start = UNIX_TIMESTAMP(), end = '0', afkTime = ?", groupID, player:getData("charID"), player:getData("afkTime"))
			if lastID then
				if type(playerGroups[player][groupID].dutyData) ~= "table" then playerGroups[player][groupID].dutyData = {} end
				playerGroups[player][groupID].dutyData =
				{
					dbID = lastID
				}
			end
		else
			local tab = playerGroups[player][groupID].dutyData
			if type(tab) == "table" then
				if tonumber(tab.dbID) then
					exports.titan_db:query_free("UPDATE _groups_duty SET end = UNIX_TIMESTAMP(), afkTime = ? - afkTime WHERE ID = ?", player:getData("afkTime"), tab.dbID)
				end
				playerGroups[player][groupID].dutyData = false
			end
		end
	end
end

function removeArrest(arrestID)
	local key = getArrestKeyFromID(arrestID)
	if not key then return false end
	table.remove(arrestData, key)
	exports.titan_db:query("DELETE FROM _arrests WHERE ID = ?", arrestID)
	return true
end

function isLeapYear(year)
    if year then year = math.floor(year)
    else year = getRealTime().year + 1900 end
    return ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0)
end

function getTimestamp(year, month, day, hour, minute, second)
    -- initiate variables
    local monthseconds = { 2678400, 2419200, 2678400, 2592000, 2678400, 2592000, 2678400, 2678400, 2592000, 2678400, 2592000, 2678400 }
    local timestamp = 0
    local datetime = getRealTime()
    year, month, day = year or datetime.year + 1900, month or datetime.month + 1, day or datetime.monthday
    hour, minute, second = hour or datetime.hour, minute or datetime.minute, second or datetime.second
 
    -- calculate timestamp
    for i=1970, year-1 do timestamp = timestamp + (isLeapYear(i) and 31622400 or 31536000) end
    for i=1, month-1 do timestamp = timestamp + ((isLeapYear(year) and i == 2) and 2505600 or monthseconds[i]) end
    timestamp = timestamp + 86400 * (day - 1) + 3600 * hour + 60 * minute + second
 
    timestamp = timestamp - 3600 --GMT+1 compensation
    if datetime.isdst then timestamp = timestamp - 3600 end
 
    return timestamp
end

function getPlayerDutyTime(charID, groupID, hourStart, hourEnd)
	local query = exports.titan_db:query("SELECT ID, start, end as timeEnd FROM _groups_duty WHERE userID = ? AND groupID = ?", charID, groupID)
	local countTime = 0
	for k, v in ipairs(query) do
		if v.timeEnd == 0 then v.timeEnd = getRealTime().timestamp end

		if v.timeEnd > v.start then
			if hourStart < v.start and hourEnd >= v.timeEnd then
				countTime = countTime + (v.timeEnd - v.start)
			elseif hourStart >= v.start and hourEnd >= v.timeEnd and v.timeEnd > hourStart then
				countTime = countTime + (v.timeEnd - hourStart)
			end
		end
	end
	return countTime
end

function isPlayerInInterior(player, groupInfo)
	local dim = getElementDimension(player)
	if dim == 0 then
		local playerZone = exports.titan_spheres:getPlayerZone(player)
		if not playerZone then
			return false, "Nie jesteś w miejscu do tego wyznaczonym."
		end
		if not exports.titan_spheres:doesOwnerHasPerm(playerZone, 2, groupInfo.ID) then
			return false, "Grupa "..groupInfo.name.." nie jest członkiem tej strefy."
		end
		if not exports.titan_spheres:doesSphereHasFlag(playerZone, "podaj") then
			return false, "Strefa nie ma dostępu do komendy /podaj."
		end
		return true
	else
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dim)
		if not doorInfo then return false, "Nie jesteś w żadnym interiorze." end
		if doorInfo.ownerType ~= 2 or doorInfo.owner ~= tonumber(groupInfo.ID) then return false, "Ten interior nie należy do Twojej grupy." end
		return true
	end
	return false
end

function sendGiveOffer(player, target, itemID)
	if not exports.titan_login:isLogged(player) then return end
	local playerDuty = getPlayerDuty(player)
	if not playerDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
	local groupInfo = getGroupInfo(playerDuty)
	if not groupInfo then return exports.titan_noti:showBox(player, "Grupa na której duty przebywasz nie istnieje w systemie.") end
	if not doesGroupHavePerm(playerDuty, "give") then return exports.titan_noti:showBox(player, "Grupa nie posiada dostępu do komendy /podaj.") end
	if not doesPlayerHavePerm(player, playerDuty, "give") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do użycia komendy /podaj.") end
	local doorInfo
	local can, err = isPlayerInInterior(player, groupInfo)
	if not can then
		if err then
			exports.titan_noti:showBox(player, err)
		else
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnien do użycia tej komendy w tym miejscu.")
		end
		return
	end
	if player:getDimension() == 0 then
		local sphereInfo = exports.titan_spheres:getSphereInfo(exports.titan_spheres:getPlayerZone(player))
		if not sphereInfo then
			return exports.titan_noti:showBox(player, "Strefa nie istnieje.")
		end
		if not sphereInfo.intID or sphereInfo.intID == 0 then
			return exports.titan_noti:showBox(player, "Budynek nie istnieje (1).")
		end
		doorInfo = exports.titan_doors:getDoorInfo(sphereInfo.intID)
		if not doorInfo then
			return exports.titan_noti:showBox(player, "Budynek nie istnieje (2).")
		end
	else
		doorInfo = exports.titan_doors:getDoorInfoFromDimension(player:getDimension())
		if not doorInfo then
			return exports.titan_noti:showBox(player, "Budynek nie istnieje.")
		end
	end
	if doorInfo.ownerType ~= 2 or doorInfo.owner ~= groupInfo.ID then
		return exports.titan_noti:showBox(player, "Budynek nie należy do Twojej grupy.")
	end
	if not exports.titan_login:isLogged(target) then return exports.titan_noti:showBox(player, "Nie znaleziono takiego gracza.") end
	if getDistanceBetweenPoints3D(player:getPosition(), target:getPosition()) > 4.0 or player:getDimension() ~= target:getDimension() or player:getInterior() ~= target:getInterior() then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end

	local magazineItem = exports.titan_doors:getMagazineItem(doorInfo.ID, itemID)
	if not magazineItem then return exports.titan_noti:showBox(player, "Nie znaleziono podanego przedmiotu w magazynie.") end
	exports.titan_offers:createNewOffer(player, target, "podaj", {name = magazineItem.name, price = magazineItem.sellPrice, itemID = itemID})
	exports.titan_noti:showBox(player, "Oferta została wysłana.")
end
addEvent("sendGiveOffer", true)
addEventHandler("sendGiveOffer", root, sendGiveOffer)


-- LECZENIE
local healData = {}
function getHealDataFreeIndex()
	local i = 1
	while true do
		if type(healData[i]) ~= "table" then return i end
		i = i + 1
	end
end

function startHeal(player, target)
	local index = getHealDataFreeIndex()
	healData[index] = 
	{
		player = player,
		target = target
	}
	healData[index].timer = setTimer(healTimer, 1000, 0, index)
end

function isPlayerCanHeal(player)
	for k, v in pairs(healData) do
		if v and type(v) == "table" then
			if v.player == player or v.target == player then return false end
		end
	end
	return true
end

function healTimer(ID)
	local data = healData[ID]
	if data then
		if not isElement(data.player) or not isElement(data.target) then
			if isTimer(data.timer) then killTimer(data.timer) end
			
			if isElement(data.player) then
				exports.titan_noti:showBox(data.player, "Proces leczenia został przerwany.")
				setElementData(data.player, "playerHealing", nil)
			end
			
			if isElement(data.target) then
				exports.titan_noti:showBox(data.target, "Proces leczenia został przerwany.")
				setElementData(data.target, "healedBy", nil)
			end
		end
		if getDistanceBetweenPoints3D(data.player:getPosition(), data.target:getPosition()) < 5.0 then
		
			if not isElement(getElementData(data.player, "playerHealing")) then
				if isTimer(data.timer) then killTimer(data.timer) end
				exports.titan_noti:showBox(data.player, "Proces leczenia został przerwany.")
				return 
			end
			
			if not isElement(getElementData(data.target, "healedBy")) then
				if isTimer(data.timer) then killTimer(data.timer) end
				exports.titan_noti:showBox(data.target, "Proces leczenia został przerwany.")
				return 
			end
			
			local health = getElementHealth(data.target)
			health = health + 5
			if health > 100 then health = 100 end
			setElementHealth(data.target, health)
			if health == 100 then
				if isElement(data.player) then
					exports.titan_noti:showBox(data.player, "Proces leczenia został zakończony.")
					setElementData(data.player, "playerHealing", nil)
				end
				if isElement(data.target) then
					exports.titan_noti:showBox(data.target, "Proces leczenia został zakończony.")
					setElementData(data.target, "healedBy", nil)
					setElementData(data.target, "damageType", 0)
					exports.titan_db:query_free("UPDATE _characters SET damagetype = 0 WHERE ID = ?", data.target:getData("charID"))
				end
				if isTimer(data.timer) then killTimer(data.timer) end
				healData[ID] = nil
			end
		end
	end
end
addCommandHandler("tas", function() 
outputChatBox(getPlayerDutyTime(80, 2, getTimestamp(2016, 5, 23, 0, 0, 0), getTimestamp(2016, 5, 23, 1, 0, 0))) end)

local countyLosSantosID = 1

function paydayFunc()
	local time = getTickCount()
	--
		local allGroups = exports.titan_db:query("SELECT * FROM _groups WHERE ID <> ?", countyLosSantosID)
		if #allGroups > 0 then
			for _, group in ipairs(allGroups) do
				if group.dotation > 0 then
					local members = exports.titan_query("SELECT * FROM _groups_members WHERE groupID = ?", group.ID)
					if #members > 0 then
						for _, member in ipairs(members) do
							-- Pojedynczy player
							local dutyTime = 0
							local mDutyTime = exports.titan_db:query("SELECT * FROM _groups_duty WHERE groupID = ? AND userID = ? AND old = 0", group.ID, member.userID)
							if #mDutyTime > 0 then
								for k, v in ipairs(mDutyTime) do
									if v["end"] > 0 then
										dutyTime = dutyTime + (v["end"] - v.start)
									end
								end
							end
							local playerCash = 0
							if dutyTime > 60 * 45 and dutyTime <= 60 * 90 then
								playerCash = 1.0
							elseif dutyTime > 60 * 90 then
								playerCash = 1.5
							end

							if playerCash > 0 then
								playerCash = math.floor(playerCash * member)

								exports.titan_db:query_free("UPDATE _groups SET account = account - ? WHERE ID = ?", group.dotation, countyLosSantosID)
								local dotationForGroup = group.dotation - playerCash
								if dotationForGroup > 0 then
									exports.titan_db:query_free("UPDATE _groups SET account = account + ? WHERE ID = ?", dotationForGroup, group.ID)
								end

								local query = exports.titan_db:query("SELECT ID, balance FROM _accounts WHERE ownerType = '1' AND owner = ? ORDER BY ID ASC LIMIT 1", player:getData("charID"))
								if #query <= 0 then
									exports.titan_db:query_free("UPDATE _groups SET account = account + ? WHERE ID = ?", playerCash, group.ID)
								else
									exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", playerCash, query[1].ID)
									exports.titan_db:query_free("INSERT INTO _accounts_logs SET accountID = ?, title = 'Wypłata z grupy "..group.name.."', cash = ?, actualBalance = ?", query[1].ID, playerCash, query[1].balance + playerCash)
								end
							end
						end
					end
				end
			end
		end
		exports.titan_db:query_free("UPDATE _groups_duty SET old = 1")
	--
	outputDebugString(string.format("[ORGS] Payday wyplacony! | %dms", getTickCount() - time))
	outputServerLog(string.format("[ORGS] Payday wyplacony! | %dms", getTickCount() - time))
	outputConsole(string.format("[ORGS] Payday wyplacony! | %dms", getTickCount() - time))
end

function takeGroupMoney(groupID, money, text)
	local groupInfo = getGroupInfo(groupID)
	if groupInfo then
		groupInfo.account = groupInfo.account - math.abs(money)
		exports.titan_db:query_free("UPDATE _groups SET account = ? WHERE ID = ?", groupInfo.account, groupInfo.ID)
		exports.titan_db:query_free("INSERT INTO _groups_accounts SET data = UNIX_TIMESTAMP(), groupID = ?, value = ?, tax = ?, type = ?, info = ?", groupInfo.ID, math.abs(money), 0, 2, text)
	end
end

function giveGroupMoney(groupID, money, tax, text)
	local groupInfo = getGroupInfo(groupID)
	if groupInfo then
		groupInfo.account = groupInfo.account + money
		exports.titan_db:query_free("UPDATE _groups SET account = ? WHERE ID = ?", groupInfo.account, groupInfo.ID)
		exports.titan_db:query_free("INSERT INTO _groups_accounts SET data = UNIX_TIMESTAMP(), groupID = ?, value = ?, tax = ?, type = ?, info = ?", groupInfo.ID, money, tax, 1, text)
	end
end

function giveGovermentMoney(money, text)
	if money > 0 then
		giveGroupMoney(1, money, 0, text)
	end
end

function getGovTax(name)
	if tonumber(govTaxes[name]) then return tonumber(govTaxes[name]) end
	return false
end