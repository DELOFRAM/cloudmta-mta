----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:36
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:38
----------------------------------------------------

function cmdGethere(player, command, arg1)
	if not doesAdminHavePerm(player, "tele") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end

	if(not tonumber(arg1)) then
		--outputChatBox(string.format("TIP: /tm [ID gracza]"), player, 180, 180, 180)
		exports.titan_noti:showBox(player, "/tm [ID gracza]")  
		return
	end

	local elem = exports.titan_login:getPlayerByID(tonumber(arg1))
	if not elem then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.") end
	if getElementData(elem, "inAJ") then return exports.titan_noti:showBox(player, "Nie możesz teleportować do siebie gracza w AJ.") end

	local pX, pY, pZ = getElementPosition(player)

	if(isPedInVehicle(elem)) then
		setElementPosition(getPedOccupiedVehicle(elem), pX + 2, pY + 2, pZ)
		setElementDimension(getPedOccupiedVehicle(elem), getElementDimension(player))
		setElementInterior(getPedOccupiedVehicle(elem), getElementInterior(player))
		setElementDimension(elem, getElementDimension(elem))
		setElementInterior(elem, getElementInterior(elem))
	else
		setElementPosition(elem, pX + 2, pY + 2, pZ)
		setElementDimension(elem, getElementDimension(player))
		setElementInterior(elem, getElementInterior(player))
	end
	exports.titan_noti:showBox(elem, "Administrator teleportował Cię do siebie.")
	return
end
addCommandHandler("tm", cmdGethere, false, false)