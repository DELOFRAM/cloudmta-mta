------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-06 14:55:57

function cmdBlokada(player)
	if exports.titan_login:isLogged(player) then
		

		local playerDuty = getPlayerDuty(player)
		if not playerDuty or not exports.titan_orgs:isGroup(playerDuty) then
			exports.titan_noti:showBox(player, "Nie jesteś na służbie żadnej grupy.")
			return
		end

		if not doesGroupHavePerm(playerDuty, "vehblock") then
			exports.titan_noti:showBox(player, "Grupa, na której służbie jesteś nie posiada dostępu do zakładania blokad.")
			return
		end

		if not doesPlayerHavePerm(player, playerDuty, "vehblock") then
			exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do do zakładania blokad.")
			return
		end

		local vehs = exports.titan_vehicles:getVehiclesOppositeToYouTireBlock(player)
		if #vehs <= 0 then
			exports.titan_noti:showBox(player, "W pobliżu Ciebie nie znaleziono żadnych pojazdów.")
			return
		end
		triggerClientEvent(player, "tireBlockGUICreate", player, vehs)
	end
end
addCommandHandler("blokuj", cmdBlokada, false, false)

function changeTireBlockState(vehElement)
	if isElement(vehElement) and exports.titan_vehicles:isVeh(vehElement) then
		local vehInfo, index = exports.titan_vehicles:getVehInfo(getElementData(vehElement, "vehID"))
		if not vehInfo then return end

		if not exports.titan_misc:isVehicleEmpty(vehInfo.veh) then
             exports.titan_noti:showBox(source, "Ktoś siedzi w pojeździe.")
            return
        end

		if vehInfo.tireBlock == 1 then
			exports.titan_vehicles:changeVehicleData(vehInfo.ID, "tireBlock", 0)
			exports.titan_noti:showBox(source, "Blokada na pojazd została zdjęta.")
			--exports.titan_chats:sendPlayerLocalMeRadius(source, string.format("ściągnał blokadę z koła pojazdu %s.", getVehicleNameFromModel(getElementModel(vehElement))), 10.0)
			local plec = "ściągnął"
			if getElementData(source, "sex") == 2 then
			plec = "ściągneła"
			end
			exports.titan_chats:sendPlayerLocalMeRadius(source, ""..plec.." blokadę z koła pojazdu ".. getVehicleNameFromModel(getElementModel(vehElement))..".", 10.0)
			return
		else
			exports.titan_vehicles:changeVehicleData(vehInfo.ID, "tireBlock", 1)
			exports.titan_vehicles:changeVehicleData(vehInfo.ID, "handbrake", 1)
			setElementFrozen(vehInfo.veh, true)
			exports.titan_vehicles:parkVehicle(vehElement)
			exports.titan_noti:showBox(source, "Blokada na pojazd została założona.")
			--exports.titan_chats:sendPlayerLocalMeRadius(source, string.format("założył blokadę na koło pojazdu %s.", getVehicleNameFromModel(getElementModel(vehElement))), 10.0)
			local plec = "założył"
			if getElementData(source, "sex") == 2 then
			plec = "założyła"
			end
			exports.titan_chats:sendPlayerLocalMeRadius(source, ""..plec.." blokadę na koło pojazdu ".. getVehicleNameFromModel(getElementModel(vehElement))..".", 10.0)
			exports.titan_vehicles:turnOffVeh(index)
			return
		end
	end
end
addEvent("changeTireBlockState", true)
addEventHandler("changeTireBlockState", root, changeTireBlockState)