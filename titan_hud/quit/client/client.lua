----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

sW, sH = guiGetScreenSize()
MAXDIST = 20
createdTexts = {}

function renderCreatedTexts()
	if #createdTexts == 0 then return end
	for k, v in ipairs(createdTexts) do
		local pX, pY, pZ = getElementPosition(localPlayer)
		local camX, camY, camZ = getCameraMatrix()
		while true do
			local distance = getDistanceBetweenPoints3D(pX, pY, pZ, v.x, v.y, v.z)
			local progress = distance / MAXDIST
			if(processLineOfSight(camX, camY, camZ, v.x, v.y, v.z, true, false, false, true, false, true)) then break end
			local renderX, renderY = getScreenFromWorldPosition(v.x, v.y, v.z, 10, false)
			if(not renderX or not renderY) then break end
			if(progress > 1) then break end
			local imgChange, alpha = interpolateBetween(100, 180, 0, 20, 0, 0, progress, "Linear")
			local scale, height = interpolateBetween(1.0, 0, 0, 0.5, imgChange, 0, progress, "Linear")
			dxDrawImage(renderX - imgChange, renderY - imgChange, imgChange, imgChange, "quit/images/exit.png", 0, 0, 0, tocolor(255, 255, 255, alpha), false)
			dxDrawText(v.text, renderX, renderY - imgChange / 2 - dxGetFontHeight(scale) / 2, renderX, renderY - 100, tocolor(255, 255, 255, alpha), scale, "default", "left", "top", false, false, false, false, false, 0, 0, 0)
			break
		end
	end
end
addEventHandler("onClientRender", root, renderCreatedTexts)

function getKey(tick)
	for k, v in ipairs(createdTexts) do
		if(v.added == tick) then return k end
	end
	return false
end

function destroyText(tick)
	local key = getKey(tick)
	if(not key) then return end
	table.remove(createdTexts, key)
end

function createQuitText(x, y, z, text)
	local tmpTable = {}
	tmpTable.x = x
	tmpTable.y = y
	tmpTable.z = z
	tmpTable.text = text
	tmpTable.added = getTickCount()
	table.insert(createdTexts, tmpTable)
	setTimer(destroyText, 1000 * 30, 1, tmpTable.added)
end
addEvent("createQuitText", true)
addEventHandler("createQuitText", root, createQuitText)