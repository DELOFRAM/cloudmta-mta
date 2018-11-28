local sx, sy = guiGetScreenSize()
local screen_x,screen_y = guiGetScreenSize(  )

function putPlayerInPosition(timeslice)
	local cx,cy,cz,ctx,cty,ctz = getCameraMatrix()
	ctx,cty = ctx-cx,cty-cy
	timeslice = timeslice*0.1	
	local tx, ty, tz = getWorldFromScreenPosition(sx / 2, sy / 2, 10)
	if isChatBoxInputActive() or isConsoleActive() or isMainMenuActive () or isTransferBoxActive () then return end	
	if getKeyState("lctrl") or getKeyState("rctrl") then timeslice = timeslice*4 end
	if getKeyState("lalt") or getKeyState("ralt") then timeslice = timeslice*0.25 end
	local mult = timeslice/math.sqrt(ctx*ctx+cty*cty)
	ctx,cty = ctx*mult,cty*mult
	if getKeyState("w") then abx,aby = abx+ctx,aby+cty end
	if getKeyState("s") then abx,aby = abx-ctx,aby-cty end
	if getKeyState("d") then  abx,aby = abx+cty,aby-ctx end
	if getKeyState("a") then abx,aby = abx-cty,aby+ctx end
	if getKeyState("space") then  abz = abz+timeslice end
	if getKeyState("lshift") or getKeyState("rshift") then	abz = abz-timeslice end	

	if isPedInVehicle ( getLocalPlayer( ) ) then	
		local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
		angle = getPedCameraRotation(getLocalPlayer ( ))	
		setElementPosition(vehicle,abx,aby,abz)
		setElementRotation(vehicle,0,0,-angle)
	else
		angle = getPedCameraRotation(getLocalPlayer ( ))	
		setElementRotation(getLocalPlayer ( ),0,0,angle)
		setElementPosition(getLocalPlayer ( ),abx,aby,abz)
	end
end

function toggleAirBrake(force)
	if force then
		if isPedInVehicle ( getLocalPlayer( ) ) then
			local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
			abx,aby,abz = nil
			setElementFrozen(vehicle,false)
			setElementCollisionsEnabled ( vehicle, true )
			setElementAlpha(getLocalPlayer(),255)
			setElementData(getLocalPlayer(), "adminFly", false)
			removeEventHandler("onClientPreRender",root,putPlayerInPosition)
		else
			abx,aby,abz = nil
			setElementData(getLocalPlayer(), "adminFly", false)
			setElementCollisionsEnabled ( localPlayer, true )
			removeEventHandler("onClientPreRender",root,putPlayerInPosition)
		end
	end
	if getKeyState( "lalt" )  == true or getKeyState( "ralt" )  == true then
	air_brake = not air_brake or nil
	--if not getElementData(localPlayer, "adminFly") then return end
			if air_brake then
				if isPedInVehicle ( getLocalPlayer( ) ) then
				local vehicle = getPedOccupiedVehicle( getLocalPlayer( ) )
				abx,aby,abz = getElementPosition(vehicle)
				Speed,AlingSpeedX,AlingSpeedY = 0,1,1
				OldX,OldY,OldZ = 0
				setElementCollisionsEnabled ( vehicle, false )
				setElementFrozen(vehicle,true)
				setElementData(localPlayer, "adminFly", true)
				addEventHandler("onClientPreRender",root,putPlayerInPosition)	
			else
				abx,aby,abz = getElementPosition(localPlayer)
				Speed,AlingSpeedX,AlingSpeedY = 0,1,1
				OldX,OldY,OldZ = 0
				setElementData(localPlayer, "adminFly", true)
				setElementCollisionsEnabled ( localPlayer, false )
				addEventHandler("onClientPreRender",root,putPlayerInPosition)	
			end
		else
		end
	end
end

addEvent("toggleAirBrake", true)
addEventHandler("toggleAirBrake", root, function(force)
	toggleAirBrake(force)
end)