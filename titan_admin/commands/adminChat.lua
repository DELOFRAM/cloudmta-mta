----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:18
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:21
----------------------------------------------------

function cmdAs(player, command, ...)
	if(not isPlayerAdmin(player)) then return false end
	if getElementData(player, "adminLevel") < 4 and getElementData(player, "adminLevel") > 6 then return end
		local message = table.concat({...}, " ")
		if(string.len(message) < 1) then
			outputChatBox("TIP: /ac [treść]", player)
			return
		end

		exports.titan_logs:adminChatLog(string.format("%s: %s", player:getData("globalName"), message))

		local aColor = exports.titan_misc:getAdminRank(exports.titan_admin:getPlayerAdminLevel(player))
		aColor = aColor.color
		message = string.format("#73739eAC: #ffffff[[ #%s%s#ffffff: %s ]]", aColor, player:getData("globalName"), string.gsub(message, "#%x%x%x%x%x%x", ""))

		local admins = getAvailableAdmins()
		for k, v in ipairs(getElementsByType("player")) do
			if getElementData(v, "adminLevel") > 3 and getElementData(v, "adminLevel") < 7 then

				if getElementData(v, "sampChat") then
					exports.titan_chats:sendPlayerChatMessage(v, message, 255, 255, 255, true)
				else
					exports.titan_chats:addPlayerOOCMessage(v, message, 255, 255, 255)
				end
			end
		end
			
		local time = getRealTime()
		exports.titan_logs:adminChatLog(string.format("[%0.2d:%0.2d:%0.2d] %s: %s", time.hour, time.minute, time.second, getElementData(player, "globalName"), message))

		return
end
addCommandHandler("ac", cmdAs, false, false)