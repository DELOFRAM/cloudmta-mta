addEvent("reloadGUI.c", true)
addEvent("showGUI.c", true)
addEvent("show4444GUI.c", true)
local blip
function getKeyFromValue(val1, val2)
	for k,v in pairs(getElementsByType("zgloszenieLSN")) do
		if tostring(getElementData(v, "data.time")) == tostring(val1) and tostring(getElementData(v, "data.phone")) == tostring(val2) then return k end
	end
	return false
end

function loadGridList()
guiGridListClear(notif.gridlist)
guiSetText(notif.memo, "")
	for _,v in pairs(getElementsByType("zgloszenieLSN")) do
	local row = guiGridListAddRow(notif.gridlist)
	guiGridListSetItemText(notif.gridlist, row, notif.name, getElementData(v, "data.name"):gsub("_", " "), false, false)
	guiGridListSetItemText(notif.gridlist, row, notif.number, getElementData(v, "data.phone"), false, false)
	guiGridListSetItemText(notif.gridlist, row, notif.time, getElementData(v, "data.time"), false, false)
	guiGridListSetItemText(notif.gridlist, row, notif.zone, getElementData(v, "data.zone"), false, false)
		if getElementData(v, "data.accepted") == true then
		guiGridListSetItemColor(notif.gridlist, row, notif.name, 0, 255, 0)
		guiGridListSetItemColor(notif.gridlist, row, notif.number, 0, 255, 0)
		guiGridListSetItemColor(notif.gridlist, row, notif.time, 0, 255, 0)
		guiGridListSetItemColor(notif.gridlist, row, notif.zone, 0, 255, 0)
		end
	end
guiGridListSetSelectedItem(notif.gridlist, 0, 0, true)
guiGridListSetSelectionMode(notif.gridlist, 0)
end

function show4444GUI()
	if not guiGetVisible(notif.window) then
		guiSetVisible(notif.window, true)
		loadGridList()
		setElementData(localPlayer, "LSNGUI", true)
		guiSetInputMode("no_binds_when_editing")
		exports.titan_cursor:showCustomCursor("newsClientCall4444")
	else
		guiSetVisible(notif.window, false)
		exports.titan_cursor:hideCustomCursor("newsClientCall4444")
	if isElement(window) then destroyElement(window) end
		guiGridListClear(notif.gridlist)
		guiSetText(notif.memo, "")
		setElementData(localPlayer, "LSNGUI", false)
	end
end

function showLSNGUI()
	if not guiGetVisible(lsn.window) then
		guiSetVisible(lsn.window, true)
		exports.titan_cursor:showCustomCursor("newsClientCall4444-2")
	else
		guiSetVisible(lsn.window, false)
		exports.titan_cursor:hideCustomCursor("newsClientCall4444-2")
	end
end

addEventHandler("onClientGUIClick", root, function(button)
	if button == "left" then
		if source == lsn.button[1] then -- powiadomienie prasy
		local x, y, z = getElementPosition(localPlayer)
		triggerServerEvent("addCall.s", localPlayer, getPlayerName(localPlayer), math.random(111111, 999999), getRealTime().hour..":"..getRealTime().minute..":"..getRealTime().second, getZoneName(x, y, z).." ("..getZoneName(x, y, z, true)..")", guiGetText(lsn.memo), x, y, z)
		triggerServerEvent("reloadGUI.s", localPlayer)
		guiSetText(lsn.memo, "")
		exports.titan_noti:showBox("Radiostacja została powiadomiona!")
		showLSNGUI()
		elseif source == lsn.button[2] then -- zamykanie powiadamiania prasy
		showLSNGUI()
		elseif source == notif.button[3] then -- zamykanie przyjmowania zgłoszeń
		show4444GUI()
		elseif source == notif.gridlist then -- klikanie na dane powiadomienie
			if guiGridListGetSelectedItem(notif.gridlist) == -1 or false then guiSetText(notif.memo, "") else
			local val1 = guiGridListGetItemText(notif.gridlist, guiGridListGetSelectedItem(notif.gridlist), notif.time)
			local val2 = guiGridListGetItemText(notif.gridlist, guiGridListGetSelectedItem(notif.gridlist), notif.number)
			local k = getKeyFromValue(val1, val2)
			guiSetText(notif.memo, getElementData(getElementsByType("zgloszenieLSN")[k], "data.text"))
			end
		elseif source == notif.button[2] then -- przyjmowanie zgłoszenia
			if guiGridListGetSelectedItem(notif.gridlist) == -1 or false then else
			local val1 = guiGridListGetItemText(notif.gridlist, guiGridListGetSelectedItem(notif.gridlist), notif.time)
			local val2 = guiGridListGetItemText(notif.gridlist, guiGridListGetSelectedItem(notif.gridlist), notif.number)
			guiSetText(notif.memo, "")
			triggerServerEvent("addBlip.s", localPlayer, getElementData(getElementsByType("zgloszenieLSN")[getKeyFromValue(val1, val2)], "data.x"), getElementData(getElementsByType("zgloszenieLSN")[getKeyFromValue(val1, val2)], "data.y"), getElementData(getElementsByType("zgloszenieLSN")[getKeyFromValue(val1, val2)], "data.z"), getKeyFromValue(val1, val2))
			setElementData(localPlayer, "zgloszenieLSN", getKeyFromValue(val1, val2))
			setElementData(getElementsByType("zgloszenieLSN")[getKeyFromValue(val1, val2)], "data.accepted", true)
			exports.titan_noti:showBox("Przyjąłeś zgłoszenie. Blip pojawił się na mapie.")
			show4444GUI()
			end
		elseif source == notif.button[1] then -- usuwanie zgłoszenia
			if guiGridListGetSelectedItem(notif.gridlist) == -1 or false then else
			local val1 = guiGridListGetItemText(notif.gridlist, guiGridListGetSelectedItem(notif.gridlist), notif.time)
			local val2 = guiGridListGetItemText(notif.gridlist, guiGridListGetSelectedItem(notif.gridlist), notif.number)
			guiSetText(notif.memo, "")
			triggerServerEvent("removeCall.s", localPlayer, val1, val2)
			triggerServerEvent("reloadGUI.s", localPlayer)
			triggerServerEvent("removeBlip.s", localPlayer, getKeyFromValue(val1, val2))
			exports.titan_noti:showBox("Zakończyłeś zgłoszenie. Blipy zostały usunięte.")
			show4444GUI()
			end
		end
	end
end)

addEventHandler("reloadGUI.c", root, function()
loadGridList()
end)

addEventHandler("showGUI.c", root, function()
showLSNGUI()
end)

addEventHandler("show4444GUI.c", root, function()
show4444GUI()
end)