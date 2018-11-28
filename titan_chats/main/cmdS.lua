----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:32
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:34
----------------------------------------------------

function cmdS(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1) then
		outputChatBox("TIP: /s(zept) [treść]", player)
		return false 
	end
	
	if(exports.titan_bw:doesPlayerHaveBW(player)) then
		exports.titan_noti:showBox(player, "W czasie stanu nieprzytomności nie możesz się odezwać.")
		return false
	end

	message = firstToUpper(message)
	message = addStop(message)
	
	local phoneElem = getElementData(player, "phoneCallElem")
	if isPedInVehicle(player) and not getElementData(getPedOccupiedVehicle(player), "openWindows") then
		for k,v in pairs(getVehicleOccupants(getPedOccupiedVehicle(player))) do
			if isElement(phoneElem) then
				sendPlayerChatMessage(v, string.format("%s %s: %s", getPlayerICName(player), "szepcze (telefon)", message), 230, 230, 230, false)
			else
				sendPlayerChatMessage(v, string.format("%s %s: %s", getPlayerICName(player), "szepcze", message), 230, 230, 230, false)
			end
		end
		local pNumber = exports.titan_items:phoneFunctionGetPlayerNumber(player)
		if(tonumber(pNumber)) then
			local messageToPhone = string.format("%d (%s) (szept): %s", pNumber, player:getData("sex") == 1 and "mężczyzna" or "kobieta", message)
			sendPlayerChatMessage(phoneElem, messageToPhone, 98, 121, 43, false)
		else
			setElementData(player, "phoneCallElem", false)
		end
		return true
	else
		if isElement(phoneElem) then
			sendPlayerLocalMessageRadius(player, message, 3.0, "szepcze (telefon)")
		else
			sendPlayerLocalMessageRadius(player, message, 3.0, "szepcze")
		end
		local pNumber = exports.titan_items:phoneFunctionGetPlayerNumber(player)
		if(tonumber(pNumber)) then
			local messageToPhone = string.format("%d (%s) (szept): %s", pNumber, player:getData("sex") == 1 and "mężczyzna" or "kobieta", message)
			sendPlayerChatMessage(phoneElem, messageToPhone, 98, 121, 43, false)
		else
			setElementData(player, "phoneCallElem", false)
		end
		return true
	end
end
--addCommandHandler("s", cmdS, false, false)
addCommandHandler("c", cmdS, false, false)
addCommandHandler("szept", cmdS, false, false)