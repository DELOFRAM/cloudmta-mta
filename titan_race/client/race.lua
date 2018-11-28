local Class = {}
Class.Race = {}
Class.Race.cache = {}
Class.Race.func = {}
Class.Race.Data = false


function onVehicleMarkerHit()
	if getPedOccupiedVehicle( getLocalPlayer(  ) ) and Class.Race.Data.status == true then
		for i,v in ipairs(Class.Race.cache.checkpoints) do
			if v == source and i == Class.Race.Data.CounterHit then
				if getElementData(source, 'finish') then
					triggerServerEvent( "Race:finishRace", getLocalPlayer(  ), Class.Race.Data.ID, getLocalPlayer(  ), (getTickCount(  )-Class.Race.TimerStart)/1000 )
				end
				Class.Race.Data.CounterHit = Class.Race.Data.CounterHit+1
				destroyElement(source)
			end
		end
	end
end

function Class.Race.func.showMap()
	if Class.Race.cache.checkpoints ~= nil and #Class.Race.cache.checkpoints > 1 then
		for i,v in ipairs(Class.Race.cache.checkpoints) do
			if isElement(v) then
				destroyElement( v )
			end
		end
	end

	if Class.Race.cache.blips ~= nil and #Class.Race.cache.blips > 1 then
		for i,v in ipairs(Class.Race.cache.blips) do
			if isElement(v) then
				destroyElement( v )
			end
		end
	end	

	Class.Race.cache.blips = {}
	Class.Race.cache.checkpoints = {}
	for i,v in ipairs(Class.Race.Data.checkpoints) do
		v.point = createMarker(v.x, v.y, v.z, 'checkpoint', 10.0, 0, 0, 255, 255)
		if i == 1 then
			setMarkerColor( v.point, 255, 0,0 ,255 )
			start = createBlip( v.x, v.y, v.z, 38, 1, 255, 0, 0, 255, 255, 100000 ),
			table.insert(Class.Race.cache.blips, start)
		elseif i == #Class.Race.Data.checkpoints then
			setMarkerIcon( v.point, 'finish' )
			setElementData(v.point, 'finish', true)
		else
			local next_index = Class.Race.Data.checkpoints[i+1]
			if next_index ~= nil then setMarkerTarget(v.point, next_index.x, next_index.y, next_index.z) end
		end
		addEventHandler ( "onClientMarkerHit", v.point, onVehicleMarkerHit )
		table.insert(Class.Race.cache.checkpoints, v.point)
	end
end

function Class.Race.func.Counter()
if not(Class.Race.Timer) then Class.Race.Timer = getTickCount(  ) end
if not(Class.Race.Counter) then Class.Race.Counter = 5 end
	if getTickCount(  )-Class.Race.Timer > 2500 then
		Class.Race.Timer = getTickCount(  )
		if Class.Race.Counter == "Ruszaj!" then
			removeEventHandler ( "onClientRender", root, Class.Race.func.Counter )
		end
		Class.Race.Counter = Class.Race.Counter-1
	end
	if Class.Race.Counter == 0 then 
		Class.Race.Counter = "Ruszaj!" 
		Class.Race.TimerStart = getTickCount(  )
		Class.Race.Data.status = true
		Class.Race.Data.CounterHit = 1
		setElementFrozen( getPedOccupiedVehicle( getLocalPlayer(  ) ), false )
	end
	dxDrawText(Class.Race.Counter, Class.Race.sW / 2 - dxGetTextWidth( Class.Race.Counter,  5.0, "default-bold" )/2, Class.Race.sH /2, 0, 0, tocolor(255, 255, 255, 200), 5.0, "default-bold")
end


function Class.Race.func.StartRace()
	if getPedOccupiedVehicle( getLocalPlayer(  ) ) then
		Class.Race.sW, Class.Race.sH = guiGetScreenSize(  )
		setElementFrozen( getPedOccupiedVehicle( getLocalPlayer(  ) ), true )
		Class.Race.Counter = 5
		addEventHandler ( "onClientRender", root, Class.Race.func.Counter )
	end
end

function Class.Race.func.UNSynchronzation()
	if Class.Race.Data ~= nil then
		if Class.Race.cache.checkpoints ~= nil and #Class.Race.cache.checkpoints > 1 then
			for i,v in ipairs(Class.Race.cache.checkpoints) do
				if isElement(v) then
					destroyElement( v )
				end
			end
		end
	
		if Class.Race.cache.blips ~= nil and #Class.Race.cache.blips > 1 then
			for i,v in ipairs(Class.Race.cache.blips) do
				if isElement(v) then
					destroyElement( v )
				end
			end
		end
	end
end
addEvent( "Race:unsync", true ) 
addEventHandler( "Race:unsync", getRootElement(  ), Class.Race.func.UNSynchronzation)

function Class.Race.func.Synchronzation(Data)
	Class.Race.Data = Data
	Class.Race.sW, Class.Race.sH = guiGetScreenSize(  )
	Class.Race.func.showMap()
	if Data.status == true then
		Class.Race.func.StartRace()
	end
end
addEvent( "Race:sync", true ) 
addEventHandler( "Race:sync", getRootElement(  ), Class.Race.func.Synchronzation)