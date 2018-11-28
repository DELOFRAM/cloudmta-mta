----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local GUI = {}
function createGroupInfoGUI(data, playerPerms, admin, ranks)
	closeGroupInfoGUI()
	local sW, sH = guiGetScreenSize()
	GUI.okno = guiCreateWindow(sW / 2 - 423 / 2, sH / 2 - 492 / 2, 423, 492, "Informacje o grupie", false)
	guiWindowSetSizable(GUI.okno, false)
	GUI.lista = guiCreateGridList(10, 29, 403, 398, false, GUI.okno)
	GUI.cancel = guiCreateButton(10, 437, 403, 38, "Zamknij", false, GUI.okno)
	guiGridListSetSortingEnabled(GUI.lista, false)
	addEventHandler("onClientGUIClick", GUI.cancel, closeGroupInfoGUI, false)
	exports.titan_cursor:showCustomCursor("orgsClientGroupInfo")

	GUI.column1 = guiGridListAddColumn(GUI.lista, "Nazwa", 0.45)
	GUI.column2 = guiGridListAddColumn(GUI.lista, "Wartość", 0.5)
	guiGridListAddRow(GUI.lista)
	guiGridListSetItemText(GUI.lista, 0, GUI.column1, "Informacje podstawowe", true, false)
	--
		local row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "UID", false, false)
		guiGridListSetItemText(GUI.lista, row, GUI.column2, data.ID, false, false)
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "Nazwa grupy", false, false)
		guiGridListSetItemText(GUI.lista, row, GUI.column2, data.name, false, false)
		--if data.perms["listTag"] == nil then else
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "Tag grupy", false, false)
		guiGridListSetItemText(GUI.lista, row, GUI.column2, data.tag, false, false)
		--end
		--if data.perms["listTag"] == nil then else
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "Kolor grupy", false, false)
		guiGridListSetItemText(GUI.lista, row, GUI.column2, string.format("rgb(%d, %d, %d)", data.r, data.g, data.b), false, false)
		guiGridListSetItemColor(GUI.lista, row, GUI.column2, data.r, data.g, data.b)
		--end
		--if data.perms["listBalance"] == nil then else
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "Konto bankowe", false, false)
		guiGridListSetItemText(GUI.lista, row, GUI.column2, string.format("$%d", data.account), false, false)
		--end
	--
	-- if data.perms["listPerms"] == true then
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, " ", true, false)
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "Uprawnienia", true, false)
		--
			if(type(data.perms) == "table") then
				for k, v in pairs(data.perms) do
					if(v) then
						row = guiGridListAddRow(GUI.lista)
						guiGridListSetItemText(GUI.lista, row, GUI.column1, string.format("• %s", getGroupPermsInfo(k)), false, false)
					end
				end
			else
				row = guiGridListAddRow(GUI.lista)
				guiGridListSetItemText(GUI.lista, row, GUI.column1, "• Brak", false, false)
			end
		--
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, " ", true, false)
	-- end
	if admin then
		row = guiGridListAddRow(GUI.lista)
		guiGridListSetItemText(GUI.lista, row, GUI.column1, "Rangi grupy", true, false)
		if type(ranks) == "table" then
			for k, v in ipairs(ranks) do
				row = guiGridListAddRow(GUI.lista)
				guiGridListSetItemText(GUI.lista, row, GUI.column1, string.format("UID: %d %s", v.ID, v.defaultRank == 1 and "(Default)" or ""), false, false)
				guiGridListSetItemText(GUI.lista, row, GUI.column2, string.format("%s", v.name), false, false)
			end
		else
			row = guiGridListAddRow(GUI.lista)
			guiGridListSetItemText(GUI.lista, row, GUI.column1, "• Brak", false, false)
		end
	end
end
addEvent("createGroupInfoGUI", true)
addEventHandler("createGroupInfoGUI", root, createGroupInfoGUI)

function closeGroupInfoGUI()
	if(isElement(GUI.okno)) then destroyElement(GUI.okno) end
	GUI = {}
	exports.titan_cursor:hideCustomCursor("orgsClientGroupInfo")
end

function getGroupPermsInfo(perm)
	local groupPerms = {}
	groupPerms["chatic"] 			= "Radio IC" --							
	groupPerms["chatooc"] 			= "Czat OOC" --							
	groupPerms["chatdept"] 			= "Radio Departamentowe" --				
	groupPerms["orders"]			= "Zamawianie przedmiotów" --				
	groupPerms["tax"] 				= "Odprowadzanie podatków" --				
	groupPerms["cduty"] 			= "Tag grupy w nicku" --					
	groupPerms["search"] 			= "Przeszukiwanie graczy" --				
	groupPerms["arrest"] 			= "Aresztowanie graczy" --					
	groupPerms["ediall"] 			= "Listowanie na /call 911" --				
	groupPerms["bdiall"] 			= "Listowanie na /call 4444" -- 			
	groupPerms["vehfix"] 			= "Naprawanie pojazdów" --					
	groupPerms["tickets"] 			= "Wydawanie mandatów" --					
	groupPerms["news"] 				= "Panel newsów" --						
	groupPerms["phoneloc"] 			= "Lokalizowanie telefonów" --				
	groupPerms["vehblock"] 			= "Blokady na koło" --						
	groupPerms["blockade"] 			= "Blokady z obiektów" --					
	groupPerms["cpr"] 				= "Reanimacja" --							
	groupPerms["heal"]				= "Oferowanie leczenia" --					
	groupPerms["gps"] 				= "GPS w pojazdach" --						
	groupPerms["itemsteal"]			= "Zabieranie przedmiotów" --				
	groupPerms["carsalon"] 			= "Salon samochodowy" -- 					
	groupPerms["objects"]			= "Tworzenie obiektów w interiorze" -- 	
	groupPerms["bodies"] 			= "Badanie zwłok" -- 						
	groupPerms["gangorders"] 		= "Zamawianie przedmiotów (gangi)" --		
	groupPerms["give"] 				= "Wydawanie przedmiotów" -- 				
	groupPerms["dashcam"] 			= "Używanie dashcamu" --		
	groupPerms["gangzones"] 		= "Strefy (gangzones)" --					
	groupPerms["blockleave"] 		= "Blokowanie opuszczania grupy" -- 		
	groupPerms["taxi"] 				= "Uprawnienia taksówkarza" -- 		 	
	groupPerms["interview"] 		= "Przeprowadzanie wywiadów" -- 		 	
	groupPerms["sendad"] 			= "Publikowanie reklam" -- 		 			
	groupPerms["doorduty"] 			= "Służba tylko wewnątrz pomieszczenia"
	groupPerms["meg"] 				= "Megafon"
	groupPerms["cuff"] 				= "Skuwanie"
	groupPerms["offer"]				= "Dostęp do oferowania"
	groupPerms["offerdoc"]			= "Wydawanie dokumentów"
	groupPerms["vehplates"] 		= "Rejestracja pojazdu"
	groupPerms["doorcre"] 			= "Tworzenie drzwi"
	groupPerms["groupcre"] 			= "Tworzenie grup"
	groupPerms["sdoc"] 				= "Oferowanie dokumentów specjalnych" -- Pozwolenie na broń
	groupPerms["taxi"] 				= "Oferowanie przejazdu"
	groupPerms["gym"] 				= "Oferowanie treningu"
	groupPerms["clothes"] 			= "Sklep z ubraniami"
	groupPerms["24/7"] 				= "Sklep 24/7"
	groupPerms["ladder"] 			= "Dostęp do drabin"
	groupPerms["Race"] 				= "Tworzenie wyścigów" -- Kwestia do obgadania
	groupPerms["logistic"] 			= "Dostęp do pracy kuriera" -- Wersja dla grupy
	groupPerms["mask"] 				= "Używanie kominiarek"
	groupPerms["Build"] 			= "Możliwość budowania" -- do obgadania.
	groupPerms["Sirene"] 			= "Dostęp do syren w pojadach grupowych"
	groupPerms["doorram"] 			= "Możliwośc wyważania zamkniętych drzwi"
	groupPerms["dtax"] 				= "Ściąganie podatków z grupy"
	groupPerms["carsalon"] 			= "Sprzedaż pojazdów" -- Salon samochodowy
	groupPerms["DrugCorners"] 		= "Dostęp do cornerów gangowych" -- System do obgadania
	groupPerms["kolczatka"] 		= "Dostęp do kolczatek"
	groupPerms["DeportPlayer"] 		= "Dostęp do deportacji"

	if(groupPerms[perm]) then return groupPerms[perm] else return "???" end
end

