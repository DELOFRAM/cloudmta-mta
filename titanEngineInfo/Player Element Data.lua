--[[
	
	--= int loggedIn =--
		1 - gracz jest zalogowany i wybrał postać
		2 - gracz zalogował się i jest w trakcie wybierania postaci

	--= int memberID =--
		ID konta globalnego gracza

	--= string globalName =--
		Nazwa użytkownika konta globalnego gracza

	--= int charID =--
		ID postaci gracza

	--= string name =--
		Imię gracza

	--= string lastname =--
		Nazwisko gracza

	--= int money =--
		Hajsy gracza.

	--= table lastPos =--
		[1] - ostatnia pozycja X gracza
		[2] - ostatnia pozycja Y gracza
		[3] - ostatnia pozycja Z gracza
		[4] - ostatnia pozycja rZ gracza
		[5] - ostatni VirtualWorld gracza
		[6] - ostatni interior gracza

	--= int skin =--
		Skin gracza

	--= int bwTime =--
		Czas BW gracza (jeśli 0 - brak BW, w przeciwnym wypadku czas w sekundach)

	--= int adminLevel =--
		Poziom administratora

	--= bool adminDuty =--
		Duty administratora

	--= timer damageColorNickTimer =--
		Timer dla podświetlania koloru w trakcie zdobycia obrażeń.

	--= bool damageColorNick =--
		Kolor podświetlenia nicku.

	--= int taserID =--
		ID broni, która użyta jest jako taser.

	--= timer taserTimer =--
		Timer, zamrożenie gracza.
	
	--= element cuffedBy =--
		Gracz, przez którego jesteśmy skuci.

	--= element cuffedPlayer =--
		Gracz, którego skuliśmy.

	--= int groupDutyID =--
		ID grupy, na której duty jesteśmy.

	--= string GroupDutyTag =--
		Tag grupy, na której duty jesteśmy.

	--= table groupDutyColor =--
		Kolor grupy, na której duty jesteśmy.
		[1] - red
		[2] - green
		[3] - blue

	--= string playerDesc =--
		Opis gracza.

	--= int nearestDoorID =--
		ID drzwi, w których strefie stoimy.

	--= int nearestDoorType =--
		Typ drzwi, w których strefie stoimy.
			int 1 - drzwi wejściowe
			int 2 - drzwi wyjściowe
			bool false - nie stoimy przy żadnych drzwiach

	--= bool enteringDoor =--
		Bool przedstawiający, czy gracz aktualnie wchodzi do drzwi.

	--= int onlineTime =--
		Czas gracza online.

	--= int afkTime =--
		Przeafczony czas na serwezre. 

	--= bool isAFK =--
		Czy gracz aktualnie jest na AFK.

	--= element courierBlip =--
		Element dla kuriera.

	--= int/bool courierPackID =--
		ID przesyłki aktualnie dostarczanej.

	--= table courierTable =--
		[1] - element markeru.
		[2] - element blipa.

	--= table locateVeh =--
		[1] - vehID pojazdu.
		[2] - element pojazdu.
		[3] - blip ojazdu.

	--= table repairedVehicle =--
		False, jeśli nie dotyczy.
		[1] - ID pojazdu, który naprawia gracz.
		[2] - Element pojazdu, który naprawia gracz.
	
	--= bool/int boomboxID =--
		ID przedmiotu boomboxa, który gracz ma aktualnie w użyciu. False, jeśli nie używa.

	--= bool vehGUIOpened =--
		Czy gui pojazdów jest otwarte.

	--= bool itemGUIOpened =--
		Czy gui przedmiotów jest otwarte.

	--= element phoneCallElem =--
		Element gracza z którym gadasz przez telefon.

	--= bool belts =--
		Czy pasy są zapięte.

	--= int ajTime =--
		Czas AJ w sekundach.

	--= int cloudPoints =--
		Ilość cloudPoints.

	--= int playerID =--
		ID gracza na serwerze.

	--= int defaultSkin =--
		Domyślny skin, niezmienialny itd.

	--= table adminPerms =--
		Permy adminstratora.

	--= bool gloves =--
		Czy ma rękawiczki na łapach czy nie.

	--= int accountID =--
		Numer konta bankowego pis joł.

	--= int accountMoney =--
		Hajs na koncie bankowym pis joł.

	--= bool isPW =--
		Bool wskazujący na to, czy wysłałeś PW w ostatnim czasie (2 sek).

	--= timer pwTimer =--
		Timer zmieniający wartość isPW na false (2 sek).

	--= int hungryLevel =--
		Poziom zapełnienia paska głodu
		
	--= bool hasAnim =--
		Bool wskazujący, czy dany gracz ma włączoną informację.
		
	--= float anim.x =--
		Pozycja X animacji gracza
		
	--= float anim.y =--
		Pozycja Y animacji gracza
		
	--= float anim.z =--
		Pozycja Z animacji gracza

	--= table/bool ssn =--
		jeśli table:
			[1] = SSN dowodu
			[2] = Data wydania
		jeśli bool:
			- false: Brak dowodu
			
	--= bool isHungry
		Bool wskazujący czy gracz ma mniej lub 15% HP i 0 punktów głodu.
		
	--= int currentDoorID
		Numer UID drzwi w których się właśnie znajdujemy, jeżeli żadne to zwraca 0.
		
	--= table weaponsAttach
		Tabela z informacjami o przypisanych broniach.
	
	--= element/nil healedBy
		element gracza przez którego jest obecnie leczony
	
	--= element/nil playerHealing
		element gracza którego właśnie postać leczy
]]--