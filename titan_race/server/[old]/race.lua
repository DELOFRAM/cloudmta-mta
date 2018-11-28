--[[ 
 * Copyright (C) 2012, Mati All rights reserved.
 *
 * File:    race.lua
 * Desc:    Skrypt umożliwiający tworzenie własnych wyścigów
 * Version: 1.0
 * Author:  Mati
 * 
 * For commercial use
 *
 --]]

local ClassRace = {}
ClassRace.list = {} --Lista obecnych wyścigów
ClassRace.pRaces = {}
ClassRace.lastRaceID = 0

function ClassRace.newRaceCmd( player, commandName, ... ) 
	if not (isPlayerInGroupType(player,15)) then 
		return sendWarningMessageServer( player, "Nie jesteś na służbie w grupie ścigantów." )		
	end
	
	local name = table.concat( {...}, " ")
	local name = tostring(name)
	
	if (not name ) or #name < 2 then 
		return sendWarningMessageServer( player, "Wpisz: /nowywyscig (Nazwa)" ) 
	end
	
	local hasRace = ClassRace.hasPlayerRace(player)
	if hasRace then
		return sendWarningMessageServer( player, "Organizujesz już jakiś wyścig, najpierw go zakończ." )
	end
	
	ClassRace.lastRaceID = ClassRace.lastRaceID + 1
	
	ClassRace.list[ClassRace.lastRaceID] = {
		name = name,
		members = {},
		checkpoints = {},
		organisator = player,
		start = false,
		meta = false,
		checkpointsCount = 0,
		membersCount = 1, --bo jestesmy my
		started = false,
		ready = false,
		finishedPlaces = 0 --Będzie liczone podczas zakonczenia wyscigu
	}
	
	ClassRace.pRaces[player] = ClassRace.lastRaceID
	ClassRace.list[ClassRace.lastRaceID].members[player] = true --my automatycznie dolaczamy do wyścigu
	
	sendMessageServer( player, "Stworzyłeś wyścig o nazwie "..name.."." ) 
end	
addCommandHandler("nowywyscig", ClassRace.newRaceCmd )

function ClassRace.hasPlayerRace(player)
	local race = tonumber(ClassRace.pRaces[player])
	if not race then return false end
	return true
end

function ClassRace.editRace( player, commandName, key, value ) 
	if not (isPlayerInGroupType(player,15)) then 
		return sendWarningMessageServer( player, "Nie jesteś na służbie w grupie ścigantów." )		
	end
	
	local key = tostring(key)
	
	if (not key) or ( (key~="meta") and (key~="start") and (key~="punkt") and (key~="zapros") and (key~="pokaz") and (key~="rozpocznij") and (key~="zakoncz") ) then 
		return sendWarningMessageServer( player, "Wpisz: /wyscig (start, meta, punkt, zapros, pokaz, zakoncz, rozpocznij)" ) 
	end
	
	local race = ClassRace.hasPlayerRace(player)
	if not race then
		return sendWarningMessageServer( player, "Nie organizujesz żadnego wyścigu." )
	end
	
	local race = ClassRace.pRaces[player]
	
	local x, y, z = getElementPosition(player)
	local z = z - 0.5
	
	if key == "start" then
		if ClassRace.list[race].ready then
			return sendWarningMessageServer( player, "Nie możesz edytować już wyścigu, został pokazany graczom." )
		end
		
		--
		
		ClassRace.list[race].start = {x,y,z}
		sendMessageServer( player, "Zmieniłeś pozycję startu." ) 
	elseif key == "meta" then
		if ClassRace.list[race].ready then
			return sendWarningMessageServer( player, "Nie możesz edytować już wyścigu, został pokazany graczom." )
		end
		
		--
		
		sendMessageServer( player, "Zmieniłeś pozycję mety." ) 
		ClassRace.list[race].meta = {x,y,z}
	elseif key == "punkt" then
		if ClassRace.list[race].ready then
			return sendWarningMessageServer( player, "Nie możesz edytować już wyścigu, został pokazany graczom." )
		end
		
		--
		
		ClassRace.list[race].checkpointsCount = ClassRace.list[race].checkpointsCount + 1
		sendMessageServer( player, "Dodałeś "..ClassRace.list[race].checkpointsCount.." punkt kontrolony." ) 
		table.insert(ClassRace.list[race].checkpoints,{x,y,z,ClassRace.list[race].checkpointsCount})
	elseif key == "zapros" then
		if ClassRace.list[race].ready then
			return sendWarningMessageServer( player, "Nie możesz edytować już wyścigu, został pokazany graczom." )
		end
		
		--
		
		local value = tonumber(value)
		if not value then
			return sendWarningMessageServer( player, "Wpisz: /wyscig zapros (ID gracza)" ) 
		end
		
		local target = getPlayerByID(value)
		
		if not target then
			return sendWarningMessageServer( player, "Ten gracz nie jest połączony z serwerem." ) 
		end
		
		if ClassRace.list[race].members[target] then
			return sendWarningMessageServer( player, "Ten gracz uczestniczy już w tym wyścigu." ) 
		end
		
		sendMessageServer( player, "Zaprosił(eś/aś) do wyścigu "..name(target).."." ) 
		sendMessageServer( target, "Został(eś/aś) zaproszony do wyścigu "..ClassRace.list[race].name.." przez "..name(player).."." ) 
		
		ClassRace.list[race].membersCount = ClassRace.list[race].membersCount + 1
		ClassRace.list[race].members[target] = true
	elseif key == "pokaz" then	
		ClassRace.showRace(player,race)
	elseif key == "rozpocznij" then
		if not ClassRace.list[race].ready then
			return sendWarningMessageServer( player, "Najpierw pokaż wyścig uczestnikom, użyj (/wyscig pokaz)" )
		end
		
		ClassRace.startRace(player,race)
	elseif key == "zakoncz" then	
		ClassRace.list[race] = nil
		ClassRace.pRaces[player] = nil
		sendMessageServer( player, "Wyścig został zakończony." ) 
	else
		return sendWarningMessageServer( player, "Wystąpił problem." )
	end
	
end	
addCommandHandler("wyscig",ClassRace.editRace)

function ClassRace.showRace(player,id)
	local data = ClassRace.list[id]
	if not data then 
		return sendWarningMessageServer( player, "Błąd." )
	end
	
	if data.start == false then
		return sendWarningMessageServer( player, "Ustal pozycję startu." )
	end
	
	if data.meta == false then
		return sendWarningMessageServer( player, "Ustal pozycję mety." )
	end
	
	if data.membersCount == 0 then
		return sendWarningMessageServer( player, "W wyścigu nie bierze nikt udziału." )
	end
	
	if data.checkpointsCount == 0 then
		return sendWarningMessageServer( player, "Wyścig nie ma punktów kontrolonych." )
	end	
	
	for player, value in pairs(ClassRace.list[id].members) do
		triggerClientEvent(player, "showRace",player,ClassRace.list[id],player,id)
	end
	
	ClassRace.list[id].ready = true
	sendMessageServer( player, "Wyścig został pokazany uczestnikom." ) 
end

function ClassRace.startRace(player,id)
	local data = ClassRace.list[id]
	if not data then 
		return sendWarningMessageServer( player, "Błąd." )
	end
	
	for player, value in pairs(ClassRace.list[id].members) do
		triggerClientEvent(player, "startRace",player,id)
	end
	
	ClassRace.list[id].started = true
	sendMessageServer( player, "Odliczanie do startu rozpoczęte." ) 
end

addEvent( "onClientFinishedRace", true )  -- od actions/
addEventHandler( "onClientFinishedRace", getRootElement(),
	function(organisator,raceId)
		local raceData = ClassRace.list[raceId]
		if not raceData then 
			return sendWarningMessageServer( source, "Ten wyścig został przerwany przez organizatora." )
		end
		
		local stage = raceData.finishedPlaces + 1
		ClassRace.list[raceId].finishedPlaces = stage
		
		sendMessageServer( source, "Ukończyłeś wyścig na "..stage..". miejscu." )
		sendMessageServer( ClassRace.list[raceId].organisator, name(source).." ukończył wyścig na "..stage..". miejscu." )
	end
)