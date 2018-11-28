local courierFunc = {}
local PACKAGES_TYPE_ONE = 15
local PACKAGES_TYPE_TWO = 100
courierElement = {}
courierFunc.vehicles =
{
[413] = 1,
[482] = 1
}	

function courierFunc.isVehicle(vehicleID)
	if not courierFunc.vehicles[vehicleID] then return false end
	return courierFunc.vehicles[vehicleID]
end

function courierFunc.getAllPlayerDelivers(player)
	if not exports.titan_login:isLogged(player) then return false end
	if type(player:getData("courierInfo")) ~= "table" then return false end
	return #player:getData("courierInfo").courierPackages
end

function courierFunc.getPlayerInfo(player, name)
	if not exports.titan_login:isLogged(player) then return false end
	if type(player:getData("courierInfo")) ~= "table" then return false end
	local data = player:getData("courierInfo")
	return data[name]
end

function courierFunc.cmdKurier(player, command, ...)
	local arg = {...}
	local value = string.lower(tostring(arg[1]))
	if value == "start" then
		if type(player:getData("courierInfo")) == "table" then return exports.titan_noti:showBox(player, "Pracujesz w tym momencie jako kurier!") end
		if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Aby rozpocząć pracę kuriera musisz być w pojeździe do tego przystosowanym.") end
		local vehicle = getPedOccupiedVehicle(player)
		if getVehicleOccupant(vehicle) ~= player then return exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe jako kierowca.") end
		local vehicleType = courierFunc.isVehicle(vehicle:getModel())
		if not vehicleType then return exports.titan_noti:showBox(player, "Ten pojazd nie jest przystosowany to przewozu towarów.") end
		local tempTable = 
		{
			courierVehicle = vehicle,
			courierType = vehicleType,
			courierPackages = {}
		}
		player:setData("courierInfo", tempTable)
		setElementVisibleTo(courierFunc.blipElement, player, true)
		exports.titan_noti:showBox(player, "Zainicjowano pracę kuriera. Pojedź do wyznaczonego przez blip miejsca na mapie.")
	elseif value == "anuluj" then
		if type(player:getData("courierInfo")) == "table" then
			setElementVisibleTo(courierFunc.blipElement, player, false)
			local tempTable = player:getData("courierInfo")
			if isElement(tempTable.courierVehicle) then
				tempTable.courierVehicle:removeData("courierBlock")
				tempTable.courierVehicle:removeData("courierPlayer")
				player:removeData("courierPlace")
			end
			player:removeData("courierInfo")
			exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = 0, status = 0 WHERE pickedBy = ?", player:getData("charID"))
			local tmpTable = player:getData("courierTable")
			if(type(tmpTable) == "table") then
				for k, v in ipairs(tmpTable[1]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				for k, v in ipairs(tmpTable[2]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
			end
			player:removeData("courierTable")
			courierFunc.playerAnimStop(player)
			return exports.titan_noti:showBox(player, "Praca kuriera anulowana.")
		else return exports.titan_noti:showBox(player, "Nie pracujesz w tym momencie jako kurier!") end
	elseif value == "info" then
		if type(player:getData("courierInfo")) ~= "table" then return exports.titan_noti:showBox(player, "Nie pracujesz w tym momencie jako kurier!") end
		local tempTable = player:getData("courierInfo")
		if #tempTable.courierPackages == 0 then return exports.titan_noti:showBox(player, "Nie masz żadnych paczek w pojeździe.") end
		return triggerClientEvent(player, "couriersFunc.guiCreate", resourceRoot, tempTable.courierPackages)
	else
		exports.titan_noti:showBox(player, "TIP: /kurier [info, start, anuluj]")
	end
end
addCommandHandler("kurier", courierFunc.cmdKurier, false, false)

function courierFunc.markerHit(player, matchDimension)
	if getElementType(player) == "player" and exports.titan_login:isLogged(player) then
		if type(player:getData("courierInfo")) == "table" then
			if player:getData("courierPlace") then return end
			local vehicleType = courierFunc.getPlayerInfo(player, "courierType")
			if not vehicleType then return end
			if vehicleType == 1 and courierFunc.getAllPlayerDelivers(player) >= PACKAGES_TYPE_ONE then return exports.titan_noti:showBox(player, "Nie możesz wziąć więcej paczek do pojazdu tego typu.") end
			local query = exports.titan_db:query("SELECT ID, name, status FROM _couriers ORDER BY ID ASC")
			if #query == 0 then return exports.titan_noti:showBox(player, "Nie ma żadnych dostępnych paczek do odebrania.") end
			return triggerClientEvent(player, "courierFunc.guiCreate", resourceRoot, query)
		end
	end
end

function courierFunc.choosePackagePlayer(player, packageID)
	if type(player:getData("courierInfo")) ~= "table" then
		triggerClientEvent(player, "courierFunc.guiDestroy", resourceRoot)
		return exports.titan_noti:showBox(player, "Nie pracujesz w tym momencie jako kurier!")
	end
	if not exports.titan_login:isLogged(player) then return end
	local query = exports.titan_db:query("SELECT * FROM _couriers WHERE ID = ?", packageID)
	if #query == 0 then 
		triggerClientEvent(player, "courierFunc.guiDestroy", resourceRoot)
		return exports.titan_noti:showBox(player, "Taka paczka już nie istnieje.")
	end
	query = query[1]
	if query.status ~= 0 then return exports.titan_noti:showBox(player, "Paczka nie znajduje się już w magazynie.") end
	local tempTable = player:getData("courierInfo")
	if tempTable.courierType == 1 and courierFunc.getAllPlayerDelivers(player) >= PACKAGES_TYPE_ONE then return exports.titan_noti:showBox(player, "Nie możesz wziąć więcej paczek do pojazdu tego typu.") end
	if not isElement(tempTable.courierVehicle) then
		triggerClientEvent(player, "courierFunc.guiDestroy", resourceRoot)
		return exports.titan_noti:showBox(player, "Nie możesz zacząć załadunku bez auta.")
	end

	--
	tempTable.courierVehicle:setData("courierBlock", 1)
	tempTable.courierVehicle:setData("courierPlayer", player)
	player:setData("courierPlace", true)
	query.status = 1
	query.pickedDate = getRealTime().timestamp
	query.state = false
	table.insert(tempTable.courierPackages, query)
	player:setData("courierInfo", tempTable)
	exports.titan_db:query_free("UPDATE _couriers SET pickedBy = ?, pickedDate = UNIX_TIMESTAMP(), status = 1 WHERE ID = ?", player:getData("charID"), packageID)
	exports.titan_noti:showBox(player, "Paczka została podniesiona. Zanieś ją teraz do pojazdu.")
	courierFunc.playerPackAnim(player)
	triggerClientEvent(player, "courierFunc.guiDestroy", resourceRoot)
end
addEvent("courierFunc.choosePackagePlayer", true)
addEventHandler("courierFunc.choosePackagePlayer", root, courierFunc.choosePackagePlayer)

function courierFunc.playerPackAnim(player)
	if isElement(player:getData("courierObject")) then destroyElement(player:getData("courierObject")) end
	setPedAnimation(player, "CARRY", "crry_prtial", 1, true, true, false)
	local object = createObject(2969, player:getPosition())
	object:setCollisionsEnabled(false)
	exports.titan_boneAttach:attachElementToBone(object, player, 4, -0.08, 0.4, -0.4, -90, 0, 0)
	setElementParent(object, player)
	player:setData("courierObject", object)
end

function courierFunc.playerAnimStop(player)
	if isElement(player:getData("courierObject")) then destroyElement(player:getData("courierObject")) end
	setPedAnimation (player, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)
end

function courierFunc.getKeyFromTableName(tbl, tableName, data)
	for k, v in ipairs(tbl) do
		if v[tableName] == data then return k end
	end
	return false
end

function courierFunc.choosePackage(player, packageID)
	if not exports.titan_login:isLogged(player) then return end
	if type(player:getData("courierInfo")) ~= "table" then

		return
	end
	local query = exports.titan_db:query("SELECT ID FROM _couriers WHERE pickedBy = ? AND (status = 1 OR status = 3)", player:getData("charID"))
	if #query > 0 then 
		exports.titan_noti:showBox(player, "Niesiesz już jakąś paczkę.")
		return
	end
	local tempTable = player:getData("courierInfo")
	for k, v in ipairs(tempTable.courierPackages) do
		v.state = false
	end
	-- // PICKUPS
	local pickupsTable = player:getData("courierTable")
	if(type(pickupsTable) == "table") then
		for k, v in ipairs(pickupsTable[1]) do
			if(isElement(v)) then
				destroyElement(v)
			end
		end
		for k, v in ipairs(pickupsTable[2]) do
			if(isElement(v)) then
				destroyElement(v)
			end
		end
	end
	player:removeData("courierTable")
	-- PICKUPS //
	local index = courierFunc.getKeyFromTableName(tempTable.courierPackages, "ID", packageID)
	if not index then

		return
	end
	tempTable.courierPackages[index].state = true
	local query = exports.titan_db:query("SELECT intID FROM _couriers WHERE ID = ?", packageID)
	if not query then

		return
	end
	local doors = exports.titan_doors:getEntryPickups(query[1].intID)
	if(not doors) then
		exports.titan_noti:showBox(player, "Grupa nie posiada żadnych drzwi, które posiadałyby wyjście na virtualworldzie 0. Zgłoś to jak najszybciej.")
		return
	end
	local tmpTable = {[1] = {}, [2] = {}}
	for k, v in ipairs(doors) do
		local marker = createMarker(v.outX, v.outY, v.outZ - 1, "cylinder", 2.0, 119, 140, 56, 100, player)
		if(isElement(marker)) then
			setElementData(marker, "isCourierMarker", true)
			setElementData(marker, "forPlayer", player)
			table.insert(tmpTable[1], marker)
		end
		local blip = createBlip(v.outX, v.outY, v.outZ - 1, 0, 2, 255, 0, 0, 255, 0, 99999.0, player)
		if(isElement(blip)) then
			table.insert(tmpTable[2], blip)
		end
	end
	player:setData("courierTable", tmpTable)
	player:setData("courierInfo", tempTable)
	triggerClientEvent(player, "couriersFunc.guiRefresh", resourceRoot, tempTable.courierPackages)
	exports.titan_noti:showBox(player, "Na mapie zaznaczono miejsca, gdzie można zostawić paczkę.")
end
addEvent("courierFunc.choosePackage", true)
addEventHandler("courierFunc.choosePackage", root, courierFunc.choosePackage)

function courierFunc.takePackage(player, packageID)
	if not exports.titan_login:isLogged(player) then return end
	if isPedInVehicle(player) then
		exports.titan_noti:showBox(player, "Nie możesz siedzieć w pojeździe.")
		return
	end
	if type(player:getData("courierInfo")) ~= "table" then

		return
	end
	local tempTable = player:getData("courierInfo")
	local index = courierFunc.getKeyFromTableName(tempTable.courierPackages, "ID", packageID)
	if not index then

		return
	end
	if not isElement(tempTable.courierVehicle) then
		exports.titan_noti:showBox(player, "Twój pojazd, którym przewoziłeś paczki nie istnieje.")
		return
	end
	if not exports.titan_vehicles:isVehicleEmpty(tempTable.courierVehicle) then
		exports.titan_noti:showBox(player, "W momencie rozładunku w pojeździe nie może być nikogo.")
		return
	end
	if tempTable.courierVehicle:getInterior() ~= player:getInterior() or tempTable.courierVehicle:getDimension() ~= player:getDimension() or getDistanceBetweenPoints3D(player:getPosition(), tempTable.courierVehicle:getPosition()) > 4.0 then
		exports.titan_noti:showBox(player, "Jesteś zbyt daleko od pojazdu.")
		return
	end
	local query = exports.titan_db:query("SELECT ID FROM _couriers WHERE pickedBy = ? AND (status = 1 OR status = 3)", player:getData("charID"))
	if #query > 0 then 
		exports.titan_noti:showBox(player, "Niesiesz już jakąś paczkę.")
		return
	end
	tempTable.courierPackages[index].status = 3
	exports.titan_db:query_free("UPDATE _couriers SET status = 3 WHERE ID = ?", packageID)
	exports.titan_noti:showBox(player, "Podniosłeś paczkę. Wejdź na marker drzwi, aby ją zostawić, lub kliknij F obok swojego pojazdu, aby wrzucić ją do niego ponownie.")
	courierFunc.playerPackAnim(player)
	tempTable.courierVehicle:setData("courierBlock", 2)
	tempTable.courierVehicle:setData("courierPlayer", player)
	player:setData("courierInfo", tempTable)
end
addEvent("courierFunc.takePackage", true)
addEventHandler("courierFunc.takePackage", root, courierFunc.takePackage)

function courierFunc.vehicleEnter(player)
	if source:getData("courierBlock") then
		cancelEvent()
		if source:getData("courierBlock") == 1 then
			if source:getData("courierPlayer") == player then
				local tempTable = player:getData("courierInfo")
				for k, v in ipairs(tempTable.courierPackages) do
					if v.status == 1 then
						v.status = 2
						exports.titan_db:query_free("UPDATE _couriers SET status = 2 WHERE ID = ?", v.ID)
						break
					end
				end
				tempTable.courierVehicle:removeData("courierBlock")
				tempTable.courierVehicle:removeData("courierPlayer")
				player:removeData("courierPlace")
				player:setData("courierInfo", tempTable)
				exports.titan_noti:showBox(player, "Paczka została załadowana na pojazd.")
				courierFunc.playerAnimStop(player)
			else
				exports.titan_noti:showBox(player, "Aktualnie trwa załadunek z magazynu. Nie można wejść do tego pojazdu.")
			end
		elseif source:getData("courierBlock") == 2 then
			if source:getData("courierPlayer") == player then
				local tempTable = player:getData("courierInfo")
				for k, v in ipairs(tempTable.courierPackages) do
					if v.status == 3 then
						v.status = 2
						exports.titan_db:query_free("UPDATE _couriers SET status = 2 WHERE ID = ?", v.ID)
						break
					end
				end
				tempTable.courierVehicle:removeData("courierBlock")
				tempTable.courierVehicle:removeData("courierPlayer")
				player:removeData("courierPlace")
				player:setData("courierInfo", tempTable)
				exports.titan_noti:showBox(player, "Paczka została załadowana na pojazd.")
				courierFunc.playerAnimStop(player)
			else
				exports.titan_noti:showBox(player, "Aktualnie trwa załadunek z magazynu. Nie można wejść do tego pojazdu.")
			end
		end
	end
	local tempTable = player:getData("courierInfo")
	-- if type(tempTable) == "table" then
		-- cancelEvent()
		-- return exports.titan_noti:showBox(player, "Możesz wejść tylko do pojazdu, który jest przypisany do kuriera.")
	-- end
end
addEventHandler("onVehicleStartEnter", root, courierFunc.vehicleEnter)

function courierFunc.globalMarker(player, dimension)
	if dimension then
		if isElement(source:getData("forPlayer")) and source:getData("forPlayer") == player then
			local tempTable = player:getData("courierInfo")
			if type(tempTable) ~= "table" then return end
			local query = exports.titan_db:query("SELECT * FROM _couriers WHERE pickedBy = ? AND status = 3", player:getData("charID"))
			if #query ~= 1 then return exports.titan_noti:showBox(player, "Wystąpił błąd w momencie doręczania przesyłki. (CODE 2)") end
			query = query[1]
			-- // PICKUPS
			local pickupsTable = player:getData("courierTable")
			if(type(pickupsTable) == "table") then
				for k, v in ipairs(pickupsTable[1]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				for k, v in ipairs(pickupsTable[2]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
			end
			player:removeData("courierTable")
			-- PICKUPS //
			query.data = fromJSON(tostring(query.data))
			exports.titan_db:query_free("INSERT INTO _deposite SET intID = ?, name = ?, stock = 1, itemType = ?, itemVal1 = ?, itemVal2 = ?, itemVal3 = ?, itemVolume = ?", query.intID, query.data.itemName, query.data.itemType, query.data.itemVal1, query.data.itemVal2, query.data.itemVal3, query.data.itemVolume)
			exports.titan_db:query_free("DELETE FROM _couriers WHERE ID = ?", query.ID)
			exports.titan_noti:showBox(player, "Paczka została dostarczona pomyślnie. Otrzymałeś wynagrodzenie!")
			courierFunc.playerAnimStop(player)
			local index = courierFunc.getKeyFromTableName(tempTable.courierPackages, "ID", query.ID)
			if index then
				table.remove(tempTable.courierPackages, index)
				if #tempTable.courierPackages == 0 then
					if type(player:getData("courierInfo")) == "table" then
						setElementVisibleTo(courierFunc.blipElement, player, false)
						local tempTable = player:getData("courierInfo")
						if isElement(tempTable.courierVehicle) then
							tempTable.courierVehicle:removeData("courierBlock")
							tempTable.courierVehicle:removeData("courierPlayer")
							player:removeData("courierPlace")
						end
						player:removeData("courierInfo")
						exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = 0, status = 0 WHERE pickedBy = ?", player:getData("charID"))
						local tmpTable = player:getData("courierTable")
						if(type(tmpTable) == "table") then
							for k, v in ipairs(tmpTable[1]) do
								if(isElement(v)) then
									destroyElement(v)
								end
							end
							for k, v in ipairs(tmpTable[2]) do
								if(isElement(v)) then
									destroyElement(v)
								end
							end
						end
						player:removeData("courierTable")
					end
					return exports.titan_noti:showBox(player, "Praca kuriera została zakończona.")
				end
				player:setData("courierInfo", tempTable)
			end
		end
	end
end
addEventHandler("onMarkerHit", resourceRoot, courierFunc.globalMarker)

function courierFunc.playerQuit()
	if isElement(source) then
		player = source
		if type(player:getData("courierInfo")) == "table" then
			setElementVisibleTo(courierFunc.blipElement, player, false)
			local tempTable = player:getData("courierInfo")
			if isElement(tempTable.courierVehicle) then
				tempTable.courierVehicle:removeData("courierBlock")
				tempTable.courierVehicle:removeData("courierPlayer")
				player:removeData("courierPlace")
			end
			player:removeData("courierInfo")
			exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = 0, status = 0 WHERE pickedBy = ?", player:getData("charID"))
			local tmpTable = player:getData("courierTable")
			if(type(tmpTable) == "table") then
				for k, v in ipairs(tmpTable[1]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				for k, v in ipairs(tmpTable[2]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
			end
			player:removeData("courierTable")
		end
	end
end
addEventHandler("onPlayerQuit", root, courierFunc.playerQuit)

function courierFunc.main(tab)
	courierElement.marker = createMarker(tab.x , tab.y, tab.z, "cylinder", 2.0,119, 140, 56, 200, root)
	courierElement.blip = createBlip(tab.x , tab.y, tab.z, 0, 2.0, 255, 110, 110, 255, 0, 99999.0, root)
	setElementVisibleTo(courierElement.blip, root, false)
	addEventHandler("onMarkerHit", courierElement.marker, courierFunc.markerHit)
end

-- function courierFunc.main()
-- 	courierFunc.markerPos = Vector3(1062.563, 2097.000, 9.120)
-- 	courierFunc.markerElement = createMarker(courierFunc.markerPos, "cylinder", 2.0,119, 140, 56, 200, root)
-- 	courierFunc.blipElement = createBlip(courierFunc.markerPos, 0, 2.0, 255, 110, 110, 255, 0, 99999.0, root)
-- 	setElementVisibleTo(courierFunc.blipElement, root, false)
-- 	courierFunc.vehicles =
-- 	{
-- 		[413] = 1,
-- 		[482] = 1
-- 	}
-- 	addEventHandler("onMarkerHit", courierFunc.markerElement, courierFunc.markerHit)
-- 	exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_couriers` (`ID` int(11) NOT NULL AUTO_INCREMENT, `groupID` int(11) NOT NULL, `intID` int(11) NOT NULL, `name` varchar(255) CHARACTER SET utf8 NOT NULL, `timeStart` int(11) NOT NULL, `data` text NOT NULL, `pickedBy` int(11) NOT NULL, `pickedDate` int(1) NOT NULL, `status` int(11) NOT NULL, PRIMARY KEY (`ID`)) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;")
-- end


function courierFunc.load()
	for i,v in ipairs(Magazyny) do
		courierFunc.main(v)
	end
	exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_couriers` (`ID` int(11) NOT NULL AUTO_INCREMENT, `groupID` int(11) NOT NULL, `intID` int(11) NOT NULL, `name` varchar(255) CHARACTER SET utf8 NOT NULL, `timeStart` int(11) NOT NULL, `data` text NOT NULL, `pickedBy` int(11) NOT NULL, `pickedDate` int(1) NOT NULL, `status` int(11) NOT NULL, PRIMARY KEY (`ID`)) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;")
end
addEventHandler("onResourceStart", resourceRoot, courierFunc.load)