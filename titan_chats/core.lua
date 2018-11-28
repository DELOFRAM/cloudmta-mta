----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:53
-- Ostatnio zmodyfikowano: 2016-01-10 13:26:08
----------------------------------------------------

function onStart()
	for k, v in ipairs(getElementsByType("player")) do
		bindKey(v, "b", "down", "chatbox", "Say(OOC)")
		--outputConsole("To jest sprawdzenie")
	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function pJoin()
	bindKey(source, "b", "down", "chatbox", "Say(OOC)")
end
addEventHandler("onPlayerJoin", root, pJoin)

function turnOOCOn(player)
	if isElement(player) then
		triggerClientEvent(player, "oocFunc.turnChatOn", player)
	end
end

function sendPlayerLocalMessageRadius(player, message, radius, pronoun, me)
	--outputConsole("To jest sprawdzenie")
	if(me == nil) then me = true end
	if(not exports.titan_login:isLogged(player)) then return false end
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname = getPlayerICName(player)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				if not exports.titan_bw:doesPlayerHaveBW(v) then
					local tPX, tPY, tPZ = getElementPosition(v)
					local dist = getDistanceBetweenPoints3D(pX, pY, pZ, tPX, tPY, tPZ)
					if isPedInVehicle(player) and isPedInVehicle(v) and getPedOccupiedVehicle(player) == getPedOccupiedVehicle(v) then dist = 0 end
					local progress = dist / radius
					local r, g, b = interpolateBetween(230, 230, 230, 110, 110, 110, progress, "Linear")
					local newMessage = string.format("%s %s: %s", nickname, tostring(pronoun), message)
					if(not me and v == player) then else
						if not isPedInVehicle(v) or (isPedInVehicle(v) and getElementData(getPedOccupiedVehicle(v), "openWindows")) then
							--exports.titan_sampChat:sendMessage(v, "IC", newMessage, r, g, b)
							--outputChatBox(newMessage, v, r, g, b, false)
							sendPlayerChatMessage(v, newMessage, r, g, b, false)
						end
					end
				end
			end
		end
	end
end

function sendPlayerLocalMessageRadiusPosition(player, message, radius, position, dimension, interior, pronoun)
	if not exports.titan_login:isLogged(player) then return end
	local sphere = createColSphere(position, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local nickname = getPlayerICName(player)
	for k, v in ipairs(players) do
		if v:getInterior() == interior and v:getDimension() == dimension then
			if v:getData("loggedIn") == 1 then 
				local tPX, tPY, tPZ = getElementPosition(v)
				local dist = getDistanceBetweenPoints3D(position, tPX, tPY, tPZ)
				local progress = dist / radius
				local r, g, b = interpolateBetween(230, 230, 230, 110, 110, 110, progress, "Linear")
				local newMessage = string.format("%s %s: %s", nickname, tostring(pronoun), message)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 194, 162, 218)
				--outputChatBox(newMessage, v, 194, 162, 218, false)
				sendPlayerChatMessage(v, newMessage, 194, 152, 218, false)
			end
		end
	end
end

function sendPlayerOOCMessageRadius(player, message, radius)
	if(not exports.titan_login:isLogged(player)) then return false end

	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname = getPlayerICName(player)
	local playerID = player:getData("playerID")
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local tPX, tPY, tPZ = getElementPosition(v)
				local dist = getDistanceBetweenPoints3D(pX, pY, pZ, tPX, tPY, tPZ)
				local progress = dist / radius
				local r, g, b = interpolateBetween(230, 230, 230, 110, 110, 110, progress, "Linear")
				local newMessage = string.format("(( [%d] %s: %s ))", playerID, nickname, message)
				--outputChatBox(newMessage, v, r, g, b, false)
				if v:getData("sampChat") then
					sendPlayerChatMessage(v, newMessage, r, g, b, false)
				else
					addPlayerOOCMessage(v, newMessage, r, g, b)
					exports.titan_logs:playerLog(v, "chat", newMessage)
				end
				exports.titan_logs:playerLog(v, "chat", newMessage)
			end
		end
	end
end

function sendPlayerLocalMessageRadiusColor(player, message, radius, r, g, b, pronoun)
	if(not exports.titan_login:isLogged(player)) then return false end

	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname = getPlayerICName(player)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local newMessage = string.format("%s %s: %s", nickname, tostring(pronoun), message)
				--outputChatBox(newMessage, v, r, g, b, false)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, r, g, b)
				--outputChatBox(newMessage, v, r, g, b, false)
				sendPlayerChatMessage(v, newMessage, r, g, b, false)
			end
		end
	end
end

function sendPlayerLocalMeRadius(player, message, radius, isPlayer)
	if(not exports.titan_login:isLogged(player)) then return false end

	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname = getPlayerICName(player)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local newMessage = string.format("%s %s %s", isPlayer and "**" or "**", nickname, message)
				--outputChatBox(newMessage, v, 194, 162, 218, false)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 194, 162, 218)
				--outputChatBox(newMessage, v, 194, 162, 218, false)
				sendPlayerChatMessage(v, newMessage, 194, 162, 218, false)
			end
		end
	end
end

function sendPlayerLocalSprobujRadius(player, message, radius, isPlayer)
	if(not exports.titan_login:isLogged(player)) then return false end

	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname = getPlayerICName(player)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local newMessage = string.format("%s %s %s", isPlayer and "***" or "***", nickname, message)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 194, 162, 218)
				--outputChatBox(newMessage, v, 194, 162, 218, false)
				sendPlayerChatMessage(v, newMessage, 194, 162, 218, false)
			end
		end
	end
end

function sendPlayerLocalMeRadiusCash(player, target, radius)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(not exports.titan_login:isLogged(target)) then return false end
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname1 = getPlayerICName(player)
	local nickname2 = getPlayerICName(target)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local newMessage = string.format("** %s podaje trochę gotówki graczowi %s.", nickname1, nickname2)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 194, 162, 218)
				--outputChatBox(newMessage, v, 194, 162, 218, false)
				sendPlayerChatMessage(v, newMessage, 194, 162, 218, false)
			end
		end
	end
end

function sendPlayerLocalMessageID(player, target, radius)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(not exports.titan_login:isLogged(target)) then return false end
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)

	local nickname1 = getPlayerICName(player)
	local nickname2 = getPlayerICName(target)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local newMessage = string.format("** %s pokazał identyfikator graczowi %s.", nickname1, nickname2)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 194, 162, 218)
				--outputChatBox(newMessage, v, 194, 162, 218, false)
				sendPlayerChatMessage(v, newMessage, 194, 162, 218, false)
			end
		end
	end
end

function sendPlayerLocalDoRadius(player, message, radius)
	if(not exports.titan_login:isLogged(player)) then return false end

	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	local nickname = getPlayerICName(player)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local newMessage = string.format("** %s (( %s ))", message, nickname)
				--outputChatBox(newMessage, v, 154, 156, 205, false)
				--exports.titan_sampChat:sendMessage(v, "IC", newMessage, 154, 156, 205)
				--outputChatBox(newMessage, v, 154, 156, 205, false)
				sendPlayerChatMessage(v, newMessage, 154, 156, 205, false)
			end
		end
	end
end

function addStop(message)
	local interp = string.byte(message, string.len(message))
	if(interp ~= string.byte(".") and interp ~= string.byte("!") and interp ~= string.byte("?")) then
		message = string.format("%s.", message)
	end
	return message
end

function addPlayerOOCMessage(player, message, r, g, b)
	if isElement(player) then
		triggerClientEvent(player, "addOOCMessage", player, message, r, g, b)
	end
end

function firstToUpper(str)
	return (str:gsub("^%l", string.upper))
end

function playWhisperAudio(player)
	triggerClientEvent(player, "playWhisperAudio", player)
end

function playWhisperAudio2(player)
	triggerClientEvent(player, "playWhisperAudio2", player)
end

function getPlayerICName(player)
	if not exports.titan_login:isLogged(player) then return "Niezalogowany" end
	if exports.titan_admin:doesPlayerHaveAdminDuty(player) then return player:getData("globalName") end
	if player:getData("mask") then return "Nieznajomy "..player:getData("shortDNA") end
	if player:getData("lastname") == "" then return player:getData("name") end
	if player:getData("lastname") == nil then return player:getData("name") end
	if #player:getData("lastname") == 0 then return player:getData("name") end
	return player:getData("name").." "..player:getData("lastname")
end

addEvent("sendPlayerLocalMeRadius", true)
addEventHandler("sendPlayerLocalMeRadius", getRootElement(), sendPlayerLocalMeRadius)

function sendPlayerChatMessage(player, message, r, g, b, colorCoded)
	if player:getData("sampChat") then
		exports.titan_sampChat:sendMessage(player, "IC", message, r, g, b, colorCoded)
	else
		outputChatBox(message, player, r, g, b, colorCoded)
	end
	exports.titan_logs:playerLog(player, "chat", message)
end