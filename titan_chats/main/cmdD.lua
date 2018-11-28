----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:08
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:11
----------------------------------------------------

function cmdDepo(player, command, ...)
	if getElementData(player, "bwTime") then return end
	local message = table.concat({...}, " ")
	if(not message or string.len(message) < 1) then exports.titan_noti:showBox(player, "TIP: /d [wiadomość]") return end
	message = addStop(firstToUpper(message))
	local playerDuty = exports.titan_orgs:getPlayerDuty(player)
	if(not playerDuty or not exports.titan_orgs:isGroup(playerDuty)) then
		exports.titan_noti:showBox(player, "Nie jesteś na służbie żadnej grupy.")
		return
	end

	if(not exports.titan_orgs:doesGroupHavePerm(playerDuty, "chatdept")) then
		exports.titan_noti:showBox(player, "Grupa, na której służbie jesteś nie posiada dostępu do radia departamentowego.")
		return
	end

	if(not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "chatdept")) then
		exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do używania radia departamentowego.")
		return
	end

	local groupInfo = exports.titan_orgs:getGroupInfo(playerDuty)
	local faceCode = tostring(getElementData(player, "faceCode"))
	local nickname = getPlayerICName(player)

	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			local playerDuty = exports.titan_orgs:getPlayerDuty(v)
			if(playerDuty and exports.titan_orgs:isGroup(playerDuty)) then
				if(exports.titan_orgs:doesGroupHavePerm(playerDuty, "chatdept")) then
					if(exports.titan_orgs:doesPlayerHavePerm(v, playerDuty, "chatdept")) then
						local newMessage = string.format("** [%s] %s: %s **", string.upper(tostring(groupInfo.tag)), nickname, message)
						--outputChatBox(string.format("** [%s] %s: %s **", string.upper(tostring(groupInfo.tag)), nickname, message), v, 255, 130, 130)
						--exports.titan_sampChat:sendMessage(v, "IC", string.format("** [%s] %s: %s **", string.upper(tostring(groupInfo.tag)), nickname, message), 255, 130, 130)
						sendPlayerChatMessage(v, newMessage, 255, 130, 130, false)
					end
				end
			end
		end
	end
	sendPlayerLocalMessageRadius(player, message, 6.0, "mówi (radio)", false)
end
addCommandHandler("d", cmdDepo, false, false)