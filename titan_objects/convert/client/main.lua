----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local convertFunc = {}
local sConvertFunc = {}
convertFunc.objectsData = {}
convertFunc.doorID = nil

function convertFunc.create(door)
	convertFunc.destroy()
	local sW, sH = guiGetScreenSize()
	convertFunc.window = guiCreateWindow(sW / 2 - 537 / 2, sH / 2 - 580 / 2, 537, 580, "Wczytywanie obiektów", false)
	guiWindowSetSizable(convertFunc.window, false)

	convertFunc.doorID = door

	convertFunc.label = guiCreateLabel(10, 26, 517, 49, "Wklej tutaj swój kod .xml z edytora obiektów MTA, aby wkleić je do swojego interioru.", false, convertFunc.window)
	convertFunc.memo = guiCreateMemo(10, 85, 517, 401, "", false, convertFunc.window)
	convertFunc.load = guiCreateButton(10, 496, 517, 28, "Wczytaj", false, convertFunc.window)
	convertFunc.cancel = guiCreateButton(10, 534, 517, 36, "Zamknij", false, convertFunc.window)

	addEventHandler("onClientGUIClick", convertFunc.cancel, convertFunc.destroy, false)
	addEventHandler("onClientGUIClick", convertFunc.load, convertFunc.onLoad, false)

	exports.titan_cursor:showCustomCursor("objectsConvert")
end
addEvent("convertFunc.create", true)
addEventHandler("convertFunc.create", root, convertFunc.create)

function convertFunc.destroy()
	if isElement(convertFunc.window) then destroyElement(convertFunc.window) end
	exports.titan_cursor:hideCustomCursor("objectsConvert")
	if isElement(window) then destroyElement(window) end
	if fileExists("tmp.xml") then fileDelete("tmp.xml") end
end

function convertFunc.onLoad()
	convertFunc.objectsData = {}
	guiSetEnabled(convertFunc.load, false)
	local memoText = guiGetText(convertFunc.memo)
	if fileExists("tmp.xml") then fileDelete("tmp.xml") end
	local file = fileCreate("tmp.xml")
	file:write(memoText)
	file:close()
	outputChatBox("Zapis tymczasowego pliku zakończony...", 0, 255, 0)
	local xmlFile = xmlLoadFile("tmp.xml")
	if not xmlFile then return outputChatBox("Nie udało się załadować poprawnie pliku XML.", 255, 0, 0) end
	outputChatBox("Wczytywanie pliku XML zakończone...", 0, 255, 0)
	local xmlNode = xmlNodeGetChildren(xmlFile)
	if not xmlNode then return outputChatBox("Nie udało się załadować poprawnie childrenów xmlNode.", 255, 0, 0) end
	for k, v in pairs(xmlNode) do
		if xmlNodeGetName(v) == "object" or xmlNodeGetName(v) == "pickup" then
			local posX = xmlNodeGetAttribute(v, "posX")
			local posY = xmlNodeGetAttribute(v, "posY")
			local posZ = xmlNodeGetAttribute(v, "posZ")
			local rotX = xmlNodeGetAttribute(v, "rotX")
			local rotY = xmlNodeGetAttribute(v, "rotY")
			local rotZ = xmlNodeGetAttribute(v, "rotZ")
			local interior = xmlNodeGetAttribute(v, "interior")
			local modelID = xmlNodeGetName(v) == "object" and xmlNodeGetAttribute(v, "model") or xmlNodeGetAttribute(v, "type")
			local tmpTable = 
			{
				typ = xmlNodeGetName(v) == "object" and "model" or "pickup",
				x = posX,
				y = posY,
				z = posZ,
				rx = rotX,
				ry = rotY,
				rz = rotZ,
				model = modelID,
				int = interior
			}
			if xmlNodeGetName(v) == "pickup" then tmpTable.checked = false end
			table.insert(convertFunc.objectsData, tmpTable)
			--outputChatBox(string.format("Object model: %d, pos: {%d, %d, %d}. rot: {%d, %d, %d}", modelID, posX, posY, posZ, rotX, rotY, rotZ))
		end
	end
	guiSetEnabled(convertFunc.load, true)
	if convertFunc.countObjects() <= 0 then return exports.titan_noti:showBox("System nie znalazł żadnych obiektów.") end
	if convertFunc.countPickups() <= 0 then return exports.titan_noti:showBox("System nie znalazł żadnych pickupów.") end
	convertFunc.destroy()
	sConvertFunc.create()
end
--convertFunc.create()


function convertFunc.countObjects()
	local i = 0
	for k, v in ipairs(convertFunc.objectsData) do if v.typ == "model" then i = i + 1 end end
	return i
end

function convertFunc.countPickups()
	local i = 0
	for k, v in ipairs(convertFunc.objectsData) do if v.typ == "pickup" then i = i + 1 end end
	return i
end

function sConvertFunc.create()
	sConvertFunc.destroy()
	local sW, sH = guiGetScreenSize()
	sConvertFunc.window = guiCreateWindow(sW / 2 - 562 / 2, sH / 2 - 413 / 2, 562, 413, "Wczytywanie obiektów", false)
	guiWindowSetSizable(sConvertFunc.window, false)

	sConvertFunc.listObjects = guiCreateGridList(10, 28, 264, 273, false, sConvertFunc.window)
	sConvertFunc.listPickups = guiCreateGridList(284, 28, 264, 273, false, sConvertFunc.window)
	sConvertFunc.label = guiCreateLabel(10, 311, 538, 49, "Po lewej stronie widzisz wszystkie obiekty, które zostały rozpoznane przez system. Po prawej pojawia się lista wszystkich pickupów, które zostały rozpoznane. Musisz wybrać jeden z nich, aby system mógł użyć jego pozycji do ustalenia wyjścia z interioru.", false, sConvertFunc.window)
	sConvertFunc.buttonSave = guiCreateButton(95, 365, 179, 38, "Wczytaj", false, sConvertFunc.window)
	sConvertFunc.buttonCancel = guiCreateButton(294, 360, 179, 38, "Anuluj", false, sConvertFunc.window)

	guiLabelSetHorizontalAlign(sConvertFunc.label, "left", true)

	guiGridListAddColumn(sConvertFunc.listObjects, "modelID", 0.3)
	guiGridListAddColumn(sConvertFunc.listObjects, "Pozycja", 0.6)

	guiGridListAddColumn(sConvertFunc.listPickups, "Typ", 0.3)
	guiGridListAddColumn(sConvertFunc.listPickups, "Pozycja", 0.6)

	sConvertFunc.refresh()

	addEventHandler("onClientGUIClick", sConvertFunc.buttonCancel, sConvertFunc.destroy, false)
	addEventHandler("onClientGUIClick", sConvertFunc.buttonSave, sConvertFunc.save, false)
	addEventHandler("onClientGUIDoubleClick", sConvertFunc.listPickups, sConvertFunc.onDoublePickupClick, false)
	exports.titan_cursor:showCustomCursor("objectsConvert2")
end

function sConvertFunc.refresh()
	guiGridListClear(sConvertFunc.listObjects)
	guiGridListClear(sConvertFunc.listPickups)
	for k, v in pairs(convertFunc.objectsData) do
		local row = guiGridListAddRow(v.typ == "model" and sConvertFunc.listObjects or sConvertFunc.listPickups)
		if v.typ == "model" then 
			guiGridListSetItemText(sConvertFunc.listObjects, row, 1, v.model, false, false)
			guiGridListSetItemText(sConvertFunc.listObjects, row, 2, string.format("X: %d, Y: %d, Z: %d", v.x, v.y, v.z), false, false)
			guiGridListSetItemData(sConvertFunc.listObjects, row, 1, k)
		else
			guiGridListSetItemText(sConvertFunc.listPickups, row, 1, v.model, false, false)
			guiGridListSetItemText(sConvertFunc.listPickups, row, 2, string.format("X: %d, Y: %d, Z: %d", v.x, v.y, v.z), false, false)
			guiGridListSetItemData(sConvertFunc.listPickups, row, 1, k)

			if v.checked then
				guiGridListSetItemColor(sConvertFunc.listPickups, row, 1, 0, 255, 0)
				guiGridListSetItemColor(sConvertFunc.listPickups, row, 2, 0, 255, 0)
			end
		end
	end
end

function sConvertFunc.destroy()
	if isElement(sConvertFunc.window) then destroyElement(sConvertFunc.window) end
	exports.titan_cursor:hideCustomCursor("objectsConvert2")
end
addEvent("sConvertFunc.destroy", true)
addEventHandler("sConvertFunc.destroy", root, sConvertFunc.destroy)

function sConvertFunc.save()
	guiSetEnabled(sConvertFunc.buttonCancel, false)
	guiSetEnabled(sConvertFunc.buttonSave, false)
	triggerServerEvent("loadObjects", resourceRoot, localPlayer, convertFunc.doorID, convertFunc.objectsData)
end

function sConvertFunc.onDoublePickupClick()
	local row = guiGridListGetSelectedItem(sConvertFunc.listPickups)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(sConvertFunc.listPickups, row, 1)
	if not tonumber(data) then return end
	for k, v in pairs(convertFunc.objectsData) do
		if v.typ == "pickup" then
			v.checked = false
			if k == data then v.checked = true end
		end
	end
	sConvertFunc.refresh()
end