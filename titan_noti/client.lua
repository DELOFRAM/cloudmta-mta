------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-08-10 22:04:55

local sW, sH = guiGetScreenSize()
local notiTime = 4000
local renderData = {}
renderData.img = {}
renderData.img[1] = {sW - 340, 0}
renderData.img[2] = {sW - 340, 105}
renderData.img[3] = {sW - 340, 210}

local font = dxCreateFont("files/font.otf", 10)
function notiSoundPlay()
	local sound = playSound("files/noti-sound.mp3")
	setSoundVolume(sound, 0.5)
end

--- NOWE NOTYFIKACJE

local notiFunc = {}
local notiDatas = {}
local notifications = {}

notiDatas.height = 0
notiDatas.remove = false

function notiFunc.render()
	if #notifications > 0 then
		for i = 1, 3 do
			if type(notifications[i]) == "table" then
				local data = notifications[i]
				if data.state == "starting" then
					if not data.sound then
						data.sound = true
						notiSoundPlay()
					end
					local progress = (getTickCount() - data.startTime) / 500
					local alpha, addHeight, alphaText = interpolateBetween(0, 30, 0, 255, 0, 180, progress, "Linear")
					if progress > 1 then
						data.startTime = getTickCount()
						data.state = "showing"
					end

					dxDrawImage(renderData.img[i][1]-40, renderData.img[i][2] + notiDatas.height + addHeight, 380, 115, "files/background.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
					if data.notiType == 1 then
						dxDrawImage(renderData.img[i][1], renderData.img[i][2] + notiDatas.height + addHeight, 340, 115, "files/icon1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
					else
						dxDrawImage(renderData.img[i][1] + 5, renderData.img[i][2] + notiDatas.height + addHeight + 25, 60, 60, data.image, 0, 0, 0, tocolor(255, 255, 255, alpha), true)
						dxDrawImage(renderData.img[i][1] + 5, renderData.img[i][2] + notiDatas.height + addHeight + 25, 60, 60, "files/avatarOutline.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
					end
					dxDrawText(data.text, renderData.img[i][1] + 70, renderData.img[i][2] + notiDatas.height + addHeight, sW - 5, renderData.img[i][2] + 115 + notiDatas.height + addHeight, tocolor(255, 255, 255, alphaText), 1.0, font, "left", "center", true, true, true, false, true, 0, 0, 0)
				elseif data.state == "showing" then
					if (getTickCount() - data.startTime) / notiTime > 1 then
						if i == 1 then
							data.startTime = getTickCount()
							data.state = "hiding"
						end
					end
					dxDrawImage(renderData.img[i][1]-40, renderData.img[i][2] + notiDatas.height, 380, 115, "files/background.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
					if data.notiType == 1 then
						dxDrawImage(renderData.img[i][1], renderData.img[i][2] + notiDatas.height, 340, 115, "files/icon1.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
					else
						dxDrawImage(renderData.img[i][1] + 5, renderData.img[i][2] + notiDatas.height + 25, 60, 60, data.image, 0, 0, 0, tocolor(255, 255, 255, 255), true)
						dxDrawImage(renderData.img[i][1] + 5, renderData.img[i][2] + notiDatas.height + 25, 60, 60, "files/avatarOutline.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
					end
					dxDrawText(data.text, renderData.img[i][1] + 70, renderData.img[i][2] + notiDatas.height, sW - 5, renderData.img[i][2] + 115 + notiDatas.height, tocolor(255, 255, 255, 180), 1.0, font, "left", "center", true, true, true, false, true, 0, 0, 0)
				elseif data.state == "hiding" then
					local progress = (getTickCount() - data.startTime) / 500
					if progress > 1 then notiDatas.remove = true end
					notiDatas.height, alpha, alphaText = interpolateBetween(0, 255, 180, -105, 0, 0, progress, "OutQuad")
					dxDrawImage(renderData.img[i][1]-40, renderData.img[i][2] + notiDatas.height, 380, 115, "files/background.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
					if data.notiType == 1 then
						dxDrawImage(renderData.img[i][1], renderData.img[i][2] + notiDatas.height, 340, 115, "files/icon1.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
					else
						dxDrawImage(renderData.img[i][1] + 5, renderData.img[i][2] + notiDatas.height + 25, 60, 60, data.image, 0, 0, 0, tocolor(255, 255, 255, alpha), true)
						dxDrawImage(renderData.img[i][1] + 5, renderData.img[i][2] + notiDatas.height + 25, 60, 60, "files/avatarOutline.png", 0, 0, 0, tocolor(255, 255, 255, alpha), true)
					end
					dxDrawText(data.text, renderData.img[i][1] + 70, renderData.img[i][2] + notiDatas.height, sW - 5, renderData.img[i][2] + 115 + notiDatas.height, tocolor(255, 255, 255, alphaText), 1.0, font, "left", "center", true, true, true, false, true, 0, 0, 0)
				end
			end
			if i == 3 and notiDatas.remove then
				if isElement(notifications[1].image) then destroyElement(notifications[1].image) end
				table.remove(notifications, 1)
				if type(notifications[3]) == "table" then
					notifications[3].state = "starting"
					notifications[3].startTime = getTickCount()
				end
				notiDatas.height = 0
				notiDatas.remove = false
			end
		end
	end
end
addEventHandler("onClientRender", root, notiFunc.render)

function AntiSpamBox(text)
local count = 1
	for i,v in ipairs(notifications) do
		if text == v.text then
			if count > 2 then
				return false
			else
				count = count+1
			end
		else
			count = 0
		end
	end
	return true
end

function showBox(text)
	if AntiSpamBox(text) then
		table.insert(notifications, {state = "starting", startTime = getTickCount(), text = text, sound = false, notiType = 1})
		outputConsole(string.format("[INFO] %s", text:gsub("\n", " ")))
	end
end
addEvent("showBox", true)
addEventHandler("showBox", root, showBox)

function showFriend(data, text)
	local maskShader = dxCreateShader("files/hud_mask.fx")
	local maskTexture = dxCreateTexture("files/avatarMask.png")
	local image = dxCreateTexture(data)
	dxSetShaderValue(maskShader, "sMaskTexture", maskTexture)
	dxSetShaderValue(maskShader, "sPicTexture", image)
	destroyElement(maskTexture)
	destroyElement(image)
	table.insert(notifications, {state = "starting", startTime = getTickCount(), text = text, sound = false, notiType = 2, image = maskShader})
	outputConsole(string.format("[INFO] %s", text:gsub("\n", " ")))
end
addEvent("showFriend", true)
addEventHandler("showFriend", root, showFriend)