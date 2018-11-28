----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local GUI = {}
function createDeliverGUI(data)
	GUI.okno = guiCreateWindow(0.39, 0.22, 0.23, 0.54, "Dostępne zamówienia", true)
	guiWindowSetSizable(GUI.okno, false)
	GUI.lista = guiCreateGridList(0.03, 0.08, 0.93, 0.75, true, GUI.okno)
	GUI.column = guiGridListAddColumn(GUI.lista, "Grupa", 0.9)
	GUI.akceptuj = guiCreateButton(0.04, 0.86, 0.58, 0.11, "Przyjmij", true, GUI.okno)
	GUI.anuluj = guiCreateButton(0.63, 0.89, 0.33, 0.08, "Anuluj", true, GUI.okno)
	addEventHandler("onClientGUIClick", GUI.anuluj, closeDeliverGUI, false)
	addEventHandler("onClientGUIClick", GUI.akceptuj, acceptDeliverGUI, false)
	addEventHandler("onClientGUIDoubleClick", GUI.lista, acceptDeliverGUI, false)
	exports.titan_cursor:showCustomCursor("orgsClientDeliverMenu")

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column, v.name, false, false)
		guiGridListSetItemData(GUI.lista, row, GUI.column, v.ID)
	end
end
addEvent("createDeliverGUI", true)
addEventHandler("createDeliverGUI", root, createDeliverGUI)

function closeDeliverGUI()
	if(isElement(GUI.okno)) then destroyElement(GUI.okno) end
	GUI = {}
	exports.titan_cursor:hideCustomCursor("orgsClientDeliverMenu")
	return
end

function acceptDeliverGUI()
	local row = guiGridListGetSelectedItem(GUI.lista)
	if(not row or row == -1) then return end

	local deliverID = guiGridListGetItemData(GUI.lista, row, GUI.column)
	if(not tonumber(deliverID)) then return end
	deliverID = tonumber(deliverID)
	triggerServerEvent("onClientChooseDeliver", localPlayer, localPlayer, deliverID)
	closeDeliverGUI()
end


function cancelPedDamage()
	cancelEvent()
end
addEventHandler("onClientPedDamage", resourceRoot, cancelPedDamage)