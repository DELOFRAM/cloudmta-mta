----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmdSilnik(player)
	if(not exports.titan_login:isLogged(player)) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if(not isPedInVehicle(player)) then return end
	local veh = getPedOccupiedVehicle(player)
	if(getVehicleController(veh) ~= player) then return end
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	
	for k,v in pairs(bikes) do
		if v == getElementModel(veh) then return end
	end
	
	local vUID = getElementData(veh, "vehID")
	if(not tonumber(vUID)) then return end
	local vehInfo = getVehInfo(vUID)
	if(not vehInfo) then return end

	if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
		exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
		return
	end

	if(tonumber(getElementData(veh, "repairedTime"))) then
		exports.titan_noti:showBox(player, "Pojazd jest w tej chwili naprawiany.")
		return
	end

	if(vehInfo.fuel <= 0) then
		exports.titan_noti:showBox(player, "W baku nie ma już paliwa.")
		return
	end

	--Blokada na koło:
	if vehInfo.tireBlock == 1 then
		exports.titan_noti:showBox(player, "Pojazd ma założona blokadę na koło.")
		cancelEvent()
		return
	end

	if(vehInfo.engineState) then
		vehInfo.engineState = false
		setElementData(vehInfo.veh, "engineState", false)
		setVehicleEngineState(vehInfo.veh, false)
		--exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("zgasił silnik pojazdu %s.", vehInfo.name), 10.0)
	else
		if(vehInfo.broken) then
			exports.titan_noti:showBox(player, "Samochód jest zniszczony i nie nadaje się do użytku.")
			vehInfo.engineState = false
			setElementData(vehInfo.veh, "engineState", false)
			setVehicleEngineState(vehInfo.veh, false)
			return
		end
		vehInfo.engineState = true
		setElementData(vehInfo.veh, "engineState", true)
		setTimer(setVehicleEngineState,578,1,vehInfo.veh,true)
		triggerClientEvent(root, "onPlayerRequestStartEngine", player, vehInfo.veh)
		--exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("odpalił silnik pojazdu %s.", vehInfo.name), 10.0)
	end
end
addCommandHandler("silnik", cmdSilnik, false, false)
addEvent("cmdSilnik", true)
addEventHandler("cmdSilnik", root, cmdSilnik)

function cmdLights(player)
	if(not exports.titan_login:isLogged(player)) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if(not isPedInVehicle(player)) then return end
	local veh = getPedOccupiedVehicle(player)
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	
	for k,v in pairs(bikes) do
		if v == getElementModel(veh) then return end -- rowery
	end
	
	for k,v in pairs(airplanes) do
		if v == getElementModel(veh) then return end -- samoloty
	end
	
	for k,v in pairs(helicopters) do
		if v == getElementModel(veh) then return end -- helikoptry
	end
	
	for k,v in pairs(special) do
		if v == getElementModel(veh) and v ~= 531 then return end -- inne (kart, bagażowe, vortex itd)
	end
	
	for k,v in pairs(boats) do
		if v == getElementModel(veh) then return end -- łodzie
	end
	
	if(getVehicleOccupant(veh) ~= player) then return end
	local vUID = getElementData(veh, "vehID")
	if(not tonumber(vUID)) then return end
	local vehInfo = getVehInfo(vUID)
	if(not vehInfo) then return end

	if(vehInfo.lightState) then
		vehInfo.lightState = false
		setElementData(vehInfo.veh, "lightState", false)
		setVehicleOverrideLights(vehInfo.veh, 1)
	else
		vehInfo.lightState = true
		setElementData(vehInfo.veh, "lightState", true)
		setVehicleOverrideLights(vehInfo.veh, 2)
	end
end
addCommandHandler("swiatla", cmdLights, false, false)

function cmdReczny(player)
	if not exports.titan_login:isLogged(player) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if not isPedInVehicle(player) then return end
	local veh = getPedOccupiedVehicle(player)
	if getVehicleOccupant(veh) ~= player then return exports.titan_noti:showBox(player, "Musisz siedzieć na miejscu kierowcy, aby użyć ręcznego.") end
	local vehInfo = getVehInfo(veh:getData("vehID"))
	if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie ma w bazie danych. Co Ty w nim robisz?") end

	if vehInfo.handbrake == 1 then
		vehInfo.handbrake = 0
		veh:setData("handbrake", false)
		toggleControl(player, "handbrake", true)
		setControlState(player, "handbrake", false)
		triggerClientEvent("soundPlay.handbrakeOff", player, veh)
		exports.titan_db:query_free("UPDATE _vehicles SET handbrake = '0' WHERE ID = ?", vehInfo.ID)
	else
		vehInfo.handbrake = 1
		veh:setData("handbrake", true)
		toggleControl(player, "handbrake", false)
		setControlState(player, "handbrake", true)
		--triggerClientEvent(player, "toggleHandbrakeMode", player, true)
		triggerClientEvent("soundPlay.handbrakeOn", player, veh)
		exports.titan_db:query_free("UPDATE _vehicles SET handbrake = '1' WHERE ID = ?", vehInfo.ID)
	end
end
--addCommandHandler("reczny", cmdReczny, false, false)

function cmdEmer(player)
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if(isPedInVehicle(player)) then
		setElementData(getPedOccupiedVehicle(player), "vLightsOn", not getElementData(getPedOccupiedVehicle(player), "vLightsOn"))
		if(not getElementData(getPedOccupiedVehicle(player), "vLightsOn")) then
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
				end, 150, 1, getPedOccupiedVehicle(player))
		end
	end
end
--addCommandHandler("emer", cmdEmer, false, false)

function cmdPojazd(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	local arg = {...}
	local legend
	if not isPedInVehicle(player) then
		legend = "z(amknij), spawn, maska, bagaznik"
	else
		legend = "info, tuning, zaparkuj, flash, kogut, gps, maska, bagaznik"
	end
	local option = string.lower(tostring(arg[1]))
	if(option == "spawn") then
		if getElementData(player, "exitingVehicle") then return end
		if getElementData(player, "enteringVehicle") then return end
		local vID = arg[2]
		if(not tonumber(arg[2])) then
			exports.titan_noti:showBox(player, "TIP: /v spawn [ID pojazdu]")
			return
		end
		vID = tonumber(vID)

		local vehInfo = getVehInfo(vID)
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Taki pojazd nie istnieje.")
			return
		end

		if(not isPlayerVeh(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Ten pojazd nie należy do Ciebie.")
			return
		end

		if vehInfo.tireBlock == 1 then
			exports.titan_noti:showBox(player, "Pojazd ma założona blokadę na koło.")
			return
		end
		if(vehInfo.spawned == 1) then
			if not isVehicleEmpty(vehInfo.veh) then return exports.titan_noti:showBox(player, "Pojazd nie jest pusty.") end
			if(uSVehicle(vehInfo.ID)) then
				exports.titan_noti:showBox(player, string.format("%s odspawnowany pomyślnie.", vehInfo.name))
				return
			end
			vehInfo.spawned = 0
		else
			if not localPlayer:getData("premium") and getPlayerSpawnedVehicleCount(player) >= 2 then
				return exports.titan_noti:showBox(player, "Nie możesz zespawnować więcej niż 2 pojazdy. Mając Konto Premium możesz zespawnować 4 pojazdy.")
			end
			if localPlayer:getData("premium") and getPlayerSpawnedVehicleCount(player) >= 4 then
				return exports.titan_noti:showBox(player, "Nie możesz zespawnować więcej niż 4 pojazdy.")
			end
			if(sVehicle(vehInfo.ID)) then	
				exports.titan_noti:showBox(player, string.format("%s zespawnowany pomyślnie.", vehInfo.name))
				return
			end
			vehInfo.spawned = 1
		end
	elseif(option == "zaparkuj") then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		if getElementData(player, "exitingVehicle") then return end
		if getElementData(player, "enteringVehicle") then return end
		local veh = getPedOccupiedVehicle(player)
		if(not isVeh(veh)) then return end
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if(not vehInfo) then return end
		if(not doesPlayerHaveVehAdminPerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz wymaganych uprawnień do użycia tej komendy.")
			return
		end

		if vehInfo.tireBlock == 1 then
			exports.titan_noti:showBox(player, "Nie możesz przeparkować pojazdu z założona blokada na koło.")
			return
		end
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
		return
	elseif(option == "z" or option == "zamknij") then
		if getElementData(player, "exitingVehicle") then return end
		if getElementData(player, "enteringVehicle") then return end
		local veh = getClosestVehicle(player)
		if(not isElement(veh) or not isVeh(veh)) then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnego pojazdu w pobliżu.")
			return
		end
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end
		if not doesPlayerHaveDrivePerm(player, vehInfo.ID) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		
		--[[for k,v in pairs(special) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(bikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(motorbikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(boats) do
			if v == getElementModel(veh) then return end
		end]]--
		if(vehInfo.locked == 1) then
			if isPedInVehicle(player) and getVehicleController(veh) ~= player then return exports.titan_noti:showBox(player, "Nie możesz otwierać pojazdu jako pasażer.") end
			vehInfo.locked = 0
			setVehicleLocked(veh, false)
			exports.titan_db:query_free("UPDATE _vehicles SET locked = '0' WHERE ID = ?", vehInfo.ID)
			exports.titan_noti:showBox(player, string.format("%s pojazd. (%s)", getElementData(player, "sex") == 1 and "Otworzyłeś" or "Otworzyłaś", getVehicleNameFromModel(getElementModel(vehInfo.veh))))
			--exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("otworzył drzwi pojazdu %s.", vehInfo.name), 10.0)
			triggerClientEvent(root, "soundPlay.doors", player, vehInfo.veh, vehInfo.hasAlarm == 1 and true or false)
			if(vehInfo.hasAlarm == 1) and not isPedInVehicle(player) then
				setElementVelocity(player, 0, 0, 0)
				setElementFrozen(player, true)
				setPedAnimation(player, "CRIB", "CRIB_use_switch", 50, false, false, false, false)
				setPedAnimation(player, "CRIB", "CRIB_use_switch", 2950, false, false, false, false)
				setTimer(setElementFrozen, 3000, 1, player, false)
				setElementData(vehInfo.veh, "i:left", true)
				setElementData(vehInfo.veh, "i:right", true)
				setTimer(setElementData, 1000, 1, vehInfo.veh, "i:left", false)
				setTimer(setElementData, 1000, 1, vehInfo.veh, "i:right", false)
			elseif vehInfo.hasAlarm == 0 and not isPedInVehicle(player) then
				setElementVelocity(player, 0, 0, 0)
				setElementFrozen(player, true)
				setPedAnimation(player, "INT_HOUSE", "wash_up", 50, false, false, false, false)
				setPedAnimation(player, "INT_HOUSE", "wash_up", 2950, false, false, false, false)
				setTimer(setElementFrozen, 3000, 1, player, false)
			end
			return
		else
			if isPedInVehicle(player) and getVehicleController(veh) ~= player then return exports.titan_noti:showBox(player, "Nie możesz zamykać pojazdu jako pasażer.") end
			vehInfo.locked = 1
			setVehicleLocked(veh, true)
			exports.titan_db:query_free("UPDATE _vehicles SET locked = '1' WHERE ID = ?", vehInfo.ID)
			exports.titan_noti:showBox(player, string.format("%s pojazd. (%s)", getElementData(player, "sex") == 1 and "Zamknąłeś" or "Zamknęłaś", getVehicleNameFromModel(getElementModel(vehInfo.veh))))
			--exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("zamknął drzwi pojazdu %s.", vehInfo.name), 10.0)
			triggerClientEvent(root, "soundPlay.doors", player, vehInfo.veh, vehInfo.hasAlarm == 1 and true or false)
			if(vehInfo.hasAlarm == 1) and not isPedInVehicle(player) then
				setElementVelocity(player, 0, 0, 0)
				setElementFrozen(player, true)
				setPedAnimation(player, "CRIB", "CRIB_use_switch", 50, false, false, false, false)
				setPedAnimation(player, "CRIB", "CRIB_use_switch", 2950, false, false, false, false)
				setTimer(setElementFrozen, 3000, 1, player, false)
				setElementData(vehInfo.veh, "i:left", true)
				setElementData(vehInfo.veh, "i:right", true)
				setTimer(setElementData, 700, 1, vehInfo.veh, "i:left", false)
				setTimer(setElementData, 700, 1, vehInfo.veh, "i:right", false)
			elseif vehInfo.hasAlarm == 0 and not isPedInVehicle(player) then
				setElementVelocity(player, 0, 0, 0)
				setElementFrozen(player, true)
				setPedAnimation(player, "INT_HOUSE", "wash_up", 50, false, false, false, false)
				setPedAnimation(player, "INT_HOUSE", "wash_up", 2950, false, false, false, false)
				setTimer(setElementFrozen, 3000, 1, player, false)
			end
			return
		end
	elseif(option == "flash") then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		if getElementData(player, "exitingVehicle") then return end
		if getElementData(player, "enteringVehicle") then return end
		local veh = getPedOccupiedVehicle(player)
		if(not isElement(veh)) then 
			exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.")
			return
		end
		
		for k,v in pairs(special) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(bikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(motorbikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(boats) do
			if v == getElementModel(veh) then return end
		end
		
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end
		if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		if(vehInfo.flashType == 0) then
			exports.titan_noti:showBox(player, "Pojazd nie posiada zamontowanych świateł policyjnych.")
			return
		end

		local isVehHaveFlash = getElementData(veh, "flashType")
		if(tonumber(isVehHaveFlash)) then
			turnVehFlash(veh)
		else
			turnVehFlash(veh, true, vehInfo.flashType)
		end
		exports.titan_noti:showBox(player, "Pomyślnie zmieniłeś stan świateł.")
		return
	elseif(option == "kogut") then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		if getElementData(player, "exitingVehicle") then return end
		if getElementData(player, "enteringVehicle") then return end
		local veh = getPedOccupiedVehicle(player)
		if(not isElement(veh)) then
			exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.")
			return
		end

		for k,v in pairs(special) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(bikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(motorbikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(boats) do
			if v == getElementModel(veh) then return end
		end
		
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end

		if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end

		if(getElementData(veh, "doesKogutActive")) then
			setElementData(veh, "doesKogutActive", false)
			local kogutElement = getElementData(veh, "kogutElement")
			if(isElement(kogutElement)) then
				destroyElement(kogutElement)
			end
			exports.titan_noti:showBox(player, "Kogut został zdjęty.")
			return
		else
			if(not exports.titan_items:doesVehicleHasItemType(getElementData(veh, "vehID"), 20)) then
				exports.titan_noti:showBox(player, "W pojeździe nie znaleziono żadnego koguta.")
				return
			end
			triggerClientEvent(player, "checkPoliceKogutPosition", player)
			return
		end
	elseif option == "info" then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		local veh = getPedOccupiedVehicle(player)
		if isElement(veh) then
			if isVeh(veh) then
				local vUID = veh:getData("vehID")
				showVehInfo(player, vUID)
				return
			end
		end
	elseif option == "tuning" then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		local veh = getPedOccupiedVehicle(player)
		if isElement(veh) then
			if isVeh(veh) then
				local vUID = veh:getData("vehID")
				showVehTune(player, vUID)
				return
			end
		end
	elseif option == "gps" then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		local veh = getPedOccupiedVehicle(player)

		if veh:getData("hasGPS") then
			if veh:getData("hasGPSOn") then
				local blip = veh:getData("gpsBlip")
				if isElement(blip) then
					clearElementVisibleTo(blip)
					setElementVisibleTo(blip, root, false)
				end
				veh:setData("hasGPSOn", false)
				exports.titan_noti:showBox(player, "GPS został wyłączony.")
			else
				veh:setData("hasGPSOn", true)
				exports.titan_noti:showBox(player, "GPS został włączony.")
			end
			return
		else
			exports.titan_noti:showBox(player, "Ten pojazd nie posiada GPS.")
			return
		end
	elseif option == "radar" then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		if getElementData(player, "exitingVehicle") then return end
		if getElementData(player, "enteringVehicle") then return end
		local veh = getPedOccupiedVehicle(player)
		local vehInfo = getVehInfo(veh:getData("vehID"))
		if not vehInfo then return exports.titan_noti:showBox(player, "Ten pojazd nie istnieje w bazie danych.") end
		if not doesPlayerHaveDrivePerm(player, vehInfo.ID) then return exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.") end
		if vehInfo.ownerType ~= 2 then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do użycia tej komendy.") end
		local groupInfo = exports.titan_orgs:getGroupInfo(vehInfo.ownerID)
		if not groupInfo then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do użycia tej komendy.") end
		if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "dashcam") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do użycia tej komendy.") end

		if not veh:getData("dashcamActive") then
			veh:setData("dashcamActive", true)
			return exports.titan_noti:showBox(player, "Radar został włączony.")
		else
			veh:removeData("dashcamActive")
			return exports.titan_noti:showBox(player, "Radar został wyłączony.")
		end
		return
	elseif option == "maska" then
		local veh = getClosestVehicle(player)
		if(not isElement(veh) or not isVeh(veh)) then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnego pojazdu w pobliżu.")
			return
		end
		if not doesPlayerHaveDrivePerm(player, getElementData(veh, "vehID")) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		
		for k,v in pairs(special) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(bikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(motorbikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(boats) do
			if v == getElementModel(veh) then return end
		end
		
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if vehInfo.locked == 1 or not isPedInVehicle(player) then return end
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end
		if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		local hoodState = getVehicleDoorOpenRatio(veh, 0)
		if(hoodState ~= 0) then
			setVehicleDoorOpenRatio(veh, 0, 0, 300)
		else
			setVehicleDoorOpenRatio(veh, 0, 1, 300)
		end
		return
	elseif option == "bagaznik" then
		local veh = getClosestVehicle(player)
		if(not isElement(veh) or not isVeh(veh)) then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnego pojazdu w pobliżu.")
			return
		end
		if not doesPlayerHaveDrivePerm(player, getElementData(veh, "vehID")) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		
		for k,v in pairs(special) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(bikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(motorbikes) do
			if v == getElementModel(veh) then return end
		end
		
		for k,v in pairs(boats) do
			if v == getElementModel(veh) then return end
		end
		
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if vehInfo.locked == 1 or not isPedInVehicle(player) then return end
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end
		if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		local trunkState = getVehicleDoorOpenRatio(veh, 1)
		if(trunkState ~= 0) then
			setVehicleDoorOpenRatio(veh, 1, 0, 300)
		else
			setVehicleDoorOpenRatio(veh, 1, 1, 300)
		end
		return
	elseif option == "audio" then
		if not isPedInVehicle(player) then exports.titan_noti:showBox(player, "TIP: /v ["..legend.."]") return end
		local veh = getPedOccupiedVehicle(player)
		if(not isElement(veh)) then 
			exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.")
			return
		end
		local vehInfo = getVehInfo(getElementData(veh, "vehID"))
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end
		if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		if not veh:getData("carAudio") then
			if veh:getData("carAudioOn") then veh:removeData("carAudioOn") end
			return exports.titan_noti:showBox(player, "W napędzie nie ma płyty.")
		else
			if veh:getData("carAudioOn") then
				veh:removeData("carAudioOn")
				local occupants = getVehicleOccupants(veh)
				for seat, player in pairs(occupants) do
					triggerClientEvent(player, "soundPlay.carAudioOff", player)
				end
				triggerClientEvent("soundPlay.carAudioOffTerrain", player, veh)
				return exports.titan_noti:showBox(player, "Audio zostało wyłączone.")
			else
				veh:setData("carAudioOn", true)
				local occupants = getVehicleOccupants(veh)
				for seat, player in pairs(occupants) do
					triggerClientEvent(player, "soundPlay.carAudioOn", player, veh:getData("carAudio"))
				end
				triggerClientEvent("soundPlay.carAudioOnTerrain", player, veh, veh:getData("carAudio"))
				return exports.titan_noti:showBox(player, "Audio zostało włączone.")
			end
		end
		return
	else
		if getElementData(player, "itemsGUI") then return exports.titan_noti:showBox(player, "Nie możesz włączyć GUI pojazdów mając włączone GUI przedmiotów.") end
		if isElement(getElementData(player, "cuffedBy")) then return exports.titan_noti:showBox(player, "Nie możesz otwierać listy pojazdów gdy jesteś skuty.") end
		if not getElementData(player, "vehGUI") then
			local vehicles = getVehicleTable(1, getElementData(player, "charID"))
			if(not vehicles) then
				exports.titan_noti:showBox(player, "Nie posiadasz żadnych pojazdów.")
				return
			end
			triggerClientEvent(player, "createPlayerVehiclesGUI", player, vehicles, true)
		else
			triggerClientEvent(player, "createPlayerVehiclesGUI", player, vehicles, false)
		end
		return
	end
end
addCommandHandler("v", cmdPojazd, false, false)
addCommandHandler("pojazd", cmdPojazd, false, false)

function cmdPasy(player)
	if(not exports.titan_login:isLogged(player)) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if(not isPedInVehicle(player)) then return end
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	local vehicle = getPedOccupiedVehicle(player)

	local belts = getElementData(player, "belts")
	
	for k,v in pairs(special) do
		if v == getElementModel(vehicle) then return end
	end
	
	for k,v in pairs(bikes) do
		if v == getElementModel(vehicle) then return end
	end
	
	for k,v in pairs(motorbikes) do
		if v == getElementModel(vehicle) then return end
	end
	
	for k,v in pairs(boats) do
		if v == getElementModel(vehicle) then return end
	end
	
	if(belts) then
		setElementData(player, "belts", false)
		exports.titan_chats:sendPlayerLocalMeRadius(player, "odpina pasy.", 10.0)
	else
		setElementData(player, "belts", true)
		exports.titan_chats:sendPlayerLocalMeRadius(player, "zapina pasy.", 10.0)
	end
end
addCommandHandler("pasy", cmdPasy, false, false)

function cmdTankuj(player, command, fuel)
	--outputDebugString("dupa")
	local price = 3
	if not exports.titan_login:isLogged(player) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz tankować pojazdu siedząc w nim!") end
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	local sphere = createColSphere(player:getPosition(), 5.0)
	local objects = getElementsWithinColShape(sphere, "object")
	destroyElement(sphere)
	local isObject = false
	for k, v in ipairs(objects) do
		if v:getData("isObject") then
			if v:getInterior() == player:getInterior() and v:getDimension() == player:getDimension() then
				if v:getModel() == 1676 then isObject = true end
			end
		end
	end
	outputDebugString("test")
	if not isObject then return exports.titan_noti:showBox(player, "Nie znajdujesz się obok dystrybutora.") end
	local veh = getClosestVehicle(player, 5.0)
	if not veh then return exports.titan_noti:showBox(player, "Nie znaleziono żadnego pojazdu w pobliżu.") end
	for k,v in pairs(bikes) do
		if v == getElementModel(veh) then return exports.titan_noti:showBox(player, "Przepraszamy. Stacja nie przewiduje w swoich usługach tankowania rowerów.") end
	end
	if getVehicleEngineState(veh) then return exports.titan_noti:showBox(player, "Nie możesz tankować pojazdu, gdy silnik jest włączony!") end
	if not tonumber(fuel) then return exports.titan_noti:showBox(player, "TIP: /tankuj [ilość litrów]") end
	fuel = tonumber(fuel)
	if fuel <= 0 then return exports.titan_noti:showBox(player, "Podano złą ilość paliwa.") end
	local vehInfo = getVehInfo(veh:getData("vehID"))
	if not vehInfo then return exports.titan_noti:showBox(player, "Ten pojazd nie jest przypisany do systemu pojazdów.") end
	if math.floor(vehInfo.fuel) >= math.floor(vehInfo.maxfuel) then return exports.titan_noti:showBox(player, "Bak w pojeździe jest pełny.") end
	if math.floor(vehInfo.fuel + fuel) > math.floor(vehInfo.maxfuel) then return exports.titan_noti:showBox(player, string.format("W baku pojazdu zmieści się jescze maksymalnie %dL.", math.floor(vehInfo.maxfuel - vehInfo.fuel))) end
	price = price * fuel
	local money = exports.titan_cash:getPlayerCash(player)
	if money < price then return exports.titan_noti:showBox(player, "Nie posiadasz wystarczającej ilości gotówki.") end
	if exports.titan_cash:takePlayerCash(player, price) then
		local tax = exports.titan_orgs:getGovTax("taxFuel")
		if not tax then tax = 0 end
		local taxPrice = math.ceil(price * (tax / 100))
		if taxPrice < 0 then taxPrice = 0 end
		if taxPrice > 0 then
			exports.titan_orgs:giveGovermentMoney(taxPrice, "Podatek ze sprzedaży paliwa")
		end
	end
	exports.titan_noti:showBox(player, string.format("Pojazd został zatankowany.\nZa usługę zapłacono $%d.", price))
	local newFuel = vehInfo.fuel + fuel
	if newFuel > vehInfo.maxfuel then newFuel = vehInfo.maxfuel end
	changeVehicleData(vehInfo.ID, "fuel", newFuel)
	veh:setData("vehFuel", newFuel)
	exports.titan_chats:sendPlayerLocalDoRadius(player, string.format("Pojazd %s został zatankowany.", vehInfo.name), 10.0)
end
addCommandHandler("tankuj", cmdTankuj, false, false)

function cmdWepchnij(player, command, target, seat)
	if not exports.titan_login:isLogged(player) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.") end
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	local veh = getPedOccupiedVehicle(player)

	for k,v in pairs(special) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(bikes) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(motorbikes) do
		if v == getElementModel(veh) then return end
	end
	
	if getVehicleOccupant(veh) ~= player then return exports.titan_noti:showBox(player, "Musisz siedzieć na miejscu kierowcy, aby użyć tej komendy.") end
	if not tonumber(target) or not tonumber(seat) then return exports.titan_noti:showBox(player, "TIP: /wepchnij [id gracza] [miejsce (1-"..getVehicleMaxPassengers(veh)..")]") end
	target = tonumber(target)
	seat = tonumber(seat)
	target = exports.titan_login:getPlayerByID(target)
	if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
	if player == target then return exports.titan_noti:showBox(player, "Nie możesz wepchnąć samego siebie.") end
	if seat < 1 or seat > getVehicleMaxPassengers(veh) then return exports.titan_noti:showBox(player, "Podano nieprawidłowe miejsce pojazdu.") end
	if getDistanceBetweenPoints3D(player:getPosition(), target:getPosition()) > 5.0 then return exports.titan_noti:showBox(player, "Gracz nie jest obok Ciebie.") end
	if not exports.titan_bw:doesPlayerHaveBW(target) then return exports.titan_noti:showBox(player, "Gracz nie ma BW.") end
	if isPedInVehicle(target) then return exports.titan_noti:showBox(player, "Gracz jest w pojeździe.") end
	setPedAnimation(target, nil, nil)
	if warpPedIntoVehicle(target, veh, seat) then
		exports.titan_noti:showBox(player, "Gracz został wrzucony do pojazdu.")
		exports.titan_noti:showBox(target, string.format("Zostałeś wrzucony do pojazdu przez gracza %s.", exports.titan_chats:getPlayerICName(player)))
	else
		exports.titan_noti:showBox(player, "Wystąpił problem w momencie wrzucania grania do pojazdu.")
	end
end
addCommandHandler("wepchnij", cmdWepchnij, false, false)

function cmdWypchnij(player, command, target)
	if not exports.titan_login:isLogged(player) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.") end
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	local veh = getPedOccupiedVehicle(player)
	
	for k,v in pairs(special) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(bikes) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(motorbikes) do
		if v == getElementModel(veh) then return end
	end
	
	if getVehicleOccupant(veh) ~= player then return exports.titan_noti:showBox(player, "Musisz siedzieć na miejscu kierowcy, aby użyć tej komendy.") end
	if not tonumber(target) then return exports.titan_noti:showBox(player, "TIP: /wypchnij [id gracza]") end
	target = tonumber(target)
	target = exports.titan_login:getPlayerByID(target)
	if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
	if player == target then return exports.titan_noti:showBox(player, "Nie możesz wypchnąć samego siebie.") end
	if not isPedInVehicle(target) or getPedOccupiedVehicle(target) ~= veh then return exports.titan_noti:showBox(player, "Gracz nie jest w Twoim pojeździe.") end
	removePedFromVehicle(target)
	local x, y, z = exports.titan_misc:getXYZInFrontOfPlayer(veh, 1.5, true)
	setElementPosition(target, x, y, z)
	if exports.titan_bw:doesPlayerHaveBW(target) then
		setPedAnimation(target, "PED", "KO_shot_front", -1, false, true, false, true)
	end
	exports.titan_noti:showBox(player, "Gracz został wyrzucony z pojazdu.")
	exports.titan_noti:showBox(target, string.format("Zostałeś wyrzucony z pojazdu przez gracza %s.", exports.titan_chats:getPlayerICName(player)))
	setElementData(target, "belts", false)
end
addCommandHandler("wypchnij", cmdWypchnij, false, false)

function cmdOkna(player)
	if not exports.titan_login:isLogged(player) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if not isPedInVehicle(player) then return end
	--if getVehicleController(getPedOccupiedVehicle(player)) ~= player then return exports.titan_noti:showBox(player, "Tylko kierowca może otwierać okna w pojeździe!") end
	if getElementData(player, "exitingVehicle") then return end
	if getElementData(player, "enteringVehicle") then return end
	local veh = getPedOccupiedVehicle(player)
	
	for k,v in pairs(special) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(bikes) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(motorbikes) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(boats) do
		if v == getElementModel(veh) then return end
	end
	
	for k,v in pairs(airplanes) do
		if v == getElementModel(veh) then return end
	end
	
	exports.titan_chats:sendPlayerLocalMeRadius(player, getElementData(getPedOccupiedVehicle(player), "openWindows") == false and "otwiera szyby w pojeździe." or "zamyka szyby w pojeździe.", 10.0)
	setElementData(getPedOccupiedVehicle(player), "openWindows", not getElementData(getPedOccupiedVehicle(player), "openWindows"))
end
addCommandHandler("okno", cmdOkna, false, false)
addCommandHandler("okna", cmdOkna, false, false)
addCommandHandler("szyba", cmdOkna, false, false)
addCommandHandler("szyby", cmdOkna, false, false)
	

for _, v in pairs(getElementsByType("player")) do
bindKey(v, "p", "down", "pojazd")
end

addEventHandler("onPlayerJoin", root, function()
bindKey(source, "p", "down", "pojazd")
end)