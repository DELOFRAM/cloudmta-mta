----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local vehID = 0
local GUI = {}
local window
local function cancelGUI()
	guiSetVisible(GUI.window, false)
	vehID = 0
	GUI.showing = false
	exports.titan_cursor:hideCustomCursor("adminAssignVehicle")
end

local function applyGUI()
	local row = guiGridListGetSelectedItem(GUI.list)
	if(tonumber(row) and row > -1) then
		local ID = guiGridListGetItemText(GUI.list, row, GUI.columnID)
		if(tonumber(ID)) then
			ID = tonumber(ID)
			triggerServerEvent("onClientChooseGroup", localPlayer, vehID, ID)
			cancelGUI()
		end
	end
end

function showAssignVehicleGUI(veh, groups)
	if GUI.showing == true then return end
	if isElement(GUI.window) then destroyElement(GUI.window) end
	GUI.window = guiCreateWindow(0.38, 0.20, 0.25, 0.60, "Wybierz grupę", true)
	guiWindowSetSizable(GUI.window, false)
	GUI.list = guiCreateGridList(0.03, 0.07, 0.94, 0.78, true, GUI.window)
	GUI.columnID = guiGridListAddColumn(GUI.list, "ID", 0.3)
	GUI.columnName = guiGridListAddColumn(GUI.list, "Nazwa grupy", 1.0)
	GUI.apply = guiCreateButton(0.06, 0.88, 0.39, 0.09, "Przypisz", true, GUI.window)
	GUI.cancel = guiCreateButton(0.55, 0.88, 0.39, 0.09, "Anuluj", true, GUI.window)
	addEventHandler("onClientGUIClick", GUI.cancel, cancelGUI, false)
	addEventHandler("onClientGUIClick", GUI.apply, applyGUI, false)
	addEventHandler("onClientGUIDoubleClick", GUI.list, applyGUI, false)
	for k, v in ipairs(groups) do
		local row = guiGridListAddRow(GUI.list)
		guiGridListSetItemText(GUI.list, row, GUI.columnID, v.ID, false, false)
		guiGridListSetItemText(GUI.list, row, GUI.columnName, v.name, false, false)
	end
	vehID = veh
	exports.titan_cursor:showCustomCursor("adminAssignVehicle")
	GUI.showing = true
end
addEvent("showAssignVehicleGUI", true)
addEventHandler("showAssignVehicleGUI", root, showAssignVehicleGUI)