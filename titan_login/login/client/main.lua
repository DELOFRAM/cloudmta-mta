----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local firstHexData = {math.floor(sW / 2 - 200 / 2), math.floor(sH / 2 - 230 / 2), 200, 230}
local bigLogoPosition = {firstHexData[1] + 15, firstHexData[2] + 60, 170, 89}
local minLogo = {114, 60, bigLogoPosition[1] + 29, bigLogoPosition[2] - 40}
local charImage = {math.floor(200 / 2 - (77 / 2) / 2), 40, math.floor(77 / 2), math.floor(217 / 2)}
local charText = {0, charImage[2] + 10 + charImage[4], firstHexData[3], charImage[2] + 10 + 10 + charImage[4]}
local font = dxCreateFont("login/client/files/font.ttf", 11)
local breath = {1, 0, 0}

function getPosHex(lineNumber, startX, startY, hexRadius)
	local hexR = firstHexData[4] / 2 + hexRadius
	local hexr = (hexR * math.sqrt(3)) / 2
	local x, y
	if(lineNumber == 1) then
		x = startX + hexr
		y = startY - 1.5 * hexR
	elseif(lineNumber == 2) then
		x = startX + 2 * hexr
		y = startY
	elseif(lineNumber == 3) then
		x = startX + hexr
		y = startY + 1.5 * hexR
	elseif(lineNumber == 4) then
		x = startX - hexr
		y = startY + 1.5 * hexR
	elseif(lineNumber == 5) then
		x = startX - 2 * hexr
		y = startY
	elseif(lineNumber == 6) then
		x = startX - hexr
		y = startY - 1.5 * hexR
	end
	return x, y
end

local dataHexStepLast = 0

Settings = {}
Settings.var = {}
Settings.var.cutoff = 0.1
Settings.var.power = 1.88
Settings.var.bloom = 1.0

myScreenSource = dxCreateScreenSource(sW / 2, sH / 2)
blurHShader,tecName = dxCreateShader("login/client/files/blurH.fx")
blurVShader,tecName = dxCreateShader("login/client/files/blurV.fx")

local krecenie = 1
local chars = {}
local chooseChar = 1

local step
local stepCount
local GUI = {}

function createGUI()
	GUI.button = guiCreateButton(firstHexData[1] + 50, firstHexData[2] + 180, 99, 18, "Zaloguj", false)
	GUI.label = guiCreateLabel(firstHexData[1] + 50, firstHexData[2] + 150, 97, 19, "Zapamiętaj mnie", false)
	guiLabelSetHorizontalAlign(GUI.label, "center", false)
	guiLabelSetVerticalAlign(GUI.label, "center")
	GUI.checkbox = guiCreateCheckBox(firstHexData[1] + 35, firstHexData[2] + 150, 15, 19, "", false, false)
	GUI.nickname = guiCreateEdit(firstHexData[1] + 23, firstHexData[2] + 90, 155, 20, getPlayerName(localPlayer), false)
	GUI.password = guiCreateEdit(firstHexData[1] + 23, firstHexData[2] + 120, 155, 20, "", false)
	guiEditSetMasked(GUI.password, true)

	guiSetVisible(GUI.button, false)
	guiSetVisible(GUI.label, false)
	guiSetVisible(GUI.checkbox, false)
	guiSetVisible(GUI.nickname, false)
	guiSetVisible(GUI.password, false)

	guiSetInputMode("no_binds_when_editing")

	addEventHandler("onClientGUIClick", GUI.button, onSubmitClick, false)
end

function onResStart()
	toggleAllControls(false, true, false)
	showChat(false)
	fadeCamera(true)
	showCursor(false)
	cameraOn()
	playStartMusic()
	createGUI()
	passRemmemberCheck()
	step = 1
	stepCount = getTickCount()
	addEventHandler("onClientRender", root, renderLogin)
end
--addEventHandler("onClientResourceStart", resourceRoot, onResStart)

function passRemmemberCheck()
	if(fileExists("login/client/loginData.xml")) then
		local file = xmlLoadFile("login/client/loginData.xml")
		if(file) then
			local nick = xmlFindChild(file, "savedNick", 0)
			local pass = xmlFindChild(file, "savedPass", 0)
			if(nick and pass) then
				nick = xmlNodeGetValue(nick)
				pass = xmlNodeGetValue(pass)

				guiSetText(GUI.nickname, nick)
				guiSetText(GUI.password, pass)
				guiCheckBoxSetSelected(GUI.checkbox, true)
			end
		end
	end
end

function passRemmemberForgot()
	if(fileExists("login/client/loginData.xml")) then
		fileDelete("login/client/loginData.xml")
		return
	end
end

function passRemmemberFunc()
	if(not guiCheckBoxGetSelected(GUI.checkbox)) then
		if(fileExists("login/client/loginData.xml")) then
			fileDelete("login/client/loginData.xml")
			return
		end
	else
		if(fileExists("login/client/loginData.xml")) then
			fileDelete("login/client/loginData.xml")
		end

		local file = xmlCreateFile("login/client/loginData.xml", "loginData")
		if(file) then
			local nodeNick = xmlCreateChild(file, "savedNick")
			local nodePass = xmlCreateChild(file, "savedPass")
			if(nodeNick and nodePass) then
				xmlNodeSetValue(nodeNick, tostring(guiGetText(GUI.nickname)))
				xmlNodeSetValue(nodePass, tostring(guiGetText(GUI.password)))
				xmlSaveFile(file)
				xmlUnloadFile(file)
				return
			end
		end
	end
end

function renderLogin()
	local blurAlpha = 255
	--[[ BLUR ]]--
	RTPool.frameStart()
	dxUpdateScreenSource(myScreenSource)
	local current = myScreenSource

	current = applyDownsample(current)
	current = applyGBlurH(current, Settings.var.bloom)
	current = applyGBlurV(current, Settings.var.bloom)
	dxSetRenderTarget()
	dxDrawImage(0, -20, sW, sH + 20, current, 0,0,0, tocolor(255, 255, 255, blurAlpha))
	--[[ BLUR ]]--

	if(step > 5) then
		if(breath[1] == 0) then
			local progress = (getTickCount() - breath[3]) / 2500
			breath[2] = breath[2] + 0.05
			breath[2] = interpolateBetween(0.1, 0, 0, 1, 0, 0, progress, "InOutQuad")
			if(progress > 1) then breath[1] = 1 breath[3] = getTickCount() end
		else
			local progress = (getTickCount() - breath[3]) / 2500
			breath[2] = interpolateBetween(1, 0, 0, 0.1, 0, 0, progress, "InOutQuad")
			if(progress > 1) then breath[1] = 0 breath[3] = getTickCount() end
		end
	end

	if(step == 1) then
		dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 255))
		local progress = (getTickCount() - stepCount) / 1000
		if(progress > 1) then
			step = 2
			stepCount = getTickCount()
		end
	elseif(step == 2) then
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "Linear")
		dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, alpha))
		if(progress > 1) then
			step = 3
			stepCount = getTickCount()
		end
	elseif(step == 3) then
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
		if(progress > 1) then
			step = 4
			stepCount = getTickCount()
		end
	elseif(step == 4) then
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")
		dxDrawImage(bigLogoPosition[1], bigLogoPosition[2], bigLogoPosition[3], bigLogoPosition[4], "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
		if(progress > 1.5) then
			step = 5
			stepCount = getTickCount()
		end
	elseif(step == 5) then
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		local progress = (getTickCount() - stepCount) / 1000
		local minW, minH, newW = interpolateBetween(bigLogoPosition[3], bigLogoPosition[4], bigLogoPosition[1], minLogo[1], minLogo[2], minLogo[3], progress, "InQuad")
		local newH = interpolateBetween(bigLogoPosition[2], 0, 0, minLogo[4], 0, 0, progress, "InQuad")
		dxDrawImage(newW, newH, minW, minH, "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		if(progress > 1) then
				guiSetVisible(GUI.button, true)
				guiSetVisible(GUI.label, true)
				guiSetVisible(GUI.checkbox, true)
				guiSetVisible(GUI.nickname, true)
				guiSetVisible(GUI.password, true)
				guiSetAlpha(GUI.button, 0)
				guiSetAlpha(GUI.label, 0)
				guiSetAlpha(GUI.checkbox, 0)
				guiSetAlpha(GUI.nickname, 0)
				guiSetAlpha(GUI.password, 0)
				showCursor(true)
				setCursorAlpha(0)
				addEventHandler("onClientKey", root, onClientKey)

				breath[3] = getTickCount()
				step = 6
				stepCount = getTickCount()
		end
	elseif(step == 6) then
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawImage(minLogo[3], minLogo[4], minLogo[1], minLogo[2], "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255 * breath[2]))
		local progress = (getTickCount() - stepCount) / 1000
		if(progress < 2) then
			local alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
			setCursorAlpha(alpha * 255)
			guiSetAlpha(GUI.button, alpha)
			guiSetAlpha(GUI.label, alpha)
			guiSetAlpha(GUI.checkbox, alpha)
			guiSetAlpha(GUI.nickname, alpha)
			guiSetAlpha(GUI.password, alpha)
		end
	elseif(step == 7) then
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		dxDrawImage(minLogo[3], minLogo[4], minLogo[1], minLogo[2], "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255 * breath[2]))
		guiSetAlpha(GUI.button, alpha)
		guiSetAlpha(GUI.label, alpha)
		guiSetAlpha(GUI.checkbox, alpha)
		guiSetAlpha(GUI.nickname, alpha)
		guiSetAlpha(GUI.password, alpha)
		if(progress > 1) then
			guiSetVisible(GUI.button, false)
			guiSetVisible(GUI.label, false)
			guiSetVisible(GUI.checkbox, false)
			guiSetVisible(GUI.nickname, false)
			guiSetVisible(GUI.password, false)
			showCursor(false)

			step = 8
			stepCount = getTickCount()
		end
	elseif(step == 8) then
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		local angle = math.sin(getTickCount() / 1000) * 20
		dxDrawImage(math.floor(minLogo[3]), math.floor(minLogo[4]), math.floor(minLogo[1]), math.floor(minLogo[2]), "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255 * breath[2]))
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")
		for k, v in ipairs(chars) do
			if(k <= (6 * (math.floor(chooseChar / 6) + 1)) and k > (6 * math.floor(chooseChar / 6))) then
				local cyferka = k - (6 * (math.floor((chooseChar - 1) / 6)))
				local x, y = getPosHex(cyferka, firstHexData[1], firstHexData[2], 2)
				dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexagon2.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				if(chooseChar == k) then
					dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexGlow.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				end
				dxDrawImage(x + charImage[1], y + charImage[2], charImage[3], charImage[4], string.format("login/client/skins/%d.png", v.skin), 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawText(string.format("\n%s %s\n(UID: %d)", v.name, v.lastname, v.ID), x + charText[1], y + charText[2], x + charText[3], y + charText[4], tocolor(255, 255, 255, alpha), 1.0, font, "center", "center")
			end
		end
		if(tonumber(chooseChar) and type(chars[chooseChar]) == "table") then
			local zoom = 0.7
			local charInfo = chars[chooseChar]
			local uidString = string.format("UID: %d", charInfo.ID)
			local uidWidth = dxGetTextWidth( uidString, 1.0, font)
			local pos1 = {firstHexData[1] + (firstHexData[3] / 2) - 37, firstHexData[2] + 80}
			local pos2 = {pos1[1] - 40, pos1[2] + 20}

			local lastInGame = charInfo.lastVisit
			if(lastInGame == 0) then
				lastInGame = "Nigdy"
			else
				local temp1 = getRealTime(lastInGame)
				local temp2 = getRealTime()

				if(temp1.year == temp2.year and temp1.month == temp2.month and temp1.monthday == temp2.monthday) then
					lastInGame = string.format("dzisiaj, %0.2d:%0.2d", temp1.hour, temp1.minute)
				else
					lastInGame = string.format("%0.2d %s %0.4d %0.2d:%0.2d", temp1.monthday, getMiesiac(temp1.month), temp1.year + 1900, temp1.hour, temp1.minute)
				end
			end
			local onlineTime = {}
			onlineTime.hour = math.floor(charInfo.onlineTime / 3600)
			onlineTime.minutes = math.floor(charInfo.onlineTime / 60 - (onlineTime.hour * 60))

			dxDrawText("Wybrana postać", pos1[1], pos1[2], 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText("UID: "..charInfo.ID, pos2[1], pos2[2], 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText(string.format("Postać: %s %s", charInfo.name, charInfo.lastname), pos2[1], pos2[2] + 15, 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText(string.format("Czas Online: %dh %dm", onlineTime.hour, onlineTime.minutes), pos2[1], pos2[2] + 30, 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText(string.format("Ostatnio: %s", lastInGame), pos2[1], pos2[2] + 45, 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
		end
		if(progress > 1) then
			step = 9
		end
	elseif(step == 9) then
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		local angle = math.sin(getTickCount() / 1000) * 20
		dxDrawImage(math.floor(minLogo[3]), math.floor(minLogo[4]), math.floor(minLogo[1]), math.floor(minLogo[2]), "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255 * breath[2]))
		for k, v in ipairs(chars) do
			if(k <= (6 * (math.floor((chooseChar - 1) / 6) + 1)) and k > (6 * math.floor((chooseChar - 1) / 6))) then
				local cyferka = k - (6 * (math.floor((chooseChar - 1) / 6)))
				local x, y = getPosHex(cyferka, firstHexData[1], firstHexData[2], 2)
				dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexagon2.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				if(chooseChar == k) then
					dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexGlow.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				end
				dxDrawImage(x + charImage[1], y + charImage[2], charImage[3], charImage[4], string.format("login/client/skins/%d.png", v.skin), 0, 0, 0, tocolor(255, 255, 255, 255))
				dxDrawText(string.format("\n%s %s\n(UID: %d)", v.name, v.lastname, v.ID), x + charText[1], y + charText[2], x + charText[3], y + charText[4], tocolor(255, 255, 255, 255), 1.0, font, "center", "center")
			end
		end
		if(tonumber(chooseChar) and type(chars[chooseChar]) == "table") then
			local zoom = 0.7
			local charInfo = chars[chooseChar]
			local uidString = string.format("UID: %d", charInfo.ID)
			local uidWidth = dxGetTextWidth( uidString, 1.0, font)
			local pos1 = {firstHexData[1] + (firstHexData[3] / 2) - 37, firstHexData[2] + 80}
			local pos2 = {pos1[1] - 40, pos1[2] + 20}

			local lastInGame = charInfo.lastVisit
			if(lastInGame == 0) then
				lastInGame = "Nigdy"
			else
				local temp1 = getRealTime(lastInGame)
				local temp2 = getRealTime()

				if(temp1.year == temp2.year and temp1.month == temp2.month and temp1.monthday == temp2.monthday) then
					lastInGame = string.format("dzisiaj, %0.2d:%0.2d", temp1.hour, temp1.minute)
				else
					lastInGame = string.format("%0.2d %s %0.4d %0.2d:%0.2d", temp1.monthday, getMiesiac(temp1.month), temp1.year + 1900, temp1.hour, temp1.minute)
				end
			end
			local onlineTime = {}
			onlineTime.hour = math.floor(charInfo.onlineTime / 3600)
			onlineTime.minutes = math.floor(charInfo.onlineTime / 60 - (onlineTime.hour * 60))

			dxDrawText("Wybrana postać", pos1[1], pos1[2], 0, 0, tocolor(255, 255, 255, 255), zoom, font, "left", "top")
			dxDrawText("UID: "..charInfo.ID, pos2[1], pos2[2], 0, 0, tocolor(255, 255, 255, 255), zoom, font, "left", "top")
			dxDrawText(string.format("Postać: %s %s", charInfo.name, charInfo.lastname), pos2[1], pos2[2] + 15, 0, 0, tocolor(255, 255, 255, 255), zoom, font, "left", "top")
			dxDrawText(string.format("Czas Online: %0dh %dm", onlineTime.hour, onlineTime.minutes), pos2[1], pos2[2] + 30, 0, 0, tocolor(255, 255, 255, 255), zoom, font, "left", "top")
			dxDrawText(string.format("Ostatnio: %s", lastInGame), pos2[1], pos2[2] + 45, 0, 0, tocolor(255, 255, 255, 255), zoom, font, "left", "top")
		end
	elseif(step == 10) then
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "Linear")
		local newAngle = interpolateBetween(dataHexStepLast, 0, 0, 0, 0, 0, progress, "Linear")

		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		for k, v in ipairs(chars) do
			if(k <= (6 * (math.floor((chooseChar - 1) / 6) + 1)) and k > (6 * math.floor((chooseChar - 1) / 6))) then
				local cyferka = k - (6 * (math.floor((chooseChar - 1) / 6)))
				local x, y = getPosHex(cyferka, firstHexData[1], firstHexData[2], 2)
				dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexagon2.png", 0, 0, 0, tocolor(255, 255, 255, k == chooseChar and 255 or alpha))
				if(chooseChar == k) then
					dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexGlow.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				end
				dxDrawImage(x + charImage[1], y + charImage[2], charImage[3], charImage[4], string.format("login/client/skins/%d.png", v.skin), 0, 0, 0, tocolor(255, 255, 255, k == chooseChar and 255 or alpha))
				dxDrawText(string.format("\n%s %s\n(UID: %d)", v.name, v.lastname, v.ID), x + charText[1], y + charText[2], x + charText[3], y + charText[4], tocolor(255, 255, 255, k == chooseChar and 255 or alpha), 1.0, font, "center", "center")
			end
		end
		if(tonumber(chooseChar) and type(chars[chooseChar]) == "table") then
			local zoom = 0.7
			local charInfo = chars[chooseChar]
			local uidString = string.format("UID: %d", charInfo.ID)
			local uidWidth = dxGetTextWidth( uidString, 1.0, font)
			local pos1 = {firstHexData[1] + (firstHexData[3] / 2) - 37, firstHexData[2] + 80}
			local pos2 = {pos1[1] - 40, pos1[2] + 20}

			local lastInGame = charInfo.lastVisit
			if(lastInGame == 0) then
				lastInGame = "Nigdy"
			else
				local temp1 = getRealTime(lastInGame)
				local temp2 = getRealTime()

				if(temp1.year == temp2.year and temp1.month == temp2.month and temp1.monthday == temp2.monthday) then
					lastInGame = string.format("dzisiaj, %0.2d:%0.2d", temp1.hour, temp1.minute)
				else
					lastInGame = string.format("%0.2d %s %0.4d %0.2d:%0.2d", temp1.monthday, getMiesiac(temp1.month), temp1.year + 1900, temp1.hour, temp1.minute)
				end
			end
			local onlineTime = {}
			onlineTime.hour = math.floor(charInfo.onlineTime / 3600)
			onlineTime.minutes = math.floor(charInfo.onlineTime / 60 - (onlineTime.hour * 60))

			dxDrawText("Wybrana postać", pos1[1], pos1[2], 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText("UID: "..charInfo.ID, pos2[1], pos2[2], 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText(string.format("Postać: %s %s", charInfo.name, charInfo.lastname), pos2[1], pos2[2] + 15, 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText(string.format("Czas Online: %dh %dm", onlineTime.hour, onlineTime.minutes), pos2[1], pos2[2] + 30, 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
			dxDrawText(string.format("Ostatnio: %s", lastInGame), pos2[1], pos2[2] + 45, 0, 0, tocolor(255, 255, 255, alpha), zoom, font, "left", "top")
		end
		local minW, minH, newW = interpolateBetween(minLogo[1], minLogo[2], minLogo[3], bigLogoPosition[3], bigLogoPosition[4], bigLogoPosition[1], progress, "InQuad")
		local newH = interpolateBetween(minLogo[4], 0, 0, bigLogoPosition[2], 0, 0, progress, "InQuad")
		local breathNew = interpolateBetween(breath[2], 0, 0, 1, 0, 0, progress - 0.5, "InOutQuad")
		dxDrawImage(newW, newH, minW, minH, "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, 255 * breathNew))
		if(progress > 1.5) then
			step = 11
			stepCount = getTickCount()
			stopStartMusic()
			fadeCamera(false)
		end
	elseif(step == 11) then
		local progress = (getTickCount() - stepCount) / 1000
		local alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "Linear")
		dxDrawImage(firstHexData[1], firstHexData[2], firstHexData[3], firstHexData[4], "login/client/files/hexagon.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
		dxDrawImage(bigLogoPosition[1], bigLogoPosition[2], bigLogoPosition[3], bigLogoPosition[4], "login/client/files/logo.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
		for k, v in ipairs(chars) do
			if(k <= (6 * (math.floor((chooseChar - 1) / 6) + 1)) and k > (6 * math.floor((chooseChar - 1) / 6))) then
				local cyferka = k - (6 * (math.floor((chooseChar - 1) / 6)))
				local x, y = getPosHex(cyferka, firstHexData[1], firstHexData[2], 2)
				dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexagon2.png", 0, 0, 0, tocolor(255, 255, 255, k == chooseChar and alpha or 0))
				if(chooseChar == k) then
					dxDrawImage(x, y, firstHexData[3], firstHexData[4], "login/client/files/hexGlow.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				end
				dxDrawImage(x + charImage[1], y + charImage[2], charImage[3], charImage[4], string.format("login/client/skins/%d.png", v.skin), 0, 0, 0, tocolor(255, 255, 255, k == chooseChar and alpha or 0))
				dxDrawText(string.format("\n%s %s\n(UID: %d)", v.name, v.lastname, v.ID), x + charText[1], y + charText[2], x + charText[3], y + charText[4], tocolor(255, 255, 255, k == chooseChar and alpha or 0), 1.0, font, "center", "center")
			end
		end
		alpha = interpolateBetween(0, 0, 0, 255, 0, 0, progress, "Linear")
		dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, alpha))

		if(progress > 1) then
			cameraOff()
			removeEventHandler("onClientRender", root, renderLogin)
			triggerServerEvent("spawnPlayerAfterAnimation", localPlayer)
			setCursorAlpha(255)
			return
		end
	end
end

function onSubmitClick()

	local nickname = tostring(guiGetText(GUI.nickname))
	local password = tostring(guiGetText(GUI.password))

	if(string.len(nickname) < 1) then
		return exports.titan_noti:showBox("Uzupełnij pole z nazwą użytkownika!")
	end

	if(string.len(password) < 1) then
		return exports.titan_noti:showBox("Uzupełnij pole z hasłem!")
	end
	guiSetEnabled(GUI.button, false)
	if(guiCheckBoxGetSelected(GUI.checkbox)) then
		passRemmemberFunc()
	else
		passRemmemberForgot()
	end
	triggerServerEvent("handlerLogin", localPlayer, nickname, password)
end

function turnOnSubmitClick()
	guiSetEnabled(GUI.button, true)
end
addEvent("turnOnSubmitClick", true)
addEventHandler("turnOnSubmitClick", root, turnOnSubmitClick)

function turnOffLoginPanel(toggle)
	if toggle then
		step = -1
	else
		step = 1
	end
	outputDebugString(tostring(step))
end
addEvent("turnOffLoginPanel", true)
addEventHandler("turnOffLoginPanel", root, turnOffLoginPanel)


function nextToChooseChar(data)
	step = 7
	stepCount = getTickCount()
	chars = data
end
addEvent("nextToChooseChar", true)
addEventHandler("nextToChooseChar", root, nextToChooseChar)

function onClientKey(key, press)
	if(press) then
		if(step == 6) then
			if(key == "enter" or key == "num_enter") then
				if(not guiGetEnabled(GUI.button)) then return end
				onSubmitClick()
				return
			end
		elseif(step == 9) then
			if(key == "mouse_wheel_down" or key == "arrow_r" or key == "d") then
				chooseChar = chooseChar + 1
				if(chooseChar > #chars) then
					chooseChar = 1
				end
				return
			end
			if(key == "mouse_wheel_up" or key == "arrow_l" or key == "a") then
				chooseChar = chooseChar - 1
				if(chooseChar < 1) then
					chooseChar = #chars
				end
				return
			end
			if(key == "enter" or key == "mouse1" or key == "num_enter") then
				removeEventHandler("onClientKey", root, onClientKey)
				triggerServerEvent("handlerSelectChar", localPlayer, chars[chooseChar].ID)
				return
			end
		end
	end
end

function confirmSelectChar()
	step = 10
	stepCount = getTickCount()
	breath[3] = getTickCount()
	dataHexStepLast = math.sin(getTickCount() / 1000) * 20
end
addEvent("confirmSelectChar", true)
addEventHandler("confirmSelectChar", root, confirmSelectChar)

--- Tutaj sobie będzie blur

------------------------------
--Apply the different stages--
------------------------------
function applyDownsample( Src, amount )
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src )
	return newRT
end

function applyGBlurH( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShader, "tex0", Src )
	dxSetShaderValue( blurHShader, "tex0size", mx,my )
	dxSetShaderValue( blurHShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx, my, blurHShader )
	return newRT
end

function applyGBlurV( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShader, "tex0", Src )
	dxSetShaderValue( blurVShader, "tex0size", mx,my )
	dxSetShaderValue( blurVShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	return newRT
end

function applyBrightPass( Src, cutoff, power )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( brightPassShader, "tex0", Src )
	dxSetShaderValue( brightPassShader, "cutoff", cutoff )
	dxSetShaderValue( brightPassShader, "power", power )
	dxDrawImage( 0, 0, mx,my, brightPassShader )
	return newRT
end


--------------------------
--Pool of render targets--
--------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end

function getMiesiac(month)
	local miesiac
	if(month == 0) then
		miesiac = "stycznia"
	elseif(month == 1) then
		miesiac = "lutego"
	elseif(month == 2) then
		miesiac = "marca"
	elseif(month == 3) then
		miesiac = "kwietnia"
	elseif(month == 4) then
		miesiac = "maja"
	elseif(month == 5) then
		miesiac = "czerwca"
	elseif(month == 6) then
		miesiac = "lipca"
	elseif(month == 7) then
		miesiac = "sierpnia"
	elseif(month == 8) then
		miesiac = "września"
	elseif(month == 9) then
		miesiac = "października"
	elseif(month == 10) then
		miesiac = "listopada"
	elseif(month == 11) then
		miesiac = "grudnia"
	end
	return miesiac
end