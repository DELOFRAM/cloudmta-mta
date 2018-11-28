----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local GUI = {}

local function createGUICloset(data)
	closeClosetGUI()
	GUI.okno = guiCreateWindow(0.39, 0.18, 0.22, 0.59, "Przedmioty w schowku", true)
	guiWindowSetSizable(GUI.okno, false)

	GUI.lista = guiCreateGridList(0.03, 0.08, 0.93, 0.76, true, GUI.okno)
	GUI.columnID = guiGridListAddColumn(GUI.lista, "ID", 0.3)
	GUI.columnaName = guiGridListAddColumn(GUI.lista, "Nazwa", 0.6)
	GUI.accept = guiCreateButton(0.07, 0.87, 0.37, 0.10, "Wyciągnij", true, GUI.okno)
	GUI.cancel = guiCreateButton(0.56, 0.87, 0.37, 0.10, "Zamknij", true, GUI.okno)

	addEventHandler("onClientGUIClick", GUI.cancel, closeClosetGUI, false)
	addEventHandler("onClientGUIClick", GUI.accept, acceptClosetGUI, false)
	addEventHandler("onClientGUIDoubleClick", GUI.lista, acceptClosetGUI, false)
	exports.titan_cursor:showCustomCursor("doorsIntCloset")

	if(type(data) == "table") then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(GUI.lista)
			guiGridListSetItemText(GUI.lista, row, GUI.columnID, v.ID, false, true)
			guiGridListSetItemText(GUI.lista, row, GUI.columnaName, v.name, false, false)

			guiGridListSetItemData(GUI.lista, row, GUI.columnID, v.ID)
		end
	end
end
addEvent("createGUICloset", true)
addEventHandler("createGUICloset", root, createGUICloset)

function closeClosetGUI()
	if(isElement(GUI.okno)) then destroyElement(GUI.okno) end
	exports.titan_cursor:hideCustomCursor("doorsIntCloset")
	GUI = {}
end

function acceptClosetGUI()
	local row = guiGridListGetSelectedItem(GUI.lista)
	if(not row or row == -1) then
		exports.titan_noti:showBox("Nie zaznaczyłeś żadnego przedmiotu.")
		return
	end

	local ID = guiGridListGetItemData(GUI.lista, row, GUI.columnID)
	if(not tonumber(ID)) then return end
	ID = tonumber(ID)
	triggerServerEvent("onPlayerChooseClosetItem", localPlayer, localPlayer, ID)
	closeClosetGUI()
end