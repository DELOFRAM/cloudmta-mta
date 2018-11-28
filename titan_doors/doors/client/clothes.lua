----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local clothesGUI = {}
local pedElement
function createClothesGUI(data)
	if(isElement(clothesGUI.okno)) then destroyElement(clothesGUI.okno) end
	clothesGUI = {}
	local sW, sH = guiGetScreenSize()
	clothesGUI.okno = guiCreateWindow(sW / 2 + sW / 4 - 109, sH / 2 - 155, 250, 310, "Wybór skinu", false)
	guiWindowSetSizable(clothesGUI.okno, false)
	clothesGUI.lista = guiCreateGridList(10, 26, 230, 236, false, clothesGUI.okno)
	clothesGUI.columnName = guiGridListAddColumn(clothesGUI.lista, "Nazwa", 0.6)
	clothesGUI.columnPrice = guiGridListAddColumn(clothesGUI.lista, "Cena", 0.2)
	clothesGUI.buy = guiCreateButton(10, 272, 72, 27, "Kup", false, clothesGUI.okno)
	clothesGUI.cancel = guiCreateButton(168, 272, 72, 27, "Anuluj", false, clothesGUI.okno)
	addEventHandler("onClientGUIClick", clothesGUI.cancel, cancelClothesGUI, false)
	addEventHandler("onClientGUIClick", clothesGUI.lista, clickListClothesGUI, false)
	addEventHandler("onClientGUIClick", clothesGUI.buy, buyClothesGUI, false)
	exports.titan_cursor:showCustomCursor("doorsClothesGUI")

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(clothesGUI.lista)
		guiGridListSetItemText(clothesGUI.lista, row, clothesGUI.columnName, v.skinName, false, false)
		guiGridListSetItemText(clothesGUI.lista, row, clothesGUI.columnPrice, "$"..v.price, false, false)
		guiGridListSetItemData(clothesGUI.lista, row, clothesGUI.columnName, v.ID)
		guiGridListSetItemData(clothesGUI.lista, row, clothesGUI.columnPrice, v.skinID)
	end

	setElementAlpha(localPlayer, 0)
	local playerX, playerY, playerZ = getElementPosition(localPlayer)
	local rotX, rotY, rotZ = getElementRotation(localPlayer)

	if(isElement(pedElement)) then destroyElement(pedElement) end
	pedElement = createPed(getElementModel(localPlayer), playerX, playerY, playerZ, rotZ)
	setElementInterior(pedElement, getElementInterior(localPlayer))
	setElementDimension(pedElement, getElementDimension(localPlayer))
	setElementFrozen(pedElement, true)
	setElementCollidableWith(localPlayer, pedElement, false)
	local nX, nY = getPointFromDistanceRotation(playerX, playerY, 4.0, rotZ + 90)
	setCameraMatrix(nX, nY, playerZ + 1.5, getElementPosition(pedElement))
	toggleAllControls(false, true, false)
end
addEvent("createClothesGUI", true)
addEventHandler("createClothesGUI", root, createClothesGUI)

function cancelClothesGUI()
	if(isElement(clothesGUI.okno)) then destroyElement(clothesGUI.okno) end
	clothesGUI = {}
	if(isElement(pedElement)) then destroyElement(pedElement) end
	setElementAlpha(localPlayer, 255)
	setCameraTarget(localPlayer)
	exports.titan_cursor:hideCustomCursor("doorsClothesGUI")
	toggleAllControls(true)
end

function buyClothesGUI()
	local row = guiGridListGetSelectedItem(clothesGUI.lista)
	if(not row or row == -1) then return end
	local skinID = guiGridListGetItemData(clothesGUI.lista, row, clothesGUI.columnName)
	if(tonumber(skinID)) then
		cancelClothesGUI()
		triggerServerEvent("clientBuyClothes", localPlayer, localPlayer, tonumber(skinID))
	end
end

function clickListClothesGUI()
	local row = guiGridListGetSelectedItem(clothesGUI.lista)
	if(not row or row == -1) then return end
	local skinID = guiGridListGetItemData(clothesGUI.lista, row, clothesGUI.columnPrice)
	if(tonumber(skinID)) then
		if(isElement(pedElement)) then
			setElementModel(pedElement, skinID)
		end
	end
end

-------------
-- FUNKCJE --
-------------

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - angle)
	local dx = math.sin(a) * dist
	local dy = math.cos(a) * dist
	return x + dx, y + dy
end