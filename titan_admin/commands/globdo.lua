----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:45
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:47
----------------------------------------------------

function cmdGlobDo(player, command, ...)
	if not doesAdminHavePerm(player, "globdo") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local message = tostring(table.concat({...}, " "))
	if(string.len(message) < 4) then
		exports.titan_noti:showBox(player, "TIP: /ado [wiadomość]")
		return
	end
	message = exports.titan_chats:firstToUpper(exports.titan_chats:addStop(message))
	--outputChatBox(string.format("** %s **", message), root, 154, 156, 205, false)
	for k, v in ipairs(getElementsByType("player")) do
	--	exports.titan_sampChat:sendMessage(v, "IC", string.format("** %s **", message),  154, 156, 205, false)
		exports.titan_chats:sendPlayerChatMessage(v, string.format("** %s **", message), 154, 156, 205, false)
	end
end
addCommandHandler("ado", cmdGlobDo, false, false)