----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local data = 
{
	turnOn = false,
	pos = {sW - 350, sH / 2 - 60, 350, 120},
	state = "starting",
	startTime = getTickCount(),
	text = "To jest jakiś tam testowy tekst ;)"

}

local queue = {}


function data.render()
	local x, y, w, h = unpack(data.pos)
	local alpha = 1.0
	if data.state == "starting" then
		local progress = (getTickCount() - data.startTime) / 1000
		x, alpha = interpolateBetween(sW, 0, 0, data.pos[1], 1, 0, progress, "OutQuad")
		if progress > 1 then
			data.startTime = getTickCount()
			data.state = "showing"
		end
	elseif data.state == "showing" then
		local progress = (getTickCount() - data.startTime) / 5000
		if progress > 1 then
			data.startTime = getTickCount()
			data.state = "hiding"
		end
	elseif data.state == "hiding" then
		local progress = (getTickCount() - data.startTime) / 1000
		x, alpha = interpolateBetween(data.pos[1], 1, 0, sW, 0, 0, progress, "InQuad")
		if progress > 1 then
			if #queue > 0 then
				data.text = queue[1]
				table.remove(queue, 1)

				data.state = "starting"
				data.startTime = getTickCount()
			else
				data.turnOn = false
				removeEventHandler("onClientRender", root, data.render)
			end
		end
	end
	dxDrawRectangle(x, y, w, h, tocolor(0, 0, 0, 150 * alpha))
	dxDrawText(data.text, x + 5, y + 5, x + w - 10, y + h - 10, tocolor(255, 255, 255, 255 * alpha), 1.0, "default-bold", "left", "top", true, true, false, false, true)
end

function showInfoHelp(text)
	if data.turnOn then
		table.insert(queue, text)
	else
		data.text = text
		data.startTime = getTickCount()
		data.state = "starting"

		data.turnOn = true
		addEventHandler("onClientRender", root, data.render)
	end
end
addEvent("showInfoHelp", true)
addEventHandler("showInfoHelp", root, showInfoHelp)