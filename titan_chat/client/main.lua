----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local chatFunc = {}
local chatData = {}

local sW, sH = guiGetScreenSize()

chatData.chatTyping = {}
chatData.chatHistory = {}
chatData.chatLine = 1
chatData.chatHistoryChosen = 1
chatData.enabled = true
chatData.characterBlock = false
chatData.inputEnabled = false
chatData.inputType = "IC"
chatData.messagesIC = {}
chatData.renderData = {}
chatData.renderData.chatIC =
{
	X = 10,
	Y = 10,
	W = 370,
	H = 200
}
chatData.renderData.input =
{
	X = chatData.renderData.chatIC.X,
	Y = chatData.renderData.chatIC.Y + chatData.renderData.chatIC.H + 5,
	W = chatData.renderData.chatIC.W + 100,
	H = 30
}
chatData.scrollingWidth = 0
chatData.maxScrollingWidth = 0
chatData.fontHeight = dxGetFontHeight(1.0, "default-bold")
chatData.renderTarget = dxCreateRenderTarget(chatData.renderData.chatIC.W, chatData.renderData.chatIC.H, true)


function chatFunc.onResourceStart()
	if chatData.enabled then
		chatFunc.toggleChat(true, true)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, chatFunc.onResourceStart)

function chatFunc.toggleChat(state, firstUse)
	if not firstUse then firstUse = false end
	if state then
		if not chatData.enabled or firstUse then
			chatData.enabled = true
			showChat(false)
			outputDebugString("[CHAT] Custom Chat On")
			addEventHandler("onClientRender", root, chatFunc.renderChatIC)
			addEventHandler("onClientKey", root, chatFunc.onClientKey)
		end
	else
		if chatData.enabled then
			chatData.enabled = false
			showChat(true)
			outputDebugString("[CHAT] Custom Chat Off")
			removeEventHandler("onClientRender", root, chatFunc.renderChatIC)
			removeEventHandler("onClientKey", root, chatFunc.onClientKey)
			--removeEventHandler("onClientCharacter", root, chatFunc.onClientCharacter)
		end
	end
end

function chatFunc.getMessageBreakLine(text, colorCoded)
	local stringWitdh = dxGetTextWidth(text, 1.0, "default-bold", colorCoded)
	if stringWitdh > chatData.renderData.chatIC.W - 13 then
		local newText, oldText = "", ""
		local i = 2
		while true do
			oldText = string.sub(text, string.len(text) - i + 1)
			newText = string.sub(text, 0, string.len(text) - i)
			local newStringWidth = dxGetTextWidth(newText, 1.0, "default-bold", colorCoded)
			if newStringWidth < chatData.renderData.chatIC.W - 13 then
				return {newText, oldText}
			end
			i = i + 2
		end
	else
		return {text, false}
	end
end

function chatFunc.addMessage(chatType, message, r, g, b)
	if chatType == "IC" then
		local newMessage = {message, message}
		while true do
			newMessage = chatFunc.getMessageBreakLine(newMessage[2], false)
			table.insert(chatData.messagesIC, {message = newMessage[1], r = r, g = g, b = b})
			--if #chatData.messagesIC > 12 then
				--chatData.scrollingWidth = (chatData.fontHeight * (#chatData.messagesIC - 1)) - (chatData.fontHeight * 12)	
			--end
			chatFunc.recalculateScrollIC()	
			if not newMessage[2] then break end
		end
	end
end

function chatFunc.renderChatIC()
	if not chatData.enabled then return end

	dxDrawRectangle(chatData.renderData.chatIC.X, chatData.renderData.chatIC.Y, chatData.renderData.chatIC.W, chatData.renderData.chatIC.H, tocolor(0, 0, 0, 150))

	dxSetRenderTarget(chatData.renderTarget, true)
	for k, v in ipairs(chatData.messagesIC) do
		dxDrawText(v.message, 5, chatData.fontHeight * (k - 1) - chatData.scrollingWidth, 0, 0, tocolor(v.r, v.g, v.b, 255), 1.0, "default-bold", "left", "top")
		if k == #chatData.messagesIC then
			if k <= 12 then
				chatData.maxScrollingWidth = 0
			else
				chatData.maxScrollingWidth = (chatData.fontHeight * (k - 1)) - (chatData.fontHeight * 12)
			end
			--outputChatBox(chatData.maxScrollingWidth)
			--chatData.scrollingWidth = chatData.maxScrollingWidth
		end
	end
	dxSetRenderTarget()
	dxDrawImage(chatData.renderData.chatIC.X, chatData.renderData.chatIC.Y, chatData.renderData.chatIC.W, chatData.renderData.chatIC.H, chatData.renderTarget)

	if chatData.inputEnabled then
		dxDrawRectangle(chatData.renderData.input.X, chatData.renderData.input.Y, chatData.renderData.input.W, chatData.renderData.input.H, tocolor(0, 0, 0, 150))
		dxDrawText(chatData.inputType, chatData.renderData.input.X + 5 + chatData.renderData.input.W, chatData.renderData.input.Y, 0, chatData.renderData.input.H + chatData.renderData.input.Y, tocolor(255, 255, 255, 150), 1.0, "default-bold", "left", "center")
		--if type(chatData.chatHistory[chatData.chatHistoryChosen]) == "table" then
			local message = table.concat(chatData.chatTyping, "")
			--outputConsole(message)
			local textWidth = dxGetTextWidth(string.sub(message, 0, chatData.chatLine - 1), 1.0, "default-bold", false)
			dxDrawText(message, chatData.renderData.input.X + 5, chatData.renderData.input.Y, chatData.renderData.input.W - 5 + chatData.renderData.input.X, chatData.renderData.input.H + chatData.renderData.input.Y, tocolor(255, 255, 255, 255), 1.0, "default-bold", "left", "center")
			dxDrawLine(chatData.renderData.input.X + 5 + textWidth, chatData.renderData.input.Y + 5, chatData.renderData.input.X + 5 + textWidth, chatData.renderData.input.H + chatData.renderData.input.Y - 5, tocolor(255, 255, 255, 255 * math.abs(math.sin(getTickCount()/200))))
		--end
	end
end

function chatFunc.recalculateScrollIC()
	if #chatData.messagesIC > 12 then
		chatData.scrollingWidth = (chatData.fontHeight * (#chatData.messagesIC - 1)) - (chatData.fontHeight * 12)
	end
end

function chatFunc.cmdChat(command, ...)
	local arg = {...}
	local option = tostring(arg[1])
	if option == "toggle" then
		if chatData.enabled then
			chatFunc.toggleChat(false)
			exports.titan_noti:showBox("Customowy czat został wyłączony.")
		else
			chatFunc.toggleChat(true)
			exports.titan_noti:showBox("Customowy czat został włączony.")
		end
	elseif option == "test" then
		local message = table.concat(arg, " ", 2)
		chatFunc.addMessage("IC", message, math.random(0, 255), math.random(0, 255), math.random(0, 255))
	elseif option == "test2" then
		local test3 = tonumber(arg[2])
		chatData.scrollingWidth = test3
	else
		exports.titan_noti:showBox("TIP /chat [toggle, test, test2]")
	end
end
addCommandHandler("chat", chatFunc.cmdChat, false, false)

function chatFunc.onClientKey(key, press)
	if press then
		if chatData.inputEnabled then cancelEvent() end
		if key == "t" then
			if not chatData.inputEnabled then
				chatData.characterBlock = true
				chatData.inputEnabled = true
				chatData.inputType = "IC"
				exports.titan_cursor:showCustomCursor("chatMain")
				addEventHandler("onClientCharacter", root, chatFunc.onClientCharacter)
				chatData.chatTyping = {}
				chatData.chatLine = 1
				--if type(chatData.chatHistory[chatData.chatHistoryChosen]) == "table" then
				--	while true do
				--		chatData.chatHistoryChosen = chatData.chatHistoryChosen + 1
				--		if type(chatData.chatHistory[chatData.chatHistoryChosen]) ~= "table" then break end
				--	end
				--end
			end
		end

		if key == "escape" then
			if chatData.inputEnabled then
				chatData.inputEnabled = false
				exports.titan_cursor:hideCustomCursor("chatMain")
				removeEventHandler("onClientCharacter", root, chatFunc.onClientCharacter)
				if type(chatData.chatHistory[chatData.chatHistoryChosen]) == "table" then
					table.remove(chatData.chatHistory, chatData.chatHistoryChosen)
				end
			end
		end

		if key == "enter" then
			if chatData.inputEnabled then
				local message = table.concat(chatData.chatTyping, "")
				local time = getRealTime()
				message = string.format("[%0.2d:%0.2d] Kubas mówi: %s", time.hour, time.minute, message)

				chatFunc.addMessage("IC", message, 255, 255, 255)

				chatData.inputEnabled = false
				exports.titan_cursor:hideCustomCursor("chatMain")
				removeEventHandler("onClientCharacter", root, chatFunc.onClientCharacter)
				--if type(chatData.chatHistory[chatData.chatHistoryChosen]) == "table" then

					--local wtf = chatData.chatHistoryChosen
					--chatData.chatHistoryChosen = #chatData.chatHistory
					--table.insert(chatData.chatHistory, chatData.chatHistory[wtf])
					--if chatData.chatHistory[#chatData.chatHistory] == chatData.chatHistory[#chatData.chatHistory - 1] then
					--	table.remove(chatData.chatHistory, #chatData.chatHistory - 1)
					--end
					--if #chatData.chatHistory > 20 then
					--	table.remove(chatData.chatHistory, 1)
					--	chatFunc.recalculateScrollIC()
					--end
					--chatData.chatHistory[chatData.chatHistoryChosen] = chatData.chatHistory[wtf]
					--table.insert(chatData.chatHistory[chatData.chatHistoryChosen], chatData.chatHistory[wtf])
					if chatData.chatHistory[#chatData.chatHistory] ~= chatData.chatTyping then
						table.insert(chatData.chatHistory, chatData.chatTyping)
						if #chatData.chatHistory > 20 then
							table.remove(chatData.chatHistory, 1)
						end
					end
					chatData.chatHistoryChosen = #chatData.chatHistory + 1
				--end
			end
		end

		if key == "backspace" then
			if chatData.inputEnabled then
				--if type(chatData.chatHistory[chatData.chatHistoryChosen]) == "table" then
					if #chatData.chatTyping > 0 then
						table.remove(chatData.chatTyping, chatData.chatLine - 1)
						chatData.chatLine = chatData.chatLine - 1
					end
				--end
			end
		end

		if chatData.inputEnabled then
			if key == "arrow_u" then
				if type(chatData.chatHistory[chatData.chatHistoryChosen - 1]) == "table" then
					chatData.chatHistoryChosen = chatData.chatHistoryChosen - 1
					chatData.chatTyping = chatData.chatHistory[chatData.chatHistoryChosen]
					chatData.chatLine = #chatData.chatTyping + 1
					--chatFunc.addMessage("IC", chatData.chatHistoryChosen, 255, 255, 255)
				end
			end
			if key == "arrow_d" then
				if type(chatData.chatHistory[chatData.chatHistoryChosen + 1]) == "table" then
					chatData.chatHistoryChosen = chatData.chatHistoryChosen + 1
					chatData.chatTyping = chatData.chatHistory[chatData.chatHistoryChosen]
					chatData.chatLine = #chatData.chatTyping + 1
					--chatFunc.addMessage("IC", chatData.chatHistoryChosen, 255, 255, 255)
				else
					chatData.chatTyping = {}
				end
			end
			if key == "arrow_l" then
				chatData.chatLine = chatData.chatLine - 1
				if chatData.chatLine < 1 then chatData.chatLine = 1 end
			end
			if key == "arrow_r" then
				chatData.chatLine = chatData.chatLine + 1
				if chatData.chatLine > #chatData.chatTyping + 1 then chatData.chatLine = #chatData.chatTyping + 1 end
			end
			--chatFunc.addMessage("IC", chatData.chatHistoryChosen, 255, 255, 255)
		end
	else
		if key == "t" then
			chatData.characterBlock = false
		end
	end
end

function chatFunc.onClientCharacter(key)
	if chatData.inputEnabled and not chatData.characterBlock then
		--if type(chatData.chatHistory[chatData.chatHistoryChosen]) ~= "table" then chatData.chatHistory[chatData.chatHistoryChosen] = {} end
		--table.insert(chatData.chatHistory[chatData.chatHistoryChosen], key)
		table.insert(chatData.chatTyping, chatData.chatLine, key)
		chatData.chatLine = chatData.chatLine + 1
		--outputConsole(key)
	end
end