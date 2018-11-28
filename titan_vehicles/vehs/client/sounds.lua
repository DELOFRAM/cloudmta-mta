----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local vehSounds = {}
local soundPlay = {}

function soundPlay.alarmToggle(veh, toggle)
	if toggle == true then
		soundPlay.alarmOn(veh)
	else
		soundPlay.alarmOff(veh)
	end
end
addEvent("soundPlay.alarm", true)
addEventHandler("soundPlay.alarm", root, soundPlay.alarmToggle)

function soundPlay.alarmOn(veh)
	if(isElement(veh)) then
		if(type(vehSounds[veh]) ~= "table") then vehSounds[veh] = {} end
		if(isElement(vehSounds[veh].alarm)) then destroyElement(vehSounds[veh].alarm) end
		local x, y, z = getElementPosition(veh)
		vehSounds[veh].alarm = playSound3D("vehs/client/files/alarm.mp3", x, y, z, true)
		if(isElement(vehSounds[veh].alarm)) then
			attachElements(vehSounds[veh].alarm, veh)
			setElementParent(vehSounds[veh].alarm, veh)
		end
		return true
	end
end


function soundPlay.alarmOff(veh)
	if(isElement(veh)) then
		if(type(vehSounds[veh]) ~= "table") then vehSounds[veh] = {} end
		if(isElement(vehSounds[veh].alarm)) then destroyElement(vehSounds[veh].alarm) end
		return true
	end
end

function soundPlay.doors(veh, isAlarm)
	if(isElement(veh)) then
		if(type(vehSounds[veh]) ~= "table") then vehSounds[veh] = {} end
		local sound = not isAlarm and "vehs/client/files/doorsLock.mp3" or "vehs/client/files/doorsAlarm.mp3"
		exports.titan_sounds:create3DSound(":titan_vehicles/"..sound, false, nil, nil, 100, 10, 1.0, veh, nil, nil, 5000)
		
	end
end
addEvent("soundPlay.doors", true)
addEventHandler("soundPlay.doors", root, soundPlay.doors)

function soundPlay.handbrakeOn(veh)
	if isElement(veh) then
		if(type(vehSounds[veh]) ~= "table") then vehSounds[veh] = {} end
		exports.titan_sounds:create3DSound(":titan_vehicles/vehs/client/files/handbrakeon.mp3", false, nil, nil, 100, 10, 1.0, veh, nil, nil, 5000)
	end
end
addEvent("soundPlay.handbrakeOn", true)
addEventHandler("soundPlay.handbrakeOn", root, soundPlay.handbrakeOn)

function soundPlay.handbrakeOff(veh)
	if isElement(veh) then
		if(type(vehSounds[veh]) ~= "table") then vehSounds[veh] = {} end
		exports.titan_sounds:create3DSound(":titan_vehicles/vehs/client/files/handbrakeoff.mp3", false, nil, nil, 100, 10, 1.0, veh, nil, nil, 5000)
	end
end
addEvent("soundPlay.handbrakeOff", true)
addEventHandler("soundPlay.handbrakeOff", root, soundPlay.handbrakeOff)

local carAudioSound = nil
local vehiclesCarSound = {}
function soundPlay.carAudioOn(link)
	if isPedInVehicle(localPlayer) then soundPlay.carAudioOffTerrain(getPedOccupiedVehicle(localPlayer)) end
	if isElement(carAudioSound) then destroyElement(carAudioSound) end
	carAudioSound = playSound(link)
end
addEvent("soundPlay.carAudioOn", true)
addEventHandler("soundPlay.carAudioOn", root, soundPlay.carAudioOn)

function soundPlay.carAudioOff()
	if isElement(carAudioSound) then destroyElement(carAudioSound) end
end
addEvent("soundPlay.carAudioOff", true)
addEventHandler("soundPlay.carAudioOff", root, soundPlay.carAudioOff)

function soundPlay.carAudioOnTerrain(veh, link)
	if vehiclesCarSound[veh] then
		exports.titan_sounds:destroy3DSound(vehiclesCarSound[veh])
		vehiclesCarSound[veh] = nil
	end
	if isPedInVehicle(localPlayer) and getPedOccupiedVehicle(localPlayer) == veh then return end
	vehiclesCarSound[veh] = exports.titan_sounds:create3DSound(link, true, nil, {"i3dl2reverb"}, 100, 10, 0.5, veh, nil, nil)
end
addEvent("soundPlay.carAudioOnTerrain", true)
addEventHandler("soundPlay.carAudioOnTerrain", root, soundPlay.carAudioOnTerrain)

function soundPlay.carAudioOffTerrain(veh)
	if vehiclesCarSound[veh] then
		exports.titan_sounds:destroy3DSound(vehiclesCarSound[veh])
		vehiclesCarSound[veh] = nil
	end
end
addEvent("soundPlay.carAudioOffTerrain", true)
addEventHandler("soundPlay.carAudioOffTerrain", root, soundPlay.carAudioOffTerrain)

function onVehExit(player)
	if player == localPlayer then 
		soundPlay.carAudioOff()
		if source:getData("carAudio") and source:getData("carAudioOn") then
			soundPlay.carAudioOnTerrain(source, source:getData("carAudio"))
		end
	end
end
addEventHandler("onClientVehicleExit", root, onVehExit)

function onElementStreamIn()
	if getElementType(source) == "vehicle" then
		if source:getData("carAudio") and source:getData("carAudioOn") then
			soundPlay.carAudioOnTerrain(source, source:getData("carAudio"))
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)

function onElementStreamOut()
	if getElementType(source) == "vehicle" then
		soundPlay.carAudioOffTerrain(source)
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

function cancelRadioSwitch()
if getElementModel(getPedOccupiedVehicle(localPlayer)) == 509 or getElementModel(getPedOccupiedVehicle(localPlayer)) == 510 or getElementModel(getPedOccupiedVehicle(localPlayer)) == 481 then cancelEvent() return end
end
addEventHandler("onClientPlayerRadioSwitch", root, cancelRadioSwitch)

function onPlayerRequestStartEngine(veh)
    exports.titan_sounds:create3DSound(":titan_vehicles/vehs/client/files/startengine.wav", false, nil, nil, 100, 10, 1.0, veh, nil, nil, 628)
end
addEvent("onPlayerRequestStartEngine", true)
addEventHandler("onPlayerRequestStartEngine", root, onPlayerRequestStartEngine)