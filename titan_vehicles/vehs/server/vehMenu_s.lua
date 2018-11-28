----------------------------------------------------
-- CloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: value
-- Stworzono:   2016-07-28 15:48:22
-- Ostatnio zmodyfikowano: xxxx-xx-xx hh:mm:ss
----------------------------------------------------

local boats ={472, 473, 493, 595, 484, 430, 453, 452, 446, 454}
local trains={590, 538, 570, 569, 537, 449}
local bikes={509, 481, 510}
local motorbikes = {448, 461, 462, 463, 468, 521, 522, 581, 586, 523, 471}
local special = {441, 464, 594, 501, 465, 564, 606, 607, 610, 584, 611, 608, 435, 450, 591, 571, 539}
local airplanes = {592, 577, 511, 512, 593, 520, 553, 476, 519, 460, 513}
local helicopters = {548, 425, 417, 487, 488, 497, 563, 447, 469}

function vehmenuToggleLock(veh, player)
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
        if(not doesPlayerHaveDrivePerm(player, vehInfo.ID)) then
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
                setElementFrozen(player, false)
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
        else
            if isPedInVehicle(player) and getVehicleController(veh) ~= player then return exports.titan_noti:showBox(player, "Nie możesz otwierać pojazdu jako pasażer.") end
            vehInfo.locked = 1
            setVehicleLocked(veh, true)
            exports.titan_db:query_free("UPDATE _vehicles SET locked = '1' WHERE ID = ?", vehInfo.ID)
            exports.titan_noti:showBox(player, string.format("%s pojazd. (%s)", getElementData(player, "sex") == 1 and "Zamknąłeś" or "Zamknęłaś", getVehicleNameFromModel(getElementModel(vehInfo.veh))))
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
        end
end