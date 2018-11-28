----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local function loadVehicles()
	local loadTime = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _vehicles")
	if(#query > 0) then
		local index = 1
		for i = 1, #query do
			local vehInfo = query[i]
			vehInfo.damage = fromJSON(vehInfo.damage)
			if(type(vehInfo.damage) ~= "table") then
				vehInfo.damage = fromJSON('[{"wheel1": 0, "wheel2": 0, "wheel3": 0, "wheel4": 0, "light1": 0, "light2": 0, "light3": 0, "light4": 0, "door1": 0, "door2": 0, "door3": 0, "door4": 0, "door5": 0, "door6": 0, "panel1": 0, "panel2": 0, "panel3": 0, "panel4": 0, "panel5": 0, "panel6": 0, "panel7": 0}]')
				setElementData(vehInfo.veh, "damageTable", vehInfo.damage)
				exports.titan_db:query_free("UPDATE _vehicles SET damage = ? WHERE ID = ?", toJSON(vehInfo.damage), vehInfo.ID)
			end
			vehData[index] = vehInfo
			vehIndex[vehInfo.ID] = index
			index = index + 1
			vehInfo.broken = false

			if(vehInfo.ownerType == 2 or vehInfo.tireBlock == 1 or vehInfo.ownerType == 3) then
				if(vehInfo.spawned == 0) then
					exports.titan_db:query_free("UPDATE _vehicles SET spawned = '1' WHERE ID = ?", vehInfo.ID)
				end
				sVehicle(vehInfo.ID)
			end
			if(vehInfo.ownerType == 1 and vehInfo.spawned == 1 and vehInfo.tireBlock ~= 1) then
				exports.titan_db:query_free("UPDATE _vehicles SET spawned = '0' WHERE ID = ?", vehInfo.ID)
				vehInfo.spawned = 0
			end
		end
		outputDebugString(string.format("[VEHICLES] Zaladowano pojazdy (%d). | %d ms", #query, getTickCount() - loadTime))
	end

	for k, v in ipairs(getElementsByType("player")) do
		bindKey(v, "k", "down", "silnik")
		bindKey(v, "l", "down", "swiatla")
	end
end
addEventHandler("onResourceStart", resourceRoot, loadVehicles)

function stopRes()
	local loadTime = getTickCount()
	local vehs = 0
	for k,v in ipairs(getElementsByType("vehicle")) do
		if isVeh(v) then
			saveVeh(v:getData("vehID"))
			uSVehicle(v:getData("vehID"))
			vehs = vehs + 1
		end
	end
	outputDebugString(string.format("[VEHICLES] Zapisano pojazdy przy resource stop (%d). | %d ms", vehs, getTickCount() - loadTime))
end
addEventHandler("onResourceStop", resourceRoot, stopRes)

local function onJoin()
	bindKey(source, "k", "down", "silnik")
	bindKey(source, "l", "down", "swiatla")
end
addEventHandler("onPlayerJoin", root, onJoin)

function sVehicle(vehID)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return end

	if(vehInfo.hp <= 350) then 
		vehInfo.hp = 350.0
		exports.titan_db:query_free("UPDATE _vehicles SET hp = '350' WHERE ID = ?", vehInfo.ID)
		vehInfo.broken = true
	end
	
	local query = exports.titan_db:query("SELECT ownerType, ownerID, x, y, z, rx, ry, rz FROM _vehicles WHERE ID = ?", vehInfo.ID)
	vehInfo.ownerType = query[1]["ownerType"]
	vehInfo.ownerID = query[1]["ownerID"]
	vehInfo.x = query[1]["x"]
	vehInfo.y = query[1]["y"]
	vehInfo.z = query[1]["z"]
	vehInfo.rx = query[1]["rx"]
	vehInfo.ry = query[1]["ry"]
	vehInfo.rz = query[1]["rz"]
	
	--------------------------------------
	-- UNSPAWNOWANIE POJAZDU NA MIEJSCU --
	--------------------------------------
	for k,v in ipairs(getElementsByType("vehicle")) do
	local x, y, z = getElementPosition(v)
		if getDistanceBetweenPoints3D(vehInfo.x, vehInfo.y, vehInfo.z, x, y, z) <= 2 then
			if not getElementData(v, "vehID") then destroyElement(v) end
			uSVehicle(getElementData(v, "vehID"))
		end
	end
	
	vehInfo.veh = createVehicle(vehInfo.model, vehInfo.x, vehInfo.y, vehInfo.z, vehInfo.rx, vehInfo.ry, vehInfo.rz, "", false, vehInfo.v1, vehInfo.v2)
	if(isElement(vehInfo.veh)) then
		exports.titan_db:query_free("UPDATE _vehicles SET spawned = 1, locked = 1 WHERE ID = ?", vehInfo.ID)
		setVehicleColor(vehInfo.veh, vehInfo.c1r, vehInfo.c1g, vehInfo.c1b, vehInfo.c2r, vehInfo.c2g, vehInfo.c2b) -- kolorek
		
		local isBike = false
		for k, v in ipairs(bikes) do
			if v == vehInfo.model then
				isBike = true
				break
			end
		end

		if isBike then
			vehInfo.locked = 0
			setVehicleLocked(vehInfo.veh, false)
		else
			if vehInfo.ownerType ~= 3 then
				vehInfo.locked = 1
				setVehicleLocked(vehInfo.veh, true)
			else
				vehInfo.locked = 0
				setVehicleLocked(vehInfo.veh, false)
			end
		end
		-- vehInfo.locked = 1
		setVehicleDamageProof( vehInfo.veh, true )
		setVehicleLocked(vehInfo.veh, true)
		
		setVehicleEngineState(vehInfo.veh, false)
		setVehicleOverrideLights(vehInfo.veh, 1)
		setVehicleFuelTankExplodable(vehInfo.veh, false)
		setElementHealth(vehInfo.veh, vehInfo.hp)
		setElementData(vehInfo.veh, "engineState", false)
		setElementData(vehInfo.veh, "lightState", false)
		setElementData(vehInfo.veh, "isVeh", true)
		setElementData(vehInfo.veh, "vehID", vehInfo.ID)
		setElementData(vehInfo.veh, "vehBroken", vehInfo.broken)
		setElementData(vehInfo.veh, "vehFuel", vehInfo.fuel)
		setElementData(vehInfo.veh, "vehMaxfuel", vehInfo.maxfuel)
		setElementData(vehInfo.veh, "vehDistance", vehInfo.distance)
		setElementData(vehInfo.veh, "vehDarkWindows", vehInfo.darkWindows)
		setElementData(vehInfo.veh, "ownerData", {query[1][1], query[1][2]})
		setElementData(vehInfo.veh, "customPJ", vehInfo.customPj)
		setElementData(vehInfo.veh, "openWindows", false)
		exports.titan_paintjobs:updatePaintjob(vehInfo.veh)

		setElementID(vehInfo.veh, "veh"..vehInfo.ID)

		setElementInterior(vehInfo.veh, vehInfo.interior)
		setElementDimension(vehInfo.veh, vehInfo.dimension)

		setVehiclePlateText(vehInfo.veh, vehInfo.carplate)

		vehInfo.engineState = false
		vehInfo.lightState = false
		vehInfo.spawned = 1

		if tonumber(vehInfo.sirenType) and vehInfo.sirenType > 0 then
			setElementData(vehInfo.veh, "siren:type", vehInfo.sirenType)
		end

		-------------------------
		-- ZNISZCZENIA POJAZDU --
		-------------------------
		if(type(vehInfo.damage) ~= "table") then
			vehInfo.damage = fromJSON('[{"wheel1": 0, "wheel2": 0, "wheel3": 0, "wheel4": 0, "light1": 0, "light2": 0, "light3": 0, "light4": 0, "door1": 0, "door2": 0, "door3": 0, "door4": 0, "door5": 0, "door6": 0, "panel1": 0, "panel2": 0, "panel3": 0, "panel4": 0, "panel5": 0, "panel6": 0, "panel7": 0}]')
			exports.titan_db:query_free("UPDATE _vehicles SET damage = ? WHERE ID = ?", toJSON(vehInfo.damage), vehInfo.ID)
		end
		setElementData(vehInfo.veh, "damageTable", vehInfo.damage)
		setVehicleDoorsUndamageable(vehInfo.veh, false)
		for i = 0, 6 do
			if i <= 3 then setVehicleLightState(vehInfo.veh, i, vehInfo.damage["light"..i + 1]) end
			if i <= 5 then setVehicleDoorState(vehInfo.veh, i, vehInfo.damage["door"..i + 1]) end
			setVehiclePanelState(vehInfo.veh, i, vehInfo.damage["panel"..i + 1])
		end
		setVehicleWheelStates(vehInfo.veh, vehInfo.damage.wheel1, vehInfo.damage.wheel2, vehInfo.damage.wheel3, vehInfo.damage.wheel4)
		
		setVehicleDamageProof(vehInfo.veh, true)

		------------
		-- RECZNY --
		------------
		if vehInfo.handbrake == 1 or vehInfo.ownerType == 3 then
			setElementFrozen(vehInfo.veh, true)
			vehInfo.veh:setData("handbrake", true)
		else
			vehInfo.veh:setData("handbrake", false)
		end
		
		---------------
		-- DANE GRUP --
		---------------
		if vehInfo.ownerType == 2 then
			if exports.titan_orgs:doesGroupHavePerm(vehInfo.ownerID, "gps") then
				vehInfo.veh:setData("hasGPS", true)
				vehInfo.veh:setData("gpsGroupID", vehInfo.ownerID)
				vehInfo.veh:setData("hasGPSOn", true)
				local r, g, b = exports.titan_orgs:getGroupColor(vehInfo.ownerID)
				if r then
					vehInfo.veh:setData("gpsColor", {r, g, b})
				end
			end
		end

		------------------------
		-- TUNING MECHANICZNY --
		------------------------
		--[[local query = exports.titan_db:query("SELECT * FROM _vehtuning WHERE vehID=?",vehInfo.ID)
		if(#query > 0) then
			for _,tune in ipairs(query) do
				--exports.titan_tuning:setVehicleComponentProperty(false, vehInfo.veh, tonumber(tune.value), tune.locked )
			end
		end]]
		-- TUNING TYMCZASOWO WYŁĄCZONY

		setVehicleParts(vehInfo.ID)

		setElementData(vehInfo.veh, "no:damage", true)
		if isElement(vehInfo.veh) then
			setTimer(function(veh)
				if isElement(veh) then
					setElementData(veh, "no:damage", false)
				end
			end, 1000, 1, vehInfo.veh)
		end
		--setTimer(setElementData,1000,1,vehInfo.veh,"no:damage",false)

		if getElementModel(vehInfo.veh) == 522 then setVehicleVariant(vehInfo.veh, 2, math.random(3, 4)) end
		--setVehicleState(vehInfo.veh)
		return true
	end
	return false
end

function uSVehicle(vehID)
	local vehInfo = getVehInfo(vehID)
	if(not vehInfo) then return false end

	if(not isElement(vehInfo.veh)) then return false end
	saveVeh(vehID)
	vehInfo.spawned = 0
	exports.titan_db:query_free("UPDATE _vehicles SET spawned = 0, damage = ? WHERE ID = ?", type(vehInfo.damage) == "table" and toJSON(vehInfo.damage) or '[{"wheel1": 0, "wheel2": 0, "wheel3": 0, "wheel4": 0, "light1": 0, "light2": 0, "light3": 0, "light4": 0, "door1": 0, "door2": 0, "door3": 0, "door4": 0, "door5": 0, "door6": 0, "panel1": 0, "panel2": 0, "panel3": 0, "panel4": 0, "panel5": 0, "panel6": 0, "panel7": 0}]', vehInfo.ID)
	destroyElement(vehInfo.veh)
	return true
end

function isVehicleEmpty( vehicle )
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end
 
	local passengers = getVehicleMaxPassengers( vehicle )
	if type( passengers ) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant( vehicle, seat ) then
				return false
			end
		end
	end
	return true
end

function turnVehFlash(veh, state, flashType)
	if(state) then
		setElementData(veh, "flashType", flashType)
	else
		setElementData(veh, "flashType", false)
		setTimer(
		function(veh)
			if(isVeh(veh)) then
				local vehInfo = getVehInfo(getElementData(veh, "vehID"))
				if(vehInfo) then
					setVehicleLightState(veh, 0, 0)
					setVehicleLightState(veh, 1, 0)
					setVehicleLightState(veh, 2, 0)
					setVehicleLightState(veh, 3, 0)
					setVehicleHeadLightColor(veh, 0, 0, 0)
					setVehicleHeadLightColor(veh, 255, 255, 255)
					if(vehInfo.lightState) then
						setVehicleOverrideLights(veh, 2)
					else
						setVehicleOverrideLights(veh, 2)
						setVehicleOverrideLights(veh, 1)
					end
				end
			end
		end, 200, 1, veh)
	end
end

function onClientFinalizeKogutPosCheck(player, posZ)
	if(not exports.titan_login:isLogged(player)) then return end

	if(not posZ) then
		exports.titan_noti:showBox(player, "Nie udało się pobrać pozycji do umieszenia koguta na pojeździe.")
		return
	end

	if(not isPedInVehicle(player)) then 
		exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.")
		return
	end
	local veh = getPedOccupiedVehicle(player)
	local vehInfo = getVehInfo(getElementData(veh, "vehID"))
	if(not vehInfo) then
		exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
		return
	end
	if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
		exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
		return
	end
	local kogutElement = getElementData(veh, "kogutElement")
	if(isElement(kogutElement)) then
		destroyElement(kogutElement)
	end

	local vX, vY, vZ = getElementPosition(veh)
	local object = createObject(1854, vX, vY, vZ)
	setElementParent(object, veh)
	attachElements(object, veh, -0.4, 0, posZ)
	setElementData(veh, "kogutElement", object)
	setElementData(veh, "doesKogutActive", true)
	setElementDoubleSided(object, true)
	exports.titan_noti:showBox(player, "Kogut został pomyślnie umiejscowiony na dachu.")
	return
end
addEvent("onClientFinalizeKogutPosCheck", true)
addEventHandler("onClientFinalizeKogutPosCheck", root, onClientFinalizeKogutPosCheck)

function reloadVehicle(veh)
	if not isElement(veh) then return false end
	if #getVehicleOccupants(veh) ~= 0 then return false end
	local id = getElementData(veh, "vehID")
	uSVehicle(id)
	sVehicle(id)
	outputChatBox("[VEHICLES] Przeładowano pojazd o UID: "..id)
end

------------
-- EVENTY --
------------

local function vStartEnter(player, seat, jacked, door)
	if exports.titan_login:isLogged(player) then
		if seat == 0 and tonumber(player:getData("vehBlock")) and player:getData("vehBlock") > 0 then
			if player:getData("vehBlock") > getRealTime().timestamp then
				outputChatBox("Posiadasz nałożona blokadę prowadzenia pojazdów!", player, 255, 0, 0)
				cancelEvent()
				return
			else
				player:setData("vehBlock", 0)
				exports.titan_db:query("UPDATE _characters SET vehBlock = '0' WHERE ID = ?", player:getData("charID"))
			end
		end

		if(isVeh(source)) then
			local vehInfo = getVehInfo(getElementData(source, "vehID"))
			if(vehInfo) then
				if vehInfo.ownerType == 3 then
					if vehInfo.ownerID == 2 then
						if exports.titan_casual:getPlayerCasualWork(player) ~= vehInfo.ownerID then
							cancelEvent()
							return exports.titan_noti:showBox(player, "Nie jesteś rozwozicielem pizzy.")
						end
					end
					if seat ~= 0 then
						cancelEvent()
						return exports.titan_noti:showBox(player, "Ten pojazd nie jest przystosowany do przewozu osób.")
					end
				elseif vehInfo.ownerType == 2 then
					if seat == 0 and not exports.titan_orgs:doesPlayerHavePerm(player, vehInfo.ownerID, "vehicles") then
						cancelEvent()
						return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do kierowania tym pojazdem.")
					end
				end
				if(vehInfo.locked == 1) then
					exports.titan_noti:showBox(player, "Drzwi są zamknięte.")
					cancelEvent()
					return
				end
				if(isElement(jacked)) then
					if(getElementData(jacked, "belts")) then
						exports.titan_noti:showBox(player, "Gracz ma zapięte pasy.")
						cancelEvent()
						return
					end
				end
				if(tonumber(getElementData(player, "boomboxID"))) then
					exports.titan_noti:showBox(player, "Nie możesz wsiąść do pojazdu z włączonym boomboxem.")
					cancelEvent()
					return
				end
				
			end
		end
	end
	setVehicleDamageProof( source, false )
	setElementData(player, "enteringVehicle", false)
end
addEventHandler("onVehicleStartEnter", root, vStartEnter)

local function vStartExit(player, seat, jacked, door)
	if(isVeh(source)) then
		local vehInfo = getVehInfo(getElementData(source, "vehID"))
		if(vehInfo) then
		if getElementModel(source) == 581 or getElementModel(source) == 462 or getElementModel(source) == 521 or getElementModel(source) == 463 or getElementModel(source) == 522 or getElementModel(source) == 461 or getElementModel(source) == 448 or getElementModel(source) == 468 or getElementModel(source) == 586 then return end -- motocykle
			if(vehInfo.locked == 1) then
				exports.titan_noti:showBox(player, "Drzwi są zamknięte.")
				cancelEvent()
				return
			end
			if(getElementData(player, "belts")) then
				exports.titan_noti:showBox(player, "Masz zapięte pasy.")
				cancelEvent()
				return
			end
			if getElementSpeed(source, "km/h") > 0 and getElementData(source, "handbrake") then
				exports.titan_noti:showBox(player, "Nie możesz wyskoczyć z pojazdu, gdy porusza się pojazd majacy zaciagniety reczny.")
				cancelEvent()
				return
			end
			--[[if isElementFrozen(source) then
				--outputDebugString("unFroze!")
				setElementFrozen(source, false)
			end]]
			--toggleControl(player, "handbrake", true)
			--setControlState(player, "handbrake", false)
		end
	end
	setElementData(player, "exitingVehicle", true)
	setControlState(player, "handbrake", false)
end
addEventHandler("onVehicleStartExit", root, vStartExit)

local function vEnter(player, seat, jacked)
	if seat == 0 then
		setVehicleDamageProof(source, false)
	end
	setElementData(player, "enteringVehicle", false)
	if(isVeh(source)) then
		for k, v in ipairs(bikes) do
			if v == getElementModel(source) then
				setVehicleEngineState(source, true)
				return
			end
		end
		local vehInfo = getVehInfo(getElementData(source, "vehID"))
		if vehInfo then
			local engineState = getElementData(source, "engineState")
			if(engineState) then
				
				if vehInfo.fuel <= 0 then
					setVehicleEngineState(source, false)
				else
					setVehicleEngineState(source, true)
				end
			else
				if seat == 0 then 
					exports.titan_help:showInfoHelp(player, "Aby uruchomić silnik wprowadź komendę /silnik, lub użyj przycisku K. Za światła odpowiada komenda /swiatla, lub przycisk L.")
				end
				setVehicleEngineState(source, false)
			end
			if vehInfo.ownerType == 3 then
				if vehInfo.ownerID == 2 then
					if exports.titan_casual:getPlayerCasualWork(player) ~= vehInfo.ownerID then
						removePedFromVehicle(player)
						exports.titan_noti:showBox(player, "Nie jesteś rozwozicielem pizzy.")
						return
					end
					if seat == 0 then
						vehInfo.veh:setData("handbrake", false)
						vehInfo.veh:setFrozen(false)
						setControlState(player, "handbrake", false)
						exports.titan_casual:pizzaDeliverOnVehicleEnter(player, source)
					end
				end
			end
			if(seat == 0) then
				triggerClientEvent(player, "vehDist.startNewRenderDist", player, source)
				if(not vehInfo.broken) then
					setVehicleDamageProof(source, false)
				end
			end
			if source:getData("carAudio") and source:getData("carAudioOn") then
				triggerClientEvent(player, "soundPlay.carAudioOn", player, source:getData("carAudio"))
			end

			---------
			-- GPS --
			---------
			-- if source:getData("hasGPS") and source:getData("hasGPSOn") and tonumber(source:getData("gpsGroupID")) then
			--	exports.titan_orgs:toggleVehicleBlips(player, source:getData("gpsGroupID"), true)
			-- end
		end
	end
	source:setDoorOpenRatio(seat + 2, 0)
	setVehicleDamageProof(source, false)
end
addEventHandler("onVehicleEnter", root, vEnter)

local function vExit(player, seat, jacked)
	setElementData(player, "exitingVehicle", false)
	if(isVeh(source)) then
		local query = exports.titan_db:query("SELECT damage FROM _vehicles WHERE ID = ?", getElementData(source, "vehID"))
		setElementData(source, "damageTable", fromJSON(query[1].damage))
		if(seat == 0) then
			local vehInfo = getVehInfo(getElementData(source, "vehID"))
			if(vehInfo) then
				if vehInfo.ownerType == 3 then
					if vehInfo.ownerID == 2 then
						return exports.titan_casual:pizzaDeliverOnVehicleExit(player, source)
					end
				else
					saveVeh(getElementData(source, "vehID"))
					setVehicleDamageProof(source, true)
					if getElementData(source, "handbrake") then
						setElementFrozen(source, true)
					end
				end
			end
		end
	end
end
addEventHandler("onVehicleExit", root, vExit)

local function vDamage(loss)
	local vehInfo = getVehInfo(source:getData("vehID"))
	if type(vehInfo) == "table" and loss >= 2 and not source:getData("no:damage") then
		if vehInfo.hasAlarm == 1 and vehInfo.locked == 1 then
			triggerClientEvent( "AlarmVehicleOn", source, source )
		end
	end

	if(isVeh(source) and isElement(getVehicleOccupant(source))) then
		if(getElementHealth(source) < 350 or getElementHealth(source) - loss < 350.0) then
			local vehInfo = getVehInfo(getElementData(source, "vehID"))
			if(vehInfo) then
				--[[if vehInfo.ownerType == 3 then
					if vehInfo.ownerID == 1 then
						respawnVehicle(vehInfo.veh)
						vehInfo.engineState = false
						setElementData(vehInfo.veh, "engineState", false)
						setVehicleEngineState(vehInfo.veh, false)
						vehInfo.lightState = false
						setElementData(vehInfo.veh, "lightState", false)
						setVehicleOverrideLights(vehInfo.veh, 1)
						fixBrokenVehicle(vehInfo.ID)
						return
					end
				end]]
				vehInfo.broken = true
				setVehicleDamageProof(vehInfo.veh, true)
				local occupant = getVehicleOccupant(source)
				if(isElement(occupant)) and not isElementInWater(source) then
					exports.titan_noti:showBox(occupant, "Pojazd jest zniszczony i nie nadaje się do użytku.")
				end
				setElementHealth(vehInfo.veh, 350.0)
				vehInfo.engineState = false
				setElementData(vehInfo.veh, "engineState", false)
				setVehicleEngineState(vehInfo.veh, false)
			end
		end
	end
	if loss > 70 then
		local healthLoss = loss / 20
		local occupants = getVehicleOccupants(source) or {}
		for k, v in pairs(occupants) do
			--if getElementData(v, "enteringVehicle") then return end
			--if getElementData(v, "exitingVehicle") then return end
			if(not getElementData(v, "belts")) then
				hpAccident(v, healthLoss)
			else
				hpAccident(v, healthLoss*0.5)
			end
		end
	end
end
addEventHandler("onVehicleDamage", root, vDamage)

function hpAccident(player, healthLoss)
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	local hp = getElementHealth(player)
	if(hp > 0) then
		if(isTimer(getElementData(player, "damageColorNickTimer"))) then
			killTimer(getElementData(player, "damageColorNickTimer"))
		end
		local timer = setTimer(function(player) setElementData(player, "damageColorNick", false) end, 500, 1, player)
		setElementData(player, "damageColorNickTimer", timer)
		setElementData(player, "damageColorNick", true)
		exports.titan_hud:colorPlayer(player)
		
		setElementHealth(player, hp - healthLoss)
	end
end

function vehTow(player)
	if exports.titan_login:isLogged(player) then
		
	end
end

function onPlayerVehicleExit()
	if isPedInVehicle(source) then
		local veh = getPedOccupiedVehicle(source)
		if isVeh(veh) then
			if veh:getData("hasGPS") then
				exports.titan_orgs:toggleVehicleBlips(source, veh:getData("gpsGroupID"), false)
			end
		end
	end
end

--addEventHandler("onPlayerWasted", root, onPlayerVehicleExit)


function fixVehicleState(vehicle,again)
local tab = getElementData(vehicle,"technicalState")
	if tab then
		for i=0,6 do
	
			if i >= 0 and i <= 3 then
				local state = getVehicleLightState ( vehicle, i )
				if tab.lights[i+1] ~= state then
					setVehicleLightState( vehicle, i, tab.lights[i] )
				end
			end
	
			if i >= 0 and i <= 5 then
				local state = getVehicleDoorState(vehicle, i)
				if tab.doors[i+1] ~= state then
					setVehicleDoorState( vehicle, i, tab.doors[i+1] )
				end
			end
	
			if i >= 0 and i <= 6 then
				local state = getVehiclePanelState(vehicle, i)
				if tab.parts[i+1] ~= state then
					setVehiclePanelState( vehicle, i, tab.parts[i+1] )
				end
			end
		end
	end
	if not(again) then
		setTimer(fixVehicleState, 100, 1, vehicle, true)
	end
end
addEvent( "fixVehicleState", true )
addEventHandler( "fixVehicleState", getRootElement(), fixVehicleState)

function getVehicleState(vehicle)
light = {}
door = {}
panel = {}
engine = {}
wheel = {}
	for i=0,6 do
		if i >= 0 and i <= 3 then
			local state = getVehicleLightState ( vehicle, i )
			light[i+1] = state
		end
	
		if i >= 0 and i <= 5 then
			local state = getVehicleDoorState(vehicle, i)
			door[i+1] = state
		end
	
		if i >= 0 and i <= 6 then
			local state = getVehiclePanelState ( vehicle, i )
			panel[i+1] = state
		end
	
		if i == 0 then
			local frontLeft, rearLeft, frontRight, rearRight = getVehicleWheelStates ( vehicle )
			wheel.frontLeft = frontLeft
			wheel.rearLeft = rearLeft
			wheel.frontRight = frontRight
			wheel.rearRight = rearRight
		end
	end
	state = {lights=light, doors=door, parts=panel, engine=engine, wheels=wheel}
	return state
end
addEvent( "getVehicleState", true )
addEventHandler( "getVehicleState", getRootElement(  ), getVehicleState)


function fixVehicleHP(vehicle, loss)
	setElementHealth( vehicle, getElementHealth( vehicle ) + loss )
end
addEvent( "fixVehicleHP", true )
addEventHandler( "fixVehicleHP", getRootElement(  ), fixVehicleHP)


-- function setVehicleState(vehicle)
-- 	local state = getVehicleState(vehicle)
-- 	if type(state) == "table" then
-- 		setElementData(vehicle,"technicalState",state)
-- 		return true
-- 	end
-- end
-- addEvent( "setVehicleState", true )
-- addEventHandler( "setVehicleState", getRootElement(  ), setVehicleState)

function setVehicleState()
	return false
end
addEvent( "setVehicleState", true )
addEventHandler( "setVehicleState", getRootElement(  ), setVehicleState)

function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    assert(getElementType(theElement) == "player" or getElementType(theElement) == "ped" or getElementType(theElement) == "object" or getElementType(theElement) == "vehicle", "Invalid element type @ getElementSpeed (player/ped/object/vehicle expected, got " .. getElementType(theElement) .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function doesVehicleHavePart(vehID, partID)
	local query = exports.titan_db:query("SELECT COUNT(ID) AS count FROM _items WHERE ownerType = ? AND owner = ? AND val1 = ?", 10, vehID, partID)
	if query[1].count > 0 then return true end
	return false
end

function setVehicleParts(vehID)
	local vehInfo = getVehInfo(vehID)
	if not vehInfo then return false end

	local types = 
	{
		FELGI = 1
	}

	if isElement(vehInfo.veh) then
		local query = exports.titan_db:query("SELECT ID, val1, val2, val3 FROM _items WHERE ownerType = ? AND owner = ?", 10, vehInfo.ID)
		if type(query) == "table" then
			for k, v in ipairs(query) do
				if v.val1 == types.FELGI then
					addVehicleUpgrade(vehInfo.veh, v.val2)
				end
			end
		end
	end
end

function addVehiclePart(vehID, partID)
	local vehInfo = getVehInfo(vehID)
	if not vehInfo then return false end
	return addVehicleUpgrade(vehInfo.veh, partID)
end

function removeVehiclePart(vehID, partID)
	local vehInfo = getVehInfo(vehID)
	if not vehInfo then return false end
	return removeVehicleUpgrade(vehInfo.veh, partID)
end