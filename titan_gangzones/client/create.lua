----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local createFunc = {}
local createGUI = {}
local sW, sH = guiGetScreenSize(0)
local preview = nil
local toggle = false

function createFunc.create()
	if isElement(createGUI.okno1) then destroyElement(createGUI.okno1) end

	createGUI.okno1 = guiCreateWindow(sW / 2 - 344, sH / 2 - 410 / 2, 344, 410, "Edytor sektorów", false)
	guiWindowSetSizable(createGUI.okno1, false)

	createGUI.lista = guiCreateGridList(10, 27, 324, 313, false, createGUI.okno1)
	guiGridListAddColumn(createGUI.lista, "ID", 0.2)
	guiGridListAddColumn(createGUI.lista, "Nazwa", 0.4)
	guiGridListAddColumn(createGUI.lista, "X", 0.2)
	guiGridListAddColumn(createGUI.lista, "Y", 0.2)
	guiGridListAddColumn(createGUI.lista, "W", 0.2)
	guiGridListAddColumn(createGUI.lista, "H", 0.2)
	guiGridListSetSortingEnabled(createGUI.lista, false)

	createGUI.button1_1 = guiCreateButton(10, 350, 76, 43, "Odśwież", false, createGUI.okno1)
	createGUI.button1_2 = guiCreateButton(96, 350, 76, 43, "Usuń", false, createGUI.okno1)
	createGUI.button1_3 = guiCreateButton(182, 350, 152, 43, "Stwórz nowy", false, createGUI.okno1)
	exports.titan_cursor:showCustomCursor("gangZonesCreate")
	createFunc.refreshList()

	addEventHandler("onClientGUIClick", createGUI.button1_1, createFunc.refreshList, false)
	addEventHandler("onClientGUIClick", createGUI.button1_2, createFunc.deleteSector, false)
	addEventHandler("onClientGUIClick", createGUI.button1_3, createFunc.buttonAddNew, false)

	showCursor(true)
end

function createFunc.createNew()
	if isElement(createGUI.okno2) then destroyElement(createGUI.okno2) end

	createGUI.okno2 = guiCreateWindow(sW / 2 + 10, sH / 2 - 410 / 2, 333, 410, "Dodawanie nowego sektoru", false)
	guiWindowSetSizable(createGUI.okno2, false)

	createGUI.edit2_1 = guiCreateEdit(10, 38, 73, 41, "X", false, createGUI.okno2)
	createGUI.edit2_2 = guiCreateEdit(10, 89, 73, 41, "Y", false, createGUI.okno2)
	createGUI.edit2_3 = guiCreateEdit(10, 140, 73, 41, "W", false, createGUI.okno2)
	createGUI.edit2_4 = guiCreateEdit(10, 191, 73, 41, "H", false, createGUI.okno2)
	createGUI.edit2_5 = guiCreateEdit(10, 257, 310, 44, "Nazwa", false, createGUI.okno2)
	createGUI.button2_1 = guiCreateButton(9, 350, 85, 43, "Podgląd", false, createGUI.okno2)
	createGUI.button2_2 = guiCreateButton(104, 350, 85, 43, "Dodaj", false, createGUI.okno2)
	createGUI.button2_3 = guiCreateButton(199, 350, 85, 43, "Anuluj", false, createGUI.okno2)
	exports.titan_cursor:showCustomCursor("gangZonesCreateNew")

	addEventHandler("onClientGUIClick", createGUI.button2_1, createFunc.preview, false)
	addEventHandler("onClientGUIClick", createGUI.button2_2, createFunc.addNewSector, false)
	addEventHandler("onClientGUIClick", createGUI.button2_3, createFunc.buttonCancel, false)
end

function createFunc.refreshList(info)
	if isElement(createGUI.lista) then
		guiGridListClear(createGUI.lista)

		local elements = getElementsByType("radararea")
		for k, v in ipairs(elements) do
			if not v:getData("onlyClient") then
				local data = v:getData("data")
				if data then
					local row = guiGridListAddRow(createGUI.lista)
					guiGridListSetItemText(createGUI.lista, row, 1, data.ID, false, true)
					guiGridListSetItemText(createGUI.lista, row, 2, data.name, false, false)
					guiGridListSetItemText(createGUI.lista, row, 3, data.x, false, true)
					guiGridListSetItemText(createGUI.lista, row, 4, data.y, false, true)
					guiGridListSetItemText(createGUI.lista, row, 5, data.w, false, true)
					guiGridListSetItemText(createGUI.lista, row, 6, data.h, false, true)

					guiGridListSetItemData(createGUI.lista, row, 1, tonumber(data.ID))
				end
			end
		end
		if info == true then
			exports.titan_noti:showBox("Sektor został dodany.")
		elseif info == false then
			exports.titan_noti:showBox("Sektor został usunięty.")
		end
	end
end
addEvent("createFunc.refreshList", true)
addEventHandler("createFunc.refreshList", root, createFunc.refreshList)

function createFunc.buttonAddNew()
	if isElement(createGUI.okno2) then destroyElement(createGUI.okno2) end
	createFunc.createNew()
end

function createFunc.buttonCancel()
	if isElement(createGUI.okno2) then destroyElement(createGUI.okno2) end
	if isElement(preview) then destroyElement(preview) end
	exports.titan_cursor:hideCustomCursor("gangZonesCreateNew")
end

function createFunc.deleteSector()
	if isElement(createGUI.lista) then
		local selected = guiGridListGetSelectedItem(createGUI.lista)
		if not selected or selected == -1 then return exports.titan_noti:showBox("Musisz wybrać sektor z listy, aby go usunąć.") end
		local data = guiGridListGetItemData(createGUI.lista, selected, 1)
		if tonumber(data) then
			triggerServerEvent("gangZonesFunc.deleteGangzone", localPlayer, tonumber(data))
		end
	end
end

function createFunc.addNewSector()
	if not isElement(preview) then return exports.titan_noti:showBox("Najpierw wybierz opcję 'podgląd'.") end
	local x, y = getElementPosition(preview)
	local w, h = getRadarAreaSize(preview)
	local name = tostring(guiGetText(createGUI.edit2_5))
	triggerServerEvent("gangZonesFunc.create", localPlayer, x, y, w, h, name)
	createFunc.buttonCancel()
end

function createFunc.preview()
	if isElement(createGUI.okno2) then
		local X = guiGetText(createGUI.edit2_1)
		local Y = guiGetText(createGUI.edit2_2)
		local W = guiGetText(createGUI.edit2_3)
		local H = guiGetText(createGUI.edit2_4)
		if not tonumber(X) or not tonumber(Y) or not tonumber(W) or not tonumber(H) then return exports.titan_noti:showBox("Któraś ze współrzędynch została podana nieprawidłowo.") end
		X = tonumber(X)
		Y = tonumber(Y)
		W = tonumber(W)
		H = tonumber(H)
		if isElement(preview) then destroyElement(preview) end
		preview = createRadarArea(X, Y, W, H)
		setRadarAreaColor(preview, 255, 0, 0, 255)
	end
end

function createFunc.close()
	if isElement(createGUI.okno1) then destroyElement(createGUI.okno1) end
	if isElement(createGUI.okno2) then destroyElement(createGUI.okno2) end
	if isElement(preview) then destroyElement(preview) end
	exports.titan_cursor:hideCustomCursor("gangZonesCreate")
	if isElement(window) then destroyElement(window) end
end

function createFunc.cmd()
	if toggle then
		createFunc.close()
	else
		createFunc.create()
	end
	toggle = not toggle
end
addCommandHandler("sector", createFunc.cmd)