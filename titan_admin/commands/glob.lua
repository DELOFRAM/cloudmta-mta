----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:40
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:43
----------------------------------------------------

function cmdGlob(player, command, ...)
	if not doesAdminHavePerm(player, "glob") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local message = tostring(table.concat({...}, " "))
	if(string.len(message) < 4) then
		exports.titan_noti:showBox(player, "TIP: /glob [wiadomość]")
		return
	end
	message = exports.titan_chats:firstToUpper(exports.titan_chats:addStop(message))
	local color = exports.titan_misc:getAdminRank(getPlayerAdminLevel(player))
	color = "#"..color.color
	if(not color) then color = "#FFFFFF" end
	outputChatBox(string.format("#FFFFFF(( %s%s#FFFFFF: %s ))", color, getElementData(player, "globalName"), message), root, 255, 255, 255, true)
	for k, v in ipairs(getElementsByType("player")) do
		exports.titan_sampChat:sendMessage(v, "IC", string.format("#FFFFFF(( %s%s#FFFFFF: %s ))", color, getElementData(player, "globalName"), message),  255, 255, 255, true)
	end
end
addCommandHandler("glob", cmdGlob, false, false)