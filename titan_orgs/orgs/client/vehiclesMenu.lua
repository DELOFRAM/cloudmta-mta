----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local vehiclesMenuFunc = {}
local vehiclesMenu = {}

function vehiclesMenuFunc.createMenu(vehicles)
	if isElement(vehiclesMenu.window) then destroyElement(vehiclesMenu.window) end
	local sW, sH = guiGetScreenSize()
	vehiclesMenu.window = guiCreateWindow(sW / 2 - 405 / 2, sH / 2 - 444 / 2, 405, 444, "Pojazdy grupy", false)
	guiWindowSetSizable(vehiclesMenu.window, false)
	vehiclesMenu.list = guiCreateGridList(10, 28, 385, 326, false, vehiclesMenu.window)
	vehiclesMenu.buttonCancel = guiCreateButton(10, 408, 385, 26, "Anuluj", false, vehiclesMenu.window)
	vehiclesMenu.buttonSpawn = guiCreateButton(10, 364, 189, 34, "Spawn/Unspawn", false, vehiclesMenu.window)
	vehiclesMenu.buttonLocate = guiCreateButton(206, 364, 189, 34, "Namierz", false, vehiclesMenu.window)

	exports.titan_cursor:showCustomCursor("orgs/client/vehiclesMenu")

	guiGridListAddColumn(vehiclesMenu.list, "ID", 0.2)
	guiGridListAddColumn(vehiclesMenu.list, "Nazwa", 0.5)
	guiGridListAddColumn(vehiclesMenu.list, "Spawn", 0.1)
	guiGridListAddColumn(vehiclesMenu.list, "HP", 0.1)

	for k, v in ipairs(vehicles) do
		local row = guiGridListAddRow(vehiclesMenu.list)
		guiGridListSetItemText(vehiclesMenu.list, row, 1, v.ID, false, true)
		guiGridListSetItemText(vehiclesMenu.list, row, 2, v.name.." (Model: "..v.model..")", false, false)
		guiGridListSetItemText(vehiclesMenu.list, row, 3, v.spawned == 1 and "Tak" or "Nie", false, false)
		guiGridListSetItemText(vehiclesMenu.list, row, 4, string.format("%0.1f", v.hp), false, true)

		guiGridListSetItemData(vehiclesMenu.list, row, 1, v.ID)
	end

	addEventHandler("onClientGUIClick", vehiclesMenu.buttonCancel, vehiclesMenuFunc.removeMenu, false)
	addEventHandler("onClientGUIClick", vehiclesMenu.buttonSpawn, vehiclesMenuFunc.SpawnUnspawn, false)
	addEventHandler("onClientGUIClick", vehiclesMenu.buttonLocate, vehiclesMenuFunc.locate, false)
end
addEvent("vehiclesMenuFunc.createMenu", true)
addEventHandler("vehiclesMenuFunc.createMenu", root, vehiclesMenuFunc.createMenu)

function vehiclesMenuFunc.removeMenu()
	if isElement(vehiclesMenu.window) then destroyElement(vehiclesMenu.window) end
	vehiclesMenu = {}
	exports.titan_cursor:hideCustomCursor("orgs/client/vehiclesMenu")
end

function vehiclesMenuFunc.SpawnUnspawn()
	local row = guiGridListGetSelectedItem(vehiclesMenu.list)
	if not row or row == -1 then return end
	local vehID = guiGridListGetItemData(vehiclesMenu.list, row, 1)
	if tonumber(vehID) then
		triggerServerEvent("playerGuiFunc.spawnUnspawnVehicle", localPlayer, vehID)
	end
end

function vehiclesMenuFunc.locate()
	local row = guiGridListGetSelectedItem(vehiclesMenu.list)
	if not row or row == -1 then return end
	local vehID = guiGridListGetItemData(vehiclesMenu.list, row, 1)
	if tonumber(vehID) then
		triggerServerEvent("playerGuiFunc.locateVehicle", localPlayer, vehID)
	end
end