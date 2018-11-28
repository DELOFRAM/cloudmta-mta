----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local mainGUI = {}
local additGUI = {}
local descData = {}

local descFunc = {}

function descFunc.create()
	descFunc.removeGUI()
	local sW, sH = guiGetScreenSize()

	-- GŁÓWNE GUI
	mainGUI.window = guiCreateWindow(sW / 2 - 339 / 2, sH / 2 - 350 / 2, 339, 350, "Panel opisów", false)
	mainGUI.opis = guiCreateLabel(10, 24, 319, 67, "Witaj w panelu opisów! Dzięki niemu możesz w szybki i wygodny sposób pracować na swoich opisać - dodawać nowe, edytować, usuwać, jak również bezpośrednio ustawiać zarówno na sobie, jak i na pojazdach.", false, mainGUI.window)
	mainGUI.opis2 = guiCreateLabel(10, 91, 123, 19, "Twoje zapisane opisy:", false, mainGUI.window)
	mainGUI.lista = guiCreateGridList(10, 110, 319, 135, false, mainGUI.window)
	mainGUI.buttonGracz = guiCreateButton(10, 255, 72, 34, getElementData(localPlayer, "playerDesc") and "Usuń z postaci" or "Ustaw na postaci", false, mainGUI.window)
	mainGUI.buttonPojazd = guiCreateButton(92, 255, 72, 34, "Ustaw na pojeździe", false, mainGUI.window)
	mainGUI.buttonEdytuj = guiCreateButton(174, 255, 72, 34, "Edytuj", false, mainGUI.window)
	mainGUI.buttonUsun = guiCreateButton(256, 255, 72, 34, "Usuń", false, mainGUI.window)
	mainGUI.buttonZamknij = guiCreateButton(10, 299, 319, 41, "Zamknij panel opisów", false, mainGUI.window)
	guiGridListAddColumn(mainGUI.lista, "Tytuł opisu", 0.9)
	guiWindowSetSizable(mainGUI.window, false)
	guiWindowSetMovable(mainGUI.window, false)
	guiLabelSetHorizontalAlign(mainGUI.opis, "center", true)
	guiSetInputMode("no_binds_when_editing")

	local veh = "Ustaw na pojeździe"
	guiSetEnabled(mainGUI.buttonPojazd, false)
	if isPedInVehicle(localPlayer) then
		if getVehicleOccupant(getPedOccupiedVehicle(localPlayer)) == localPlayer then
			guiSetEnabled(mainGUI.buttonPojazd, true)
			if getElementData(getPedOccupiedVehicle(localPlayer), "vehDesc") then
				veh = "Usuń z pojazdu"
			else
				veh = "Ustaw na pojeździe"
			end
		end
	end
	guiSetText(mainGUI.buttonPojazd, veh)

	-- DODATKOWE GUI
	additGUI.window = guiCreateWindow(sW / 2 + 339 / 2 + 5, sH / 2 - 350 / 2, 319, 248, "Dodaj nowy opis", false)
	additGUI.opis = guiCreateLabel(10, 26, 115, 19, "Tytuł opisu:", false, additGUI.window)
	additGUI.opis2 = guiCreateLabel(10, 74, 115, 19, "Treść opisu:", false, additGUI.window)
	additGUI.tresc = guiCreateMemo(10, 93, 299, 92, "", false, additGUI.window)
	additGUI.tytul = guiCreateEdit(10, 45, 299, 23, "", false, additGUI.window)
	additGUI.dodaj = guiCreateButton(10, 195, 299, 43, "Dodaj nowy opis", false, additGUI.window)

	guiWindowSetSizable(additGUI.window, false)
	guiWindowSetMovable(additGUI.window, false)

	exports.titan_cursor:showCustomCursor("descriptionsMain")


	-- EVENTY NA GUI
	addEventHandler("onClientGUIClick", mainGUI.lista, descFunc.clickOnDesc, false)

	addEventHandler("onClientGUIClick", mainGUI.buttonZamknij, descFunc.removeGUI, false)
	addEventHandler("onClientGUIClick", mainGUI.buttonUsun, descFunc.clickOnDelete, false)
	addEventHandler("onClientGUIClick", mainGUI.buttonGracz, descFunc.clickOnChar, false)
	addEventHandler("onClientGUIClick", mainGUI.buttonPojazd, descFunc.clickOnVeh, false)
	addEventHandler("onClientGUIClick", mainGUI.buttonEdytuj, descFunc.clickOnEdit, false)

	addEventHandler("onClientGUIClick", additGUI.dodaj, descFunc.newDesc, false)

	-- ŁADOWAIE ZAPISANYCH OPISÓW
	descFunc.loadAllDesc()
end

function descFunc.removeGUI()
	if isElement(mainGUI.window) then destroyElement(mainGUI.window) end
	if isElement(additGUI.window) then destroyElement(additGUI.window) end
	exports.titan_cursor:hideCustomCursor("descriptionsMain")
	mainGUI = {}
	additGUI = {}
	descData = {}
	return true
end

-- FUNKCJE BUTTONÓW
function descFunc.newDesc()
	local tytul = guiGetText(additGUI.tytul)
	local tresc = guiGetText(additGUI.tresc)

	if string.len(tytul) < 3 then
		exports.titan_noti:showBox("Tytuł opisu musi zawierać przynajmniej 3 znaki.")
		return
	end
	tresc = string.gsub(tresc, "\n", "")
	if string.len(tresc) < 3 then
		exports.titan_noti:showBox("Treść opisu musi zawierać przynajmniej 3 znaki.")
		return
	end

	if string.len(tresc) > 250 then
		exports.titan_noti:showBox("Treść opisu może zawierać maksymalnie 250 znaków.")
		return
	end
	descFunc.addNewDesc(tytul, tresc)
	guiSetText(additGUI.tytul, "")
	guiSetText(additGUI.tresc, "")
end

function descFunc.clickOnChar()
	if getElementData(localPlayer, "playerDesc") then
		setElementData(localPlayer, "playerDesc", false)
		guiSetText(mainGUI.buttonGracz, "Ustaw na postaci")
		exports.titan_noti:showBox("Opis został pomyślnie usunięty.")
		return
	end
	local row = guiGridListGetSelectedItem(mainGUI.lista)
	if row ~= -1 then
		local id = guiGridListGetItemData(mainGUI.lista, row, 1)
		if tonumber(id) then
			local dData = descData[tonumber(id)]
			if type(dData) == "table" then
				setElementData(localPlayer, "playerDesc", tostring(dData.content))
				guiSetText(mainGUI.buttonGracz, "Usuń z postaci")
				exports.titan_noti:showBox("Opis został pomyślnie ustawiony.")

				if isTimer(descData.descTimer) then killTimer(descData.descTimer) end
				setElementData(localPlayer, "previewDesc", true)
				descData.descTimer = setTimer(function() setElementData(localPlayer, "previewDesc", false) end, 10000, 1)
			end
		end
	end
end

function descFunc.clickOnVeh()
	if not isPedInVehicle(localPlayer) then return exports.titan_noti:showBox("Nie jesteś w pojeździe.") end
	if getVehicleOccupant(getPedOccupiedVehicle(localPlayer)) ~= localPlayer then return exports.titan_noti:showBox("Nie jesteś kierowcą pojazdu.") end
	local veh = getPedOccupiedVehicle(localPlayer)
	if getElementData(veh, "vehDesc") then
		setElementData(veh, "vehDesc", false)
		guiSetText(mainGUI.buttonPojazd, "Ustaw na pojeździe")
		exports.titan_noti:showBox("Opis został pomyślnie usunięty.")
		return
	end
	local row = guiGridListGetSelectedItem(mainGUI.lista)
	if row ~= -1 then
		local id = guiGridListGetItemData(mainGUI.lista, row, 1)
		if tonumber(id) then
			local dData = descData[tonumber(id)]
			if type(dData) == "table" then
				setElementData(veh, "vehDesc", tostring(dData.content))
				guiSetText(mainGUI.buttonPojazd, "Usuń z pojazdu")
				exports.titan_noti:showBox("Opis został pomyślnie ustawiony.")
			end
		end
	end
end

function descFunc.clickOnEdit()
local row = guiGridListGetSelectedItem(mainGUI.lista)
	if row ~= -1 then
		local id = guiGridListGetItemData(mainGUI.lista, row, 1)
		if tonumber(id) then
			local dData = descData[tonumber(id)]
			if type(dData) == "table" then
			guiSetEnabled(additGUI.tytul, true)
			guiSetEnabled(additGUI.tresc, true)
			guiSetEnabled(additGUI.dodaj, true)
			end
		end
	end
end

function descFunc.clickOnDelete()
	local row = guiGridListGetSelectedItem(mainGUI.lista)
	if row ~= -1 then
		local id = guiGridListGetItemData(mainGUI.lista, row, 1)
		if tonumber(id) then
			descFunc.deleteDesc(tonumber(id))
		end
	end
end

function descFunc.clickOnDesc()
	local row = guiGridListGetSelectedItem(mainGUI.lista)
	if row == -1 then
		guiSetText(additGUI.tytul, "")
		guiSetText(additGUI.tresc, "")

		guiSetEnabled(additGUI.tytul, true)
		guiSetEnabled(additGUI.tresc, true)
		guiSetEnabled(additGUI.dodaj, true)
		return
	end

	local id = guiGridListGetItemData(mainGUI.lista, row, 1)
	if tonumber(id) then
		local dData = descData[tonumber(id)]
		if type(dData) == "table" then
			guiSetText(additGUI.tytul, dData.title)
			guiSetText(additGUI.tresc, dData.content)

			guiSetEnabled(additGUI.tytul, false)
			guiSetEnabled(additGUI.tresc, false)
			guiSetEnabled(additGUI.dodaj, false)
			return
		end
	end
end

-- POZOSTAŁE FUKCJE
function descFunc.getLowestID()
	if not fileExists("client/descriptions.xml") then
		return 1
	else
		local descFile = xmlLoadFile("client/descriptions.xml")
		local descriptions = xmlNodeGetChildren(descFile)
		local i = 1
		while true do
			local hasNumber = false
			for k, v in ipairs(descriptions) do
				local attributes = xmlNodeGetAttributes(v)
				if attributes then
					if tonumber(attributes.id) == i then hasNumber = true end
				end
			end
			if not hasNumber then return i end
			i = i + 1
		end
	end
end

function descFunc.loadAllDesc()
	if fileExists("client/descriptions.xml") then
		local descFile = xmlLoadFile("client/descriptions.xml")
		local descriptions = xmlNodeGetChildren(descFile)
		for k, v in ipairs(descriptions) do
			local attributes = xmlNodeGetAttributes(v)
			if attributes then
				descData[tonumber(attributes.id)] =
				{
					title = tostring(attributes.title),
					content = tostring(attributes.content)
				}
				if isElement(mainGUI.lista) then
					local row = guiGridListAddRow(mainGUI.lista)
					guiGridListSetItemText(mainGUI.lista, row, 1, tostring(attributes.title), false, false)
					guiGridListSetItemData(mainGUI.lista, row, 1, tonumber(attributes.id))
				end
			end
		end
	end
end

function descFunc.deleteDesc(id)
	descData[tonumber(id)] = nil

	guiSetText(additGUI.tytul, "")
	guiSetText(additGUI.tresc, "")

	guiSetEnabled(additGUI.tytul, true)
	guiSetEnabled(additGUI.tresc, true)
	guiSetEnabled(additGUI.dodaj, true)

	guiGridListRemoveRow(mainGUI.lista, guiGridListGetSelectedItem(mainGUI.lista))

	if fileExists("client/descriptions.xml") then
		local descFile = xmlLoadFile("client/descriptions.xml")
		local descriptions = xmlNodeGetChildren(descFile)
		for k, v in ipairs(descriptions) do
			local attributes = xmlNodeGetAttributes(v)
			if attributes then
				if tonumber(attributes.id) == tonumber(id) then
					xmlDestroyNode(v)
					xmlSaveFile(descFile)
					xmlUnloadFile(descFile)
					return true
				end
			end
		end
	end
	xmlUnloadFile(descFile)
	return false
end

function descFunc.addNewDesc(title, content)
	local descFile
	if not fileExists("client/descriptions.xml") then
		descFile = xmlCreateFile("client/descriptions.xml", "descriptions")
	else
		descFile = xmlLoadFile("client/descriptions.xml")
	end

	if descFile then
		local id = descFunc.getLowestID()
		if tonumber(id) then
			local node = xmlCreateChild(descFile, "desc")
			if node then
				xmlNodeSetAttribute(node, "id", id)
				xmlNodeSetAttribute(node, "title", title)
				xmlNodeSetAttribute(node, "content", content)

				xmlSaveFile(descFile)
				xmlUnloadFile(descFile)

				descData[id] = 
				{
					title = title,
					content = content
				}

				if isElement(mainGUI.lista) then
					local row = guiGridListAddRow(mainGUI.lista)
					guiGridListSetItemText(mainGUI.lista, row, 1, title, false, false)
					guiGridListSetItemData(mainGUI.lista, row, 1, tonumber(id))
				end
			end
		end
	end
end

function cmdOpis()
	descFunc.create()
end
addCommandHandler("opis", cmdOpis, false, false)