----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

Alarm = {}

function updateAlarm(vehicle)
	if isVehicleLocked(vehicle) == true and isElement(vehicle) then
		if getVehicleOverrideLights( vehicle ) ~= 2 then	
			setVehicleOverrideLights( vehicle, 2 )
		else
			setVehicleOverrideLights( vehicle, 1 )
		end
	else
		AlarmVehicleOff(vehicle)
	end
end

function AlarmVehicleOn(vehicle)
	if not isVehicleAlarmOn(vehicle) then
		Alarm[vehicle] = {}
		Alarm[vehicle].element = vehicle
		Alarm[vehicle].sound = triggerEvent( "soundPlay.alarm", vehicle, vehicle, true )
		Alarm[vehicle].timer = setTimer(updateAlarm, 1000, 20, vehicle)
		Alarm[vehicle].timerOff = setTimer(AlarmVehicleOff, 1000*20, 1, vehicle)
	end
end
addEvent("AlarmVehicleOn", true)
addEventHandler("AlarmVehicleOn", root, AlarmVehicleOn)

function AlarmVehicleOff(vehicle)
	if isVehicleAlarmOn(vehicle) then
		if isTimer(Alarm[vehicle].timer) then killTimer(Alarm[vehicle].timer) end
		if isTimer(Alarm[vehicle].timerOff) then killTimer( Alarm[vehicle].timerOff ) end
		Alarm[vehicle] = nil
		setVehicleOverrideLights( vehicle, 1 )
		triggerEvent( "soundPlay.alarm", vehicle, vehicle, false )
	end
end

function isVehicleAlarmOn(vehicle)
	if Alarm[vehicle] ~= nil then
		return true
	else
		return false
	end
end

