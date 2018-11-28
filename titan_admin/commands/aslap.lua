----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:18
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:20
----------------------------------------------------

function cmdAslap(player, command, ID)
	if not isPlayerAdmin(player) then return false end
	if not tonumber(ID) then
		exports.titan_noti:showBox(player, "TIP: /aslap [ID gracza]")
		return
	end
	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end

	if isPedInVehicle(target) then
		local veh = getPedOccupiedVehicle(target)
		removePedFromVehicle(target)
		target:setData("belts", false)
	end
	local x, y, z = getElementPosition(target)
	exports.titan_logs:commandLog(player, command, {ID}, target)
	target:setPosition(x, y, z + 3)
	exports.titan_noti:showBox(target, string.format("Slap od %s!", exports.titan_chats:getPlayerICName(player)))
	exports.titan_noti:showBox(player, string.format("Slap dla %s!", exports.titan_chats:getPlayerICName(target)))
end
addCommandHandler("aslap", cmdAslap, false, false)