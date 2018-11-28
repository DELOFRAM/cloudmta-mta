----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

functions = {}
data = {}

components = {}
components["wheels"] =
{
	[1] = {"Lewe przednie koło", "wheel_lp", 0},
	[2] = {"Prawe przednie koło", "wheel_rp", 2},
	[3] = {"Lewe tylne koło", "wheel_lt", 1},
	[4] = {"Prawe tylne koło", "wheel_rt", 3}
}
components["doors"] =
{
	[1] = {"Lewe przednie drzwi", "door_lp", 2},
	[2] = {"Prawe przednie drzwi", "door_rp", 3},
	[3] = {"Lewe tylne drzwi", "door_lt", 4},
	[4] = {"Prawe tylne drzwi", "door_rt", 5},

	[5] = {"Maska", "mask", 0},
	[6] = {"Klapa bagażnika", "trunk", 1}
}
components["panels"] =
{
	[1] = {"Lewy przedni panel", "panel_lp", 0},
	[2] = {"Prawy przedni panel", "panel_rp", 1},
	[3] = {"Lewy Tylny panel", "panel_lt", 2},
	[4] = {"Lewy Tylny panel", "panel_rt", 3},
	[5] = {"Szyba samochodowa", "windscreen", 4},
	[6] = {"Przedni zderzak", "bumper_p", 5},
	[7] = {"Tylny zderzak", "bumper_t", 6}
}
components["engine"] =
{
	[1] = {"Wymiana silnika", "engine"}
}
components["lights"] =
{
	[1] = {"Lewa przednia lampa", "light_lp", 0},
	[2] = {"Prawa przednia lampa", "light_rp", 1},
	[3] = {"Lewa tylna lampa", "light_lt", 2},
	[4] = {"Prawa tylna lampa", "light_rt", 3}
}

local sW, sH = guiGetScreenSize()

data.textPos =
{
	X = 280,
	Y = sH - 280,
	W = 580,
	H = sH - 80
}

function functions.render()
	dxDrawText("Aktualnie trwa naprawa: lewe tylne koło\nPozostały czas: 02:34", data.textPos.X, data.textPos.Y, data.textPos.W, data.textPos.H, tocolor(200, 200, 200, 255), 1.0, "default-bold")
end
--addEventHandler("onClientRender", root, functions.render)

function functions.guiMechanicShow()
	if isElement(data.guiWindow) then destroyElement(data.guiWindow) end
	data.guiWindow = guiCreateWindow(sW / 2 - 326 / 2, sH / 2 - 386 / 2, 326, 386, "Którą rzecz chcesz naprawić?", false)
	guiWindowSetSizable(data.guiWindow, false)

	data.guiList = guiCreateGridList(10, 30, 306, 301, false, data.guiWindow)
	data.guiButton = guiCreateButton(10, 338, 306, 38, "Anuluj", false, data.guiWindow)
	guiGridListSetSortingEnabled(data.guiList, false)
	guiGridListAddColumn(data.guiList, "Naprawiany komponent", 0.9)

	local row = guiGridListAddRow(data.guiList)
	guiGridListSetItemText(data.guiList, row, 1, "Koła", true, false)
	local wheelState = {}
	wheelState[0], wheelState[1], wheelState[2], wheelState[3] = getVehicleWheelStates(data.targetVeh)
	for k, v in ipairs(components["wheels"]) do
		local row = guiGridListAddRow(data.guiList)
		guiGridListSetItemText(data.guiList, row, 1, v[1], false, false)
		guiGridListSetItemData(data.guiList, row, 1, v[2])

		if wheelState[v[3]] ~= 0 then
			guiGridListSetItemColor(data.guiList, row, 1, 255, 0, 0)
		end
	end
	local row = guiGridListAddRow(data.guiList)
	guiGridListSetItemText(data.guiList, row, 1, "Drzwi", true, false)
	for k, v in ipairs(components["doors"]) do
		local row = guiGridListAddRow(data.guiList)
		guiGridListSetItemText(data.guiList, row, 1, v[1], false, false)
		guiGridListSetItemData(data.guiList, row, 1, v[2])

		if getVehicleDoorState(data.targetVeh, v[3]) ~= 0 then
			guiGridListSetItemColor(data.guiList, row, 1, 255, 0, 0)
		end
	end
	local row = guiGridListAddRow(data.guiList)
	guiGridListSetItemText(data.guiList, row, 1, "Panele", true, false)
	for k, v in ipairs(components["panels"]) do
		local row = guiGridListAddRow(data.guiList)
		guiGridListSetItemText(data.guiList, row, 1, v[1], false, false)
		guiGridListSetItemData(data.guiList, row, 1, v[2])

		if getVehiclePanelState(data.targetVeh, v[3]) ~= 0 then
			guiGridListSetItemColor(data.guiList, row, 1, 255, 0, 0)
		end
	end
	local row = guiGridListAddRow(data.guiList)
	guiGridListSetItemText(data.guiList, row, 1, "Lampy", true, false)
	for k, v in ipairs(components["lights"]) do
		local row = guiGridListAddRow(data.guiList)
		guiGridListSetItemText(data.guiList, row, 1, v[1], false, false)
		guiGridListSetItemData(data.guiList, row, 1, v[2])

		if getVehicleLightState(data.targetVeh, v[3]) ~= 0 then
			guiGridListSetItemColor(data.guiList, row, 1, 255, 0, 0)
		end
	end
	local row = guiGridListAddRow(data.guiList)
	guiGridListSetItemText(data.guiList, row, 1, "Silnik", true, false)
	local health = getElementHealth(data.targetVeh)
	for k, v in ipairs(components["engine"]) do
		local row = guiGridListAddRow(data.guiList)
		guiGridListSetItemText(data.guiList, row, 1, v[1]..string.format(" (%0.2f)", health), false, false)
		guiGridListSetItemData(data.guiList, row, 1, v[2])
		if health < 1000 then
			guiGridListSetItemColor(data.guiList, row, 1, 255, 0, 0)
		end
	end

	exports.titan_cursor:showCustomCursor("mechanicClientMain")

	addEventHandler("onClientGUIClick", data.guiButton, functions.guiMechanicHide, false)
	addEventHandler("onClientGUIDoubleClick", data.guiList, functions.onDoubleClick, false)
end

function functions.guiMechanicHide()
	if isElement(data.guiWindow) then destroyElement(data.guiWindow) end
	exports.titan_cursor:hideCustomCursor("mechanicClientMain")
	data.mechanicTarget = nil
	data.targetVeh = nil
	data.mechanicPrice = nil
end

function functions.onDoubleClick()
	local row = guiGridListGetSelectedItem(data.guiList)
	if not row or row == -1 then return end
	local componentName = guiGridListGetItemData(data.guiList, row, 1)
	if componentName then
		triggerServerEvent("functions.clientEvent", localPlayer, data.mechanicTarget, componentName, data.mechanicPrice)
		functions.guiMechanicHide()
		return
	end
end

function functions.mechanicEvent(target, price)
	data.mechanicTarget = target
	data.mechanicPrice = price
	data.targetVeh = getPedOccupiedVehicle(target)
	functions.guiMechanicShow()
end
addEvent("functions.mechanicEvent", true)
addEventHandler("functions.mechanicEvent", root, functions.mechanicEvent)

local time = getTickCount()

--function functions.renderStatus()
--	local progress2 = (getTickCount() - time) / 60000
--	local progress = interpolateBetween(0, 0, 0, 1, 0, 0, progress2, "Linear") 
--	dxDrawImageSection(sW / 2 - 151, 128, 303 * progress, 8, 0, 0, 303 * progress, 8, "client/files/status.png", 0, 0, 0, tocolor(255, 255, 255, 255))
--	--dxDrawImage(sW / 2 - 151, 128, 303, 8, "client/files/status.png")
--	dxDrawImage(sW / 2 - 160, 120, 320, 24, "client/files/status_obrys.png")
--end
--addEventHandler("onClientRender", root, functions.renderStatus)

