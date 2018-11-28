----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmdASerial(player, command, ...)
	if not doesAdminHavePerm(player, "serial") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local option = string.lower(tostring(arg[1]))
	if option == "ban" then
		local serial = arg[2]
		local reason = table.concat(arg, " ", 3)
		if string.len(tostring(serial)) ~= 32 or string.len(tostring(reason)) < 4 then
			return exports.titan_noti:showBox(player, "TIP: /aserial ban [serial] [powód]")
		end
		serial = string.upper(tostring(serial))
		reason = tostring(reason)
		exports.titan_db:query_free("INSERT INTO _serialBans SET serial = ?, bannedBy = ?, time = UNIX_TIMESTAMP(), reason = ?", serial, player:getData("memberID"), reason)
		return exports.titan_noti:showBox(player, string.format("Pomyślnie zbanowano serial %s.", string.upper(serial)))
	elseif option == "get" then
		local playerID = arg[2]
		if not tonumber(playerID) then 
			return exports.titan_noti:showBox(player, "TIP: /aserial get [ID gracza]")
		end
		playerID = tonumber(playerID)
		local target = exports.titan_login:getPlayerByID(playerID)
		if not target then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
			return
		end
		local serial = getPlayerSerial(target)
		return exports.titan_noti:showBox(player, string.format("Serial gracza %s to: %s.", exports.titan_chats:getPlayerICName(target), serial))
	else
		return exports.titan_noti:showBox(player, "TIP: /aserial [get, ban]")
	end
end	
addCommandHandler("aserial", cmdASerial, false, false)