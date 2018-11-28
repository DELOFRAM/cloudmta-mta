local screenw, screenh = guiGetScreenSize(  )


motionblur = false
motionblur_shader = false
motionblur_screenSrc = false
motionblur_state = false

motionblur_shader = dxCreateShader( "motion.fx" )
motionblur_screenSrc = dxCreateScreenSource( screenw, screenh )
dxSetShaderValue( motionblur_shader, "ScreenTexture", motionblur_screenSrc )
dxSetShaderValue( motionblur_shader, "drunkLevel", 0 )

Move = false

function setMovePlayer(control)
move = true
setControlState( control, true )
setControlState( "walk", true )
	setTimer( function()
		move = false
		setControlState( control, false )
		setControlState( "walk", false )
	end, 500, 1)
end

function clientHUDRender_motionblur()
local drunkLevel=getElementData(localPlayer, "drunkLevel")
if drunkLevel >= 15 then
local veh = getPedOccupiedVehicle( localPlayer )	
	if not( getPedWalkingStyle( localPlayer ) == 126) then
		triggerServerEvent( "setPedDrunkWalkStyle", localPlayer, localPlayer )
	end
	if not(veh) and getControlState ( "forwards" ) then
		local rand = math.random(1,6)
		setControlState( "forwards", false )
		if rand == 1 and not(move) then
			setMovePlayer("left")
		elseif rand == 2 and not(move) then
			setMovePlayer("right")
		elseif rand == 3 and not(move) then
			setMovePlayer("backwards")
		end
	elseif not(veh) and getControlState ( "left" ) then
		local rand = math.random(1,6)
		setControlState( "left", false )
		if rand == 1 and not(move) then
			setMovePlayer("right")
		elseif rand == 2 and not(move) then
			setMovePlayer("forwards")
		elseif rand == 3 and not(move) then
			setMovePlayer("backwards")
		end
	elseif not(veh) and getControlState ( "right" ) then
		local rand = math.random(1,6)
		setControlState( "right", false )
		if rand == 1 and not(move) then
			setMovePlayer("left")
		elseif rand == 2 and not(move) then
			setMovePlayer("forwards")
		elseif rand == 3 and not(move) then
			setMovePlayer("backwards")
		end
	elseif not(veh) and getControlState ( "backwards" ) then
		local rand = math.random(1,6)
		setControlState( "backwards", false )
		if rand == 1 and not(move) then
			setMovePlayer("left")
		elseif rand == 2 and not(move) then
			setMovePlayer("right")
		elseif rand == 3 and not(move) then
			setMovePlayer("forwards")
		end
	elseif veh and getControlState ( "accelerate" ) then
		local rand = math.random(1,6)
		setControlState( "accelerate", false )
		if rand == 1 and not(move) then
			setMovePlayer("vehicle_left")
		elseif rand == 2 and not(move) then
			setMovePlayer("vehicle_right")
		elseif rand == 3 and not(move) then
			setMovePlayer("brake_reverse")
		end
	elseif veh and getControlState ( "vehicle_left" ) then
		local rand = math.random(1,6)
		setControlState( "vehicle_left", false )
		if rand == 1 and not(move) then
			setMovePlayer("vehicle_right")
		elseif rand == 2 and not(move) then
			setMovePlayer("accelerate")
		elseif rand == 3 and not(move) then
			setMovePlayer("brake_reverse")
		end
	elseif veh and getControlState ( "vehicle_right" ) then
		local rand = math.random(1,6)
		setControlState( "vehicle_right", false )
		if rand == 1 and not(move) then
			setMovePlayer("vehicle_left")
		elseif rand == 2 and not(move) then
			setMovePlayer("accelerate")
		elseif rand == 3 and not(move) then
			setMovePlayer("brake_reverse")
		end
	elseif veh and getControlState ( "brake_reverse" ) then
		local rand = math.random(1,6)
		setControlState( "brake_reverse", false )
		if rand == 1 and not(move) then
			setMovePlayer("vehicle_left")
		elseif rand == 2 and not(move) then
			setMovePlayer("vehicle_right")
		elseif rand == 3 and not(move) then
			setMovePlayer("accelerate")
		end

	end
end
	dxSetShaderValue( motionblur_shader, "drunkLevel", tonumber(drunkLevel))
	dxSetRenderTarget()
	dxUpdateScreenSource(motionblur_screenSrc)
	dxDrawImage(0, 0, screenw, screenh, motionblur_shader);
end



addEventHandler ( "onClientElementDataChange", getRootElement(), function ( dataName, oldValue )
	if dataName == "drunkLevel" then
		if tonumber( getElementData(localPlayer,"drunkLevel") ) > 0 then
			if not(motionblur_state) then
				addEventHandler( "onClientHUDRender", getRootElement( ), clientHUDRender_motionblur )
				setCameraShakeLevel ( 5 )
				motionblur_state = true	
			end
		else
			if motionblur_state then
				removeEventHandler( "onClientHUDRender", getRootElement( ), clientHUDRender_motionblur )	
				setCameraShakeLevel ( 0 )
				setPedWalkingStyle( localPlayer, 0 )	
				motionblur_state = false	
			end
		end
	end
end )