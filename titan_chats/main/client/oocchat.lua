----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:47
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:51
----------------------------------------------------

local oocFunc = {}
local oocMessages = {}
local maxMessages = 6

local sW, sH = guiGetScreenSize()
local chatData = getChatboxLayout()
local chatX, chatY = 0.0156 * sW, 16 + 15 * chatData.chat_lines + 30

local enabled = false
local infoText = "Czat OOC [/b]"

function oocFunc.render()
	if localPlayer:getData("dashboardOn") or localPlayer:getData("dashActive") then return end
	if localPlayer:getData("hide:OOC") then return end
	dxDrawText(infoText, chatX + 1, chatY + 1, 0, 0, tocolor(0, 0, 0, 255), 1.0, "default-bold")
	dxDrawText(infoText, chatX, chatY, 0, 0, tocolor(180, 180, 180, 255), 1.0, "default-bold")
	for k, v in ipairs(oocMessages) do
		local textX = chatX
		local textY = chatY + 15 + (k - 1) * 15
		dxDrawText(string.gsub(v.content, "#%x%x%x%x%x%x", ""), textX + 1, textY + 1, 0, 0, tocolor(0, 0, 0, 255), 1.0, "default-bold")
		dxDrawText(v.content, textX, textY, 0, 0, tocolor(v.r, v.g, v.b, 255), 1.0, "default-bold", "left", "top", false, false, false, true, false, 0, 0, 0)
	end
end

function oocFunc.newMessage(text, r, g, b)
	if #oocMessages < maxMessages then
		table.insert(oocMessages, { content = text, r = r, g = g, b = b})
	else
		table.remove(oocMessages, 1)
		table.insert(oocMessages, { content = text, r = r, g = g, b = b})
	end
end
addEvent("addOOCMessage", true)
addEventHandler("addOOCMessage", root, oocFunc.newMessage)

function oocFunc.turnChatOn()
	if not enabled then
		addEventHandler("onClientRender", root, oocFunc.render)
		enabled = true
	end
end
addEvent("oocFunc.turnChatOn", true)
addEventHandler("oocFunc.turnChatOn", root, oocFunc.turnChatOn)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		if getElementData(localPlayer, "loggedIn") == 1 then
	 		oocFunc.turnChatOn()
	 	end
	end
)