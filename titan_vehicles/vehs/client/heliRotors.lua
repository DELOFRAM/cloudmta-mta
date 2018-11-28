----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function getElementSpeed(theElement, unit)
    -- Check arguments for errors
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

addEventHandler("onClientRender", root, function()
	for k,v in pairs(getElementsByType("vehicle")) do
		if getVehicleType(v) == "Helicopter" then
			if getElementSpeed(v, 1) > 20 then
				setHelicopterRotorSpeed(v, math.floor(getElementSpeed(v, 1))/10)
			end
			local x, y, z = getElementPosition(v)
			local gz = getGroundPosition(x, y, z)
			if getDistanceBetweenPoints3D(x, y, z, x, y, gz) > 10 then
				setHelicopterRotorSpeed(v, math.floor(getElementSpeed(v, 1))/10)
			end
			if not getVehicleEngineState(v) then
				setHelicopterRotorSpeed(v, 0)
			end
		end
	end
end)
