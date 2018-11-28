----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:14
-- Ostatnio zmodyfikowano: 2016-01-09 15:44:20
----------------------------------------------------

function setPlayerBW(player, time, veh, seat)
	if(not isElement(player)) then return false end
	if(getElementData(player, "loggedIn") ~= 1) then return false end
	--if doesPlayerHaveBW(player) then return end
	if(not tonumber(time)) then return false end
	time = tonumber(time)
	if(time < 0 or time > 3600) then return false end
	local oldBWTime = getElementData(player, "bwTime")
	if(time == 0) then
		setElementData(player, "bwTime", false)
		triggerPlayerSpawn(player)
		toggleAllControls(player, true, true, false)
		toggleControl(player, "enter_passenger", true)
		return
	end

	if(not oldBWTime or oldBWTime <= 0) then
		exports.titan_items:disarmPlayer(player)
	end

	if getElementData(player,"hungryLevel") <= 0 then
		setElementData(player,"hungryLevel",10)
	end	

	if(not oldBWTime or oldBWTime <= 0) then
		local pX, pY, pZ = getElementPosition(player)
		local skin = getElementModel(player)
		local dimension = getElementDimension(player)
		local interior = getElementInterior(player)
		--toggleAllControls(player, false)
		toggleAllControls(player, false, false, false)
		if isElement(veh) then
			spawnPlayer(player, pX, pY, pZ, 0, skin, interior, dimension)
			warpPedIntoVehicle(player, veh, seat)
			setPedAnimation(player, "PED", "CAR_dead_LHS", -1, false, true, false, true)
			setElementHealth(player, 1)
			setVehicleEngineState( veh, false )
			--setElementFrozen(veh, true)
			--setElementData(veh, "handbrake", true)
		else
			spawnPlayer(player, pX, pY, pZ, 0, skin, interior, dimension)
			setElementHealth(player, 1)
			setPedAnimation(player, "PED", "KO_shot_front", -1, false, true, false, true)
		end
	end
	setElementData(player, "bwTime", time)
	if isElement(getElementData(player, "healedBy")) then setElementData(player, "healedBy", nil) end
	if isElement(getElementData(player, "playerHealing")) then setElementData(player, "playerHealing", nil) end
	if getElementData(player, "boomboxInHand") then removeElementData(player, "boomboxInHand") end
	if getElementData(player, "itemGUIOpened") then triggerClientEvent(player, "closeItemGUI", player) end
	if getElementData(player, "vehGUI") then triggerClientEvent(player, "createPlayerVehiclesGUI", player, vehicles, false) end
	if getElementData(player, "driveBy") then removeElementData(player, "driveBy") end
	toggleAllControls(player, false, true, false)
	toggleControl(player, "enter_passenger", false)
	return
end
addEvent("setPlayerBW", true)
addEventHandler("setPlayerBW", root, setPlayerBW)

function doesPlayerHaveBW(player)
	if(not isElement(player)) then return false end
	if(not getElementData(player, "loggedIn") or getElementData(player, "loggedIn") ~= 1) then return false end

	if(tonumber(getElementData(player, "bwTime")) == 0 or not getElementData(player, "bwTime")) then return false else return true end
end

function animTaserSynchronise(state)
	if(state == 1) then
		setPedAnimation(source, "ped", "KO_shot_stom", -1, false, false, false, true)
	end
	if(state == 2) then
		setPedAnimation(source, "CARRY", "crry_prtial", -1, false, false, false, false)
	end
end
addEvent("animTaserSynchronise", true)
addEventHandler("animTaserSynchronise", root, animTaserSynchronise)

function turnBWOff(player)
	if not exports.titan_login:isLogged(player) then return end
	triggerClientEvent(player, "turnBWOff", player)
end