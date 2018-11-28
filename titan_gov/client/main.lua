----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local govGUI = {}
function createGovGUI()
	if isElement(govGUI.okno) then destroyElement(govGUI.okno) end
	local sW, sH = guiGetScreenSize()
	govGUI.okno = guiCreateWindow(sW / 2 - 463 / 2, sH / 2 - 266 / 2, 463, 266, "Urząd", false)
	govGUI.lista = guiCreateGridList(10, 24, 216, 232, false, govGUI.okno)
	govGUI.column = guiGridListAddColumn(govGUI.lista, "Nazwa", 0.9)
	govGUI.label1 = guiCreateLabel(236, 24, 217, 138, "Wybierz usługę z listy", false, govGUI.okno)
	govGUI.label2 = guiCreateLabel(236, 172, 217, 30, "", false, govGUI.okno)
	govGUI.button1 = guiCreateButton(236, 212, 104, 34, "Wybierz", false, govGUI.okno)
	govGUI.button2 = guiCreateButton(349, 212, 104, 34, "Anuluj", false, govGUI.okno)
	guiWindowSetSizable(govGUI.okno, false)
	showCursor(true)
end
addEvent("createGovGUI", true)
addEventHandler("createGovGUI", root, createGovGUI)