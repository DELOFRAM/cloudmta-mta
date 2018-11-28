----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local backspaceClickTime = 0
local backspaceTimer = nil

local sW, sH = guiGetScreenSize()
local renderData = {}
renderData.chatIC =
{
	X = 40,
	Y = 10,
	W = 400,
	H = 200
}
renderData.input =
{
	X = renderData.chatIC.X,
	Y = renderData.chatIC.Y + renderData.chatIC.H + 5,
	W = renderData.chatIC.W,
	H = 30
}
local chatSettings = {}
local chatTyping =
{
	messageContent = {},
	messageType = "IC",
	messageLine = 1
}

local fontHeight = dxGetFontHeight(1.0, "default-bold")
local renderTarget = dxCreateRenderTarget(renderData.chatIC.W - 5, renderData.chatIC.H - 10, true)
local renderTarget2 = dxCreateRenderTarget(renderData.input.W - 10, renderData.input.H, true)
local chatMessagesIC = {}

globalHistory = {}
localHistory = {}

function resetChatSettings()
	chatSettings =
	{
		enabled = false,
		inputEnabled = false,
		tButtonBlock = false,
		state = "none",
		animStartTime = 0,
		animTime = 1000,
		choosedLine = 0,
		scrollingWidth = 0,
		localHistoryChoosed = 0,
		historySize = 30,
		recalculateScroll = false,
		maxScroll = 0,
		maxChars = 255,
		clickedOnDot = false
	}
	localPlayer:setData("sampChat:inputEnabled", false)
end
addEventHandler("onClientResourceStart", resourceRoot, resetChatSettings)

function toggleEvents(state)
	if state then
		addEventHandler("onClientKey", root, eventOnClientKey)
		addEventHandler("onClientClick", root, eventOnClientClick)
	else
		removeEventHandler("onClientKey", root, eventOnClientKey)
		removeEventHandler("onClientClick", root, eventOnClientClick)
	end
end

function toggleChat(state)
	if state then
		if chatSettings.enabled then return outputDebugString("[sampChat] Nastąpiła próba WŁĄCZENIA czatu, gdy jest już aktualnie włączony.") end
		chatSettings.enabled = true
		chatSettings.state = "starting"
		chatSettings.animStartTime = getTickCount()
		showChat(false)
		triggerServerEvent("toggleChat", localPlayer, true)
		globalHistory = {}
		localHistory = {}
		chatMessagesIC = {}
		addMessage("IC", "* CloudMTA Custom Chat v1.0 Loaded.", 54, 227, 227, false)

		addEventHandler("onClientRender", root, renderCustomChat)
		toggleEvents(true)
	else
		if not chatSettings.enabled then return outputDebugString("[sampChat] Nastąpiła próba WYŁĄCZENIA czatu, gdy jest już aktualnie wyłączony.") end
		if chatSettings.state == "hiding" or chatSettings.state == "starting" then return end
		chatSettings.animStartTime = getTickCount()
		chatSettings.state = "hiding"
		exports.titan_cursor:hideCustomCursor("chatMain")
		toggleEvents(false)
		showChat(true)
		triggerServerEvent("toggleChat", localPlayer, false)
	end
end

function renderCustomChat()
	local backspace = getKeyState("backspace")
	-- backSpace
		if chatSettings.inputEnabled then
			if backspace then
				if (getTickCount() - backspaceClickTime) / 500 > 1 then
					if not isTimer(backspaceTimer) then
						backspaceTimer = setTimer(backspaceFunction, 50, 0)
					end
				end
			end
		end
		if not backspace and isTimer(backspaceTimer) then
			killTimer(backspaceTimer)
		end
	--
	local alpha = 1.0
	if not chatSettings.enabled then
		removeEventHandler("onClientRender", root, renderCustomChat)
		return
	end
	if chatSettings.state == "starting" then
		local progress = (getTickCount() - chatSettings.animStartTime) / chatSettings.animTime
		alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
		if progress > 1 then
			chatSettings.state = "showing"
		end
	elseif chatSettings.state == "hiding" then
		local progress = (getTickCount() - chatSettings.animStartTime) / chatSettings.animTime
		alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
		if progress > 1 then
			resetChatSettings()
			removeEventHandler("onClientRender", root, renderCustomChat)
			return
		end
	end

	if #chatMessagesIC > 12 then
		if chatSettings.recalculateScroll then
			chatSettings.scrollingWidth = (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 5
			chatSettings.recalculateScroll = false
			chatSettings.maxScroll = tonumber(chatSettings.scrollingWidth)
		end
	end

	--outputConsole(chatSettings.scrollingWidth)

	-- CONTENT
	--dxDrawRectangle(renderData.chatIC.X, renderData.chatIC.Y, renderData.chatIC.W, renderData.chatIC.H, tocolor(0, 0, 0, 150 * alpha))
	dxDrawImage(renderData.chatIC.X, renderData.chatIC.Y, renderData.chatIC.W, renderData.chatIC.H, "client/files/mainBg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), true)

	-- PASEK PRZESUWANIA
	dxDrawImage(renderData.chatIC.X - 20, renderData.chatIC.Y, 15, 200, "client/files/scroll.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), true)

	-- PASEK PRZESUWANIA - DOT

	local maxProgress = (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 3
	local progress = 180
	if #chatMessagesIC > 12 then
		local tempProgress = chatSettings.scrollingWidth / maxProgress
		progress = interpolateBetween(0, 0, 0, 180, 0, 0, tempProgress, "Linear")
	end

	dxDrawImage(renderData.chatIC.X - 18, renderData.chatIC.Y + 4 + progress, 11, 11, "client/files/scroll_dot.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), true)


	dxSetRenderTarget(renderTarget, true)
	dxSetBlendMode("modulate_add")
	for k, v in ipairs(chatMessagesIC) do
		dxDrawText(v.message, 5, fontHeight * (k - 1) - chatSettings.scrollingWidth, 0, 50, tocolor(v.r, v.g, v.b, 255 * alpha), 1.0, "default-bold", "left", "top", false, false, false, v.colorCoded, true)
	end
	dxSetBlendMode("blend")
	dxSetRenderTarget()
	dxSetBlendMode("add")
	dxDrawImage(renderData.chatIC.X + 2, renderData.chatIC.Y + 5, renderData.chatIC.W - 5, renderData.chatIC.H - 10, renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), true)
	dxSetBlendMode("blend")
	if chatSettings.inputEnabled then
		--dxDrawRectangle(renderData.input.X, renderData.input.Y, renderData.input.W, renderData.input.H, tocolor(0, 0, 0, 150 * alpha))
		dxDrawImage(renderData.input.X, renderData.input.Y, renderData.input.W, renderData.input.H, "client/files/inputBg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), true)
		dxDrawText(chatTyping.messageType, renderData.input.X + 5 + renderData.input.W, renderData.input.Y, 0, renderData.input.H + renderData.input.Y, tocolor(255, 255, 255, 150 * alpha), 1.0, "default-bold", "left", "center", false, false, true, false, false)
		--
		--local message = table.concat(chatTyping.messageContent, "")
		--local textWidth = dxGetTextWidth(string.sub(changePolishChars(message), 0, chatTyping.messageLine - 1), 1.0, "default-bold", false)
		--dxDrawText(message, renderData.input.X + 5, renderData.input.Y, renderData.input.W - 15 + renderData.input.X, renderData.input.H + renderData.input.Y, tocolor(255, 255, 255, 255 * alpha), 1.0, "default-bold", "left", "center")
		--dxDrawLine(renderData.input.X + 5 + textWidth, renderData.input.Y + 5, renderData.input.X + 5 + textWidth, renderData.input.H + renderData.input.Y - 5, tocolor(255, 255, 255, 255 * alpha * math.abs(math.sin(getTickCount()/500))))
		dxSetRenderTarget(renderTarget2, true)
			local message = table.concat(chatTyping.messageContent, "")
			local messageWidth = dxGetTextWidth(string.sub(changePolishChars(message), 0, chatTyping.messageLine - 1), 1.0, "default-bold", false)
			local temporaryWidth = 0
			if messageWidth > renderData.input.W - 15 then
				temporaryWidth = math.abs(messageWidth - (renderData.input.W - 15))
			end
			--outputConsole(temporaryWidth)
			dxDrawText(message, 0 - temporaryWidth, 0, renderData.input.W - temporaryWidth, renderData.input.H, tocolor(255, 255, 255, 255 * alpha), 1.0, "default-bold", "left", "center", false, false, false, false, true)
			dxDrawLine(messageWidth - temporaryWidth, 5, messageWidth - temporaryWidth, renderData.input.H - 5, tocolor(255, 255, 255, 255 * alpha * math.abs(math.sin(getTickCount() / 500))))
		dxSetRenderTarget()
		dxDrawImage(renderData.input.X + 5, renderData.input.Y, renderData.input.W - 10, renderData.input.H, renderTarget2, 0, 0, 0, tocolor(255, 255, 255, 255 * alpha), true)
	end
end


--[[function getMessageBreakLine(text, colorCoded)
	local stringWitdh = dxGetTextWidth(text, 1.0, "default-bold", colorCoded)
	if stringWitdh > renderData.chatIC.W - 13 then
		local newText, oldText = "", ""
		local i = 2
		while true do
			oldText = string.sub(text, string.len(text) - i + 1)
			newText = string.sub(text, 0, string.len(text) - i)
			local newStringWidth = dxGetTextWidth(newText, 1.0, "default-bold", colorCoded)
			if newStringWidth < renderData.chatIC.W - 13 then
				return {newText, oldText}
			end
			i = i + 2
		end
	else
		return {text, false}
	end
end]]

function getKeyFromTableID(tTable, columnName, data)
	if type(tTable) == "table" then
		for k, v in ipairs(tTable) do
			if v[columnName] == data then return k end
		end
		return false
	end
end

function getMessageBreakLine(text, colorCoded, colorInfo, lineInfo, anotherOne)
	if colorCoded and not colorInfo then
		local newColoredText = tostring(text)
		colorInfo = {}
		lineInfo = 0
		while true do
			local sStart, sEnd = string.find(newColoredText, "#%x%x%x%x%x%x")
			if sStart then
				--outputDebugString(string.format("Kolor: %s, linijki: %d, %d", string.sub(newColoredText, sStart, sEnd), sStart, sEnd))
				table.insert(colorInfo, {color = string.sub(newColoredText, sStart, sEnd), line = sStart, ID = #colorInfo + 1})
				newColoredText = string.sub(newColoredText, 0, sStart)..string.sub(newColoredText, sEnd)
			else
				break
			end
		end
		text = string.gsub(text, "#%x%x%x%x%x%x", "")
	end

	local stringWitdh = dxGetTextWidth(changePolishChars(text), 1.0, "default-bold", colorCoded)
	if stringWitdh > renderData.chatIC.W - 13 then
		local newText, oldText = "", ""
		local i = 2
		while true do
			oldText = string.sub(text, string.len(text) - i + 1)
			newText = string.sub(text, 0, string.len(text) - i)
			local newStringWidth = dxGetTextWidth(changePolishChars(newText), 1.0, "default-bold", colorCoded)
			if newStringWidth < renderData.chatIC.W - 13 then
				if colorCoded then
					local stopLine = tonumber(tostring(lineInfo))
					lineInfo = lineInfo + string.len(changePolishChars(newText))
					local tempData = 0

					local toRemove = {}
					for k = 1, #colorInfo do
						if anotherOne then

						else
							local text1 = string.sub(newText, 0, colorInfo[k].line - 1 + tempData)
							local text2 = string.sub(newText, colorInfo[k].line + tempData)
							--outputDebugString(string.format("local text1 = string.sub(newText, 0, %s + %s)", tostring(colorInfo[k].line), tostring(tempData)))
							--newText = text1..colorInfo[k].color..text2
							newText = text1..colorInfo[k].color..text2
							tempData = tempData + string.len(colorInfo[k].color) - 2
							if (k < #colorInfo) and not((colorInfo[k].line > stopLine) and (colorInfo[k + 1].line >= lineInfo)) then
								table.insert(toRemove, colorInfo[k].ID)
								--outputDebugString("REMOVE COLOR "..colorInfo[k].color)
							end
						end
					end
					for k, v in ipairs(toRemove) do
						--outputDebugString("REMOVE")
						local key = getKeyFromTableID(colorInfo, "ID", v)
						if key then
							table.remove(colorInfo, key)
						end
					end
				end
				return {newText, oldText, colorInfo, lineInfo, true}
			end
			i = i + 2
		end
	else
		if colorCoded then
			if anotherOne then
				local tempData = 0
				local stopLine = tonumber(tostring(lineInfo))
				lineInfo = lineInfo + string.len(text)
				for k = 1, #colorInfo do
					--outputDebugString("WITAM syrdyczniy")
					if colorInfo[k].line < stopLine then
						--outputDebugString("SIEMKA")
						text = colorInfo[k].color..text
						tempData = tempData + string.len(colorInfo[k].color) - 3 - #colorInfo
					else
						local text1 = string.sub(text, 0, colorInfo[k].line - stopLine + tempData - 1)
						local text2 = string.sub(text, colorInfo[k].line - stopLine + tempData)
						text = text1..colorInfo[k].color..text2
						tempData = tempData + string.len(colorInfo[k].color) - 2
					end
				end
			else
				local tempData = 0
				for k = 1, #colorInfo do
					--outputDebugString("TEST")
					color = colorInfo[k].color
					line = colorInfo[k].line

					-- TEMP
					--outputDebugString(string.format("local text1 = string.sub(newText, 0 + %d, %d)", tempData, line))
					--outputDebugString(string.format("local text2 = string.sub(newText, %d)", line))
					local text1 = string.sub(text, 0, line + tempData - 1)
					local text2 = string.sub(text, line + tempData)
					text = text1..color..text2
					tempData = tempData + 5
					--table.insert(toRemove, colorInfo[k].ID)
				end
			end
		end
		return {text, false}
	end
end

--[[function cmdBle()
	addMessage("IC", "Kubas mówi: Test #ff0000Test #00ff00Test test test test test #0000ffTest test test test ttest test test test test test #fffffftest. Test Test. #ffff00Test? #ff0000JEST!", 255, 255, 255, true)
end
addCommandHandler("ble", cmdBle, false, false)]]

--[[function getMessageBreakLine(text, colorCoded, colorInfo, lineInfo, anotherOne)
	if colorCoded and not colorInfo then
		local newColoredText = tostring(text)
		colorInfo = {}
		lineInfo = 0
		while true do
			local sStart, sEnd = string.find(newColoredText, "#%x%x%x%x%x%x")
			if sStart then
				--outputDebugString(string.format("Kolor: %s, linijki: %d, %d", string.sub(newColoredText, sStart, sEnd), sStart, sEnd))
				table.insert(colorInfo, {color = string.sub(newColoredText, sStart, sEnd), line = sStart, ID = #colorInfo + 1})
				newColoredText = string.sub(newColoredText, 0, sStart)..string.sub(newColoredText, sEnd)
			else
				break
			end
		end
		text = string.gsub(text, "#%x%x%x%x%x%x", "")
	end
	local stringWitdh = dxGetTextWidth(text, 1.0, "default-bold", colorCoded)
	if stringWitdh > renderData.chatIC.W - 13 then
		local newText, oldText = "", ""
		local i = 2
		while true do
			oldText = string.sub(text, string.len(text) - i + 1)
			newText = string.sub(text, 0, string.len(text) - i)
			local newStringWidth = dxGetTextWidth(newText, 1.0, "default-bold", colorCoded)
			if newStringWidth < renderData.chatIC.W - 13 then
				outputDebugString(lineInfo)
				local color, line = "", -1
				local stopLine = tonumber(lineInfo)
				--local tempData = 0
				local toRemove = {}
				for k = 1, #colorInfo do
					--outputDebugString("TEST")
					if colorInfo[k].line <= stopLine then
						color = colorInfo[k].color
						line = colorInfo[k].line

						-- TEMP
						outputDebugString(string.format("local text1 = string.sub(newText, %s)", tempData, lineInfo))
						--outputDebugString(string.format("local text2 = string.sub(newText, %d)", line))
						local text1 = string.sub(newText, 0, line + tempData - 1)
						local text2 = string.sub(newText, line + tempData)
						lineInfo = lineInfo + string.len(newText)
						newText = text1..color..text2
						tempData = tempData + 5
						--if (k < #colorInfo) and not((colorInfo[k].line < stopLine) and (colorInfo[k + 1].line >= stopLine)) then
						--	table.insert(toRemove, colorInfo[k].ID)
						--end
					end
				end
				for k, v in ipairs(toRemove) do
					outputDebugString("REMOVE")
					local key = getKeyFromTableID(colorInfo, "ID", v)
					if key then
						table.remove(colorInfo, key)
					end
				end
				return {newText, oldText, colorInfo, lineInfo, true}
			end
			i = i + 2
		end
	else
		if not anotherOne then
			local tempData = 0
			for k = 1, #colorInfo do
				--outputDebugString("TEST")
				color = colorInfo[k].color
				line = colorInfo[k].line

				-- TEMP
				outputDebugString(string.format("local text1 = string.sub(newText, 0 + %d, %d)", tempData, line))
				outputDebugString(string.format("local text2 = string.sub(newText, %d)", line))
				local text1 = string.sub(text, 0, line + tempData - 1)
				local text2 = string.sub(text, line + tempData)
				text = text1..color..text2
				tempData = tempData + 5
				--table.insert(toRemove, colorInfo[k].ID)
			end
		else

		end
		return {text, false}
	end
end]]

function addMessage(chatType, message, r, g, b, colorCoded)
	if not chatSettings.enabled then return end
	if not r or not g or not b then
		r = 255
		g = 255
		b = 255
	end
	if chatType == "IC" then
		saveHistoryFile(string.gsub(message, "#%x%x%x%x%x%x", ""))
		local newMessage = {message, message, false, false, false}
		while true do
			newMessage = getMessageBreakLine(newMessage[2], true, newMessage[3], newMessage[4], newMessage[5])
			if #chatMessagesIC > 50 then
				table.remove(chatMessagesIC, 1)
			end
			table.insert(chatMessagesIC, {message = newMessage[1], r = r, g = g, b = b, colorCoded = colorCoded and true or false})
			if not chatSettings.inputEnabled or (chatSettings.inputEnabled and chatSettings.scrollingWidth == chatSettings.maxScroll) then
				chatSettings.recalculateScroll = true
			end
			--if #chatData.messagesIC > 12 then
				--chatData.scrollingWidth = (chatData.fontHeight * (#chatData.messagesIC - 1)) - (chatData.fontHeight * 12)
			--end
			if not newMessage[2] then break end
		end
	end
end
addEvent("addMessage", true)
addEventHandler("addMessage", root, addMessage)

function changePolishChars(text)
	local newText = ""
	for c in text:gmatch(".[\128-\191]*") do
		if c == "ą" then c = "a" end
		if c == "ę" then c = "e" end
		if c == "ó" then c = "o" end
		if c == "ć" then c = "c" end
		if c == "ż" then c = "z" end
		if c == "ź" then c = "z" end
		if c == "ń" then c = "n" end
		if c == "ł" then c = "l" end
		if c == "ś" then c = "s" end
		if c == "€" then c = "u" end
		if c == "Ą" then c = "A" end
		if c == "Ę" then c = "E" end
		if c == "Ó" then c = "O" end
		if c == "Ć" then c = "C" end
		if c == "Ż" then c = "Z" end
		if c == "Ź" then c = "Z" end
		if c == "Ń" then c = "N" end
		if c == "Ł" then c = "L" end
		if c == "Ś" then c = "S" end
		newText = newText..c
	end
	return newText
end

function isCursorGetRectangle(X, Y, W, H)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * sW, cY * sH
	W = W + X
	H = H + Y
	if(cX > X and cX < W and cY > Y and cY < H) then return true end
	return false
end

function eventOnClientClick(button, state)
	if button == "left" then
		if state == "down" and not chatSettings.clickedOnDot then
			local maxProgress = (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 3
			local progress = 180
			if #chatMessagesIC > 12 then
				local tempProgress = chatSettings.scrollingWidth / maxProgress
				progress = interpolateBetween(0, 0, 0, 180, 0, 0, tempProgress, "Linear")
				--renderData.chatIC.X - 18, renderData.chatIC.Y + 4 + progress, 11, 11

				if isCursorGetRectangle(renderData.chatIC.X - 18, renderData.chatIC.Y + 4 + progress, 11, 11) then
					chatSettings.clickedOnDot = true
					addEventHandler("onClientRender", root, eventOnClientMouseMove)
					--outputDebugString("WITAM! :0")
				end
			end
		elseif state == "up" then
			if chatSettings.clickedOnDot then
				chatSettings.clickedOnDot = false
				removeEventHandler("onClientRender", root, eventOnClientMouseMove)
			end
		end
	end
end

function backspaceFunction()
	if #chatTyping.messageContent > 0 then
		if chatTyping.messageLine > 1 then
			table.remove(chatTyping.messageContent, chatTyping.messageLine - 1)
			localHistory[chatSettings.localHistoryChoosed] = chatTyping.messageContent
			chatTyping.messageLine = chatTyping.messageLine - 1
		end
	end
end

function eventOnClientMouseMove()
	local aX, aY = getCursorPosition()
	aY = aY * sH
	--outputConsole("test")
	if chatSettings.clickedOnDot then
		local minX = renderData.chatIC.Y + 4
		local maxX = renderData.chatIC.Y + 184

		local tempMaxX = maxX - minX
		local tempAX = aY - minX
		--outputConsole(tempAX)

		--dxDrawText(tempAX, 500, 500)
		local progress = 0
		if tempAX < 0 then
			progress = 0
		elseif tempAX > 0 then
			if tempAX > tempMaxX then
				progress = 1
			else
				progress = tempAX / tempMaxX
			end
		end
		chatSettings.scrollingWidth = ((fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 5) * progress
	end
end

function eventOnClientKey(button, press)
	if chatSettings.inputEnabled then
		cancelEvent()
	end
	if press then

		if string.lower(button) == "t" and not chatSettings.inputEnabled and not guiGetInputEnabled() and (not getElementData(localPlayer, "phoneState") or (getElementData(localPlayer, "phoneState") and not isCursorShowing())) then
			chatSettings.tButtonBlock = true
			chatSettings.inputEnabled = true
			localPlayer:setData("sampChat:inputEnabled", true)
			chatSettings.maxScroll = tonumber(chatSettings.scrollingWidth)
			chatTyping.messageType = "IC"
			exports.titan_cursor:showCustomCursor("chatMain")
			localHistory = {}
			local copy = toJSON(globalHistory)
			localHistory = fromJSON(copy)
			chatSettings.localHistoryChoosed = #localHistory + 1
			localHistory[chatSettings.localHistoryChoosed] = {}
			addEventHandler("onClientCharacter", root, eventOnClientCharacter)
		elseif string.lower(button) == "b" and not chatSettings.inputEnabled and not guiGetInputEnabled() and (not getElementData(localPlayer, "phoneState") or (getElementData(localPlayer, "phoneState") and not isCursorShowing())) then
			chatSettings.tButtonBlock = true
			chatSettings.inputEnabled = true
			localPlayer:setData("sampChat:inputEnabled", true)
			chatSettings.maxScroll = tonumber(chatSettings.scrollingWidth)
			chatTyping.messageType = "OOC"
			exports.titan_cursor:showCustomCursor("chatMain")
			localHistory = {}
			local copy = toJSON(globalHistory)
			localHistory = fromJSON(copy)
			chatSettings.localHistoryChoosed = #localHistory + 1
			localHistory[chatSettings.localHistoryChoosed] = {}
			addEventHandler("onClientCharacter", root, eventOnClientCharacter)
		end

		if chatSettings.inputEnabled then
			if button == "backspace" then
				backspaceClickTime = getTickCount()
				backspaceFunction()
			end
			if button == "escape" then
				chatSettings.inputEnabled = false
				localPlayer:setData("sampChat:inputEnabled", false)
				chatTyping.messageContent = {}
				chatTyping.messageLine = 1
				exports.titan_cursor:hideCustomCursor("chatMain")
				removeEventHandler("onClientCharacter", root, eventOnClientCharacter)
			end
			if button == "arrow_l" then
				chatTyping.messageLine = chatTyping.messageLine - 1
				if chatTyping.messageLine < 1 then chatTyping.messageLine = 1 end
			end
			if button == "arrow_r" then
				chatTyping.messageLine = chatTyping.messageLine + 1
				if chatTyping.messageLine > #chatTyping.messageContent + 1 then chatTyping.messageLine = #chatTyping.messageContent + 1 end
			end
			if button == "arrow_u" then
				if #localHistory > 0 then
					if chatSettings.localHistoryChoosed - 1 > 0 then
						chatSettings.localHistoryChoosed = chatSettings.localHistoryChoosed - 1
						chatTyping.messageContent = localHistory[chatSettings.localHistoryChoosed]
						chatTyping.messageLine = string.len(changePolishChars(table.concat(chatTyping.messageContent, ""))) + 1
					end
				end
			end
			if button == "arrow_d" then
				if #localHistory > 0 then
					if type(localHistory[chatSettings.localHistoryChoosed + 1]) == "table" then
						chatSettings.localHistoryChoosed = chatSettings.localHistoryChoosed + 1
						chatTyping.messageContent = localHistory[chatSettings.localHistoryChoosed]
						chatTyping.messageLine = string.len(changePolishChars(table.concat(chatTyping.messageContent, ""))) + 1
					end
				end
			end
			if button == "mouse_wheel_up" then
				chatSettings.scrollingWidth = chatSettings.scrollingWidth - 5
				if chatSettings.scrollingWidth < 0 then chatSettings.scrollingWidth = 0 end
			end
			if button == "pgup" then
				chatSettings.scrollingWidth = chatSettings.scrollingWidth - 30
				if chatSettings.scrollingWidth < 0 then chatSettings.scrollingWidth = 0 end
			end
			if button == "mouse_wheel_down" then
				if #chatMessagesIC > 13 then
					chatSettings.scrollingWidth = chatSettings.scrollingWidth + 5
					if chatSettings.scrollingWidth > (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 5 then
						chatSettings.scrollingWidth = (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 5
					end
				end
			end
			if button == "pgdn" then
				if #chatMessagesIC > 13 then
					chatSettings.scrollingWidth = chatSettings.scrollingWidth + 30
					if chatSettings.scrollingWidth > (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 5 then
						chatSettings.scrollingWidth = (fontHeight * (#chatMessagesIC - 1)) - (fontHeight * 12) + 5
					end
				end
			end
			if button == "enter" then
				if #chatTyping.messageContent > 0 then
					local message = table.concat(chatTyping.messageContent, "")
					if chatTyping.messageType == "IC" and string.sub(message, 1, 1) == "/" then
						local command, arguments = splitCommand(message)
						--outputDebugString(string.format("[CHAT] COMMAND NAME: %s, ARGUMENTS: %s", tostring(command), tostring(arguments)))
						triggerServerEvent("commandHandlerExecute", localPlayer, command, arguments)
						if #globalHistory > 0 then
							local oldContent = table.concat(globalHistory[#globalHistory])
							if table.concat(chatTyping.messageContent, "") ~= oldContent then
								if #globalHistory > chatSettings.historySize then
									table.remove(globalHistory, 1)
								end
								table.insert(globalHistory, chatTyping.messageContent)
							end
						else
							if #globalHistory > chatSettings.historySize then
								table.remove(globalHistory, 1)
							end
							table.insert(globalHistory, chatTyping.messageContent)
						end
					else
						--local time = getRealTime()
						--message = string.format("[%0.2d:%0.2d] Kubas mówi: %s", time.hour, time.minute, message)
						--message = string.format("Kubas mówi: %s", message)
						--addMessage("IC", message, 255, 0, 0)
						if string.len(message) > chatSettings.maxChars then
							return exports.titan_noti:showBox("Wpisana wiadomość jest zbyt długa. Maksymalna długość wpisanej wiadomości wynosi "..chatSettings.maxChars.." znaków.")
						end
						triggerServerEvent("chatMessage", localPlayer, message, chatTyping.messageType)
						if #globalHistory > 0 then
							local oldContent = table.concat(globalHistory[#globalHistory])
							if table.concat(chatTyping.messageContent, "") ~= oldContent then
								table.insert(globalHistory, chatTyping.messageContent)
							end
						else
							if #globalHistory > chatSettings.historySize then
								table.remove(globalHistory, 1)
							end
							table.insert(globalHistory, chatTyping.messageContent)
						end
					end
				end

				chatSettings.inputEnabled = false
				localPlayer:setData("sampChat:inputEnabled", false)
				chatTyping.messageContent = {}
				chatTyping.messageLine = 1
				exports.titan_cursor:hideCustomCursor("chatMain")
				removeEventHandler("onClientCharacter", root, eventOnClientCharacter)
				return true
			end
		end
	else
		if (button == "t" or button == "b") and chatSettings.tButtonBlock then
			chatSettings.tButtonBlock = false
		end
	end
end

function eventOnClientCharacter(key)
	if chatSettings.inputEnabled then
		if chatSettings.tButtonBlock and (string.lower(key) == "t" or string.lower(key) == "b") then return end
		--outputDebugString(key)
		table.insert(chatTyping.messageContent, chatTyping.messageLine, key)
		localHistory[chatSettings.localHistoryChoosed] = chatTyping.messageContent
		chatTyping.messageLine = chatTyping.messageLine + 1
	end
end

function splitCommand(message)
	local commandName = string.sub(message, 2)
	local whiteChar = string.find(message, " ")
	if not whiteChar then return commandName, nil end
	return string.sub(commandName, 1, whiteChar - 2), string.sub(commandName, whiteChar)
end

function tmpCmd()
	toggleChat(not chatSettings.enabled)
end
--addCommandHandler("chat", tmpCmd, false, false)

function tryExecuteCommandClientside(commandName, arguments)
	local executeState = executeCommandHandler(commandName, arguments)
	if executeState then
		--outputDebugString(string.format("[CHAT-CS] Komenda %s wykonana pomyślnie.", tostring(commandName)))
	else
		playSoundFrontEnd(18)
		--outputDebugString(string.format("[CHAT-CS] Komenda %s nie została wykonana pomyślnie.", tostring(commandName)))
	end
end
addEvent("tryExecuteCommandClientside", true)
addEventHandler("tryExecuteCommandClientside", root, tryExecuteCommandClientside)

function saveHistoryFile(text)
	local historyFile
	local time = getRealTime()
	local fileName = string.format("chatHistory/%0.2d.%0.2d.%0.4d.txt", time.monthday, time.month + 1, time.year + 1900)
	if fileExists(fileName) then
		historyFile = fileOpen(fileName)
	else
		historyFile = fileCreate(fileName)
	end
	fileSetPos(historyFile, fileGetSize(historyFile))
	fileWrite(historyFile, string.format("[%0.2d:%0.2d:%0.2d] %s\n", time.hour, time.minute, time.second, text))
	fileClose(historyFile)
end