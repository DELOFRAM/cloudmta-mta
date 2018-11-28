local Class = {}
Class.Race = {}
Class.Race.toggle = false
Class.Race.func = {}
Class.Race.checkpoint = {}
Class.Race.history = {}
Class.Race.elements = {}
Class.Race.clickTimer = getTickCount(  )
Class.Race.sW, Class.Race.sH = guiGetScreenSize(  )
Class.Race.UID = false
Class.Race.Name = false
Class.Race.Status = false

function Class.Race.func.informationText()
	dxDrawRectangle(Class.Race.sW / 2 - 150, Class.Race.sH - 180, 390, 40, tocolor(0, 0, 0, 180))
	dxDrawText(tostring(Class.Race.Status).." wyścigu "..tostring(Class.Race.Name).." (UID: "..tostring(Class.Race.UID)..")", Class.Race.sW / 2 + 900, Class.Race.sH - 172, 0, 0, tocolor(130, 130, 130, 200), 1.2, "default-bold", "center")


	local text = "Nacisnij [alt] aby postawić kolejny checkpoint."
	local text = text.."\nNacisnij [backspace] aby anulować tworzenie checkpointów."
	local text = text.."\nNacisnij [ctrl+enter] aby zatwierdzić tworzenie checkpoint."	
	local text = text.."\nNacisnij [ctrl+z] aby usunać poprzedni checkpoint."
	local text = text.."\nNacisnij [ctrl+y] aby przywrócić usunięty checkpoint."
	dxDrawRectangle(Class.Race.sW / 2 - 150, Class.Race.sH - 130, 390, 90, tocolor(0, 0, 0, 180))
	dxDrawText(text, Class.Race.sW / 2 + 900, Class.Race.sH - 125, 0, 0, tocolor(130, 130, 130, 200), 1.0, "default-bold", "center")
end

function Class.Race.func.createCheckpoint()
	if #Class.Race.elements > 0 then
		for key,v in ipairs(Class.Race.elements) do
			if isElement(v) then
				destroyElement( v )
			end
		end
	end

	for i,v in ipairs(Class.Race.checkpoint) do
		v.point = createMarker(v.x, v.y, v.z, 'checkpoint', 10.0, 0, 0, 255, 255)
		if i == 1 then
			setMarkerColor( v.point, 255, 0,0 ,255 )
		elseif i == #Class.Race.checkpoint then
			setMarkerIcon( v.point, 'finish' )
			setElementData(v.point, 'finish', true)
		else
			local next_index = Class.Race.checkpoint[i+1]
			if next_index ~= nil then setMarkerTarget(v.point, next_index.x, next_index.y, next_index.z) end
		end
		table.insert(Class.Race.elements,v.point)
	end


end

function Class.Race.func.insertPoint()
	local x, y, z = getElementPosition( getLocalPlayer(  ) )
	table.insert(Class.Race.checkpoint,{x=x,y=y,z=z})
	Class.Race.func.createCheckpoint()
	exports.titan_noti:showBox("Postawiono ".. #Class.Race.checkpoint .." punkt.")
end

function Class.Race.func.removePoint()
	if #Class.Race.checkpoint == 0 then return end
	table.insert(Class.Race.history,Class.Race.checkpoint[#Class.Race.checkpoint])
	table.remove(Class.Race.checkpoint,#Class.Race.checkpoint)
	Class.Race.func.createCheckpoint()
	exports.titan_noti:showBox("Usunięto ".. #Class.Race.checkpoint+1 .." punkt.")
end

function Class.Race.func.insertHistoryPoint()
	if #Class.Race.checkpoint == 0 then return end
	table.insert(Class.Race.checkpoint,Class.Race.history[#Class.Race.history])
	table.remove(Class.Race.history,#Class.Race.history)
	Class.Race.func.createCheckpoint()
	exports.titan_noti:showBox("Przywrócono ".. #Class.Race.history .." punkt.")
end

function Class.Race.func.cancel()
	triggerServerEvent( "Race:cancelHosting", getLocalPlayer(  ), getLocalPlayer(  ), Class.Race.UID )
	exports.titan_noti:showBox("Anulowano tworzenie wyścigu.")
end


function Class.Race.func.closed()
	if #Class.Race.elements > 0 then
		for key,v in ipairs(Class.Race.elements) do
			if isElement(v) then
				destroyElement( v )
			end
		end
	end
	removeEventHandler ( "onClientRender", root, Class.Race.func.Control )
end

function Class.Race.func.confirm()
	Class.Race.func.closed()
	if #Class.Race.checkpoint < 2 then return exports.titan_noti:showBox("Trasa wyścigu musi zawierać minimum dwa punkty!") end
	if Class.Race.Status == "Tworzenie" then
		exports.titan_noti:showBox("Zatwierdzono budowanie trasy wyścigu.")
	else
		exports.titan_noti:showBox("Zatwierdzono edytowanie trasy wyścigu.")		
	end
	triggerServerEvent( "Race:setCheckpoint", getLocalPlayer(  ), Class.Race.UID, Class.Race.checkpoint )
end

function Class.Race.func.Control()
	Class.Race.func.informationText()
	if not toggleButton and not isConsoleActive() and not isMainMenuActive() and not isChatBoxInputActive() and not isTransferBoxActive() then
		if getTickCount(  )-Class.Race.clickTimer > 1000 and ( getKeyState( "lalt" ) == true or getKeyState( "ralt" ) == true ) then
			Class.Race.func.insertPoint()
			Class.Race.clickTimer = getTickCount(  )
			toggleButton = true
			return
		elseif getTickCount(  )-Class.Race.clickTimer > 1000 and getKeyState( "backspace" ) == true then
			Class.Race.func.cancel()
			Class.Race.func.closed()
			return
		elseif getTickCount(  )-Class.Race.clickTimer > 1000 and (getKeyState( "lctrl" ) == true or getKeyState( "rctrl" ) == true) and getKeyState( "enter" ) == true then
			Class.Race.func.confirm()
			return
		elseif getTickCount(  )-Class.Race.clickTimer > 1000 and (getKeyState( "lctrl" ) == true or getKeyState( "rctrl" ) == true) and getKeyState( "z" ) == true then
			Class.Race.func.removePoint()
			Class.Race.clickTimer = getTickCount(  )
			toggleButton = true
			return
		elseif getTickCount(  )-Class.Race.clickTimer > 1000 and (getKeyState( "lctrl" ) == true or getKeyState( "rctrl" ) == true) and getKeyState( "y" ) == true then
			Class.Race.func.insertHistoryPoint()
			Class.Race.clickTimer = getTickCount(  )
			toggleButton = true
			return
		end
	elseif not getKeyState( "backspace" ) and not getKeyState( "lalt" ) and not getKeyState( "lctrl" ) and not getKeyState( "enter" ) and not getKeyState( "y" ) and not getKeyState( "z" ) then
 		toggleButton = false
 	end
end

function Class.Race.newCreate(UID, Name, Status, checkpoint)
	Class.Race.clickTimer = getTickCount(  )
	Class.Race.sW, Class.Race.sH = guiGetScreenSize(  )
	Class.Race.UID = UID
	Class.Race.Name = Name
	Class.Race.Status = Status
	if Status == "Edycja" then
		Class.Race.checkpoint = checkpoint
		Class.Race.func.createCheckpoint()
	end

	Class.Race.toggle = true
	addEventHandler ( "onClientRender", root, Class.Race.func.Control )
end
addEvent( "Race:bulding", true ) 
addEventHandler( "Race:bulding", getLocalPlayer(), Class.Race.newCreate)


function Class.Race.closeCreate()
	if Class.Race.toggle then
		Class.Race.func.closed()
	end
end
addEvent( "Race:stopbulding", true ) 
addEventHandler( "Race:stopbulding", getLocalPlayer(), Class.Race.closeCreate)