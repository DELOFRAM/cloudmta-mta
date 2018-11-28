----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

GUIEditGroup = {}
editGroupFunc = {}
local groupPerms = 
{
	["chatic"] 			= "Radio IC", --							@DONE
	["chatooc"] 		= "Czat OOC", --							@DONE
	["chatdept"] 		= "Radio Departamentowe", --				@DONE
	["orders"]			= "Zamawianie przedmiotów", --				@DONE
	["tax"] 			= "Odprowadzanie podatków", --				@LATE
	["cduty"] 			= "Tag grupy w nicku", --					@DONE
	["search"] 			= "Przeszukiwanie graczy", --				@DONE
	["arrest"] 			= "Aresztowanie graczy", --					@DONE
	["ediall"] 			= "Listowanie na /call 911", --				@DONE
	["bdiall"] 			= "Listowanie na /call 4444", -- 			@DONE
	["vehfix"] 			= "Naprawanie pojazdów", --					@TODO
	["tickets"] 		= "Wydawanie mandatów", --					@DONE
	["news"] 			= "Panel newsów", --						@DONE
	["phoneloc"] 		= "Lokalizowanie telefonów", --				@TODO
	["vehblock"] 		= "Blokady na koło", --						@DONE
	["blockade"] 		= "Blokady z obiektów", --					@DONE
	["cpr"] 			= "Reanimacja", --							@DONE
	["heal"]			= "Oferowanie leczenia", --					@DONE
	["gps"] 			= "GPS w pojazdach", --						@DONE
	["itemsteal"]		= "Zabieranie przedmiotów", --				@DONE
	["carsalon"] 		= "Salon samochodowy", -- 					@TODO
	["objects"]			= "Tworzenie obiektów w interiorze", -- 	@TODO
	["bodies"] 			= "Badanie zwłok", -- 						@DONE
	["gangorders"] 		= "Zamawianie przedmiotów (gangi)", --		@DONE
	["give"] 			= "Wydawanie przedmiotów", -- 				@DONE
	["dashcam"] 		= "Używanie dashcamu w pojazdach", --		@DONE
	["gangzones"] 		= "Strefy (gangzones)", --					@DONE
	["blockleave"] 		= "Blokowanie opuszczania grupy", -- 		@DONE
	["taxi"] 			= "Uprawnienia taksówkarza", -- 		 	@TODO
	["interview"] 		= "Przeprowadzanie wywiadów", -- 		 	@DONE
	["sendad"] 			= "Publikowanie reklam", -- 		 		@DONE
	--["listTag"] 		= "Listowanie tagu grupy", -- 		 		@DONE
	--["listColor"] 		= "Listowanie koloru grupy", -- 		 	@DONE
	--["listBalance"] 	= "Listowanie stanu konta", -- 		 		@DONE
	--["listPerms"] 		= "Listowanie uprawnień", -- 		 		@DONE
	--["criminal"] 		= "Grupa przestępcza" -- 		 			@DONE
	["kolczatka"] 		= "Dostęp do kolczatek",
	["DeportPlayer"] 	= "Dostęp do deportacji",
	["intduty"]			= "Duty tylko w interiorze grupy",
	["gym"]				= "Uprawnienia siłowni",
	["courier"]			= "Uprawnienia kuriera",
	["spawn"]			= "Spawn w budynku grupy"

}

function editGroupFunc.create(groupInfo)
	local sW, sH = guiGetScreenSize()
	if GUIEditGroup.showing then return end
	if(isElement(GUIEditGroup.okno)) then destroyElement(GUIEditGroup.okno) end
	GUIEditGroup.okno = guiCreateWindow(sW / 2 - 471 / 2, sH / 2 - 396 / 2, 471, 396, string.format("Edycja grupy - %s (ID: %d)", groupInfo.name, groupInfo.ID), false)
	guiWindowSetSizable(GUIEditGroup.okno, false)
	GUIEditGroup.label = {}
	GUIEditGroup.label[1] = guiCreateLabel(15, 27, 133, 17, "Nazwa", false, GUIEditGroup.okno)
	GUIEditGroup.label[2] = guiCreateLabel(15, 82, 133, 17, "Tag grupy", false, GUIEditGroup.okno)
	GUIEditGroup.label[3] = guiCreateLabel(15, 137, 133, 17, "Kolor grupy", false, GUIEditGroup.okno)
	GUIEditGroup.label[4] = guiCreateLabel(267, 27, 133, 17, "Uprawnienia", false, GUIEditGroup.okno)

	GUIEditGroup.groupName = guiCreateEdit(15, 44, 213, 28, groupInfo.name, false, GUIEditGroup.okno)
	GUIEditGroup.groupTag = guiCreateEdit(15, 99, 213, 28, groupInfo.tag, false, GUIEditGroup.okno)
	GUIEditGroup.groupColorR = guiCreateEdit(15, 154, 44, 28, groupInfo.r, false, GUIEditGroup.okno)
	GUIEditGroup.groupColorG = guiCreateEdit(69, 154, 44, 28, groupInfo.g, false, GUIEditGroup.okno)
	GUIEditGroup.groupColorB = guiCreateEdit(123, 154, 44, 28, groupInfo.b, false, GUIEditGroup.okno)

	GUIEditGroup.groupInfo = groupInfo

	GUIEditGroup.groupScrollPanel = guiCreateScrollPane(267, 54, 194, 332, false, GUIEditGroup.okno)
	GUIEditGroup.checkbox = {}
	GUIEditGroup.newPerms = {}
	local i = 0
	for k, v in pairs(groupPerms) do
		i = i + 1
		GUIEditGroup.checkbox[i] = guiCreateCheckBox(10, 10 + (28 * (i - 1)), 174, 28, v, false, false, GUIEditGroup.groupScrollPanel)
		setElementData(GUIEditGroup.checkbox[i], "isGroupPerm", true)
		setElementData(GUIEditGroup.checkbox[i], "name", k)
		if(groupInfo.perms[k]) then
			guiCheckBoxSetSelected(GUIEditGroup.checkbox[i], true)
			GUIEditGroup.newPerms[k] = true
		end
		addEventHandler("onClientGUIClick", GUIEditGroup.checkbox[i], editGroupFunc.changed, false)
	end
	GUIEditGroup.save = guiCreateButton(13, 357, 90, 29, "Zapisz", false, GUIEditGroup.okno)
	GUIEditGroup.cancel = guiCreateButton(113, 357, 90, 29, "Anuluj", false, GUIEditGroup.okno)
	addEventHandler("onClientGUIClick", GUIEditGroup.cancel, editGroupFunc.cancel, false)
	addEventHandler("onClientGUIClick", GUIEditGroup.save, editGroupFunc.save, false)
	exports.titan_cursor:showCustomCursor("adminEditGroup")
	GUIEditGroup.showing = true
end
addEvent("editGroupFunc.create", true)
addEventHandler("editGroupFunc.create", root, editGroupFunc.create)

function editGroupFunc.cancel()
	if(isElement(GUIEditGroup.okno)) then destroyElement(GUIEditGroup.okno) end
	GUIEditGroup = {}
	exports.titan_cursor:hideCustomCursor("adminEditGroup")
	GUIEditGroup.showing = false
	return
end

function editGroupFunc.changed()
	if(getElementData(source, "isGroupPerm")) then
		if(guiCheckBoxGetSelected(source)) then
			GUIEditGroup.newPerms[getElementData(source, "name")] = true
		else
			GUIEditGroup.newPerms[getElementData(source, "name")] = nil
		end
	end
end

function editGroupFunc.save()
	local name = guiGetText(GUIEditGroup.groupName)
	local tag = guiGetText(GUIEditGroup.groupTag)
	local colorR = guiGetText(GUIEditGroup.groupColorR)
	local colorG = guiGetText(GUIEditGroup.groupColorG)
	local colorB = guiGetText(GUIEditGroup.groupColorB)

	if(string.len(name) < 3) then
		exports.titan_noti:showBox("Nazwa grupy musi mieć przynajmniej 3 znaki.")
		return
	end
	if(string.len(tag) < 3 or string.len(tag) > 5) then
		exports.titan_noti:showBox("Tag grupy musi mieć od 3 do 5 znaków.")
		return
	end
	if(not tonumber(colorR) or not tonumber(colorG) or not tonumber(colorB)) then
		exports.titan_noti:showBox("Kolor może być zapisany tylko w formie numerycznej.")
		return
	end
	colorR = tonumber(colorR)
	colorG = tonumber(colorG)
	colorB = tonumber(colorB)

	if(colorR < 0 or colorR > 255 or colorG < 0 or colorG > 255 or colorB < 0 or colorB > 255) then
		exports.titan_noti:showBox("Kolor może zawierać się w przedziale od 0 do 255.")
		return
	end
	triggerServerEvent("groupEdit.save", localPlayer, GUIEditGroup.groupInfo.ID, name, tag, colorR, colorG, colorB, GUIEditGroup.newPerms)
	editGroupFunc.cancel()
end