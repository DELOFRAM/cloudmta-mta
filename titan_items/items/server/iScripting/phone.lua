local phoneServer = {}
local phoneUsers = {}
local phoneUsersIndex = {}
phoneFunction = {}

function phoneFunction.getID()
	local i = 1
	while(true) do
		if(type(phoneServer[i]) ~= "table") then return i end
		i = i + 1
	end
end

function phoneFunction.getNumberFromPlayer(player)
	if(tonumber(phoneUsers[player])) then return phoneUsers[player] end
	return false
end

function phoneFunction.getConversationIndexFromNumber(number)
	for k, v in pairs(phoneServer) do
		if(v.sender == number or v.target == number) then return k end
		return false
	end
end

function phoneFunction.doesPlayerHaveConversation(player)
	local phoneNumber = phoneFunction.getNumberFromPlayer(player)
	if(not phoneNumber) then return false end
	local index = phoneFunction.getConversationIndexFromNumber(phoneNumber)
	if(tonumber(index)) then return true end
	return false
end

function phoneFunction.doesNumberHaveConversation(phoneNumber)
	local index = phoneFunction.getConversationIndexFromNumber(phoneNumber)
	if(tonumber(index)) then return true end
	return false
end

function phoneFunction.getPhoneContacts(phoneID, phoneNumber)
	local query = exports.titan_db:query("SELECT * FROM _phone_contacts WHERE phoneID = ? ORDER BY name ASC", phoneID)
	if(#query <= 0) then
		local tempTable = {}
		table.insert(tempTable, {ID = nil, phoneID = phoneID, number = phoneNumber, name = "Mój numer"})
		table.insert(tempTable, {ID = nil, phoneID = phoneID, number = 911, name = "Numer alarmowy"})
		return tempTable
	end
	local tempTable = {}
	table.insert(tempTable, {ID = nil, phoneID = phoneID, number = phoneNumber, name = "Mój numer"})
	table.insert(tempTable, {ID = nil, phoneID = phoneID, number = 911, name = "Numer alarmowy"})
	for k, v in ipairs(query) do
		table.insert(tempTable, v)
	end
	return tempTable
end

function phoneFunction.deleteContact(contactID)
	if not exports.titan_login:isLogged(source) then return end
	local phoneInfo = getPlayerUsedPhoneInfo(source)
	if not phoneInfo then
		return exports.titan_noti:showBox(source, "Nie posiadasz żadnego telefonu w użyciu.")
	end

	if source:getData("phoneState") then
		local query, numRows = exports.titan_db:query("SELECT name, phoneID FROM _phone_contacts WHERE ID = ?", contactID)
		if numRows == 0 then return exports.titan_noti:showBox(source, "Ten kontakt nie istnieje.") end
		query = query[1]
		if query.phoneID ~= phoneInfo.ID then return exports.titan_noti:showBox(source, "Ten kontakt nie jest zapisany na Twoim telefonie.") end
		exports.titan_db:query_free("DELETE FROM _phone_contacts WHERE ID = ?", contactID)
		exports.titan_noti:showBox(source, string.format("Kontakt \"%s\" usunięty pomyślnie.", query.name))
		local contacts = phoneFunction.getPhoneContacts(phoneInfo.ID, phoneInfo.val1)
		triggerClientEvent(source, "phoneEvent.refreshContacts", resourceRoot, contacts)
	end
end
addEvent("phoneFunction.deleteContact", true)
addEventHandler("phoneFunction.deleteContact", root, phoneFunction.deleteContact)

function phoneFunction.getPhoneMessages(phoneID)
	local query = exports.titan_db:query("SELECT * FROM _phone_messages WHERE phoneID = ? ORDER BY timestamp DESC", phoneID)
	if(#query <= 0) then return {} end
	return query
end

---------
-- CMD --
---------
function phoneFunction.cmd(player)
	if(not exports.titan_login:isLogged(player)) then return end
	local phoneInfo = getPlayerUsedPhoneInfo(player)
	if(not phoneInfo) then
		exports.titan_noti:showBox(player, "Nie posiadasz żadnego telefonu w użyciu.")
		return
	end
	if(getElementData(player, "phoneState")) then
		triggerClientEvent(player, "phoneEvent.turnOff", player)
	else
		local contacts = phoneFunction.getPhoneContacts(phoneInfo.ID, phoneInfo.val1)
		local messages = phoneFunction.getPhoneMessages(phoneInfo.ID)
		triggerClientEvent(player, "phoneEvent.turnOn", player, contacts, messages)
	end
end
addCommandHandler("tel", phoneFunction.cmd, false, false)

------------
-- EVENTY --
------------
function phoneFunction.startCall(player, toNumber)
	if(not exports.titan_login:isLogged(player)) then return end

	-------------
	-- NADAWCA --
	-------------

	local phoneInfo = getPlayerUsedPhoneInfo(player)
	if(not phoneInfo) then
			exports.titan_noti:showBox(player, "Nie posiadasz żadnego telefonu w użyciu.")
		return
	end
	if(phoneFunction.doesPlayerHaveConversation(player)) then
		exports.titan_noti:showBox(player, "Prowadzisz już inną rozmowę.")
		return
	end

	--------------
	-- ODBIORCA --
	--------------

	if(phoneFunction.doesNumberHaveConversation(toNumber)) then
		triggerClientEvent(player, "phoneEvent.errorCall", player, 2)
		return
	end
	local rPhoneInfo = getPhoneItemFromNumber(toNumber)
	if(not rPhoneInfo) then
		triggerClientEvent(player, "phoneEvent.errorCall", player, 3)
		return
	end
	local target = exports.titan_login:getPlayerByCharID(rPhoneInfo.owner)
	if(not isElement(target)) then
		triggerClientEvent(player, "phoneEvent.errorCall", player, 2)
		return
	end

	if(phoneInfo.val1 == rPhoneInfo.val1) then
		triggerClientEvent(player, "phoneEvent.errorCall", player, 2)
		return
	end

	if(rPhoneInfo.used ~= 1) then
		triggerClientEvent(player, "phoneEvent.errorCall", player, 2)
		return
	end

	phoneUsers[player] = phoneInfo.val1
	phoneUsers[target] = rPhoneInfo.val1

	local index = phoneFunction.getID()

	phoneUsersIndex[player] = index
	phoneUsersIndex[target] = index

	phoneServer[index] = 
	{
		sender = phoneInfo.val1,
		target = rPhoneInfo.val1,
		senderPlayer = player,
		targetPlayer = target,
		callState = "calling",
		timer = setTimer(phoneFunction.timeCancel, 1000 * 30, 1, index)
	}
	setPedAnimation(player, "ped", "phone_in", 0, false)
	local contacts = phoneFunction.getPhoneContacts(rPhoneInfo.ID)
	triggerClientEvent(target, "phoneEvent.ringPhone", target, phoneInfo.val1, contacts)
	exports.titan_chats:sendPlayerLocalDoRadius(target, "Telefon rozbrzmiewa w kieszeni radosnym dźwiękiem dzwonka.", 10.0)

	local ringID = rPhoneInfo.val2
	if(not tonumber(ringID) or ringID <= 0) then ringID = 2 end
	triggerClientEvent("phoneEvent.ringOn", root, target, ringID)
end
addEvent("phoneFunction.startCall", true)
addEventHandler("phoneFunction.startCall", root, phoneFunction.startCall)

function phoneFunction.readMessage(player, messageID)
	exports.titan_db:query_free("UPDATE _phone_messages SET readmess = '1' WHERE ID = ?", messageID)
end
addEvent("phoneFunction.readMessage", true)
addEventHandler("phoneFunction.readMessage", root, phoneFunction.readMessage)

function phoneFunction.sendSMS(player, number, text)
	if(not exports.titan_login:isLogged(player)) then return end

	-------------
	-- NADAWCA --
	-------------

	local phoneInfo = getPlayerUsedPhoneInfo(player)
	if(not phoneInfo) then
			exports.titan_noti:showBox(player, "Nie posiadasz żadnego telefonu w użyciu.")
			triggerClientEvent(player, "phoneEvent.disableToggleSendMessage", player)
		return
	end

	--------------
	-- ODBIORCA --
	--------------

	local rPhoneInfo = getPhoneItemFromNumber2(number)
	if not rPhoneInfo then return exports.titan_noti:showBox(player, "Ten numer jest nieprawidłowy.") end

	exports.titan_db:query("INSERT INTO _phone_messages SET phoneID = ?, number = ?, timestamp = UNIX_TIMESTAMP(), content = ?, readmess = '0'", rPhoneInfo.ID, phoneInfo.val1, tostring(text))
	exports.titan_chats:sendPlayerLocalDoRadius(player, "Wysłano SMS.", 10.0)
	triggerClientEvent(player, "phoneEvent.disableToggleSendMessage", player)
	triggerClientEvent(player, "phoneEvent.sendMessageAnim", player)
	exports.titan_noti:showBox(player, "Wiadomość została wysłana.")
	local target = exports.titan_login:getPlayerByCharID(rPhoneInfo.owner)
	if rPhoneInfo.used == 1 then
		if isElement(target) then
			if getElementData(target, "phoneState") then
				local messages = phoneFunction.getPhoneMessages(rPhoneInfo.ID)
				triggerClientEvent(target, "phoneEvent.refreshMessages", target, messages)
			end
			exports.titan_chats:sendPlayerLocalDoRadius(target, "Otrzymano SMS.", 10.0)
			triggerClientEvent("phoneEvent.smsSound", target, target)
		end
	end
end
addEvent("phoneFunction.sendSMS", true)
addEventHandler("phoneFunction.sendSMS", root, phoneFunction.sendSMS)

function phoneFunction.timeCancel(index)
	if(type(phoneServer[index]) == "table") then
		local pServ = phoneServer[index]
		phoneUsers[pServ.senderPlayer] = nil
		phoneUsers[pServ.targetPlayer] = nil
		phoneUsersIndex[pServ.senderPlayer] = nil
		phoneUsersIndex[pServ.targetPlayer] = nil
		if(isTimer(pServ.timer)) then killTimer(pServ.timer) end
		phoneServer[index] = nil

		if(isElement(pServ.senderPlayer)) then
			triggerClientEvent(pServ.senderPlayer, "phoneEvent.errorCall", pServ.senderPlayer, 4)
			setPedAnimation(pServ.senderPlayer, "ped", "phone_out", 0, false)
		end
		if(isElement(pServ.targetPlayer)) then
			triggerClientEvent("phoneEvent.ringOff", pServ.targetPlayer, pServ.targetPlayer)
			triggerClientEvent(pServ.targetPlayer, "phoneEvent.cancelPhone", pServ.targetPlayer)
		end
	end
end

function phoneFunction.declineCall(player)
	local phoneNumber = phoneUsers[player]
	local index = phoneUsersIndex[player]
	if(type(phoneServer[index]) == "table") then
		local pServ = phoneServer[index]
		if(isElement(pServ.senderPlayer) and isElement(pServ.targetPlayer)) then
			if(pServ.callState == "calling") then
				triggerClientEvent("phoneEvent.ringOff", pServ.targetPlayer, pServ.targetPlayer)
				triggerClientEvent(pServ.senderPlayer, "phoneEvent.errorCall", pServ.senderPlayer, 2)
				setPedAnimation(pServ.senderPlayer, "ped", "phone_out", 0, false)
			end
			phoneUsers[pServ.senderPlayer] = nil
			phoneUsers[pServ.targetPlayer] = nil
			phoneUsersIndex[pServ.senderPlayer] = nil
			phoneUsersIndex[pServ.targetPlayer] = nil
			if(isTimer(pServ.timer)) then killTimer(pServ.timer) end
			phoneServer[index] = nil
		end
	end
end
addEvent("phoneFunction.declineCall", true)
addEventHandler("phoneFunction.declineCall", root, phoneFunction.declineCall)

function phoneFunction.cancelCall(player)
	local index = phoneUsersIndex[player]
	if(type(phoneServer[index]) == "table") then
		local pServ = phoneServer[index]
		if(isElement(pServ.targetPlayer)) then
			triggerClientEvent(pServ.targetPlayer, "phoneEvent.cancelPhone", pServ.targetPlayer)
			triggerClientEvent("phoneEvent.ringOff", pServ.targetPlayer, pServ.targetPlayer)
		end
		phoneUsers[pServ.senderPlayer] = nil
		phoneUsers[pServ.targetPlayer] = nil
		phoneUsersIndex[pServ.senderPlayer] = nil
		phoneUsersIndex[pServ.targetPlayer] = nil
		if(isTimer(pServ.timer)) then killTimer(pServ.timer) end
		phoneServer[index] = nil
	end
end
addEvent("phoneFunction.cancelCall", true)
addEventHandler("phoneFunction.cancelCall", root, phoneFunction.cancelCall)

function phoneFunction.acceptCall(player)
	local index = phoneUsersIndex[player]
	if(type(phoneServer[index]) == "table") then
		local pServ = phoneServer[index]
		if(isElement(pServ.senderPlayer) and isElement(pServ.targetPlayer)) then
			triggerClientEvent("phoneEvent.ringOff", pServ.targetPlayer, pServ.targetPlayer)

			triggerClientEvent(pServ.targetPlayer, "phoneEvent.turnCallOn", pServ.targetPlayer)
			triggerClientEvent(pServ.senderPlayer, "phoneEvent.turnCallOn", pServ.senderPlayer)

			setPedAnimation(pServ.targetPlayer, "ped", "phone_in", 0, false)

			setElementData(pServ.targetPlayer, "phoneCallElem", pServ.senderPlayer)
			setElementData(pServ.senderPlayer, "phoneCallElem", pServ.targetPlayer)
			if(isTimer(pServ.timer)) then killTimer(pServ.timer) end
			phoneServer[index].callState = "call"
		else
			if(isElement(pServ.senderPlayer)) then
				triggerClientEvent(pServ.senderPlayer, "phoneEvent.cancelPhone", pServ.targetPlayer)
			end
			if(isElement(pServ.targetPlayer)) then
				triggerClientEvent(pServ.targetPlayer, "phoneEvent.cancelPhone", pServ.targetPlayer)
				triggerClientEvent("phoneEvent.ringOff", pServ.targetPlayer, pServ.targetPlayer)
			end
		end
	end
end
addEvent("phoneFunction.acceptCall", true)
addEventHandler("phoneFunction.acceptCall", root, phoneFunction.acceptCall)

function phoneFunction.endCall(player)
	local index = phoneUsersIndex[player]
	if(type(phoneServer[index]) == "table") then
		local pServ = phoneServer[index]
		if(isElement(pServ.senderPlayer)) then
			triggerClientEvent(pServ.senderPlayer, "phoneEvent.errorCall", pServ.senderPlayer, 1)
			setPedAnimation(pServ.senderPlayer, "ped", "phone_out", 0, false)
		end
		if(isElement(pServ.targetPlayer)) then
			triggerClientEvent(pServ.targetPlayer, "phoneEvent.errorCall", pServ.targetPlayer, 1)
			setPedAnimation(pServ.targetPlayer, "ped", "phone_out", 0, false)
		end

		setElementData(pServ.targetPlayer, "phoneCallElem", false)
		setElementData(pServ.senderPlayer, "phoneCallElem", false)

		if(isTimer(pServ.timer)) then killTimer(pServ.timer) end
		phoneUsers[pServ.senderPlayer] = nil
		phoneUsers[pServ.targetPlayer] = nil
		phoneUsersIndex[pServ.senderPlayer] = nil
		phoneUsersIndex[pServ.targetPlayer] = nil
		phoneServer[index] = nil
		
	end
end
addEvent("phoneFunction.endCall", true)
addEventHandler("phoneFunction.endCall", root, phoneFunction.endCall)

function phoneFunction.deleteMessage(player, messageID)
	local phoneInfo = getPlayerUsedPhoneInfo(player)
	if(not phoneInfo) then
		exports.titan_noti:showBox(player, "Nie posiadasz żadnego telefonu w użyciu.")
		triggerClientEvent(player, "phoneEvent.turnOff", player)
		return
	end
	exports.titan_db:query("DELETE FROM _phone_messages WHERE ID = ?", messageID)
	exports.titan_noti:showBox(player, "Wiadomość usunięta pomyślnie.")
	local messages = phoneFunction.getPhoneMessages(phoneInfo.ID)
	triggerClientEvent(player, "phoneEvent.refreshMessages", player, messages)
end
addEvent("phoneFunction.deleteMessage", true)
addEventHandler("phoneFunction.deleteMessage", root, phoneFunction.deleteMessage)

function phoneFunction.saveNewContact(player, number, name)
	local phoneInfo = getPlayerUsedPhoneInfo(player)
	if(not phoneInfo) then
		exports.titan_noti:showBox(player, "Nie posiadasz żadnego telefonu w użyciu.")
		triggerClientEvent(player, "phoneEvent.turnOff", player)
		return
	end

	exports.titan_db:query("INSERT INTO _phone_contacts SET phoneID = ?, number = ?, name = ?", phoneInfo.ID, tonumber(number), name)
	exports.titan_noti:showBox(player, "Kontakt dodany pomyślnie.")
	local contacts = phoneFunction.getPhoneContacts(phoneInfo.ID, phoneInfo.val1)
	triggerClientEvent(player, "phoneEvent.refreshContacts", player, contacts)
end
addEvent("phoneFunction.saveNewContact", true)
addEventHandler("phoneFunction.saveNewContact", root, phoneFunction.saveNewContact)

function phoneFunctionGetPlayerNumber(player)
	if(tonumber(phoneUsers[player])) then return tonumber(phoneUsers[player]) else return false end
end