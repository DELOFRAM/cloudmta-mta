----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local editData = {}
local attachMenuGUI = {}
local editMenu = {}
local sW, sH = guiGetScreenSize()
function createAttachMenu(itemID, boneID, objectID)
	if isElement(attachMenuGUI.okno) then destroyElement(attachMenuGUI.okno) end
	attachMenuGUI.okno = guiCreateWindow(sW / 2 - 309 / 2, sH / 2 - 155 / 2, 309, 155, "Przedmiot przyczepialny", false)
	guiWindowSetSizable(attachMenuGUI.okno, false)
	attachMenuGUI.label = guiCreateLabel(10, 25, 290, 17, "Co chcesz zrobić?", false, attachMenuGUI.okno)
	guiLabelSetHorizontalAlign(attachMenuGUI.label, "center", false)
	attachMenuGUI.button1 = guiCreateButton(10, 52, 140, 56, "Załóż", false, attachMenuGUI.okno)
	attachMenuGUI.button2 = guiCreateButton(160, 52, 140, 56, "Edytuj pozycję", false, attachMenuGUI.okno)
	attachMenuGUI.button3 = guiCreateButton(104, 118, 105, 27, "Anuluj", false, attachMenuGUI.okno)
	attachMenuGUI.itemID = itemID
	attachMenuGUI.boneID = boneID
	attachMenuGUI.objectID = objectID
	addEventHandler("onClientGUIClick", attachMenuGUI.button1, onBut1, false)
	addEventHandler("onClientGUIClick", attachMenuGUI.button2, onBut2, false)
	addEventHandler("onClientGUIClick", attachMenuGUI.button3, onBut3, false)
	exports.titan_cursor:showCustomCursor("itemsAttachMenu")
end
addEvent("createAttachMenu", true)
addEventHandler("createAttachMenu", root, createAttachMenu)

function onBut1()
	triggerServerEvent("takeAttachedItemOn", localPlayer, localPlayer, attachMenuGUI.itemID)
	onBut3()
end

function onBut2()
	editData.object = createObject(attachMenuGUI.objectID, 0, 0, 0)
	exports.titan_boneAttach:attachElementToBone(editData.object, localPlayer, attachMenuGUI.boneID, 0, 0, 0, 0, 0, 0)
	setElementData(editData.object, "itemID", attachMenuGUI.itemID)
	setElementData(editData.object, "itemOwner", localPlayer)
	addEventHandler("onClientRender", root, editMenu.render)
	if isElement(attachMenuGUI.okno) then destroyElement(attachMenuGUI.okno) end
	editMenu.create()
	exports.titan_cursor:hideCustomCursor("itemsAttachMenu")
end

function onBut3()
	if isElement(attachMenuGUI.okno) then destroyElement(attachMenuGUI.okno) end
	exports.titan_cursor:hideCustomCursor("itemsAttachMenu")
end

function editMenu.create()
	if isElement(editMenu.window) then destroyElement(editMenu.window) end
	editMenu.window = guiCreateWindow(sW - 220, sH / 2 - 247 / 2, 189, 247, "Edycja obiektu przyczepialnego", false)
	guiWindowSetSizable(editMenu.window, false)

	editMenu.posX = guiCreateEdit(10, 27, 169, 23, "0", false, editMenu.window)
	editMenu.posY = guiCreateEdit(10, 50, 169, 23, "0", false, editMenu.window)
	editMenu.posZ = guiCreateEdit(10, 73, 169, 23, "0", false, editMenu.window)
	editMenu.posrX = guiCreateEdit(10, 96, 169, 23, "0", false, editMenu.window)
	editMenu.posrY = guiCreateEdit(10, 119, 169, 23, "0", false, editMenu.window)
	editMenu.posrZ = guiCreateEdit(10, 142, 169, 23, "0", false, editMenu.window)
	editMenu.previewB = guiCreateButton(10, 172, 84.5, 33, "Podgląd", false, editMenu.window)
	editMenu.saveB = guiCreateButton(94.5, 172, 84.5, 33, "Zapisz", false, editMenu.window)
	editMenu.cancel = guiCreateButton(12, 213, 167, 24, "Anuluj", false, editMenu.window)

	addEventHandler("onClientGUIClick", editMenu.cancel, editMenu.destroy, false)
	addEventHandler("onClientGUIClick", editMenu.saveB, editMenu.save, false)
	addEventHandler("onClientGUIClick", editMenu.previewB, editMenu.preview, false)
	exports.titan_cursor:showCustomCursor("itemsAttachMenu2")
end

function editMenu.save()
	local x = guiGetText(editMenu.posX)
	local y = guiGetText(editMenu.posY)
	local z = guiGetText(editMenu.posZ)
	local rx = guiGetText(editMenu.posrX)
	local ry = guiGetText(editMenu.posrY)
	local rz = guiGetText(editMenu.posrZ)

	if not tonumber(x) or not tonumber(y) or not tonumber(z) or not tonumber(rx) or not tonumber(ry) or not tonumber(rz) then return end
	x = tonumber(x)
	y = tonumber(y)
	z = tonumber(z)
	rx = tonumber(rx)
	ry = tonumber(ry)
	rz = tonumber(rz)
	triggerServerEvent("saveAttachItemPos", localPlayer, localPlayer, attachMenuGUI.itemID, x, y, z, rx, ry, rz)
	editMenu.destroy()
end

function editMenu.preview()
	local x = guiGetText(editMenu.posX)
	local y = guiGetText(editMenu.posY)
	local z = guiGetText(editMenu.posZ)
	local rx = guiGetText(editMenu.posrX)
	local ry = guiGetText(editMenu.posrY)
	local rz = guiGetText(editMenu.posrZ)

	if not tonumber(x) or not tonumber(y) or not tonumber(z) or not tonumber(rx) or not tonumber(ry) or not tonumber(rz) then return end
	x = tonumber(x)
	y = tonumber(y)
	z = tonumber(z)
	rx = tonumber(rx)
	ry = tonumber(ry)
	rz = tonumber(rz)

	exports.titan_boneAttach:setElementBonePositionOffset(editData.object, x, y, z)
	exports.titan_boneAttach:setElementBoneRotationOffset(editData.object, rx, ry, rz)
end

function editMenu.render()
	if isElement(editData.object) then
		local x, y, z = getElementPosition(editData.object)
		dxDrawLine3D(x - 0.5, y, z, x + 0.5, y, z, tocolor(255, 0, 0, 100))
		dxDrawLine3D(x, y - 0.5, z, x, y + 0.5, z, tocolor(0, 255, 0, 100))
		dxDrawLine3D(x, y, z - 0.5, x, y, z + 0.5, tocolor(0, 0, 255, 100))
		if getKeyState("space") then
			exports.titan_cursor:hideCustomCursor("itemsAttachMenu2")
		else
			exports.titan_cursor:showCustomCursor("itemsAttachMenu2")
		end
	end
end

function editMenu.destroy()
	if isElement(editMenu.window) then destroyElement(editMenu.window) end
	if isElement(editData.object) then destroyElement(editData.object) end
	removeEventHandler("onClientRender", root, editMenu.render)
	exports.titan_cursor:hideCustomCursor("itemsAttachMenu2")
end