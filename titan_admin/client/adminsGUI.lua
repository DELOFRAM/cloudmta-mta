----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local adminsGUI = {}
function showAdminsGUI(data)
	if isElement(adminsGUI.okno) then closeAdminsGUI() end
	local sW, sH = guiGetScreenSize()
	adminsGUI.okno = guiCreateWindow(sW / 2 - 348 / 2, sH / 2 - 399 / 2, 348, 399, "Administracja online", false)
	guiWindowSetSizable(adminsGUI.okno, false)
	adminsGUI.lista = guiCreateGridList(10, 25, 328, 321, false, adminsGUI.okno)
	adminsGUI.c1 = guiGridListAddColumn(adminsGUI.lista, "ID", 0.1)
	adminsGUI.c2 = guiGridListAddColumn(adminsGUI.lista, "Nick", 0.3)
	adminsGUI.c3 = guiGridListAddColumn(adminsGUI.lista, "Ranga", 0.4)
	adminsGUI.c4 = guiGridListAddColumn(adminsGUI.lista, "Służba", 0.1)
	adminsGUI.button = guiCreateButton(10, 356, 328, 33, "Zamknij", false, adminsGUI.okno)
	addEventHandler("onClientGUIClick", adminsGUI.button, closeAdminsGUI, false)
	bindKey("enter", "down", closeAdminsGUI)
	exports.titan_cursor:showCustomCursor("adminAdminsGUI")
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(adminsGUI.lista)
		local rankData = exports.titan_misc:getAdminRank(v:getData("adminLevel"))
		local r, g, b = hex2rgb(rankData.color)
		guiGridListSetItemText(adminsGUI.lista, row, adminsGUI.c1, v:getData("playerID"), false, false)
		guiGridListSetItemText(adminsGUI.lista, row, adminsGUI.c2, v:getData("globalName"), false, false)
		guiGridListSetItemText(adminsGUI.lista, row, adminsGUI.c3, rankData.name, false, false)
		guiGridListSetItemColor(adminsGUI.lista, row, adminsGUI.c3, r, g, b)
		guiGridListSetItemText(adminsGUI.lista, row, adminsGUI.c4, v:getData("adminDuty") and "Tak" or "Nie", false, false)
		if v:getData("adminDuty") then
			guiGridListSetItemColor(adminsGUI.lista, row, adminsGUI.c4, 10, 255, 10)
		end
		
	end
end
addEvent("adminsGUI", true)
addEventHandler("adminsGUI", root, showAdminsGUI)

function closeAdminsGUI()
	if isElement(adminsGUI.okno) then destroyElement(adminsGUI.okno) end
	exports.titan_cursor:hideCustomCursor("adminAdminsGUI")
	adminsGUI = {}
	unbindKey("enter", "down", closeAdminsGUI)
end

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end