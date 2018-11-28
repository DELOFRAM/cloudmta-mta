----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local iinfogui = {}
function iinfogui.createGUI(data)
	if isElement(iinfogui.okno) then destroyElement(iinfogui.okno) end
	local sW, sH = guiGetScreenSize()
	iinfogui.okno = guiCreateWindow(sW / 2 - 361 / 2, sH / 2 - 368 / 2, 361, 368, "Informacje o przedmiocie", false)
	guiWindowSetSizable(iinfogui.okno, false)
	iinfogui.lista = guiCreateGridList(10, 25, 341, 288, false, iinfogui.okno)
	iinfogui.column1 = guiGridListAddColumn(iinfogui.lista, "Parametr", 0.45)
	iinfogui.column2 = guiGridListAddColumn(iinfogui.lista, "Wartość", 0.45)
	iinfogui.button = guiCreateButton(10, 323, 341, 35, "Zamknij", false, iinfogui.okno)
	addEventHandler("onClientGUIClick", iinfogui.button, iinfogui.removeGUI, false)
	exports.titan_cursor:showCustomCursor("itemsClientInfo")
	guiGridListSetSortingEnabled(iinfogui.lista, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(iinfogui.lista)
		guiGridListSetItemText(iinfogui.lista, row, iinfogui.column1, tostring(v.title), false, false)
		guiGridListSetItemColor(iinfogui.lista, row, iinfogui.column1, 180, 180, 180)
		guiGridListSetItemText(iinfogui.lista, row, iinfogui.column2, tostring(v.text), false, false)
		guiGridListSetItemColor(iinfogui.lista, row, iinfogui.column2, v.color[1], v.color[2], v.color[3])
	end
end
addEvent("iinfogui.show", true)
addEventHandler("iinfogui.show", root, iinfogui.createGUI)

function iinfogui.removeGUI()
	if isElement(iinfogui.okno) then destroyElement(iinfogui.okno) end
	exports.titan_cursor:hideCustomCursor("itemsClientInfo")
end