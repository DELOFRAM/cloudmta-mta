local x,y = guiGetScreenSize()
ads = {}
ads.window = guiCreateWindow(522/1680*x, 345/1050*y, 636/1680*x, 361/1050*y, "Los Santos News || Dodawanie reklamy", false)
guiWindowSetSizable(ads.window, false)
guiWindowSetMovable(ads.window, false)
ads.label = guiCreateLabel(9/1680*x, 21/1050*y, 617/1680*x, 46/1050*y, "Wpisz poniżej tekst swojej reklamy. Opłacone zostało już jej nadanie więc należy wpisać tekst i wstawić reklamę do kolejki! Wszystkie głupie teksty będą odpowiednio nagradzane przez ekipę serwera.", false, ads.window)
guiSetFont(ads.label, "default-bold-small")
guiLabelSetHorizontalAlign(ads.label, "left", true)
ads.memo = guiCreateMemo(11/1680*x, 77/1050*y, 615/1680*x, 241/1050*y, "", false, ads.window)
ads.button = guiCreateButton(9/1680*x, 326/1050*y, 617/1680*x, 25/1050*y, "Wyślij reklamę do kolejki oczekujacych", false, ads.window)
guiSetFont(ads.button, "clear-normal")
guiSetProperty(ads.button, "NormalTextColour", "FFAAAAAA")
guiSetVisible(ads.window, false)
