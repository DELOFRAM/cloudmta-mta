----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local vinfogui = {}
function vinfogui.createGUI(data)
	if isElement(vinfogui.okno) then destroyElement(vinfogui.okno) end
	local sW, sH = guiGetScreenSize()
	vinfogui.okno = guiCreateWindow(sW / 2 - 361 / 2, sH / 2 - 368 / 2, 361, 368, "Informacje o pojeździe", false)
	guiWindowSetSizable(vinfogui.okno, false)
	vinfogui.lista = guiCreateGridList(10, 25, 341, 288, false, vinfogui.okno)
	vinfogui.column1 = guiGridListAddColumn(vinfogui.lista, "Parametr", 0.45)
	vinfogui.column2 = guiGridListAddColumn(vinfogui.lista, "Wartość", 0.45)
	vinfogui.button = guiCreateButton(10, 323, 341, 35, "Zamknij", false, vinfogui.okno)
	addEventHandler("onClientGUIClick", vinfogui.button, vinfogui.removeGUI, false)
	exports.titan_cursor:showCustomCursor("vehiclesClientVehInfo")
	guiGridListSetSortingEnabled(vinfogui.lista, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(vinfogui.lista)
		guiGridListSetItemText(vinfogui.lista, row, vinfogui.column1, v.title, false, false)
		guiGridListSetItemColor(vinfogui.lista, row, vinfogui.column1, 180, 180, 180)
		guiGridListSetItemText(vinfogui.lista, row, vinfogui.column2, v.text, false, false)
		guiGridListSetItemColor(vinfogui.lista, row, vinfogui.column2, v.color[1], v.color[2], v.color[3])
	end
end
addEvent("vinfogui.show", true)
addEventHandler("vinfogui.show", root, vinfogui.createGUI)

function vinfogui.removeGUI()
	if isElement(vinfogui.okno) then destroyElement(vinfogui.okno) end
	exports.titan_cursor:hideCustomCursor("vehiclesClientVehInfo")
end