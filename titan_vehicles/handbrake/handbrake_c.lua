----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local exitVehTimer = nil

function onClientElementDataChange(dataName, oldValue)
	if source == localPlayer then
		if (string.lower(tostring(dataName)) == "exitingvehicle" or string.lower(tostring(dataName)) == "enteringvehicle") and (getElementData(localPlayer, "enteringVehicle") or getElementData(localPlayer, "exitingVehicle")) then
			if isTimer(exitVehTimer) then killTimer(exitVehTimer) end
			exitVehTimer = setTimer(function()
				setElementData(localPlayer, "exitingVehicle", false)
				setElementData(localPlayer, "enteringVehicle", false)
			end, 5000, 1)
		end
	end
end
addEventHandler("onClientElementDataChange", root, onClientElementDataChange)

local blocked ={472, 473, 493, 595, 484, 430, 453, 452, 446, 454, 590, 538, 570, 569, 537, 449, 509, 481, 510, 441, 464, 594, 501, 465, 564, 606, 607, 610, 584, 611, 608, 435, 450, 591, 571, 539, 448, 461, 462, 463, 468, 521, 522, 581, 586, 523, 471, 592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513, 548, 425, 417, 487, 488, 497, 563, 447, 469}

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end


--[[addEventHandler ( "onClientRender", root, function ()
	toggleControl("handbrake", false)	
	local vehicle = getPedOccupiedVehicle( getLocalPlayer(  ) )	
	if vehicle then
		if getElementSpeed(vehicle,"km/h") <= 0 and getElementData(vehicle,"handbrake") then
			if not( isElementFrozen( vehicle ) ) then
				--setElementFrozen( vehicle, true )
				triggerServerEvent("serverSetElementFrozen", resourceRoot, vehicle, true)
			end
		elseif getElementData(vehicle,"handbrake") then
			setControlState ( "handbrake", true )
		else
			setControlState("handbrake", false)
		end
	end
end)]]

function timerFunc()
	local veh = getPedOccupiedVehicle(localPlayer)
	if isElement(veh) then
		if getElementSpeed(veh, "km/h") <= 0 and veh:getData("handbrake") and not isBlockedVehicle(getElementModel(veh)) then
			if not isElementFrozen(veh) then
				triggerServerEvent("serverSetElementFrozen", resourceRoot, veh, true)
			end
		end
		if not isBlockedVehicle(getElementModel(veh)) and (not localPlayer:getData("enteringVehicle") and not localPlayer:getData("exitingVehicle")) then
			if getElementData(veh, "handbrake") then
				setControlState("handbrake", true)
			else
				setControlState("handbrake", false)
			end
		end
	end
end
setTimer(timerFunc, 500, 0)

function onVehicleEnter(player, seat)
	if player == localPlayer then
		if getElementData(source, "handbrake") then
			setControlState("handbrake", true)
		end
	end
end
addEventHandler("onClientVehicleEnter", root, onVehicleEnter)

function isBlockedVehicle(vehModel)
	for k,v in pairs(blocked) do
		if v == vehModel then return true end
	end
	return false
end

function playerPressedSpace(button, press)
	if button == "space" then
		toggleControl("handbrake", false)
		--if isChatBoxInputActive() then return end
		local veh = getPedOccupiedVehicle(localPlayer)
		if not isElement(veh) then return end
		if getVehicleController(veh) ~= localPlayer then return end
		
		if isBlockedVehicle(getElementModel(veh)) then
			--outputDebugString("TEST?!")
			setControlState("handbrake", press == "down" and true or false)
		else
			if press == "down" then
				outputDebugString("TEST")
				if localPlayer:getData("enteringVehicle") or localPlayer:getData("exitingVehicle") then return end
				outputDebugString("TES2T")
				setElementData(veh, "handbrake", not getElementData(veh, "handbrake"))
				setControlState("handbrake", getElementData(veh, "handbrake"))
				if not getElementData(veh, "handbrake") then
					triggerServerEvent("serverSetElementFrozen", resourceRoot, veh, false)
				end
				exports.titan_sounds:create3DSound(":titan_vehicles/handbrake/sounds/handbrake.wav", false, nil, nil, 100, 50, 1.0, veh, nil, nil, 4000)
			end
		end
	end
end
--addEventHandler("onClientKey", root, playerPressedSpace)
bindKey("space", "both", playerPressedSpace)