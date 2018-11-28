----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local vprzypiszgui = {}
 function vprzypiszgui.createGUI(data)
 	if isElement(vprzypiszgui.okno) then destroyElement(vprzypiszgui.okno) end
 	local sW, sH = guiGetScreenSize()
 	vprzypiszgui.okno = guiCreateWindow(sW / 2 - 361 / 2, sH / 2 - 368 / 2, 361, 368, "Przypisywanie pojazdu", false)
 	guiWindowSetSizable(vprzypiszgui.okno, false)
 	vprzypiszgui.lista = guiCreateGridList(10, 25, 341, 288, false, vprzypiszgui.okno)
 	vprzypiszgui.column1 = guiGridListAddColumn(vprzypiszgui.lista, "Grupa", 1)
 	vprzypiszgui.button = guiCreateButton(10, 323, 341, 35, "Zamknij", false, vprzypiszgui.okno)

addEventHandler("onClientGUIClick", vprzypiszgui.button, vprzypiszgui.removeGUI, false)
addEventHandler( "onClientGUIDoubleClick", vprzypiszgui.lista, vprzypiszgui.selectGroup, false )
exports.titan_cursor:showCustomCursor("vehiclesClientVehPrzypisz")
guiGridListSetSortingEnabled(vprzypiszgui.lista, false)

 	for k, v in ipairs(data) do
 		local row = guiGridListAddRow(vprzypiszgui.lista)
 		guiGridListSetItemText(vprzypiszgui.lista, row, vprzypiszgui.column1, v.title, false, false)
 		guiGridListSetItemColor(vprzypiszgui.lista, row, vprzypiszgui.column1, 180, 180, 180)
 		guiGridListSetItemData(vprzypiszgui.lista, row, vprzypiszgui.column1, v.ID )
 	end
 end
 addEvent("vprzypiszgui.show", true)
 addEventHandler("vprzypiszgui.show", root, vprzypiszgui.createGUI)

 function vprzypiszgui.selectGroup()
 local selectedRow, selectedCol = guiGridListGetSelectedItem( vprzypiszgui.lista )
 	if not(selectedRow == -1) and not(selectedCol == -1) then
 		local group = guiGridListGetItemText( vprzypiszgui.lista, selectedRow, selectedCol )
 		local ID = guiGridListGetItemData( vprzypiszgui.lista, selectedRow, selectedCol )
 		vprzypiszgui.removeGUI()
 	end
 end

 function vprzypiszgui.removeGUI()
 	if isElement(vprzypiszgui.okno) then destroyElement(vprzypiszgui.okno) end
 	exports.titan_cursor:hideCustomCursor("vehiclesClientVehPrzypisz")
 end