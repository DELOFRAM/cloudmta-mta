resGUI = {}

function createResourcesGUI(data)
	if isElement(resGUI.window) then destroyElement(resGUI.window) end
	resGUI.window = guiCreateWindow(0.38, 0.25, 0.21, 0.41, "Lista włączonych skryptów.", true)
	guiWindowSetSizable(resGUI.window, false)
	resGUI.list = guiCreateGridList(0.03, 0.05, 0.95, 0.84, true, resGUI.window)
	resGUI.column = guiGridListAddColumn(resGUI.list, "Nazwa skryptu.", 0.9)
	resGUI.button = guiCreateButton(0.03, 0.89, 0.95, 0.08, "Zamknij okno", true, resGUI.window)
	guiSetProperty(resGUI.button, "NormalTextColour", "FFAAAAAA")
	addEventHandler("onClientGUIClick", resGUI.button, closeResourcesGUI, false)
	bindKey("enter", "down", closeResourcesGUI)
	exports.titan_cursor:showCustomCursor("adminAdminsGUI")
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(resGUI.list)
		guiGridListSetItemText(resGUI.list, row, resGUI.column, v, false, false)
		guiGridListSetItemColor(resGUI.list, row, resGUI.column, 10, 255, 10)
	end
end
addEvent("showResourcesGUI", true)
addEventHandler("showResourcesGUI", root, createResourcesGUI)

function closeResourcesGUI()
	if isElement(resGUI.window) then destroyElement(resGUI.window) end
	exports.titan_cursor:hideCustomCursor("adminAdminsGUI")
	resGUI = {}
	unbindKey("enter", "down", closeResourcesGUI)
end