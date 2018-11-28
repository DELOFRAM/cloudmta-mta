----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local GUI = {}
local groupID = 0
local intID = 0
function createOrderMenuGUI(cat, orders, gID, iID)
	if(isElement(GUI.okno)) then destroyElement(GUI.okno) end
	GUI.okno = guiCreateWindow(0.26, 0.14, 0.45, 0.76, "Zamawianie przedmiotów", true)
	guiWindowSetSizable(GUI.okno, false)

	GUI.lista = guiCreateGridList(0.02, 0.06, 0.52, 0.91, true, GUI.okno)
	GUI.column = guiGridListAddColumn(GUI.lista, "Nazwa", 0.9)

	GUI.opis = guiCreateLabel(0.58, 0.10, 0.35, 0.38, "", true, GUI.okno)
	GUI.label1 = guiCreateLabel(0.61, 0.72, 0.11, 0.08, "Ilość sztuk", true, GUI.okno)
	guiLabelSetHorizontalAlign(GUI.label1, "center", false)
	guiLabelSetVerticalAlign(GUI.label1, "center")

	GUI.stock = guiCreateEdit(0.73, 0.72, 0.15, 0.08, "0", true, GUI.okno)
	GUI.zamow = guiCreateButton(0.63, 0.85, 0.26, 0.10, "Zamów", true, GUI.okno)
	GUI.anuluj = guiCreateButton(0.85, 0.05, 0.12, 0.06, "Anuluj", true, GUI.okno)
	exports.titan_cursor:showCustomCursor("orgsClientOrderMenu")
	addEventHandler("onClientGUIClick", GUI.anuluj, closeOrderMenuGUI, false)
	addEventHandler("onClientGUIClick", GUI.lista, onClientClickItemList, false)
	addEventHandler("onClientGUIClick", GUI.zamow, onClickSubscribeOrderMenu, false)
	groupID = gID
	intID = iID
	local catID = {}
	for k, v in ipairs(cat) do
		catID[v.ID] = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, catID[v.ID], GUI.column, v.name, true, false)
	end
	for k, v in ipairs(orders) do
		local row = guiGridListInsertRowAfter(GUI.lista, catID[v.catID])
		guiGridListSetItemText(GUI.lista, row, GUI.column, v.name, false, false)
		guiGridListSetItemData(GUI.lista, row, GUI.column, v)
		for k, v in pairs(catID) do
			if(v > row - 1) then catID[k] = catID[k] + 1 end
		end
	end
end

function closeOrderMenuGUI()
	destroyElement(GUI.okno)
	GUI = {}
	groupID = 0
	intID = 0
	exports.titan_cursor:hideCustomCursor("orgsClientOrderMenu")
end

function onClickSubscribeOrderMenu()
	local row = guiGridListGetSelectedItem(GUI.lista)
	if(not row or row == -1) then return end
	local itemData = guiGridListGetItemData(GUI.lista, row, GUI.column)
	if(type(itemData) ~= "table") then return end

	local stock = guiGetText(GUI.stock)
	if(not tonumber(stock) or math.floor(tonumber(stock)) <= 0) or tonumber(stock) > 200 then
		guiLabelSetColor(GUI.label1, 255, 0, 0)
		return
	end
	stock = math.floor(tonumber(stock))
	guiLabelSetColor(GUI.label1, 255, 255, 255)
	if(not tonumber(groupID) or groupID <= 0) then return end
	triggerServerEvent("onClientOrderFinalize", localPlayer, localPlayer, groupID, intID, itemData.ID, stock)
	closeOrderMenuGUI()
end

function onClientClickItemList()
	local row = guiGridListGetSelectedItem(GUI.lista)
	if(not row or row == -1) then
		guiSetText(GUI.opis, "")
		return
	end
	local itemData = guiGridListGetItemData(GUI.lista, row, GUI.column)
	if(type(itemData) ~= "table") then return end
	guiSetText(GUI.opis, string.format("INFORMACJE\n\nNazwa: %s\nCena: $%s", itemData.name, itemData.price))
end

local orderFunc = {}
function orderFunc.create(cat, orders, gID, iID)
	orderFunc.destroy()
	local sW, sH = guiGetScreenSize()
	orderFunc.window = guiCreateWindow(sW / 2 - 591 / 2, sH / 2 - 396 / 2, 591, 396, "Zamawianie przedmiotów", false)
	orderFunc.list = guiCreateGridList(10, 24, 266, 329, false, orderFunc.window)
	guiWindowSetSizable(orderFunc.window, false)
	orderFunc.label1 = guiCreateLabel(286, 24, 295, 30, "Informacje o zamawianym przedmiocie", false, orderFunc.window)
	orderFunc.label2 = guiCreateLabel(286, 259, 295, 30, "Wprowadź poniżej ilość zamawianego przedmiotu", false, orderFunc.window)
	orderFunc.name = guiCreateEdit(286, 64, 295, 29, "Nazwa: ", false, orderFunc.window)
	orderFunc.type = guiCreateEdit(286, 103, 295, 29, "Typ: ", false, orderFunc.window)
	orderFunc.val1 = guiCreateEdit(286, 142, 295, 29, "Wartość I: ", false, orderFunc.window)
	orderFunc.val2 = guiCreateEdit(286, 181, 295, 29, "Wartość II: ", false, orderFunc.window)
	orderFunc.price = guiCreateEdit(288, 220, 293, 29, "Cena za sztukę: ", false, orderFunc.window)	
	orderFunc.editIlosc = guiCreateEdit(286, 289, 295, 29, "", false, orderFunc.window)
	orderFunc.order = guiCreateButton(487, 349, 84, 37, "Zamów", false, orderFunc.window)
	orderFunc.cancel = guiCreateButton(393, 349, 84, 37, "Zamknij", false, orderFunc.window)
	
	guiLabelSetHorizontalAlign(orderFunc.label1, "center", false)
	guiLabelSetVerticalAlign(orderFunc.label1, "center")
	guiLabelSetHorizontalAlign(orderFunc.label2, "center", false)
	guiLabelSetVerticalAlign(orderFunc.label2, "center")
	guiEditSetReadOnly(orderFunc.name, true)
	guiEditSetReadOnly(orderFunc.type, true)
	guiEditSetReadOnly(orderFunc.val1, true)
	guiEditSetReadOnly(orderFunc.val2, true)
	guiEditSetReadOnly(orderFunc.price, true)

	guiGridListAddColumn(orderFunc.list, "Nazwa", 0.9)

	groupID = gID
	intID = iID
	local catID = {}
	for k, v in ipairs(cat) do
		catID[v.ID] = guiGridListAddRow(orderFunc.list)
		guiGridListSetItemText(orderFunc.list, catID[v.ID], 1, v.name, true, false)
	end
	for k, v in ipairs(orders) do
		local row = guiGridListInsertRowAfter(orderFunc.list, catID[v.catID])
		guiGridListSetItemText(orderFunc.list, row, 1, v.name, false, false)
		guiGridListSetItemData(orderFunc.list, row, 1, v)
		for k, v in pairs(catID) do
			if(v > row - 1) then catID[k] = catID[k] + 1 end
		end
	end

	showCursor(true)
	addEventHandler("onClientGUIClick", orderFunc.cancel, orderFunc.destroy, false)
	addEventHandler("onClientGUIClick", orderFunc.list, orderFunc.clickList, false)
	addEventHandler("onClientGUIClick", orderFunc.order, orderFunc.clickOrder, false)
end
addEvent("createOrderMenuGUI", true)
addEventHandler("createOrderMenuGUI", root, orderFunc.create)

function orderFunc.destroy()
	if isElement(orderFunc.window) then destroyElement(orderFunc.window) end
	if isCursorShowing() then showCursor(false) end
end

function orderFunc.clickList()
	local row = guiGridListGetSelectedItem(orderFunc.list)
	if(not row or row == -1) then
		guiSetText(orderFunc.name, "Nazwa: ")
		guiSetText(orderFunc.type, "Typ: ")
		guiSetText(orderFunc.val1, "Wartość I: ")
		guiSetText(orderFunc.val2, "Wartość II: ")
		guiSetText(orderFunc.price, "Cena za sztukę: ")
	end
	local itemData = guiGridListGetItemData(orderFunc.list, row, 1)
	if(type(itemData) ~= "table") then return end
	guiSetText(orderFunc.name, "Nazwa: "..itemData.name)
	guiSetText(orderFunc.type, "Typ: ")
	guiSetText(orderFunc.val1, "Wartość I: ")
	guiSetText(orderFunc.val2, "Wartość II: ")
	guiSetText(orderFunc.price, "Cena za sztukę: $"..itemData.price)
end

function orderFunc.clickOrder()
	local row = guiGridListGetSelectedItem(orderFunc.list)
	if(not row or row == -1) then return end
	local itemData = guiGridListGetItemData(orderFunc.list, row, 1)
	if(type(itemData) ~= "table") then return end

	local stock = guiGetText(orderFunc.editIlosc)
	if(not tonumber(stock) or math.floor(tonumber(stock)) <= 0) or tonumber(stock) > 200 then
		return exports.titan_noti:showBox("Musisz wprowadzić ilość zamawianego przedmiotu.")
	end
	stock = math.floor(tonumber(stock))
	if(not tonumber(groupID) or groupID <= 0) then return end
	triggerServerEvent("onClientOrderFinalize", localPlayer, localPlayer, groupID, intID, itemData.ID, stock)
	orderFunc.destroy()
end