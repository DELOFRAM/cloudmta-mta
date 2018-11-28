local courierFunc = {}
local couriersFunc = {}

function courierFunc.guiCreate(data)
	local sW, sH = guiGetScreenSize()
	courierFunc.guiDestroy()
	courierFunc.window = guiCreateWindow(sW / 2 - 386 / 2, sH / 2 - 378 / 2, 386, 378, "Lista dostępnych zamówień", false)
	guiWindowSetSizable(courierFunc.window, false)
	courierFunc.list = guiCreateGridList(10, 27, 366, 282, false, courierFunc.window)
	courierFunc.cancel = guiCreateButton(10, 319, 366, 49, "Zamknij", false, courierFunc.window)
	guiGridListAddColumn(courierFunc.list, "Nazwa", 0.6)
	guiGridListAddColumn(courierFunc.list, "Stan", 0.3)
	addEventHandler("onClientGUIClick", courierFunc.cancel, courierFunc.guiDestroy, false)
	addEventHandler("onClientGUIDoubleClick", courierFunc.list, courierFunc.listClick, false)
	exports.titan_cursor:showCustomCursor("courierFunc")

	if type(data) == "table" then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(courierFunc.list)
			guiGridListSetItemText(courierFunc.list, row, 1, v.name, false, false)
			if v.status == 1 then
				guiGridListSetItemText(courierFunc.list, row, 2, "Poza magazynem", false, false)
				guiGridListSetItemColor(courierFunc.list, row, 1, 255, 204, 0)
				guiGridListSetItemColor(courierFunc.list, row, 2, 255, 204, 0)
			elseif v.status == 2 then
				guiGridListSetItemText(courierFunc.list, row, 2, "W doręczeniu", false, false)
				guiGridListSetItemColor(courierFunc.list, row, 1, 255, 0, 0)
				guiGridListSetItemColor(courierFunc.list, row, 2, 255, 0, 0)
			else
				guiGridListSetItemText(courierFunc.list, row, 2, "Oczekująca", false, false)
			end
			guiGridListSetItemData(courierFunc.list, row, 1, v.ID)
			guiGridListSetItemData(courierFunc.list, row, 2, v.status)
		end
	end
end
addEvent("courierFunc.guiCreate", true)
addEventHandler("courierFunc.guiCreate", root, courierFunc.guiCreate)

function courierFunc.guiDestroy()
	if isElement(courierFunc.window) then destroyElement(courierFunc.window) end
	exports.titan_cursor:hideCustomCursor("courierFunc")
end
addEvent("courierFunc.guiDestroy", true)
addEventHandler("courierFunc.guiDestroy", root, courierFunc.guiDestroy)

function courierFunc.listClick()
	if not guiGetEnabled(courierFunc.cancel) then return end
	local row = guiGridListGetSelectedItem(courierFunc.list)
	if not row or row == -1 then return end
	local ID = guiGridListGetItemData(courierFunc.list, row, 1)
	local status = guiGridListGetItemData(courierFunc.list, row, 2)
	if status == 1 then return exports.titan_noti:showBox("Paczka została już odebrana z magazynu.") end
	if status == 2 then return exports.titan_noti:showBox("Paczka jest już w doręczeniu przez innego kuriera.") end
	triggerServerEvent("courierFunc.choosePackagePlayer", resourceRoot, localPlayer, ID)
	guiSetText(courierFunc.cancel, "Poczekaj...")
	guiSetEnabled(courierFunc.cancel, false)
end

function couriersFunc.guiCreate(data)
	couriersFunc.guiDestroy()
	local sW, sH = guiGetScreenSize()
	couriersFunc.window = guiCreateWindow(sW / 2 - 354 / 2, sH / 2 - 364 / 2, 354, 364, "Paczki w aucie", false)
	couriersFunc.list = guiCreateGridList(10, 24, 334, 279, false, couriersFunc.window)
	couriersFunc.close = guiCreateButton(10, 313, 165, 41, "Zamknij", false, couriersFunc.window)
	couriersFunc.take = guiCreateButton(178, 313, 334, 41, "Weź paczkę", false, couriersFunc.window)
	guiWindowSetSizable(couriersFunc.window, false)
	guiGridListAddColumn(couriersFunc.list, "Nazwa", 0.9)
	addEventHandler("onClientGUIClick", couriersFunc.close, couriersFunc.guiDestroy, false)
	addEventHandler("onClientGUIClick", couriersFunc.take, couriersFunc.guiTake, false)
	addEventHandler("onClientGUIDoubleClick", couriersFunc.list, couriersFunc.guiChoose, false)
	exports.titan_cursor:showCustomCursor("couriersFunc")
	couriersFunc.guiRefresh(data)
end
addEvent("couriersFunc.guiCreate", true)
addEventHandler("couriersFunc.guiCreate", root, couriersFunc.guiCreate)

function couriersFunc.guiRefresh(data)
	if not isElement(couriersFunc.window) then return end
	guiGridListClear(couriersFunc.list)
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(couriersFunc.list)
		guiGridListSetItemText(couriersFunc.list, row, 1, v.name, false, false)
		guiGridListSetItemData(couriersFunc.list, row, 1, {k, v})
		if v.state then
			guiGridListSetItemColor(couriersFunc.list, row, 1, 0, 255, 0)
		end
	end
end
addEvent("couriersFunc.guiRefresh", true)
addEventHandler("couriersFunc.guiRefresh", root, couriersFunc.guiRefresh)

function couriersFunc.guiDestroy()
	if isElement(couriersFunc.window) then destroyElement(couriersFunc.window) end
	exports.titan_cursor:hideCustomCursor("couriersFunc")
end

function couriersFunc.guiChoose()
	local row = guiGridListGetSelectedItem(couriersFunc.list)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(couriersFunc.list, row, 1)
	triggerServerEvent("courierFunc.choosePackage", resourceRoot, localPlayer, data[2].ID)
end

function couriersFunc.guiTake()
	local row = guiGridListGetSelectedItem(couriersFunc.list)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(couriersFunc.list, row, 1)
	if not data[2].state then return exports.titan_noti:showBox("Najpierw zaznacz paczkę poprzez dwukrotne nacisnięcie na jej nazwę na liście.") end
	triggerServerEvent("courierFunc.takePackage", resourceRoot, localPlayer, data[2].ID)
end