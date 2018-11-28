----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

vehData = {}
vehIndex = {}

boats ={472, 473, 493, 595, 484, 430, 453, 452, 446, 454}
trains={590, 538, 570, 569, 537, 449}
bikes={509, 481, 510}
motorbikes = {448, 461, 462, 463, 468, 521, 522, 581, 586, 523, 471}
special = {441, 464, 594, 501, 465, 564, 606, 607, 610, 584, 611, 608, 435, 450, 591, 571, 539, 531}
airplanes = {592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513}
helicopters = {548, 425, 417, 487, 488, 497, 563, 447, 469}

function getVehInfo(vehID)
	local index = vehIndex[vehID]
	if(not tonumber(index)) then return false end
	if(type(vehData[index]) ~= "table") then return false end
	return vehData[index], index
end

function getAllVehicles()
	return vehData
end

function turnOffVeh(vehIndex)
	if vehData[vehIndex] and isElement(vehData[vehIndex].veh) then
		vehData[vehIndex].engineState = false
		setElementData(vehData[vehIndex].veh, "engineState", false)
		setVehicleEngineState(vehData[vehIndex].veh, false)
		vehData[vehIndex].lightState = false
		setElementData(vehData[vehIndex].veh, "lightState", false)
		setVehicleOverrideLights(vehData[vehIndex].veh, 1)
	end
end

function isVeh(veh)
	if not isElement(veh) then return false end
	if(not getElementData(veh, "isVeh")) then return false end
	if(not tonumber(getElementData(veh, "vehID"))) then return false end
	return true
end

function isPlayerVeh(player, vehID)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end
	if(vehInfo.ownerType == 1 and vehInfo.ownerID == getElementData(player, "charID")) then return true end
	return false
end

function doesPlayerHaveVehAdminPerm(player, vehID)
	if(exports.titan_admin:doesPlayerHaveAdminDuty(player)) then return true end
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end
	if(vehInfo.ownerType == 1) then
		if(vehInfo.ownerID == getElementData(player, "charID")) then return true end
		return false
	elseif(vehInfo.ownerType == 2) then
		if(exports.titan_orgs:isGroup(vehInfo.ownerID)) then
			if(exports.titan_orgs:doesPlayerHavePerm(player, vehInfo.ownerID, "leader")) then return true end
			return false
		end
		return false
	end
end


function doesPlayerHaveDrivePerm(player, vehID)
	if(exports.titan_admin:doesPlayerHaveAdminDuty(player)) then return true end
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end
	vehInfo.ownerType = tonumber(vehInfo.ownerType)
	vehInfo.ownerID = tonumber(vehInfo.ownerID)
	if(vehInfo.ownerType == 1) then
		--[[local playerItems = exports.titan_items:getPlayerItems(player)
		if not playerItems then return false end
		for k, v in ipairs(playerItems) do
			if v.type == 10 then
				if tonumber(v.val1) == tonumber(vehInfo.ID) then
					return true
				end
			end
		end]]
		if vehInfo.ownerID == player:getData("charID") then return true end
		return false
	elseif(vehInfo.ownerType == 2) then
		if(exports.titan_orgs:isGroup(vehInfo.ownerID)) then
			if exports.titan_orgs:doesPlayerHaveGroup(player, vehInfo.ownerID) then
				if(exports.titan_orgs:doesPlayerHavePerm(player, vehInfo.ownerID, "vehicles")) then return true end
				return false
			end
			return false
		end
		return false
	elseif vehInfo.ownerType == 3 then
		if exports.titan_casual:getPlayerCasualWork(player) == vehInfo.ownerID then return true end
		return false
	end
end

function getFreeVehicleIndex()
	local i = 1
	while(true) do
		if(type(vehData[i]) ~= "table") then return i end
		i = i + 1
	end
	return false
end

function vehDestroy(vehID)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return end
	if(isElement(vehInfo.veh)) then
		destroyElement(vehInfo.veh)
	end
	exports.titan_db:query_free("DELETE FROM _vehicles WHERE ID = ?", vehInfo.ID)
	local index = vehIndex[vehInfo.ID]
	vehIndex[vehInfo.ID] = false
	vehData[index] = nil
	
	return true
end

function vehCreate(ownType, owner, vehModel, px, py, pz, prz, inter, vw, spawned)
	if spawned == nil then spawned = true end
	local carplate = exports.titan_misc:generateCarPlate()
	local dmg = '[{"wheel1": 0, "wheel2": 0, "wheel3": 0, "wheel4": 0, "light1": 0, "light2": 0, "light3": 0, "light4": 0, "door1": 0, "door2": 0, "door3": 0, "door4": 0, "door5": 0, "door6": 0, "panel1": 0, "panel2": 0, "panel3": 0, "panel4": 0, "panel5": 0, "panel6": 0, "panel7": 0}]'
	local query, rows, lastID = exports.titan_db:query("INSERT INTO _vehicles SET name = ?, ownerType = ?, ownerID = ?, model = ?, spawned = '1', locked = '0', x = ?, y = ?, z = ?, rz = ?, fuel = '50', damage = ?, interior = ?, dimension = ?, carplate = ?", getVehicleNameFromModel(vehModel), ownType, owner, vehModel, px, py, pz, prz, dmg, inter, vw, carplate)
	if(tonumber(lastID) and lastID > 0) then
		local index = getFreeVehicleIndex()
		vehIndex[lastID] = index
		vehData[index] = 
		{
			ID = lastID,
			name = getVehicleNameFromModel(vehModel),
			ownerType = ownType,
			ownerID = owner,
			c1r = math.random(0, 255),
			c1g = math.random(0, 255),
			c1b = math.random(0, 255),
			c2r = math.random(0, 255),
			c2g = math.random(0, 255),
			c2b = math.random(0, 255),
			model = vehModel,
			hp = 1000,
			x = px,
			y = py,
			z = pz,
			rx = 0,
			ry = 0,
			rz = prz,
			v1 = 0,
			v2 = 0,
			fuel = 50,
			damage = fromJSON(dmg),
			interior = inter,
			dimension = vw,
			distance = 0,
			maxfuel = 50,
			sirenType = 0,
			carplate = carplate
		}
		if spawned then sVehicle(lastID) end
		return lastID
	else 
		return false
	end
end

function getElementSpeed(theElement, unit)
	-- Check arguments for errors
	assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
	assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
	return (Vector3.create(getElementVelocity(theElement)) * 180).length
end

function assignVehicle(vehID, ownerType, owner)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end

	vehInfo.ownerType = ownerType
	vehInfo.ownerID = owner
	if isElement(vehInfo.veh) then
		setElementData(vehInfo.veh, "ownerData", {vehInfo.ownerType, vehInfo.ownerID})
	end
	exports.titan_db:query_free("UPDATE _vehicles SET ownerType = ?, ownerID = ? WHERE ID = ?", ownerType, owner, vehInfo.ID)
	outputDebugString(string.format("[VEHICLES] Przypisano pojazd. [ID: %d, nazwa: %s, ownerType: %d, owner: %d]", vehInfo.ID, vehInfo.name, ownerType, owner))
	return true
end

function isPlayerVehicleOwner(player, vehID)
	if(not exports.titan_login:isLogged(player)) then return false end
end

function changeVehicleColor(vehID, color, cr, cg, cb)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end
	cr, cg, cb = tonumber(cr), tonumber(cg), tonumber(cb)
	if(color == 1) then
		vehInfo.c1r = cr
		vehInfo.c1g = cg
		vehInfo.c1b = cb
		exports.titan_db:query_free("UPDATE _vehicles SET c1r = ?, c1g = ?, c1b = ? WHERE ID = ?", cr, cg, cb, vehInfo.ID)
		if(isElement(vehInfo.veh)) then
			setVehicleColor(vehInfo.veh, vehInfo.c1r, vehInfo.c1g, vehInfo.c1b, vehInfo.c2r, vehInfo.c2g, vehInfo.c2b)
		end
		return true
	elseif(color == 2) then
		vehInfo.c2r = cr
		vehInfo.c2g = cg
		vehInfo.c2b = cb
		exports.titan_db:query_free("UPDATE _vehicles SET c2r = ?, c2g = ?, c2b = ? WHERE ID = ?", cr, cg, cb, vehInfo.ID)
		if(isElement(vehInfo.veh)) then
			setVehicleColor(vehInfo.veh, vehInfo.c1r, vehInfo.c1g, vehInfo.c1b, vehInfo.c2r, vehInfo.c2g, vehInfo.c2b)
		end
		return true
	end
	return false
end

function getClosestVehicle(player, radius)
	local defaultRadius = 5.0
	local nearData = 
	{
		dist = radius and radius or defaultRadius
	}
	local dim, int = player:getDimension(), player:getInterior()
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius and radius or defaultRadius)
	local vehicles = getElementsWithinColShape(sphere, "vehicle")
	destroyElement(sphere)
	for k, v in ipairs(vehicles) do
		if v:getInterior() == int and v:getDimension() == dim then
			local vX, vY, vZ = getElementPosition(v)
			local tmpDist = getDistanceBetweenPoints3D(pX, pY, pZ, vX, vY, vZ)
			if tmpDist < nearData.dist then
				nearData.dist = tmpDist
				nearData.elem = v
			end
		end
	end
	if not nearData.elem then return false end
	return nearData.elem
end

function getVehiclesOppositeToYou(player)
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, 15)
	local vehicles = getElementsWithinColShape(sphere, "vehicle")
	destroyElement(sphere)
	local tmpTab = {}
	for k, v in ipairs(vehicles) do
		if isVeh(v) then
			table.insert(tmpTab, v)
		end
	end
	return tmpTab
end

function getVehiclesOppositeToYouTireBlock(player)
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, 5)
	local vehicles = getElementsWithinColShape(sphere, "vehicle")
	destroyElement(sphere)
	local tmpTab = {}
	for k, v in ipairs(vehicles) do
		if isVeh(v) then
			table.insert(tmpTab, v)
		end
	end
	return tmpTab
end

function fixOnlyBroken(vehID)
	local vehInfo = getVehInfo(vehID)
	--if vehInfo then vehInfo.broken = false if isElement(vehInfo.vehElement) then setVehicleDamageProof(vehInfo.vehElement, false) end end
	if vehInfo then
		vehInfo.broken = false
		if isElement(vehInfo.vehElement) then
			setVehicleDamageProof(vehInfo.vehElement, false)
		end
	end
end

function fixBrokenVehicle(vehID)
	local vehInfo = getVehInfo(vehID)
	if(vehInfo) then
		vehInfo.damage = fromJSON('[{"wheel1": 0, "wheel2": 0, "wheel3": 0, "wheel4": 0, "light1": 0, "light2": 0, "light3": 0, "light4": 0, "door1": 0, "door2": 0, "door3": 0, "door4": 0, "door5": 0, "door6": 0, "panel1": 0, "panel2": 0, "panel3": 0, "panel4": 0, "panel5": 0, "panel6": 0, "panel7": 0}]')
		vehInfo.broken = false
	end
end

function saveVeh(vehID)
	local vehInfo = getVehInfo(vehID)
	if(vehInfo) then
		if(isElement(vehInfo.veh)) then
			local tmpTable = {}
			tmpTable.wheel1, tmpTable.wheel2, tmpTable.wheel3, tmpTable.wheel4 = getVehicleWheelStates(vehInfo.veh)
			tmpTable.light1 = getVehicleLightState(vehInfo.veh, 0)
			tmpTable.light2 = getVehicleLightState(vehInfo.veh, 1)
			tmpTable.light3 = getVehicleLightState(vehInfo.veh, 2)
			tmpTable.light4 = getVehicleLightState(vehInfo.veh, 3)
			tmpTable.door1 = getVehicleDoorState(vehInfo.veh, 0)
			tmpTable.door2 = getVehicleDoorState(vehInfo.veh, 1)
			tmpTable.door3 = getVehicleDoorState(vehInfo.veh, 2)
			tmpTable.door4 = getVehicleDoorState(vehInfo.veh, 3)
			tmpTable.door5 = getVehicleDoorState(vehInfo.veh, 4)
			tmpTable.door6 = getVehicleDoorState(vehInfo.veh, 5)
			tmpTable.panel1 = getVehiclePanelState(vehInfo.veh, 0)
			tmpTable.panel2 = getVehiclePanelState(vehInfo.veh, 1)
			tmpTable.panel3 = getVehiclePanelState(vehInfo.veh, 2)
			tmpTable.panel4 = getVehiclePanelState(vehInfo.veh, 3)
			tmpTable.panel5 = getVehiclePanelState(vehInfo.veh, 4)
			tmpTable.panel6 = getVehiclePanelState(vehInfo.veh, 5)
			tmpTable.panel7 = getVehiclePanelState(vehInfo.veh, 6)
			vehInfo.hp = getElementHealth(vehInfo.veh)
			if(vehInfo.hp < 350.0) then	vehInfo.hp = 350.0 end
			if(getElementData(vehInfo.veh, "vLightsOn")) then
				tmpTable.light1 = 0
				tmpTable.light2 = 0
				tmpTable.light3 = 0
				tmpTable.light4 = 0
			end
			local dist = vehInfo.distance
			if not tonumber(dist) then dist = 0 end

			vehInfo.damage = tmpTable

			exports.titan_db:query_free("UPDATE _vehicles SET hp = ?, damage = ?, fuel = ?, distance = ? WHERE ID = ?", vehInfo.hp, toJSON(tmpTable), vehInfo.fuel, dist, vehInfo.ID)
		end
	end
end

function getVehicleTable(ownerType, owner)
	local tmpTable = {}
	if(tonumber(ownerType) and tonumber(owner)) then
		for k, v in pairs(vehData) do
			if(v and v.ownerType == ownerType and v.ownerID == owner) then
				table.insert(tmpTable, v)
			end
		end
		if(#tmpTable <= 0) then return false end
		return tmpTable
	end
	return false
end

function getPlayerSpawnedVehicleCount(player)
	local vehTable = getVehInfo(1, getElementData(player, "charID"))
	if not vehTable then return 0 end
	local count = 0
	for k, v in ipairs(vehTable) do
		if v.spawned == 1 then count = count + 1 end
	end
	return count
end

function getVehiclesToDashboard(player)
	local vehs = getVehicleTable(1, player:getData("charID"))
	if(not vehs) then vehs = {} end
	--exports.titan_dashboard:setPlayerVehicles(player, vehs)
	return vehs
end

function respawnGroupVehicles(ownerID)
	local query = exports.titan_db:query("SELECT ID FROM _vehicles WHERE ownerType = '2' AND ownerID = ?", ownerID)
	if(#query > 0) then
		for k, v in ipairs(query) do
			local vehInfo = getVehInfo(v.ID)
			if(vehInfo) then
				if(not isElement(vehInfo.veh)) then
					sVehicle(vehInfo.ID)
				else
					if(isVehicleEmpty(vehInfo.veh)) then
						respawnVehicle(vehInfo.veh)
						vehInfo.engineState = false
						setElementData(vehInfo.veh, "engineState", false)
						setVehicleEngineState(vehInfo.veh, false)
						vehInfo.lightState = false
						setElementData(vehInfo.veh, "lightState", false)
						setVehicleOverrideLights(vehInfo.veh, 1)
					end
				end
			end
		end
	else
		return true, 0
	end
end

function getGroupVehicles(ownerID)
	local query = exports.titan_db:query("SELECT ID FROM _vehicles WHERE ownerType = '2' AND ownerID = ?", ownerID)
	local tmpTable = {}
	for k, v in ipairs(query) do
		local vehInfo = getVehInfo(v.ID)
		if vehInfo then
			table.insert(tmpTable, vehInfo)
		end
	end
	if(#query <= 0) then return false end
	return tmpTable
end

function getWorkVehicles(workID)
	local vehTable = {}
	for k, v in pairs(vehData) do
		if v and v.ownerType == 3 and v.ownerID == workID then
			if isElement(v.veh) then
				outputChatBox("TEST2")
				table.insert(vehTable, v)
			end
		end
	end
	return vehTable
end

function locateVehicle(player, vehID)
	if(not exports.titan_login:isLogged(player)) then return end
	if(not vehID) then
		if(type(getElementData(player, "locateVeh") == "table")) then
			local locateVeh = getElementData(player, "locateVeh")
			if(isElement(locateVeh[2])) then destroyElement(locateVeh[2]) end
			if(isElement(locateVeh[3])) then destroyElement(locateVeh[3]) end
			setElementData(player, "locateVeh", false)
		end
		exports.titan_noti:showBox(player, "Namierzanie wyłączone.")
		return
	end
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego pojazdu.")
		return
	end

	if(not isElement(vehInfo.veh)) then
		exports.titan_noti:showBox(player, "Pojazd nie jest zespawnowany.")
		return
	end
	local locateVeh = getElementData(player, "locateVeh")
	if(type(locateVeh) == "table") then
		if(isElement(locateVeh[2])) then destroyElement(locateVeh[2]) end
		if(isElement(locateVeh[3])) then destroyElement(locateVeh[3]) end
		setElementData(player, "locateVeh", false)
	end

	local marker = createMarker(0, 0, 0, "cylinder", 4.0, 255, 0, 0, 100, player)
	attachElements(marker, vehInfo.veh, 0, 0, -1)

	local blip = createBlip(0, 0, 0, 0, 2, 255, 0, 0, 255, 0, 99999.0, player)
	setElementParent(blip, vehInfo.veh)
	setElementParent(marker, vehInfo.veh)
	attachElements(blip, vehInfo.veh)
	local tmpTable = {vehID, marker, blip}
	setElementData(player, "locateVeh", tmpTable)
	exports.titan_noti:showBox(player, "Pojazd został namierzony.")
end

function setVehFlashType(vehID, flashType)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end

	vehInfo.flashType = flashType
	exports.titan_db:query_free("UPDATE _vehicles SET flashType = ? WHERE ID = ?", flashType, vehInfo.ID)
	if(isElement(vehInfo.veh)) then
		if(tonumber(getElementData(vehInfo.veh, "flashType"))) then
			setElementData(vehInfo.veh, "flashType", flashType)
		end
	end
	return true
end

function parkVehicle(veh)
	if isElement(veh) and isVeh(veh) then

		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if not vehInfo then return end
		local pX, pY, pZ = getElementPosition(veh)
		local rX, rY, rZ = getElementRotation(veh)
		local int = getElementInterior(veh)
		local vw = getElementDimension(veh)
		vehInfo.x = pX
		vehInfo.y = pY
		vehInfo.z = pZ
		vehInfo.rx = rX
		vehInfo.ry = rY
		vehInfo.rz = rZ
		vehInfo.interior = int
		vehInfo.dimension = vw
		exports.titan_db:query_free("UPDATE _vehicles SET x = ?, y = ?, z = ?, rx = ?, ry = ?, rz = ?, interior = ?, dimension = ? WHERE ID = ?", pX, pY, pZ, rX, rY, rZ, int, vw, vehInfo.ID)
		exports.titan_noti:showBox(player, string.format("Pojazd %s został zaparkowany pomyślnie.", vehInfo.name))
		setVehicleRespawnPosition(veh, pX, pY, pZ, rX, rY, rZ)
	end
end

function changeVehicleData(vehID, dataName, data, onDB)
	if onDB ~= true and onDB ~= false then onDB = true end
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end
	vehInfo[dataName] = data
	if onDB then
		exports.titan_db:query_free("UPDATE _vehicles SET ?? = ? WHERE ID = ?", tostring(dataName), tostring(data), vehInfo.ID)
	end
	return true
end

function changeVehicleDistance(vehElement, vehDistance)
	if exports.titan_login:isLogged(source) then
		if isVeh(vehElement) then
			local vehInfo = getVehInfo(vehElement:getData("vehID"))
			if vehInfo then
				vehInfo.distance = vehInfo.distance + vehDistance
				vehElement:setData("vehDistance", vehInfo.distance)
			end
		end
	end
end
addEvent("changeVehicleDistance", true)
addEventHandler("changeVehicleDistance", root, changeVehicleDistance)

function showVehInfo(player, vehID)
	local vehInfo = getVehInfo(vehID)
	local owner = ""
	if vehInfo.ownerType == 1 then
		local query = exports.titan_db:query("SELECT c.name, c.lastname, m.members_display_name FROM _characters c LEFT JOIN ipb_members m ON (m.member_id = c.memberID) WHERE c.ID = ? LIMIT 1", vehInfo.ownerID)
		if query then
			query = query[1]
			owner = string.format("%s %s (%s)", query.name, query.lastname, query.members_display_name)
		end
	elseif vehInfo.ownerType == 2 then
		local query = exports.titan_db:query("SELECT name FROM _groups WHERE ID = ? LIMIT 1", vehInfo.ownerID)
		if query then
			query = query[1]
			owner = query.name
		end
	end
	if not vehInfo then return end
	local tmpTable = 
	{
		[1] = 
		{
			title = "ID pojazdu",
			color = {255, 255, 255},
			text = vehInfo.ID
		},
		[2] =
		{
			title = "Model pojazdu",
			color = {255, 255, 255},
			text = string.format("%s (%d)", getVehicleNameFromModel(vehInfo.model), vehInfo.model)
		},
		[3] =
		{
			title = "Kolor 1 pojazdu",
			color = {vehInfo.c1r, vehInfo.c1g, vehInfo.c1b},
			text = string.format("rgb(%d, %d, %d)", vehInfo.c1r, vehInfo.c1g, vehInfo.c1b)
		},
		[4] =
		{
			title = "Kolor 2 pojazdu",
			color = {vehInfo.c2r, vehInfo.c2g, vehInfo.c2b},
			text = string.format("rgb(%d, %d, %d)", vehInfo.c2r, vehInfo.c2g, vehInfo.c2b)
		},
		[5] =
		{
			title = "Typ właściciela",
			color = {255, 255, 255},
			text = vehInfo.ownerType == 1 and "Gracz" or vehInfo.ownerType == 2 and "Grupa" or "Nieznany"
		},
		[6] = 
		{
			title = "Właściciel",
			color = {255, 255, 255},
			text = owner
		},
		[7] = 
		{
			title = "UID właściciela",
			color = {255, 255, 255},
			text = vehInfo.ownerID
		},
		[8] =
		{
			title = "HP pojazdu",
			color = {255, 255, 255},
			text = string.format("%0.1f", vehInfo.hp)
		},
		[9] =
		{
			title = "Ilość paliwa",
			color = {255, 255, 255},
			text = string.format("%0.1f", vehInfo.fuel)
		},
		[10] =
		{
			title = "Pojemność zbiornika",
			color = {255, 255, 255},
			text = string.format("%0.1f", vehInfo.maxfuel)
		},
		[11] =
		{
			title = "Rejestracja pojazdu",
			color = {255, 255, 255},
			text = vehInfo.carplate
		},
		[12] =
		{
			title = "Typ świateł emergency",
			color = {255, 255, 255},
			text = vehInfo.flashType and vehInfo.flashType or 0
		},
		[13] =
		{
			title = "Typ sygnałów emergency",
			color = {255, 255, 255},
			text = vehInfo.sirenType and vehInfo.sirenType or 0
		},
	}


	triggerClientEvent(player, "vinfogui.show", player, tmpTable)
end


function showVehTune(player, vehID)
	local vehInfo = getVehInfo(vehID)
	if not vehInfo then return end
	local tmpTable = {}
	local query = exports.titan_db:query("SELECT * FROM _items WHERE ownerType = ? AND owner = ?", 10, vehInfo.ID)
	for k, v in ipairs(query) do
		table.insert(tmpTable, v)
	end
	triggerClientEvent(player, "vtunegui.show", player, tmpTable)
end
addEvent("showVehTune", true)
addEventHandler("showVehTune", root, showVehTune)

function showPrzypisz(player, vehID)
	local vehInfo = getVehInfo(vehID)
	local owner = ""
	if not vehInfo then return end
	-- local tmpTable = {}
	
	local group = exports.titan_orgs:getAllGroups()
	local playerGroups = exports.titan_orgs:getPlayerGroups(player)
	if(not playerGroups) then
		exports.titan_noti:showBox(player, "Nie posiadasz żadnych grup.")
		return
	end

	groupa = {}
	for i,v in ipairs(group) do
		if exports.titan_orgs:doesPlayerHaveGroupLeader(player, v.ID) then
			table.insert(groupa,v)
		end
	end
	triggerClientEvent(player, "showAssignVehicleGUI", player, vehInfo.ID, groupa)
end
addEvent("showPrzypisz", true)
addEventHandler("showPrzypisz", root, showPrzypisz)

----------------
-- GUI EVENTY --
----------------

function onPlayerClickOptionVehicleGUI(player, vehID, option)
	-- // Wykaz opcji
	-- || 1 - INFO
	-- || 2 - SPAWN/UNSPAWN
	-- || 3 - NAMIERZ
	-- || 4 - PRZYPISZ
	-- || 5 - TUNING
	-- \\ Wykaz opcji - koniec
	if(not exports.titan_login:isLogged(player)) then return false end
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego pojazdu.")
		return false
	end
	if(not isPlayerVeh(player, vehID)) then
		exports.titan_noti:showBox(plyer, "Ten pojazd nie należy do Ciebie.")
		return false
	end

	if(option == 1) then
		showVehInfo(player, vehID)
		return true
	elseif(option == 2) then
		if(isElement(vehInfo.veh)) then
			if vehInfo.tireBlock == 1 then
				exports.titan_noti:showBox(player, "Pojazd ma założona blokadę na koło.")
				return
			end
			if not isVehicleEmpty(vehInfo.veh) then return exports.titan_noti:showBox(player, "Pojazd nie jest pusty.") end
			vehInfo.spawned = 0
			uSVehicle(vehInfo.ID)
			exports.titan_noti:showBox(player, string.format("%s odspawnowany pomyślnie.", vehInfo.name))
			return true
		else
			vehInfo.spawned = 1
			sVehicle(vehInfo.ID)
			exports.titan_noti:showBox(player, string.format("%s zespawnowany pomyślnie.", vehInfo.name))
			return true
		end
	elseif(option == 3) then
		local locateVeh = getElementData(player, "locateVeh")
		if(type(locateVeh) == "table" and locateVeh[1] == vehID) then
			if(isElement(locateVeh[2])) then destroyElement(locateVeh[2]) end
			if(isElement(locateVeh[3])) then destroyElement(locateVeh[3]) end
			setElementData(player, "locateVeh", false)
			exports.titan_noti:showBox(player, "Namierzanie wyłączone.")
		else
			locateVehicle(player, vehInfo.ID)
		end
		return true
	end
end
addEvent("onPlayerClickOptionVehicleGUI", true)
addEventHandler("onPlayerClickOptionVehicleGUI", root, onPlayerClickOptionVehicleGUI)

function serverSetElementFrozen(element, state)
	if isElement(element) then
		setElementFrozen(element, state)
	end
end
addEvent("serverSetElementFrozen", true)
addEventHandler("serverSetElementFrozen", root, serverSetElementFrozen)

function onMarkerHit(elem)
	if getElementType(elem) ~= "player" or type(getElementData(elem, "locateVeh")) ~= "table" then return end
	local locateTable = getElementData(elem, "locateVeh")
	if source == locateTable[2] then
		destroyElement(locateTable[2])
		destroyElement(locateTable[3])
		setElementData(elem, "locateVeh", false)
	end
end
addEventHandler("onMarkerHit", root, onMarkerHit)