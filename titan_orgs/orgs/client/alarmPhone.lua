------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-09 14:23:34

local APGUI = {}
function createAlarmPhoneGUI(groups)
	if isElement(APGUI.okno) then destroyElement(APGUI.okno) end
	local sW, sH = guiGetScreenSize()
	APGUI.okno = guiCreateWindow(sW / 2 - 555 / 2, sH / 2 - 381 / 2, 555, 381, "Numer alarmowy", false)
	APGUI.lista = guiCreateGridList(11, 47, 533, 148, false, APGUI.okno)
	APGUI.column1 = guiGridListAddColumn(APGUI.lista, "Nazwa grupy", 0.95)
	APGUI.memo = guiCreateMemo(12, 220, 532, 93, "", false, APGUI.okno)
	APGUI.button1 = guiCreateButton(451, 330, 93, 41, "Wezwij", false, APGUI.okno)
	APGUI.button2 = guiCreateButton(348, 330, 93, 41, "Anuluj", false, APGUI.okno)
	guiGridListSetSelectionMode(APGUI.lista, 3)
	guiCreateLabel(11, 28, 600, 15, "Wybierz do kogo zgłoszenie powinno zostać skierowane (wybierz kilka przyciskając \"ctrl\")", false, APGUI.okno)
	guiCreateLabel(12, 199, 249, 15, "Treść zgłoszenia", false, APGUI.okno)
	guiWindowSetSizable(APGUI.okno, false)
	exports.titan_cursor:showCustomCursor("orgsClientAlarmPhone")

	addEventHandler("onClientGUIClick", APGUI.button2, closeAlarmPhoneGUI, false)
	addEventHandler("onClientGUIClick", APGUI.button1, selectAlarmPhoneGUI, false)

	for k, v in ipairs(groups) do
		local row = guiGridListAddRow(APGUI.lista)
		guiGridListSetItemText(APGUI.lista, row, APGUI.column1, v.name, false, false)
		guiGridListSetItemData(APGUI.lista, row, APGUI.column1, v.ID)
	end

end
addEvent("createAlarmPhoneGUI", true)
addEventHandler("createAlarmPhoneGUI", root, createAlarmPhoneGUI)

function closeAlarmPhoneGUI()
	if isElement(APGUI.okno) then destroyElement(APGUI.okno) end
	exports.titan_cursor:hideCustomCursor("orgsClientAlarmPhone")
end

function selectAlarmPhoneGUI()
	local items = guiGridListGetSelectedItems(APGUI.lista)
	if #items <= 0 then
		exports.titan_noti:showBox("Musisz wybrać przynajmniej jedną grupę, którą chcesz powiadomić.")
		return
	end
	local groups = {}
	for k, v in ipairs(items) do
		local ID = guiGridListGetItemData(APGUI.lista, v.row, APGUI.column1)
		if tonumber(ID) then
			table.insert(groups, tonumber(ID))
		end
	end

	local text = tostring(guiGetText(APGUI.memo))
	if string.len(text) < 5 then
		exports.titan_noti:showBox("Tekst wiadomości musi zajmować przynajmniej 5 znaków.")
		return
	end
	triggerServerEvent("addNew911Dial", localPlayer, text, groups)
	closeAlarmPhoneGUI()
	exports.titan_noti:showBox("Służby zostały powiadomione.")
end