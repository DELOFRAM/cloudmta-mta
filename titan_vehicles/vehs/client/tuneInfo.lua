local vtunegui = {}


function vtunegui.createGUI(data)
	if isElement(vtunegui.okno) then destroyElement(vtunegui.okno) end
	local sW, sH = guiGetScreenSize()
	vtunegui.okno = guiCreateWindow(sW / 2 - 361 / 2, sH / 2 - 368 / 2, 361, 368, "Informacje o tuningu", false)
	guiWindowSetSizable(vtunegui.okno, false)
	vtunegui.lista = guiCreateGridList(10, 25, 341, 288, false, vtunegui.okno)
	vtunegui.column1 = guiGridListAddColumn(vtunegui.lista, "Nazwa", 0.6)
	vtunegui.column2 = guiGridListAddColumn(vtunegui.lista, "Typ", 0.3)
	vtunegui.button = guiCreateButton(10, 323, 341, 35, "Zamknij", false, vtunegui.okno)
	addEventHandler("onClientGUIClick", vtunegui.button, vtunegui.removeGUI, false)
	exports.titan_cursor:showCustomCursor("vehiclesClientVehTune")
	guiGridListSetSortingEnabled(vtunegui.lista, false)

	if #data > 0 then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(vtunegui.lista)
			guiGridListSetItemText(vtunegui.lista, row, 1, v.name, false, false)
			guiGridListSetItemText(vtunegui.lista, row, 2, vtunegui.getName(v.val1), false, false)
		end
	end
end
addEvent("vtunegui.show", true)
addEventHandler("vtunegui.show", root, vtunegui.createGUI)

function vtunegui.removeGUI()
	if isElement(vtunegui.okno) then destroyElement(vtunegui.okno) end
	exports.titan_cursor:hideCustomCursor("vehiclesClientVehTune")
end

function vtunegui.getName(ID)
	if ID == 1 then return "Felgi"
	end
	return "Nieznany"
end