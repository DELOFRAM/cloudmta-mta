----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:29
-- Ostatnio zmodyfikowano: 2016-01-09 15:44:35
----------------------------------------------------

local deathReasons =
{
	[19] = "Rakieta",
	[37] = "Spalenie",
	[49] = "Potrącenie",
	[50] = "Przecięcie śmigłem helikotpera",
	[51] = "Eksplozja",
	[52] = "Driveby",
	[53] = "Utonięcie",
	[54] = "Upadek",
	[55] = "Unknown",
	[56] = "Melee",
	[57] = "Weapon",
	[59] = "Tank Grenade",
	[63] = "Wybuch w aucie"
}

function triggerPlayerSpawn(player)
	setPedAnimation(player, "PED", "KO_shot_front", -1, false, true, false, true)
	setCameraTarget(player, player)
	toggleAllControls(player, true)
	if isPedInVehicle(player) then
		setPedAnimation (player, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)
	else
		setPedAnimation(player, "ped", "getup_front", -1, false, true, false, false)
	end
	setElementHealth(player, player:getData("damageType") == 2 and 20 or player:getData("damageType") == 3 and 10 or 25)
	if player:getData("damageType") == 1 or player:getData("damageType") == 2 then exports.titan_db:query_free("UPDATE _characters SET damageType = '0' WHERE ID = ?", player:getData("charID")) end
	if player:getData("damageType") ~= 3 then player:removeData("damageType") end

	exports.titan_damage:resetPlayerDamage(player)
end
addEvent("triggerPlayerSpawn", true)
addEventHandler("triggerPlayerSpawn", root, triggerPlayerSpawn)

function onPDeath(totalAmmo, killer, killerWeapon, bodypart, stealth)
	source:setData("belts", false)
	exports.titan_items:disarmPlayer(source)
	if isElement(killer) then
		if isElement(source:getData("cuffedBy")) then
			setElementData(source:getData("cuffedBy"), "cuffedPlayer", false)
			detachElements(source, source:getData("cuffedBy"))
			source:setData("cuffedBy", false)
		end
	end
	local damageType = 1
	local veh = source:getData("inVehicle")
	local seat = 0
	if isElement(veh) then 
		seat = source:getData("inVehicleSeat")
	end
	if isElement(killer) and bodypart == 9 then
		setPlayerBW(source, 60 * 15, veh, seat)
		source:setData("damageType", 3)
	else
		if tonumber(killerWeapon) and killerWeapon == 49 or killerWeapon == 5 then
			setPlayerBW(source, 60 * 6, veh, seat)
			source:setData("damageType", 2)
		elseif tonumber(killerWeapon) and killerWeapon == 4 or (killerWeapon >= 22 and killerWeapon <= 38) then
			setPlayerBW(source, 60 * 10, veh, seat)
			source:setData("damageType", 3)
		elseif tonumber(killerWeapon) == 54 then
			setPlayerBW(source, 60 * 7, veh, seat)
			source:setData("damageType", 2)
		elseif tonumber(killerWeapon) and killerWeapon == 3 or killerWeapon == 2 or killerWeapon == 5 then
			setPlayerBW(source, 60 * 6, veh, seat)
			source:setData("damageType", 2)
		elseif tonumber(killerWeapon) and killerWeapon == 8 then
			setPlayerBW(source, 60 * 10, veh, seat)
			source:setData("damageType", 3)
		elseif tonumber(killerWeapon) and killerWeapon == 9 then
			setPlayerBW(source, 60 * 15, veh, seat)
			source:setData("damageType", 3)	
		else
			setPlayerBW(source, 60 * 3, veh, seat)
			source:setData("damageType", 1)
		end
	end
	exports.titan_db:query_free("UPDATE _characters SET damageType = ? WHERE ID = ?", getElementData(source, "damageType"), getElementData(source, "charID"))
	setPlayerCKReason(source, killer, killerWeapon)
end
addEventHandler("onPlayerWasted", root, onPDeath)

function onVehEnter(player, seat)
	player:setData("inVehicle", source)
	player:setData("inVehicleSeat", seat)
end
addEventHandler("onVehicleEnter", root, onVehEnter)

function onVehExit(player)
	player:removeData("inVehicle")
	player:removeData("inVehicleSeat")
end
addEventHandler("onVehicleExit", root, onVehExit)

function setPlayerCKReason(player, killer, killerWeapon)
	if deathReasons[killerWeapon] then
		local tmpTable = 
		{
			killerDNA = "n/d",
			weaponID = killerWeapon,
			weaponData = "Zabity przez "..deathReasons[killerWeapon]
		}
		player:setData("CKReason", tmpTable)
		return
	else
		if isElement(killer) and killer:getType() == "player" and exports.titan_login:isLogged(killer) then
			local tmpTable = {}
			tmpTable.killerDNA = killer:getData("DNA")
			if killerWeapon == 0 then
				tmpTable.weaponID = 0
				tmpTable.weaponData = killer:getData("DNA")
			else
				tmpTable.weaponID = killerWeapon
				local weaponData = exports.titan_items:getPlayerUsedGunWeaponIDVal3(killer, killerWeapon)
				tmpTable.weaponData = weaponData and weaponData or "---"
			end
			player:setData("CKReason", tmpTable)
			return
		end
	end
end

-- function cancelAFKDamage()
-- if getElementData(source, "isAFK") then return cancelEvent(true) end
-- end
-- addEventHandler("onPlayerDamage", root, cancelAFKDamage)

function cmdAsmierc(player)
	if not exports.titan_login:isLogged(player) then return end
	if not exports.titan_bw:doesPlayerHaveBW(player) then return exports.titan_noti:showBox(player, "Nie jesteś nieprzytomny.") end
	-- if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz być w pojeździe.") end
	if type(player:getData("CKReason")) ~= "table" then return exports.titan_noti:showBox(player, "Wystąpił błąd związany z wartością \"CKReason\". Poinformuj administratora.") end
	
	if player:getData("onlineTime") < 36000 then
		return exports.titan_noti:showBox(player, "Aby przeprowadzić Character Kill musisz mieć przegrane przynajmniej 10h na swojej postaci.")
	end

	exports.titan_items:playerAllItemsOnGround(player)

	local ckreason = player:getData("CKReason")
	local pos = player:getPosition()
	local tmpTable = 
	{
		name = string.format("%s %s", player:getData("name"), player:getData("lastname")),
		DNA = player:getData("DNA"),
		killerDNA = ckreason.killerDNA,
		killTime = getRealTime().timestamp,
		weaponID = ckreason.weaponID,
		weaponData = ckreason.weaponData,
		location = getZoneName(pos)
	}
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _corpses SET name = ?, DNA = ?, killerDNA = ?, killTime = ?, weaponID = ?, weaponData = ?, location = ?", tmpTable.name, tmpTable.DNA, tmpTable.killerDNA, tmpTable.killTime, tmpTable.weaponID, tmpTable.weaponData, tmpTable.location)
	if lastID then
		if not isPedInVehicle(player) then
		exports.titan_items:itemCreate(0, 0, "Zwłoki", 7, 0, 2, lastID, 0, 0, player)
		else
		exports.titan_items:itemCreate(3, getElementData(getPedOccupiedVehicle(player), "vehID"), "Zwłoki", 7, 0, 2, lastID, 0, 0, player)
		end
	end
	exports.titan_db:query_free("UPDATE _characters SET blocked = 1 WHERE ID = ?", player:getData("charID"))
	exports.titan_admin:savePenalty(14, 0, player, 0, "Postać została uśmiercona.")
	kickPlayer(player, root, "Character Kill")
end
addCommandHandler("asmierc", cmdAsmierc, false, false)