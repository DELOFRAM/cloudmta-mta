local adminHelperGUI = {}
local adminCommandsList = {}


adminCommandsList["Administrator"] = {
{"/ablock", "/ablock [char/veh/unveh/ooc/unooc/run/unrun]", "Blokady (postaci/pojazdów/zdjęcia blokady pojazdów/ooc/zdjęcia blokady ooc/biegania/zdjęcie blokady biegania)"},
{"/aban", "/aban [ID gracza] [czas (w dniach), 0 - perm] [powód]", "Banuje konto gracza"},
{"/aduty", "/aduty", "Rozpoczęcie oraz zakończenie służby Ekipy"},
{"/afly", "/afly", "włączanie/wyłączanie trybu latania"},
{"/abus", "/abus [ID obiektu] [Nazwa przystanku]", "Tworzenie przystanku autobusowego (wymagany obiekt)"},
{"/ainv", "/ainv", "włączanie/wyłączanie znikania postaci"},
{"/aj", "/aj [ID gracza] [czas (w minutach)] [powód]", "wrzucanie gracza do Admin Jaila"},
{"/unaj", "/unaj [ID gracza] [powód]", "wyciąganie gracza z Admin Jaila"},
{"/akick", "/akick [ID gracza] [powód]", "wyrzucanie gracza z serwera"},
{"/areport", "/areport", "otwieranie panelu logów"},
{"/amaster", "/amaster [login] [hasło] ", "logowanie na konto MTA"},
{"/aset", "/aset [int/vw/hp/admin/addmoney/cp/time/weather/skin/nick]", "ustawianie danych wartości (interior/virtual world/uprawnienia administratorów/pieniądze/cloudPointsy/czas/pogoda/skin/nick)"},
{"/aslap", "/aslap [ID Gracza]", "podrzucanie gracza do góry"},
{"/aspec", "/aspec [ID Gracza]", "obserwowanie graczy"},
{"/awarn", "/awarn [ID Gracza] [powód]","nakładanie ostrzeżenia na gracza"},
{"/bw", "/bw [ID Gracza] [Czas w sekundach]","nakładanie/zdejmowanie BW"},
{"/tm", "/tm [ID Gracza]","teleportowanie do siebie gracza"},
{"/to", "/to [ID Gracza]","teleportowanie się do gracza"},
{"/glob","/glob [text]","globalna wiadomość OOC"},
{"/ado","/ado [text]","globalna wiadomość IC (opisowa)"},
{"/toint","/toint [numer interioru]","teleportuje do wybranego interioru"},
{"/tpt","/tpt [ID teleportowanego] [ID odbiorcy]","teleportuje gracza do wybranego gracza"},
}

adminCommandsList["Control"] = {
{"/ag", "/ag [lista/stworz/usun/edytuj/info/wejdz/kolor]", "zarządzanie grupami"},
{"/ad", "/ad [stworz, ustaw, usun, to, lista, produkt]", "zarządzanie drzwiami"},
{"/av", "/av [info, uid, stworz, usun, klucze, przypisz, kolor1, kolor2, fix, to, tm, flash, siren, alarm, fuel, windows, respawn, rveh, audio, spawn, flip]", "zarządzanie pojazdami"},
{"/ap", "/ap [stworz, ownertypes, itemtypes]", "zarządzanie przedmiotoami"},
{"/ao","/ao [owner]","zarządzanie obiektami"},
{"/as","/as [stwórz, edytuj, usuń, lista]","zarządzanie strefami"},
{"/atext","/atext [lista/stworz]", "zarzadzanie tekstami 3D"},
{"/aped","/aped [stworz, usun]","zarządzanie pedami"},
{"/aareszt","/aareszt [stworz/lista]", "zarządzanie aresztami"},
}

function serachElementGUI(source)
	for i,v in ipairs(adminHelperGUI.Element) do
		if v == source then
			return source
		end
	end
	return false
end

function AdminHelperGUIClickGridlist()
	if serachElementGUI(source) then
		local selecter = guiGridListGetSelectedItem ( source )
		if selecter ~= -1 then
			local command = guiGridListGetItemText ( source, guiGridListGetSelectedItem ( source ), 1 )
			local example = guiGridListGetItemText ( source, guiGridListGetSelectedItem ( source ), 2 )
			local descrpition = guiGridListGetItemText ( source, guiGridListGetSelectedItem ( source ), 3 )
			outputChatBox("---------------------------------------------------")
			outputChatBox("Komenda: "..command)
			outputChatBox("Przykład: "..example)
			outputChatBox("Opis: "..descrpition)
			outputChatBox("---------------------------------------------------")
		end
	end
end

function createHelperGUITab(name, name_list)
local index = #adminHelperGUI.lista+1
adminHelperGUI.zakladka[index] = guiCreateTab(name, adminHelperGUI.tabPanel)
adminHelperGUI.lista[index] = {}
adminHelperGUI.lista[index].grid = guiCreateGridList(0.02, 0.01, 0.97, 0.95, true, adminHelperGUI.zakladka[index])
adminHelperGUI.lista[index].Commands = guiGridListAddColumn(adminHelperGUI.lista[index].grid, "Komenda", 0.20)
adminHelperGUI.lista[index].Example = guiGridListAddColumn(adminHelperGUI.lista[index].grid, "Przykład", 0.56)	
adminHelperGUI.lista[index].Descrpition = guiGridListAddColumn(adminHelperGUI.lista[index].grid, "Opis", 1.5)	
table.insert(adminHelperGUI.Element,adminHelperGUI.lista[index].grid)
	addEventHandler("onClientGUIDoubleClick", adminHelperGUI.lista[index].grid, AdminHelperGUIClickGridlist, false)	
	if adminCommandsList[name_list] ~= nil and #adminCommandsList[name_list] > 0 then
		for i,v in ipairs(adminCommandsList[name_list]) do
			local row = guiGridListAddRow ( adminHelperGUI.lista[index].grid )
			guiGridListSetItemText ( adminHelperGUI.lista[index].grid, row, adminHelperGUI.lista[index].Commands, v[1], false, false)
			guiGridListSetItemText ( adminHelperGUI.lista[index].grid, row, adminHelperGUI.lista[index].Example, v[2], false, false)
			guiGridListSetItemText ( adminHelperGUI.lista[index].grid, row, adminHelperGUI.lista[index].Descrpition, v[3], false, false)				
		end
	end
end


function showAdminHelperGUI(data)
	if isElement(adminHelperGUI.window) then closeAdminHelperGUI() end
	adminHelperGUI.zakladka = {}
	adminHelperGUI.lista = {}
	adminHelperGUI.Element = {}

	adminHelperGUI.window = guiCreateWindow(0.31, 0.31, 0.39, 0.42, "Komepedium komend Ekipy cloudMTA", true)
	adminHelperGUI.tabPanel = guiCreateTabPanel(0.01, 0.06, 0.97, 0.91, true, adminHelperGUI.window)
	
	createHelperGUITab("Ogólne", "Administrator")
	createHelperGUITab("Zarządzania", "Control")

	guiSetProperty(adminHelperGUI.close, "NormalTextColour", "FFAAAAAA")
	addEventHandler("onClientGUIClick", adminHelperGUI.close, closeAdminHelperGUI, false)
	bindKey("enter", "down", closeAdminHelperGUI)
	exports.titan_cursor:showCustomCursor("adminHelperGUI")
	exports.titan_noti:showBox("Aby zamknąć panel wcisnij klawisz 'enter'")
end
addEvent("adminHelperGUI", true)
addEventHandler("adminHelperGUI", root, showAdminHelperGUI)

function closeAdminHelperGUI()
	if isElement(adminHelperGUI.window) then destroyElement(adminHelperGUI.window) end
	exports.titan_cursor:hideCustomCursor("adminHelperGUI")
	adminHelperGUI = {}
	unbindKey("enter", "down", closeAdminsGUI)
end