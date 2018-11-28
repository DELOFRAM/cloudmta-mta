----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Ostatnia modyfikacja: Irons
-- Stworzono:   2016-01-09 15:45:18
-- Ostatnio zmodyfikowano: 2016-08-13 23:48:21
----------------------------------------------------

function cmdK(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then
		outputChatBox("TIP: /k(rzyk) [treść]", player)
		return false 
	end

	if(exports.titan_bw:doesPlayerHaveBW(player)) then
		exports.titan_noti:showBox(player, "W czasie stanu nieprzytomności nie możesz się odezwać.")
		return false
	end

	message = firstToUpper(message)
	message = string.format("%s!", message)
	local phoneElem = getElementData(player, "phoneCallElem")
	if isPedInVehicle(player) and not getElementData(getPedOccupiedVehicle(player), "openWindows") then
		local pNumber = exports.titan_items:phoneFunctionGetPlayerNumber(player)
		if(tonumber(pNumber)) then
			local messageToPhone = string.format("%d (%s) (krzyk): %s", pNumber, player:getData("sex") == 1 and "mężczyzna" or "kobieta", message)
			--outputChatBox(messageToPhone, phoneElem, 98, 121, 43)
			sendPlayerChatMessage(phoneElem, messageToPhone, 98, 121, 43, false)
		else
			setElementData(player, "phoneCallElem", false)
		end
		for k,v in pairs(getVehicleOccupants(getPedOccupiedVehicle(player))) do
			if isElement(phoneElem) then
				sendPlayerChatMessage(v, string.format("%s %s: %s", getPlayerICName(player), "krzyczy (telefon)", message), 230, 230, 230, false)
				
			else
				sendPlayerChatMessage(v, string.format("%s %s: %s", getPlayerICName(player), "krzyczy", message), 230, 230, 230, false)
			end
		end
		return true
	else
		if isElement(phoneElem) then
			sendPlayerLocalMessageRadius(player, message, 18.0, "krzyczy (telefon)")
		else
			sendPlayerLocalMessageRadius(player, message, 18.0, "krzyczy")
			if not getElementData(player, "gym:training") then
				setPedAnimation(player, "ON_LOOKERS", "shout_in", 2000, false, false)
				setTimer(function()
					setPedAnimation(player, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)
				end, 2000, 1)
			end
		end
		local pNumber = exports.titan_items:phoneFunctionGetPlayerNumber(player)
		if(tonumber(pNumber)) then
			local messageToPhone = string.format("%d (%s) (krzyk): %s", pNumber, player:getData("sex") == 1 and "mężczyzna" or "kobieta", message)
			sendPlayerChatMessage(phoneElem, messageToPhone, 98, 121, 43, false)
		else
			setElementData(player, "phoneCallElem", false)
		end
		return true
	end
end
addCommandHandler("k", cmdK, false, false)
addCommandHandler("krzyk", cmdK, false, false)
addCommandHandler("s", cmdK, false, false)