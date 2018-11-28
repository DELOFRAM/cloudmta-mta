----------------------------------------------------
-- CloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:40:48
-- Ostatnio zmodyfikowano: 2016-01-09 15:40:53
----------------------------------------------------

function cmdAban(player, command, ID, time, ...)
	if not doesAdminHavePerm(player, "ban") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local reason = table.concat({...}, " ")

	if(not tonumber(ID) or not tonumber(time) or not reason or string.len(reason) < 1) then
		exports.titan_noti:showBox(player, "TIP: /aban [ID gracza] [czas (w dniach), 0 - perm] [powód]")
		return
	end
	reason = tostring(reason)
	ID = tonumber(ID)
	time = tonumber(time)

	if(time < 0 and time > 365) then
		exports.titan_noti:showBox(player, "Czas musi zawierać się w przedziale 0 - 365")

		return
	end
	time = math.floor(time)

	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end

	if(player == target) then
		exports.titan_noti:showBox(player, "Nie możesz zbanować samego siebie.")
		return
	end
	
	if time == 0 then
		savePenalty(2, player, target, 0, reason)
		exports.titan_db:query_free("UPDATE ipb_members SET game_ban = ? WHERE member_id = ?", getRealTime().timestamp+86313600, getElementData(target, "memberID"))
		czas = "permanentny"
	else
		savePenalty(2, player, target, getRealTime().timestamp+(time*86400), reason)
		exports.titan_db:query_free("UPDATE ipb_members SET game_ban = ? WHERE member_id = ?", getRealTime().timestamp+(time*86400), getElementData(target, "memberID"))
		czas = tostring(time)
	end
	local adminName = tostring(getElementData(player, "globalName"))
	local playerName = string.format("%s (%s)", exports.titan_chats:getPlayerICName(target), tostring(getElementData(target, "globalName")))
	reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
	exports.titan_hud:showPenalty(adminName, playerName, 2, reason, time)
	outputConsole("---------------------------")
	outputConsole(string.format("Banowany: %s (%s)", exports.titan_chats:getPlayerICName(target), getElementData(target, "globalName")), target)
	outputConsole(string.format("Banujący: %s", adminName), target)
	outputConsole(string.format("Powód: %s", reason), target)
	outputConsole(string.format("Ilość dni: %s", czas), target)
	outputConsole("---------------------------")
	exports.titan_logs:commandLog(player, command, {ID, time, ...}, target)
	kickPlayer(target, string.format("Zostałeś zbanowany. Informacje w konsoli."))
end
addCommandHandler("aban", cmdAban, false, false)