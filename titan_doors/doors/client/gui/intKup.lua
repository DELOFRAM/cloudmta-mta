----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local buyGUI = {}
local toggleBuyGUI = false
function createBuyGUI(data)
	if(isElement(buyGUI.okno)) then destroyElement(buyGUI.okno) end
	local sW, sH = guiGetScreenSize()
	buyGUI.okno = guiCreateWindow(sW / 2 - 286 / 2, sH / 2 - 357 / 2, 286, 357, "Sklep", false)
	guiWindowSetSizable(buyGUI.okno, false)

	buyGUI.lista = guiCreateGridList(12, 26, 264, 271, false, buyGUI.okno)
	buyGUI.columnName = guiGridListAddColumn(buyGUI.lista, "Nazwa", 0.6)
	buyGUI.columnPrice = guiGridListAddColumn(buyGUI.lista, "Cena", 0.3)
	buyGUI.kup = guiCreateButton(22, 307, 89, 37, "Kup", false, buyGUI.okno)
	buyGUI.anuluj = guiCreateButton(177, 307, 89, 37, "Anuluj", false, buyGUI.okno)
	addEventHandler("onClientGUIClick", buyGUI.anuluj, closeBuyGUI, false)
	addEventHandler("onClientGUIClick", buyGUI.kup, useBuyGUI, false)
	addEventHandler("onClientGUIDoubleClick", buyGUI.lista, useBuyGUI, false)
	exports.titan_cursor:showCustomCursor("doorsIntKup")

	if(type(data) == "table") then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(buyGUI.lista)

			guiGridListSetItemText(buyGUI.lista, row, buyGUI.columnName, v.itemName, false, false)
			guiGridListSetItemText(buyGUI.lista, row, buyGUI.columnPrice, "$"..v.price, false, false)
			guiGridListSetItemData(buyGUI.lista, row, buyGUI.columnName, v.ID)
		end
	end
end
addEvent("createBuyGUI", true)
addEventHandler("createBuyGUI", root, createBuyGUI)

function closeBuyGUI()
	if(isElement(buyGUI.okno)) then destroyElement(buyGUI.okno) end
	exports.titan_cursor:hideCustomCursor("doorsIntKup")
end

function useBuyGUI()
	if(toggleBuyGUI) then return end
	local row = guiGridListGetSelectedItem(buyGUI.lista)
	if(not row or row == -1) then return end

	local ID = guiGridListGetItemData(buyGUI.lista, row, buyGUI.columnName)
	if(tonumber(ID)) then
		ID = tonumber(ID)
		toggleBuyGUI = true
		guiSetEnabled(buyGUI.kup, false)
		triggerServerEvent("onClientBuyItem", localPlayer, localPlayer, ID)
	end
end

function removeBlockBuyGUI()
	toggleBuyGUI = false
	if(isElement(buyGUI.kup)) then
		guiSetEnabled(buyGUI.kup, true)
	end
end
addEvent("removeBlockBuyGUI", true)
addEventHandler("removeBlockBuyGUI", root, removeBlockBuyGUI)

function turnBuySoundOn()
	playSound("doors/client/files/cash.mp3", false)
end
addEvent("turnBuySoundOn", true)
addEventHandler("turnBuySoundOn", root, turnBuySoundOn)