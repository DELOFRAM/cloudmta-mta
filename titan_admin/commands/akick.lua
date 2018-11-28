----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:57
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:00
----------------------------------------------------

function cmdAkick(player, command, ID, ...)
	if not doesAdminHavePerm(player, "kick") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local reason = table.concat({...}, " ")

	if(not tonumber(ID) or not reason or string.len(reason) < 1) then
		exports.titan_noti:showBox(player, "TIP: /akick [ID gracza] [powód]")
		return
	end
	reason = tostring(reason)
	ID = tonumber(ID)

	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end

	local adminName = tostring(getElementData(player, "globalName"))
	local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
	reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
	exports.titan_hud:showPenalty(adminName, playerName, 1, reason, 0)
	outputConsole("------KICK------", target)
	outputConsole(string.format("| Nadano przez: %s", adminName), target)
	outputConsole("| Powód:", target)
	outputConsole("| "..reason, target)
	local x, y, z = getElementPosition(target)
	exports.titan_logs:commandLog(player, command, {ID, ...}, target)
	savePenalty(1, player, target, 0, reason)
	kickPlayer(target, adminName, "Informacje w konsoli ([`] - tylda)")
end
addCommandHandler("akick", cmdAkick, false, false)