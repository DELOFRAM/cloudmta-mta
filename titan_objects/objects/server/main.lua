----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

objectData = {}
local objectIndex = {}
objectEngine = {}

local objectTable = {[4030]=true, [1]=true, [393]=true, [17941]=true, [1225]=true, [14708]=true, [4103]=true, [4141]=true, [14706]=true, [14776]=true, [6189]=true, [14581]=true, [3112]=true, [2218]=true}

function objectEngine.loadObjects()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM `_objects`")
	if(#query > 0) then
		local i = 1
		for k, v in ipairs(query) do
			v.object = createObject(v.model, v.x, v.y, v.z, v.rx, v.ry, v.rz)
			if(isElement(v.object)) then
				setElementInterior(v.object, v.interior)
				setElementDimension(v.object, v.dimension)

				setElementData(v.object, "objectID", v.ID)
				v.object:setData("isObject", true)
				v.object:setData("isGate", v.isGate == 1 and true or false)
				v.object:setData("gatePos", {v.gx, v.gy, v.gz, v.grx, v.gry, v.grz})
				v.object:setData("closePos", {v.x, v.y, v.z, v.rx, v.ry, v.rz})
				v.object:setData("gateTime", v.gAnimTime)
				v.object:setData("gateRange", v.gRange)
				v.object:setData("gateState", false)
				v.object:setData("ownerType", v.ownerType)
				v.object:setData("owner", v.owner)

				if v.texData then
					v.texData = fromJSON(v.texData)
					if type(v.texData) ~= "table" then v.texData = {} end
				else
					v.texData = {}
				end
				setElementData(v.object, "textures:data", v.texData)

				for k1, v1 in pairs(v.texData) do
					local tName, tID = unpack(v1)
					if tName and tID then
						triggerClientEvent("setObjectTexture", v.object, v.object, v1.tName, v1.tID)
					end
				end
			end
			objectIndex[v.ID] = i
			objectData[i] = v
			i = i + 1
		end
	end
	outputDebugString(string.format("[OBJECTS] Zaladowano obiekty (%d). | %d ms", #query, getTickCount() - time))
	exports.titan_bus:busLoad()
end
addEventHandler("onResourceStart", resourceRoot,
	function()
		setTimer(objectEngine.loadObjects, 500, 1)
	end
)

function objectEngine.getDimensionObjects(dimension)
	local objTable = {}
	for k, v in pairs(objectData) do
		if v and v.dimension == dimension then
			table.insert(objTable, v)
		end
	end
	if #objTable == 0 then return false end
	return objTable
end
getDimensionObjects = objectEngine.getDimensionObjects

function objectEngine.getFreeIndex()
	local i = 1
	while(true) do
		if(type(objectData[i]) ~= "table") then return i end
		i = i + 1
	end
	return false
end

function objectEngine.objectInfo(objID)
	local index = objectIndex[objID]
	if(not tonumber(index)) then return false end
	if(type(objectData[index]) ~= "table") then return false end
	return objectData[index]
end

function cmdoEdit(player, command, arg1)
	if(not exports.titan_login:isLogged(player)) then return end
	if(not tonumber(arg1)) then
		exports.titan_noti:showBox(player, "TIP: /oe [ID obiektu]")
		return
	end
	arg1 = tonumber(arg1)
	local objectInfo = objectEngine.objectInfo(arg1)
	if(not objectInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego obiektu.")
		return
	end
	local editBy = getElementData(objectInfo.object, "object:editBy")
	if isElement(editBy) and getElementType(editBy) == "player" and editBy ~= player then
		return exports.titan_noti:showBox(player, "Inny gracz edytuje już ten obiekt.")
	end
	local perm, err, limit = getPlayerPermToCreateObject(player, true)
	if not perm then
		if err == 1 then
			return exports.titan_noti:showBox(player, "Nie masz uprawnień do stawiania obiektów w tym miejscu.")
		elseif err == 2 then
			--exports.titan_noti:showBox(player, "Wykorzystałeś maksymalny limit obiektów ("..limit..").")
		else
			return exports.titan_noti:showBox(player, "Wystąpił błąd podczas tworzenia obiektu (ERROR CODE: 216). Powiadom administratora o zajściu.")
		end
	end
	local polygon = nil
	if objectInfo.ownerType == -1 then
		local sphereInfo = exports.titan_spheres:getSphereInfo(objectInfo.owner)
		if sphereInfo then
			polygon = sphereInfo.polygon
		end
	end
	triggerClientEvent(player, "editor.serverObjectEdit", player, objectInfo.object, polygon)
	setElementData(objectInfo.object, "object:editBy", player)

end
addCommandHandler("oe", cmdoEdit, false, false)

function cmdOFind(player, command, arg)
	if(not exports.titan_login:isLogged(player)) then return end
	if(not tonumber(arg)) then
		exports.titan_noti:showBox(player, "TIP: /ofind [UID modelu]")
		return
	end
	arg = tonumber(arg)
	local sphere = createColSphere(player:getPosition(), 50.0)
	local objects = getElementsWithinColShape(sphere, "object")
	destroyElement(sphere)
	local object = nil
	local distance = 50.0
	for k, v in ipairs(objects) do
		if v:getInterior() == player:getInterior() and v:getDimension() == player:getDimension() and v:getData("isObject") and v:getModel() == arg then
			local dist = getDistanceBetweenPoints3D(player:getPosition(), v:getPosition())
			if dist < distance then
				distance = tonumber(dist)
				object = v
			end
		end
	end
	if not isElement(object) then
		return exports.titan_noti:showBox(player, "Nie znaleziono obiektu o takim ID.")
	end
	local objectInfo = objectEngine.objectInfo(object:getData("objectID"))
	if(not objectInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego obiektu.")
		return
	end
	local editBy = getElementData(objectInfo.object, "object:editBy")
	if isElement(editBy) and getElementType(editBy) == "player" and editBy ~= player then
		return exports.titan_noti:showBox(player, "Inny gracz edytuje już ten obiekt.")
	end
	local perm, err, limit = getPlayerPermToCreateObject(player, true)
	if not perm then
		if err == 1 then
			return exports.titan_noti:showBox(player, "Nie masz uprawnień do stawiania obiektów w tym miejscu.")
		elseif err == 2 then
			--exports.titan_noti:showBox(player, "Wykorzystałeś maksymalny limit obiektów ("..limit..").")
		else
			return exports.titan_noti:showBox(player, "Wystąpił błąd podczas tworzenia obiektu (ERROR CODE: 217). Powiadom administratora o zajściu.")
		end
	end
	local polygon = nil
	if objectInfo.ownerType == -1 then
		local sphereInfo = exports.titan_spheres:getSphereInfo(objectInfo.owner)
		if sphereInfo then
			polygon = sphereInfo.polygon
		end
	end
	triggerClientEvent(player, "editor.serverObjectEdit", player, objectInfo.object, polygon)
	setElementData(objectInfo.object, "object:editBy", player)
end
addCommandHandler("ofind", cmdOFind, false, false)

function objectEngine.objectEdit(player, objectID)
	local objectInfo = objectEngine.objectInfo(objectID)
	if(not objectInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego obiektu.")
		return
	end
	local editBy = getElementData(objectInfo.object, "object:editBy")
	if isElement(editBy) and getElementType(editBy) == "player" and editBy ~= player then
		return exports.titan_noti:showBox(player, "Inny gracz edytuje już ten obiekt.")
	end
	local perm, err, limit = getPlayerPermToCreateObject(player, true)
	if not perm then
		if err == 1 then
			exports.titan_noti:showBox(player, "Nie masz uprawnień do stawiania obiektów w tym miejscu.")
		elseif err == 2 then
			exports.titan_noti:showBox(player, "Wykorzystałeś maksymalny limit obiektów ("..limit..").")
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd podczas tworzenia obiektu (ERROR CODE: 216). Powiadom administratora o zajściu.")
		end
		return
	end
	local polygon = nil
	if objectInfo.ownerType == -1 then
		local sphereInfo = exports.titan_spheres:getSphereInfo(objectInfo.owner)
		if sphereInfo then
			polygon = sphereInfo.polygon
		end
	end
	triggerClientEvent(player, "editor.serverObjectEdit", player, objectInfo.object, polygon)
	setElementData(objectInfo.object, "object:editBy", player)
end
addEvent("objectEngine.objectEdit", true)
addEventHandler("objectEngine.objectEdit", root, objectEngine.objectEdit)

function cmdOStworz(player, command, arg1)
	if not arg1 then
		exports.titan_noti:showBox(player, "TIP: /oc [ID obiektu/ edytor]")
		return
	end

	--[[if not player:getData("Zone") and not exports.titan_admin:doesPlayerHaveAdminDuty(player) then
		exports.titan_noti:showBox(player, "Nie jesteś w żadnej strefie budowania.")
		return
	end]]

	--[[if player:getData("Zone") and not exports.titan_admin:doesPlayerHaveAdminDuty(player) then
		if player:getData("Zone").ownerType == 1 and player:getData("Zone").owner ~= player:getData("charID") then
			exports.titan_noti:showBox(player, "Nie jesteś włascicelem tej strefy.")
			return
		elseif player:getData("Zone").ownerType == 2 then 
			if exports.titan_orgs:doesPlayerHaveGroup(player, player:getData("Zone").owner ) then
				exports.titan_noti:showBox(player, "Nie należysz do tej grupy.")
				return
			end

				if not exports.titan_orgs:doesPlayerHavePerm(player, player:getData("Zone").owner, "bulding") then
				exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do budowania na tej strefie.")
				return
			end		
		end
	end]]

	if arg1 == "edytor" then
		triggerClientEvent(player, "editor.createObjectGUI", player)
	else
		local perm, err, limit = getPlayerPermToCreateObject(player)
		if not perm then
			if err == 1 then
				exports.titan_noti:showBox(player, "Nie masz uprawnień do stawiania obiektów w tym miejscu.")
			elseif err == 2 then
				exports.titan_noti:showBox(player, "Wykorzystałeś maksymalny limit obiektów ("..limit..").")
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd podczas tworzenia obiektu (ERROR CODE: 216). Powiadom administratora o zajściu.")
			end
			return
		end
		arg1 = tonumber(arg1)

		if objectTable[arg1] then 
			exports.titan_noti:showBox(player, "Nie możesz stworzyć tego obiekty.") 
	    	return 
		end

		local x, y, z = getElementPosition(player)
		x, y = getXYInFrontOfPlayer(player, 3)
	
		local object = createObject(arg1, x, y, z)
		if not isElement(object) then
			exports.titan_noti:showBox(player, "Podano niepoprawne ID obiektu.")
			destroyElement(object)
			return
		end

		local sphereID = exports.titan_spheres:getPlayerZone(player)

		local ownerType = getElementDimension(player) == 0 and (tonumber(sphereID) and -1 or 0) or 1
		local owner = getElementDimension(player) == 0 and (tonumber(sphereID) and sphereID or 0) or player:getData("charID")
		setElementDimension(object, getElementDimension(player))
		setElementInterior(object, getElementInterior(player))
		local res, rows, lastID = exports.titan_db:query("INSERT INTO `_objects` SET `model` = ?, `x` = ?, `y` = ?, `z` = ?, `interior` = ?, `dimension` = ?, ownerType = ?, owner = ?", arg1, x, y, z, getElementInterior(player), getElementDimension(player), ownerType, owner)
		setElementData(object, "objectID", lastID)
		setElementData(object, "isObject", true)
		setElementData(object, "ownerType", ownerType)
		setElementData(object, "owner", owner)
		exports.titan_noti:showBox(player, string.format("Stworzono obiekt o ID: %d.", lastID))
	
		local freeIndex = objectEngine.getFreeIndex()
		objectData[freeIndex] =
		{
			ID = lastID,
			model = arg1,
			ownerType = ownerType,
			owner = owner,
			x = x,
			y = y,
			z = z,
			rx = 0,
			ry = 0,
			rz = 0,
			interior = getElementInterior(player),
			dimension = getElementDimension(player),
			object = object
		}
		objectIndex[lastID] = freeIndex
		local polygon = nil
		if objectData[freeIndex].ownerType == -1 then
			local sphereInfo = exports.titan_spheres:getSphereInfo(objectData[freeIndex].owner)
			if sphereInfo then
				polygon = sphereInfo.polygon
			end
		end
		triggerClientEvent(player, "editor.serverObjectEdit", player, object, polygon)
		setElementData(object, "object:editBy", player)
	end
end
addCommandHandler("oc", cmdOStworz, false, false)

function getPlayerPermToCreateObject(player, isEdit)
	if exports.titan_admin:doesPlayerHaveAdminDuty(player) and exports.titan_admin:doesAdminHavePerm(player, "objects") then return true end
	local vw = getElementDimension(player)
	if vw == 0 then
		local playerZone = exports.titan_spheres:getPlayerZone(player)
		if not playerZone then
			return false, 1
		end
		--exports.titan_chats:sendPlayerChatMessage(player, "Test", 255, 255, 255, false)
		if exports.titan_spheres:doesSphereHasFlag(playerZone, "object") then
			if exports.titan_spheres:doesOwnerHasPerm(playerZone, 1, player:getData("charID")) then
				if not isEdit then
					local query = exports.titan_db:query("SELECT COUNT(*) AS rows FROM _objects WHERE ownerType = -1 AND owner = ?", playerZone)
					if query[1].rows >= exports.titan_spheres:getSphereMaxObjects(playerZone) then
						return false, 2, query[1].rows
					end
				end
				return true
			else
				local playerDuty = exports.titan_orgs:getPlayerDuty(player)
				if not playerDuty then return false, 1 end
				if exports.titan_spheres:doesOwnerHasPerm(playerZone, 2, playerDuty) then
					if not isEdit then
						local query = exports.titan_db:query("SELECT COUNT(*) AS rows FROM _objects WHERE ownerType = -1 AND owner = ?", playerZone)
						if query[1].rows >= exports.titan_spheres:getSphereMaxObjects(playerZone) then
							return false, 2, query[1].rows
						end
					end
					return true
				end
			end
		end
		return false, 1
	else
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(vw)
		if doorInfo then
			if doorInfo.ownerType == 1 then
				if doorInfo.owner == player:getData("charID") then
					local query = exports.titan_db:query("SELECT COUNT(*) AS rows FROM _objects WHERE dimension = ?", doorInfo.dimension)
					if query[1].rows >= doorInfo.objectsLimit then
						return false, 2, query[1].rows
					end
					return true
				else
					return false, 1
				end
			elseif doorInfo.ownerType == 2 then
				if exports.titan_orgs:doesPlayerHavePerm(player, doorInfo.owner, "objects") then
					local query = exports.titan_db:query("SELECT COUNT(*) AS rows FROM _objects WHERE dimension = ?", doorInfo.dimension)
					if query[1].rows >= doorInfo.objectsLimit then
						return false, 2, query[1].rows
					end
					return true
				else
					return false, 1
				end
			end
		end
	end
	return false, 1
end

function createObjectPanel(player, arg1, x, y, z)
	if not getPlayerPermToCreateObject(player) then return exports.titan_noti:showBox(player, "Nie masz uprawnień do stawiania obiektów w tym miejscu.") end
	local object = createObject(arg1, x, y, z)
	if not isElement(object) then
		exports.titan_noti:showBox(player, "Podano niepoprawne ID obiektu.")
		return
	end
	local ownerType = getElementDimension(player) == 0 and -1 or 1
	local owner = getElementDimension(player) == 0 and exports.titan_spheres:getPlayerZone(player) or player:getData("charID")
	setElementDimension(object, getElementDimension(player))
	setElementInterior(object, getElementInterior(player))
	local res, rows, lastID = exports.titan_db:query("INSERT INTO `_objects` SET `model` = ?, `x` = ?, `y` = ?, `z` = ?, `interior` = ?, `dimension` = ?, ownerType = ?, owner = ?", arg1, x, y, z, getElementInterior(player), getElementDimension(player), ownerType, owner)
	setElementData(object, "objectID", lastID)
	setElementData(object, "isObject", true)
	setElementData(object, "ownerType", 0)
	setElementData(object, "owner", 0)
	exports.titan_noti:showBox(player, string.format("Stworzono obiekt o ID: %d.", lastID))

	local freeIndex = objectEngine.getFreeIndex()
	objectData[freeIndex] =
	{
		ID = lastID,
		model = arg1,
		ownerType = ownerType,
		owner = owner,
		x = x,
		y = y,
		z = z,
		rx = 0,
		ry = 0,
		rz = 0,
		interior = getElementInterior(player),
		dimension = getElementDimension(player),
		object = object
	}
	objectIndex[lastID] = freeIndex
end
addEvent("createPanelObject", true)
addEventHandler("createPanelObject", root, createObjectPanel)



function cmdODel(player, command, id)
	if not id then return exports.titan_noti:showBox(player, "/odel [ID obiektu]") end

	local objectInfo = objectEngine.objectInfo(tonumber(id))
	if(not objectInfo) then return exports.titan_noti:showBox(player, "Nie znaleziono takiego obiektu.") end
	if (objectInfo.ownerType == 1 and objectInfo.owner ~= getElementData(player, "memberID")) or not exports.titan_admin:doesAdminHavePerm(player, "objects") or not isPlayerHavePermissionToGate(player, objectInfo.object)then return exports.titan_noti:showBox(player, "Nie jesteś właścicielem tego obiektu") end
	objectEngine.delObject(tonumber(id))
	exports.titan_noti:showBox(player, string.format("Pomyślnie usunięto obiekt o UID: (%d)", id))
end
addCommandHandler("odel", cmdODel)

function objCreate(model, ownerType, owner, x, y, z, rx, ry, rz, interior, dimension)
	local object = createObject(model, x, y, z, rx, ry, rz)
	if isElement(object) then
		setElementDimension(object, dimension)
		setElementInterior(object, interior)
		local res, rows, lastID = exports.titan_db:query("INSERT INTO `_objects` SET `model` = ?, `x` = ?, `y`= ?, `z` = ?, `rx` = ?, `ry` = ?, `rz` = ?, `interior` = ?, `dimension` = ?, `ownerType` = ?, `owner` = ?", model, x, y, z, rx, ry, rz, interior, dimension, ownerType, owner)

		setElementData(object, "objectID", lastID)
		setElementData(object, "isObject", true)
		setElementData(object, "ownerType", ownerType)
		setElementData(object, "owner", owner)
		local freeIndex = objectEngine.getFreeIndex()
		objectData[freeIndex] =
		{
			ID = lastID,
			model = model,
			ownerType = ownerType,
			owner = owner,
			x = x,
			y = y,
			z = z,
			rx = rx,
			ry = ry,
			rz = rz,
			interior = interior,
			dimension = dimension,
			object = object,
			texData = {}
		}
		objectIndex[lastID] = freeIndex
	end
end

function objectEngine.saveObject(objID, x, y, z, rx, ry, rz)
	local objectInfo = objectEngine.objectInfo(objID)
	if(not objectInfo) then return end
	objectInfo.x = x
	objectInfo.y = y
	objectInfo.z = z
	objectInfo.rx = rx
	objectInfo.ry = ry
	objectInfo.rz = rz

	if isElement(objectInfo.object) then
		setElementPosition(objectInfo.object, x, y, z)
		setElementRotation(objectInfo.object, rx, ry, rz)
		objectInfo.object:setData("isGate", false)
	end

	exports.titan_db:query("UPDATE `_objects` SET `x` = ?, `y` = ?, `z` = ?, `rx` = ?, `ry` = ?, `rz` = ?, `gx` = 0, `gy` = 0, `gz` = 0, `grx` = 0, `gry` = 0, `grz` = 0, `isGate` = 0, `gAnimTime` = '0', `gRange` = '0' WHERE `ID` = ?", x, y, z, rx, ry, rz, objID)
end
addEvent("saveObject", true)
addEventHandler("saveObject", root, objectEngine.saveObject)

function getObjectInfo(objID)
	local objectInfo = objectEngine.objectInfo(objID)
	if not objectInfo then return false end
	return objectInfo
end

function objectEngine.delObject(objID)
	local objectInfo = objectEngine.objectInfo(objID)
	if(not objectInfo) then return end
	exports.titan_db:query("DELETE FROM `_objects` WHERE `ID` = ?", objectInfo.ID)
	if objectInfo.object:getData("isBus") then
		local busData = objectInfo.object:getData("busID")
		if tonumber(busData) then exports.titan_bus:busRemove(tonumber(busData)) end
	end
	if isElement(objectInfo.object) then destroyElement(objectInfo.object) end
	objectData[objectIndex[objID]] = false
	objectIndex[objID] = false
end
addEvent("delObject", true)
addEventHandler("delObject", root, objectEngine.delObject)
delObject = objectEngine.delObject

function objectEngine.changeObjectOwner(objID, ownerType, owner)
	local objectInfo = objectEngine.objectInfo(objID)
	if not objectInfo then return end

	if isElement(objectInfo.object) then
		objectInfo.object:setData("ownerType", ownerType)
		objectInfo.object:setData("owner", owner)
	end

	objectInfo.ownerType = ownerType
	objectInfo.owner = owner
	exports.titan_db:query_free("UPDATE `_objects` SET `ownerType` = ?, `owner` = ? WHERE `ID` = ?", ownerType, owner, objID)
end
changeObjectOwner = objectEngine.changeObjectOwner

function objectEngine.createGate(objID, closePos, openPos, time, range)
	if not range or range > 10 or range < 0 then range = 10 end
	if not time or not tonumber(time) or time < 0 or time > 5000 then time = 2000 end
	local objectInfo = objectEngine.objectInfo(objID)
	if(not objectInfo) then return end

	if isElement(objectInfo.object) then
		for k, v in pairs(closePos) do
			if not tonumber(v) then v = 0 end
		end
		for k, v in pairs(openPos) do
			if not tonumber(v) then v = 0 end
		end
		objectInfo.object:setData("isGate", true)
		objectInfo.object:setData("isObject", true)
		objectInfo.object:setData("gateState", false)
		
		objectInfo.object:setData("gatePos", {openPos.X, openPos.Y, openPos.Z, openPos.rX, openPos.rY, openPos.rZ})
		objectInfo.object:setData("closePos", {closePos.X, closePos.Y, closePos.Z, closePos.rX, closePos.rY, closePos.rZ})
		objectInfo.object:setData("gateRange", range)
		objectInfo.object:setData("gateTime", time)

		objectInfo.object:setPosition(closePos.X, closePos.Y, closePos.Z)
		objectInfo.object:setRotation(closePos.rX, closePos.rY, closePos.rZ)
		objectInfo.x = closePos.X
		objectInfo.y = closePos.Y
		objectInfo.z = closePos.Z
		objectInfo.rx = closePos.rX
		objectInfo.ry = closePos.rY
		objectInfo.rz = closePos.rZ
		exports.titan_db:query("UPDATE `_objects` SET `x` = ?, `y` = ?, `z` = ?, `rx` = ?, `ry` = ?, `rz` = ?, `gx` = ?, `gy` = ?, `gz` = ?, `grx` = ?, `gry` = ?, `grz` = ?, `gAnimTime` = ?, `gRange` = ?, `isGate` = 1 WHERE `ID` = ?", closePos.X, closePos.Y, closePos.Z, closePos.rX, closePos.rY, closePos.rZ, openPos.X, openPos.Y, openPos.Z, openPos.rX, openPos.rY, openPos.rZ, time, range, objID)
	end
end
addEvent("objectEngine.createGate", true)
addEventHandler("objectEngine.createGate", root, objectEngine.createGate)

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad(-rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z
end

function isPlayerHavePermissionToGate(player, object)
	if not exports.titan_login:isLogged(player) then return false end
	if not isElement(object) then return false end
	if exports.titan_admin:isPlayerAdmin(player) then return true end
	if object:getDimension() == 0 then
		if object:getData("ownerType") == 1 then
			if object:getData("owner") == player:getData("charID") then return true end
		elseif object:getData("ownerType") == 2 then
			if exports.titan_orgs:doesPlayerHavePerm(player, object:getData("owner"), "gates") then return true end
		elseif object:getData("ownerType") == -1 then
			if exports.titan_spheres:doesOwnerHasPerm(object:getData("owner"), 1, player:getData("charID")) then return true end
			local playerDuty = exports.titan_orgs:getPlayerDuty(player)
			if tonumber(playerDuty) then
				if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "gates") then return false end
				if exports.titan_spheres:doesOwnerHasPerm(object:getData("owner"), 2, playerDuty) then return true end
			end
		end
	else
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(object:getDimension())
		if not doorInfo then return false end
		if doorInfo.ownerType == 1 then
			if doorInfo.owner == player:getData("charID") then return true end
		elseif doorInfo.ownerType == 2 then
			if exports.titan_orgs:doesPlayerHavePerm(player, doorInfo.owner, "gates") then return true end
		end
	end
	return false
end

function tmpGate(player)
	local x, y, z = getElementPosition(player)
	local sphere = createColSphere(x, y, z, 10.0)
	local objects = getElementsWithinColShape(sphere, "object")
	local int, vw = getElementInterior(player), getElementDimension(player)
	destroyElement(sphere)
	for k, v in ipairs(objects) do
		if v:getInterior() == int and v:getDimension() == vw then
			if v:getData("isObject") and v:getData("isGate") then
				local oX, oY, oZ = getElementPosition(v)
				if getDistanceBetweenPoints3D(x, y, z, oX, oY, oZ) < v:getData("gateRange") then
					if isPlayerHavePermissionToGate(player, v) then
						if v:getData("gateState") then
							v:setData("gateState", false)
							local data = v:getData("closePos")
							triggerClientEvent("gFunc.new", player, v, data, v:getData("gateTime"))
							if isTimer(v:getData("gateTimer")) then
								killTimer(v:getData("gateTimer"))
							end
							local timer = setTimer(objectEngine.setPos, v:getData("gateTime") + 500, 1, v, data)
							v:setData("gateTimer", timer)
						else
							v:setData("gateState", true)
							local data = v:getData("gatePos")
							triggerClientEvent("gFunc.new", player, v, data, v:getData("gateTime"))
							if isTimer(v:getData("gateTimer")) then
								killTimer(v:getData("gateTimer"))
							end
							local timer = setTimer(objectEngine.setPos, v:getData("gateTime") + 500, 1, v, data)
							v:setData("gateTimer", timer)
						end
					else
						exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do tej bramy.")
					end
				end
			end
		end
	end
end
addCommandHandler("gate", tmpGate, false, false)
addCommandHandler("brama", tmpGate, false, false)

function objectEngine.setObjectTexture(objID, texName, texID)
	local objectInfo = getObjectInfo(objID)
	if not objectInfo then return end

	if isElement(objectInfo.object) then
		local texData = getElementData(objectInfo.object, "textures:data")
		if type(texData) == "table" then
			for k, v in ipairs(texData) do
				local tName, tID = unpack(v)
				if tostring(texName) == tostring(tName) then
					table.remove(texData, k)
					triggerClientEvent("removeObjectTexture", objectInfo.object, objectInfo.object, tName)
					break
				end
			end
		else
			texData = {}
		end

		table.insert(texData, {texName, texID})
		setElementData(objectInfo.object, "textures:data", texData)
		triggerClientEvent("setObjectTexture", objectInfo.object, objectInfo.object, texName, texID)
		exports.titan_db:query_free("UPDATE _objects SET texData = ? WHERE ID = ?", toJSON(texData), objectInfo.ID)
	end
end
addEvent("objectEngine.setObjectTexture", true)
addEventHandler("objectEngine.setObjectTexture", root, objectEngine.setObjectTexture)

function objectEngine.setPos(elem, pos)
	if isElement(elem) then
		setElementPosition(elem, pos[1], pos[2], pos[3], false)
		setElementRotation(elem, pos[4], pos[5], pos[6], "default", false)
	end
end

function objectEngine.setObjectEditBy(object, toggle)
	if isElement(object) then
		if toggle then
			setElementData(object, "object:editBy", source)
		else
			removeElementData(object, "object:editBy")
		end
	end
end
addEvent("objectEngine.setObjectEditBy", true)
addEventHandler("objectEngine.setObjectEditBy", root, objectEngine.setObjectEditBy)