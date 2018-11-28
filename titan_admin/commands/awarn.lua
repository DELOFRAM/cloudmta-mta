----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:40:48
-- Ostatnio zmodyfikowano: 2016-01-09 15:40:53
----------------------------------------------------

function cmdAwarn(player, command, ID, ...)
	if not doesAdminHavePerm(player, "warn") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local reason = table.concat({...}, " ")

	if(not tonumber(ID) or not reason or string.len(reason) < 1) then
		exports.titan_noti:showBox(player, "TIP: /awarn [ID gracza] [powód]")
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
	exports.titan_hud:showPenalty(adminName, playerName, 3, reason, 0)
	exports.titan_logs:commandLog(player, command, {ID, ...}, target)
	savePenalty(3, player, target, getRealTime().timestamp + 3600 * 24 * 90, reason)
end
addCommandHandler("awarn", cmdAwarn, false, false)