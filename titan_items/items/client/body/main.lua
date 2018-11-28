----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local bodyGUI = {}
local sW, sH = guiGetScreenSize()

function bodyGUI.create(playerName, killTime, playerDNA, victimDNA, weaponID, weaponData, location)
	bodyGUI.okno = guiCreateWindow(sW / 2 - 495 / 2, sH / 2 - 296 / 2, 495, 296, "Badanie zwłok", false)
	guiWindowSetSizable(bodyGUI.okno, false)

	bodyGUI.label1 = guiCreateLabel(10, 30, 148, 27, "Imię i nazwisko", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label1, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label1, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label1, "center")
		
	bodyGUI.label2 = guiCreateLabel(10, 57, 148, 27, "Data zgonu", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label2, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label2, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label2, "center")
		
	bodyGUI.label3 = guiCreateLabel(10, 111, 148, 27, "DNA zabójcy", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label3, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label3, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label3, "center")
		
	bodyGUI.label4 = guiCreateLabel(10, 138, 148, 27, "Broń", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label4, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label4, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label4, "center")

	bodyGUI.label5 = guiCreateLabel(10, 165, 148, 27, "Przyczyna zgonu", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label5, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label5, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label5, "center")
		
	bodyGUI.label6 = guiCreateLabel(10, 192, 148, 27, "Miejsce zabójstwa", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label6, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label6, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label6, "center")

	bodyGUI.label7 = guiCreateLabel(10, 84, 148, 27, "DNA poszkodowanego", false, bodyGUI.okno)
	guiSetFont(bodyGUI.label7, "default-bold-small")
	guiLabelSetHorizontalAlign(bodyGUI.label7, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.label7, "center")
		
	-------------
	-- ZMIENNE --
	-------------

	

	bodyGUI.imienazwisko = guiCreateLabel(158, 30, 327, 27, playerName, false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.imienazwisko, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.imienazwisko, "center")

	local time = getRealTime(killTime)
	bodyGUI.datazgonu = guiCreateLabel(158, 57, 327, 27, string.format("%0.2d %s %0.4d %0.2d:%0.2d", time.monthday, getMiesiac(time.month), time.year + 1900, time.hour, time.minute), false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.datazgonu, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.datazgonu, "center")

	bodyGUI.dnaposzkodowanego = guiCreateLabel(159, 84, 262, 27, playerDNA, false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.dnaposzkodowanego, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.dnaposzkodowanego, "center")

	bodyGUI.dnazabojcy = guiCreateLabel(159, 111, 262, 27, victimDNA, false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.dnazabojcy, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.dnazabojcy, "center")

	bodyGUI.bronnazwa = guiCreateLabel(158, 138, 327, 27, string.format("%s (%d)", tostring(getWeaponNameFromID(weaponID)), tonumber(weaponID)), false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.bronnazwa, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.bronnazwa, "center")

	bodyGUI.bronid = guiCreateLabel(158, 165, 262, 27, weaponData, false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.bronid, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.bronid, "center")

	if not getWeaponNameFromID(weaponID) then
		guiSetText(bodyGUI.label5, "Powód zgonu")
	end

	bodyGUI.miejscezabojstwa = guiCreateLabel(158, 192, 327, 27, location, false, bodyGUI.okno)
	guiLabelSetHorizontalAlign(bodyGUI.miejscezabojstwa, "center", false)
	guiLabelSetVerticalAlign(bodyGUI.miejscezabojstwa, "center")

	bodyGUI.kopiuj1 = guiCreateButton(420, 84, 65, 27, "Kopiuj", false, bodyGUI.okno)
	bodyGUI.kopiuj2 = guiCreateButton(420, 111, 65, 27, "Kopiuj", false, bodyGUI.okno)
	bodyGUI.kopiuj3 = guiCreateButton(420, 165, 65, 27, "Kopiuj", false, bodyGUI.okno)
	bodyGUI.zamknij = guiCreateButton(10, 234, 475, 52, "Zamknij", false, bodyGUI.okno)

	addEventHandler("onClientGUIClick", bodyGUI.zamknij, bodyGUI.remove, false)
	addEventHandler("onClientGUIClick", bodyGUI.kopiuj1, bodyGUI.copy1, false)
	addEventHandler("onClientGUIClick", bodyGUI.kopiuj2, bodyGUI.copy2, false)
	addEventHandler("onClientGUIClick", bodyGUI.kopiuj3, bodyGUI.copy3, false)

	exports.titan_cursor:showCustomCursor("itemsBody")
end
addEvent("bodyGUI.create", true)
addEventHandler("bodyGUI.create", root, bodyGUI.create)

function bodyGUI.remove()
	if isElement(bodyGUI.okno) then destroyElement(bodyGUI.okno) end
		exports.titan_cursor:hideCustomCursor("itemsBody")
end

function bodyGUI.copy1()
	setClipboard(guiGetText(bodyGUI.dnaposzkodowanego))
	exports.titan_noti:showBox("DNA poszkodowanego zostało skopiowane do schowka")
end
function bodyGUI.copy2()
	setClipboard(guiGetText(bodyGUI.dnazabojcy))
	exports.titan_noti:showBox("DNA zabójcy zostało skopiowane do schowka")
end
function bodyGUI.copy3()
	setClipboard(guiGetText(bodyGUI.bronid))
	exports.titan_noti:showBox("Identyfikator broni został skopiowany do schowka")
end

function getMiesiac(month)
	local miesiac
	if(month == 0) then	miesiac = "stycznia"
	elseif(month == 1) then	miesiac = "lutego"
	elseif(month == 2) then	miesiac = "marca"
	elseif(month == 3) then	miesiac = "kwietnia"
	elseif(month == 4) then	miesiac = "maja"
	elseif(month == 5) then	miesiac = "czerwca"
	elseif(month == 6) then	miesiac = "lipca"
	elseif(month == 7) then	miesiac = "sierpnia"
	elseif(month == 8) then	miesiac = "września"
	elseif(month == 9) then	miesiac = "października"
	elseif(month == 10) then miesiac = "listopada"
	elseif(month == 11) then miesiac = "grudnia"
	end
	return miesiac
end