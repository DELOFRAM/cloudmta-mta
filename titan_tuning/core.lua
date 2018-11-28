function getComponentData(type, value)
	for i,v in ipairs(Parts) do
		if v.type == type and i == value then
			return v
		end
	end
	return false
end

function getComponentDataVehicle(vehicle, value)
local tunings = getElementData(vehicle,"tuningParts")
	for i,v in ipairs(tunings) do
		if tonumber(v.id) == tonumber(value) then
			return v
		end 
	end
	return false
end

function getPlayerItemTuning(player, uid)
	local playerItems = exports.titan_items:getPlayerItems(player)
	for i,v in ipairs(playerItems) do
		if tonumber(v.ID) == tonumber(uid) then
			if  tonumber(v.type) == 23 then
				return v
			else
				return nil
			end
		end 
	end
	return false
end

function getVehicleHandlingOriginalProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getOriginalHandling ( getElementModel(element) )
        local value = handlingTable[property]

        if value then
            return value
        end
    end
    return false
end

function getVehicleHandlingProperty ( element, property )
    if isElement ( element ) and getElementType ( element ) == "vehicle" and type ( property ) == "string" then
        local handlingTable = getVehicleHandling( element )
        local value = handlingTable[property]
        if value then
            return value
        end
    end
    return false
end


function saveVehicleComponent(vehicle, data, by, save)
	if not(by) or by == nil then
		by = "system"
	else
		by = getElementData(by,"charID")
	end

	if not(getElementData(vehicle,"tuningParts")) then
		tempTable = {}
	else
		tempTable = getElementData(vehicle,"tuningParts")
	end
	local vehID = getElementData(vehicle,"vehID")
	if vehID and save then
		exports.titan_db:query_free("INSERT INTO _vehtuning SET vehID=?, name=?, value=?, type=?, locked=?, byInstall=?", vehID, data[1], data.id, data.type, false, by )
	end
	table.insert(tempTable,{index=#tempTable+1,name=data[1], id=data.id, type=data.type, locked=false})
	setElementData(vehicle,"tuningParts",tempTable)
	return true
end


function unloadVehicleComponent(vehicle, data, value)
	if not(getElementData(vehicle,"tuningParts")) then
		return false
	else
		tempTable = getElementData(vehicle,"tuningParts")
	end

	local vehID = getElementData(vehicle,"vehID")
	--outputChatBox(tostring(vehID))
	if vehID then
		exports.titan_db:query_free("DELETE FROM _vehtuning WHERE vehID=? AND value=?", vehID, value)
	end

	table.remove(tempTable,data.index)
	setElementData(vehicle,"tuningParts",tempTable)
end

function isVehicleComponent(vehicle, type, value)
	if getVehicleComponent(vehicle, type, value) then
		return true
	else
		return false
	end
end

function getVehicleComponent(vehicle, type, value)
	if not getElementData(vehicle,"tuningParts") then return false end
	for i,v in ipairs( getElementData(vehicle,"tuningParts") ) do
		if v.type == type and v.id == value then
			return v
		end
	end
	return false
end

function loadVehicleComponent(save, vehicle, ID, locked)
	if Parts[tonumber(ID)] == nil then
		outputDebugString("Nieznany model części pojazdu!")
		return false
	end
	local part = Parts[tonumber(ID)]
	setVehicleComponent(vehicle, tonumber(part.type), tonumber(ID), false, save)
	return true
end


function setVehicleComponent(vehicle, part, value, by, save)
local data = getComponentData(part, value)
	if data then
		if not isVehicleComponent(vehicle, part, value) then
			for i,v in ipairs(data.handling) do
				local value = getVehicleHandlingOriginalProperty(vehicle, v[1])
				local prop = getVehicleHandlingProperty(vehicle, v[1])
				if not(value) then
					outputDebugString("Error: Handling value: "..v[1])
					return false, 2
				elseif type(value) == "number" then
					setVehicleHandling( vehicle, v[1], ( tonumber(v[2])*tonumber(value) )+tonumber(prop) )
				elseif type(value) == "text" then
					setVehicleHandling( vehicle, v[1], v[2] )
				end
			end
			data.id = value
			saveVehicleComponent(vehicle, data, by, save)
			return true
		else
			return false, 1
		end
		return true
	else
		return false, 0
	end
end



function removeVehicleComponent(vehicle, part, value, save)
local data = getComponentData(part, value) 
local part = getVehicleComponent(vehicle, part, value)
local id = value
	if part then
		for i,v in ipairs(data.handling) do
			local value = getVehicleHandlingOriginalProperty(vehicle, v[1])
			local prop = getVehicleHandlingProperty(vehicle, v[1])
			if not(value) then
				return false, 2
			elseif type(value) == "number" then
				setVehicleHandling( vehicle, v[1], ( tonumber(v[2])*tonumber(value) )-tonumber(prop) )
			elseif type(value) == "text" then
				setVehicleHandling( vehicle, v[1], prop )	
			end
		end
			if save then
				unloadVehicleComponent(vehicle, data, id)
			end
		return true
	else
		return false, 0
	end
end