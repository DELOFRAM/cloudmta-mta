------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-11 20:44:52

local searchGUI = {}
function createSearchGUI(typ, data, player)
	local sW, sH = guiGetScreenSize()
	if isElement(searchGUI.okno) then destroyElement(searchGUI.okno) end
	searchGUI.okno = guiCreateWindow(sW / 2 - 357 / 2, sH / 2 - 340 / 2, 357, 340, string.format("Przeszukiwanie %s", typ == 1  and "gracza" or typ == 2 and "pojazdu" or typ == 3 and "budynku" or typ == 4 and "śmietnika"), false)
	guiWindowSetSizable(searchGUI.okno, false)
	searchGUI.label = guiCreateLabel(10, 29, 337, 30, string.format("%s", typ == 1 and "Ilość pieniędzy w portfelu: $"..tostring(getElementData(source, "money")) or ""), false, searchGUI.okno)
	guiLabelSetHorizontalAlign(searchGUI.label, "center", false)
	guiLabelSetVerticalAlign(searchGUI.label, "center")
	searchGUI.lista = guiCreateGridList(10, 69, 337, 218, false, searchGUI.okno)
	searchGUI.column1 = guiGridListAddColumn(searchGUI.lista, "ID", 0.3)
	searchGUI.column2 = guiGridListAddColumn(searchGUI.lista, "Nazwa", 0.6)
	searchGUI.button1 = guiCreateButton(10, 295, 166, 35, "Zabierz przedmiot", false, searchGUI.okno)
	searchGUI.button2 = guiCreateButton(181, 295, 166, 35, "Zamknij", false, searchGUI.okno)
	addEventHandler("onClientGUIClick", searchGUI.button2, closeSearchGUI, false)
	addEventHandler("onClientGUIClick", searchGUI.button1, takeSearchGUI, false)
	exports.titan_cursor:showCustomCursor("orgsClientSearchPlayer")
	searchGUI.player = player

	if  searchGUI.player == getLocalPlayer(  ) or type(data) ~= "table" or typ ~= 1 or #data < 0 then
		guiSetEnabled(searchGUI.button1, false)
	end

	if type(data) == "table" and #data > 0 then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(searchGUI.lista)
			guiGridListSetItemText(searchGUI.lista, row, searchGUI.column1, v.ID, false, false)
			guiGridListSetItemText(searchGUI.lista, row, searchGUI.column2, v.name, false, false)
			guiGridListSetItemData(searchGUI.lista, row, searchGUI.column1, v.ID)
		end
	else
		local row = guiGridListAddRow(searchGUI.lista)
		guiGridListSetItemText(searchGUI.lista, row, searchGUI.column2, "Brak przedmiotów", false, false)
		guiSetEnabled(searchGUI.lista, false)
	end
end
addEvent("createSearchGUI", true)
addEventHandler("createSearchGUI", root, createSearchGUI)

function closeSearchGUI()
	if isElement(searchGUI.okno) then destroyElement(searchGUI.okno) end
	searchGUI = {}
	exports.titan_cursor:hideCustomCursor("orgsClientSearchPlayer")
end

function takeSearchGUI()
	local row = guiGridListGetSelectedItem(searchGUI.lista)
	--local items = {}
	--for i = 1, guiGridListGetSelectedCount(searchGUI.lista) do
	--	local data = guiGridListGetItemData(searchGUI.lista, rows[i]["row"], searchGUI.column1)
	--	table.insert(items, data)
	--end
		
	if not row or row == -1 then return end
	local item = guiGridListGetItemData(searchGUI.lista, row, searchGUI.column1)
	if not item then return end

	triggerServerEvent("onPlayerTakeItem", localPlayer, searchGUI.player, item)
	closeSearchGUI()
end