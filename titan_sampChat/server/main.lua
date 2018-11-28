----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function commandHandlerExecute(commandName, arguments)
	if string.lower(tostring(commandName)) == "me" then
		exports.titan_chats:onPlayerChat2(source, arguments, 1)
		return
	end
	local executeState = executeCommandHandler(commandName, source, arguments)
	if executeState then
		--outputDebugString(string.format("[CHAT] Komenda %s wykonana pomyślnie.", tostring(commandName)))
	else
		--outputDebugString(string.format("[CHAT] Komenda %s nie została wykonana pomyślnie. Może komenda po stronie klienta?", tostring(commandName)))
		triggerClientEvent(source, "tryExecuteCommandClientside", source, commandName, arguments)
	end
end
addEvent("commandHandlerExecute", true)
addEventHandler("commandHandlerExecute", root, commandHandlerExecute)

function chatMessage(text, messageType)
	if messageType == "IC" then
		exports.titan_chats:onPlayerChat2(source, text, 0)
	elseif messageType == "OOC" then
		executeCommandHandler("b", source, text)
	end
end
addEvent("chatMessage", true)
addEventHandler("chatMessage", root, chatMessage)

function sendMessage(player, chatType, message, r, g, b, colorCoded)
	if not colorCoded then colorCoded = false end
	triggerClientEvent(player, "addMessage", resourceRoot, chatType, message, r, g, b, colorCoded)
end

function toggleChat(state)
	if isElement(source) then
		if state then
			source:setData("sampChat", true)
			source:setData("hide:OOC", true)
		else
			source:removeData("sampChat")
			source:removeData("hide:OOC")
		end
	end
end
addEvent("toggleChat", true)
addEventHandler("toggleChat", root, toggleChat)
