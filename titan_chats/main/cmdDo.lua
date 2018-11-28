----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:13
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:15
----------------------------------------------------

function cmdDo(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then return exports.titan_noti:showBox(player, "TIP: /do [akcja]") end

	message = firstToUpper(message)
	message = addStop(message)

	sendPlayerLocalDoRadius(player, message, 15.0)
	return true
end
addCommandHandler("do", cmdDo, false, false)

function cmdJa(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then return exports.titan_noti:showBox(player, "TIP: /ja [akcja]") end

	message = addStop(message)

	sendPlayerLocalMeRadius(player, message, 15.0, true)
	return true
end
addCommandHandler("ja", cmdJa, false, false)