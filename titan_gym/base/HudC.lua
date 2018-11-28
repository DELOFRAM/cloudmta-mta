local sW, sH = guiGetScreenSize(  )
local font = dxCreateFont("files/font/a.ttf", 30)
local renderData = {}
renderData.time = getTickCount(  )
renderData.boxX 	= sW / 2 - 200
renderData.boxY 	= sH - 125
renderData.boxW 	= 400
renderData.boxH 	= 50

renderData.textX 	= renderData.boxX
renderData.textY 	= renderData.boxY + renderData.boxH/2 - 15
renderData.textW 	= renderData.textX + renderData.boxW
renderData.textH 	= renderData.textY + renderData.boxH / 2 + 5



-- for i,v in ipairs(getElementsByType("player")) do
-- 	setElementData(v,"traningTime",5000)
-- 	setElementData(v,"inTraning",true)
-- end

function renderTraningTime()
	if(getElementData(localPlayer, "loggedIn") ~= 1) then return end
	if not getElementData(localPlayer, "traningTime") or not getElementData(localPlayer, "inTraning") then return end
	local traningTime = getElementData(localPlayer, "traningTime")
	local hours = math.floor(traningTime / 3600)
	local minutes = math.floor(traningTime / 60) - (hours * 60)
	local seconds = math.floor(traningTime - (minutes * 60) - (hours * 3600))
	dxDrawRectangle(renderData.boxX, renderData.boxY, renderData.boxW, renderData.boxH, tocolor(0, 0, 0, 150))
	dxDrawText(string.format("Do końca treningu pozostało %0.2d:%0.2d:%0.2d", hours, minutes, seconds), renderData.textX, renderData.textY, renderData.textW, renderData.textH, tocolor(255, 255, 255, 255), 0.5, font, "center", "center")
	
	if getTickCount(  )-renderData.time > 1000 then
		renderData.time = getTickCount(  )
		if traningTime > 0 then
			traningTime = traningTime - 1
		else
			traningTime = 0
		end
		setElementData(localPlayer,"traningTime",traningTime)
	end

end
addEventHandler("onClientRender", root, renderTraningTime)