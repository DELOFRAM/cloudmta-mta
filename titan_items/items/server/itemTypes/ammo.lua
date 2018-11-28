function itemTypeFunc.ammo(player, itemInfo, itemArg1)
	if not tonumber(itemArg1) then
		exports.titan_noti:showBox(player, "TIP: /p uzyj [ID przedmiotu magazynku] [ID przedmiotu broni]")
		guiFunc.updatePlayerEquip(player)
		return false
	end
	itemArg1 = tonumber(itemArg1)
	local weaponItemInfo = getItemInfo(itemArg1)
	if(not weaponItemInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono przedmiotu broni o podanym ID.")
		return false
	end
	if(weaponItemInfo.ownerType ~= 1 or weaponItemInfo.owner ~= getElementData(player, "charID")) then
		exports.titan_noti:showBox(player, "Podany przedmiot broni nie należy do Ciebie.")
		return
	end
	if(weaponItemInfo.type ~= 1) then
		exports.titan_noti:showBox(player, "Podany przedmiot nie jest bronią.")
		return false
	end
	if(weaponItemInfo.val1 ~= itemInfo.val1) then
		exports.titan_noti:showBox(player, "Amunicja nie pasuje do tej broni.")
		return false
	end
	if(weaponItemInfo.used == 1) then
		exports.titan_noti:showBox(player, "Broń nie może być używana.")
		return false
	end
	weaponItemInfo.val2 = weaponItemInfo.val2 + itemInfo.val2
	removeItem(itemInfo.ID)
	exports.titan_noti:showBox(player, string.format("Załadowano amunicję do broni %s.", weaponItemInfo.name))
	exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("przeładował amunicję w broni \"%s\".", weaponItemInfo.name), 10.0)
end