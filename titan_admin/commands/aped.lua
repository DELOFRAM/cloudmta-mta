----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmdAped(player, command, ...)
	if not doesAdminHavePerm(player, "peds") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local args = {...}
	local option = string.lower(tostring(args[1]))
	if option == "stworz" then
		local skinID = args[2]
		local pedType = args[3]
		local pedName = table.concat(args, " ", 4)
		if not tonumber(skinID) or string.len(tostring(pedType)) < 4 or string.len(tostring(pedName)) < 4 then return exports.titan_noti:showBox(player, "TIP: /aped stworz [skinID] [Typ peda] [Nazwa peda]") end
		skinID = tonumber(skinID)
		local x, y, z = getElementPosition(player)
		local rx, ry, rz = getElementRotation(player)
		if exports.titan_peds:pedCreate(skinID, x, y, z, rz, player:getInterior(), player:getDimension(), pedType, pedName) then
			return exports.titan_noti:showBox(player, "Ped został stworzony pomyślnie!")
		else
			return exports.titan_noti:showBox(player, "Tworzenie peda nie powiodło się. Zgłoś to administratorowi.")
		end
	elseif option == "usun" then
		local pedID = args[2]
		if not tonumber(pedID) then return exports.titan_noti:showBox(player, "TIP: /aped usun [pedID]") end
		pedID = tonumber(pedID)
		if exports.titan_peds:pedDestroy(pedID) then
			return exports.titan_noti:showBox("Pomyślnie usunięto peda.")
		else
			return exports.titan_noti:showBox("Ped nie został znaleziony.")
		end
	else
		exports.titan_noti:showBox(player, "TIP: /aped [stworz, usun]")
	end
end
addCommandHandler("aped", cmdAped, false, false)