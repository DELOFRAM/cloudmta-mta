----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

functions = {}
mechanics = {}
vehicles = {}

function doesPlayerDoingRepair(player)
	if type(mechanics[player]) == "table" then return true end
	return false
end

function createRepairGUI(player, target, price)
	triggerClientEvent(player, "functions.mechanicEvent", player, target, price)
end

function functions.cmdNapraw(player, command, playerID, price)
	if not exports.titan_login:isLogged(player) then return end
	if getElementData(player, "bwTime") then return end
	if not tonumber(playerID) or not tonumber(price) then return exports.titan_noti:showBox(player, "TIP: /naprawa [ID gracza] [cena]") end
	price = tonumber(price)
	playerID = tonumber(playerID)
	local target = exports.titan_login:getPlayerByID(tonumber(playerID))
	if getElementData(target, "bwTime") then return exports.titan_noti:showBox(player, "Gracz któremu chcesz oferować naprawę ma BW.") end
	if not isElement(target) then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest On zalogowany.") end
	if player == target then return exports.titan_noti:showBox(player, "Nie możesz zaoferować naprawy samemu sobie.") end
	if type(mechanics[player]) == "table" then return exports.titan_noti:showBox(player, "Prowadzisz już inną naprawę.") end

	local playerVehicle = getPedOccupiedVehicle(target)
	if not isElement(playerVehicle) then return exports.titan_noti:showBox(player, "Gracz musi siedzieć w pojeździe.") end
	local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
	if not vehInfo then return exports.titan_noti:showBox(player, "Tego pojazdu nie znaleziono w systemie, nie można go naprawić.") end

	triggerClientEvent(player, "functions.mechanicEvent", player, target, price)	
end
--addCommandHandler("naprawa", functions.cmdNapraw, false, false)

function functions.clientEvent(target, component, price)
	if not isElement(target) then return exports.titan_noti:showBox(source, "Nie znaleziono gracza.") end
	if type(mechanics[source]) == "table" then return exports.titan_noti:showBox(source, "Prowadzisz już inną naprawę.") end

	if type(exports.titan_items:getPlayerVehiclePart(target, component)) ~= "table" then
		return exports.titan_noti:showBox(source, "Gracz nie posiada tego komponentu w ekwipunku.")
	end

	exports.titan_offers:createRepairOffer(source, target, component, price)
end
addEvent("functions.clientEvent", true)
addEventHandler("functions.clientEvent", root, functions.clientEvent)

function startRepair(mechanic, target, component, price)
	if not isElement(mechanic) then return exports.titan_noti:showBox(target, "Mechanika nie ma na serwerze.") end
	if not isElement(target) then return exports.titan_noti:showBox(mechanic, "Nie znaleziono gracza.") end
	local playerVehicle = getPedOccupiedVehicle(target)
	if not isElement(playerVehicle) then exports.titan_noti:showBox(target, "Naprawa przerwana.") return exports.titan_noti:showBox(mechanic, "Gracz musi siedzieć w pojeździe.") end
	local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
	if not vehInfo then exports.titan_noti:showBox(target, "Naprawa przerwana.") return exports.titan_noti:showBox(mechanic, "Tego pojazdu nie znaleziono w systemie, nie można go naprawić.") end
	if type(mechanics[mechanic]) == "table" then exports.titan_noti:showBox(target, "Naprawa przerwana.") return exports.titan_noti:showBox(mechanic, "Prowadzisz już inną naprawę.") end

	if type(vehicles[playerVehicle]) == "table" then
		for k, v in ipairs(vehicles[playerVehicle]) do
			if v == component then
				exports.titan_noti:showBox(target, "Naprawa przerwana.")
				exports.titan_noti:showBox(mechanic, "Ta część jest już naprawiana przez kogoś innego.")
				return
			end
		end
	end

	mechanics[mechanic] = 
	{
		playerVehicle = playerVehicle,
		playerTarget = target,
		vehicleComponent = component,
		timeLeft = 15,
		fullTime = 15,
		price = price
	}
	if type(vehicles[playerVehicle]) ~= "table" then vehicles[playerVehicle] = {} end
	table.insert(vehicles[playerVehicle], component)
	mechanics[mechanic].repairTimer = setTimer(functions.repairFunction, 1000, 0, mechanic)
	--outputChatBox("DEBUG: Rozpoczęto naprawę...")
	exports.titan_noti:showBox(mechanic, "Rozpoczęto naprawę części...")
	exports.titan_noti:showBox(target, "Naprawa została rozpoczęta. Czekaj cierpliwie na koniec naprawy. Aby naprawa była możliwa, musisz wyłaczyć silnik.")
	triggerClientEvent(mechanic, "hud:setStatus", mechanic, true)
	triggerClientEvent(mechanic, "hud:setStatusState", mechanic, 0)
end

function functions.repairFunction(mechanic)
	local repairData = mechanics[mechanic]
	if not repairData then
		if isTimer(sourceTimer) then
			killTimer(sourceTimer)
			return
		end
	end
	if not isElement(mechanic) then
		if isElement(repairData.playerTarget) then
			exports.titan_noti:showBox(repairData.playerTarget, "Mechanik wyszedł z gry. Naprawa została anulowana. Kwota została oddana.")
		end
		if isTimer(repairData.repairTimer) then killTimer(repairData.repairTimer) end
		if type(vehicles[repairData.playerVehicle]) == "table" then
			if #vehicles[repairData.playerVehicle] == 1 then vehicles[repairData.playerVehicle] = nil
			else
				for k, v in ipairs(vehicles[repairData.playerVehicle]) do
					if v == repairData.vehicleComponent then
						table.remove(vehicles[repairData.playerVehicle], k)
						break
					end
				end
			end
		end
		mechanics[mechanic] = nil
		return
	end
	if not isElement(repairData.playerVehicle) then
		if isElement(repairData.playerTarget) then
			exports.titan_noti:showBox(repairData.playerTarget, "Nie znaleziono pojazdu. Naprawa została anulowana. Kwota została oddana.")
		end
		exports.titan_noti:showBox(mechanic, "Nie znaleziono pojazdu. Naprawa została anulowana.")
		if isTimer(repairData.repairTimer) then killTimer(repairData.repairTimer) end
		if type(vehicles[repairData.playerVehicle]) == "table" then
			if #vehicles[repairData.playerVehicle] == 1 then vehicles[repairData.playerVehicle] = nil
			else
				for k, v in ipairs(vehicles[repairData.playerVehicle]) do
					if v == repairData.vehicleComponent then
						table.remove(vehicles[repairData.playerVehicle], k)
						break
					end
				end
			end
		end
		mechanics[mechanic] = nil
		return
	end
	if not repairData.playerVehicle:getData("engineState") then
		local distance = getDistanceBetweenPoints2D(mechanic:getPosition(), repairData.playerVehicle:getPosition())
		if distance <= 5.0 then
			mechanics[mechanic].timeLeft = mechanics[mechanic].timeLeft - 1
			local time = mechanics[mechanic].fullTime - mechanics[mechanic].timeLeft

			triggerClientEvent(mechanic, "hud:setStatusState", mechanic, time / mechanics[mechanic].fullTime)
			
			if mechanics[mechanic].timeLeft <= 0 then
				-- POCZĄTEK SPRAWDZANIA
				local playerDuty = exports.titan_orgs:getPlayerDuty(mechanic)
				if not playerDuty or not exports.titan_orgs:doesGroupHavePerm(playerDuty, "vehfix") or not exports.titan_orgs:doesPlayerHavePerm(mechanic, playerDuty, "vehfix") then
					exports.titan_noti:showBox(mechanic, "Nie jesteś na duty poprawnej grupy. Naprawa anulowana.")
					exports.titan_noti:showBox(repairData.playerTarget, "Mechanik nie był na duty poprawnej grupy. Naprawa została anulowana. Kwota nie została pobrana.")
					triggerClientEvent(mechanic, "hud:setStatus", mechanic, false)
					triggerClientEvent(mechanic, "hud:setStatusState", mechanic, 0)
					if isTimer(repairData.repairTimer) then killTimer(repairData.repairTimer) end
					if type(vehicles[repairData.playerVehicle]) == "table" then
						if #vehicles[repairData.playerVehicle] == 1 then vehicles[repairData.playerVehicle] = nil
						else
							for k, v in ipairs(vehicles[repairData.playerVehicle]) do
								if v == repairData.vehicleComponent then
									table.remove(vehicles[repairData.playerVehicle], k)
									break
								end
							end
						end
					end
					mechanics[mechanic] = nil
					return
				end

				if exports.titan_cash:getPlayerCash(repairData.playerTarget) < repairData.price then
					exports.titan_noti:showBox(mechanic, "Gracz nie miał tyle pieniędzy przy sobie. Naprawa została anulowana.")
					exports.titan_noti:showBox(repairData.playerTarget, "Nie posiadasz tyle pieniędzy przy sobie. Naprawa została anulowana.")
					triggerClientEvent(mechanic, "hud:setStatus", mechanic, false)
					triggerClientEvent(mechanic, "hud:setStatusState", mechanic, 0)
					if isTimer(repairData.repairTimer) then killTimer(repairData.repairTimer) end
					if type(vehicles[repairData.playerVehicle]) == "table" then
						if #vehicles[repairData.playerVehicle] == 1 then vehicles[repairData.playerVehicle] = nil
						else
							for k, v in ipairs(vehicles[repairData.playerVehicle]) do
								if v == repairData.vehicleComponent then
									table.remove(vehicles[repairData.playerVehicle], k)
									break
								end
							end
						end
					end
					mechanics[mechanic] = nil
					return
				end

				local itemInfo = exports.titan_items:getPlayerVehiclePart(repairData.playerTarget, repairData.vehicleComponent)
				if not itemInfo then
					exports.titan_noti:showBox(mechanic, "Gracz nie posiada przy sobie naprawianego komponentu. Naprawa została anulowana.")
					exports.titan_noti:showBox(repairData.playerTarget, "Nie posiadasz naprawianego komponentu. Naprawa została anulowana.")
					triggerClientEvent(mechanic, "hud:setStatus", mechanic, false)
					triggerClientEvent(mechanic, "hud:setStatusState", mechanic, 0)
					if isTimer(repairData.repairTimer) then killTimer(repairData.repairTimer) end
					if type(vehicles[repairData.playerVehicle]) == "table" then
						if #vehicles[repairData.playerVehicle] == 1 then vehicles[repairData.playerVehicle] = nil
						else
							for k, v in ipairs(vehicles[repairData.playerVehicle]) do
								if v == repairData.vehicleComponent then
									table.remove(vehicles[repairData.playerVehicle], k)
									break
								end
							end
						end
					end
					mechanics[mechanic] = nil
					return
				end
				-- KONIEC SPRAWDZANIA

				if repairData.vehicleComponent == "wheel_lp" then setVehicleWheelStates(repairData.playerVehicle, 0, -1, -1, -1)
				elseif repairData.vehicleComponent == "wheel_rp" then setVehicleWheelStates(repairData.playerVehicle, -1, -1, 0, -1)
				elseif repairData.vehicleComponent == "wheel_lt" then setVehicleWheelStates(repairData.playerVehicle, -1, 0, -1, -1)
				elseif repairData.vehicleComponent == "wheel_rt" then setVehicleWheelStates(repairData.playerVehicle, -1, -1, -1, 0)
				elseif repairData.vehicleComponent == "door_lp" then setVehicleDoorState(repairData.playerVehicle, 2, 0)
				elseif repairData.vehicleComponent == "door_rp" then setVehicleDoorState(repairData.playerVehicle, 3, 0)
				elseif repairData.vehicleComponent == "door_lt" then setVehicleDoorState(repairData.playerVehicle, 4, 0)
				elseif repairData.vehicleComponent == "door_rt" then setVehicleDoorState(repairData.playerVehicle, 5, 0)
				elseif repairData.vehicleComponent == "mask" then setVehicleDoorState(repairData.playerVehicle, 0, 0)
				elseif repairData.vehicleComponent == "trunk" then setVehicleDoorState(repairData.playerVehicle, 1, 0)
				elseif repairData.vehicleComponent == "panel_lp" then setVehiclePanelState(repairData.playerVehicle, 0, 0)
				elseif repairData.vehicleComponent == "panel_rp" then setVehiclePanelState(repairData.playerVehicle, 1, 0)
				elseif repairData.vehicleComponent == "panel_lt" then setVehiclePanelState(repairData.playerVehicle, 2, 0)
				elseif repairData.vehicleComponent == "panel_rt" then setVehiclePanelState(repairData.playerVehicle, 3, 0)
				elseif repairData.vehicleComponent == "windscreen" then setVehiclePanelState(repairData.playerVehicle, 4, 0)
				elseif repairData.vehicleComponent == "bumper_p" then setVehiclePanelState(repairData.playerVehicle, 5, 0)
				elseif repairData.vehicleComponent == "bumper_t" then setVehiclePanelState(repairData.playerVehicle, 6, 0)
				elseif repairData.vehicleComponent == "light_lp" then setVehicleLightState(repairData.playerVehicle, 0, 0)
				elseif repairData.vehicleComponent == "light_rp" then setVehicleLightState(repairData.playerVehicle, 1, 0)
				elseif repairData.vehicleComponent == "light_lt" then setVehicleLightState(repairData.playerVehicle, 2, 0)
				elseif repairData.vehicleComponent == "light_rt" then setVehicleLightState(repairData.playerVehicle, 3, 0)
				elseif repairData.vehicleComponent == "engine" then setElementHealth(repairData.playerVehicle, 1000.0) exports.titan_vehicles:fixOnlyBroken(repairData.playerVehicle:getData("vehID"))
				end
				exports.titan_vehicles:saveVeh(repairData.playerVehicle:getData("vehID"))
				exports.titan_noti:showBox(mechanic, "Naprawa została zakończona.")
				exports.titan_noti:showBox(repairData.playerTarget, "Naprawa została zakończona.")

				if exports.titan_cash:takePlayerCash(repairData.playerTarget, repairData.price) then
					local groupInfo = exports.titan_orgs:getGroupInfo(playerDuty)
					if groupInfo then
						local tax = exports.titan_orgs:getGovTax("taxVehRepair")
						if not tax then tax = 0 end
						local taxPrice = math.ceil(repairData.price * (tax / 100))
						if taxPrice < 0 then taxPrice = 0 end
						exports.titan_orgs:giveGroupMoney(groupInfo.ID, repairData.price - taxPrice, tax, string.format("%s naprawił pojazd graczowi %s.", exports.titan_chats:getPlayerICName(mechanic), exports.titan_chats:getPlayerICName(repairData.playerTarget)))
						if taxPrice > 0 then
							exports.titan_orgs:giveGovermentMoney(taxPrice, string.format("Podatek z naprawy pojazdu od grupy %s.", groupInfo.name))
						end
					end
				end
				exports.titan_items:removeItem(itemInfo.ID, true)

				triggerClientEvent(mechanic, "hud:setStatus", mechanic, false)
				triggerClientEvent(mechanic, "hud:setStatusState", mechanic, 0)
				if isTimer(repairData.repairTimer) then killTimer(repairData.repairTimer) end
				if type(vehicles[repairData.playerVehicle]) == "table" then
					if #vehicles[repairData.playerVehicle] == 1 then vehicles[repairData.playerVehicle] = nil
					else
						for k, v in ipairs(vehicles[repairData.playerVehicle]) do
							if v == repairData.vehicleComponent then
								table.remove(vehicles[repairData.playerVehicle], k)
								break
							end
						end
					end
				end
				mechanics[mechanic] = nil
				return
			end
		end
	end
end