----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local textGUI = {}

function createTextGUI(data)
	if textGUI.showing then return end
	if isElement(textGUI.okno) then destroyElement(textGUI.okno) end
	local sW, sH = guiGetScreenSize()
	textGUI.okno = guiCreateWindow(sW / 2 - 271 / 2, sH / 2 - 306 / 2, 271, 306, "Lista tekstów obok Ciebie", false)
	guiWindowSetSizable(textGUI.okno, false)
	textGUI.lista = guiCreateGridList(10, 24, 251, 223, false, textGUI.okno)
	textGUI.column1 = guiGridListAddColumn(textGUI.lista, "ID", 0.3)
	textGUI.column2 = guiGridListAddColumn(textGUI.lista, "Tekst", 0.6)
	textGUI.button1 = guiCreateButton(10, 257, 123, 39, "Usuń", false, textGUI.okno)
	textGUI.button2 = guiCreateButton(138, 257, 123, 39, "Anuluj", false, textGUI.okno)
	exports.titan_cursor:showCustomCursor("adminListTexts")
	textGUI.showing = true
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(textGUI.lista)
		guiGridListSetItemText(textGUI.lista, row, textGUI.column1, tostring(v:getData("ID")), false, false)
		guiGridListSetItemText(textGUI.lista, row, textGUI.column2, tostring(v:getData("text")), false, false)
		guiGridListSetItemData(textGUI.lista, row, textGUI.column1, v:getData("ID"))
	end
	addEventHandler("onClientGUIClick", textGUI.button2, cancelTextGUI)
	addEventHandler("onClientGUIClick", textGUI.button1, deleteTextGUI)
end
addEvent("createTextGUI", true)
addEventHandler("createTextGUI", root, createTextGUI)

function cancelTextGUI()
	if isElement(textGUI.okno) then destroyElement(textGUI.okno) end
	exports.titan_cursor:hideCustomCursor("adminListTexts")
	textGUI.showing = false
end

function deleteTextGUI()
	local row = guiGridListGetSelectedItem(textGUI.lista)
	if row and row ~= -1 then
		local textID = guiGridListGetItemData(textGUI.lista, row, textGUI.column1)
		if tonumber(textID) then
			textID = tonumber(textID)
			triggerServerEvent("onClientDeleteText", localPlayer, textID)
			cancelTextGUI()
		end
	end
end