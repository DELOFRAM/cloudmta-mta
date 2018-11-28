----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local aPerms =
{
	["items"] 					= "Zarządzanie przedmiotami",
	["vehicles"] 				= "Zarządzanie pojazdami",
	["orgs"] 					= "Zarządzanie grupami",
	["doors"] 					= "Zarządzanie drzwiami",
	["texts"] 					= "Zarządzanie 3Dtextami",
	["spheres"] 				= "Zarządzanie strefami",
	["spec"] 					= "Dostęp do komendy /aspec",
	["kick"] 					= "Dostęp do komendy /akick",
	["ban"] 					= "Dostęp do komendy /aban",
	["warn"] 					= "Dostęp do komendy /awarn",
	["aj"] 						= "Dostęp do komend /aj, /unaj",
	["tele"] 					= "Dostęp do komend teleportacyjnych (/to, /tm, /tp)",
	["globdo"]					= "Dostęp do komendy /ado",
	["glob"] 					= "Dostęp do komendy /glob",
	["block"] 					= "Dostęp do komendy /ablock",
	["bw"] 						= "Dostęp do komendy /bw",
	["aset"] 					= "Dostęp do komendy /aset",
	["aset_money"] 				= "Dostęp do komendy /aset addmoney",
	["aset_globaladmin"] 		= "Dostęp do komend /aset [admin, password, shutdown]",
	["manageadmins"] 			= "Dostęp do panelu edycji administratorów",
	["masteradmin"] 			= "Dostęp do logowania się do konta MTA",
	["arrest"] 					= "Zarządzanie celami",
	["bus"]						= "Zarządzanie busami",
	["objects"]					= "Zarządzanie obiektami",
	["peds"] 					= "Zarządzanie pedami",
	["ninja"] 					= "Dostęp do komendy /ainv",
	["superman"] 				= "Dostęp do komendy /afly",
	["fck"]						= "Dostęp do komendy /afck",
	["serial"]					= "Dostęp do komendy /aserial",
	["agun"]					= "Dostęp do komendy /agun"
}
local sW, sH = guiGetScreenSize()
local eAdminData = {}

function eAdminData.create(data)
	if eAdminData.showing then return end
	eAdminData.delete()
	eAdminData.okno = guiCreateWindow(sW / 2 - 450 / 2, sH / 2 - 403 / 2, 450, 403, "Edycja administratora", false)
	eAdminData.label1 = guiCreateLabel(10, 28, 54, 17, "Nick OOC", false, eAdminData.okno)
	eAdminData.label2 = guiCreateLabel(20, 45, 258, 19, "", false, eAdminData.okno)
	eAdminData.label3 = guiCreateLabel(278, 25, 132, 20, "Poziom administratora", false, eAdminData.okno)
	eAdminData.combo = guiCreateComboBox(230, 45, 250, 92, "Wybierz rangę", false, eAdminData.okno)
	eAdminData.label4 = guiCreateLabel(16, 100, 424, 27, "Uprawnienia administratora", false, eAdminData.okno)
	eAdminData.scrollpanel = guiCreateScrollPane(16, 127, 424, 217, false, eAdminData.okno)
	eAdminData.button1 = guiCreateButton(370, 354, 70, 35, "Zapisz", false, eAdminData.okno)
	eAdminData.button2 = guiCreateButton(290, 354, 70, 35, "Anuluj", false, eAdminData.okno)

	--GUIEditor.checkbox[1] = guiCreateCheckBox(10, 10, 404, 24, "", true, false, GUIEditor.scrollpane[1])

	guiWindowSetSizable(eAdminData.okno, false)
	guiSetFont(eAdminData.label1, "default-bold-small")
	guiSetFont(eAdminData.label3, "default-bold-small")
	eAdminData.rankNone = guiComboBoxAddItem(eAdminData.combo, "Brak")
	eAdminData.rank1 = guiComboBoxAddItem(eAdminData.combo, "Supporter")
	eAdminData.rank2 = guiComboBoxAddItem(eAdminData.combo, "Moderator")
	eAdminData.rank3 = guiComboBoxAddItem(eAdminData.combo, "Developer")
	eAdminData.rank4 = guiComboBoxAddItem(eAdminData.combo, "Administrator Techniczny")
	eAdminData.rank5 = guiComboBoxAddItem(eAdminData.combo, "Administrator Rozgrywki")
	eAdminData.rank6 = guiComboBoxAddItem(eAdminData.combo, "Główny Administrator")
	eAdminData.rank7 = guiComboBoxAddItem(eAdminData.combo, "Beta-Tester")
	guiSetFont(eAdminData.label4, "default-bold-small")
	guiLabelSetHorizontalAlign(eAdminData.label4, "center", false)
	guiLabelSetVerticalAlign(eAdminData.label4, "center")

	exports.titan_cursor:showCustomCursor("adminEditAdmin")
	eAdminData.showing = true
	addEventHandler("onClientGUIClick", eAdminData.button2, eAdminData.delete, false)
	addEventHandler("onClientGUIClick", eAdminData.button1, eAdminData.save, false)

	guiComboBoxSetSelected(eAdminData.combo, tonumber(data.elem:getData("adminLevel")))
	guiSetText(eAdminData.label2, data.elem:getData("globalName"))

	eAdminData.newPerms = {}
	eAdminData.player = data.elem

	local i = 1
	for k, v in pairs(aPerms) do
		local checkbox = guiCreateCheckBox(10, 10 + (i - 1) * 24, 404, 24, v, data.perms[k] and true or false, false, eAdminData.scrollpanel)
		if isElement(checkbox) then
			checkbox:setData("isAdminPerm", true)
			checkbox:setData("name", k)
			eAdminData.newPerms[k] = data.perms[k] and true or false
			addEventHandler("onClientGUIClick", checkbox, eAdminData.onChangeVar, false)
		end
		i = i + 1
	end
end
addEvent("eAdminData.create", true)
addEventHandler("eAdminData.create", root, eAdminData.create)

function eAdminData.delete()
	if isElement(eAdminData.okno) then destroyElement(eAdminData.okno) end
	exports.titan_cursor:hideCustomCursor("adminEditAdmin")
	
	eAdminData.showing = false
	eAdminData.player = nil
	eAdminData.newPerms = {}
end

function eAdminData.save()
	local aLevel = tonumber(guiComboBoxGetItemText(eAdminData.combo, guiComboBoxGetSelected(eAdminData.combo)))
	local adminLevel = 0
	local selectedAdminLevel = guiComboBoxGetSelected(eAdminData.combo)
	if selectedAdminLevel == eAdminData.rank1 then adminLevel = 1
	elseif selectedAdminLevel == eAdminData.rank2 then adminLevel = 2
	elseif selectedAdminLevel == eAdminData.rank3 then adminLevel = 3
	elseif selectedAdminLevel == eAdminData.rank4 then adminLevel = 4
	elseif selectedAdminLevel == eAdminData.rank5 then adminLevel = 5
	elseif selectedAdminLevel == eAdminData.rank6 then adminLevel = 6
	elseif selectedAdminLevel == eAdminData.rank7 then adminLevel = 7
	end
	triggerServerEvent("saveAdminPerms", localPlayer, eAdminData.player, adminLevel, eAdminData.newPerms)
	eAdminData.delete()
end

function eAdminData.onChangeVar()
	if isElement(source) then
		if source:getData("isAdminPerm") then
			if guiCheckBoxGetSelected(source) then
				eAdminData.newPerms[source:getData("name")] = true
			else
				eAdminData.newPerms[source:getData("name")] = false
			end
		end
	end
end