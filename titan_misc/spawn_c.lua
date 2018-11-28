----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local spawnGui = {}

function createSpawnGUI(data)
	if isElement(spawnGui.window) then destroyElement(spawnGui.window) end
	local sW, sH = guiGetScreenSize()
	spawnGui.window = guiCreateWindow(sW / 2 - 168, sH / 2 - 184.5, 336, 369, "Wybierz swój spawn", false)
	spawnGui.list = guiCreateGridList(10, 26, 316, 279, false, spawnGui.window)
	spawnGui.cancel = guiCreateButton(10, 315, 316, 44, "Zamknij", false, spawnGui.window)
	guiWindowSetSizable(spawnGui.window, false)

	guiGridListAddColumn(spawnGui.list, "Wybór spawnu", 0.9)

	exports.titan_cursor:showCustomCursor("spawnGUI")

	addEventHandler("onClientGUIClick", spawnGui.cancel, destroySpawnGUI, false)
	addEventHandler("onClientGUIDoubleClick", spawnGui.list, chooseSpawn, false)

	if type(data) == "table" then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(spawnGui.list)
			guiGridListSetItemText(spawnGui.list, row, 1, v[1], false, false)
			guiGridListSetItemData(spawnGui.list, row, 1, v)
		end
	end
	guiGridListAutoSizeColumn(spawnGui.list, 1)
end
addEvent("createSpawnGUI", true)
addEventHandler("createSpawnGUI", root, createSpawnGUI)

function destroySpawnGUI()
	if isElement(spawnGui.window) then destroyElement(spawnGui.window) end
	exports.titan_cursor:hideCustomCursor("spawnGUI")
end

function chooseSpawn()
	local row = guiGridListGetSelectedItem(spawnGui.list)
	if not row or row == -1 then return false end

	local data = guiGridListGetItemData(spawnGui.list, row, 1)
	if type(data) == "table" and tonumber(data[2]) and tonumber(data[3]) and tonumber(data[4]) then
		destroySpawnGUI()
		triggerServerEvent("guiSetPlayerSpawn", localPlayer, localPlayer, data[2], data[3], data[4])
		--exports.titan_noti:showBox(string.format("Wybrałeś %s (%d, %d, %d)!", data[1], data[2], data[3], data[4]))
	end
end