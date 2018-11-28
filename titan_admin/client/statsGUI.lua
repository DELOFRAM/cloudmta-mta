----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local statsGUI = {}
local sW, sH = guiGetScreenSize()

function createStatsGUI(player, vehs, interiors, groups, accounts)
	if statsGUI.showing then return end
	if isElement(statsGUI.okno) then destroyElement(statsGUI.okno) end
	statsGUI.okno = guiCreateWindow(sW / 2 - 469 / 2, sH / 2 - 497 / 2, 469, 497, "Statystyki gracza: "..player:getData("name").." "..player:getData("lastname"), false)
	statsGUI.lista = guiCreateGridList(10, 26, 449, 413, false, statsGUI.okno)
	guiGridListAddColumn(statsGUI.lista, "Argument", 0.4)
	guiGridListAddColumn(statsGUI.lista, "Wartość", 0.5)
	statsGUI.close = guiCreateButton(10, 449, 449, 38, "Zamknij", false, statsGUI.okno)
	guiWindowSetSizable(statsGUI.okno, false)

	exports.titan_cursor:showCustomCursor("adminStatsGUI")
	statsGUI.showing = true
	addEventHandler("onClientGUIClick", statsGUI.close, cancelStatsGUI, false)

	guiGridListSetSortingEnabled(statsGUI.lista, false)

	local row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Informacje o graczu", true, false)

	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "UID konta globalnego", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("memberID"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "UID postaci", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("charID"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Imię i nazwisko", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("name").." "..player:getData("lastname"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Płeć", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("sex") == 1 and "Mężczyzna" or player:getData("sex") == 2 and "Kobieta" or "Nieznana", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Konto globalne", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("globalName"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Czas Online", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%dh", math.floor(player:getData("onlineTime") / 60 / 60)), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Czas AFK", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%dh", math.floor(player:getData("afkTime") / 60 / 60)), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "krótkie DNA", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("shortDNA"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "DNA", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("DNA"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "HP", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, math.floor(player:getHealth()).."%", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Głód", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, math.floor(player:getData("hungryLevel")).."%", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Siła", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%0.2f%%", player:getData("strength")), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Kondycja", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%0.2f%%", player:getData("condition")), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Skin", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("skin"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Skin domyślny", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, player:getData("defaultSkin"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Portfel", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, "$"..player:getData("money"), false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "BW", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, tonumber(player:getData("bwTime")) and player:getData("bwTime") > 0 and player:getData("bwTime").." sekund" or "Brak", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "AdminJail", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, tonumber(player:getData("ajTime")) and player:getData("ajTime") > 0 and player:getData("ajTime").." sekund" or "Brak", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Areszt", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, tonumber(player:getData("arrestTime")) and player:getData("arrestTime") > 0 and player:getData("arrestTime").." sekund" or "Brak", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Blokada pojazdów", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, "Brak", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Blokada biegania", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, "Brak", false, false)
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Blokada OOC", false, false)
	guiGridListSetItemText(statsGUI.lista, row, 2, "Brak", false, false)

	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Pojazdy postaci", true, false)
	for k, v in ipairs(vehs) do
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, string.format("UID: %d", v.ID), false, false)
		guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%s", v.name), false, false)
	end
	if #vehs <= 0 then
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, "- Brak pojazdów", false, false)
	end
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Pomieszczenia postaci", true, false)
	for k, v in ipairs(interiors) do
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, string.format("UID: %d", v.ID), false, false)
		guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%s", v.name), false, false)
	end
	if #interiors <= 0 then
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, "- Brak pomieszczen", false, false)
	end
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Grupy postaci", true, false)
	for k, v in ipairs(groups) do
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, string.format("UID: %d", v.groupInfo.ID), false, false)
		guiGridListSetItemText(statsGUI.lista, row, 2, string.format("%s", v.groupInfo.name), false, false)
	end
	if #groups <= 0 then
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, "- Brak grup", false, false)
	end
	row = guiGridListAddRow(statsGUI.lista)
	guiGridListSetItemText(statsGUI.lista, row, 1, "Konta bankowe postaci", true, false)
	for k, v in ipairs(accounts) do
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, string.format("%s (%s)", tostring(v.accountID), v.name), false, false)
		guiGridListSetItemText(statsGUI.lista, row, 2, "$"..v.balance, false, false)
	end
	if #accounts <= 0 then
		row = guiGridListAddRow(statsGUI.lista)
		guiGridListSetItemText(statsGUI.lista, row, 1, "- Brak kont", false, false)
	end

end

function cancelStatsGUI()
	if isElement(statsGUI.okno) then destroyElement(statsGUI.okno) end
	exports.titan_cursor:hideCustomCursor("adminStatsGUI")
	statsGUI.showing = false
end

addEvent("createStatsGUI", true)
addEventHandler("createStatsGUI", root, createStatsGUI)