--[[ 
 * Copyright (C) 2012, Mati All rights reserved.
 *
 * File:    c_race.lua (it is client script)
 * Desc:    Skrypt umożliwiający tworzenie własnych wyścigów 
 * Version: 1.0
 * Author:  Mati
 * 
 * For commercial use
 *
 --]]

local ClassRace = {}
ClassRace.exists = false
ClassRace.cache = {}
ClassRace.checkpointCounts = 0
ClassRace.lastCheckpoint = 0
ClassRace.organisator = false
ClassRace.curRadeId = 0
ClassRace.raceIsStarted = false

addEvent( "showRace", true )  -- od actions/
addEventHandler( "showRace", getLocalPlayer(),
	function(data,organisation,id)
		if ClassRace.exists then
			showInfoBoxClient( "Nie możesz wziąść udział w kolejnym wyścigu póki nie skończysz obecnego." ) 
			return
		end
		
		ClassRace.show(data,organisation,id)
		
		showInfoBoxClient( "Organizator pokazał tobie wyścig. Zaraz rozpocznie się start, przygotuj się." ) 
	end
)

addEvent( "startRace", true )  -- od actions/
addEventHandler( "startRace", getLocalPlayer(),
	function(id)
		if ClassRace.exists then
			showInfoBoxClient( "Nie możesz wziąść udział w kolejnym wyścigu póki nie skończysz obecnego." ) 
			return
		end
		
		local veh = getPedOccupiedVehicle(localPlayer)
		if veh then 
			setElementFrozen(veh,true)
		end
		setElementFrozen(localPlayer,true)
		
		setTimer(
			function()
				sendMessage("3!")
			end, 1000, 1
		)
		
		setTimer(
			function()
				sendMessage("2!")
			end, 2000, 1
		)
		
		setTimer(
			function()
				sendMessage("1!")
			end, 3000, 1
		)
		
		setTimer(
			function()
				setElementFrozen(localPlayer,false)
				setElementFrozen(veh,false)
				sendMessage("Start!")
			end, 4000, 1
		)
		
		ClassRace.raceIsStarted = true
	end
)

function ClassRace.show(data,organisation,id)
	ClassRace.cache = {}
	ClassRace.checkpointCounts = 0
	ClassRace.lastCheckpoint = 0
	ClassRace.organisator = organisation
	ClassRace.curRadeId = id
	
	ClassRace.cache = {
		start = createBlip( data.start[1], data.start[2], data.start[3], 38, 1, 255, 0, 0, 255, 255, 100000 ),
		startMarker = createMarker(data.start[1], data.start[2], data.start[3], 'checkpoint', 10, 255, 0, 0)
	}
	
	ClassRace.cache.blips = {}
	ClassRace.cache.checkpoints = {}
	
	for key, value in pairs(data.checkpoints) do
		createCheckpoint(value[1],value[2],value[3],value[4],data,false)
	end
	
	ClassRace.checkpointCounts = data.checkpointsCount + 1 --bo jeszcze meta
	
	createCheckpoint(data.meta[1], data.meta[2], data.meta[3],ClassRace.checkpointCounts,data,true)
end

function createCheckpoint(x,y,z,i,data,isMeta)
	local color = { 0, 0, 255 }
	local marker = createMarker(x,y,z, 'checkpoint', 12, color[1], color[2], color[3])
	addEventHandler ( "onClientMarkerHit", marker, MarkerHit )
	
	setElementData(marker,"racemarkerid",i)
	
	if isMeta then
		setMarkerIcon(marker, 'finish')
		setElementData(marker,"meta",true)
	else 
		for key, value in pairs(data.checkpoints) do
			if value[4] == i + 1 then
				setMarkerTarget(marker,value[1],value[2],value[3])
				break
			end
		end
	end

	local blip = createBlip(x,y,z, 0, 2, color[1], color[2], color[3])
	setBlipOrdering(blip, 1)
	
	ClassRace.cache.checkpoints[marker] = blip
end

function MarkerHit ( hitPlayer, matchingDimension )
	if not ClassRace.raceIsStarted then return false end
	if hitPlayer ~= localPlayer then return false end
	local id = getElementData(source,"racemarkerid")
	if not id then return false end --to nie race marker
	if ClassRace.lastCheckpoint + 1 ~= id then
		return showInfoBoxClient( "Najpierw zalicz poprzednie punkty kontrolne." ) 
	end
	
	ClassRace.lastCheckpoint = ClassRace.lastCheckpoint + 1	
	
	local isMeta = getElementData(source,"meta") 
	destroyElement(ClassRace.cache.checkpoints[source])
	destroyElement(source)
	playSoundFrontEnd(43)
	
	if isMeta and id == ClassRace.checkpointCounts then
		ClassRace.exists = false
		destroyElement(ClassRace.cache.start)
		destroyElement(ClassRace.cache.startMarker)
		triggerServerEvent('onClientFinishedRace',localPlayer,ClassRace.organisator,ClassRace.curRadeId)
		ClassRace.cache = {}
	end
end