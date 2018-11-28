----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sphereGUI =
{
	mainWindow = {},
	editorWindow = {}
}
local sphereGUIFunc = {}
local sphereGUIData = {}

local spherePerms = 
{
	["car"]		= "Blokada parkowania",
	["object"]	= "Tworzenie obiektów",
	["podaj"]	= "Dostęp do /podaj",
	["duty"]	= "Dostęp do /g duty",
	["zamow"] 	= "Dostęp do zamówien grupy na strefie."
}

function sphereGUIFunc.createWindows(data)
	local sW, sH = guiGetScreenSize()
	if isElement(sphereGUI.mainWindow.window) then destroyElement(sphereGUI.mainWindow.window) end
	if isElement(sphereGUI.editorWindow.window) then destroyElement(sphereGUI.editorWindow.window) end
	sphereGUI.mainWindow = {}
	sphereGUI.editorWindow = {}
	sphereGUIData = {}
	sphereGUIData.newPerms = {}

	sphereGUI.mainWindow.window = guiCreateWindow(sW / 2 - 545 / 2 - 216 / 2, sH / 2 - 538 / 2, 545, 538, "Zarządzanie strefą", false)
	sphereGUI.mainWindow.label1 = guiCreateLabel(10, 31, 525, 20, "ID strefy", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.editID = guiCreateEdit(10, 51, 525, 31, "ID STREFY", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.editName = guiCreateEdit(10, 112, 525, 31, "NAZWA STREFY", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.label2 = guiCreateLabel(10, 92, 525, 20, "Nazwa strefy", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.label3 = guiCreateLabel(10, 153, 525, 20, "Uprawnienia", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.permsList = guiCreateGridList(10, 183, 307, 282, false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.scrollpanel = guiCreateScrollPane(328, 291, 207, 174, false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.buttonEditPerms = guiCreateButton(327, 183, 208, 44, "Edytuj uprawnienie", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.buttonDeletePerms = guiCreateButton(328, 237, 206, 44, "Usuń uprawnienie", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.buttonSave = guiCreateButton(416, 475, 119, 53, "Zapisz", false, sphereGUI.mainWindow.window)
	sphereGUI.mainWindow.buttonCancel = guiCreateButton(287, 475, 119, 53, "Anuluj", false, sphereGUI.mainWindow.window)

	sphereGUI.editorWindow.window = guiCreateWindow(sW / 2 + 545 / 2 + 5 - 216 / 2, sH / 2 - 538 / 2, 216, 538, "Edytor uprawnień", false)
	sphereGUI.editorWindow.label1 = guiCreateLabel(10, 26, 196, 21, "Typ właściciela", false, sphereGUI.editorWindow.window)
	sphereGUI.editorWindow.combobox = guiCreateComboBox(10, 47, 196, 76, "", false, sphereGUI.editorWindow.window)
	sphereGUI.editorWindow.label2 = guiCreateLabel(10, 123, 196, 21, "Właściciel", false, sphereGUI.editorWindow.window)
	sphereGUI.editorWindow.editOwner = guiCreateEdit(10, 144, 196, 30, "", false, sphereGUI.editorWindow.window)
	--sphereGUI.editorWindow.scrollpanel = guiCreateScrollPane(10, 184, 196, 224, false, sphereGUI.editorWindow.window)
	sphereGUI.editorWindow.buttonAdd = guiCreateButton(9, 418, 197, 50, "Dodaj nowe uprawnienie", false, sphereGUI.editorWindow.window)
	sphereGUI.editorWindow.buttonReset = guiCreateButton(9, 478, 197, 50, "Resetuj", false, sphereGUI.editorWindow.window)

	--guiCreateCheckBox(0, 0, 196, 24, "Uprawnienia właściciela", false, false, sphereGUI.editorWindow.scrollpanel)

	--guiCreateCheckBox(0, 0, 207, 24, "Uprawnienie #1", false, false,sphereGUI.mainWindow.scrollpanel)
	local i = 1
	for k, v in pairs(spherePerms) do
		local checkbox = guiCreateCheckBox(0, 0 + (i - 1) * 24, 207, 24, v, data.flags[k] and true or false, false, sphereGUI.mainWindow.scrollpanel)
		if isElement(checkbox) then
			checkbox:setData("isSpherePerm", true)
			checkbox:setData("name", k)
			sphereGUIData.newPerms[k] = data.flags[k] and true or nil
			addEventHandler("onClientGUIClick", checkbox, sphereGUIFunc.onChangeVar, false)
		end
		i = i + 1
	end

	guiWindowSetSizable(sphereGUI.mainWindow.window, false)
	guiLabelSetVerticalAlign(sphereGUI.mainWindow.label1, "center")
	guiEditSetReadOnly(sphereGUI.mainWindow.editID, true)
	guiLabelSetVerticalAlign(sphereGUI.mainWindow.label2, "center")
	guiLabelSetVerticalAlign(sphereGUI.mainWindow.label3, "center")
	guiWindowSetSizable(sphereGUI.editorWindow.window, false)
	guiLabelSetVerticalAlign(sphereGUI.editorWindow.label1, "center")
	guiLabelSetVerticalAlign(sphereGUI.editorWindow.label2, "center")

	guiComboBoxAddItem(sphereGUI.editorWindow.combobox, "None")
	guiComboBoxAddItem(sphereGUI.editorWindow.combobox, "Gracz")
	guiComboBoxAddItem(sphereGUI.editorWindow.combobox, "Grupa")
	guiComboBoxAddItem(sphereGUI.editorWindow.combobox, "Bank")

	guiGridListAddColumn(sphereGUI.mainWindow.permsList, "Typ właściciela", 0.5)
	guiGridListAddColumn(sphereGUI.mainWindow.permsList, "ID właściciela", 0.4)

	exports.titan_cursor:showCustomCursor("admin/client/editSphere")

	addEventHandler("onClientGUIClick", sphereGUI.mainWindow.buttonSave, sphereGUIFunc.save, false)
	addEventHandler("onClientGUIClick", sphereGUI.mainWindow.buttonCancel, sphereGUIFunc.closeGUI, false)
	addEventHandler("onClientGUIClick", sphereGUI.mainWindow.buttonDeletePerms, sphereGUIFunc.eventOnClientClickDeletePerm, false)

	addEventHandler("onClientGUIClick", sphereGUI.editorWindow.buttonAdd, sphereGUIFunc.eventOnClientClickSubmit, false)

	guiSetText(sphereGUI.mainWindow.editID, data.ID)
	guiSetText(sphereGUI.mainWindow.editName, data.name)

	sphereGUIFunc.reloadPerms(data.members)
end
addEvent("sphereGUIFunc.createWindows", true)
addEventHandler("sphereGUIFunc.createWindows", root, sphereGUIFunc.createWindows)

function sphereGUIFunc.closeGUI()
	if isElement(sphereGUI.mainWindow.window) then destroyElement(sphereGUI.mainWindow.window) end
	if isElement(sphereGUI.editorWindow.window) then destroyElement(sphereGUI.editorWindow.window) end

	sphereGUI.mainWindow = {}
	sphereGUI.editorWindow = {}
	sphereGUIData = {}

	exports.titan_cursor:hideCustomCursor("admin/client/editSphere")
end

function sphereGUIFunc.save()
	local name = guiGetText(sphereGUI.mainWindow.editName)
	if string.len(tostring(name)) < 4 then return exports.titan_noti:showBox("Nazwa strefy musi mieć przynajmniej 4 znaki.") end
	name = tostring(name)
	triggerServerEvent("spheresFunc.saveInfo", localPlayer, tonumber(guiGetText(sphereGUI.mainWindow.editID)), name, sphereGUIData.newPerms)
	sphereGUIFunc.closeGUI()
end

--
-- Eventy do tworzenia
-- 
function sphereGUIFunc.eventOnClientClickSubmit()
	if sphereGUIData.editOn then

	else
		local ownerType = guiComboBoxGetSelected(sphereGUI.editorWindow.combobox)
		local owner = guiGetText(sphereGUI.editorWindow.editOwner)
		if not ownerType or ownerType == -1 then return exports.titan_noti:showBox("Wybierz typ właściciela.") end
		if not owner or not tonumber(owner) then return exports.titan_noti:showBox("Wprowadź poprawnie ID właściciela.") end
		ownerType = tonumber(ownerType)
		owner = tonumber(owner)
		if ownerType == 3 then ownerType = -1 end
		triggerServerEvent("spheresFunc.addSphereMember", localPlayer, tonumber(guiGetText(sphereGUI.mainWindow.editID)), ownerType, owner)
		guiSetEnabled(sphereGUI.editorWindow.buttonAdd, false)
	end
end

function sphereGUIFunc.eventOnClientClickDeletePerm()
	local row = guiGridListGetSelectedItem(sphereGUI.mainWindow.permsList)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(sphereGUI.mainWindow.permsList, row, 1)
	if data then
		local ownerType, owner = unpack(data)
		triggerServerEvent("spheresFunc.deleteSphereMember", localPlayer, tonumber(guiGetText(sphereGUI.mainWindow.editID)), tonumber(ownerType), tonumber(owner))
		guiSetEnabled(sphereGUI.mainWindow.buttonDeletePerms, false)
	end
end

function sphereGUIFunc.turnOnGuiElement(eType, eName)
	if isElement(sphereGUI[eType][eName]) then
		guiSetEnabled(sphereGUI[eType][eName], true)
	end
end
addEvent("sphereGUIFunc.turnOnGuiElement", true)
addEventHandler("sphereGUIFunc.turnOnGuiElement", root, sphereGUIFunc.turnOnGuiElement)

function sphereGUIFunc.reloadPerms(data)
	if isElement(sphereGUI.mainWindow.permsList) then
		guiGridListClear(sphereGUI.mainWindow.permsList)
		for k, v in ipairs(data) do
			local row = guiGridListAddRow(sphereGUI.mainWindow.permsList)
			guiGridListSetItemText(sphereGUI.mainWindow.permsList, row, 1, sphereGUIFunc.getOwnerTypeName(v.ownerType), false, false)
			guiGridListSetItemText(sphereGUI.mainWindow.permsList, row, 2, v.owner, false, false)

			guiGridListSetItemData(sphereGUI.mainWindow.permsList, row, 1, {v.ownerType, v.owner})
		end
	end
end
addEvent("sphereGUIFunc.reloadPerms", true)
addEventHandler("sphereGUIFunc.reloadPerms", root, sphereGUIFunc.reloadPerms)

function sphereGUIFunc.onChangeVar()
	if isElement(source) then
		if source:getData("isSpherePerm") then
			if guiCheckBoxGetSelected(source) then
				sphereGUIData.newPerms[source:getData("name")] = true
			else
				sphereGUIData.newPerms[source:getData("name")] = nil
			end
		end
	end
end

function sphereGUIFunc.getOwnerTypeName(ownerType)
	local names = 
	{
		[-1] = "Bank",
		[0] = "None",
		[1] = "Gracz",
		[2] = "Grupa"
	}
	if names[ownerType] then return names[ownerType] else return "Nieznany" end
end