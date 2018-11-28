----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:49
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:51
----------------------------------------------------

function cmdGoto(player, command, arg1)
	if not doesAdminHavePerm(player, "tele") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end

	if(not tonumber(arg1)) then
		exports.titan_noti:showBox(player, "/to [ID gracza]")  
		return
	end

	local elem = exports.titan_login:getPlayerByID(tonumber(arg1))
	if(not elem) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
		return
	end

	local pX, pY, pZ = getElementPosition(elem)

	if(isPedInVehicle(player)) then
		setElementPosition(getPedOccupiedVehicle(player), pX + 2, pY + 2, pZ)
		setElementDimension(getPedOccupiedVehicle(player), getElementDimension(elem))
		setElementInterior(getPedOccupiedVehicle(player), getElementInterior(elem))
		setElementDimension(player, getElementDimension(elem))
		setElementInterior(player, getElementInterior(elem))
	else
		setElementPosition(player, pX + 2, pY + 2, pZ)
		setElementDimension(player, getElementDimension(elem))
		setElementInterior(player, getElementInterior(elem))
	end
	exports.titan_noti:showBox(elem, "Administrator teleportował się do Ciebie.")
	return
end
addCommandHandler("to", cmdGoto, false, false)