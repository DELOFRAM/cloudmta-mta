----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local mapSize = {W = 3072, H = 3072}
local minimapSize = {W = 212, H = 207}
--local minimapSize = {W = 400, H = 400}
local renderTarget = dxCreateRenderTarget(minimapSize.W, minimapSize.H, false)
local renderData = {}
local radarToggle = false
local scale = 6000 / mapSize.W
renderData.bg = 
{
	X = 30,
	Y = sH - 251 - 50,
	W = 247,
	H = 251
}
renderData.mapTarget = 
{
	X = renderData.bg.X + 15,
	Y = renderData.bg.Y + 15,
	W = minimapSize.W,
	H = minimapSize.H
}

renderData.pBg = 
{
	X = 45,
	Y1 = sH - 251 - 10 - 90 - 30,
	Y2 = sH - 251 - 10 - 30,
	W = 217,
	H = 93
}
renderData.radarState = "none"
local vector = {X = sW / 1366, Y = sH / 768, blip = 12}
setPlayerHudComponentVisible("radar", false)

-------------
-- Funkcje --
-------------

function findRotation(x1,y1,x2,y2) 
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - angle)
	local dx = math.cos(a) * dist
	local dy = math.sin(a) * dist
	return x + dx, y + dy
end

------------
-- RENDER --
------------

renderData.pTime = {2000, 5000, 2000}

renderData.pState = "none"
--renderData.pTick = getTickCount()

local penaltiesData = {}
function cutText(text)
	if(string.len(text) > 50) then
		text = string.sub(text, 0, 50).."..."
	end
	return text
end

function showPenalty(adminName, playerName, penaltyType, reason, penaltyTime)
	reason = cutText(reason)
	local tmpTable = {}
	tmpTable.adminName = adminName
	tmpTable.playerName = playerName
	tmpTable.penaltyType = penaltyType
	tmpTable.reason = reason
	tmpTable.infoType = 1
	table.insert(penaltiesData, tmpTable)
end
addEvent("showPenalty", true)
addEventHandler("showPenalty", root, showPenalty)

function showPayday(data)
	if type(data) == "table" then
		local readyString = ""
		for k, v in ipairs(data) do
			local stringWitdh = dxGetTextWidth(v, 0.9, renderData.pFontBold, true)
			if stringWitdh > renderData.pBg.W - 25 then
				local i = 2
				local newText = ""
				while true do
					newText = string.sub(v, 0, string.len(v) - i)
					local newStringWidth = dxGetTextWidth(newText, 0.9, renderData.pFontBold, true)
					if newStringWidth < renderData.pBg.W - 25 then
						newText = newText.."..."
						break
					end
					i = i + 2
				end
				if string.len(readyString) == 0 then
					readyString = string.format("%s", newText)
				else
					readyString = string.format("%s\n%s", readyString, newText)
				end
			else
				if string.len(readyString) == 0 then
					readyString = string.format("%s", v)
				else
					readyString = string.format("%s\n%s", readyString, v)
				end
			end
		end
		local tempTable = {}
		tempTable.infoType = 2
		tempTable.data = readyString
		table.insert(penaltiesData, tempTable)
	end
end
addEvent("showPayday", true)
addEventHandler("showPayday", root, showPayday)

renderData.pFontBold = dxCreateFont("sradar/client/files/font.otf", 9, true)
if(not isElement(renderData.pFontBold)) then renderData.pFontBold = "default-bold" end

function renderPenalty()
	if(renderData.pState == "none") then
		if(type(penaltiesData) == "table") then
			if(type(penaltiesData[1]) == "table") then
				renderData.pState = "starting"
				renderData.pTick = getTickCount()
			end
		end
		return
	end
	local height = renderData.pBg.Y1
	local alpha = 1
	if(renderData.pState == "starting") then
		local progress = (getTickCount() - renderData.pTick) / renderData.pTime[1]
		height, alpha = interpolateBetween(renderData.pBg.Y2, 0, 0, renderData.pBg.Y1, 1, 0, progress, "OutQuad")
		if(progress > 1) then
			renderData.pState = "showing"
			renderData.pTick = getTickCount()
		end
	elseif(renderData.pState == "showing") then
		local progress = (getTickCount() - renderData.pTick) / renderData.pTime[2]
		if(progress > 1) then
			renderData.pState = "hiding"
			renderData.pTick = getTickCount()
		end
	elseif(renderData.pState == "hiding") then
		local progress = (getTickCount() - renderData.pTick) / renderData.pTime[3]
		height, alpha = interpolateBetween(renderData.pBg.Y1, 1, 0, renderData.pBg.Y2, 0, 0, progress, "InQuad")
		if(progress > 1) then
			table.remove(penaltiesData, 1)
			renderData.pState = "none"
			return
		end
	end

	if localPlayer:getData("dashboardOn") then return end

	local pData = penaltiesData[1]
	if(type(pData) ~= "table") then return end
	if pData.infoType == 1 then
		dxDrawImage(renderData.pBg.X, height, renderData.pBg.W, renderData.pBg.H, "sradar/client/files/pBg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText(pData.penaltyType, renderData.pBg.X + 5, height + 5, 0, 0, tocolor(177, 5, 5, 200 * alpha), 1.0, renderData.pFontBold, "left", "top", false, false, false, false, true, 0, 0, 0)
		dxDrawText(string.format("#ffffffGracz: #ccc6c6%s", pData.playerName), renderData.pBg.X + 10, height + 25, 0, 0, tocolor(255, 255, 255, 200 * alpha), 1.0, renderData.pFontBold, "left", "top", false, false, false, true, true, 0, 0, 0)
		dxDrawText(string.format("#ffffffNadał: #ccc6c6%s", pData.adminName), renderData.pBg.X + 10, height + 40, 0, 0, tocolor(255, 255, 255, 200 * alpha), 1.0, renderData.pFontBold, "left", "top", false, false, false, true, true, 0, 0, 0)
		dxDrawText("#ffffffPowód:", renderData.pBg.X + 10, height + 55, renderData.pBg.X + 80, height + 80, tocolor(255, 255, 255, 200 * alpha), 1.0, renderData.pFontBold, "left", "top", true, true, false, true, true, 0, 0, 0)
		dxDrawText("               "..pData.reason, renderData.pBg.X + 10, height + 55, renderData.pBg.X + 210, height + 86, tocolor(204, 198, 198, 200 * alpha), 1.0, renderData.pFontBold, "left", "top", true, true, false, false, true, 0, 0, 0)
	elseif pData.infoType == 2 then
		dxDrawImage(renderData.pBg.X, height, renderData.pBg.W, renderData.pBg.H, "sradar/client/files/pBg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText("Payday", renderData.pBg.X + 5, height + 5, 0, 0, tocolor(119, 140, 56, 200 * alpha), 1.0, renderData.pFontBold, "left", "top", false, false, false, false, true, 0, 0, 0)
		dxDrawText(pData.data, renderData.pBg.X + 10, height + 22, renderData.pBg.X + 10 + renderData.pBg.W - 5, 0, tocolor(255, 255, 255, 200 * alpha), 0.9, renderData.pFontBold, "left", "top", true, false, false, true, true, 0, 0, 0)
	end
end
addEventHandler("onClientRender", root, renderPenalty)

function renderRadar()
	if tonumber(localPlayer:getData("loggedIn") and localPlayer:getData("loggedIn") == 1 then
		if localPlayer:getDimension() ~= 0 then
			if renderData.radarState == "showing" then
				toggleRadarVisible(false)
			end
		else
			if renderData.radarState == "none" then
				toggleRadarVisible(true)
			end
		end
	end
	local alpha = 1
	if(renderData.radarState == "none") then
		return
	elseif(renderData.radarState == "starting") then
		local progress = (getTickCount() - renderData.radarTime) / 800
		alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
		if(progress > 1) then
			renderData.radarState = "showing"
		end
	elseif(renderData.radarState == "hiding") then
		local progress = (getTickCount() - renderData.radarTime) / 800
		alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
		if(progress > 1) then
			renderData.radarState = "none"
			return
		end
	end

	if localPlayer:getData("dashboardOn") then return end
	if localPlayer:getData("hide:playerRadar") then return end

	local pX, pY = getElementPosition(localPlayer)
	local pXonMap = minimapSize.W / 2 - (pX / (6000 / mapSize.W))
	local pYOnMap = minimapSize.H / 2 + (pY / (6000 / mapSize.H))
	local camX, camY, camZ = getElementRotation(getCamera())

	dxSetRenderTarget(renderTarget, true)
	dxSetBlendMode("modulate_add")
	-- Render
		dxDrawRectangle(0, 0, minimapSize.W, minimapSize.H, tocolor(110, 158, 204, 255 * alpha), false)
		dxDrawImage(pXonMap - mapSize.W / 2, pYOnMap - mapSize.H / 2, mapSize.W, mapSize.H, "sradar/client/files/map.jpg", 0, (pX / (6000 / mapSize.W)), -(pY / (6000 / mapSize.H)), tocolor(255, 255, 255, 255 * alpha))
		for k, v in ipairs(getElementsByType("radararea")) do
			local rax,ray=getElementPosition(v)
			local raw,rah=getRadarAreaSize(v)

			--local posX = ((rax / scale) - (pX / scale) + raw) - 15
			--local posY = (-(ray / scale) + (pY / scale)) + rah / scale - 15
			local posX = rax / scale - pX / scale + minimapSize.W / 2
			local posY = -((ray + rah) / scale) + pY / scale + minimapSize.H / 2
			local posW = raw / scale
			local posH = rah / scale
			local r, g, b, a = getRadarAreaColor(v)
			dxDrawRectangle(posX, posY, posW, posH, tocolor(r, g, b, a * alpha), false, true)
			--dxDrawLine(posX, posY, posX + posW, posY)
		end
	-- Render - koniec
	dxSetBlendMode("blend")
	dxSetRenderTarget()
	dxSetBlendMode("add")
	--
		dxDrawImage(renderData.mapTarget.X, renderData.mapTarget.Y, renderData.mapTarget.W, renderData.mapTarget.H, renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255))
	--
	dxSetBlendMode("blend")
	dxDrawImage(renderData.bg.X, renderData.bg.Y, renderData.bg.W, renderData.bg.H, "sradar/client/files/bg.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	local x, y, z = getElementPosition(localPlayer)
	-----------
	-- BLIPY --
	-----------

	local rX, rY, rZ = getElementRotation(localPlayer)
	local lB = renderData.bg.X + 22
	local rB = renderData.bg.X + renderData.bg.W - 22
	local tB = renderData.bg.Y + 18
	local bB = renderData.bg.Y + renderData.bg.H - 30
	local cX = (rB + lB) / 2
	local cY = (tB + bB) / 2
	local blips = getElementsByType("blip")
	for k, v in ipairs(blips) do
		local bX, bY = getElementPosition(v)
		local dist = getDistanceBetweenPoints2D(pX, pY, bX, bY)
		local maxDist = getBlipVisibleDistance(v)
		if(dist <= maxDist) then
			if(getElementDimension(v) == getElementDimension(localPlayer)) then
				if(getElementInterior(v) == getElementInterior(localPlayer)) then
					local mapDist = dist / (6000 / ((mapSize.W + mapSize.H) / 2))
					local rot = findRotation(bX, bY, pX, pY)
					local pointX, pointY = getPointFromDistanceRotation(cX, cY, mapDist, rot)
					local pointX = math.max(lB, math.min(rB, pointX))
					local pointY = math.max(tB, math.min(bB, pointY))
					local blipIcon = getBlipIcon(v)
					local bcR, bcG, bcB, bcA = getBlipColor(v)
					if(blipIcon ~= 0) then
						bcR, bcG, bcB = 255, 255, 255
					end
					dxDrawImage(pointX - 10, pointY - 10, 20, 20, "sradar/client/files/blips/0.png", 0, 0, 0, tocolor(bcR, bcG, bcB, bcA * alpha))
				end
			end
		end
	end

	local northX, northY = getPointFromDistanceRotation(cX, cY, math.sqrt(101.5 ^ 2 + 101.5 ^ 2), -camZ + 180)
	local northX = math.max(lB, math.min(rB, northX))
	local northY = math.max(tB, math.min(bB, northY))
	dxDrawImage(cX - 10, tB - 15, 20, 20, "sradar/client/files/blips/north.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	--dxDrawRectangle(renderData.mapTarget.X + 5, renderData.mapTarget.Y, minimapSize.W - 5, 15, tocolor(0, 0, 0, 90))
	dxDrawText(getZoneName(x, y, z), renderData.mapTarget.X + 5 + 1, renderData.mapTarget.Y + minimapSize.H - 15 + 1, renderData.mapTarget.X + minimapSize.W - 5 + 1, renderData.mapTarget.Y + minimapSize.H + 1, tocolor(0, 0, 0, 150 * alpha), 1.0, "default-bold", "center", "center")
	dxDrawText(getZoneName(x, y, z), renderData.mapTarget.X + 5, renderData.mapTarget.Y + minimapSize.H - 15, renderData.mapTarget.X + minimapSize.W - 5, renderData.mapTarget.Y + minimapSize.H, tocolor(255, 255, 255, 150 * alpha), 1.0, "default-bold", "center", "center")
	
	---------------------
	-- WSKAŹNIK GRACZA --
	---------------------
	dxDrawImage(renderData.mapTarget.X + (renderData.mapTarget.W) / 2 - 18, renderData.mapTarget.Y + (renderData.mapTarget.H) / 2 - 14, 36, 28, "sradar/client/files/player.png", -rZ, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	--dxDrawLine(renderData.mapTarget.X, renderData.mapTarget.Y + renderData.mapTarget.H / 2, renderData.mapTarget.X + renderData.mapTarget.W, renderData.mapTarget.Y + renderData.mapTarget.H / 2)
	--dxDrawLine(renderData.mapTarget.X + renderData.mapTarget.W / 2, renderData.mapTarget.Y, renderData.mapTarget.X + renderData.mapTarget.W / 2, renderData.mapTarget.Y + renderData.mapTarget.H)
end
addEventHandler("onClientRender", root, renderRadar)

function toggleRadarVisible(state)
	if(state) then
		renderData.radarState = "starting"
		renderData.radarTime = getTickCount()
	else
		renderData.radarState = "hiding"
		renderData.radarTime = getTickCount()
	end
end
addEvent("toggleRadarVisible", true)
addEventHandler("toggleRadarVisible", root, toggleRadarVisible)

local function onResStart()
	if(getElementData(localPlayer, "loggedIn") and getElementData(localPlayer, "loggedIn") == 1) then
		toggleRadarVisible(true)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)