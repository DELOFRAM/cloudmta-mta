----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local interactionFunc = {}
local interactionSettings = {}
local interactionPlayerData = {}
local sW, sH = guiGetScreenSize()

function interactionFunc.resetSettings()
	if isElement(interactionSettings.customFont) then destroyElement(interactionSettings.customFont) end
	interactionSettings = 
	{
		customFont = dxCreateFont("client/files/latomedium.ttf", 8),

		hexSize = 128,

		greenColor = {119, 140, 56},
		greyColor = {43, 38, 35},
		redColor = {64, 19, 14},

		selectedInteraction = 1,

		iDuration = 500,
		iState = "starting",
		iTime = getTickCount()
	}
	outputDebugString("Załadowano ustawienia!")
end
addEventHandler("onClientResourceStart", resourceRoot, interactionFunc.resetSettings)

function interactionFunc.getInteractionData(interactionName)
	local name = "Interakcja"
	local image = "client/files/"..interactionSettings.hexSize.."none.png"

	return name, image
end

function interactionFunc.getColorFromName(name, alpha)
	return tocolor(interactionSettings[name][1], interactionSettings[name][2], interactionSettings[name][3], alpha)
end

function interactionFunc.getPositionHex(lineNumber, startX, startY)
	local x, y = startX, startY
	if interactionSettings.hexSize == 128 then
		if lineNumber == 1 then x, y = startX, startY - interactionSettings.hexSize + 16 end
		if lineNumber == 2 then x, y = startX + interactionSettings.hexSize - 32, startY - interactionSettings.hexSize / 2 + 9 end
		if lineNumber == 3 then x, y = startX + interactionSettings.hexSize - 32, startY + interactionSettings.hexSize / 2 - 7 end
		if lineNumber == 4 then x, y = startX, startY + interactionSettings.hexSize - 16 end
		if lineNumber == 5 then x, y = startX - interactionSettings.hexSize + 32, startY + interactionSettings.hexSize / 2 - 7 end
		if lineNumber == 6 then x, y = startX - interactionSettings.hexSize + 32, startY - interactionSettings.hexSize / 2 + 9 end
	else

	end
	return x, y
end

function interactionFunc.renderInteractionMenu()
	local alpha = 1.0
	local additionalHeight = 0
	if interactionSettings.iState == "starting" then
		local progress = (getTickCount() - interactionSettings.iTime) / interactionSettings.iDuration
		alpha, additionalHeight = interpolateBetween(0, 1024, 0, 1, 0, 0, progress, "OutBack")
		if progress > 1 then
			--interactionSettings.iState = "hiding"
			--interactionSettings.iTime = getTickCount()
		end
	elseif interactionSettings.iState == "hiding" then
		local progress = (getTickCount() - interactionSettings.iTime) / interactionSettings.iDuration
		alpha, additionalHeight = interpolateBetween(1, 0, 0, 0, 1024, 0, progress, "InBack")
		if progress > 1 then
			interactionSettings.iState = "showing"
			--interactionSettings.iTime = getTickCount()
		end
	end

	if alpha > 1 then alpha = 1 end

	dxDrawImage(math.floor(sW / 2 - interactionSettings.hexSize / 2), math.floor(sH / 2 - interactionSettings.hexSize / 2 + additionalHeight), interactionSettings.hexSize, interactionSettings.hexSize, "client/files/"..interactionSettings.hexSize.."/hex_bg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	for i = 1, 6 do
		local x, y = interactionFunc.getPositionHex(i, math.floor(sW / 2 - interactionSettings.hexSize / 2), math.floor(sH / 2 - interactionSettings.hexSize / 2 + additionalHeight), 0)
		dxDrawImage(x, y, interactionSettings.hexSize, interactionSettings.hexSize, "client/files/"..interactionSettings.hexSize.."/hex_bg.png", 0, 0, 0, tocolor(255, 255, 255, interactionSettings.selectedInteraction == i and 255 * alpha or 150 * alpha))
		local desc, name = interactionFunc.getInteractionData()
		if interactionSettings.selectedInteraction == i then
			dxDrawImage(math.floor(sW / 2 - interactionSettings.hexSize / 2), math.floor(sH / 2 - interactionSettings.hexSize / 2 + additionalHeight), interactionSettings.hexSize, interactionSettings.hexSize, "client/files/"..interactionSettings.hexSize.."/outline_"..i..".png", 0, 0, 0, interactionFunc.getColorFromName("greenColor", alpha * 255))
			dxDrawText(desc, math.floor(sW / 2 - interactionSettings.hexSize / 2), math.floor(sH / 2 - interactionSettings.hexSize / 2 + additionalHeight), interactionSettings.hexSize + math.floor(sW / 2 - interactionSettings.hexSize / 2), interactionSettings.hexSize + math.floor(sH / 2 - interactionSettings.hexSize / 2 + additionalHeight), tocolor(255, 255, 255, 255 * alpha), 1.0, interactionSettings.customFont, "center", "center", false, false, false, false, false)
		end
	end
end
addEventHandler("onClientRender", root, interactionFunc.renderInteractionMenu)