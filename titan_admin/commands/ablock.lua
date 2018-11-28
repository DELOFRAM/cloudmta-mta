----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:40:56
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:00
----------------------------------------------------

function cmdABlock(player, command, ...)
	if not doesAdminHavePerm(player, "block") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local typ = string.lower(tostring(arg[1]))
	if typ == "char" then
		local ID = arg[2]
		local reason = table.concat(arg, " ", 3)
		if(not tonumber(ID) or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock char [ID gracza] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		savePenalty(4, player, target, 0, reason)
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 4, reason, 0)
		exports.titan_db:query_free("UPDATE `_characters` SET `blocked` = '1' WHERE `ID` = ?", target:getData("charID"))
		exports.titan_logs:commandLog(player, command, {...}, target)
		outputConsole("---------------------------")
		outputConsole(string.format("Blokowany: %s (%s)", exports.titan_chats:getPlayerICName(target), getElementData(target, "globalName")), target)
		outputConsole(string.format("Blokujący: %s", adminName), target)
		outputConsole(string.format("Powód: %s", reason), target)
		outputConsole("---------------------------")
		kickPlayer(target, string.format("Twoja postać została zablokowana. Informacje w konsoli"))
		return
	elseif typ == "veh" then
		local ID = arg[2]
		local time = arg[3]
		local timeDay = arg[4]
		local reason = table.concat(arg, " ", 5)
		if(not tonumber(ID) or not tonumber(time) or not timeDay or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock veh [ID gracza] [czas] [godzin, dni] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		time = math.floor(tonumber(time))
		timeDay = string.lower(tostring(timeDay))
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		local timeStamp = getRealTime().timestamp
		if timeDay == "godzin" then
			if time < 1 or time >= 24 then
				exports.titan_noti:showBox(player, "Blokadę można wybrać w przedziale [1 - 23] godzin.")
				return
			end
			timeStamp = timeStamp + (3600 * time)
		elseif timeDay == "dni" then
			if time < 1 or time >= 14 then
				exports.titan_noti:showBox(player, "Blokadę można wybrać w przedziale [1 - 14] dni.")
				return
			end
			timeStamp = timeStamp + (86400 * time)
		else
			exports.titan_noti:showBox(player, "Podano nieprawidłowy typ długości blokady! [godzin, dni]")
			return
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 7, reason, {time, timeDay})
		exports.titan_logs:commandLog(player, command, {...}, target)
		savePenalty(7, player, target, timeStamp, reason)

		if isPedInVehicle(target) then
			if getPedOccupiedVehicleSeat(target) == 0 then
				removePedFromVehicle(target)
			end
		end
		--outputChatBox("Otrzymałeś blokadę pojazdów!", target, 255, 0, 0)
		--outputChatBox(string.format("Blokada kończy się za: %s %s", tostring(time), tostring(timeDay)), target, 255, 0, 0)
		exports.titan_chats:sendPlayerChatMessage(target, "Otrzymałeś blokadę pojazdów!", 255, 0, 0, false)
		exports.titan_chats:sendPlayerChatMessage(target, string.format("Blokada kończy się za: %s %s", tostring(time), tostring(timeDay)), 255, 0, 0, false)
		target:setData("vehBlock", timeStamp)
		exports.titan_db:query(string.format("UPDATE `_characters` SET `vehBlock` = '%d' WHERE `ID` = '%d'", timeStamp, target:getData("charID")))
	elseif typ == "unveh" then
		local ID = arg[2]
		local reason = table.concat(arg, " ", 3)
		if(not tonumber(ID) or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock unveh [ID gracza] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		if target:getData("vehBlock") <= 0 then
			exports.titan_noti:showBox(player, "Gracz nie posiada aktywnej blokady pojazdów.")
			return
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 8, reason, 0)
		exports.titan_logs:commandLog(player, command, {...}, target)
		savePenalty(8, player, target, 0, reason, 7)
		exports.titan_noti:showBox(target, "Blokada pojazdów została zdjęta.")
		target:setData("vehBlock", 0)
		exports.titan_db:query(string.format("UPDATE `_characters` SET `vehBlock` = '0' WHERE `ID` = '%d'", target:getData("charID")))
	elseif typ == "ooc" then
		local ID = arg[2]
		local time = arg[3]
		local timeDay = arg[4]
		local reason = table.concat(arg, " ", 5)
		if(not tonumber(ID) or not tonumber(time) or not timeDay or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock ooc [ID gracza] [czas] [godzin, dni] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		time = math.floor(tonumber(time))
		timeDay = string.lower(tostring(timeDay))
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		local timeStamp = getRealTime().timestamp
		if timeDay == "godzin" then
			if time < 1 or time >= 24 then
				exports.titan_noti:showBox(player, "Blokadę można wybrać w przedziale [1 - 23] godzin.")
				return
			end
			timeStamp = timeStamp + (3600 * time)
		elseif timeDay == "dni" then
			if time < 1 or time >= 14 then
				exports.titan_noti:showBox(player, "Blokadę można wybrać w przedziale [1 - 14] dni.")
				return
			end
			timeStamp = timeStamp + (86400 * time)
		else
			exports.titan_noti:showBox(player, "Podano nieprawidłowy typ długości blokady! [godzin, dni]")
			return
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 9, reason, {time, timeDay})
		exports.titan_logs:commandLog(player, command, {...}, target)
		savePenalty(9, player, target, timeStamp, reason)
		--outputChatBox("Otrzymałeś blokadę czatu OOC!", target, 255, 0, 0)
		--outputChatBox(string.format("Blokada kończy się za: %s %s", tostring(time), tostring(timeDay)), target, 255, 0, 0)
		exports.titan_chats:sendPlayerChatMessage(target, "Otrzymałeś blokadę czatu OOC!", 255, 0, 0, false)
		exports.titan_chats:sendPlayerChatMessage(target, string.format("Blokada kończy się za: %s %s", tostring(time), tostring(timeDay)), 255, 0, 0, false)
		target:setData("oocBlock", timeStamp)
		exports.titan_db:query(string.format("UPDATE `_characters` SET `oocBlock` = '%d' WHERE `ID` = '%d'", timeStamp, target:getData("charID")))
	elseif typ == "unooc" then
		local ID = arg[2]
		local reason = table.concat(arg, " ", 3)
		if(not tonumber(ID) or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock unooc [ID gracza] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		if target:getData("oocBlock") <= 0 then
			exports.titan_noti:showBox(player, "Gracz nie posiada aktywnej blokady OOC.")
			return
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 10, reason, 0)
		exports.titan_logs:commandLog(player, command, {...}, target)
		savePenalty(10, player, target, 0, reason, 9)
		exports.titan_noti:showBx(target, "Blokada czatu OOC została zdjęta.")
		target:setData("oocBlock", 0)
		exports.titan_db:query(string.format("UPDATE `_characters` SET `oocBlock` = '0' WHERE `ID` = '%d'", target:getData("charID")))
	elseif typ == "run" then
		local ID = arg[2]
		local time = arg[3]
		local timeDay = arg[4]
		local reason = table.concat(arg, " ", 5)
		if(not tonumber(ID) or not tonumber(time) or not timeDay or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock run [ID gracza] [czas] [godzin, dni] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		time = math.floor(tonumber(time))
		timeDay = string.lower(tostring(timeDay))
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		local timeStamp = getRealTime().timestamp
		if timeDay == "godzin" then
			if time < 1 or time >= 24 then
				exports.titan_noti:showBox(player, "Blokadę można wybrać w przedziale [1 - 23] godzin.")
				return
			end
			timeStamp = timeStamp + (3600 * time)
		elseif timeDay == "dni" then
			if time < 1 or time >= 14 then
				exports.titan_noti:showBox(player, "Blokadę można wybrać w przedziale [1 - 14] dni.")
				return
			end
			timeStamp = timeStamp + (86400 * time)
		else
			exports.titan_noti:showBox(player, "Podano nieprawidłowy typ długości blokady! [godzin, dni]")
			return
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 11, reason, {time, timeDay})
		exports.titan_logs:commandLog(player, command, {...}, target)
		savePenalty(11, player, target, timeStamp, reason)
		--outputChatBox("Otrzymałeś blokadę biegania!", target, 255, 0, 0)
		--outputChatBox(string.format("Blokada kończy się za: %s %s", tostring(time), tostring(timeDay)), target, 255, 0, 0)
		exports.titan_chats:sendPlayerChatMessage(target, "Otrzymałeś blokadę biegania!", 255, 0, 0, false)
		exports.titan_chats:sendPlayerChatMessage(target, string.format("Blokada kończy się za: %s %s", tostring(time), tostring(timeDay)), 255, 0, 0, false)
		target:setData("runBlock", timeStamp)
		exports.titan_db:query(string.format("UPDATE `_characters` SET `runBlock` = '%d' WHERE `ID` = '%d'", timeStamp, target:getData("charID")))
		toggleControl(target, "sprint", false)
		toggleControl(target, "jump", false)
	elseif typ == "unrun" then
		local ID = arg[2]
		local reason = table.concat(arg, " ", 3)
		if(not tonumber(ID) or not reason or string.len(reason) < 1) then
			exports.titan_noti:showBox(player, "TIP: /ablock unrun [ID gracza] [powód]")
			return
		end
		reason = tostring(reason)
		ID = tonumber(ID)
		local target = exports.titan_login:getPlayerByID(ID)
		if(not target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		if target:getData("runBlock") <= 0 then
			exports.titan_noti:showBox(player, "Gracz nie posiada aktywnej blokady biegania.")
			return
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 12, reason, 0)
		exports.titan_logs:commandLog(player, command, {...}, target)
		savePenalty(12, player, target, 0, reason, 11)
		exports.titan_noti:showBox(target, "Blokada biegania została zdjęta.")
		target:setData("runBlock", 0)
		exports.titan_db:query(string.format("UPDATE `_characters` SET `runBlock` = '0' WHERE `ID` = '%d'", target:getData("charID")))
		toggleControl(target, "sprint", true)
		toggleControl(target, "jump", true)
	else
		exports.titan_noti:showBox(player, "TIP: /ablock [char, veh, unveh, ooc, unooc, run, unrun]")
		return
	end
end
addCommandHandler("ablock", cmdABlock, false, false)