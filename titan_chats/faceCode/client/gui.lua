local data = 
{
	[1] = {faceCode = "ASDXDD", name = "Test"},
	[2] = {faceCode = "ASDXDD", name = "Test"},
	[3] = {faceCode = "ASDXDD", name = "Test"},
	[4] = {faceCode = "ASDXDD", name = "Test"},
	[5] = {faceCode = "ASDXDD", name = "Test"},
	[6] = {faceCode = "ASDXDD", name = "Test"},
	[7] = {faceCode = "ASDXDD", name = "Test"},
	[8] = {faceCode = "ASDXDD", name = "Test"},
	[9] = {faceCode = "ASDXDD", name = "Test"},
	[10] = {faceCode = "ASDXDD", name = "Test"}
}
local fcGUI = {}
function createGUIFaceCodes()
	local sW, sH = guiGetScreenSize()
	fcGUI.okno = guiCreateWindow(sW / 2 - 345 / 2, sH / 2 - 310 / 2, 345, 310, "Zapisane kody twarzy", false)
	guiWindowSetSizable(fcGUI.okno, false)
	fcGUI.scroll = guiCreateScrollPane(10, 27, 323, 170, false, fcGUI.okno)
	--fcGUI.list1 = guiCreateGridList(0, 10, 300, 55, false, fcGUI.scroll)
	fcGUI.cancel = guiCreateButton(239, 259, 84, 40, "Anuluj", false, fcGUI.okno)
	fcGUI.add = guiCreateButton(239, 207, 84, 40, "Dodaj nowy...", false, fcGUI.okno)
	fcGUI.opis = guiCreateLabel(10, 207, 215, 88, "To jest interfejs, który ma umożliwić zarządzanie Twoimi zapisanymi kodami twarzy i dowolne manewrowanie nimi.\n\nWybierz opcję 'Dodaj nową', aby dodać kod twarzy, której jeszcze nie masz zapisanej. ", false, fcGUI.okno)
	guiLabelSetHorizontalAlign(fcGUI.opis, "left", true)

	local i = 0
	for k, v in ipairs(data) do
		local gridList = guiCreateGridList(0, 10 + (65 * i), 300, 55, false, fcGUI.scroll)
		guiCreateLabel(10, 10, 300, 20, "Nazwa: Test", false, gridList)
		guiCreateLabel(10, 30, 300, 20, "Nazwa: Test", false, gridList)
		i = i + 1
	end
	showCursor(true)
end
--createGUIFaceCodes()