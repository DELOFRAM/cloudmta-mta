function itemTypeFunc.weapon(player, itemInfo, itemArg1)
	if(itemInfo.used == 1) then
		itemInfo.used = 0
		takeWeapon(player, itemInfo.val1)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("schował broń %s.", itemInfo.name), 10.0)
		exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
		guiFunc.updatePlayerEquip(player)
	else
		if(getSlotFromWeapon(itemInfo.val1) and getSlotFromWeapon(itemInfo.val1) ~= 1 and itemInfo.val2 <= 0) then
			exports.titan_noti:showBox(player, string.format("W broni %s skończyła się amunicja.", itemInfo.name))
			guiFunc.updatePlayerEquip(player)
			return
		end
		local slot = getSlotFromWeapon(itemInfo.val1)
		if(not slot) then
			exports.titan_noti:showBox(player, "Niepoprawne ID broni.")
			guiFunc.updatePlayerEquip(player)
			return
		end
		if(getPedWeapon(player, slot) ~= 0 and getPedTotalAmmo(player, slot) > 0) then
			exports.titan_noti:showBox(player, "Ten slot broni jest już zajęty.")
			guiFunc.updatePlayerEquip(player)
			return
		end

		itemInfo.used = 1
		giveWeapon(player, itemInfo.val1, itemInfo.val2, true)
		exports.titan_chats:sendPlayerLocalMeRadius(player, string.format("wyciągnął broń %s.", itemInfo.name), 10.0)
		exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), lastUsedID = ? WHERE ID = ?", itemInfo.used, getElementData(player, "charID"), itemInfo.ID)
		guiFunc.updatePlayerEquip(player)
	end
end