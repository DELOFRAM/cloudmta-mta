--[[
	No to tutaj będziemy sobie pisać permy.

	Permy dla graczy.

	leader - czy jest liderem
	vehicles - czy może używać pojazdów
	doors - czy może zamykać drzwi
	icchat - czat IC
	oocchat - czat OOC
	deliver - czy może ogarniac zamówienia.
	depochat - czat departamentowy.



	Permy dla grup.

	deliver - zamówienia.
	depochat - czat departamentowy.
	vehblock - blokady na koło.
	arrest - areszt.

]]--

	local groupPerms = {}
	groupPerms["ChatIC"] = "Czat In Character"
	groupPerms["ChatOOC"] = "Czat Out of Character"
	groupPerms["ChatDept"] = "Czat Departamentowy"
	groupPerms["Orders"] = "Zamawianie produktów"
	groupPerms["Tax"] = "Zobowiązany do odprowadzania podatku"
	--groupPerms["CDuty"] = "Kolorowy nick podczas służby"
	--groupPerms["DoorDuty"] = "Służba tylko wewnątrz pomieszczenia"
	groupPerms["Meg"] = "Megafon"
	groupPerms["Search"] = "Przeszukiwanie"
	--groupPerms["Cuff"] = "Skuwanie"
	groupPerms["Arrest"] = "Przetrzymywanie"
	groupPerms["EDiall"] = "Listowanie grupy na 911"
	groupPerms["BDiall"] = "Listowanie grupy na 4444" -- Numer do biznesów jest do uzgodniwnia.
	groupPerms["Offer"] = "Dostęp do oferowania"
	groupPerms["VehFix"] = "Naprawianie pojazdów"
	--groupPerms["Weapon"] = "Używanie oflagowanej broni"
	groupPerms["OfferDoc"] = "Wydawanie dokumentów"
	groupPerms["VehPlates"] = "Rejestracja pojazdu"
	groupPerms["Tickets"] = "Wydawanie mandatów"
	groupPerms["News"] = "Newsy"
	--groupPerms["DoorCre"] = "Tworzenie drzwi"
	--groupPerms["GroupCre"] = "Tworzenie grup"
	groupPerms["SDoc"] = "Oferowanie dokumentów specjalnych" -- Pozwolenie na broń
	groupPerms["PhoneLoc"] = "Lokalizowanie telefonów"
	groupPerms["Taxi"] = "Oferowanie przejazdu"
	groupPerms["Gym"] = "Oferowanie treningu"
	--groupPerms["Clothes"] = "Sklep z ubraniami"
	--groupPerms["24/7"] = "Sklep 24/7"
	groupPerms["VehBlock"] = "Blokady na koło"
	groupPerms["Blockade"] = "Blokady"
	groupPerms["Ladder"] = "Dostęp do drabin"
	groupPerms["ItemSteal"] = "Zabieranie przedmiotów"
	--groupPerms["Race"] = "Tworzenie wyścigów" -- Kwestia do obgadania
	groupPerms["Logistic"] = "Dostęp do pracy kuriera" -- Wersja dla grupy
	groupPerms["CPR"] = "Reanimacja"
	groupPerms["Heal"] = "Oferowanie leczenia"
	groupPerms["GPS"] = "Namierzanie pojazdów grupy"
	groupPerms["Mask"] = "Używanie kominiarek"
	--groupPerms["Build"] = "Możliwość budowania" -- do obgadania.
	--groupPerms["Sirene"] = "Dostęp do syren w pojadach grupowych"
	groupPerms["DoorRam"] = "Możliwośc wyważania zamkniętych drzwi"
	groupPerms["DTax"] = "Ściąganie podatków z grupy"
	groupPerms["CarSalon"] = "Sprzedaż pojazdów" -- Salon samochodowy
	groupPerms["kolczatka"] = "Dostęp do kolczatek"
	groupPerms["DeportPlayer"] = "Dostęp do deportacji"
	--gropuPerms["DrugCorners"] = "Dostęp do cornerów gangowych" -- System do obgadania