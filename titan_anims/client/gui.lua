----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local animGui = {}

function animGui.create(data)
	animGui.destroy()
	local sW, sH = guiGetScreenSize()
	animGui.window = guiCreateWindow(sW / 2 - 340 / 2, sH / 2 - 330 / 2, 340, 330, "Lista animacji", false)
	guiWindowSetSizable(animGui.window, false)
	animGui.lista = guiCreateGridList(10, 29, 320, 240, false, animGui.window)
	guiGridListAddColumn(animGui.lista, "Nazwa animacji", 0.9)
	animGui.cancel = guiCreateButton(10, 279, 320, 41, "Zamknij", false, animGui.window)
	addEventHandler("onClientGUIClick", animGui.cancel, animGui.destroy, false)
	addEventHandler("onClientGUIDoubleClick", animGui.lista, animGui.click, false)
	exports.titan_cursor:showCustomCursor("animsGUI")

	if #data > 0 then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(animGui.lista)
			guiGridListSetItemText(animGui.lista, row, 1, "."..v.name, false, false)
			guiGridListSetItemData(animGui.lista, row, 1, v.name)
		end
	end
end
addEvent("animGui.create", true)
addEventHandler("animGui.create", root, animGui.create)

function animGui.destroy()
	if isElement(animGui.window) then destroyElement(animGui.window) end
	exports.titan_cursor:hideCustomCursor("animsGUI")
end

function animGui.click()
	local row = guiGridListGetSelectedItem(animGui.lista)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(animGui.lista, row, 1)
	if data then
		return triggerServerEvent("playerStartAnim", localPlayer, localPlayer, tostring(data))
	end
end