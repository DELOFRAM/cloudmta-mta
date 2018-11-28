------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-06 15:00:40

unbindKey("Y","down","teamsay")

local sW, sH = guiGetScreenSize()
local GUI = {}
function tireBlockGUICreate(data)
	if isElement(GUI.okno) then destroyElement(GUI.okno) end
	GUI.okno = guiCreateWindow(sW / 2 - 303 / 2, sH / 2 - 321 / 2, 303, 321, "Pojazdy w pobliżu", false)
	guiWindowSetSizable(GUI.okno, false)
	GUI.lista = guiCreateGridList(10, 27, 283, 243, false, GUI.okno)
	GUI.button1 = guiCreateButton(10, 280, 139, 31, "Anuluj", false, GUI.okno)
	GUI.button2 = guiCreateButton(154, 280, 139, 31, "Wybierz", false, GUI.okno)
	GUI.column1 = guiGridListAddColumn(GUI.lista, "Pojazd", 0.9)
	addEventHandler("onClientGUIClick", GUI.button1, onTireBlockGUICancel, false)
	addEventHandler("onClientGUIClick", GUI.button2, onTireBlockGUISelect, false)
	addEventHandler("onClientGUIDoubleClick", GUI.lista, onTireBlockGUISelect, false)
	showCursor(true)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, ""..getElementData(v,"vehID").." | "..getVehicleNameFromModel(getElementModel(v)).."", false, false)
		guiGridListSetItemData(GUI.lista, row, GUI.column1, v)
	end
end
addEvent("tireBlockGUICreate", true)
addEventHandler("tireBlockGUICreate", root, tireBlockGUICreate)

function onTireBlockGUICancel()
	if isElement(GUI.okno) then destroyElement(GUI.okno) end
	showCursor(false)	
end

function onTireBlockGUISelect()
	local row = guiGridListGetSelectedItem(GUI.lista)
	if row and row ~= -1 then
		local element = guiGridListGetItemData(GUI.lista, row, GUI.column1)
		if isElement(element) then
			onTireBlockGUICancel()
			local vehID = getElementData(element, "vehID")
			if tonumber(vehID) then
				triggerServerEvent("changeTireBlockState", localPlayer, element)
				return
			end
			exports.titan_noti:showBox("Ten pojazd nie może zostać zablokowany.")
		end
	end
end