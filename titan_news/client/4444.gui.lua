--[[
Lista zgłoszeń
]]--

x, y = guiGetScreenSize()
notif = {
    button = {}
}
notif.window = guiCreateWindow(483/1680*x, 301/1050*y, 715/1680*x, 449/1050*y, "Lista zgłoszeń.", false)
guiWindowSetSizable(notif.window, false)

notif.gridlist = guiCreateGridList(9/1680*x, 24/1050*y, 696/1680*x, 263/1050*y, false, notif.window)
notif.name = guiGridListAddColumn(notif.gridlist, "Imię i nazwisko", 0.3)
notif.number = guiGridListAddColumn(notif.gridlist, "Numer", 0.14)
notif.time = guiGridListAddColumn(notif.gridlist, "Godzina", 0.16)
notif.zone = guiGridListAddColumn(notif.gridlist, "Lokalizacja", 0.35)
notif.memo = guiCreateMemo(9/1680*x, 291/1050*y, 696/1680*x, 118/1050*y, "", false, notif.window)
notif.button[3] = guiCreateButton(551/1680*x, 413/1050*y, 154/1680*x, 26/1050*y, "Zamknij", false, notif.window)
guiSetFont(notif.button[3], "clear-normal")
guiSetProperty(notif.button[3], "NormalTextColour", "FFAAAAAA")
notif.button[2] = guiCreateButton(387/1680*x, 413/1050*y, 154/1680*x, 26/1050*y, "Przyjmij", false, notif.window)
guiSetFont(notif.button[2], "clear-normal")
guiSetProperty(notif.button[2], "NormalTextColour", "FFAAAAAA")
notif.button[1] = guiCreateButton(223/1680*x, 415/1050*y, 154/1680*x, 24/1050*y, "Usuń", false, notif.window)
guiSetFont(notif.button[1], "clear-normal")
guiSetProperty(notif.button[1], "NormalTextColour", "FFAAAAAA")

--[[
Powiadamianie prasy
]]--

lsn = {
    button = {}
}
lsn.window = guiCreateWindow(571/1680*x, 392/1050*y, 538/1680*x, 267/1050*y, "Powiadamianie prasy.", false)
guiWindowSetSizable(lsn.window, false)

lsn.memo = guiCreateMemo(0.02, 0.08, 0.96, 0.74, "", true, lsn.window)
lsn.button[2] = guiCreateButton(393/1680*x, 230/1050*y, 135/1680*x, 27/1050*y, "Zamknij", false, lsn.window)
guiSetFont(lsn.button[2], "clear-normal")
guiSetProperty(lsn.button[2], "NormalTextColour", "FFAAAAAA")
lsn.button[1] = guiCreateButton(248/1680*x, 230/1050*y, 135/1680*x, 27/1050*y, "Wyślij", false, lsn.window)
guiSetFont(lsn.button[1], "clear-normal")
guiSetProperty(lsn.button[1], "NormalTextColour", "FFAAAAAA")

--[[
Funkcje
]]--

guiSetVisible(notif.window, false)
guiSetVisible(lsn.window, false)
guiMemoSetReadOnly(notif.memo, true)
guiWindowSetMovable(lsn.window, false)
guiWindowSetSizable(lsn.window, false)
guiWindowSetMovable(notif.window, false)
guiWindowSetSizable(notif.window, false)