woodObjects = 
{
	[1] = 
	{
		pos = Vector3(-409.925, -1750.398, 6.133),
		objectID = 618
	},
	[2] =
	{
		pos = Vector3(-397.53, -1734.75, 8.84),
		objectID = 616
	}
}
woodWork = {}


function onStart()
	for k, v in ipairs(woodObjects) do
		woodObjects[k].object = createObject(v.objectID, v.pos)
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function cmdDrwal(player)
	if player:getData("job:woodcutter") then
		player:removeData("job:woodcutter")
		woodWork[player] = nil
		return exports.titan_noti:showBox(player, "Praca drwala została anulowana.")
	end

	local workVehicles = exports.titan_vehicles:getWorkVehicles(1)
	if #workVehicles == 0 then return exports.titan_noti:showBox(player, "Nie ma żadnych dostępnych pojazdów, których można użyć do wykonania pracy.") end
	
	local ignoredVehicles = {}
	for k, v in pairs(woodWork) do
		if isElement(k) then
			ignoredVehicles[v.vehID] = true
		else
			woodWork[k] = nil
		end
	end
	local vehID, key
	for k, v in ipairs(workVehicles) do
		if not ignoredVehicles[v.ID] then vehID = v.ID key = k break end
	end
	if not vehID then return exports.titan_noti:showBox(player, "Nie znaleziono żadnego wolnego pojazdu, którego można użyć.") end
	
	local woodKey
	for k, v in ipairs(woodObjects) do
		if not isElement(v.player) then woodKey = k break end
	end
	if not woodKey then return exports.titan_noti:showBox(player, "Nie ma wolnych miejsc do pracowania.") end

	woodObjects[woodKey].player = player

	woodWork[player] = 
	{
		vehID = vehID,
		woodKey = woodKey

	}
	return exports.titan_noti:showBox(player, "Rozpocząłeś pracę drwala. Wsiądź do wyznaczonego pojazdu.")

end
addCommandHandler("drwal", cmdDrwal, false, false)

function cmdObiekt(player)
	local veh = getPedOccupiedVehicle(player)
	local object = createObject(1463, player:getPosition())
	object:attach(veh, 0, -1.3, 0.2, 0, 0, 90)
	object:setParent(veh)
end
addCommandHandler("obj", cmdObiekt, false, false)