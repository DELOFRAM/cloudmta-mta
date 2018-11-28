----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmdG(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return end
	if getElementData(player, "bwTime") then return exports.titan_noti:showBox(player, "Nie możesz zarządzać swoimi grupami podczas BW.") end
	local arg = {...}
	local syntax = "TIP: /g(rupa) [lista / slot grupy / stworz] [info, zapros, wypros, respawn, zamow, id, zgloszenia, pojazdy, wplac, wyplac opusc]"

	if (arg[1] and string.lower(tostring(arg[1])) == "lista") then
		local playerGroups = getPlayerGroups(player)
		if(not playerGroups) then
			exports.titan_noti:showBox(player, "Nie posiadasz żadnych grup.")
			return
		end
		triggerClientEvent(player, "groupMenuGUI.createGUI", player, playerGroups)
		return
	elseif arg[1] == "stworz" then
		if not arg[2] then return exports.titan_noti:showBox(player, "/g stworz [nazwa]") end
		
		local name = table.concat(arg, " ", 2)
		if(not name or string.len(name) < 3) then
			exports.titan_noti:showBox(player, "TIP: /g stworz [nazwa]")
			return
		end
		name = tostring(name)

		local que = exports.titan_db:query("SELECT ID FROM _groups WHERE mainLeader = ?", player:getData("charID"))
		if #que > 0 then return exports.titan_noti:showBox(player, "Możesz mieć maksymalnie jedną własna grupę na postać.") end

		local groupID = createGroup(player, name, true)
		exports.titan_noti:showBox(player, string.format("Grupa stworzona pomyślnie (ID: %d. Nazwa: %s.)", groupID, name))
		triggerEvent("groupEdit.save", player, groupID, name, "", 255, 255, 255, {["listTag"] = nil, ["listColor"] = nil, ["listBalance"] = nil, ["listPerms"] = nil})
		return
	elseif (not tonumber(arg[1])) then
		exports.titan_noti:showBox(player, syntax)
		local playerGroups = getPlayerGroups(player)
		if not playerGroups then return end
		triggerClientEvent(player, "groupMenuGUI.createGUI", player, playerGroups)
		return
	end
	arg[1] = tonumber(arg[1])
	arg[2] = string.lower(tostring(arg[2]))

	local groupID = getPlayerGroupFromSlot(player, arg[1])
	if(not groupID) then
		exports.titan_noti:showBox(player, "Nie znaleziono żadnej grupy na podanym slocie.")
		return
	end

	local groupInfo = getGroupInfo(groupID)
	if(not groupInfo) then return exports.titan_noti:showBox(player, "Ta grupa jest uszkodzona. Zgłoś to administratorowi.") end
	
	-- if(arg[2] == "info") then
		-- showGroupInfoTable(player, groupInfo)
		-- return
	--else
	if(arg[2] == "zapros") then
		if(not doesPlayerHaveGroupLeader(player, groupID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień do użycia tej komendy.")
			return
		end
		if(not tonumber(arg[3])) then
			exports.titan_noti:showBox(player, "TIP: /grupa) [slot] zapros [ID gracza]")
			return
		end
		arg[3] = tonumber(arg[3])

		local elem = exports.titan_login:getPlayerByID(arg[3])
		if(not elem) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end

		if(player == elem) then
			exports.titan_noti:showBox(player, "Nie możesz dodać samego siebie do grupy.")
			return
		end

		if(doesPlayerHaveGroup(elem, groupID)) then
			exports.titan_noti:showBox(player, "Ten gracz jest już w Twojej grupie.")
			return
		end

		local playerGroups = getPlayerGroups(elem)
		if type(playerGroups) == "table" and #playerGroups >= GROUP_LIMIT then
			exports.titan_noti:showBox(player, string.format("Gracz nie może posiadać więcej niż %d grup.", GROUP_LIMIT))
			return
		end

		local defaultRankID, defaultRankName, defaultPerms = getDefaultGroupRank(groupID)
		if(not defaultRankID) then
			exports.titan_noti:showBox(player, "Musisz ustawić domyślną rangę w panelu aby móc przyjmować innych do grupy.")
			return
		end

		if(addPlayerToGroup(elem, groupID, defaultRankID, defaultRankName, defaultPerms)) then
			exports.titan_noti:showBox(player, string.format("Dodałeś gracza %s %s do swojej grupy.", getElementData(elem, "name"), getElementData(elem, "lastname")))
			exports.titan_noti:showBox(elem, string.format("Zostałeś dodany do grupy %s.", groupInfo.name))
			return
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd podczas dodawania gracza do grupy.")
			return
		end

	elseif(arg[2] == "wypros") then
		if(not doesPlayerHaveGroupLeader(player, groupID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień do użycia tej komendy.")
			return
		end
		if(not tonumber(arg[3])) then
			exports.titan_noti:showBox(player, "TIP: /g(rupa) [slot] wypros [ID gracza]")
			return
		end
		arg[3] = tonumber(arg[3])

		local elem = exports.titan_login:getPlayerByID(arg[3])
		if(not elem) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end

		if(player == elem) then
			exports.titan_noti:showBox(player, "Nie możesz wyrzucić samego siebie z grupy.")
			return
		end

		if(not doesPlayerHaveGroup(elem, groupID)) then
			exports.titan_noti:showBox(player, "Ten gracz nie jest w Twojej grupie.")
			return
		end

		if(removePlayerFromGroup(elem, groupID)) then
			exports.titan_noti:showBox(player, string.format("Wyrzuciłeś gracza %s %s ze swojej grupy.", getElementData(elem, "name"), getElementData(elem, "lastname")))
			exports.titan_noti:showBox(elem, string.format("Zostałeś wyrzucony z grupy %s.", groupInfo.name))

			if elem:getData("groupDutyID") and elem:getData("groupDutyID") == groupID then
				removeElementData(elem, "groupDutyID")
				removeElementData(elem, "groupDutyColor")
				removeElementData(elem, "GroupDutyTag")
			end
			return
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd podczas wyrzucania gracza z grupy.")
			return
		end
	elseif arg[2] == "wplac" then
		if(not doesPlayerHaveGroupLeader(player, groupID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień do użycia tej komendy.")
			return			
		end
		if not exports.titan_cash:isPlayerInBank(player) then return exports.titan_noti:showBox(player, "Nie jesteś w banku.") end

		local how = arg[3]
		if not tonumber(how) then
			return 	exports.titan_noti:showBox(player, "TIP: /g [slot] wplac [kwota]")
		end
		how = tonumber(how)
		if how <= 0 then return exports.titan_noti:showBox(player, "Wprowadzono niepoprawna kwotę.") end

		if how > exports.titan_cash:getPlayerCash(player) then return exports.titan_noti:showBox(player, "Nie posiadasz takiej gotówki.") end

		if exports.titan_cash:takePlayerCash(player, how) then
			giveGroupMoney(groupInfo.ID, how, 0, string.format("%s wpłacił pieniadze na konto bankowe grupy.", exports.titan_chats:getPlayerICName(player)))
			exports.titan_noti:showBox(player, "Pomyślnie wpłacono pieniadze na konto bankowe grupy.")
		end
	elseif arg[2] == "wyplac" then
		if(not doesPlayerHaveGroupLeader(player, groupID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień do użycia tej komendy.")
			return			
		end
		if not exports.titan_cash:isPlayerInBank(player) then return exports.titan_noti:showBox(player, "Nie jesteś w banku.") end

		local how = arg[3]
		if not tonumber(how) then
			return 	exports.titan_noti:showBox(player, "TIP: /g [slot] wyplac [kwota]")
		end
		how = tonumber(how)
		if how <= 0 then return exports.titan_noti:showBox(player, "Wprowadzono niepoprawna kwotę.") end

		if groupInfo.account < how then return exports.titan_noti:showBox(player, "Nie ma takiej kwoty na koncie bankowym.") end
		--if how > exports.titan_cash:getPlayerCash(player) then return exports.titan_noti:showBox(player, "Nie posiadasz takiej gotówki.") end

		takeGroupMoney(groupInfo.ID, how, string.format("%s wypłacił pieniadze z konta bankowego grupy.", exports.titan_chats:getPlayerICName(player)))
		if exports.titan_cash:addPlayerCash(player, how) then
			exports.titan_logs:playerLog(player, "cash", string.format("Otrzymano pieniądze od: (Konto bankowe - grupa) %s (UID: %d), Kwota: $%d.", groupInfo.name, groupInfo.ID, how))
			exports.titan_noti:showBox(player, "Pomyslnie wyplacono pieniadze z konta bankowego grupy.")
		end
	
	elseif(arg[2] == "respawn") then
		if(not doesPlayerHaveGroupLeader(player, groupID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz odpowiednich uprawnień do użycia tej komendy.")
			return			
		end
		exports.titan_vehicles:respawnGroupVehicles(groupID)
		for k, v in ipairs(getElementsByType("player")) do
			if(exports.titan_login:isLogged(v)) then
				if(doesPlayerHaveGroup(v, groupID)) then
					local playerSlot = getSlotFromGroup(v, groupID)
					exports.titan_noti:showBox(player, string.format("#%d [%s] ** Pojazdy w grupie %s zostały zrespawnowane. **", playerSlot, groupInfo.tag, groupInfo.name))
					--outputChatBox(string.format("#%d [%s] ** Pojazdy w grupie %s zostały zrespawnowane. **", playerSlot, groupInfo.tag, groupInfo.name), v, groupInfo.r, groupInfo.g, groupInfo.b)
				end
			end
		end
	elseif arg[2] == "usun" then
		if groupInfo.mainLeader == 0 then return exports.titan_noti:showBox(player, "Nie możesz usunać grupy stworzonej przez administratora.") end
		if groupInfo.mainLeader ~= player:getData("charID") then return exports.titan_noti:showBox(player, "Grupa nie należy do Ciebie.") end
		
		if removeGroup(groupInfo.ID) then
			exports.titan_noti:showBox(player, "Twoja grupa została usunięta pomyślnie.")
		else
			exports.titan_noti:showBox(player, "Coś poszło nie tak, grupa nie została usunięta!")
		end
	elseif(arg[2] == "duty") then
		local playerDuty = getPlayerDuty(player)
		if(tonumber(playerDuty) and playerDuty == groupID) then
			setPlayerDuty(player, groupID, false)
		exports.titan_noti:showBox(player, string.format("Zakończyłeś służbę w grupie %s.", groupInfo.name))
			--outputChatBox(string.format("Zakończyłeś służbę w grupie %s.", groupInfo.name), player, groupInfo.r, groupInfo.g, groupInfo.b)
		elseif(tonumber(playerDuty) and playerDuty ~= groupID) then
			exports.titan_noti:showBox(player, "Najpierw wyłącz duty na innej grupie.")
			return
		else
			setPlayerDuty(player, groupID, true)
			exports.titan_noti:showBox(player, string.format("Rozpocząłeś służbę w grupie %s.", groupInfo.name))
			--outputChatBox(string.format("Rozpocząłeś służbę w grupie %s.", groupInfo.name), player, groupInfo.r, groupInfo.g, groupInfo.b)

		end
	elseif(arg[2] == "zamow") then
		if not doesGroupHavePerm(groupID, "orders") then
			exports.titan_noti:showBox(player, "Grupa nie posiada dostępu do zamówień.")
			return
		end

		if not doesPlayerHavePerm(player, groupID, "orders") then
			exports.titan_noti:showBox(player, "Nie posiadasz dostępu do zamówień.")
			return
		end

		local dim = getElementDimension(player)
		if(dim == 0) then
			return exports.titan_noti:showBox(player, "Zamawianie na strefach tymczasowo wyłaczone.")
			--local sphereID = exports.titan_spheres:getPlayerZone(player)
			--if not sphereID then return exports.titan_noti:showBox(player, "Musisz być na strefie z uprawnieniami dla Twojej grupy.") end
			--if not exports.titan_spheres:doesOwnerHasPerm(sphereID, 2, groupInfo.ID) then return exports.titan_noti:showBox(player, "Grupa nie ma dostępu do tej strefy.") end
			--if not exports.titan_spheres:doesSphereHasFlag(sphereID, "zamow") then return exports.titan_noti:showBox(player, "Strefa nie ma flagi umożliwiajacej to.") end
		else
			local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dim)
			if(not doorInfo or doorInfo.ownerType ~= 2 or doorInfo.owner ~= groupID) then
				exports.titan_noti:showBox(player, "Musisz być w interiorze należącym do Twojej grupy.")
				return
			end
			local cat, orders = getAvailableOrders(groupID)
			if(not cat) then
				exports.titan_noti:showBox(player, "Grupa nie posiada żadnych dostępnych zamówień")
				return
			end
			triggerClientEvent(player, "createOrderMenuGUI", player, cat, orders, groupID, doorInfo.ID)
		end

	elseif arg[2] == "id" then
		if(not tonumber(arg[3])) then
			exports.titan_noti:showBox(player, "TIP: /g(rupa) [slot] id [ID gracza]")
			return
		end
		arg[3] = tonumber(arg[3])
		local elem = exports.titan_login:getPlayerByID(arg[3])
		if(not elem) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end
		exports.titan_noti:showBox(elem, string.format("Identyfikator grupy\nNazwa: %s %s\nGrupa: %s\nRanga: %s", getElementData(player, "name"), getElementData(player, "lastname"), groupInfo.name, getPlayerGroupRankName(player, groupID)))
		exports.titan_chats:sendPlayerLocalMessageID(player, elem, 10.0)
	elseif arg[2] == "zgloszenia" then
		if not doesGroupHavePerm(groupInfo.ID, "ediall") then
			exports.titan_noti:showBox(player, "Twoja grupa nie posiada uprawnień do korzystania ze zgłoszeń 911.")
			return
		end

		local dials = getAllDials()
		if #dials <= 0 then return exports.titan_noti:showBox(player, "Nie ma żadnych oczekujących wezwań.") end
		triggerClientEvent(player, "reportsGroup.funcCreate", player, dials, groupInfo.ID)
	elseif arg[2] == "pojazdy" then
		if not doesPlayerHavePerm(player, groupInfo.ID, "vehicles") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do zarzadzaniem pojazdów w grupie.") end

		local groupVehicles = exports.titan_vehicles:getGroupVehicles(groupInfo.ID)
		if not groupVehicles then return exports.titan_noti:showBox(player, "Grupa nie posiada żadnych pojazdów.") end
		triggerClientEvent(player, "vehiclesMenuFunc.createMenu", resourceRoot, groupVehicles)
	elseif arg[2] == "opusc" then
		if doesGroupHavePerm(groupInfo.ID, "blockleave") then return exports.titan_noti:showBox(player, "Grupa ma nadaną flagę uniemożliwiającą opuszczenie jej.") end
		if(removePlayerFromGroup(player, groupID)) then
			exports.titan_noti:showBox(player, string.format("Opuściłeś grupę %s.", groupInfo.name))

			if player:getData("groupDutyID") and player:getData("groupDutyID") == groupID then
				removeElementData(player, "groupDutyID")
				removeElementData(player, "groupDutyColor")
				removeElementData(player, "GroupDutyTag")
			end
			return
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd podczas odchodzenia z grupy.")
			return
		end
	else
		showGroupInfoTable(player, groupInfo)
		return
	end
end
addCommandHandler("g", cmdG, false, false)
addCommandHandler("grupa", cmdG, false, false)

-- KOMENDY GRUP --

function cmdReanimuj(player, command, id)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
	local pDuty = getPlayerDuty(player)
	if not pDuty then
		exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.")
		return
	end
	if not doesGroupHavePerm(pDuty, "cpr") then
		exports.titan_noti:showBox(player, "Twoja grupa nie posiada uprawnień do reanimowania graczy.")
		return
	end
	if not doesPlayerHavePerm(player, pDuty, "cpr") then
		exports.titan_noti:showBox(player, "Nie posiadasz nadanych uprawnień umożliwiających wywołanie komendy.")
		return
	end
	if not tonumber(id) then
		exports.titan_noti:showBox(player, "TIP: /reanimuj [ID gracza]")
		return
	end
	id = tonumber(id)
	local target = exports.titan_login:getPlayerByID(id)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end
	if player == target then
		exports.titan_noti:showBox(player, "Nie możesz reanimować sam siebie.")
		return
	end
	if getElementData(player, "bwTime") then
		exports.titan_noti:showBox(player, "Nie możesz reanimować kogos gdy masz BW")
		return
	end
	local x, y, z = getElementPosition(player)
	local px, py, pz = getElementPosition(target)
	if getDistanceBetweenPoints3D(x, y, z, px, py, pz) > 4.0 then
		exports.titan_noti:showBox(player, "Gracz jest za daleko.")
		return
	end
	if not exports.titan_bw:doesPlayerHaveBW(target) then
		exports.titan_noti:showBox(player, "Gracz nie jest nieprzytomny.")
		return
	end
	exports.titan_bw:turnBWOff(target)
	exports.titan_noti:showBox(target, string.format("Ocknałeś się dzięki graczowi %s.", exports.titan_chats:getPlayerICName(player)))
	exports.titan_noti:showBox(player, string.format("Ocknałeś gracza %s.", exports.titan_chats:getPlayerICName(target)))
end
addCommandHandler("reanimuj", cmdReanimuj, false, false)

function cmdPrzebierz(player)
	if exports.titan_login:isLogged(player) then
	if getElementData(player, "bwTime") then return end
		local defaultSkin = player:getData("defaultSkin")
		if tonumber(defaultSkin) then
			player:setModel(tonumber(defaultSkin))
			player:setData("skin", tonumber(defaultSkin))
			exports.titan_db:query_free("UPDATE _characters SET skin = ? WHERE ID = ?", tonumber(defaultSkin), player:getData("charID"))
			exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("%s się.", getElementData(player, "sex") == 1 and "przebrał" or "przebrała"), 10.0)
			exports.titan_noti:showBox(player, "Pomyślnie zmieniono skin na Twój domyślny.")
			return
		end
	end
end
addCommandHandler("przebierz", cmdPrzebierz, false, false)

function cmdBlokada(player, command, option)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
	local pDuty = getPlayerDuty(player)
	if not pDuty then
		exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.")
		return
	end
	if not doesGroupHavePerm(pDuty, "blockade") then
		exports.titan_noti:showBox(player, "Twoja grupa nie posiada uprawnień do stawiania blokad.")
		return
	end
	if not doesPlayerHavePerm(player, pDuty, "blockade") then
		exports.titan_noti:showBox(player, "Nie posiadasz nadanych uprawnień umożliwiających stawianie blokad.")
		return
	end
	if not option then
		exports.titan_noti:showBox(player, "TIP: /blokada [stworz, usun]")
		return
	end
	option = string.lower(tostring(option))
	if option == "stworz" then
		triggerClientEvent(player, "bGUI.create", player, blockadeData)
	elseif option == "usun" then
		triggerClientEvent(player, "bRender.toggleRemoveBlockade", player)
	else
		exports.titan_noti:showBox(player, "TIP: /blokada [stworz, usun]")
		return
	end
end
addCommandHandler("blokada", cmdBlokada, false, false)

function cmdZgloszenia(player)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
	local playerDuty = getPlayerDuty(player)
	if not playerDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
	local groupInfo = getGroupInfo(playerDuty)
	if not groupInfo then return exports.titan_noti:showBox(player, "Grupa na której duty jesteś nie istnieje.") end
	if not doesGroupHavePerm(groupInfo.ID, "ediall") then
		return exports.titan_noti:showBox(player, "Twoja grupa nie posiada uprawnień do korzystania ze zgłoszeń 911.")
	end
	local dials = getAllDials()
	if #dials <= 0 then return exports.titan_noti:showBox(player, "Nie ma żadnych oczekujących wezwań.") end
	triggerClientEvent(player, "reportsGroup.funcCreate", player, dials, groupInfo.ID)
end
addCommandHandler("zgloszenia", cmdZgloszenia, false, false)
addCommandHandler("911", cmdZgloszenia, false, false)

function cmdAreszt(player, command, option1, option2)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
	local pDuty = getPlayerDuty(player)
	if not pDuty then
		exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.")
		return
	end
	if not doesGroupHavePerm(pDuty, "arrest") then
		exports.titan_noti:showBox(player, "Twoja grupa nie posiada uprawnień do aresztowania graczy.")
		return
	end
	if not doesPlayerHavePerm(player, pDuty, "arrest") then
		exports.titan_noti:showBox(player, "Nie posiadasz nadanych uprawnień umożliwiających aresztowanie graczy.")
		return
	end
	local doorInfo = exports.titan_doors:getDoorInfoFromDimension(player:getDimension())
	if not doorInfo then
		exports.titan_noti:showBox(player, "Musisz być w interiorze grupy.")
		return
	end
	if doorInfo.ownerType ~= 2 or doorInfo.owner ~= pDuty then
		exports.titan_noti:showBox(player, "Ten interior nie należy do Twojej grupy.")
		return
	end
	local arrestsData = getArrestsDataFromInterior(doorInfo.ID)
	if not arrestsData then
		exports.titan_noti:showBox(player, "W tym interiorze nie ma stworzonych cel.")
		return
	end
	if not option1 or not option2 then
		exports.titan_noti:showBox(player, "TIP: /areszt [ID gracza] [czas w minutach]")
		return
	end
	option1 = tonumber(option1)
	option2 = tonumber(option2)
	local target = exports.titan_login:getPlayerByID(option1)
	if not target then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
		return
	end
	local x1, y1, z1 = getElementPosition(player)
	local x2, y2, z2 = getElementPosition(target)
	if getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2) > 5.0 or player:getInterior() ~= target:getInterior() or player:getDimension() ~= target:getDimension() then
		exports.titan_noti:showBox(player, "Nie znajdujesz się w pobliżu tego gracza.")
		return
	end
	if player == target then
		exports.titan_noti:showBox(player, "Nie możesz aresztować samego siebie.")
		return
	end
	if option2 < 0 or option2 > 700 then
		exports.titan_noti:showBox(player, "Czas musi mieścić się w przedziale od 1 do 700 minut.")
		return
	end
	if option2 == 0 then
		if target:getData("arrestTime") <= 0 or not tonumber(target:getData("arrestData")) then
			exports.titan_noti:showBox(player, "Gracz nie jest w areszcie.")
			return
		end
		local arrestData = target:getData("arrestData")
		local data
		for k, v in ipairs(arrestsData) do
			if v.ID == arrestData then
				data = v
				break
			end
		end
		if not data then
			exports.titan_noti:showBox(player, "Gracz nie jest aresztowany w tym interiorze.")
			return
		end
		target:setData("arrestTime", 0)
		target:setData("arrestData", 0)
		local sData = exports.titan_misc:randomSpawn()
		target:setDimension(0)
		target:setInterior(0)
		target:setPosition(sData[1], sData[2], sData[3])
		exports.titan_db:query_free("UPDATE _characters SET arrestTime = '0', arrestData = '0' WHERE ID = ?", target:getData("charID"))
		exports.titan_noti:showBox(player, string.format("Uwolniłeś gracza %s z aresztu.", exports.titan_chats:getPlayerICName(target)))
		exports.titan_noti:showBox(target, string.format("Zostałeś uwolniony z aresztu przez gracza %s.", exports.titan_chats:getPlayerICName(player)))
		return
	else
		local x, y, z = getElementPosition(player)
		local nearArrest = getNearestArrest(player, doorInfo.ID, x, y, z, 10.0)
		if not nearArrest then
			exports.titan_noti:showBox(player, "Nie znajdujesz się obok żadnej celi.")
			return
		end
		target:setDimension(player:getDimension())
		target:setInterior(player:getInterior())
		target:setData("arrestTime", option2 * 60)
		target:setData("arrestData", nearArrest.ID)
		target:setPosition(nearArrest.x, nearArrest.y, nearArrest.z)
		exports.titan_db:query_free("UPDATE _characters SET arrestTime = ?, arrestData = ? WHERE ID = ?", option2 * 60, nearArrest.ID, target:getData("charID"))
		exports.titan_noti:showBox(player, string.format("Aresztowałeś gracza %s na %d minut.", exports.titan_chats:getPlayerICName(target), option2))
		exports.titan_noti:showBox(target, string.format("Gracza %s aresztował Cię na %d minut.", exports.titan_chats:getPlayerICName(player), option2))
		return
	end
end
addCommandHandler("areszt", cmdAreszt, false, false)

function PlayerGiveItem(player, command, target)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
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
	if not tonumber(target) then return exports.titan_noti:showBox(player, "TIP: /o podaj [ID gracza]") end
	local elem = exports.titan_login:getPlayerByID(tonumber(target))
	if not elem then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
	if getDistanceBetweenPoints3D(player:getPosition(), elem:getPosition()) > 4.0 or player:getDimension() ~= elem:getDimension() or player:getInterior() ~= elem:getInterior() then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
	if elem == player then return exports.titan_noti:showBox(player, "Nie możesz podawać przedmiotów samemu sobie.") end
	local magazineItems = exports.titan_doors:getMagazineItems(doorInfo.ID)
	if not magazineItems then return exports.titan_noti:showBox(player, "W magazynie nie ma żadnych przedmiotów.") end

	triggerClientEvent(player, "giveMenu.create", player, magazineItems, elem)
end


function PlayerHeal(player, command, target)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
	local playerDuty = getPlayerDuty(player)
	if not playerDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
	local groupInfo = getGroupInfo(playerDuty)
	if not groupInfo then return exports.titan_noti:showBox(player, "Grupa na której duty przebywasz nie istnieje w systemie.") end
	if not doesGroupHavePerm(playerDuty, "heal") then return exports.titan_noti:showBox(player, "Grupa nie posiada dostępu do komendy /lecz.") end
	if not doesPlayerHavePerm(player, playerDuty, "heal") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do użycia komendy /lecz.") end
	if not tonumber(target) then return exports.titan_noti:showBox(player, "TIP: /o leczenie [ID gracza]") end
	local elem = exports.titan_login:getPlayerByID(tonumber(target))
	if not elem then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
	if getDistanceBetweenPoints3D(player:getPosition(), elem:getPosition()) > 4.0 or player:getDimension() ~= elem:getDimension() or player:getInterior() ~= elem:getInterior() then return exports.titan_noti:showBox(player, "Gracz jest za daleko.") end
	if elem == player then return exports.titan_noti:showBox(player, "Nie możesz leczyć samego siebie.") end
	if not isPlayerCanHeal(player) then return exports.titan_noti:showBox(player, "Nie możesz leczyć kilku osób jednocześnie.") end
	setElementData(elem, "healedBy", player)
	setElementData(player, "playerHealing", elem)
	exports.titan_noti:showBox(player, string.format("Rozpoczęto proces leczenia %s.", exports.titan_chats:getPlayerICName(elem)))
	exports.titan_noti:showBox(elem, "Rozpoczęto proces leczenia. Trzymaj się blisko lekarza.")
	startHeal(player, elem)
end
