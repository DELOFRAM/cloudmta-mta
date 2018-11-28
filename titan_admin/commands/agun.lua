----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmd_aGun(player, command, ...)
	if not exports.titan_admin:doesAdminHavePerm(player, "agun") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	
	local arg = {...}
	local option = string.lower(tostring(arg[1]))
	if option == "bron" then
			local weaponID = arg[2]
			local weaponAmmo = arg[3]
			local weaponName = table.concat(arg, " ", 4)
			if not tonumber(weaponID) or not tonumber(weaponAmmo) or string.len(tostring(weaponName)) < 3 then
				return exports.titan_noti:showBox(player, "TIP: /agun bron [ID broni] [Ilość amunicji] [Nazwa broni]")
			end
			weaponID = tonumber(weaponID)
			weaponAmmo = tonumber(weaponAmmo)
			weaponName = tostring(weaponName)

			if not getWeaponNameFromID(weaponID) then
				return exports.titan_noti:showBox(player, "Nie istnieje bron o podanym ID.")
			end

			if weaponAmmo < 0 then
				return exports.titan_noti:showBox(player, "Amunicja nie może być wartościa ujemna.")
			end

			local itemSlotID = exports.titan_items:getPlayerFreeSlotID(player)
			if not itemSlotID or itemSlotID > 35 then
				exports.titan_noti:showBox(player, "Nie posiadasz wolnego miejsca w ekwipunku.")
				return
			end

			local state, itemID = exports.titan_items:itemCreate(1, getElementData(player, "charID"), weaponName, 1, itemSlotID, 2, weaponID, weaponAmmo, exports.titan_misc:generateGunID())
			if state then
				exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono przedmiot o nazwie \"%s\" (UID: %d).", weaponName, itemID))
				exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) stworzył przedmiot %s (Typ: %d, UID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), itemName, itemType, itemID))
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie tworzenia przedmiotu")
			end
			return
	elseif option == "amunicja" then
		local weaponID = arg[2]
			local weaponAmmo = arg[3]
			local weaponName = table.concat(arg, " ", 4)
			if not tonumber(weaponID) or not tonumber(weaponAmmo) or string.len(tostring(weaponName)) < 3 then
				return exports.titan_noti:showBox(player, "TIP: /agun amunicja [ID broni] [Ilość amunicji] [Nazwa broni]")
			end
			weaponID = tonumber(weaponID)
			weaponAmmo = tonumber(weaponAmmo)
			weaponName = tostring(weaponName)

			if not getWeaponNameFromID(weaponID) then
				return exports.titan_noti:showBox(player, "Nie istnieje bron o podanym ID.")
			end

			if weaponAmmo < 0 then
				return exports.titan_noti:showBox(player, "Amunicja nie może być wartościa ujemna.")
			end

			local itemSlotID = exports.titan_items:getPlayerFreeSlotID(player)
			if not itemSlotID or itemSlotID > 35 then
				exports.titan_noti:showBox(player, "Nie posiadasz wolnego miejsca w ekwipunku.")
				return
			end

			local state, itemID = exports.titan_items:itemCreate(1, getElementData(player, "charID"), weaponName, 2, itemSlotID, 2, weaponID, weaponAmmo, exports.titan_misc:generateGunID())
			if state then
				exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono przedmiot o nazwie \"%s\" (UID: %d).", itemName, itemID))
				exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) stworzył przedmiot %s (Typ: %d, UID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), itemName, itemType, itemID))
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie tworzenia przedmiotu")
			end
			return
	else
		return exports.titan_noti:showBox(player, "TIP: /agun [bron, amunicja]")
	end
end
addCommandHandler("agun", cmd_aGun, false, false)