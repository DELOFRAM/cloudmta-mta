----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local pRenderData = {}
local phoneEvent = {}
local playerRingtones = {}
local sW, sH = guiGetScreenSize()
local isAnim = false

function loadPhoneRenderData()
	removeRenderData()
	-------------------
	-- CZAS ANIMACJI --
	-------------------
	pRenderData.animFullTime = 1000
	pRenderData.animLockTime = 500

	pRenderData.bg =
	{
		X = sW - 230,
		Y = sH - 434,
		W = 230,
		H = 434
	}
	pRenderData.callA = 
	{
		X = 15 + pRenderData.bg.X + 28,
		Y = 255 + pRenderData.bg.Y + 45,
		W = 65 + pRenderData.bg.X + 28,
		H = 305 + pRenderData.bg.Y + 45
	}
	pRenderData.callD = 
	{
		X = 100 + pRenderData.bg.X + 28,
		Y = 255 + pRenderData.bg.Y + 45,
		W = 150 + pRenderData.bg.X + 28,
		H = 305 + pRenderData.bg.Y + 45
	}
	pRenderData.iconWeather =
	{
		X = 5 + pRenderData.bg.X + 28,
		Y = 18 + pRenderData.bg.Y + 45,
		W = 75,
		H = 72
	}
	pRenderData.iconCall = 
	{
		X = pRenderData.bg.X + 28 + 85,
		Y = pRenderData.bg.Y + 45 + 18,
		W = 35,
		H = 35
	}
	pRenderData.iconCall = 
	{
		X = pRenderData.bg.X + 28 + 85,
		Y = pRenderData.bg.Y + 45 + 18,
		W = 35,
		H = 35
	}
	pRenderData.iconMessages = 
	{
		X = pRenderData.bg.X + 28 + 85 + 40,
		Y = pRenderData.bg.Y + 45 + 18,
		W = 35,
		H = 35
	}
	pRenderData.iconAnswer = 
	{
		X = pRenderData.bg.X + 28,
		Y = pRenderData.bg.Y + 45 + 282,
		W = pRenderData.bg.X + 28 + 167,
		H = pRenderData.bg.Y + 45 + 314
	}
	pRenderData.numberPreview =
	{
		X = 5,
		Y = 68,
		W = 125,
		H = 93,
	}
	pRenderData.contactAddEdit1 = 
	{
		X = 11,
		Y = 76,
		W = 11 + 147,
		H = 75 + 31
	}
	pRenderData.contactAddEdit2 = 
	{
		X = 11,
		Y = 125,
		W = 11 + 147,
		H = 124 + 31
	}
	pRenderData.displayToMath = 
	{
		X = pRenderData.bg.X + 28,
		Y = pRenderData.bg.Y + 45
	}

	pRenderData.testPos = {0, 0, 0, 0}


	pRenderData.phoneMessages = {}
	pRenderData.phoneMessagesPage = 1
	pRenderData.phoneMessagesComposeEditBox = 1
	pRenderData.phoneMessagesComposeNumber = {}
	pRenderData.phoneMessagesComposeText = {}
	pRenderData.phoneMessagesToggle = false
	pRenderData.phoneMessagesSendToggle = false

	pRenderData.iconWeatherLabel = guiCreateLabel(pRenderData.iconWeather.X, pRenderData.iconWeather.Y, pRenderData.iconWeather.W, pRenderData.iconWeather.H, "", false)
	pRenderData.iconCallLabel = guiCreateLabel(pRenderData.iconCall.X, pRenderData.iconCall.Y, pRenderData.iconCall.W, pRenderData.iconCall.H, "", false)
	pRenderData.iconMessagesLabel = guiCreateLabel(pRenderData.iconMessages.X, pRenderData.iconMessages.Y, pRenderData.iconMessages.W, pRenderData.iconMessages.H, "", false)

	setElementData(pRenderData.iconWeatherLabel, "labelType", "phone")
	setElementData(pRenderData.iconCallLabel, "labelType", "phone")
	setElementData(pRenderData.iconMessagesLabel, "labelType", "phone")

	setElementData(pRenderData.iconWeatherLabel, "type", 1)
	setElementData(pRenderData.iconCallLabel, "type", 2)
	setElementData(pRenderData.iconMessagesLabel, "type", 5)

	addEventHandler("onClientMouseLeave", resourceRoot, onLeave)
	addEventHandler("onClientMouseEnter", resourceRoot, onEnter)

	pRenderData.display = dxCreateRenderTarget(167, 314, true)
	pRenderData.font = {}
	pRenderData.font.adventProRegular = dxCreateFont("items/client/phone/files/AdventPro-Regular.ttf", 38)
	pRenderData.displayState = "locked"
	pRenderData.displayState2 = "locked"
	pRenderData.displayStateTime = 0
	pRenderData.callNumber = false
	pRenderData.animState = "none"
	pRenderData.nextDisplayState = ""
	pRenderData.nextDisplayState2 = ""
	pRenderData.menuSelect = 0

	pRenderData.readMessageIndex = 0

	pRenderData.phoneError = 0

	pRenderData.msgTable = {}
	pRenderData.numberTable = {}

	pRenderData.phoneContacts = {}
	pRenderData.phoneContactsIndex = {}
	pRenderData.phoneContactsPage = 1

	pRenderData.contactAddName = {}
	pRenderData.contactAddNumber = {}
	pRenderData.contactAddEditbox = 1
	pRenderData.contactAddToggle = false
end
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------- RENDER -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function renderPhone()
	local addHeight = 0
	if(pRenderData.animState == "starting") then
		local progress = (getTickCount() - pRenderData.animTime) / pRenderData.animFullTime
		addHeight = interpolateBetween(pRenderData.bg.H, 0, 0, 0, 0, 0, progress, "OutQuad")
		if(progress > 1) then
			pRenderData.animState = "showing"
			isAnim = false
		end
	elseif(pRenderData.animState == "hiding") then
		local progress = (getTickCount() - pRenderData.animTime) / pRenderData.animFullTime
		addHeight = interpolateBetween(0, 0, 0, pRenderData.bg.H, 0, 0, progress, "InQuad")
		if(progress > 1) then
			removeEventHandler("onClientRender", root, renderPhone)
			removeRenderData()
			return
		end
	end

	-------------------
	-- RENDER EKRANU --
	-------------------
	dxSetRenderTarget(pRenderData.display, true)
	--
		------------
		-- TAPETA --
		------------
		dxDrawImage(0, 0, 167, 314, "items/client/phone/files/wallpaper.png")
		--------------------
		-- BLOKADA EKRANU --
		--------------------
		if(pRenderData.displayState == "locked") then
			local displayAddHeight = 0
			if(pRenderData.displayState2 == "hiding") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				displayAddHeight = interpolateBetween(0, 0, 0, -314, 0, 0, progress, "InQuad")
				if(progress > 1) then
					pRenderData.displayState = "mainMenu"
					pRenderData.displayState2 = "showMenu"
					pRenderData.displayStateTime = getTickCount()
				end
			end
			dxDrawImage(0, 0 + displayAddHeight, 167, 314, "items/client/phone/files/locked.png")
			local fullTime = getRealTime()
			local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)

			local line1 = string.format("%s", getDay(fullTime.weekday))
			local line2 = string.format("%d %s %0.4d", fullTime.monthday, getMiesiac(fullTime.month), fullTime.year + 1900)

			dxDrawText(time, 0, 10 + displayAddHeight, 167, 0, tocolor(255, 255, 255, 200), 1.0, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
			dxDrawText(line1, 10, 65 + displayAddHeight, 0, 0, tocolor(255, 255, 255, 200), 0.4, pRenderData.font.adventProRegular, "left", "top", false, false, false, false, true, 0, 0, 0)
			dxDrawText(line2, 10, 85 + displayAddHeight, 0, 0, tocolor(255, 255, 255, 200), 0.35, pRenderData.font.adventProRegular, "left", "top", false, false, false, false, true, 0, 0, 0)
		--------------------
		-- EKRAN STARTOWY --
		--------------------
		elseif(pRenderData.displayState == "mainMenu") then
			------------------
			-- WYJAZD PASKA --
			------------------
			if(pRenderData.displayState2 == "showMenu") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local height, alpha = interpolateBetween(-13, 0, 0, 0, 200, 0, progress, "OutQuad")
				if(progress > 1) then
					pRenderData.displayState = "mainMenu"
					pRenderData.displayState2 = "menuShowed"
				end
				dxDrawImage(0, height, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1 + height, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
				-----------
				-- IKONY --
				-----------
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-weather.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-settings.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-phone.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-notes.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-message.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				--[[dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-music.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-calendar.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				]]
				-- WIADOMOŚCI (!) -- dxDrawText("1", 130, 28, 150, 43, tocolor(191, 188, 132, alpha), 1.0, "default", "center", "center", false, false, false, false, true, 0, 0, 0)
			elseif(pRenderData.displayState2 == "showMenu2") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local alpha = interpolateBetween(-0, 0, 0, 200, 0, 0, progress, "OutQuad")
				if(progress > 1) then
					pRenderData.displayState = "mainMenu"
					pRenderData.displayState2 = "menuShowed"
				end
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
				-----------
				-- IKONY --
				-----------
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-weather.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-settings.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-phone.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-notes.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-message.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				--[[dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-music.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-calendar.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				]]
			elseif(pRenderData.displayState2 == "menuShowed") then
				local time = getRealTime()
				local time = string.format("%0.2d:%0.2d", time.hour, time.minute)
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
				-----------
				-- IKONY --
				-----------
				local alpha = 200 if(pRenderData.menuSelect == 1) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-weather.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 200 if(pRenderData.menuSelect == 2) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-phone.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 200 if(pRenderData.menuSelect == 3) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-settings.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 200 if(pRenderData.menuSelect == 4) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-notes.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 200 if(pRenderData.menuSelect == 5) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-message.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				--[[local alpha = 200 if(pRenderData.menuSelect == 5) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-music.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 200 if(pRenderData.menuSelect == 7) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-calendar.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				]]
			elseif(pRenderData.displayState2 == "menuHiding") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local alpha = interpolateBetween(200, 0, 0, 0, 0, 0, progress, "InQuad")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()
				end
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
				-----------
				-- IKONY --
				-----------
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-weather.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-settings.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-phone.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-notes.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-message.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				--[[dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-music.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-calendar.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				]]
			end
		---------------------
		-- MENU DZWONIENIA --
		---------------------
		elseif(pRenderData.displayState == "callMenu") then

			if(pRenderData.displayState2 == "starting") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local alpha = interpolateBetween(0, 0, 0, 200, 0, 0, progress, "OutQuad")
				if(progress > 1) then
					pRenderData.displayState2 = "showing"
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/callNumbers.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/callCall.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
			elseif(pRenderData.displayState2 == "showing") then
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/callNumbers.png", 0, 0, 0, tocolor(255, 255, 255, 200))
				local alpha = 200
				if(isCursorGet(pRenderData.iconAnswer.X, pRenderData.iconAnswer.Y, pRenderData.iconAnswer.W, pRenderData.iconAnswer.H)) then
					alpha = 255
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/callCall.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local number = table.concat(pRenderData.numberTable, "")
				if(tonumber(number)) then
					if(string.len(number) >= 6) then
						number = convertNumber(tonumber(number))
					end
					dxDrawText(number, pRenderData.numberPreview.X, pRenderData.numberPreview.Y, pRenderData.numberPreview.W, pRenderData.numberPreview.H, tocolor(255, 255, 255, 200), 0.5, pRenderData.font.adventProRegular, "left", "center", true, false, false, false, false, 0, 0, 0)
				end
			elseif(pRenderData.displayState2 == "hiding") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local alpha = interpolateBetween(200, 0, 0, 0, 0, 0, progress, "InQuad")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/callNumbers.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/callCall.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local number = table.concat(pRenderData.numberTable, "")
				if(tonumber(number)) then
					if(string.len(number) >= 6) then
						number = convertNumber(tonumber(number))
					end
					dxDrawText(number, pRenderData.numberPreview.X, pRenderData.numberPreview.Y, pRenderData.numberPreview.W, pRenderData.numberPreview.H, tocolor(255, 255, 255, alpha), 0.5, pRenderData.font.adventProRegular, "left", "center", true, false, false, false, false, 0, 0, 0)
				end
			end
			dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
			local fullTime = getRealTime()
			local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
			dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
		---------------------
		-- GDY KTOŚ DZWONI --
		---------------------
		elseif(pRenderData.displayState == "callReceive") then
			dxDrawImage(0, 0, 167, 314, "items/client/phone/files/call-bg.png")
			local number = pRenderData.callNumber
			if(pRenderData.phoneContactsIndex[tostring(number)]) then
				number = pRenderData.phoneContactsIndex[tostring(number)]
			else
				if(tonumber(number)) then
					number = convertNumber(tonumber(number))
				else
					number = "---"
				end
			end
			dxDrawText("Połączenie od...", 10, 25, 0, 0, tocolor(255, 255, 255, 200), 0.85, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
			dxDrawText(number, 10, 35, 0, 0, tocolor(255, 255, 255, 200), 0.5, pRenderData.font.adventProRegular, "left", "top", false, false ,false, false, true, 0, 0, 0)
			local alpha = 150
			if(isCursorGet(pRenderData.callA.X, pRenderData.callA.Y, pRenderData.callA.W, pRenderData.callA.H)) then
				alpha = 255
			end
			dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-call-a.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
			local alpha = 150
			if(isCursorGet(pRenderData.callD.X, pRenderData.callD.Y, pRenderData.callD.W, pRenderData.callD.H)) then
				alpha = 255
			end
			dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-call-d.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
			dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
			local fullTime = getRealTime()
			local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
			dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
		------------------
		-- GDY DZWONISZ --
		------------------
		elseif(pRenderData.displayState == "call") then
			if(pRenderData.displayState2 == "phoning") then
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/call-bg.png")
				dxDrawText("Dzwonię...", 10, 25, 0, 0, tocolor(255, 255, 255, 200), 0.85, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
				local number = table.concat(pRenderData.numberTable, "")
				if(pRenderData.phoneContactsIndex[number]) then
					number = pRenderData.phoneContactsIndex[number]
				else
					if(tonumber(number)) then
						number = convertNumber(tonumber(number))
					else
						number = "---"
					end
				end
				dxDrawText(number, 10, 35, 0, 0, tocolor(255, 255, 255, 200), 0.5, pRenderData.font.adventProRegular, "left", "top", false, false ,false, false, true, 0, 0, 0)
				
				local alpha = 150
				if(isCursorGet(pRenderData.callD.X, pRenderData.callD.Y, pRenderData.callD.W, pRenderData.callD.H)) then
					alpha = 255
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-call-d.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
			elseif(pRenderData.displayState2 == "error") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / 3000
				if(progress > 1) then
					pRenderData.displayState = "callMenu"
					pRenderData.displayState2 = "starting"
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/call-bg.png")
				dxDrawText(pRenderData.errorCall == 1 and "Rozłączono" or pRenderData.errorCall == 2 and "Zajęte" or pRenderData.errorCall == 4 and "Nie odpowiada" or "Błąd połączenia", 10, 25, 0, 0, tocolor(255, 255, 255, 200), 0.85, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
				local number = table.concat(pRenderData.numberTable, "")
				if(pRenderData.phoneContactsIndex[number]) then
					number = pRenderData.phoneContactsIndex[number]
				else
					if(tonumber(number)) then
						number = convertNumber(tonumber(number))
					else
						number = "---"
					end
				end
				dxDrawText(number, 10, 35, 0, 0, tocolor(255, 255, 255, 200), 0.5, pRenderData.font.adventProRegular, "left", "top", false, false ,false, false, true, 0, 0, 0)
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
			elseif(pRenderData.displayState2 == "talk") then
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/call-bg.png")
				dxDrawText("Rozmowa", 10, 25, 0, 0, tocolor(255, 255, 255, 200), 0.85, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
				local number = table.concat(pRenderData.numberTable, "")
				if(pRenderData.phoneContactsIndex[number]) then
					number = pRenderData.phoneContactsIndex[number]
				else
					if(tonumber(number)) then
						number = convertNumber(tonumber(number))
					else
						number = "---"
					end
				end
				dxDrawText(number, 10, 35, 0, 0, tocolor(255, 255, 255, 200), 0.5, pRenderData.font.adventProRegular, "left", "top", false, false ,false, false, true, 0, 0, 0)
				
				local alpha = 150
				if(isCursorGet(pRenderData.callD.X, pRenderData.callD.Y, pRenderData.callD.W, pRenderData.callD.H)) then
					alpha = 255
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/icon-call-d.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				-- Linia
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
			end
		elseif(pRenderData.displayState == "contacts") then
			if(pRenderData.displayState2 == "starting") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local alpha, progress2 = interpolateBetween(0, 0, 0, 255, 1, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState2 = "showing"
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/contacts-bg.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)

				-- KONTAKY wyświetlanie --
				--dxDrawText("KONTAKTY", 10, 15, 167, 0, tocolor(255, 255, 255, 200 * progress), 0.3, pRenderData.font.adventProRegular, "left", "top", false, false, false, false, true, 0, 0, 0)
				dxDrawImage(140, 35, 20, 20, "items/client/phone/files/contact-add.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
				if(#pRenderData.phoneContacts <= 0) then
					dxDrawText("Brak kontaktów", 0, 70, 167, 0, tocolor(255, 255, 255, 200 * progress2), 0.4, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
				else
					for k, v in ipairs(pRenderData.phoneContacts) do
						local cNumber = k - ((pRenderData.phoneContactsPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneContactsPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneContactsPage - 1))) - 1)
								local cName = v.name
								if(string.len(cName) > 12) then
									cName = string.sub(cName, 0, 12).."..."
								end
								dxDrawText(cName, 5, contactHeight, 95, contactHeight + 20, tocolor(255, 255, 255, 200 * progress2), 1.0, "default-bold", "left", "top", true, false, false, false, true, 0, 0, 0)
								dxDrawText(convertNumber(v.number), 10, contactHeight + 14, 0, 0, tocolor(255, 255, 255, 170 * progress2), 0.9, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
								dxDrawImage(100, contactHeight + 5, 20, 20, "items/client/phone/files/contact-call.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
								dxDrawImage(120, contactHeight + 5, 20, 20, "items/client/phone/files/contact-message.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
								dxDrawImage(140, contactHeight + 5, 20, 20, "items/client/phone/files/contact-edit.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
							end
						end
					end
				end

			elseif(pRenderData.displayState2 == "showing") then
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/contacts-bg.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				-- Linia
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
				
				-- KONTAKY wyświetlanie --
				--dxDrawText("KONTAKTY", 10, 15, 167, 0, tocolor(255, 255, 255, 200), 0.3, pRenderData.font.adventProRegular, "left", "top", false, false, false, false, true, 0, 0, 0)
				local alpha = 150
				if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + 35, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + 35 + 20)) then
					alpha = 220
				end
				dxDrawImage(140, 35, 20, 20, "items/client/phone/files/contact-add.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				if(#pRenderData.phoneContacts <= 0) then
					dxDrawText("Brak kontaktów", 0, 70, 167, 0, tocolor(255, 255, 255, 200), 0.4, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
				else
					for k, v in ipairs(pRenderData.phoneContacts) do
						local cNumber = k - ((pRenderData.phoneContactsPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneContactsPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneContactsPage - 1))) - 1)
								local cName = v.name
								if(string.len(cName) > 12) then
									cName = string.sub(cName, 0, 12).."..."
								end
								dxDrawText(cName, 5, contactHeight, 95, contactHeight + 20, tocolor(255, 255, 255, 200), 1.0, "default-bold", "left", "top", true, false, false, false, true, 0, 0, 0)
								dxDrawText(convertNumber(v.number), 10, contactHeight + 14, 0, 0, tocolor(255, 255, 255, 170), 0.9, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
								local alpha = 150
								if(isCursorGet(pRenderData.displayToMath.X + 100, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 25)) then
									alpha = 220
								end
								dxDrawImage(100, contactHeight + 5, 20, 20, "items/client/phone/files/contact-call.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
								local alpha = 150
								if(isCursorGet(pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 25)) then
									alpha = 220
								end
								dxDrawImage(120, contactHeight + 5, 20, 20, "items/client/phone/files/contact-message.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
								local alpha = 150
								if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + contactHeight + 25)) then
									alpha = 220
								end
								dxDrawImage(140, contactHeight + 5, 20, 20, "items/client/phone/files/contact-edit.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
							end
						end
					end
				end

			elseif(pRenderData.displayState2 == "hiding") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local alpha, progress2 = interpolateBetween(255, 1, 0, 0, 0, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/contacts-bg.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				-- Linia
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)

				if(progress < 1) then
					-- KONTAKY wyświetlanie --
					--dxDrawText("KONTAKTY", 10, 15, 167, 0, tocolor(255, 255, 255, 200 - (200 * progress)), 0.3, pRenderData.font.adventProRegular, "left", "top", false, false, false, false, true, 0, 0, 0)
					dxDrawImage(140, 35, 20, 20, "items/client/phone/files/contact-add.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
					if(#pRenderData.phoneContacts <= 0) then
						dxDrawText("Brak kontaktów", 0, 70, 167, 0, tocolor(255, 255, 255, 200 * progress2), 0.4, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
					else
						
						for k, v in ipairs(pRenderData.phoneContacts) do
							local cNumber = k - ((pRenderData.phoneContactsPage - 1) * 8)
							if(cNumber <= 8) then
								if(k > 8 * (pRenderData.phoneContactsPage - 1)) then
									local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneContactsPage - 1))) - 1)
									local cName = v.name
									if(string.len(cName) > 12) then
										cName = string.sub(cName, 0, 12).."..."
									end
									dxDrawText(cName, 5, contactHeight, 95, contactHeight + 20, tocolor(255, 255, 255, 200 * progress2), 1.0, "default-bold", "left", "top", true, false, false, false, true, 0, 0, 0)
									dxDrawText(convertNumber(v.number), 10, contactHeight + 14, 0, 0, tocolor(255, 255, 255, 170 * progress2), 0.9, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
									dxDrawImage(100, contactHeight + 5, 20, 20, "items/client/phone/files/contact-call.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
									dxDrawImage(120, contactHeight + 5, 20, 20, "items/client/phone/files/contact-message.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
									dxDrawImage(140, contactHeight + 5, 20, 20, "items/client/phone/files/contact-edit.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progress2))
								end
							end
						end
					end	
				end
			end
		------------------------
		-- DODAWANIE KONTAKTU --
		------------------------
		elseif(pRenderData.displayState == "addcontact") then
			if(pRenderData.displayState2 == "starting") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState2 = "showing"
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-bg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-add.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-nameedit.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-numberedit.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))

				local number = table.concat(pRenderData.contactAddNumber)
				if(tonumber(number)) then if(string.len(number) >= 6) then number = tostring(convertNumber(number)) end end
				dxDrawText(number, pRenderData.contactAddEdit2.X + 10, pRenderData.contactAddEdit2.Y, pRenderData.contactAddEdit2.W, pRenderData.contactAddEdit2.H, tocolor(255, 255, 255, 200 * progressVar), 1.0, "default-bold", "left", "center", true, false, false, false, false, 0, 0, 0)
				local name = table.concat(pRenderData.contactAddName)
				dxDrawText(name, pRenderData.contactAddEdit1.X + 10, pRenderData.contactAddEdit1.Y, pRenderData.contactAddEdit1.W, pRenderData.contactAddEdit1.H, tocolor(255, 255, 255, 200 * progressVar), 1.0, "default-bold", "left", "center", true, false, false, false, false, 0, 0, 0)

				-- Linia 
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
			-----------------------
			-- DOBRE POKAZYWANIE --
			-----------------------
			elseif(pRenderData.displayState2 == "showing") then
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-bg.png", 0, 0, 0, tocolor(255, 255, 255, 255))
				local alpha = 150 if(isCursorGet(pRenderData.iconAnswer.X, pRenderData.iconAnswer.Y, pRenderData.iconAnswer.W, pRenderData.iconAnswer.H)) then alpha = 220 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-add.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 150 if(pRenderData.contactAddEditbox == 1) then alpha = 255 elseif(isCursorGet(pRenderData.displayToMath.X + pRenderData.contactAddEdit1.X, pRenderData.displayToMath.Y + pRenderData.contactAddEdit1.Y, pRenderData.displayToMath.X + pRenderData.contactAddEdit1.W, pRenderData.displayToMath.Y + pRenderData.contactAddEdit1.H)) then alpha = 220 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-nameedit.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				local alpha = 150 if(pRenderData.contactAddEditbox == 2) then alpha = 255 elseif(isCursorGet(pRenderData.displayToMath.X + pRenderData.contactAddEdit2.X, pRenderData.displayToMath.Y + pRenderData.contactAddEdit2.Y, pRenderData.displayToMath.X + pRenderData.contactAddEdit2.W, pRenderData.displayToMath.Y + pRenderData.contactAddEdit2.H)) then alpha = 220 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-numberedit.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				
				local number = table.concat(pRenderData.contactAddNumber)
				if(tonumber(number)) then if(string.len(number) >= 6) then number = tostring(convertNumber(number)) end end
				dxDrawText(number, pRenderData.contactAddEdit2.X + 10, pRenderData.contactAddEdit2.Y, pRenderData.contactAddEdit2.W, pRenderData.contactAddEdit2.H, tocolor(255, 255, 255, 200), 1.0, "default-bold", "left", "center", true, false, false, false, false, 0, 0, 0)
				local name = table.concat(pRenderData.contactAddName)
				dxDrawText(name, pRenderData.contactAddEdit1.X + 10, pRenderData.contactAddEdit1.Y, pRenderData.contactAddEdit1.W, pRenderData.contactAddEdit1.H, tocolor(255, 255, 255, 200), 1.0, "default-bold", "left", "center", true, false, false, false, false, 0, 0, 0)

				-- Linia 
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
			elseif(pRenderData.displayState2 == "hiding") then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-bg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-add.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-nameedit.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/addcontact-numberedit.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))

				local number = table.concat(pRenderData.contactAddNumber)
				if(tonumber(number)) then if(string.len(number) >= 6) then number = tostring(convertNumber(number)) end end
				dxDrawText(number, pRenderData.contactAddEdit2.X + 10, pRenderData.contactAddEdit2.Y, pRenderData.contactAddEdit2.W, pRenderData.contactAddEdit2.H, tocolor(255, 255, 255, 200 * progressVar), 1.0, "default-bold", "left", "center", true, false, false, false, false, 0, 0, 0)
				local name = table.concat(pRenderData.contactAddName)
				dxDrawText(name, pRenderData.contactAddEdit1.X + 10, pRenderData.contactAddEdit1.Y, pRenderData.contactAddEdit1.W, pRenderData.contactAddEdit1.H, tocolor(255, 255, 255, 200 * progressVar), 1.0, "default-bold", "left", "center", true, false, false, false, false, 0, 0, 0)

				-- Linia
				dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
				local fullTime = getRealTime()
				local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
				dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
			end
		----------	
		-- SMSy --
		----------
		elseif pRenderData.displayState == "messages-list" then
			if pRenderData.displayState2 == "starting" then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
				if progress > 1 then
					pRenderData.displayState2 = "showing"
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-list.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(140, 35, 20, 20, "items/client/phone/files/messages-composeicon.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
				if #pRenderData.phoneMessages <= 0 then
					dxDrawText("Brak wiadomości", 0, 62, 167, 0, tocolor(255, 255, 255, 200 * progressVar), 0.3, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
				else
					for k, v in ipairs(pRenderData.phoneMessages) do
						local cNumber = k - ((pRenderData.phoneMessagesPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneMessagesPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneMessagesPage - 1))) - 1)
								--local cName = v.
								--if(string.len(cName) > 12) then
								--	cName = string.sub(cName, 0, 12).."..."
								--end
								local cName = v.number
								if(pRenderData.phoneContactsIndex[tostring(cName)]) then
									cName = pRenderData.phoneContactsIndex[tostring(cName)]
								else
									if(tonumber(cName)) then
										cName = convertNumber(tonumber(cName))
									else
										cName = "Nieznany"
									end
								end
								if(string.len(cName) > 12) then
									cName = string.sub(cName, 0, 12).."..."
								end
								local time = getRealTime(v.timestamp)
								dxDrawText(cName, 5, contactHeight, 95, contactHeight + 20, v.readmess == 1 and tocolor(255, 255, 255, 200 * progressVar) or tocolor(41, 110, 40, 200 * progressVar), 1.0, "default-bold", "left", "top", true, false, false, false, true, 0, 0, 0)
								dxDrawText(string.format("%0.2d.%0.2d, %0.2d:%0.2d", time.monthday, time.month + 1, time.hour, time.minute), 10, contactHeight + 14, 0, 0, tocolor(255, 255, 255, 170 * progressVar), 0.9, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
								dxDrawImage(100, contactHeight + 5, 20, 20, "items/client/phone/files/messages-previewicon.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
								dxDrawImage(120, contactHeight + 5, 20, 20, "items/client/phone/files/contact-message.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
								dxDrawImage(140, contactHeight + 5, 20, 20, "items/client/phone/files/messages-removeicon.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
							end
						end
					end
				end
			elseif pRenderData.displayState2 == "showing" then
				-- TUTAJ --
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-list.png", 0, 0, 0,tocolor(255, 255, 255, 255))
				local alpha = 150
				if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + 35, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + 35 + 20)) then
					alpha = 220
				end
				dxDrawImage(140, 35, 20, 20, "items/client/phone/files/messages-composeicon.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				if #pRenderData.phoneMessages <= 0 then
					dxDrawText("Brak wiadomości", 0, 62, 167, 0, tocolor(255, 255, 255, 200), 0.3, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
				else
					for k, v in ipairs(pRenderData.phoneMessages) do
						local cNumber = k - ((pRenderData.phoneMessagesPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneMessagesPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneMessagesPage - 1))) - 1)
								--local cName = v.
								--if(string.len(cName) > 12) then
								--	cName = string.sub(cName, 0, 12).."..."
								--end
								local cName = v.number
								if(pRenderData.phoneContactsIndex[tostring(cName)]) then
									cName = pRenderData.phoneContactsIndex[tostring(cName)]
								else
									if(tonumber(cName)) then
										cName = convertNumber(tonumber(cName))
									else
										cName = "Nieznany"
									end
								end
								if(string.len(cName) > 12) then
									cName = string.sub(cName, 0, 12).."..."
								end
								local time = getRealTime(v.timestamp)
								dxDrawText(cName, 5, contactHeight, 95, contactHeight + 20, v.readmess == 1 and tocolor(255, 255, 255, 200) or tocolor(41, 110, 40, 200), 1.0, "default-bold", "left", "top", true, false, false, false, true, 0, 0, 0)
								dxDrawText(string.format("%0.2d.%0.2d, %0.2d:%0.2d", time.monthday, time.month + 1, time.hour, time.minute), 10, contactHeight + 14, 0, 0, tocolor(255, 255, 255, 170), 0.9, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
								local alpha = 150
								if(isCursorGet(pRenderData.displayToMath.X + 100, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 25)) then
									alpha = 220
								end
								dxDrawImage(100, contactHeight + 5, 20, 20, "items/client/phone/files/messages-previewicon.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
								local alpha = 150
								if(isCursorGet(pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 25)) then
									alpha = 220
								end
								dxDrawImage(120, contactHeight + 5, 20, 20, "items/client/phone/files/contact-message.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
								local alpha = 150
								if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + contactHeight + 25)) then
									alpha = 220
								end
								dxDrawImage(140, contactHeight + 5, 20, 20, "items/client/phone/files/messages-removeicon.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
							end
						end
					end
				end
			elseif pRenderData.displayState2 == "hiding" then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-list.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(140, 35, 20, 20, "items/client/phone/files/messages-composeicon.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
				if #pRenderData.phoneMessages <= 0 then
					dxDrawText("Brak wiadomości", 0, 62, 167, 0, tocolor(255, 255, 255, 200 * progressVar), 0.3, pRenderData.font.adventProRegular, "center", "top", false, false, false, false, true, 0, 0, 0)
				else
					for k, v in ipairs(pRenderData.phoneMessages) do
						local cNumber = k - ((pRenderData.phoneMessagesPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneMessagesPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneMessagesPage - 1))) - 1)
								--local cName = v.
								local cName = v.number
								if(pRenderData.phoneContactsIndex[tostring(cName)]) then
									cName = pRenderData.phoneContactsIndex[tostring(cName)]
								else
									if(tonumber(cName)) then
										cName = convertNumber(tonumber(cName))
									else
										cName = "Nieznany"
									end
								end
								if(string.len(cName) > 12) then
									cName = string.sub(cName, 0, 12).."..."
								end
								local time = getRealTime(v.timestamp)
								dxDrawText(cName, 5, contactHeight, 95, contactHeight + 20, v.readmess == 1 and tocolor(255, 255, 255, 200 * progressVar) or tocolor(41, 110, 40, 200 * progressVar), 1.0, "default-bold", "left", "top", true, false, false, false, true, 0, 0, 0)
								dxDrawText(string.format("%0.2d.%0.2d, %0.2d:%0.2d", time.monthday, time.month + 1, time.hour, time.minute), 10, contactHeight + 14, 0, 0, tocolor(255, 255, 255, 170 * progressVar), 0.9, "default-bold", "left", "top", false, false, false, false, true, 0, 0, 0)
								dxDrawImage(100, contactHeight + 5, 20, 20, "items/client/phone/files/messages-previewicon.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
								dxDrawImage(120, contactHeight + 5, 20, 20, "items/client/phone/files/contact-message.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
								dxDrawImage(140, contactHeight + 5, 20, 20, "items/client/phone/files/messages-removeicon.png", 0, 0, 0, tocolor(255, 255, 255, 150 * progressVar))
							end
						end
					end
				end
			end
			-- LINIA --
		 	dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
			local fullTime = getRealTime()
			local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
			dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
		elseif pRenderData.displayState == "messages-compose" then
			if pRenderData.displayState2 == "starting" then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
				if progress > 1 then
					pRenderData.displayState2 = "showing"
				end
				local number = table.concat(pRenderData.phoneMessagesComposeNumber, "")
				if tonumber(number) then
					number = convertNumber(number)
				else
					number = tostring(number)
				end
				local text = table.concat(pRenderData.phoneMessagesComposeText, "")
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-newmessagebg.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-newmessagenumber.png", 0, 0, 0,tocolor(255, 255, 255, 150 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-sendmessage.png", 0, 0, 0,tocolor(255, 255, 255, 150 * progressVar))
				dxDrawText(number, 15, 33, 155, 58, tocolor(220, 220, 220, 180 * progressVar), 1.0, "default-bold", "left", "center")
				dxDrawText(text, 15, 75, 150, 270, tocolor(220, 220, 220, 220 * progressVar), 0.95, "default-bold", "left", "top", true, true)
			elseif pRenderData.displayState2 == "showing" then
			-- TUTAJ --
				local number = table.concat(pRenderData.phoneMessagesComposeNumber, "")
				if tonumber(number) then
					number = convertNumber(number)
				else
					number = tostring(number)
				end
				local text = table.concat(pRenderData.phoneMessagesComposeText, "")
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-newmessagebg.png", 0, 0, 0,tocolor(255, 255, 255, 255))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-newmessagenumber.png", 0, 0, 0,tocolor(255, 255, 255, pRenderData.phoneMessagesComposeEditBox == 1 and 255 or 150))
				local alpha = 150 if(isCursorGet(pRenderData.iconAnswer.X, pRenderData.iconAnswer.Y, pRenderData.iconAnswer.W, pRenderData.iconAnswer.H)) then alpha = 255 end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-sendmessage.png", 0, 0, 0,tocolor(255, 255, 255, alpha))
				dxDrawText(number, 15, 33, 155, 58, tocolor(220, 220, 220, 180), 1.0, "default-bold", "left", "center")
				dxDrawText(text, 15, 75, 150, 270, tocolor(220, 220, 220, 220), 0.95, "default-bold", "left", "top", true, true)
			elseif pRenderData.displayState2 == "hiding" then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()

					pRenderData.phoneMessagesComposeNumber = {}
					pRenderData.phoneMessagesComposeText = {}
					phoneMessagesComposeEditBox = 1
				end
				local number = table.concat(pRenderData.phoneMessagesComposeNumber, "")
				if tonumber(number) then
					number = convertNumber(number)
				else
					number = tostring(number)
				end
				local text = table.concat(pRenderData.phoneMessagesComposeText, "")
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-newmessagebg.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-newmessagenumber.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-sendmessage.png", 0, 0, 0,tocolor(255, 255, 255, 150 * progressVar))
				dxDrawText(number, 15, 33, 155, 58, tocolor(220, 220, 220, 180 * progressVar), 1.0, "default-bold", "left", "center")
				dxDrawText(text, 15, 75, 150, 270, tocolor(220, 220, 220, 220 * progressVar), 0.95, "default-bold", "left", "top", true, true)
			end

			-- LINIA --
		 	dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
			local fullTime = getRealTime()
			local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
			dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
		elseif pRenderData.displayState == "messages-read" then
			if pRenderData.displayState2 == "starting" then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
				if progress > 1 then
					pRenderData.displayState2 = "showing"
					local messageInfo = pRenderData.phoneMessages[pRenderData.readMessageIndex]
					if messageInfo then
						triggerServerEvent("phoneFunction.readMessage", localPlayer, localPlayer, messageInfo.ID)
						messageInfo.readmess = 1
					end
				end
				local messageInfo = pRenderData.phoneMessages[pRenderData.readMessageIndex]
				local cName = ""
				local content = ""
				if type(messageInfo) == "table" then
					cName = messageInfo.number
					if(pRenderData.phoneContactsIndex[tostring(cName)]) then
						cName = pRenderData.phoneContactsIndex[tostring(cName)]
					else
						if(tonumber(cName)) then
							cName = convertNumber(tonumber(cName))
						else
							cName = "Nieznany"
						end
					end
					content = messageInfo.content
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-readmessagebg.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawText(cName, 10, 20, 0, 38, tocolor(220, 220, 220, 200 * progressVar), 1.0, "default-bold", "left", "center")
				dxDrawText(content, 15, 55, 157, 302, tocolor(220, 220, 220, 230 * progressVar), 1.0, "default-bold", "left", "top", true, true)
			elseif pRenderData.displayState2 == "showing" then
				local messageInfo = pRenderData.phoneMessages[pRenderData.readMessageIndex]
				local cName = ""
				local content = ""
				if type(messageInfo) == "table" then
					cName = messageInfo.number
					if(pRenderData.phoneContactsIndex[tostring(cName)]) then
						cName = pRenderData.phoneContactsIndex[tostring(cName)]
					else
						if(tonumber(cName)) then
							cName = convertNumber(tonumber(cName))
						else
							cName = "Nieznany"
						end
					end
					content = messageInfo.content
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-readmessagebg.png", 0, 0, 0,tocolor(255, 255, 255, 255))
				dxDrawText(cName, 10, 20, 0, 38, tocolor(220, 220, 220, 200), 1.0, "default-bold", "left", "center")
				dxDrawText(content, 15, 55, 157, 302, tocolor(220, 220, 220, 230), 1.0, "default-bold", "left", "top", true, true)
			elseif pRenderData.displayState2 == "hiding" then
				local progress = (getTickCount() - pRenderData.displayStateTime) / pRenderData.animLockTime
				local progressVar = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
				if(progress > 1) then
					pRenderData.displayState = pRenderData.nextDisplayState
					pRenderData.displayState2 = pRenderData.nextDisplayState2
					pRenderData.displayStateTime = getTickCount()

					pRenderData.readMessageIndex = 0
				end
				local messageInfo = pRenderData.phoneMessages[pRenderData.readMessageIndex]
				local cName = ""
				local content = ""
				if type(messageInfo) == "table" then
					cName = messageInfo.number
					if(pRenderData.phoneContactsIndex[tostring(cName)]) then
						cName = pRenderData.phoneContactsIndex[tostring(cName)]
					else
						if(tonumber(cName)) then
							cName = convertNumber(tonumber(cName))
						else
							cName = "Nieznany"
						end
					end
					content = messageInfo.content
				end
				dxDrawImage(0, 0, 167, 314, "items/client/phone/files/messages-readmessagebg.png", 0, 0, 0,tocolor(255, 255, 255, 255 * progressVar))
				dxDrawText(cName, 10, 20, 0, 38, tocolor(220, 220, 220, 200 * progressVar), 1.0, "default-bold", "left", "center")
				dxDrawText(content, 15, 55, 157, 302, tocolor(220, 220, 220, 230 * progressVar), 1.0, "default-bold", "left", "top", true, true)
			end
			-- LINIA --
		 	dxDrawImage(0, 0, 167, 13, "items/client/phone/files/line.png")
			local fullTime = getRealTime()
			local time = string.format("%0.2d:%0.2d", fullTime.hour, fullTime.minute)
			dxDrawText(time, 0, 1, 167, 1, tocolor(255, 255, 255, 200), 0.7, "default-bold", "center", "top", false, false, false, false, true, 0, 0, 0)
		end
	--
	--dxDrawRectangle(pRenderData.testPos[1], pRenderData.testPos[2], pRenderData.testPos[3], pRenderData.testPos[4])
	dxSetRenderTarget()

	------------
	-- RENDER --
	------------
	dxDrawImage(pRenderData.bg.X, pRenderData.bg.Y + addHeight, pRenderData.bg.W, pRenderData.bg.H, "items/client/phone/files/phone.png")
	dxDrawImage(pRenderData.bg.X + 28, pRenderData.bg.Y + addHeight + 45, 167, 314, pRenderData.display)
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------- MOUSE ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function clickPhone(button, state, cX, cY)
	if(state == "up") then
		-----------
		-- EKRAN --
		-----------
		if(isCursorGet(pRenderData.bg.X + 28, pRenderData.bg.Y + 45, pRenderData.bg.X + 28 + 167, pRenderData.bg.Y + 45 + 314)) then
			-------------------------
			-- ODBLOKOWANIE EKRANU --
			-------------------------
			if(pRenderData.displayState == "locked" and pRenderData.displayState2 ~= "hiding") then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"	
			elseif(pRenderData.displayState == "callReceive") then
				-------------
				-- ODBIERA --
				-------------
				if(isCursorGet(pRenderData.callA.X, pRenderData.callA.Y, pRenderData.callA.W, pRenderData.callA.H)) then
					triggerServerEvent("phoneFunction.acceptCall", localPlayer, localPlayer)
				-------------
				-- ODRZUCA --
				-------------
				elseif(isCursorGet(pRenderData.callD.X, pRenderData.callD.Y, pRenderData.callD.W, pRenderData.callD.H)) then
					triggerServerEvent("phoneFunction.declineCall", localPlayer, localPlayer)
					turnPhoneOff()
					return
				end
			---------------------
			-- KLIKANIE W MENU --
			---------------------
			elseif(pRenderData.displayState == "mainMenu" and pRenderData.displayState2 == "menuShowed") then
				local selected = pRenderData.menuSelect
				if(tonumber(selected) and selected > 0) then
					if(selected == 1) then
						pRenderData.displayStateTime = getTickCount()
						pRenderData.displayState2 = "menuHiding"

						pRenderData.nextDisplayState = "contacts"
						pRenderData.nextDisplayState2 = "starting"
					elseif(selected == 2) then
						pRenderData.displayStateTime = getTickCount()
						pRenderData.displayState2 = "menuHiding"

						pRenderData.nextDisplayState = "callMenu"
						pRenderData.nextDisplayState2 = "starting"
						pRenderData.numberTable = {}
					elseif selected == 5 then
						pRenderData.displayStateTime = getTickCount()
						pRenderData.displayState2 = "menuHiding"

						pRenderData.nextDisplayState = "messages-list"
						pRenderData.nextDisplayState2 = "starting"
					end
				end
			---------------------
			-- MENU DZWONIENIA --
			---------------------
			elseif(pRenderData.displayState == "callMenu" and pRenderData.displayState2 == "showing") then
				if(isCursorGet(pRenderData.iconAnswer.X, pRenderData.iconAnswer.Y, pRenderData.iconAnswer.W, pRenderData.iconAnswer.H)) then
					phoneEvent.callStart()
					return
				end
			----------------
			-- GDY DZWONI --
			----------------
			elseif(pRenderData.displayState == "call") then
				if(isCursorGet(pRenderData.callD.X, pRenderData.callD.Y, pRenderData.callD.W, pRenderData.callD.H)) then
					if(pRenderData.displayState2 == "phoning") then
						triggerServerEvent("phoneFunction.cancelCall", localPlayer, localPlayer)
						pRenderData.errorCall = 1
						pRenderData.displayState = "call"
						pRenderData.displayState2 = "error"
						pRenderData.displayStateTime = getTickCount()
					elseif(pRenderData.displayState2 == "talk") then
						triggerServerEvent("phoneFunction.endCall", localPlayer, localPlayer)
						pRenderData.errorCall = 1
						pRenderData.displayState = "call"
						pRenderData.displayState2 = "error"
						pRenderData.displayStateTime = getTickCount()
					end
				end

			-- DODAWANIE KONTAKTU --
			elseif(pRenderData.displayState == "addcontact" and pRenderData.displayState2 == "showing") then
				if(isCursorGet(pRenderData.displayToMath.X + pRenderData.contactAddEdit1.X, pRenderData.displayToMath.Y + pRenderData.contactAddEdit1.Y, pRenderData.displayToMath.X + pRenderData.contactAddEdit1.W, pRenderData.displayToMath.Y + pRenderData.contactAddEdit1.H)) then pRenderData.contactAddEditbox = 1 return end
				if(isCursorGet(pRenderData.displayToMath.X + pRenderData.contactAddEdit2.X, pRenderData.displayToMath.Y + pRenderData.contactAddEdit2.Y, pRenderData.displayToMath.X + pRenderData.contactAddEdit2.W, pRenderData.displayToMath.Y + pRenderData.contactAddEdit2.H))then pRenderData.contactAddEditbox = 2 return end
			
				-- DODAJ NOWY KONTAKT
				if(not pRenderData.contactAddToggle and isCursorGet(pRenderData.iconAnswer.X, pRenderData.iconAnswer.Y, pRenderData.iconAnswer.W, pRenderData.iconAnswer.H)) then
					if(#pRenderData.contactAddName < 4) then
						exports.titan_noti:showBox("Nazwa kontaktu musi mieć przynajmniej 4 znaki.")
						return
					end
					if(#pRenderData.contactAddNumber < 3) then
						exports.titan_noti:showBox("Numer telefonu musi mieć przynajmniej 3 znaki.")
						return
					end

					local tempNumber = table.concat(pRenderData.contactAddNumber)
					tempNumber = tonumber(tempNumber)
					-- CZY MASZ JUŻ GOŚCIU DANY NUMER ZAPISANY
					for k, v in ipairs(pRenderData.phoneContacts) do
						if(tonumber(v.number) == tempNumber) then
							exports.titan_noti:showBox("W Twojej książce adresowej widnieje już ktoś z takim numerem.")
							return
						end
					end
					pRenderData.contactAddToggle = true
					triggerServerEvent("phoneFunction.saveNewContact", localPlayer, localPlayer, tempNumber, table.concat(pRenderData.contactAddName))
				end

			--------------
			-- KONTAKTY --
			--------------
			elseif(pRenderData.displayState == "contacts" and pRenderData.displayState2 == "showing") then
				if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + 35, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + 35 + 20)) then
					pRenderData.displayState = "contacts"
					pRenderData.displayState2 = "hiding"
					pRenderData.nextDisplayState = "addcontact"
					pRenderData.nextDisplayState2 = "starting"
					pRenderData.displayStateTime = getTickCount()

					pRenderData.contactAddNumber = {}
					pRenderData.contactAddName = {}
					return
				end
				if(type(pRenderData.phoneContacts) == "table" and #pRenderData.phoneContacts > 0) then
					for k, v in ipairs(pRenderData.phoneContacts) do
						local cNumber = k - ((pRenderData.phoneContactsPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneContactsPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneContactsPage - 1))) - 1)
								if(isCursorGet(pRenderData.displayToMath.X + 100, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 25)) then
									pRenderData.numberTable = {}
									for i = 1, string.len(v.number) do
										local char = string.sub(v.number, i, i)
										if(tonumber(char)) then
											table.insert(pRenderData.numberTable, tonumber(char))
										end
									end
									phoneEvent.callStart()
									return
								end
								if(isCursorGet(pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 25)) then
									pRenderData.phoneMessagesComposeNumber = {}
									for i = 1, string.len(v.number) do
										local char = string.sub(v.number, i, i)
										if tonumber(char) then
											table.insert(pRenderData.phoneMessagesComposeNumber, tonumber(char))
										end
									end
									pRenderData.displayState = "contacts"
									pRenderData.displayState2 = "hiding"
									pRenderData.nextDisplayState = "messages-compose"
									pRenderData.nextDisplayState2 = "starting"
									pRenderData.displayStateTime = getTickCount()
									return
								end
								if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + contactHeight + 25)) then
									if tonumber(v.ID) then
										return triggerServerEvent("phoneFunction.deleteContact", localPlayer, v.ID)
									else
										return exports.titan_noti:showBox("Tego kontaktu nie możesz usunać.")
									end
									--exports.titan_noti:showBox("KLIK")
								end
							end
						end
					end
				end
			----------
			-- SMSy --
			----------
			elseif pRenderData.displayState == "messages-list" and pRenderData.displayState2 == "showing" then
				if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + 35, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + 35 + 20)) then
					pRenderData.displayState = "messages-list"
					pRenderData.displayState2 = "hiding"
					pRenderData.nextDisplayState = "messages-compose"
					pRenderData.nextDisplayState2 = "starting"
					pRenderData.displayStateTime = getTickCount()

					pRenderData.contactAddNumber = {}
					pRenderData.contactAddName = {}
					return
				end
				if(type(pRenderData.phoneMessages) == "table" and #pRenderData.phoneMessages > 0) then
					for k, v in ipairs(pRenderData.phoneMessages) do
						local cNumber = k - ((pRenderData.phoneMessagesPage - 1) * 8)
						if(cNumber <= 8) then
							if(k > 8 * (pRenderData.phoneMessagesPage - 1)) then
								local contactHeight = 58 + 30 * ((k - (8 * (pRenderData.phoneMessagesPage - 1))) - 1)
								if(isCursorGet(pRenderData.displayToMath.X + 100, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 25)) then
									pRenderData.displayState2 = "hiding"
									pRenderData.nextDisplayState = "messages-read"
									pRenderData.nextDisplayState2 = "starting"
									pRenderData.displayStateTime = getTickCount()
									pRenderData.readMessageIndex = k
									return
								end
								if(isCursorGet(pRenderData.displayToMath.X + 120, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 25)) then
									pRenderData.phoneMessagesComposeNumber = {}
									for i = 1, string.len(v.number) do
										local char = string.sub(v.number, i, i)
										if tonumber(char) then
											table.insert(pRenderData.phoneMessagesComposeNumber, tonumber(char))
										end
									end
									pRenderData.displayState2 = "hiding"
									pRenderData.nextDisplayState = "messages-compose"
									pRenderData.nextDisplayState2 = "starting"
									pRenderData.displayStateTime = getTickCount()
									return
								end
								if(isCursorGet(pRenderData.displayToMath.X + 140, pRenderData.displayToMath.Y + contactHeight + 5, pRenderData.displayToMath.X + 160, pRenderData.displayToMath.Y + contactHeight + 25)) then
									if not pRenderData.phoneMessagesToggle then
										pRenderData.phoneMessagesToggle = true
										triggerServerEvent("phoneFunction.deleteMessage", localPlayer, localPlayer, v.ID)
										return
									end
									return
								end
							end
						end
					end
				end
			elseif pRenderData.displayState == "messages-compose" and pRenderData.displayState2 == "showing" then
				if isCursorGet(pRenderData.displayToMath.X + 10, pRenderData.displayToMath.Y + 33, pRenderData.displayToMath.X + 155, pRenderData.displayToMath.Y + 58) then
					pRenderData.phoneMessagesComposeEditBox = 1
				end
				if isCursorGet(pRenderData.displayToMath.X + 10, pRenderData.displayToMath.Y + 68, pRenderData.displayToMath.X + 155, pRenderData.displayToMath.Y + 268) then
					pRenderData.phoneMessagesComposeEditBox = 2
				end
				if(not pRenderData.phoneMessagesSendToggle and isCursorGet(pRenderData.iconAnswer.X, pRenderData.iconAnswer.Y, pRenderData.iconAnswer.W, pRenderData.iconAnswer.H)) then
					if tonumber(pRenderData.phoneMessagesComposeNumber) == 911 then return exports.titan_noti:showBox("Numer alarmowy nie przyjmuje zgłoszeń tekstowych.") end
					if tonumber(pRenderData.phoneMessagesComposeNumber) == 4444 then return exports.titan_noti:showBox("Prasa nie przyjmuje zgłoszeń tekstowych.") end
					if #pRenderData.phoneMessagesComposeNumber < 4 then return exports.titan_noti:showBox("Numer telefonu musi składać się z przynajmniej 4 cyfr.") end
					if #pRenderData.phoneMessagesComposeText < 1 then return exports.titan_noti:showBox("Treść wiadomości nie może być pusta.") end

					local number = table.concat(pRenderData.phoneMessagesComposeNumber, "")
					if not tonumber(number) then return exports.titan_noti:showBox("Numer telefonu jest nieprawidłowy.") end
					number = tonumber(number)

					local text = table.concat(pRenderData.phoneMessagesComposeText, "")
					text = tostring(text)
					triggerServerEvent("phoneFunction.sendSMS", localPlayer, localPlayer, number, text)
				end
			end
		end

		--------------
		-- "WSTECZ" --
		--------------
		if(isCursorGet(pRenderData.bg.X + 30, pRenderData.bg.Y + pRenderData.bg.H - 65, pRenderData.bg.X + 60, pRenderData.bg.Y + pRenderData.bg.H - 35)) then
			if((pRenderData.displayState == "locked" and pRenderData.displayState2 ~= "hiding") or (pRenderData.displayState == "mainMenu" and pRenderData.displayState2 == "menuShowed")) then
				turnPhoneOff()
				return
			elseif(pRenderData.displayState == "callMenu" and pRenderData.displayState2 == "showing") then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"

				pRenderData.nextDisplayState = "mainMenu"
				pRenderData.nextDisplayState2 = "showMenu2"
			elseif(pRenderData.displayState == "contacts" and pRenderData.displayState2 == "showing") then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"

				pRenderData.nextDisplayState = "mainMenu"
				pRenderData.nextDisplayState2 = "showMenu2"
			elseif(pRenderData.displayState == "addcontact" and pRenderData.displayState2 == "showing") then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"

				pRenderData.nextDisplayState = "contacts"
				pRenderData.nextDisplayState2 = "starting"
			elseif pRenderData.displayState == "messages-list" and pRenderData.displayState2 == "showing" then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"

				pRenderData.nextDisplayState = "mainMenu"
				pRenderData.nextDisplayState2 = "showMenu2"
			elseif pRenderData.displayState == "messages-compose" and pRenderData.displayState2 == "showing" then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"

				pRenderData.nextDisplayState = "messages-list"
				pRenderData.nextDisplayState2 = "starting"
			elseif pRenderData.displayState == "messages-read" and pRenderData.displayState2 == "showing" then
				pRenderData.displayStateTime = getTickCount()
				pRenderData.displayState2 = "hiding"

				pRenderData.nextDisplayState = "messages-list"
				pRenderData.nextDisplayState2 = "starting"
			end
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------- KEY -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function keyPhone(button, press)

	if(press) then
		------------
		-- KURSOR --
		------------
		if(button == "ralt" or button == "insert") then
			if(isCursorShowing()) then
				exports.titan_cursor:hideCustomCursor("itemsPhone")
			else
				exports.titan_cursor:showCustomCursor("itemsPhone")
				
			end
		end

		-----------------------
		-- WYBIERANIE NUMERU --
		-----------------------
		if(pRenderData.displayState == "callMenu" and pRenderData.displayState2 == "showing") then
			if(tonumber(button)) then
				button = tonumber(button)
				if(#pRenderData.numberTable >= 6) then return end
				table.insert(pRenderData.numberTable, button)
				return
			else
				if(button == "backspace") then
					if(#pRenderData.numberTable > 0) then
						table.remove(pRenderData.numberTable, #pRenderData.numberTable)
					end
					return
				end
				if(#pRenderData.numberTable >= 6) then return end
				for i = 0, 9 do
					if(button == "num_"..i) then
						button = i
						table.insert(pRenderData.numberTable, button)
						return
					end
				end
			end
		--------------
		-- KONTAKTY --
		--------------
		elseif(pRenderData.displayState == "contacts" and pRenderData.displayState2 == "showing") then
			if(button == "mouse_wheel_down") then
				local index = (pRenderData.phoneContactsPage) * 8
				if(type(pRenderData.phoneContacts[index]) == "table") then pRenderData.phoneContactsPage = pRenderData.phoneContactsPage + 1 end
			elseif(button == "mouse_wheel_up") then
				pRenderData.phoneContactsPage = pRenderData.phoneContactsPage - 1
				if(pRenderData.phoneContactsPage <= 0) then pRenderData.phoneContactsPage = 1 end
			end

		--------------------
		-- TWORZENIE SMSa --
		--------------------
		elseif pRenderData.displayState == "messages-compose" and pRenderData.displayState2 == "showing" then
			if button ~= "end" then cancelEvent() end
			if pRenderData.phoneMessagesComposeEditBox == 1 then
				if button == "backspace" then
					if #pRenderData.phoneMessagesComposeNumber > 0 then return table.remove(pRenderData.phoneMessagesComposeNumber, #pRenderData.phoneMessagesComposeNumber) end
				end
				local chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "num_1", "num_2", "num_3", "num_4", "num_5", "num_6", "num_7", "num_8", "num_9", "num_0"}
				if #pRenderData.phoneMessagesComposeNumber < 6 then
					for k, v in pairs(chars) do
						if button == v then
							if button == "num_0" then return table.insert(pRenderData.phoneMessagesComposeNumber, "0") 
							elseif button == "num_1" then return table.insert(pRenderData.phoneMessagesComposeNumber, "1") 
							elseif button == "num_2" then return table.insert(pRenderData.phoneMessagesComposeNumber, "2") 
							elseif button == "num_3" then return table.insert(pRenderData.phoneMessagesComposeNumber, "3") 
							elseif button == "num_4" then return table.insert(pRenderData.phoneMessagesComposeNumber, "4") 
							elseif button == "num_5" then return table.insert(pRenderData.phoneMessagesComposeNumber, "5") 
							elseif button == "num_6" then return table.insert(pRenderData.phoneMessagesComposeNumber, "6") 
							elseif button == "num_7" then return table.insert(pRenderData.phoneMessagesComposeNumber, "7") 
							elseif button == "num_8" then return table.insert(pRenderData.phoneMessagesComposeNumber, "8") 
							elseif button == "num_9" then return table.insert(pRenderData.phoneMessagesComposeNumber, "9")
							else return table.insert(pRenderData.phoneMessagesComposeNumber, tostring(button)) end 
							break
						end
					end
				end
			elseif pRenderData.phoneMessagesComposeEditBox == 2 then
				if button == "backspace" then
					if #pRenderData.phoneMessagesComposeText > 0 then return table.remove(pRenderData.phoneMessagesComposeText, #pRenderData.phoneMessagesComposeText) end
				end
				local chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", ".", ",", "-", "\\", "/", "[", "]", ";", "space"}
				if #pRenderData.phoneMessagesComposeText < 255 then
					for k, v in pairs(chars) do
						if button == v then
							local key = getKeyFromKeyboard(button)
							if key then
								table.insert(pRenderData.phoneMessagesComposeText, key)
							end
							break
						end
					end
				end
			end

		------------------------
		-- DODAWANIE KONTAKTU --
		------------------------
		elseif(pRenderData.displayState == "addcontact" and pRenderData.displayState2 == "showing") then
			if(button ~= "end") then cancelEvent() end
			if(pRenderData.contactAddEditbox == 1) then
				if(button == "backspace") then
					if(#pRenderData.contactAddName > 0) then
						table.remove(pRenderData.contactAddName, #pRenderData.contactAddName)
					end
					return
				end
				local chars = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", ".", ",", "-", "\\", "/", "[", "]", ";", "space"}
				if(#pRenderData.contactAddName < 20) then
					for k, v in pairs(chars) do
						if(button == v) then
							local key = getKeyFromKeyboard(button)
							table.insert(pRenderData.contactAddName, key)
							return
						end
					end
				end
			elseif(pRenderData.contactAddEditbox == 2) then
				if(tonumber(button)) then
					button = tonumber(button)
					if(#pRenderData.contactAddNumber >= 6) then return end
					table.insert(pRenderData.contactAddNumber, button)
					return
				else
					if(button == "backspace") then
						if(#pRenderData.contactAddNumber > 0) then
							table.remove(pRenderData.contactAddNumber, #pRenderData.contactAddNumber)
						end
						return
					end
					if(#pRenderData.contactAddNumber >= 6) then return end
					for i = 0, 9 do
						if(button == "num_"..i) then
							button = i
							table.insert(pRenderData.contactAddNumber, button)
							return
						end
					end
				end
			end
		end
	end

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
------------------------------------------
-- WYBIERANIE NUMERY PRZY POMOCY MYSZKI --
------------------------------------------
function onMouseClick(but, state, x, y)
	if but == "left" and state == "down" then
		if(pRenderData.displayState == "callMenu" and pRenderData.displayState2 == "showing") then
			if #pRenderData.numberTable < 6 then
				if isCursorGetRectangle(pRenderData.bg.X + 30, pRenderData.bg.Y + 150, 53, 43) then
					table.insert(pRenderData.numberTable, 1)
				elseif isCursorGetRectangle(pRenderData.bg.X + 84, pRenderData.bg.Y + 150, 53, 43) then
					table.insert(pRenderData.numberTable, 2)
				elseif isCursorGetRectangle(pRenderData.bg.X + 138, pRenderData.bg.Y + 150, 53, 43) then
					table.insert(pRenderData.numberTable, 3)
				elseif isCursorGetRectangle(pRenderData.bg.X + 30, pRenderData.bg.Y + 194, 53, 43) then
					table.insert(pRenderData.numberTable, 4)
				elseif isCursorGetRectangle(pRenderData.bg.X + 84, pRenderData.bg.Y + 194, 53, 43) then
					table.insert(pRenderData.numberTable, 5)
				elseif isCursorGetRectangle(pRenderData.bg.X + 138, pRenderData.bg.Y + 194, 53, 43) then
					table.insert(pRenderData.numberTable, 6)
				elseif isCursorGetRectangle(pRenderData.bg.X + 30, pRenderData.bg.Y + 238, 53, 43) then
					table.insert(pRenderData.numberTable, 7)
				elseif isCursorGetRectangle(pRenderData.bg.X + 84, pRenderData.bg.Y + 238, 53, 43) then
					table.insert(pRenderData.numberTable, 8)
				elseif isCursorGetRectangle(pRenderData.bg.X + 138, pRenderData.bg.Y + 238, 53, 43) then
					table.insert(pRenderData.numberTable, 9)
				elseif isCursorGetRectangle(pRenderData.bg.X + 84, pRenderData.bg.Y + 282, 53, 43) then
					table.insert(pRenderData.numberTable, 0)
				end
			end
			if #pRenderData.numberTable > 0 then
				if isCursorGetRectangle(pRenderData.bg.X + 165, pRenderData.bg.Y + 110, 25, 30) then
					table.remove(pRenderData.numberTable, #pRenderData.numberTable)
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, onMouseClick)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------- OTHER ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function onLeave()
	pRenderData.menuSelect = 0
end

function onEnter()
	local data = getElementData(source, "type")
	if(tonumber(data)) then pRenderData.menuSelect = tonumber(data) end
end

function removeRenderData()
	if(isElement(pRenderData.display)) then destroyElement(pRenderData.display) end
	if(type(pRenderData.font) == "table") then
		if(isElement(pRenderData.font.adventProRegular)) then destroyElement(pRenderData.font.adventProRegular) end
	end
	pRenderData = {}

	removeEventHandler("onClientMouseLeave", resourceRoot, onLeave)
	removeEventHandler("onClientMouseEnter", resourceRoot, onEnter)

	for k, v in ipairs(getElementChildren(getResourceGUIElement())) do
		if(isElement(v)) then
			if(getElementData(v, "labelType") == "phone") then
				destroyElement(v)
			end
		end
	end
	isAnim = false
end


function turnPhoneOff()
	pRenderData.displayState = "locked"
	pRenderData.displayState2 = "locked"
	pRenderData.displayStateTime = 0
	
	removeEventHandler("onClientClick", root, clickPhone)
	removeEventHandler("onClientKey", root, keyPhone)
	pRenderData.animTime = getTickCount()
	pRenderData.animState = "hiding"
	isAnim = true
	exports.titan_cursor:hideCustomCursor("itemsPhone")
	setElementData(localPlayer, "phoneState", false)
end

local function isCursorGet(minX, minY, maxX, maxY)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * sW, cY * sH
	if(cX > minX and cX < maxX and cY > minY and cY < maxY) then return true end
	return false
end

function startPhone()
	loadPhoneRenderData()
	pRenderData.animTime = getTickCount()
	pRenderData.animState = "starting"
	isAnim = true
	addEventHandler("onClientRender", root, renderPhone)
	addEventHandler("onClientClick", root, clickPhone)
	addEventHandler("onClientKey", root, keyPhone)
end

function getMiesiac(month)
	local miesiac = "BŁĄD"
	if(month == 0) then miesiac = "stycznia"
	elseif(month == 1) then miesiac = "lutego"
	elseif(month == 2) then miesiac = "marca"
	elseif(month == 3) then miesiac = "kwietnia"
	elseif(month == 4) then miesiac = "maja"
	elseif(month == 5) then miesiac = "czerwca"
	elseif(month == 6) then miesiac = "lipca"
	elseif(month == 7) then miesiac = "sierpnia"
	elseif(month == 8) then miesiac = "września"
	elseif(month == 9) then miesiac = "października"
	elseif(month == 10) then miesiac = "listopada"
	elseif(month == 11) then miesiac = "grudnia"
	end
	return miesiac
end

function getDay(weekday)
	local day = "BŁĄD"
	if(weekday == 0) then day = "niedziela"
	elseif(weekday == 1) then day = "poniedziałek"
	elseif(weekday == 2) then day = "wtorek"
	elseif(weekday == 3) then day = "środa"
	elseif(weekday == 4) then day = "czwartek"
	elseif(weekday == 5) then day = "piątek"
	elseif(weekday == 6) then day = "sobota"
	end
	return day
end

function getRingtone(ringID)
	local ringTones = {}
	ringTones[1] = {dir = "viber_original.mp3", desc = "Domyślny"}
	ringTones[2] = {dir = "skyfall.mp3", desc = "Adele - Skyfall"}
	ringTones[3] = {dir = "2_pac_1.mp3", desc = "2Pac - Jakiś Tytuł"}
	ringTones[4] = {dir = "angry_birds.mp3", desc = "Muzyka z Angry Birds"}
	
	if(type(ringTones[ringID]) == "table") then
		return ringTones[ringID]
	end
	return false
end

function convertNumber(number)  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(tostring(formatted), "^(-?%d+)(%d%d%d)", '%1 %2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function getKeyFromKeyboard(key)
	if(key == "space") then key = " " end
	if(getKeyState("ralt") and (not getKeyState("lshift") and not getKeyState("rshift"))) then
		if(key == "e") then key = "ę" end
		if(key == "o") then key = "ó" end
		if(key == "a") then key = "ą" end
		if(key == "s") then key = "ś" end
		if(key == "l") then key = "ł" end
		if(key == "z") then key = "ż" end
		if(key == "x") then key = "ź" end
		if(key == "c") then key = "ć" end
		if(key == "n") then key = "ń" end
	end

	if(getKeyState("lshift") or getKeyState("rshift")) then
		if(getKeyState("ralt")) then
			if(key == "e") then key = "Ę"
			elseif(key == "o") then key = "Ó"
			elseif(key == "a") then key = "Ą"
			elseif(key == "s") then key = "Ś"
			elseif(key == "l") then key = "Ł"
			elseif(key == "z") then key = "Ż"
			elseif(key == "x") then key = "Ź"
			elseif(key == "c") then key = "Ć"
			elseif(key == "n") then key = "Ń"
			else key = string.upper(key) end
		else
			if key == "1" then key = "!" end
			if key == "2" then key = "@" end
			if key == "3" then key = "#" end
			if key == "4" then key = "$" end
			if key == "5" then key = "%" end
			if key == "6" then key = "^" end
			if key == "7" then key = "&" end
			if key == "8" then key = "*" end
			if key == "9" then key = "(" end
			if key == "0" then key = ")" end
			if key == ";" then key = ":" end
			if key == "'" then key = "\"" end
			if key == "/" then key = "?" end
			if key == "," then key = "<" end
			if key == "." then key = ">" end
			key = string.upper(key)
		end
	end
	return key
end

------------
-- EVENTY --
------------

function phoneEvent.disableToggleSendMessage()
	pRenderData.phoneMessagesSendToggle = false
end
addEvent("phoneEvent.disableToggleSendMessage", true)
addEventHandler("phoneEvent.disableToggleSendMessage", root, phoneEvent.disableToggleSendMessage)

function phoneEvent.sendMessageAnim()
	pRenderData.displayStateTime = getTickCount()
	pRenderData.displayState = "messages-compose"
	pRenderData.displayState2 = "hiding"
	pRenderData.nextDisplayState = "messages-list"
	pRenderData.nextDisplayState2 = "starting"
end
addEvent("phoneEvent.sendMessageAnim", true)
addEventHandler("phoneEvent.sendMessageAnim", root, phoneEvent.sendMessageAnim)

function phoneEvent.ringOn(player, ringID)
	local ringInfo = getRingtone(ringID)
	if(not ringInfo) then return end
	if(isElement(playerRingtones[player])) then destroyElement(playerRingtones[player]) end

	local x, y, z = getElementPosition(player)
	playerRingtones[player] = playSound3D(string.format("items/client/phone/files/ringtones/%s", ringInfo.dir), x, y, z, true)
	attachElements(playerRingtones[player], player)
	setElementParent(playerRingtones[player], player)

	setElementInterior(playerRingtones[player], getElementInterior(player))
	setElementDimension(playerRingtones[player], getElementDimension(player))
end
addEvent("phoneEvent.ringOn", true)
addEventHandler("phoneEvent.ringOn", root, phoneEvent.ringOn)

function phoneEvent.ringOff(player)
	if(isElement(playerRingtones[player])) then destroyElement(playerRingtones[player]) end
end
addEvent("phoneEvent.ringOff", true)
addEventHandler("phoneEvent.ringOff", root, phoneEvent.ringOff)

function phoneEvent.ringPhone(number, contacts)
	if(not pRenderData.animState or pRenderData.animState == "none") then
		loadPhoneRenderData()
		startPhone()
		pRenderData.displayState = "callReceive"
		setElementData(localPlayer, "phoneState", true)
	else
		if(pRenderData.animState ~= "showing") then
			pRenderData.animTime = getTickCount()
			pRenderData.animState = "starting"
		end
		pRenderData.displayState = "callReceive"
	end
	pRenderData.callNumber = number
	if(type(contacts) == "table") then
		pRenderData.phoneContacts = contacts
		pRenderData.phoneContactsIndex = {}
		for k, v in ipairs(contacts) do
			pRenderData.phoneContactsIndex[tostring(v.number)] = v.name
		end
	else pRenderData.phoneContacts = {} end
end
addEvent("phoneEvent.ringPhone", true)
addEventHandler("phoneEvent.ringPhone", root, phoneEvent.ringPhone)

function phoneEvent.refreshContacts(contacts)
	pRenderData.contactAddToggle = false
	pRenderData.displayStateTime = getTickCount()
	pRenderData.displayState2 = "hiding"
	pRenderData.nextDisplayState = "contacts"
	pRenderData.nextDisplayState2 = "starting"
	
	pRenderData.phoneContacts = {}
	pRenderData.phoneContactsIndex = {}
	if(type(contacts) == "table") then
		pRenderData.phoneContacts = contacts
		for k, v in ipairs(contacts) do
			pRenderData.phoneContactsIndex[tostring(v.number)] = v.name
		end
	end
end
addEvent("phoneEvent.refreshContacts", true)
addEventHandler("phoneEvent.refreshContacts", root, phoneEvent.refreshContacts)

function phoneEvent.refreshMessages(messages)
	pRenderData.phoneMessages = {}
	if type(messages) == "table" then
		pRenderData.phoneMessages = messages
	end
	pRenderData.phoneMessagesToggle = false
end
addEvent("phoneEvent.refreshMessages", true)
addEventHandler("phoneEvent.refreshMessages", root, phoneEvent.refreshMessages)

function phoneEvent.turnOn(contacts, messages, playerNumber)
	if(isAnim) then return end
	if getElementData(localPlayer, "bwTime") then return end
	if(not pRenderData.animState or pRenderData.animState == "none") then
		loadPhoneRenderData()
		startPhone()
		pRenderData.displayState = "locked"
		pRenderData.displayState2 = "locked"
	else
		if(pRenderData.animState ~= "showing") then
			pRenderData.animTime = getTickCount()
			pRenderData.animState = "starting"
			isAnim = true
		end
		pRenderData.displayState = "locked"
		pRenderData.displayState2 = "locked"
	end
	if(type(contacts) == "table") then
		pRenderData.phoneContacts = contacts
		for k, v in ipairs(contacts) do
			pRenderData.phoneContactsIndex[tostring(v.number)] = v.name
		end
	else pRenderData.phoneContacts = {} end
	if type(messages) == "table" then
		pRenderData.phoneMessages = messages
	else pRenderData.phoneMessages = {} end
	pRenderData.phoneNumber = playerNumber
	setElementData(localPlayer, "phoneState", true)
end
addEvent("phoneEvent.turnOn", true)
addEventHandler("phoneEvent.turnOn", root, phoneEvent.turnOn)

function phoneEvent.cancelPhone()
	if(type(pRenderData) ~= "table") then return end
	if(pRenderData.displayState == "callReceive") then
		turnPhoneOff()
	end
	setElementData(localPlayer, "phoneState", false)
end
addEvent("phoneEvent.cancelPhone", true)
addEventHandler("phoneEvent.cancelPhone", root, phoneEvent.cancelPhone)


function phoneEvent.turnOff()
	if(isAnim) then return end
	if(type(pRenderData) ~= "table") then return end
	if(pRenderData.displayState == "callReceive" or pRenderData.displayState == "call") then return end
	if(pRenderData.animState) then
		turnPhoneOff()
	end
	setElementData(localPlayer, "phoneState", false)
end
addEvent("phoneEvent.turnOff", true)
addEventHandler("phoneEvent.turnOff", root, phoneEvent.turnOff)

function phoneEvent.errorCall(error)
	pRenderData.errorCall = error
	pRenderData.displayState = "call"
	pRenderData.displayState2 = "error"
	pRenderData.displayStateTime = getTickCount()
end
addEvent("phoneEvent.errorCall", true)
addEventHandler("phoneEvent.errorCall", root, phoneEvent.errorCall)

function phoneEvent.turnCallOn()
	pRenderData.displayState = "call"
	pRenderData.displayState2 = "talk"

	if(tonumber(pRenderData.callNumber)) then
		local number1 = tostring(pRenderData.callNumber)
		pRenderData.numberTable = {}
		for i = 1, string.len(number1) do
			local char = string.sub(number1, i, i)
			if(tonumber(char)) then
				table.insert(pRenderData.numberTable, tonumber(char))
			end
		end
	end
end
addEvent("phoneEvent.turnCallOn", true)
addEventHandler("phoneEvent.turnCallOn", root, phoneEvent.turnCallOn)

function phoneEvent.callStart()
	local number = table.concat(pRenderData.numberTable, "")
	if(not tonumber(number)) then return end
	number = tonumber(number)
	if(#pRenderData.numberTable < 6) then
		if number == 911 then
			phoneEvent.turnOff()
			pRenderData.displayState = "call"
			pRenderData.displayState2 = "phoning"
			triggerServerEvent("callTo911", localPlayer)
			return
		elseif number == 4444 then
			phoneEvent.turnOff()
			pRenderData.displayState = "call"
			pRenderData.displayState2 = "phoning"
			triggerServerEvent("callTo4444", localPlayer)
			return
		else
			return
		end
	end
	pRenderData.displayState = "call"
	pRenderData.displayState2 = "phoning"
	triggerServerEvent("phoneFunction.startCall", localPlayer, localPlayer, number)
end

function phoneEvent.smsSound(player)
	local x, y, z = getElementPosition(player)
	local sound = playSound3D(string.format("items/client/phone/files/ringtones/sms.mp3"), x, y, z, false)

	setSoundVolume(sound, 1.0)

	attachElements(sound, player)
	setElementParent(sound, player)

	setElementInterior(sound, getElementInterior(player))
	setElementDimension(sound, getElementDimension(player))
end
addEvent("phoneEvent.smsSound", true)
addEventHandler("phoneEvent.smsSound", root, phoneEvent.smsSound)

function testCommand(command, var1, var2)
	outputChatBox("OK?")
	var1 = tostring(var1)
	if var1 == "1" then
		pRenderData.testPos[1] = tonumber(var2)
	elseif var1 == "2" then
		pRenderData.testPos[2] = tonumber(var2)
	elseif var1 == "3" then
		pRenderData.testPos[3] = tonumber(var2)
	elseif var1 == "4" then
		pRenderData.testPos[4] = tonumber(var2)
	end
	outputChatBox(toJSON(pRenderData.testPos))
end
addCommandHandler("testpos", testCommand)