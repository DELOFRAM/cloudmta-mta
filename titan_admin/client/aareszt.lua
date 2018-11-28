----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local aresztData = {}
local sW, sH = guiGetScreenSize()
local window
function aresztData.create()
	if aresztData.showing == true then return end
	aresztData.okno = guiCreateWindow(sW / 2 - 418 / 2, sH / 2 - 167 / 2, 418, 167, "Tworzenie celi", false)
	guiWindowSetSizable(aresztData.okno, false)

	aresztData.opis = guiCreateLabel(10, 24, 398, 30, "Tutaj możesz stworzyć nową celę! Zostanie ona stworzona w miejscu, gdzie stoi Twoja postać. Posiadać będzie nazwę, którą podasz poniżej.", false, aresztData.okno)
	guiSetFont(aresztData.opis, "default-bold-small")
	guiLabelSetHorizontalAlign(aresztData.opis, "center", true)
	aresztData.input = guiCreateEdit(10, 64, 398, 36, "", false, aresztData.okno)
	aresztData.save = guiCreateButton(311, 110, 97, 47, "Stwórz celę", false, aresztData.okno)
	aresztData.cancel = guiCreateButton(223, 129, 78, 28, "Anuluj", false, aresztData.okno)

	exports.titan_cursor:showCustomCursor("adminAreszt")
	aresztData.showing = true
	
	addEventHandler("onClientGUIClick", aresztData.cancel, aresztData.delete, false)
	addEventHandler("onClientGUIClick", aresztData.save, aresztData.createNew)
end
addEvent("aresztData.create", true)
addEventHandler("aresztData.create", root, aresztData.create)

function aresztData.delete()
	if isElement(aresztData.okno) then destroyElement(aresztData.okno) end
	exports.titan_cursor:hideCustomCursor("adminAreszt")
	aresztData.showing = false
end

function aresztData.createNew()
	local text = guiGetText(aresztData.input)
	if not text or string.len(tostring(text)) < 4 then
		exports.titan_noti:showBox("Nazwa celi musi zawierać przynajmniej 4 znaki.")
		return
	end
	triggerServerEvent("createNewArrest", localPlayer, tostring(text))
	aresztData.delete()
end

-- GUI2

function aresztData.create2(data)
	if aresztData.showing2 == true then return end
	aresztData.okno2 = guiCreateWindow(sW / 2 - 313 / 2, sH / 2 - 328 / 2, 313, 328, "Lista cel w pomieszczeniu", false)
	guiWindowSetSizable(aresztData.okno2, false)

	aresztData.lista2 = guiCreateGridList(10, 24, 293, 248, false, aresztData.okno2)
	guiGridListAddColumn(aresztData.lista2, "Nazwa celi", 0.45)
	guiGridListAddColumn(aresztData.lista2, "Odległość", 0.45)
	aresztData.removeItem = guiCreateButton(10, 277, 148, 41, "Usuń", false, aresztData.okno2)
	aresztData.cancel2 = guiCreateButton(155, 277, 148, 41, "Zamknij", false, aresztData.okno2)

	exports.titan_cursor:showCustomCursor("adminAreszt2")
	
	addEventHandler("onClientGUIClick", aresztData.cancel2, aresztData.delete2, false)
	addEventHandler("onClientGUIClick", aresztData.removeItem, aresztData.remove2)
	local x, y, z = getElementPosition(localPlayer)
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(aresztData.lista2)
		local dist = math.floor(getDistanceBetweenPoints3D(x, y, z, v.x, v.y, v.z))
		guiGridListSetItemText(aresztData.lista2, row, 1, v.name, false, false)
		guiGridListSetItemText(aresztData.lista2, row, 2, dist, false, true)
		guiGridListSetItemData(aresztData.lista2, row, 1, v.ID)
	end
	aresztData.showing2 = true
end
addEvent("aresztData.create2", true)
addEventHandler("aresztData.create2", root, aresztData.create2)

function aresztData.delete2()
	if isElement(aresztData.okno2) then destroyElement(aresztData.okno2) end
	exports.titan_cursor:hideCustomCursor("adminAreszt2")
	aresztData.showing2 = false
end

function aresztData.remove2()
	local row = guiGridListGetSelectedItem(aresztData.lista2)
	if not row or row == - 1 then return end
	local ID = guiGridListGetItemData(aresztData.lista2, row, 1)
	if tonumber(ID) then
		ID = tonumber(ID)
		triggerServerEvent("removeArrest", localPlayer, ID)
		aresztData.delete2()
	end
end