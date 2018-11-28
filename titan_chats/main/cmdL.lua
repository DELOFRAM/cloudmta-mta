----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:23
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:25
----------------------------------------------------

function cmdL(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then
		outputChatBox("TIP: /l(ocal) [treść]", player)
		return false 
	end

	if(exports.titan_bw:doesPlayerHaveBW(player)) then
		exports.titan_noti:showBox(player, "W czasie stanu nieprzytomności nie możesz się odezwać.")
		return false
	end

	message = firstToUpper(message)
	message = addStop(message)

	sendPlayerLocalMessageRadius(player, message, 8.0, "mówi")
	if not getElementData(player, "gym:training") then
		setPedAnimation(player, "GANGS", "prtial_gngtlkH", 2000, false, false)
		setTimer(function()
			setPedAnimation(player, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)
		end, 2000, 1)
	end
	return true
end
addCommandHandler("l", cmdL, false, false)
addCommandHandler("local", cmdL, false, false)