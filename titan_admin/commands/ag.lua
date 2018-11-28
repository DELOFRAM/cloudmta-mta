----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:33
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:36
----------------------------------------------------

function cmdAg(player, command, ...)
	if not doesAdminHavePerm(player, "orgs") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local legend = "lista, stworz, usun, edytuj, info, wejdz, kolor, rank, order"
	local option1 = string.lower(tostring(arg[1]))
	if(option1 == "stworz") then
		local name = table.concat(arg, " ", 2)
		if(not name or string.len(name) < 3) then
			exports.titan_noti:showBox(player, "TIP: /ag stworz [nazwa]")
			return
		end
		name = tostring(name)
		local groupID = exports.titan_orgs:createGroup(player, name)
		exports.titan_noti:showBox(player, string.format("Grupa stworzona pomyślnie (ID: %d).", groupID))
	elseif(option1 == "lista") then
		local allGroups = exports.titan_orgs:getAllGroups()
		if(not allGroups) then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnych grup.")
			return
		end
		triggerClientEvent(player, "listGroupFunc.create", player, allGroups)
		return
	elseif(option1 == "edytuj") then
		local groupID = arg[2]
		if(not tonumber(groupID)) then
			exports.titan_noti:showBox(player, "TIP: /ag edytuj [ID grupy]")
			return
		end
		groupID = tonumber(groupID)
		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if(not groupInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono grupy o podanym ID.")
			return
		end
		triggerClientEvent(player, "editGroupFunc.create", player, groupInfo)
		return
	elseif(option1 == "info") then
		local groupID = arg[2]
		if(not tonumber(groupID)) then
			exports.titan_noti:showBox(player, "TIP: /ag info [ID grupy]")
			return
		end
		groupID = tonumber(groupID)
		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if(not groupInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono grupy o podanym ID.")
			return
		end
		exports.titan_orgs:showGroupInfoTable(player, groupInfo, true)
	elseif(option1 == "usun") then
		local groupID = arg[2]
		if(not tonumber(groupID)) then
			exports.titan_noti:showBox(player, "TIP: /ag usun [ID grupy]")
			return
		end
		groupID = tonumber(groupID)
		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if(not groupInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono grupy o podanym ID.")
			return
		end
		local removed, errorn = exports.titan_orgs:removeGroup(groupInfo.ID)
		if(removed) then
			exports.titan_noti:showBox(player, "Grupa została pomyślnie usunięta.")
			return
		else
			exports.titan_noti:showBox(player, "Nie udało się poprawnie usunąć grupy.")
			return
		end	
	elseif option1 == "wejdz" then
		local groupID = arg[2]
		if(not tonumber(groupID)) then
			exports.titan_noti:showBox(player, "TIP: /ag wejdz [ID grupy]")
			return
		end
		groupID = tonumber(groupID)
		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if(not groupInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono grupy o podanym ID.")
			return
		end
		if(exports.titan_orgs:doesPlayerHaveGroup(player, groupID)) then
			exports.titan_noti:showBox(player, "Jesteś już w tej grupie.")
			return
		end
		local defaultRankID, defaultRankName, defaultPerms = exports.titan_orgs:getDefaultGroupRank(groupID)
		if(not defaultRankID) then
			exports.titan_noti:showBox(player, "Musisz ustawić domyślną rangę w panelu aby móc przyjmować innych do grupy.")
			return
		end
		if(exports.titan_orgs:addPlayerToGroup(player, groupID, defaultRankID, defaultRankName, defaultPerms)) then
			exports.titan_noti:showBox(player, "Pomyślnie dodano do grupy.")
			return
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd podczas dodawania do grupy.")
			return
		end
	elseif option1 == "order" then
		local groupID = arg[2]
		local orderID = arg[3]
		if(not tonumber(groupID) or not tonumber(orderID)) then
			exports.titan_noti:showBox(player, "TIP: /ag order [ID grupy] [orderID]")
			return
		end
		groupID = tonumber(groupID)
		orderID = tonumber(orderID)

		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if(not groupInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono grupy o podanym ID.")
			return
		end
		exports.titan_orgs:changeGroupData(groupInfo.ID, "orderType", orderID)
		exports.titan_noti:showBox(player, "Zmieniono pomyślnie.")
	elseif option1 == "kolor" then
		local groupID = arg[2]
		if(not tonumber(groupID)) then
			exports.titan_noti:showBox(player, "TIP: /ag kolor [ID grupy]")
			return
		end
		groupID = tonumber(groupID)
		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if(not groupInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono grupy o podanym ID.")
			return
		end
		triggerClientEvent(player, "playerChooseGroupColor", player, groupInfo.ID)
	elseif option1 == "rank" then
		local playerID = arg[2]
		local groupID = arg[3]
		local rankID = arg[4]

		if not tonumber(playerID) or not tonumber(groupID) or not tonumber(rankID) then
			return exports.titan_noti:showBox(player, "TIP :/ag rank [ID gracza] [ID grupy] [ID rangi]")
		end
		playerID = tonumber(playerID)
		groupID = tonumber(groupID)
		rankID = tonumber(rankID)

		local target = exports.titan_login:getPlayerByID(playerID)
		if not target then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end

		local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
		if not groupInfo then
			return exports.titan_noti:showBox(player, "Grupa o takim ID nie istnieje.")
		end

		if not exports.titan_orgs:doesPlayerHaveGroup(target, groupInfo.ID) then
			return exports.titan_noti:showBox(player, "Gracz nie jest w grupie o podanym ID.")
		end

		local rankInfo = exports.titan_db:query("SELECT * FROM _groups_ranks WHERE ID = ?", rankID)
		if #rankInfo <= 0 then
			return exports.titan_noti:showBox(player, "Nie znaleziono rangi o podanym ID.")
		end
		rankInfo = rankInfo[1]

		if rankInfo.groupID ~= groupInfo.ID then 
			return exports.titan_noti:showBox(player, "Ta ranga nie należy do tej grupy.")
		end

		local perms = fromJSON(rankInfo.perms)
		if type(perms) ~= "table" then perms = {} end
		exports.titan_orgs:changePlayerRank(target, groupInfo.ID, rankInfo.ID, rankInfo.name, perms)

		exports.titan_noti:showBox(player, "Ranga gracza została ustawiona.")
		exports.titan_noti:showBox(target, "Administrator zmienił Ci rangę w grupie "..groupInfo.name..".")
	else
		exports.titan_noti:showBox(player, string.format("TIP: /ag [%s]", legend))
		return
	end
end
addCommandHandler("ag", cmdAg, false, false)