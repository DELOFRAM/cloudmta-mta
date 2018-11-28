----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local blips = {}
function onDataChange(dataName, oldValue)
	if source:getType() == "vehicle" then
		if dataName == "hasGPSOn" then
			if isPedInVehicle(localPlayer) then
				if getPedOccupiedVehicleSeat(localPlayer) == 0 or getPedOccupiedVehicleSeat(localPlayer) == 1 then
					local veh = getPedOccupiedVehicle(localPlayer)
					if veh:getData("hasGPS") then
						if source == veh then
							if veh:getData(dataName) then
								local groupID = veh:getData("gpsGroupID")
								local color = veh:getData("gpsColor")
								if not color then color = {255, 0, 0} end
								createBlips(groupID, color[1], color[2], color[3])
							else
								destroyAllBlips()
							end
						else
							if source:getData(dataName) then
								local groupID = source:getData("gpsGroupID")
								if veh:getData("gpsGroupID") == groupID then
									local color = veh:getData("gpsColor")
									if not color then color = {255, 0, 0} end
									createBlips(groupID, color[1], color[2], color[3])
								end
							else
								destroyBlipToVehicle(source)
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientElementDataChange", root, onDataChange)

function onWasted()
	if source == localPlayer then
		destroyAllBlips()
	end
end
addEventHandler("onClientPlayerWasted", localPlayer, onWasted)

function onElemDestroy()
	if getElementType(source) == "vehicle" then
		if isElement(blips[source]) then
			destroyElement(blips[source])
			destroyBlipToVehicle(source)
		end
	end
end
addEventHandler("onClientElementDestroy", root, onElemDestroy)

function onVehEnter(player, seat)
	if player == localPlayer and (seat == 0 or seat == 1) then
		if source:getData("hasGPS") and source:getData("hasGPSOn") then
			local groupID = source:getData("gpsGroupID")
			local color = source:getData("gpsColor")
			if not color then color = {255, 0, 0} end
			createBlips(groupID, color[1], color[2], color[3])
		end
	end
end
addEventHandler("onClientVehicleEnter", root, onVehEnter)

function onVehExit(player)
	if player == localPlayer then
		destroyAllBlips()
	end
end
addEventHandler("onClientVehicleExit", root, onVehExit)

function destroyAllBlips()
	for k, v in pairs(blips) do
		if isElement(v) then destroyElement(v) end
	end
	blips = {}
end

function destroyBlipToVehicle(veh)
	if isElement(blips[veh]) then
		destroyElement(blips[veh])
		blips[veh] = nil
	end
end

function createBlips(groupID, r, g, b, veh)
	if not veh then veh = getElementsByType("vehicle") else veh = {[1] = veh} end
	destroyAllBlips()
	local myVeh = getPedOccupiedVehicle(localPlayer)
	for k, v in ipairs(veh) do
		if v ~= myVeh then
			if v:getData("hasGPS") and v:getData("hasGPSOn") then
				if v:getData("gpsGroupID") == groupID then
					local blip = createBlipAttachedTo(v, 0, 2, r, g, b, 255, 0, 99999.0)
					blips[v] = blip
				end
			end
		end
	end
end