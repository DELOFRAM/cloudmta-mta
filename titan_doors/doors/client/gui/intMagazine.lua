----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local GUIMagazine = {}


function createMagazineGUI(data)
	closeMagazineGUI()
	GUIMagazine.okno = guiCreateWindow(0.38, 0.18, 0.25, 0.60, "Przedmioty w magazynie", true)
	guiWindowSetSizable(GUIMagazine.okno, false)

	GUIMagazine.lista = guiCreateGridList(0.03, 0.08, 0.94, 0.75, true, GUIMagazine.okno)
	GUIMagazine.column1 = guiGridListAddColumn(GUIMagazine.lista, "ID", 0.15)
	GUIMagazine.column2 = guiGridListAddColumn(GUIMagazine.lista, "Nazwa", 0.5)
	GUIMagazine.column3 = guiGridListAddColumn(GUIMagazine.lista, "Ilość sztuk", 0.25)
	GUIMagazine.cancel = guiCreateButton(0.71, 0.86, 0.23, 0.11, "Anuluj", true, GUIMagazine.okno)
	GUIMagazine.accept1 = guiCreateButton(0.06, 0.86, 0.23, 0.11, "Wydaj", true, GUIMagazine.okno)
	GUIMagazine.accept2 = guiCreateButton(0.38, 0.86, 0.23, 0.11, "Wyciągnij", true, GUIMagazine.okno)
	addEventHandler("onClientGUIClick", GUIMagazine.cancel, closeMagazineGUI, false)
	addEventHandler("onClientGUIClick", GUIMagazine.accept1, clickMagazineGUIAccept1, false)
	addEventHandler("onClientGUIClick", GUIMagazine.accept2, clickMagazineGUIAccept2, false)
	exports.titan_cursor:showCustomCursor("doorsIntMagazine")
	if(type(data) == "table") then
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(GUIMagazine.lista)
			guiGridListSetItemText(GUIMagazine.lista, row, GUIMagazine.column1, v.ID, false, true)
			guiGridListSetItemText(GUIMagazine.lista, row, GUIMagazine.column2, v.name, false, false)
			guiGridListSetItemText(GUIMagazine.lista, row, GUIMagazine.column3, v.stock, false, true)

			guiGridListSetItemData(GUIMagazine.lista, row, GUIMagazine.column1, v.ID)
		end
	end
end
addEvent("createMagazineGUI", true)
addEventHandler("createMagazineGUI", root, createMagazineGUI)

function closeMagazineGUI()
	if(isElement(GUIMagazine.okno)) then destroyElement(GUIMagazine.okno) end
	GUIMagazine = {}
	exports.titan_cursor:hideCustomCursor("doorsIntMagazine")
end

function clickMagazineGUIAccept1()
	local row = guiGridListGetSelectedItem(GUIMagazine.lista)
	if(not row or row == -1) then
		exports.titan_noti:showBox("Nie zaznaczyłeś żadnego przedmiotu.")
		return
	end
	local ID = guiGridListGetItemData(GUIMagazine.lista, row, GUIMagazine.column1)
	if(not tonumber(ID)) then return end
	ID = tonumber(ID)
end

function clickMagazineGUIAccept2()
	local row = guiGridListGetSelectedItem(GUIMagazine.lista)
	if(not row or row == -1) then
		exports.titan_noti:showBox("Nie zaznaczyłeś żadnego przedmiotu.")
		return
	end
	local ID = guiGridListGetItemData(GUIMagazine.lista, row, GUIMagazine.column1)
	if(not tonumber(ID)) then return end
	ID = tonumber(ID)
	triggerServerEvent("onPlayerChooseMagazineItemPull", localPlayer, localPlayer, ID)
	closeMagazineGUI()
end