----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function aFck(player, command, ID, ...)
	if not doesAdminHavePerm(player, "fck") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local reason = tostring(table.concat({...}, " "))
	if not tonumber(ID) or string.len(reason) <= 1 then
		return exports.titan_noti:showBox(player, "TIP: /afck [ID gracza] [powód]")
	end
	if string.len(reason) < 5 then
		return exports.titan_noti:showBox(player, "Długość powodu musi zawierać przynajmniej 5 znaków.")
	end
	ID = tonumber(ID)
	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end
	local adminName = tostring(getElementData(player, "globalName"))
	local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
	reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
	exports.titan_hud:showPenalty(adminName, playerName, 14, reason, 0)
	exports.titan_items:playerAllItemsOnGround(target)
	local pos = target:getPosition()
	local tmpTable = 
	{
		name = string.format("%s %s", target:getData("name"), target:getData("lastname")),
		DNA = target:getData("DNA"),
		killerDNA = "N/D",
		killTime = getRealTime().timestamp,
		weaponID = "N/D",
		weaponData = "N/D",
		location = getZoneName(pos)
	}
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _corpses SET name = ?, DNA = ?, killerDNA = ?, killTime = ?, weaponID = ?, weaponData = ?, location = ?", tmpTable.name, tmpTable.DNA, tmpTable.killerDNA, tmpTable.killTime, tmpTable.weaponID, tmpTable.weaponData, tmpTable.location)
	if lastID then
		if not isPedInVehicle(target) then
			exports.titan_items:itemCreate(0, 0, "Zwłoki", 7, 0, 2, lastID, 0, 0, target)
		else
			exports.titan_items:itemCreate(3, getElementData(getPedOccupiedVehicle(target), "vehID"), "Zwłoki", 7, 0, 2, lastID, 0, 0, target)
		end
	end
	exports.titan_db:query_free("UPDATE _characters SET blocked = 1 WHERE ID = ?", target:getData("charID"))
	exports.titan_admin:savePenalty(14, player, target, 0, reason)
	kickPlayer(target, root, "Character Kill")
end
addCommandHandler("afck", aFck, false, false)