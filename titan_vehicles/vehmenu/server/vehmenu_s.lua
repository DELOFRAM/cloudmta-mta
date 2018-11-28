----------------------------------------------------
-- CloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Value
-- Stworzono:   2016-07-28 18:14:22
-- Ostatnio zmodyfikowano: 2016-xx-xx xx:xx:xx
----------------------------------------------------

local boats ={472, 473, 493, 595, 484, 430, 453, 452, 446, 454}
local trains={590, 538, 570, 569, 537, 449}
local bikes={509, 481, 510}
local motorbikes = {448, 461, 462, 463, 468, 521, 522, 581, 586, 523, 471}
local special = {441, 464, 594, 501, 465, 564, 606, 607, 610, 584, 611, 608, 435, 450, 591, 571, 539}
local airplanes = {592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513}
local helicopters = {548, 425, 417, 487, 488, 497, 563, 447, 469}

local extras = {
	[555] = {0, 0, 1, 1},
	[439] = {1,1, 2, 2},
}

function vehSelect(player, veh, selected)
	local vehID = getElementData(veh, "vehID")
	if selected == "doors" then  -- Drzwi
		exports.titan_vehicles:vehmenuToggleLock(veh, player)
	elseif selected == "hood" then -- Maska
		if(not isElement(veh) or not exports.titan_vehicles:isVeh(veh)) then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnego pojazdu w pobliżu.")
			return
		end
		local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
			return
		end
		if(not exports.titan_vehicles:doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		local hoodState = getVehicleDoorOpenRatio(veh, 0)
		if(hoodState ~= 0) then
			setVehicleDoorOpenRatio(veh, 0, 0, 300)
		else
			setVehicleDoorOpenRatio(veh, 0, 1, 300)
		end
	elseif selected == "windows" then -- Szyby
		if not exports.titan_login:isLogged(player) then return end
		if exports.titan_bw:doesPlayerHaveBW(player) then return end
		if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Musisz być w pojeździe aby otwierać okna!") end
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
	
		exports.titan_chats:sendPlayerLocalMeRadius(player, getElementData(getPedOccupiedVehicle(player), "openWindows") == false and "otwiera okna w pojeździe." or "zamyka okna w pojeździe.", 10.0)
		setElementData(getPedOccupiedVehicle(player), "openWindows", not getElementData(getPedOccupiedVehicle(player), "openWindows"))
	elseif selected == "trunk" then -- Bagażnik
		if (getElementModel(veh) == 505) then
			exports.titan_noti:showBox(player, "Ten pojazd nie ma bagażnika.")
			return
		end
		if(not exports.titan_vehicles:doesPlayerHaveDrivePerm(player, vehID)) then
			exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			return
		end
		local trunkState = getVehicleDoorOpenRatio(veh, 1)
		if(trunkState ~= 0) then
			setVehicleDoorOpenRatio(veh, 1, 0, 300)
		else
			setVehicleDoorOpenRatio(veh, 1, 1, 300)
		end
	elseif selected == "audio" then -- Audio
        if(not isElement(veh)) then
            exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.")
            return
        end
        local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
        if(not vehInfo) then
            exports.titan_noti:showBox(player, "Nie można znaleźć informacji o pojeździe.")
            return
        end
        if(not exports.titan_vehicles:doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
            exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
            return
        end
        if not getElementData(veh, "carAudio") then
            if getElementData(veh, "carAudioOn") then removeElementData(veh, "carAudioOn") end
            return exports.titan_noti:showBox(player, "W napędzie nie ma płyty.")
        else
            if getElementData(veh, "carAudioOn") then
                removeElementData(veh, "carAudioOn")
                local occupants = getVehicleOccupants(veh)
                for seat, player in pairs(occupants) do
                    triggerClientEvent(player, "soundPlay.carAudioOff", player)
                end
                triggerClientEvent("soundPlay.carAudioOffTerrain", player, veh)
                return exports.titan_noti:showBox(player, "Audio zostało wyłączone.")
            else
               setElementData(veh, "carAudioOn", true)
                local occupants = getVehicleOccupants(veh)
                for seat, player in pairs(occupants) do
                    triggerClientEvent(player, "soundPlay.carAudioOn", player, getElementData(veh, "carAudio"))
                end
                triggerClientEvent("soundPlay.carAudioOnTerrain", player, veh, getElementData(veh, "carAudio"))
                return exports.titan_noti:showBox(player, "Audio zostało włączone.")
            end
        end
        return
	elseif selected == "plachta" then -- Plandeka
		if(not exports.titan_vehicles:doesPlayerHaveDrivePerm(player, vehID)) then
			 exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			 return
		end
		local plachta = getElementData(veh, "plachta") or false
		if plachta then
			triggerClientEvent("togglePlachta", source, veh, false)
			exports.titan_noti:showBox(player, "Ściągasz płachtę z pojazdu")
		else
			triggerClientEvent("togglePlachta", source, veh, true)
			exports.titan_noti:showBox(player, "Zakładasz płachtę na pojazd")
		end
		--triggerClientEvent("togglePlachta", source, veh)
	elseif selected == "roof" then -- Dach
		if(not exports.titan_vehicles:doesPlayerHaveDrivePerm(player, vehID)) then
			 exports.titan_noti:showBox(player, "Nie posiadasz kluczyków do tego pojazdu.")
			 return
		end
		local var1, var2 = getVehicleVariant(veh)
		if var1 == extras[getElementModel(veh)][3] and var2 == extras[getElementModel(veh)][4] then
			setVehicleVariant(veh, extras[getElementModel(veh)][1], extras[getElementModel(veh)][2])
			exports.titan_noti:showBox(player, "Zakładasz dach w pojeździe.")
		else
			setVehicleVariant(veh, extras[getElementModel(veh)][3], extras[getElementModel(veh)][4])
			exports.titan_noti:showBox(player, "Ściągasz dach w pojeździe.")
		end
	end
end
addEvent("vehSelect", true)
addEventHandler("vehSelect", getRootElement(), vehSelect)

function vehlock(veh)
	local vehID = getElementData(veh, "vehID")
	local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
	if isVehicleLocked(veh) then
		triggerClientEvent(source, "changelock", source, 1)
	else
		triggerClientEvent(source, "changelock", source, 0)
	end
	
end
addEvent("vehlock", true)
addEventHandler("vehlock", getRootElement(), vehlock)