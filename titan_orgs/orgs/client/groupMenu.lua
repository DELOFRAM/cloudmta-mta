----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local groupMenuGUI =
{
	manage = {}
}
local sW, sH = guiGetScreenSize()
function groupMenuGUI.createGUI(data)
	groupMenuGUI.removeGUI()
	groupMenuGUI.okno = guiCreateWindow(sW / 2 - 344 / 2, sH / 2 - 371 / 2, 344, 371, "Twoje grupy", false)
	groupMenuGUI.lista = guiCreateGridList(10, 29, 324, 286, false, groupMenuGUI.okno)
	groupMenuGUI.close = guiCreateButton(10, 325, 324, 36, "Zamknij", false, groupMenuGUI.okno)
	guiGridListAddColumn(groupMenuGUI.lista, "Slot", 0.1)
	guiGridListAddColumn(groupMenuGUI.lista, "Tag", 0.15)
	guiGridListAddColumn(groupMenuGUI.lista, "Nazwa", 0.65)
	guiWindowSetSizable(groupMenuGUI.okno, false)
	exports.titan_cursor:showCustomCursor("orgsClientGroupMenu")
	addEventHandler("onClientGUIClick", groupMenuGUI.close, groupMenuGUI.removeGUI, false)
	addEventHandler("onClientGUIDoubleClick", groupMenuGUI.lista, groupMenuGUI.selectGUI, false)

	if type(data) == "table" then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(groupMenuGUI.lista)
			guiGridListSetItemText(groupMenuGUI.lista, row, 1, v.slot, false, true)
			guiGridListSetItemText(groupMenuGUI.lista, row, 2, v.groupInfo.tag, false, false)
			guiGridListSetItemText(groupMenuGUI.lista, row, 3, v.groupInfo.name, false, false)
			guiGridListSetItemData(groupMenuGUI.lista, row, 1, v.groupInfo.ID)

			if v.duty then
				guiGridListSetItemColor(groupMenuGUI.lista, row, 1, 0, 255, 0)
				guiGridListSetItemColor(groupMenuGUI.lista, row, 2, 0, 255, 0)
				guiGridListSetItemColor(groupMenuGUI.lista, row, 3, 0, 255, 0)
			end
		end
	end
end
addEvent("groupMenuGUI.createGUI", true)
addEventHandler("groupMenuGUI.createGUI", root, groupMenuGUI.createGUI)

function groupMenuGUI.removeGUI()
	if isElement(groupMenuGUI.okno) then destroyElement(groupMenuGUI.okno) end
	exports.titan_cursor:hideCustomCursor("orgsClientGroupMenu")
end
function groupMenuGUI.selectGUI()
	local row = guiGridListGetSelectedItem(groupMenuGUI.lista)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(groupMenuGUI.lista, row, 1)
	if tonumber(data) then
		groupMenuGUI.removeGUI()
		triggerServerEvent("playerGuiFunc.show", localPlayer, tonumber(data))
		return
	end
end
function groupMenuGUI.manage.create(groupInfo, pGroupInfo, groupVehicles, groupPlayers)
	if isElement(groupMenuGUI.manage.okno) then destroyElement(groupMenuGUI.manage.okno) end
	groupMenuGUI.manage.groupID = groupInfo.ID
	groupMenuGUI.manage.pginfo = pGroupInfo
	-- OKNO
	groupMenuGUI.manage.okno = guiCreateWindow(sW / 2 - 462 / 2, sH / 2 - 389 / 2, 462, 389, "Podgląd grupy - "..groupInfo.name, false)
	guiWindowSetSizable(groupMenuGUI.manage.okno, false)
	groupMenuGUI.manage.zamknij = guiCreateButton(381, 347, 71, 32, "Zamknij", false, groupMenuGUI.manage.okno)
	groupMenuGUI.manage.tabpanel = guiCreateTabPanel(10, 22, 442, 315, false, groupMenuGUI.manage.okno)
	-- TAB1
	groupMenuGUI.manage.tab1 = guiCreateTab("Informacje", groupMenuGUI.manage.tabpanel)
	--groupMenuGUI.manage.label1 = guiCreateLabel(10, 10, 422, 160, string.format("ID grupy: %d\nTag: %s\nNazwa: %s\n\nRanga: %s\nWypłata: $500", groupInfo.ID, groupInfo.tag, groupInfo.name, pGroupInfo.name), false, groupMenuGUI.manage.tab1)
	--guiSetFont(groupMenuGUI.manage.label1, "default-bold-small")
	groupMenuGUI.manage.gridlistinfo = guiCreateGridList(10, 10, 422, 221, false, groupMenuGUI.manage.tab1)
	guiGridListAddColumn(groupMenuGUI.manage.gridlistinfo, "Argument", 0.45)
	guiGridListAddColumn(groupMenuGUI.manage.gridlistinfo, "Wartość", 0.45)
	groupMenuGUI.manage.duty = guiCreateButton(10, 242, 422, 38, pGroupInfo.duty and "Zejdź ze służby" or "Wejdź na służbę", false, groupMenuGUI.manage.tab1)
	-- TAB2
	groupMenuGUI.manage.tab2 = guiCreateTab("Pojazdy", groupMenuGUI.manage.tabpanel)
	groupMenuGUI.manage.label2 = guiCreateLabel(10, 10, 422, 26, "Pojazdy grupy", false, groupMenuGUI.manage.tab2)
	guiSetFont(groupMenuGUI.manage.label2, "default-bold-small")
	guiLabelSetHorizontalAlign(groupMenuGUI.manage.label2, "center", false)
	guiLabelSetVerticalAlign(groupMenuGUI.manage.label2, "center")
	groupMenuGUI.manage.gridlistpojazdy = guiCreateGridList(10, 36, 422, 245, false, groupMenuGUI.manage.tab2)
	guiGridListAddColumn(groupMenuGUI.manage.gridlistpojazdy, "ID", 0.2)
	guiGridListAddColumn(groupMenuGUI.manage.gridlistpojazdy, "Nazwa", 0.7)
	-- TAB3
	groupMenuGUI.manage.tab3 = guiCreateTab("Pracownicy", groupMenuGUI.manage.tabpanel)
	groupMenuGUI.label3 = guiCreateLabel(10, 10, 422, 26, "Pracownicy Online", false, groupMenuGUI.manage.tab3)
	guiSetFont(groupMenuGUI.label3, "default-bold-small")
	guiLabelSetHorizontalAlign(groupMenuGUI.label3, "center", false)
	guiLabelSetVerticalAlign(groupMenuGUI.label3, "center")
	groupMenuGUI.manage.gridlistpracownicy = guiCreateGridList(10, 36, 422, 245, false, groupMenuGUI.manage.tab3)
	guiGridListAddColumn(groupMenuGUI.manage.gridlistpracownicy, "ID", 0.2)
	guiGridListAddColumn(groupMenuGUI.manage.gridlistpracownicy, "Nazwa", 0.7)
	exports.titan_cursor:showCustomCursor("orgsClientGroupMenu2")
	addEventHandler("onClientGUIClick", groupMenuGUI.manage.zamknij, groupMenuGUI.manage.close, false)
	addEventHandler("onClientGUIClick", groupMenuGUI.manage.duty, groupMenuGUI.manage.dutyClick, false)

	guiGridListSetSortingEnabled(groupMenuGUI.manage.gridlistinfo, false)

	local row = guiGridListAddRow(groupMenuGUI.manage.gridlistinfo)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 1, "ID grupy", false, false)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 2, groupInfo.ID, false, false)
	guiGridListSetItemColor(groupMenuGUI.manage.gridlistinfo, row, 1, 180, 180, 180)

	local row = guiGridListAddRow(groupMenuGUI.manage.gridlistinfo)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 1, "Tag grupy", false, false)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 2, groupInfo.tag, false, false)
	guiGridListSetItemColor(groupMenuGUI.manage.gridlistinfo, row, 1, 180, 180, 180)

	local row = guiGridListAddRow(groupMenuGUI.manage.gridlistinfo)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 1, "Nazwa grupy", false, false)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 2, groupInfo.name, false, false)
	guiGridListSetItemColor(groupMenuGUI.manage.gridlistinfo, row, 1, 180, 180, 180)

	local row = guiGridListAddRow(groupMenuGUI.manage.gridlistinfo)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 1, "Ranga", false, false)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 2, pGroupInfo.name, false, false)
	guiGridListSetItemColor(groupMenuGUI.manage.gridlistinfo, row, 1, 180, 180, 180)

	local row = guiGridListAddRow(groupMenuGUI.manage.gridlistinfo)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 1, "Wypłata", false, false)
	guiGridListSetItemText(groupMenuGUI.manage.gridlistinfo, row, 2, "$"..tostring(pGroupInfo.cash), false, false)
	guiGridListSetItemColor(groupMenuGUI.manage.gridlistinfo, row, 1, 180, 180, 180)



	for k, v in pairs(groupVehicles) do
		local row = guiGridListAddRow(groupMenuGUI.manage.gridlistpojazdy)
		guiGridListSetItemText(groupMenuGUI.manage.gridlistpojazdy, row, 1, v.ID, false, true)
		guiGridListSetItemText(groupMenuGUI.manage.gridlistpojazdy, row, 2, v.name, false, false)
		if v.spawned == 1 then
			guiGridListSetItemColor(groupMenuGUI.manage.gridlistpojazdy, row, 1, 0, 255, 0)
			guiGridListSetItemColor(groupMenuGUI.manage.gridlistpojazdy, row, 2, 0, 255, 0)
		end
	end

	for k, v in pairs(groupPlayers) do
		local row = guiGridListAddRow(groupMenuGUI.manage.gridlistpracownicy)
		guiGridListSetItemText(groupMenuGUI.manage.gridlistpracownicy, row, 1, v.player:getData("playerID"), false, true)
		guiGridListSetItemText(groupMenuGUI.manage.gridlistpracownicy, row, 2, string.format("%s %s", v.player:getData("name"), v.player:getData("lastname")), false, false)
		if v.duty then
			guiGridListSetItemColor(groupMenuGUI.manage.gridlistpracownicy, row, 1, 0, 255, 0)
			guiGridListSetItemColor(groupMenuGUI.manage.gridlistpracownicy, row, 2, 0, 255, 0)
		end
	end
end
addEvent("groupMenuGUI.manage.create", true)
addEventHandler("groupMenuGUI.manage.create", root, groupMenuGUI.manage.create)

function groupMenuGUI.manage.close()
	groupMenuGUI.manage.groupID = nil
	groupMenuGUI.manage.pginfo = nil
	if isElement(groupMenuGUI.manage.okno) then destroyElement(groupMenuGUI.manage.okno) end
	exports.titan_cursor:hideCustomCursor("orgsClientGroupMenu2")
end

function groupMenuGUI.manage.dutyClick()
	if groupMenuGUI.manage.pginfo then
		if groupMenuGUI.manage.pginfo.duty then
			triggerServerEvent("playerGuiFunc.setDuty", localPlayer, groupMenuGUI.manage.groupID, false)
			guiSetText(groupMenuGUI.manage.duty, "Wejdź na służbę")
			groupMenuGUI.manage.pginfo.duty = false
		else
			triggerServerEvent("playerGuiFunc.setDuty", localPlayer, groupMenuGUI.manage.groupID, true)
			guiSetText(groupMenuGUI.manage.duty, "Zejdź ze służby")
			groupMenuGUI.manage.pginfo.duty = true
		end
	end
end