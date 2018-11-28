----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local damageGUI = {}

function onDamage(attacker, weapon, bodypart, loss)
	if isElement(attacker) and weapon ~= 37 then
		local tmpTable = localPlayer:getData("lastDamage")
		if type(tmpTable) ~= "table" then tmpTable = {} end
		local attackerType = attacker:getType() == "player" and 1 or attacker:getType() == "vehicle" and 2 or 3
		table.insert(tmpTable, {time = getRealTime().timestamp, type = attackerType, hp = string.format("%0.2f", loss), id = weapon})
		localPlayer:setData("lastDamage", tmpTable)
	end
end
--addEventHandler("onClientPlayerDamage", localPlayer, onDamage)

function createDamageGUI(data)
	if isElement(damageGUI.okno) then destroyElement(damageGUI.okno) end
	damageGUI.okno = guiCreateWindow(484, 133, 346, 360, "Obrażenia przyjęte przez gracza", false)
	guiWindowSetSizable(damageGUI.okno, false)
	damageGUI.lista = guiCreateGridList(10, 25, 326, 282, false, damageGUI.okno)
	damageGUI.column1 = guiGridListAddColumn(damageGUI.lista, "Źródło", 0.3)
	damageGUI.column2 = guiGridListAddColumn(damageGUI.lista, "Kiedy", 0.2)
	damageGUI.column3 = guiGridListAddColumn(damageGUI.lista, "Ilość HP", 0.2)
	damageGUI.column4 = guiGridListAddColumn(damageGUI.lista, "Część ciała", 0.2)
	damageGUI.button = guiCreateButton(10, 317, 326, 33, "Zamknij", false, damageGUI.okno)
	exports.titan_cursor:showCustomCursor("damageClientMain")
	addEventHandler("onClientGUIClick", damageGUI.button, closeDamageGUI, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(damageGUI.lista)
		local time = getRealTime(v.time)
		guiGridListSetItemText(damageGUI.lista, row, damageGUI.column1, string.format("%s %s (%d)", v.bw and "(BW)" or "", tostring(getWeaponNameFromID(v.weapon)), tostring(v.weapon)), false, false)
		--guiGridListSetItemText(damageGUI.lista, row, damageGUI.column1, tostring(getWeaponNameFromID(v.weapon)).." ("..tostring(v.weapon)..")", false, false)
		guiGridListSetItemText(damageGUI.lista, row, damageGUI.column2, string.format("%0.2d:%0.2d:%0.2d", time.hour, time.minute, time.second), false, false)
		guiGridListSetItemText(damageGUI.lista, row, damageGUI.column3, tonumber(v.hp) and string.format("%0.2f", v.hp) or v.hp, false, false)
		guiGridListSetItemText(damageGUI.lista, row, damageGUI.column4, tostring(getBodyPartName(v.bodypart)), false, false)
	end
end
addEvent("createDamageGUI", true)
addEventHandler("createDamageGUI", root, createDamageGUI)

function closeDamageGUI()
	if isElement(damageGUI.okno) then destroyElement(damageGUI.okno) end
	exports.titan_cursor:hideCustomCursor("damageClientMain")
end