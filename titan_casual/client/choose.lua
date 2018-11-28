----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local chooseGUI = {}

local casualsData = 
{
	[1] = 
	{
		name = "Kurier",
		description = "Praca kuriera umożliwia Ci dostarczanie paczek zamówionych przez graczy do swoich grup! Za każda paczke otrzymujesz wynagrodzenie. Możesz zostać kurierem na własna rękę, musisz posiadać jedynie pojazd, który przystosowany jest do przewozu paczek kurierskich!\n\nKomendy kuriera: /kurier"
	},
	[2] =
	{
		name = "Dostawca pizzy",
		description = "Praca dostawcy pizzy umożliwia Ci jazdę pojazdami typu Pizza Boy. Po wykonaniu trasy dostajesz wypłatę z każdy przejazd.\n\nAby rozpoczać pracę jako dostawca pizzy musisz usiaść na pojeździe typu Pizzaboy (pojazdy rozstawione sa pod budynkami burgershot)"
	}
}

function chooseGUICreate()
	if isElement(chooseGUI.window) then destroyElement(chooseGUI.window) end
	local sW, sH = guiGetScreenSize()
	chooseGUI.window = guiCreateWindow(sW / 2 - 369 / 2, sH / 2 - 434 / 2, 369, 434, "Wybór pracy dorywczej", false)
	guiWindowSetSizable(chooseGUI.window, false)

	chooseGUI.list = guiCreateGridList(10, 27, 349, 168, false, chooseGUI.window)
	chooseGUI.desc = guiCreateMemo(10, 205, 349, 168, "", false, chooseGUI.window)
	guiMemoSetReadOnly(chooseGUI.desc, true)
	chooseGUI.cancel = guiCreateButton(10, 383, 165, 41, "Anuluj", false, chooseGUI.window)
	chooseGUI.select = guiCreateButton(194, 383, 165, 41, "Wybierz", false, chooseGUI.window)

	guiGridListAddColumn(chooseGUI.list, "Nazwa pracy dorywczej", 0.9)

	exports.titan_cursor:showCustomCursor("casual/chooseGUI")

	addEventHandler("onClientGUIClick", chooseGUI.cancel, chooseGUIDelete, false)
	addEventHandler("onClientGUIClick", chooseGUI.select, chooseGUISelect, false)
	addEventHandler("onClientGUIClick", chooseGUI.list, chooseGUIClick, false)

	for k, v in ipairs(casualsData) do
		local row = guiGridListAddRow(chooseGUI.list)
		guiGridListSetItemText(chooseGUI.list, row, 1, v.name, false, false)
		guiGridListSetItemData(chooseGUI.list, row, 1, k)
	end
end
addEvent("chooseGUICreate", true)
addEventHandler("chooseGUICreate", root, chooseGUICreate)

function chooseGUIGetInfo(ID)
	if type(casualsData[ID]) == "table" then return casualsData[ID] end
	return false
end

function chooseGUIDelete()
	if isElement(chooseGUI.window) then destroyElement(chooseGUI.window) end
	exports.titan_cursor:hideCustomCursor("casual/chooseGUI")
end

function chooseGUISelect()
	local row = guiGridListGetSelectedItem(chooseGUI.list)
	if not row or row == -1 then return end
	local info = guiGridListGetItemData(chooseGUI.list, row, 1)
	if not tonumber(info) then return end
	chooseGUIDelete()
	triggerServerEvent("casualEventOnClientTriedToChooseCasual", localPlayer, info)
end

function chooseGUIClick()
	local row = guiGridListGetSelectedItem(chooseGUI.list)
	if not row or row == -1 then
		guiSetText(chooseGUI.desc, "")
		return
	end

	local info = chooseGUIGetInfo(guiGridListGetItemData(chooseGUI.list, row, 1))
	if info then 
		guiSetText(chooseGUI.desc, info.description)
	end
end