----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

addCommandHandler("tpt", function(plr, com, arg1, arg2)
	if not doesAdminHavePerm(plr, "tele") then return exports.titan_noti:showBox(plr, "Nie posiadasz uprawnień do użycia tej komendy.") end
	if not arg1 then return exports.titan_noti:showBox(plr, "/tpt [ID teleportowanego] [ID odbiorcy]") end
	if not arg2 then return exports.titan_noti:showBox(plr, "/tpt [ID teleportowanego] [ID odbiorcy]") end

	local target1 = exports.titan_login:getPlayerByID(arg1)
	local target2 = exports.titan_login:getPlayerByID(arg2)

	if not isElement(target1) then return exports.titan_noti:showBox(plr, "Nie znaleziono gracza o podanym ID.") end
	if not isElement(target2) then return exports.titan_noti:showBox(plr, "Nie znaleziono gracza o podanym ID.") end


	local x, y, z = getElementPosition(target2)

	if isPedInVehicle(target1) then
		setElementPosition(getPedOccupiedVehicle(target1), x + 2, y + 2, z)
		setElementDimension(getPedOccupiedVehicle(target1), getElementDimension(target2))
		setElementInterior(getPedOccupiedVehicle(target1), getElementInterior(target2))
		setElementDimension(target1, getElementDimension(target2))
		setElementInterior(target1, getElementInterior(target2))
	else
		setElementPosition(target1, x + 2, y + 2, z)
		setElementDimension(target1, getElementDimension(target2))
		setElementInterior(target1, getElementInterior(target2))
	end

	exports.titan_noti:showBox(plr, string.format("Przeteleportowałeś %s do %s", exports.titan_chats:getPlayerICName(target1), exports.titan_chats:getPlayerICName(target2)))
	exports.titan_noti:showBox(target1, string.format("Administrator przeteleportował Cię do %s", exports.titan_chats:getPlayerICName(target2)))
	exports.titan_noti:showBox(target2, string.format("Administrator przeteleportował %s do Ciebie", exports.titan_chats:getPlayerICName(target1)))
end)