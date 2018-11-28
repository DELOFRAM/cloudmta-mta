----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local pGUI = {}
local sW, sH = guiGetScreenSize()
 
function pGUI.create()
    pGUI.delete()
 
    pGUI.okno = guiCreateWindow(sW / 2 - 634 / 2, sH / 2 - 450 / 2, 634, 450, "System raportów", false)
    pGUI.label1 = guiCreateLabel(10, 31, 614, 68, "Witaj w systemie raportów! Został on stworzony z myślą o każdym graczu, aby mógł w łatwy i szybki sposób zgłosić administracji błąd, tudzież zachowanie innych graczy odbiegające od norm, czy łamiące ogólne zasady RP, czy regulamin. Wybierz odpowiednią kategorię, podaj ID petenta, na którego chcesz zgłosić raport i zaczekaj na odpowiedź administratora.", false, pGUI.okno)
    pGUI.label2 = guiCreateLabel(10, 99, 75, 17, "Kategoria", false, pGUI.okno)
    pGUI.combo = guiCreateComboBox(10, 116, 195, 84, "", false, pGUI.okno)
    pGUI.label3 = guiCreateLabel(10, 162, 138, 17, "ID gracza (opcjonalnie)", false, pGUI.okno)
    pGUI.player = guiCreateEdit(10, 179, 75, 31, "", false, pGUI.okno)
    pGUI.label4 = guiCreateLabel(10, 220, 75, 17, "Opis", false, pGUI.okno)
    pGUI.desc = guiCreateMemo(10, 237, 614, 132, "", false, pGUI.okno)
    pGUI.button1 = guiCreateButton(10, 379, 298, 61, "Wyślij raport", false, pGUI.okno)
    pGUI.button2 = guiCreateButton(327, 379, 297, 61, "Anuluj", false, pGUI.okno)
 
    guiLabelSetHorizontalAlign(pGUI.label1, "center", true)
    guiSetFont(pGUI.label4, "default-bold-small")
    guiSetFont(pGUI.label2, "default-bold-small")
    guiSetFont(pGUI.label3, "default-bold-small")
    guiComboBoxAddItem(pGUI.combo, "Nieodpowiednie zachowanie")
    guiComboBoxAddItem(pGUI.combo, "Bug Abusing")
    guiComboBoxAddItem(pGUI.combo, "Inne")
    guiWindowSetSizable(pGUI.okno, false)
    guiSetInputMode("no_binds")
    addEventHandler("onClientGUIClick", pGUI.button2, pGUI.delete, false)
    addEventHandler("onClientGUIClick", pGUI.button1, pGUI.send, false)
    exports.titan_cursor:showCustomCursor("reportsClientPlayer")
end
 
function pGUI.delete()
    if isElement(pGUI.okno) then destroyElement(pGUI.okno) end
    exports.titan_cursor:hideCustomCursor("reportsClientPlayer")
    guiSetInputMode("allow_binds")
end
 
function pGUI.send()
    local combo = guiComboBoxGetSelected(pGUI.combo)
    if not combo or combo == -1 then
        exports.titan_noti:showBox("Musisz wybrać kategorię raportu.")
        return
    end
    combo = tostring(guiComboBoxGetItemText(pGUI.combo, combo))
 
    local playerID = guiGetText(pGUI.player)
    if string.len(tostring(playerID)) > 0 then
        if tonumber(playerID) then playerID = tonumber(playerID) else playerID = 0 end
    end
 
    local content = guiGetText(pGUI.desc)
    if not content or string.len(tostring(content)) < 3 then
        exports.titan_noti:showBox("Musisz wpisać treść raportu.")
        return
    end
    content = tostring(content)
 
    triggerServerEvent("addReport", localPlayer, localPlayer, playerID, combo, content)
    exports.titan_noti:showBox("Raport został wysłany!")
    pGUI.delete()
end
addCommandHandler("report", pGUI.create, false, false)
addCommandHandler("raport", pGUI.create, false, false)