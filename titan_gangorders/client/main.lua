----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-11 11:57:50
-- Ostatnio zmodyfikowano: 2016-01-11 14:11:46
----------------------------------------------------

local orderData = {}
local sW, sH = guiGetScreenSize()

function orderData.startGUI(cat, orders)
	if isElement(orderData.okno) then destroyElement(orderData.okno) end
	orderData.okno = guiCreateWindow(sW / 2 - 390 / 2, sH / 2 - 390 / 2, 390, 450, "Kupno przedmiotów", false)
	guiWindowSetSizable(orderData.okno, false)
	orderData.lista = guiCreateGridList(10, 28, 370, 349, false, orderData.okno)
	guiGridListAddColumn(orderData.lista, "Nazwa", 0.6)
	guiGridListAddColumn(orderData.lista, "Cena", 0.3)
	orderData.buy = guiCreateButton(16, 386, 175, 54, "Kup", false, orderData.okno)
	orderData.close = guiCreateButton(201, 386, 175, 54, "Zamknij", false, orderData.okno)
	exports.titan_cursor:showCustomCursor("gangOrdersClientMain")
	guiGridListSetSortingEnabled(orderData.lista, false)

	local ordersData = {}
	for k, v in ipairs(orders) do
		if type(ordersData[v.catID]) ~= "table" then ordersData[v.catID] = {} end
		table.insert(ordersData[v.catID], v)
	end
	local categories = {}
	for k, v in ipairs(cat) do
		categories[v.ID] = guiGridListAddRow(orderData.lista)
		guiGridListSetItemText(orderData.lista, categories[v.ID], 1, v.name, true, false)

		if type(ordersData[v.ID]) == "table" then
			for k1, v1 in ipairs(ordersData[v.ID]) do
				local row = guiGridListAddRow(orderData.lista)
				guiGridListSetItemText(orderData.lista, row, 1, v1.name, false, false)
				guiGridListSetItemText(orderData.lista, row, 2, "$"..v1.price, false, false)
				guiGridListSetItemData(orderData.lista, row, 1, v1.ID)
			end
		end
	end

	addEventHandler("onClientGUIClick", orderData.buy, orderData.buyGUI, false)
	addEventHandler("onClientGUIClick", orderData.close, orderData.closeGUI, false)
end
addEvent("orderData.startGUI", true)
addEventHandler("orderData.startGUI", root, orderData.startGUI)

function orderData.buyGUI()
	local row = guiGridListGetSelectedItem(orderData.lista)
	if not row or row == -1 then return end
	local selected = guiGridListGetItemData(orderData.lista, row, 1)
	if tonumber(selected) then
		triggerServerEvent("orderData.funcBuyProduct", localPlayer, selected)
	end
end

function orderData.closeGUI()
	if isElement(orderData.okno) then destroyElement(orderData.okno) end
	exports.titan_cursor:hideCustomCursor("gangOrdersClientMain")
end