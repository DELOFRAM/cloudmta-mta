----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-15 23:20:24
-- Ostatnio zmodyfikowano: 2016-01-17 20:46:56
----------------------------------------------------

local giveMenu = {}

function giveMenu.create(data, target)
	local sW, sH = guiGetScreenSize()
	if isElement(giveMenu.okno) then destroyElement(giveMenu.okno) end
	giveMenu.okno = guiCreateWindow(sW / 2 - 344 / 2, sH / 2 - 381 / 2, 344, 381, "Podawanie graczowi "..target:getData("name").." "..target:getData("lastname"), false)
	giveMenu.lista = guiCreateGridList(10, 26, 324, 291, false, giveMenu.okno)
	guiGridListAddColumn(giveMenu.lista, "Nazwa przedmiotu", 0.65)
	guiGridListAddColumn(giveMenu.lista, "Cena", 0.3)
	guiWindowSetSizable(giveMenu.okno, false)
	giveMenu.button1 = guiCreateButton(10, 327, 155, 44, "Wybierz", false, giveMenu.okno)
	giveMenu.button2 = guiCreateButton(179, 327, 155, 44, "Anuluj", false, giveMenu.okno)

	addEventHandler("onClientGUIClick", giveMenu.button1, giveMenu.funcButton1, false)
	addEventHandler("onClientGUIClick", giveMenu.button2, giveMenu.funcButton2, false)

	giveMenu.target = target

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(giveMenu.lista)
		guiGridListSetItemText(giveMenu.lista, row, 1, v.name, false, false)
		guiGridListSetItemText(giveMenu.lista, row, 2, "$"..v.sellPrice, false, false)
		guiGridListSetItemData(giveMenu.lista, row, 1, v.ID)
	end

	exports.titan_cursor:showCustomCursor("orgsClientGiveMenu")
end
addEvent("giveMenu.create", true)
addEventHandler("giveMenu.create", root, giveMenu.create)

function giveMenu.funcButton1()
	local selectedItem = guiGridListGetSelectedItem(giveMenu.lista)
	if not selectedItem or selectedItem == -1 then return end
	local itemData = guiGridListGetItemData(giveMenu.lista, selectedItem, 1)
	if tonumber(itemData) then
		triggerServerEvent("sendGiveOffer", localPlayer, localPlayer, giveMenu.target, tonumber(itemData))
		giveMenu.funcButton2()
	end
end

function giveMenu.funcButton2()
	if isElement(giveMenu.okno) then destroyElement(giveMenu.okno) end
	exports.titan_cursor:hideCustomCursor("orgsClientGiveMenu")
end