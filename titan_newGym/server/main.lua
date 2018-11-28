----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local gymFunc = {}

function gymFunc.cmd(player, command, option)
	if not exports.titan_login:isLogged(player) then return end
	local can, groupID = gymFunc.isInPlace(player)
	if not can then return exports.titan_noti:showBox(player, "Nie jesteś w siłowni.") end
	if exports.titan_bw:doesPlayerHaveBW(player) then return exports.titan_noti:showBox(player, "Nie możesz ćwiczyć majac BW.") end
	option = string.lower(tostring(option))
	if not gymFunc.isPlayerHavePerm(player, groupID) then return exports.titan_noti:showBox(player, "Nie posiadasz ważnego karnetu do tej siłowni.") end
	if option == "bieznia" then
		if getElementData(player, "gym:training") then return exports.titan_noti:showBox(player, "Już trenujesz!") end
		local objectElement = gymFunc.getNearestObjectID(player, 2627, 2.0)
		if not objectElement then return exports.titan_noti:showBox(player, "Nie stoisz obok bieżni.") end
		if isElement(objectElement:getData("gym:active")) then return exports.titan_noti:showBox(player, "Ktoś ćwiczy na tym urzadzeniu.") end
		local treadmillPos = objectElement:getPosition()
		local treadmillRot = objectElement:getRotation()
		treadmillPos.z = treadmillPos.z + 0.5
		player:setPosition(treadmillPos)
		player:setRotation(treadmillRot)
		player:setFrozen(false)
		player:setAnimation("gymnasium", "gym_tread_jog", -1, true, true, false, true)
		exports.titan_noti:showBox(player, "Rozpoczałeś trening na bieżni. W ciagu 60 sekund odgrywaj akcję RP. Gdy czas dobiegnie konca, trening zostanie zakonczony.")
		setElementData(player, "gym:training", true)
		setElementData(objectElement, "gym:active", player)
		setElementData(player, "gym:object", objectElement)
		triggerClientEvent(player, "trainingFunc.start", player, objectElement)
	else
		exports.titan_noti:showBox(player, "TIP: /cwicz [bieznia]")
	end
end
addCommandHandler("cwicz", gymFunc.cmd, false, false)

function gymFunc.getNearestObjectID(player, objectID, distance)
	if not distance then distance = 3 end
	local element = nil
	local sphere = createColSphere(player:getPosition(), distance)
	local objects = getElementsWithinColShape(sphere, "object")
	destroyElement(sphere)
	for k, v in ipairs(objects) do
		local tempDistance = getDistanceBetweenPoints3D(v:getPosition(), player:getPosition())
		--outputChatBox(tempDistance)
		if  tempDistance < distance then
			distance = tempDistance
			element = v
		end
	end
	if isElement(element) then return element end
	return false
end

function gymFunc.isPlayerHavePerm(player, groupID)
	--if player then return true end
	local items = exports.titan_items:getPlayerItems(player)
	if not items then return false end
	local timestamp = getRealTime().timestamp
	for k, v in ipairs(items) do
		if v.type == 27 and tonumber(v.val1) == tonumber(groupID) then
			--outputDebugString("TEST?!")
			if tonumber(v.val2) and tonumber(timestamp) < tonumber(v.val2) then return true end
		end
	end
	return false
end

function gymFunc.isInPlace(player)
	local dimension = getElementDimension(player)
	if dimension == 0 then
		local sphereInfo = exports.titan_spheres:getPlayerZone(player)
		if not sphereInfo then return false end
		sphereInfo = exports.titan_spheres:getSphereInfo(sphereInfo)
		if not sphereInfo then return false end
		if not tonumber(sphereInfo.intID) or sphereInfo.intID == 0 then return false end
		local doorInfo = exports.titan_doors:getDoorInfo(sphereInfo.intID)
		if not doorInfo then return false end
		if doorInfo.ownerType ~= 2 then return false end
		if not exports.titan_orgs:doesGroupHavePerm(doorInfo.owner, "gym") then return false end
		return true, doorInfo.owner
	else
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dimension)
		if not doorInfo then return false end
		if doorInfo.ownerType ~= 2 then return false end
		if not exports.titan_orgs:doesGroupHavePerm(doorInfo.owner, "gym") then return false end
		return true, doorInfo.owner
	end
end

function gymFunc.addStrength(player, addStrength)
	local strength = getElementData(player, "strength")
	if not strength then strength = 10 end
	strength = strength + addStrength
	if strength > 100 then strength = 100 end
	setElementData(player, "strength", strength)
	exports.titan_db:query_free("UPDATE _characters SET `strength` = ? WHERE ID = ?", strength, getElementData(player, "charID"))
end

function gymFunc.addCondition(player, addCondition)
	local condition = getElementData(player, "condition")
	if not condition then condition = 10 end
	condition = condition + addCondition
	if condition > 100 then condition = 100 end
	setElementData(player, "condition", condition)
	exports.titan_db:query_free("UPDATE _characters SET `condicion` = ? WHERE ID = ?", condition, getElementData(player, "charID"))
end

function gymFunc.treadMillStop()
	source:setAnimation("gymnasium", "gym_tread_getoff", -1, false, true, true, false)
	removeElementData(source, "gym:training")

	local condition = getElementData(source, "condition")
	if not condition then condition = 10 end
	local different = 100 - condition
	if different > 0 then
		local newCondition = different * 0.005
		gymFunc.addCondition(source, newCondition)
		exports.titan_noti:showBox(source, string.format("Trening powiększył Ci ilość siły o %0.3f%%!", newCondition))
	end
	local obj = getElementData(source, "gym:object")
	if isElement(obj) then
		removeElementData(obj, "gym:active")
	end
	removeElementData(source, "gym:object")
end
addEvent("gymFunc.treadMillStop", true)
addEventHandler("gymFunc.treadMillStop", root, gymFunc.treadMillStop)

function gymFunc.onWasted()
	if source:getData("gym:training") then
		exports.titan_noti:showBox(source, "Trening został przerwany.")
		triggerClientEvent(source, "trainingFunc.stop", source)
		removeElementData(source, "gym:training")
		source:setAnimation()

		local obj = getElementData(source, "gym:object")
		if isElement(obj) then
			removeElementData(obj, "gym:active")
		end
		removeElementData(source, "gym:object")
	end
end
addEventHandler("onPlayerWasted", root, gymFunc.onWasted)
addEventHandler("onPlayerDamage", root, gymFunc.onWasted)

addEvent("gymFunc.onWasted", true)
addEventHandler("gymFunc.onWasted", root, gymFunc.onWasted)