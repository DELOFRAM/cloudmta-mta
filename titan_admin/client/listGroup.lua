----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

GUIListGroup = {}
listGroupFunc = {}

function listGroupFunc.create(groupsList)
	if GUIListGroup.showing then return end
	if(isElement(GUIListGroup.okno)) then destroyElement(GUIListGroup.okno) end
	local sW, sH = guiGetScreenSize()
	GUIListGroup.okno = guiCreateWindow(sW / 2 - 358 / 2, sH / 2 - 380 / 2, 358, 380, "Lista grup", false)
	guiWindowSetSizable(GUIListGroup.okno, false)

	GUIListGroup.lista = guiCreateGridList(10, 27, 338, 295, false, GUIListGroup.okno)
	GUIListGroup.columnID = guiGridListAddColumn(GUIListGroup.lista, "ID", 0.4)
	GUIListGroup.columnName = guiGridListAddColumn(GUIListGroup.lista, "Nazwa grupy", 0.5)

	GUIListGroup.cancel = guiCreateButton(10, 332, 338, 38, "Zamknij", false, GUIListGroup.okno)
	addEventHandler("onClientGUIClick", GUIListGroup.cancel, listGroupFunc.close, false)

	exports.titan_cursor:showCustomCursor("adminListGroup")
	GUIListGroup.showing = true

	for k, v in pairs(groupsList) do
		local row = guiGridListAddRow(GUIListGroup.lista)
		guiGridListSetItemText(GUIListGroup.lista, row, GUIListGroup.columnID, v.ID, false, true)
		guiGridListSetItemText(GUIListGroup.lista, row, GUIListGroup.columnName, v.name, false, false)
	end
end
addEvent("listGroupFunc.create", true)
addEventHandler("listGroupFunc.create", root, listGroupFunc.create)

function listGroupFunc.close()
	if(isElement(GUIListGroup.okno)) then destroyElement(GUIListGroup.okno) end
	exports.titan_cursor:hideCustomCursor("adminListGroup")
	GUIListGroup.showing = false
	return
end