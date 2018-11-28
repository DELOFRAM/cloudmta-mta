----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:59
-- Ostatnio zmodyfikowano: 2016-01-19 22:47:28
----------------------------------------------------

function onPlayerChat2(player, message, messageType)
	triggerEvent("onPlayerChat2", player, message, messageType)
end

function onPlayerChat(message, messageType)
	cancelEvent()

	if(not exports.titan_login:isLogged(source)) then return false end
	if(string.len(message) < 1) then return false end
	if(messageType == 0) then
		-- Czat administratora
		if string.byte(message) == string.byte("#") then
			if not exports.titan_admin:isPlayerAdmin(source) then return end
			message = string.sub(message, 2)
			message = firstToUpper(message)
			message = addStop(message)

			exports.titan_logs:adminChatLog(string.format("%s: %s", source:getData("globalName"), message))
			local aColor = exports.titan_misc:getAdminRank(exports.titan_admin:getPlayerAdminLevel(source))
			aColor = aColor.color
			message = string.format("#73739e# #ffffff[[ #%s%s#ffffff (%d): %s ]]", aColor, source:getData("globalName"), source:getData("playerID"), string.gsub(message, "#%x%x%x%x%x%x", ""))

			for k, v in ipairs(exports.titan_admin:getAvailableAdmins()) do
				if v:getData("sampChat") then
					sendPlayerChatMessage(v, message, 255, 255, 255, true)
				else
					exports.titan_chats:addPlayerOOCMessage(v, message, 255, 255, 255)
				end
			end
			return
		end
		if string.byte(message) == string.byte(".") then
			if(exports.titan_bw:doesPlayerHaveBW(source)) then
				exports.titan_noti:showBox(source, "W czasie stanu nieprzytomności nie możesz się odezwać.")
				return false
			end
			if isPedInVehicle(source) then
				return exports.titan_noti:showBox(source, "Nie możesz używać animacji będąc w pojeździe.")	
			end
			message = string.sub(message, 2)
			if(string.lower(message) == "stopani") then
				exports.titan_anims:playerStopAnim(source)
			else
				exports.titan_anims:playerStartAnim(source, message)
			end
			return
		end
		-- czaty grupy
		if(string.byte(message) == string.byte("@")) then
			local slot = string.sub(message, 2, 3)
			if(not tonumber(slot)) then return false end
			message = string.sub(message, 4)
			message = firstToUpper(addStop(message))
			exports.titan_orgs:sendGroupOOCMessage(source, tonumber(slot), message)
			return
		end

		if(string.byte(message) == string.byte("!")) then
			if(exports.titan_bw:doesPlayerHaveBW(source)) then
				exports.titan_noti:showBox(source, "W czasie stanu nieprzytomności nie możesz się odezwać.")
				return false
			end
			local slot = string.sub(message, 2, 3)
			if(not tonumber(slot)) then return false end
			message = string.sub(message, 4)
			message = firstToUpper(addStop(message))
			exports.titan_orgs:sendGroupICMessage(source, tonumber(slot), message)
			sendPlayerLocalMessageRadius(source, message, 10.0, "mówi (radio)", false)
			return
		end
		-- czaty grupy - END
		if(exports.titan_bw:doesPlayerHaveBW(source)) then
			exports.titan_noti:showBox(source, "W czasie stanu nieprzytomności nie możesz się odezwać.")
			return false
		end

		--outputConsole("Testowa komenda?")

		if string.lower(tostring(message)) == ":)" then return sendPlayerLocalMeRadius(source, "uśmiecha się.", 10.0, false) end
		if string.lower(tostring(message)) == "(:" then return sendPlayerLocalMeRadius(source, "uśmiecha się.", 10.0, false) end
		if string.lower(tostring(message)) == "c:" then return sendPlayerLocalMeRadius(source, "uśmiecha się.", 10.0, false) end
		if string.lower(tostring(message)) == ";)" then return sendPlayerLocalMeRadius(source, "puszcza oczko.", 10.0, false) end
		if string.lower(tostring(message)) == "(;" then return sendPlayerLocalMeRadius(source, "puszcza oczko.", 10.0, false) end
		if string.lower(tostring(message)) == ":d" or string.lower(tostring(message)) == ";d" then return sendPlayerLocalMeRadius(source, "śmieje się.", 10.0, false) end
		if string.lower(tostring(message)) == ":p" or string.lower(tostring(message)) == ";p" then return sendPlayerLocalMeRadius(source, "wystawia język.", 10.0, false) end
		if string.lower(tostring(message)) == ":o" or string.lower(tostring(message)) == ";o" then return sendPlayerLocalMeRadius(source, "robi zdziwioną minę.", 10.0, false) end
		if string.lower(tostring(message)) == "o:" or string.lower(tostring(message)) == "o;" then return sendPlayerLocalMeRadius(source, "robi zdziwioną minę.", 10.0, false) end
		if string.lower(tostring(message)) == ":/" or string.lower(tostring(message)) == ";/" then return sendPlayerLocalMeRadius(source, "krzywi się.", 10.0, false) end
		if string.lower(tostring(message)) == "/:" or string.lower(tostring(message)) == "/;" then return sendPlayerLocalMeRadius(source, "krzywi się.", 10.0, false) end
		if string.lower(tostring(message)) == ":*" or string.lower(tostring(message)) == ";*" then return sendPlayerLocalMeRadius(source, "posyła całusa.", 10.0, false) end
		if string.lower(tostring(message)) == "*:" or string.lower(tostring(message)) == "*;" then return sendPlayerLocalMeRadius(source, "posyła całusa.", 10.0, false) end
		if string.lower(tostring(message)) == ":3" or string.lower(tostring(message)) == ";3" then return sendPlayerLocalMeRadius(source, "słodko się uśmiecha.", 10.0, false) end
		if string.lower(tostring(message)) == ":(" or string.lower(tostring(message)) == ";(" then return sendPlayerLocalMeRadius(source, "robi smutną minę.", 10.0, false) end
		if string.lower(tostring(message)) == ":c" or string.lower(tostring(message)) == ";c" then return sendPlayerLocalMeRadius(source, "robi smutną minę.", 10.0, false) end
		if string.lower(tostring(message)) == "):" or string.lower(tostring(message)) == ");" then return sendPlayerLocalMeRadius(source, "robi smutną minę.", 10.0, false) end

		message = firstToUpper(message)
		message = addStop(message)

		local phoneElem = getElementData(source, "phoneCallElem")
		if(isElement(phoneElem)) then
			if isPedInVehicle(source) and not getElementData(getPedOccupiedVehicle(source), "openWindows") then
				for k,v in pairs(getVehicleOccupants(getPedOccupiedVehicle(source))) do
					local newMessage = string.format("%s %s (telefon): %s", getPlayerICName(source), "mówi", message)
					--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 230, 230, 230)
					--outputChatBox(newMessage, v, 230, 230, 230, false)
					sendPlayerChatMessage(v, newMessage, 230, 230, 230, false)
				end
			else
				sendPlayerLocalMessageRadius(source, message, 1, "mówi (telefon)")
			end
			
			local pNumber = exports.titan_items:phoneFunctionGetPlayerNumber(source)
			if(tonumber(pNumber)) then
				local messageToPhone = string.format("%s (%s): %s", tonumber(pNumber), source:getData("sex") == 1 and "mężczyzna" or "kobieta", message)
				--outputChatBox(messageToPhone, phoneElem, 98, 121, 43)
				sendPlayerChatMessage(phoneElem, messageToPhone, 98, 121, 43, false)
			else
				setElementData(source, "phoneCallElem", false)
			end
		else
			--outputConsole("testowe teraz sprawdzenie")
			if isPedInVehicle(source) and not getElementData(getPedOccupiedVehicle(source), "openWindows") and getVehicleType(getPedOccupiedVehicle(source)) ~= "Bike" and getVehicleType(getPedOccupiedVehicle(source)) ~= "BMX" and getVehicleType(getPedOccupiedVehicle(source)) ~= "Quad" then
				for k,v in pairs(getVehicleOccupants(getPedOccupiedVehicle(source))) do
					--outputChatBox(string.format("%s %s: %s", getPlayerICName(source), "mówi", message))
					local newMessage = string.format("%s %s: %s", getPlayerICName(source), "mówi", message)
					--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 230, 230, 230)
					--outputChatBox(newMessage, v, 230, 230, 230, false)
					sendPlayerChatMessage(v, newMessage, 230, 230, 230, false)
				end
			else
				sendPlayerLocalMessageRadius(source, message, 8.0, "mówi")
				--setPedAnimation(source, "GANGS", "prtial_gngtlkH", 2000, false, false)
				--	setTimer(function()
				--	setPedAnimation(source, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)
				--	end, 2000, 1)
			end
			if getElementData(source, "interviewLSN") then 
				exports.titan_news:addInterviewMessage(source, message) 
			end 
		end
		return
	end

	if(messageType == 1) then
		if(not message or string.len(message) < 2) then return end
		sendPlayerLocalMeRadius(source, addStop(tostring(message)), 10.0, true)
		return
	end
end
addEvent("onPlayerChat2", true)
addEventHandler("onPlayerChat2", root, onPlayerChat)
addEventHandler("onPlayerChat", root, onPlayerChat)

for k,v in ipairs(getElementsByType("player")) do
	bindKey(v, "space", "down", "say", ".stopani")
end