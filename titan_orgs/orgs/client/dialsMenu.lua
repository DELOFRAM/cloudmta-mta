------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-09 15:29:12

local reportsGroup = {}
local sW, sH = guiGetScreenSize()

function reportsGroup.funcCreate(data, groupID)
	if isElement(reportsGroup.okno) then destroyElement(reportsGroup.okno) end
	reportsGroup.okno = guiCreateWindow(sW / 2 - 616 / 2, sH / 2 - 349 / 2, 616, 349, "Zgłoszenia 911", false)
	guiWindowSetSizable(reportsGroup.okno, false)

	reportsGroup.lista = guiCreateGridList(10, 28, 596, 131, false, reportsGroup.okno)
	guiGridListAddColumn(reportsGroup.lista, "Imię i nazwisko", 0.2)
	guiGridListAddColumn(reportsGroup.lista, "Telefon", 0.1)
	guiGridListAddColumn(reportsGroup.lista, "Czas", 0.13)
	guiGridListAddColumn(reportsGroup.lista, "Departamenty", 0.34)
	guiGridListAddColumn(reportsGroup.lista, "Lokalizacja", 0.2)
	reportsGroup.memo = guiCreateMemo(10, 165, 596, 121, "", false, reportsGroup.okno)
	reportsGroup.button = guiCreateButton(254, 296, 111, 38, "Przyjmij/zakoncz zgłoszenie", false, reportsGroup.okno)
	reportsGroup.close = guiCreateButton(495, 296, 111, 38, "Zamknij panel", false, reportsGroup.okno)

	guiMemoSetReadOnly(reportsGroup.memo, true)

	addEventHandler("onClientGUIClick", reportsGroup.close, reportsGroup.funcClose, false)
	addEventHandler("onClientGUIClick", reportsGroup.button, reportsGroup.funcButton, false)
	addEventHandler("onClientGUIClick", reportsGroup.lista, reportsGroup.funcListClick, false)

	exports.titan_cursor:showCustomCursor("orgsClientDialsMenu")

	reportsGroup.funcRefreshData(data)
	localPlayer:setData("guiOpen:zgloszenia", true)
end
addEvent("reportsGroup.funcCreate", true)
addEventHandler("reportsGroup.funcCreate", root, reportsGroup.funcCreate)

function reportsGroup.funcClose()
	if isElement(reportsGroup.okno) then destroyElement(reportsGroup.okno) end
	exports.titan_cursor:hideCustomCursor("orgsClientDialsMenu")
	localPlayer:setData("guiOpen:zgloszenia", false)
end

function reportsGroup.funcListClick()
	local row = guiGridListGetSelectedItem(reportsGroup.lista)
	if not row or row == -1 then return guiSetText(reportsGroup.memo, "") end
	local data = guiGridListGetItemData(reportsGroup.lista, row, 1)
	if type(data) == "table" then
		guiSetText(reportsGroup.memo, data.text)
	end
end

function reportsGroup.funcButton()
	local row = guiGridListGetSelectedItem(reportsGroup.lista)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(reportsGroup.lista, row, 1)
	if type(data) == "table" then
		return triggerServerEvent("toggleDialStatus", localPlayer, data.index)
	end
end

function reportsGroup.funcRefreshData(data, groupID)
	if not isElement(reportsGroup.okno) then return end
	guiGridListClear(reportsGroup.lista)
	for k, v in ipairs(data) do
		local time = getRealTime(v.time)
		local row = guiGridListAddRow(reportsGroup.lista)
		local groups = ""
		local accepted = false
		for k1, v1 in ipairs(v.groups) do
			groups = string.format("%s %s%s", groups, v1.tag, isElement(v1.stateElement) and "(✔)" or "(x)")
			if isElement(v1.stateElement) and v1.stateElement == localPlayer then accepted = true end
		end
		guiGridListSetItemText(reportsGroup.lista, row, 1, v.name, false, false)
		guiGridListSetItemText(reportsGroup.lista, row, 2, v.phone, false, false)
		guiGridListSetItemText(reportsGroup.lista, row, 3, string.format("%0.2d:%0.2d:%0.2d", time.hour, time.minute, time.second), false, false)
		guiGridListSetItemText(reportsGroup.lista, row, 4, groups, false, false)
		guiGridListSetItemText(reportsGroup.lista, row, 5, v.zone, false, false)
		guiGridListSetItemData(reportsGroup.lista, row, 1, v)
		if accepted then
			guiGridListSetItemColor(reportsGroup.lista, row, 1, 0, 255, 0)
			guiGridListSetItemColor(reportsGroup.lista, row, 2, 0, 255, 0)
			guiGridListSetItemColor(reportsGroup.lista, row, 3, 0, 255, 0)
			guiGridListSetItemColor(reportsGroup.lista, row, 4, 0, 255, 0)
			guiGridListSetItemColor(reportsGroup.lista, row, 5, 0, 255, 0)
		end
	end
end
addEvent("reportsGroup.funcRefreshData", true)
addEventHandler("reportsGroup.funcRefreshData", root, reportsGroup.funcRefreshData)