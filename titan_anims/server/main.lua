----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local animData = {}
local blockedAnims = {}
blockedAnims["idz1"] = true
blockedAnims["idz2"] = true
blockedAnims["idz3"] = true
blockedAnims["idz4"] = true
blockedAnims["idz5"] = true
blockedAnims["idz6"] = true
blockedAnims["idz7"] = true
blockedAnims["idz8"] = true
blockedAnims["idz9"] = true
blockedAnims["pijak"] = true
blockedAnims["skradajsie"] = true

function loadAnimations()
	local time = getTickCount()
	animData = exports.titan_db:query("SELECT * FROM _anims")
	outputDebugString(string.format("[ANIMS] Załadowano animacje. (%d) | %d ms", #animData, getTickCount() - time))
end
addEventHandler("onResourceStart", resourceRoot, loadAnimations)

function getAnimInfo(animName)
	for k, v in ipairs(animData) do
		if string.lower(v.name) == string.lower(animName) then return v end
	end
	return false
end

function playerStartAnim(player, animName)
	if not exports.titan_login:isLogged(player) then return end
	if isTimer(player:getData("taserTimer")) then return end
	if isElement(player:getData("cuffedBy")) then return exports.titan_noti:showBox(player, "Nie możesz włączać animacji będąc skutym.") end
	if getElementData(player, "gym:training") then return exports.titan_noti:showBox(player, "Nie możesz włączać animacji będąc w trakcie treningu.") end
	local animInfo = getAnimInfo(animName)
	if not animInfo then return end
	player:setData("anim:state", true)
	player:setData("anim:startPos", player:getPosition())
	player:setData("anim:info", animInfo)
	setPedAnimation(player, animInfo.animlib, animInfo.animname, -1, animInfo.loop == 1 and true or false, animInfo.updatepos == 1 and true or false, animInfo.interruptable == 1 and true or false, animInfo.freeze == 1 and true or false)
	local x, y, z = getElementPosition(player)
	triggerClientEvent(player, "onAnimStarted", player, {x, y, z}, animInfo)
	--setElementCollisionsEnabled(player, false) #Buguje
end
addEvent("playerStartAnim", true)
addEventHandler("playerStartAnim", root, playerStartAnim)

function playerStopAnim(player)
	if not exports.titan_login:isLogged(player) then return end
	if isTimer(player:getData("taserTimer")) then return end
	if isElement(player:getData("cuffedBy")) then return end
	if getElementData(player, "gym:training") then return exports.titan_noti:showBox(player, "Nie możesz włączać animacji będąc w trakcie treningu.") end
	player:removeData("anim:state", true)
	player:removeData("anim:startPos", player:getPosition())
	player:removeData("anim:info", animInfo)
	setPedAnimation (player, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)
	triggerClientEvent(player, "onAnimStopped", player)
	--setElementCollisionsEnabled(player, true) #Buguje
end
addEvent("playerStopAnim", true)
addEventHandler("playerStopAnim", root, playerStopAnim)

function cmdAnims(player)
	if not exports.titan_login:isLogged(player) then return end
	if exports.titan_bw:doesPlayerHaveBW(player) then return end
	if #animData == 0 then return exports.titan_noti:showBox(player, "Nie znaleziono żadnych animacji w bazie danych.") end
	local anims = {}
	for k,v in ipairs(animData) do
		if not blockedAnims[v.name] then
			table.insert(anims, v)
		end
	end
	triggerClientEvent(player, "animGui.create", player, anims)
end
addCommandHandler("anims", cmdAnims, false, false)
addCommandHandler("anim", cmdAnims, false, false)