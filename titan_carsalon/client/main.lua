----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local carSalonFunc = {}

function carSalonFunc.guiCreate(data)
	local sW, sH = guiGetScreenSize()
	carSalonFunc.window = guiCreateWindow(sW / 2 - 404 / 2, sH / 2 - 436 / 2, 404, 436, "Salon samochodowy", false)
	guiWindowSetSizable(carSalonFunc.window, false)

	carSalonFunc.list = guiCreateGridList(10, 27, 384, 349, false, carSalonFunc.window)
	carSalonFunc.button = guiCreateButton(10, 381, 384, 45, "Zamknij", false, carSalonFunc.window)

	guiGridListAddColumn(carSalonFunc.list, "Nazwa pojazdu", 0.7)
	guiGridListAddColumn(carSalonFunc.list, "Cena (w $)", 0.2)

	addEventHandler("onClientGUIClick", carSalonFunc.button, carSalonFunc.guiButton, false)
	addEventHandler("onClientGUIDoubleClick", carSalonFunc.list, carSalonFunc.doubleClick, false)

	exports.titan_cursor:showCustomCursor("carsalonMain")

	if type(data) == "table" then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(carSalonFunc.list)
			guiGridListSetItemText(carSalonFunc.list, row, 1, v.name, true, false)
			for key, value in ipairs(v.vehicles) do
				local row = guiGridListAddRow(carSalonFunc.list)
				guiGridListSetItemText(carSalonFunc.list, row, 1, value.name, false, false)
				guiGridListSetItemText(carSalonFunc.list, row, 2, value.price, false, false)
				guiGridListSetItemData(carSalonFunc.list, row, 1, value.ID)
			end
		end
	end
end
addEvent("carSalonFunc.guiCreate", true)
addEventHandler("carSalonFunc.guiCreate", root, carSalonFunc.guiCreate)

function carSalonFunc.doubleClick()
	local row = guiGridListGetSelectedItem(carSalonFunc.list)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(carSalonFunc.list, row, 1)
	if tonumber(data) then
		carSalonFunc.guiButton()
		triggerServerEvent("carSalonFunc.responsePlayer", resourceRoot, localPlayer, tonumber(data))
	end
end

function carSalonFunc.guiButton()
	if isElement(carSalonFunc.window) then destroyElement(carSalonFunc.window) end
	exports.titan_cursor:hideCustomCursor("carsalonMain")
end