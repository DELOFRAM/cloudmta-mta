----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local atmFunc = {}
local atmGui = {}
local atmGui2 = {}
local atmCardID = 0

function atmFunc.chooseCreate(data)
	local sW, sH = guiGetScreenSize()
	if isElement(atmGui.window) then destroyElement(atmGui.window) end
	atmGui.window = guiCreateWindow(sW / 2 - 421 / 2, sH / 2 - 150, 421, 300, "Bankomat", false)
	guiWindowSetSizable(atmGui.window, false)

	atmGui.label1 = guiCreateLabel(10, 26, 401, 19, "Wybierz kartę", false, atmGui.window)
	guiLabelSetHorizontalAlign(atmGui.label1, "center", false)
	guiLabelSetVerticalAlign(atmGui.label1, "center")
	atmGui.list = guiCreateGridList(10, 45, 401, 101, false, atmGui.window)
	atmGui.label2 = guiCreateLabel(10, 146, 401, 19, "Wprowadź kod PIN", false, atmGui.window)
	guiLabelSetHorizontalAlign(atmGui.label2, "center", false)
	guiLabelSetVerticalAlign(atmGui.label2, "center")
	atmGui.pin = guiCreateEdit(10, 165, 401, 30, "", false, atmGui.window)
	atmGui.cancelChoose = guiCreateButton(10, 251, 401, 39, "Anuluj", false, atmGui.window)
	atmGui.choose = guiCreateButton(11, 205, 400, 39, "Wejdź", false, atmGui.window)
	exports.titan_cursor:showCustomCursor("cash/cash/client/atm")

	guiGridListAddColumn(atmGui.list, "Nazwa konta", 0.5)
	guiGridListAddColumn(atmGui.list, "Numer konta", 0.4)

	addEventHandler("onClientGUIClick", atmGui.cancelChoose, atmFunc.cancelChooseGui, false)
	addEventHandler("onClientGUIClick", atmGui.choose, atmFunc.chooseChooseGui, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(atmGui.list)
		guiGridListSetItemText(atmGui.list, row, 1, v.name, false, false)
		guiGridListSetItemText(atmGui.list, row, 2, v.val3, false, false)
		guiGridListSetItemData(atmGui.list, row, 1, v.ID)
	end
end
addEvent("atmFunc.chooseCreate", true)
addEventHandler("atmFunc.chooseCreate", root, atmFunc.chooseCreate)

function atmFunc.cancelChooseGui()
	if isElement(atmGui.window) then destroyElement(atmGui.window) end
	exports.titan_cursor:hideCustomCursor("cash/cash/client/atm")
end
addEvent("atmFunc.cancelChooseGui", true)
addEventHandler("atmFunc.cancelChooseGui", root, atmFunc.cancelChooseGui)

function atmFunc.enableChooseGui()
	if isElement(atmGui.choose) then
		guiSetEnabled(atmGui.choose, true)
	end
end
addEvent("atmFunc.enableChooseGui", true)
addEventHandler("atmFunc.enableChooseGui", root, atmFunc.enableChooseGui)

function atmFunc.chooseChooseGui()
	local row = guiGridListGetSelectedItem(atmGui.list)
	if not row or row == -1 then
		return exports.titan_noti:showBox("Wybierz kartę z listy dostępnych kart w ekwipunku.")
	end
	local cardID = guiGridListGetItemData(atmGui.list, row, 1)
	if tonumber(cardID) then
		cardID = tonumber(cardID)
		local PIN = guiGetText(atmGui.pin)
		if not PIN or string.len(PIN) == 0 then return exports.titan_noti:showBox("Wprowadź PIN karty.") end
		if not tonumber(PIN) then return exports.titan_noti:showBox("Kod PIN musi składać się tylko z cyfr.") end
		if string.len(PIN) ~= 4 then return exports.titan_noti:showBox("PIN do karty musi składać się z 4 cyfr.") end
		guiSetEnabled(atmGui.choose, false)
		triggerServerEvent("atmFunc.accountLogin", localPlayer, cardID, tonumber(PIN))
	end
end

-- GUI WYPŁACANIA SRODKÓW

function atmFunc.createAtmGui(cardID, money)
	local sW, sH = guiGetScreenSize()
	if isElement(atmGui2.window) then destroyElement(atmGui2.window) end
	atmGui2.window = guiCreateWindow(sW / 2 - 247 / 2, sH / 2 - 225 / 2, 247, 225, "Bankomat", false)
	guiWindowSetSizable(atmGui2.window, false)
	atmGui2.label1 = guiCreateLabel(10, 58, 227, 31, "Wypłata środków", false, atmGui2.window)
	guiSetFont(atmGui2.label1, "default-bold-small")
	guiLabelSetHorizontalAlign(atmGui2.label1, "center", false)
	guiLabelSetVerticalAlign(atmGui2.label1, "center")
	atmGui2.label2 = guiCreateLabel(10, 27, 227, 31, "Stan konta: $"..money, false, atmGui2.window)
	guiSetFont(atmGui2.label2, "default-bold-small")
	guiLabelSetHorizontalAlign(atmGui2.label2, "center", false)
	guiLabelSetVerticalAlign(atmGui2.label2, "center")
	atmGui2.money = guiCreateEdit(10, 99, 227, 37, "", false, atmGui2.window)
	atmGui2.cancel = guiCreateButton(10, 186, 227, 29, "Anuluj", false, atmGui2.window)
	atmGui2.select = guiCreateButton(10, 147, 227, 29, "Wypłać", false, atmGui2.window)

	atmCardID = cardID

	exports.titan_cursor:showCustomCursor("cash/cash/client/atm")

	addEventHandler("onClientGUIClick", atmGui2.cancel, atmFunc.atmCancel, false)
	addEventHandler("onClientGUIClick", atmGui2.select, atmFunc.atmPay, false)
end
addEvent("atmFunc.createAtmGui", true)
addEventHandler("atmFunc.createAtmGui", root, atmFunc.createAtmGui)

function atmFunc.atmCancel()
	if isElement(atmGui2.window) then destroyElement(atmGui2.window) end
	exports.titan_cursor:hideCustomCursor("cash/cash/client/atm")
end
addEvent("atmFunc.atmCancel", true)
addEventHandler("atmFunc.atmCancel", root, atmFunc.atmCancel)

function atmFunc.atmTurnOn()
	if isElement(atmGui2.select) then
		guiSetEnabled(atmGui2.select, true)
	end
end
addEvent("atmFunc.atmTurnOn", true)
addEventHandler("atmFunc.atmTurnOn", root, atmFunc.atmTurnOn)

function atmFunc.atmPay()
	local money = guiGetText(atmGui2.money)
	if not tonumber(money) then
		return exports.titan_noti:showBox("Wprowadź poprawna kwote, która chcesz wypłacić z konta.")
	end
	money = tonumber(money)
	if money <= 0 then
		return exports.titan_noti:showBox("Kwota wypłacana musi być większa od 0.")
	end
	guiSetEnabled(atmGui2.select, false)
	triggerServerEvent("atmFunc.accountPayout", localPlayer, atmCardID, money)
end