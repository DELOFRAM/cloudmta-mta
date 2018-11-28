----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local adminReport = {}
local sW, sH = guiGetScreenSize()

local reportsData = {}

function adminReport.create(data)
	adminReport.okno1 = guiCreateWindow(sW / 2 - 348 / 2, sH / 2 - 361 / 2, 348, 361, "Aktywne raporty - System raportów", false)
	adminReport.lista = guiCreateGridList(10, 27, 328, 284, false, adminReport.okno1)
	adminReport.zamknij = guiCreateButton(10, 321, 328, 30, "Zamknij", false, adminReport.okno1)

	adminReport.okno2 = guiCreateWindow(sW / 2 + 348 / 2 + 10, sH / 2 - 361 / 2, 359, 361, "Podgląd raportu - System raportów", false)
	adminReport.label1 = guiCreateLabel(10, 29, 65, 18, "Kategoria:", false, adminReport.okno2)
	adminReport.label2 = guiCreateLabel(10, 47, 339, 18, "", false, adminReport.okno2)
	adminReport.label3 = guiCreateLabel(10, 75, 75, 18, "Zgłaszający", false, adminReport.okno2)
	adminReport.label4 = guiCreateLabel(10, 139, 339, 18, "", false, adminReport.okno2)
	adminReport.label5 = guiCreateLabel(10, 121, 75, 18, "Zgłaszany", false, adminReport.okno2)
	adminReport.label6 = guiCreateLabel(10, 93, 339, 18, "", false, adminReport.okno2)
	adminReport.label7 = guiCreateLabel(10, 167, 75, 18, "Treść", false, adminReport.okno2)
	adminReport.memo1 = guiCreateMemo(10, 185, 339, 166, "", false, adminReport.okno2)
	adminReport.button2 = guiCreateButton(214, 147, 135, 28, "Odbierz zgłoszenie", false, adminReport.okno2)

	guiGridListAddColumn(adminReport.lista, "Dodał", 0.45)
	guiGridListAddColumn(adminReport.lista, "Czas", 0.45)

	guiWindowSetSizable(adminReport.okno1, false)
	guiWindowSetSizable(adminReport.okno2, false)

	guiWindowSetMovable(adminReport.okno1, false)
	guiWindowSetMovable(adminReport.okno2, false)

	guiSetFont(adminReport.label1, "default-bold-small")
	guiSetFont(adminReport.label3, "default-bold-small")
	guiSetFont(adminReport.label5, "default-bold-small")
	guiSetFont(adminReport.label7, "default-bold-small")
	guiMemoSetReadOnly(adminReport.memo1, true)

	guiSetText(adminReport.label2, "")
	guiSetText(adminReport.label4, "")
	guiSetText(adminReport.label6, "")
	guiSetText(adminReport.memo1, "")
	guiSetEnabled(adminReport.button2, false)

	reportsData = data

	for k, v in ipairs(data) do
		local data = getRealTime(v.date)
		local row = guiGridListAddRow(adminReport.lista)
		guiGridListSetItemText(adminReport.lista, row, 1, v.senderName, false, false)
		guiGridListSetItemData(adminReport.lista, row, 1, v.id)
		guiGridListSetItemText(adminReport.lista, row, 2, string.format("%0.2d:%0.2d %0.2d.%0.2d", data.hour, data.minute, data.monthday, data.month + 1), false, false)
	end

	addEventHandler("onClientGUIClick", adminReport.zamknij, adminReport.delete, false)
	addEventHandler("onClientGUIClick", adminReport.button2, adminReport.claim, false)
	addEventHandler("onClientGUIClick", adminReport.lista, adminReport.changeVars, false)

	exports.titan_cursor:showCustomCursor("reportsClientAdmin")
end
addEvent("adminReport.create", true)
addEventHandler("adminReport.create", root, adminReport.create)

function adminReport.changeVars()
	local row = guiGridListGetSelectedItem(adminReport.lista)
	if not row or row == -1 then
		guiSetText(adminReport.label2, "")
		guiSetText(adminReport.label4, "")
		guiSetText(adminReport.label6, "")
		guiSetText(adminReport.memo1, "")
		guiSetEnabled(adminReport.button2, false)
	else
		local rData = reportsData[guiGridListGetItemData(adminReport.lista, row, 1)]
		if rData then
			guiSetText(adminReport.label2, rData.cat)
			guiSetText(adminReport.label4, rData.targetName)
			guiSetText(adminReport.label6, rData.senderName)
			guiSetText(adminReport.memo1, rData.desc)
			guiSetEnabled(adminReport.button2, true)
		end
	end
end


function adminReport.delete()
	if isElement(adminReport.okno1) then destroyElement(adminReport.okno1) end
	if isElement(adminReport.okno2) then destroyElement(adminReport.okno2) end
	exports.titan_cursor:hideCustomCursor("reportsClientAdmin")
	reportsData = {}
end

function adminReport.claim()
	local row = guiGridListGetSelectedItem(adminReport.lista)
	if not row or row == -1 then return end
	local rData = reportsData[guiGridListGetItemData(adminReport.lista, row, 1)]
	if rData then
		triggerServerEvent("reportFunc.adminClaimReport", localPlayer, rData.id)
		adminReport.delete()
	end
end