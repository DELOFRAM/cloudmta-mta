----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:27
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:29
----------------------------------------------------

function cmdM(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	if(not exports.titan_items:doesPlayerHaveItemType(player, 4)) then
		exports.titan_noti:showBox(player, "Nie posiadasz megafonu w swoim ekwipunku.")
		return
	end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then
		exports.titan_noti:showBox(player, "TIP: /m(egafon) [treść]")
		return false 
	end

	if(exports.titan_bw:doesPlayerHaveBW(player)) then
		exports.titan_noti:showBox(player, "W czasie stanu nieprzytomności nie możesz się odezwać.")
		return false
	end

	message = firstToUpper(message)
	message = addStop(message)
	exports.titan_db:query_free("UPDATE _items SET lastUsed = UNIX_TIMESTAMP(), lastUsedID = ? WHERE owner = ? AND ownerType = 1 AND type = 4", getElementData(player, "charID"), getElementData(player, "charID"))
	sendPlayerLocalMessageRadiusColor(player, message, 60, 245, 218, 7, "(megafon)")
	return true
end
addCommandHandler("m", cmdM, false, false)
addCommandHandler("megafon", cmdM, false, false)

