----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:40
-- Ostatnio zmodyfikowano: 2016-01-19 22:57:50
----------------------------------------------------

function cmdW(player, command, playerID, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(not tonumber(playerID) or string.len(message) < 1) then
		exports.titan_noti:showBox(player, "TIP: /w [ID gracza] [wiadomość]")
		return
	end

	local target = exports.titan_login:getPlayerByID(tonumber(playerID))
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o danym ID, lub nie jest on zalogowany.")
		return
	end

	if(target == player) then
		exports.titan_noti:showBox(player, "Nie możesz wysłać wiadomości do samego siebie.")
		return
	end
	
	if getElementData(target, "tog:w") and not exports.titan_admin:doesPlayerHaveAdminDuty(player) then
		exports.titan_noti:showBox(player, string.format("%s ma wyłączone prywatne wiadomości.", getPlayerICName(target)))
		return
	end
	
	if player:getData("oocBlock") > 0 then
		if not exports.titan_admin:doesPlayerHaveAdminDuty(target) then
			exports.titan_noti:showBox(player, "Majac aktywna blokadę OOC możesz pisać tylko do administratora.")
			return
		end
	end

	local nickname2 = getPlayerICName(player)
	local nickname1 = getPlayerICName(target)
	
	message = addStop(message)

	local string1 = string.format("Wiadomość do %s [%d]%s: %s", nickname1, getElementData(target, "playerID"), getElementData(target, "isAFK") and " [AFK]" or "", firstToUpper(message))
	local string2 = string.format("Wiadomość od %s [%d]: %s", nickname2, getElementData(player, "playerID"), firstToUpper(message))

	if player:getData("sampChat") then
		sendPlayerChatMessage(player, string1, 224, 224, 47, false)
	else
		addPlayerOOCMessage(player, string1, 224, 224, 47)
	end
	if target:getData("sampChat") then
		sendPlayerChatMessage(target, string2, 222, 169, 9, false)
	else
		addPlayerOOCMessage(target, string2, 222, 169, 9)
	end

	if isTimer(player:getData("pwTimer")) then killTimer(player:getData("pwTimer")) end
	player:setData("isPW", true)
	player:setData("pwTimer", setTimer(function(player) if isElement(player) then player:removeData("isPW") end end, 2000, 1, player))

	setElementData(player, "playerWr", target)
	setElementData(target, "playerRe", player)

	playWhisperAudio2(player)
	playWhisperAudio(target)

	exports.titan_logs:playerWhisperLog(player, string1)
	exports.titan_logs:playerWhisperLog(target, string2)
	return
end
addCommandHandler("w", cmdW, false, false)

function cmdRe(player, command, ...)
	local target = getElementData(player, "playerRe")
	if(not target or not isElement(target)) then
		exports.titan_noti:showBox(player, "Nikt nie wysłał do Ciebie ostatnio wiadomości.")
		if(target) then
			setElementData(player, "playerRe", false)
		end
		return
	end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then
		exports.titan_noti:showBox(player, "TIP: /re [wiadomość]")
		return
	end

	if getElementData(target, "tog:w") and not exports.titan_admin:doesPlayerHaveAdminDuty(player) then
		exports.titan_noti:showBox(player, string.format("%s ma wyłączone prywatne wiadomości.", getPlayerICName(target)))
		return
	end
	
	if player:getData("oocBlock") > 0 then
		if not exports.titan_admin:doesPlayerHaveAdminDuty(target) then
			exports.titan_noti:showBox(player, "Majac aktywna blokadę OOC możesz pisać tylko do administratora.")
			return
		end
	end

	local nickname2 = getPlayerICName(player)
	local nickname1 = getPlayerICName(target)

	message = addStop(message)

	local string1 = string.format("Wiadomość do %s [%d]%s: %s", nickname1, getElementData(target, "playerID"), getElementData(target, "isAFK") and " [AFK]" or "", firstToUpper(message))
	local string2 = string.format("Wiadomość od %s [%d]: %s", nickname2, getElementData(player, "playerID"), firstToUpper(message))

	if player:getData("sampChat") then
		sendPlayerChatMessage(player, string1, 224, 224, 47, false)
	else
		addPlayerOOCMessage(player, string1, 224, 224, 47)
	end
	if target:getData("sampChat") then
		sendPlayerChatMessage(target, string2, 222, 169, 9, false)
	else
		addPlayerOOCMessage(target, string2, 222, 169, 9)
	end

	if isTimer(player:getData("pwTimer")) then killTimer(player:getData("pwTimer")) end
	player:setData("isPW", true)
	player:setData("pwTimer", setTimer(function(player) if isElement(player) then player:removeData("isPW") end end, 2000, 1, player))

	setElementData(player, "playerWr", target)
	setElementData(target, "playerRe", player)

	playWhisperAudio2(player)
	playWhisperAudio(target)

	exports.titan_logs:playerWhisperLog(player, string1)
	exports.titan_logs:playerWhisperLog(target, string2)
	return
end
addCommandHandler("re", cmdRe, false, false)

function cmdWr(player, command, ...)
	local target = getElementData(player, "playerWr")
	if(not target or not isElement(target)) then
		exports.titan_noti:showBox(player, "Nie wysyłałeś ostatnio do nikogo wiadomości.")
		if(target) then
			setElementData(player, "playerWr", false)
		end
		return
	end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then
		exports.titan_noti:showBox(player, "TIP: /wr [wiadomość]")
		return
	end

	if getElementData(target, "tog:w") and not exports.titan_admin:doesPlayerHaveAdminDuty(player) then
		exports.titan_noti:showBox(player, string.format("%s ma wyłączone prywatne wiadomości.", getPlayerICName(target)))
		return
	end
	
	if player:getData("oocBlock") > 0 then
		if not exports.titan_admin:doesPlayerHaveAdminDuty(target) then
			exports.titan_noti:showBox(player, "Majac aktywna blokadę OOC możesz pisać tylko do administratora.")
			return
		end
	end

	local nickname2 = getPlayerICName(player)
	local nickname1 = getPlayerICName(target)

	message = addStop(message)

	local string1 = string.format("Wiadomość do %s [%d]%s: %s", nickname1, getElementData(target, "playerID"), getElementData(target, "isAFK") and " [AFK]" or "", firstToUpper(message))
	local string2 = string.format("Wiadomość od %s [%d]: %s", nickname2, getElementData(player, "playerID"), firstToUpper(message))

	if player:getData("sampChat") then
		sendPlayerChatMessage(player, string1, 224, 224, 47, false)
	else
		addPlayerOOCMessage(player, string1, 224, 224, 47)
	end
	if target:getData("sampChat") then
		sendPlayerChatMessage(target, string2, 222, 169, 9, false)
	else
		addPlayerOOCMessage(target, string2, 222, 169, 9)
	end

	if isTimer(player:getData("pwTimer")) then killTimer(player:getData("pwTimer")) end
	player:setData("isPW", true)
	player:setData("pwTimer", setTimer(function(player) if isElement(player) then player:removeData("isPW") end end, 2000, 1, player))

	setElementData(player, "playerWr", target)
	setElementData(target, "playerRe", player)

	playWhisperAudio2(player)
	playWhisperAudio(target)

	exports.titan_logs:playerWhisperLog(player, string1)
	exports.titan_logs:playerWhisperLog(target, string2)
	return
end
addCommandHandler("wr", cmdWr, false, false)