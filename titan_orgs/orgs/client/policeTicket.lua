----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local ptFunc = {}
local ptF = {}

function ptF.create(player)
	if isElement(ptFunc.okno) then destroyElement(ptFunc.okno) end

	local sW, sH = guiGetScreenSize()
	ptFunc.okno = guiCreateWindow(sW / 2 - 200, sH / 2 - 190, 400, 380, "Wypisywanie mandatu", false)
	guiWindowSetSizable(ptFunc.okno, false)

	ptFunc.label1 = guiCreateLabel(10, 32, 380, 22, "Kwota mandatu", false, ptFunc.okno)
	ptFunc.label2 = guiCreateLabel(10, 106, 380, 22, "Punkty karne", false, ptFunc.okno)
	ptFunc.label3 = guiCreateLabel(10, 178, 380, 22, "Treść", false, ptFunc.okno)
	guiSetFont(ptFunc.label2, "default-bold-small")
	guiSetFont(ptFunc.label3, "default-bold-small")
	guiSetFont(ptFunc.label1, "default-bold-small")

	ptFunc.price = guiCreateEdit(10, 54, 380, 33, "", false, ptFunc.okno)
	ptFunc.points = guiCreateEdit(10, 128, 380, 33, "", false, ptFunc.okno)
	ptFunc.content = guiCreateMemo(10, 200, 380, 119, "", false, ptFunc.okno)

	ptFunc.cancel = guiCreateButton(10, 329, 185, 41, "Anuluj", false, ptFunc.okno)
	ptFunc.save = guiCreateButton(205, 329, 185, 41, "Wypisz mandat", false, ptFunc.okno)

	exports.titan_cursor:showCustomCursor("orgs/client/policeTicket")

	addEventHandler("onClientGUIClick", ptFunc.cancel, ptF.destroy, false)
	addEventHandler("onClientGUIClick", ptFunc.save, ptF.save, false)

	ptFunc.player = player
end
addEvent("ptF.create", true)
addEventHandler("ptF.create", root, ptF.create)

function ptF.destroy()
	if isElement(ptFunc.okno) then destroyElement(ptFunc.okno) end
	ptFunc = {}
	exports.titan_cursor:hideCustomCursor("orgs/client/policeTicket")
end

function ptF.save()
	local price = guiGetText(ptFunc.price)
	local points = guiGetText(ptFunc.points)
	local content = guiGetText(ptFunc.content)

	if not tonumber(price) or not tonumber(points) or string.len(tostring(content)) < 3 then return end
	price = tonumber(price)
	points = tonumber(points)
	content = tostring(content)

	if price <= 0 then return end
	if points < 0 or points > 20 then return end

	triggerServerEvent("ptFunc.addTicket", localPlayer, ptFunc.player, price, points, content)

	ptF.destroy()
end