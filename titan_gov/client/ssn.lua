----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local ssnFunc = {}

function ssnFunc.create(name, data)
	local sW, sH = guiGetScreenSize()
	ssnFunc.destroy()
	ssnFunc.window = guiCreateWindow(sW / 2 - 406 / 2, sH / 2 - 231 / 2, 406, 231, name, false)
	guiWindowSetSizable(ssnFunc.window, false)
	ssnFunc.list = guiCreateGridList(10, 26, 386, 159, false, ssnFunc.window)
	guiGridListSetSortingEnabled(ssnFunc.list, false)
	guiGridListAddColumn(ssnFunc.list, "", 0.4)
	guiGridListAddColumn(ssnFunc.list, "", 0.5)
	ssnFunc.close = guiCreateButton(10, 193, 386, 28, "Zamknij", false, ssnFunc.window)
	addEventHandler("onClientGUIClick", ssnFunc.close, ssnFunc.destroy, false)
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(ssnFunc.list)
		guiGridListSetItemText(ssnFunc.list, row, 1, v[1], false, false)
		guiGridListSetItemColor(ssnFunc.list, row, 1, 180, 180, 180)
		guiGridListSetItemText(ssnFunc.list, row, 2, v[2], false, false)
	end
	exports.titan_cursor:showCustomCursor("govSSN")
end
addEvent("ssnFunc.create", true)
addEventHandler("ssnFunc.create", root, ssnFunc.create)

function ssnFunc.destroy()
	if isElement(ssnFunc.window) then destroyElement(ssnFunc.window) end
	exports.titan_cursor:hideCustomCursor("govSSN")
end