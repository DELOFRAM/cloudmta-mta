----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

courierData = {}
activeCouriers = {}
activeCouriersVehicle = {}

markersList = 
{
	[1] = {1784, -1724, 13}
}
markersData = {}

function courierData.createMarkers()
	for k, v in ipairs(markersList) do
		local x, y, z = unpack(v)
		local marker = createMarker(x, y, z - 0.5, "cylinder", 2.0, 255, 255, 255, 80, root)
		local blip = createBlip(x, y, z, 0, 2, 255, 255, 255, 255)
		setElementVisibleTo(blip, root, false)
		setElementVisibleTo(marker, root, false)
		table.insert(markersData, {blip, marker})

		marker:setData("courierMagazineMarker", true)
	end
	-- RESET WSZYSTKICH PRZESYŁEK
	exports.titan_db:query_free("UPDATE _couriers SET status = 0, pickedDate = 0, pickedBy = 0")

	--[[
		Odkomentuj, gdy tabela `_couriers` nie istnieje
		exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_couriers` (`ID` int(11) NOT NULL AUTO_INCREMENT, `groupID` int(11) NOT NULL, `intID` int(11) NOT NULL, `name` varchar(255) CHARACTER SET utf8 NOT NULL, `timeStart` int(11) NOT NULL, `data` text NOT NULL, `pickedBy` int(11) NOT NULL, `pickedDate` int(1) NOT NULL, `status` int(11) NOT NULL, PRIMARY KEY (`ID`)) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;")
	]]
end
addEventHandler("onResourceStart", resourceRoot, courierData.createMarkers)

function courierData.onMarkerHit(player, dimensionMatch)
	--outputDebugString("onMarkerHit")
	if dimensionMatch and getElementType(player) == "player" then
		if isPedInVehicle(player) then return end
		if source:getData("courierMagazineMarker") then
			local cInfo = courierData.getPlayerCourierData(player)
			if not cInfo then return end
			if cInfo.state ~= 2 then return end

			local packages = #cInfo.packages
			if packages >= courierData.getCourierTypePackages(cInfo.vehType) then
				return exports.titan_noti:showBox(player, "Twój pojazd posiada już maksymalną ilość załadowanych paczek.")
			end
			triggerClientEvent(player, "createCourierMagazineGUI", player, courierData.getCourierTypePackages(cInfo.vehType) - packages, cInfo.vehicle)
		end
	end
end
addEventHandler("onMarkerHit", resourceRoot, courierData.onMarkerHit)

function courierData.toggleMagazineMarkers(player, state)
	if state then
		for k, v in ipairs(markersData) do
			local blip, marker = unpack(v)
			setElementVisibleTo(blip, player, true)
			setElementVisibleTo(marker, player, true)
		end
	else
		for k, v in ipairs(markersData) do
			local blip, marker = unpack(v)
			setElementVisibleTo(blip, player, false)
			setElementVisibleTo(marker, player, false)
		end
	end
end

function courierData.getPlayerCourierData(player)
	if type(activeCouriers[player]) == "table" then
		return activeCouriers[player]
	end
	return false
end

function courierData.getCourierTypePackages(courierType)
	local packages = 
	{
		[1] = 10,
		[2] = 15,
		[3] = 20,
		[4] = 25,
		[5] = 30,
		[6] = 35,
		[7] = 40,
		[8] = 50,
		[9] = 60
	}
	if tonumber(packages[courierType]) then return packages[courierType] end
	return false
end

function courierData.getVehicleCourierType(vehModel)
	local vehModels = 
	{
		[459] = 3,
		[482] = 3,
		[413] = 3,
		[440] = 3,
		[499] = 6,
		[609] = 4,
		[498] = 4,
		[414] = 7,
		[456] = 7,
		[422] = 1,
		[578] = 9,
		[455] = 8,
		[600] = 2,
		[543] = 2,
		[478] = 1,
		[554] = 3

	}
	if tonumber(vehModels[vehModel]) then return vehModels[vehModel] end
	return false
end

function courierData.cmd(player, command, arg1)
	if not exports.titan_login:isLogged(player) then return end

	local playerDuty = exports.titan_orgs:getPlayerDuty(player)
	if tonumber(playerDuty) then
		if not exports.titan_orgs:doesGroupHavePerm(playerDuty, "courier") then
			return exports.titan_noti:showBox(player, "Grupa, na której duty jesteś nie posiada uprawnien do przewożenia paczek.")
		end
	else
		if exports.titan_casual:getPlayerCasualWork(player) ~= 1 then
			return exports.titan_noti:showBox(player, "Nie jesteś kurierem.")
		end
	end

	arg1 = string.lower(tostring(arg1))
	if arg1 == "start" then
		local cInfo = courierData.getPlayerCourierData(player)
		if cInfo then
			return exports.titan_noti:showBox(player, "Pracujesz już jako kurier.")
		end
		activeCouriers[player] = 
		{
			state = 1,
			packages = {}
		}
		exports.titan_noti:showBox(player, "Rozpocząłeś pracę jako kurier! Wsiądź do pojazdu i wpisz /kurier pojazd, aby rozpocząć.")
	elseif arg1 == "pojazd" then
		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return exports.titan_noti:showBox(player, "Nie pracujesz jako kurier.") end
		if cInfo.state ~= 1 then return exports.titan_noti:showBox(player, "Już wybrałeś pojazd.") end
		if not isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe.") end
		local playerVeh = getPedOccupiedVehicle(player)
		if getVehicleController(playerVeh) ~= player then return exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe jako kierowca.") end
		local vehType = courierData.getVehicleCourierType(getElementModel(playerVeh))
		if not vehType then return exports.titan_noti:showBox(player, "Ten pojazd nie może być użyty do przewozu paczek.") end

		local vehInfo = exports.titan_vehicles:getVehInfo(getElementData(playerVeh, "vehID"))
		if not vehInfo then
			return exports.titan_noti:showBox(player, "Nie znaleziono informacji o tym pojeździe.")
		end

		if vehInfo.ownerType ~= 1 or vehInfo.ownerID ~= player:getData("charID") then
			if vehInfo.ownerType == 2 then
				if not exports.titan_orgs:doesGroupHavePerm(vehInfo.ownerID, "courier") then
					return exports.titan_noti:showBox(player, "Grupa nie posiada uprawnien kurierskich.")
				end
				if not exports.titan_orgs:doesPlayerHavePerm(player, vehInfo.ownerID, "vehicles") then
					return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do tego pojazdu.")
				end
			else
				return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do tego pojazdu.")
			end
		end

		exports.titan_noti:showBox(player, "Pojazd został wybrany. Udaj się teraz do miejsca wyznaczonego przez marker, aby odebrać paczki.")

		activeCouriers[player].state = 2
		activeCouriers[player].vehicle = playerVeh
		activeCouriers[player].vehType = vehType
		activeCouriersVehicle[playerVeh] = player

		courierData.toggleMagazineMarkers(player, true)
	elseif arg1 == "anuluj" then
		local cInfo = courierData.getPlayerCourierData(player)
		if cInfo then 
			courierData.toggleMagazineMarkers(player, false)
			courierData.playerAnimStop(player)
			if type(cInfo.markersInfo) == "table" then
				for k, v in ipairs(cInfo.markersInfo[1]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				for k, v in ipairs(cInfo.markersInfo[2]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
			end
			if type(cInfo.markersInfo2) == "table" then
				for k, v in ipairs(cInfo.markersInfo2[1]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				for k, v in ipairs(cInfo.markersInfo2[2]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
			end
			local markerData = player:getData("courier:marker")
			if markerData then
				local marker, blip = unpack(markerData)
				removeEventHandler("onMarkerHit", marker, courierData.playerMarkerHit)
				destroyElement(marker)
				destroyElement(blip)
				player:removeData("courier:marker")
			end
			if isElement(cInfo.vehicle) then
				activeCouriersVehicle[cInfo.vehicle] = nil
			end
			cInfo.markersInfo = nil
			activeCouriers[player] = nil
			exports.titan_db:query_free("UPDATE _couriers SET STATUS = 0, pickedBy = 0, pickedDate = 0 WHERE pickedBy = ?", player:getData("charID"))
			return exports.titan_noti:showBox(player, "Anulowałeś pracę kuriera.")
		else
			return exports.titan_noti:showBox(player, "Nie pracujesz jako kurier.")
		end
	elseif arg1 == "magazyn" then
		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return exports.titan_noti:showBox(player, "Nie pracujesz jako kurier.") end
		if cInfo.state < 2 then return exports.titan_noti:showBox(player, "Musisz wybrać swój pojazd.") end
		local maxPackages = courierData.getCourierTypePackages(cInfo.vehType)
		if not maxPackages then return exports.titan_noti:showBox(player, "Wystąpił błąd (CODE: 1). Powiadom administratora.") end
		if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz siedzieć w pojeździe.") end
		triggerClientEvent(player, "createCourierMagazineGUI", player)
	elseif arg1 == "namierz" then
		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return exports.titan_noti:showBox(player, "Nie pracujesz jako kurier.") end
		if cInfo.state ~= 2 then return exports.titan_noti:showBox(player, "Nie możesz teraz tego zrobić.") end
		if #cInfo.packages == 0 then return exports.titan_noti:showBox(player, "Na pojeździe nie ma żadnych paczek.") end

		if type(cInfo.markersInfo) == "table" then
			for k, v in ipairs(cInfo.markersInfo[1]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
			for k, v in ipairs(cInfo.markersInfo[2]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
			cInfo.markersInfo = nil
			exports.titan_noti:showBox(player, "Namierzanie zostało usunięte. Użyj komendy /kurier rozladuj")
		else
			if not isPedInVehicle(player) or getPedOccupiedVehicle(player) ~= cInfo.vehicle then return exports.titan_noti:showBox(player, "Aby włączyć namierzanie musisz być w pojeździe przypisanym pod pracę kuriera.") end
			local package = cInfo.packages[1]
			local packageInfo = exports.titan_db:query("SELECT * FROM _couriers WHERE ID = ?", package)
			if #packageInfo <= 0 then
				table.remove(cInfo.packages, 1)
				return exports.titan_noti:showBox(player, "Taka paczka nie istnieje!")
			end
			packageInfo = packageInfo[1]
			local doors = exports.titan_doors:getEntryPickups(packageInfo.intID)
			if(not doors) then
				exports.titan_noti:showBox(player, "Grupa nie posiada żadnych drzwi, które posiadałyby wyjście na virtualworldzie 0. Zgłoś to jak najszybciej.")
				table.remove(cInfo.packages, 1)
				exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = UNIX_TIMESTAMP(), status = -1 WHERE ID = ?", packageInfo.ID)
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
			cInfo.markersInfo = tmpTable
			addEventHandler("onPlayerVehicleExit", player, courierData.removePackageOnVehExit)
			return exports.titan_noti:showBox(player, "Na mapie oznaczono miejsca, gdzie możesz zostawić paczkę.")
		end
	elseif arg1 == "rozladuj" then
		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return exports.titan_noti:showBox(player, "Nie pracujesz jako kurier.") end
		if cInfo.state ~= 2 then return exports.titan_noti:showBox(player, "Nie możesz teraz tego zrobić.") end
		if #cInfo.packages == 0 then return exports.titan_noti:showBox(player, "Na pojeździe nie ma żadnych paczek.") end
		if isPedInVehicle(player) then return exports.titan_noti:showBox(player, "Nie możesz siedzieć w pojeździe.") end

		local x0, y0, z0, x1, y1, z1 = unpack(cInfo.boundingData)
		if x0 then
			local matrix = cInfo.vehicle:getMatrix()
			local newMatrix = matrix:transformPosition(Vector3(0, y0 - 1, z0 - 0.5))
			local marker = createMarker(newMatrix, "cylinder", 2.0, 255, 255, 0, 80, player)
			local blip = createBlip(newMatrix, 0, 2, 255, 255, 0, 255, 0, 99999.0, player)
			setElementData(player, "courier:marker", {marker, blip})
			addEventHandler("onMarkerHit", marker, courierData.playerMarkerHit2)
		end
		cInfo.state = 4
		return exports.titan_noti:showBox(player, "Wejdź w marker, aby wyciągnąć paczkę.")
	else
		return exports.titan_noti:showBox(player, "TIP: /kurier [start, pojazd, namierz, rozladuj, anuluj]")
	end
end
addCommandHandler("kurier", courierData.cmd, false, false)

function courierData.playerMarkerHit2(player, dimensionMatch)
	if dimensionMatch then
		local markerData = player:getData("courier:marker")
		if markerData then
			local marker, blip = unpack(markerData)
			removeEventHandler("onMarkerHit", marker, courierData.playerMarkerHit)
			destroyElement(marker)
			destroyElement(blip)
			player:removeData("courier:marker")
		end

		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return end
		if cInfo.state ~= 4 then return end

		local package = cInfo.packages[1]
		local packageInfo = exports.titan_db:query("SELECT * FROM _couriers WHERE ID = ?", package)
		if #packageInfo <= 0 then
			table.remove(cInfo.packages, 1)
			return exports.titan_noti:showBox(player, "Taka paczka nie istnieje!")
		end
		packageInfo = packageInfo[1]
		local doors = exports.titan_doors:getEntryPickups(packageInfo.intID)
		if(not doors) then
			exports.titan_noti:showBox(player, "Grupa nie posiada żadnych drzwi, które posiadałyby wyjście na virtualworldzie 0. Zgłoś to jak najszybciej.")
			table.remove(cInfo.packages, 1)
			exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = UNIX_TIMESTAMP(), status = -1 WHERE ID = ?", packageInfo.ID)
			return
		end
		local tmpTable = {[1] = {}, [2] = {}}
		for k, v in ipairs(doors) do
			local marker = createMarker(v.outX, v.outY, v.outZ - 1, "cylinder", 2.0, 119, 140, 56, 100, player)
			if(isElement(marker)) then
				setElementData(marker, "isCourierMarker", true)
				setElementData(marker, "forPlayer", player)
				marker:setParent(player)
				table.insert(tmpTable[1], marker)
				addEventHandler("onMarkerHit", marker, courierData.playerMarkerHit3)
			end
			local blip = createBlip(v.outX, v.outY, v.outZ - 1, 0, 2, 255, 0, 0, 255, 0, 99999.0, player)
			if(isElement(blip)) then
				table.insert(tmpTable[2], blip)
				blip:setParent(player)
			end
		end
		cInfo.markersInfo2 = tmpTable
		cInfo.state = 5
		courierData.playerPackAnim(player)
		exports.titan_noti:showBox(player, "Teraz zanieś paczkę do drzwi.")
	end
end

function courierData.playerMarkerHit3(player, dimensionMatch)
	if dimensionMatch then
		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return end
		if cInfo.state ~= 5 then return end

		local package = cInfo.packages[1]
		local packageInfo = exports.titan_db:query("SELECT * FROM _couriers WHERE ID = ?", tonumber(package))
		if #packageInfo > 0 then
			packageInfo = packageInfo[1]
			packageInfo.data = fromJSON(tostring(packageInfo.data))
			if type(packageInfo.data) ~= "table" then
				outputDebugString(string.format("[COURIER] Wystapił błąd z pobraniem wartości kuriera. ID paczki: %d.", packageInfo.ID))
				exports.titan_noti:showBox(player, "Niestety, ta paczka jest uszkodzona. Administrator otrzymał powiadomienie.")
				table.remove(cInfo.packages, 1)
				exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = UNIX_TIMESTAMP(), status = -1 WHERE ID = ?", packageInfo.ID)
				courierData.playerAnimStop(player)
				table.remove(cInfo.packages, 1)
				cInfo.state = 2

				if type(cInfo.markersInfo2) == "table" then
					for k, v in ipairs(cInfo.markersInfo2[1]) do
						if(isElement(v)) then
							removeEventHandler("onMarkerHit", v, courierData.playerMarkerHit3)
							destroyElement(v)
						end
					end
					for k, v in ipairs(cInfo.markersInfo2[2]) do
						if(isElement(v)) then
							destroyElement(v)
						end
					end
				end
				cInfo.markersInfo2 = nil
				return
			end
			local vehInfo = exports.titan_vehicles:getVehInfo(cInfo.vehicle:getData("vehID"))
			if vehInfo.ownerType ~= 1 or vehInfo.ownerID ~= player:getData("charID") then
				if vehInfo.ownerType == 2 then
					if not exports.titan_orgs:doesGroupHavePerm(vehInfo.ownerID, "courier") then
						table.remove(cInfo.packages, 1)
						exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = UNIX_TIMESTAMP(), status = -1 WHERE ID = ?", packageInfo.ID)
						courierData.playerAnimStop(player)
						table.remove(cInfo.packages, 1)
						cInfo.state = 2

						if type(cInfo.markersInfo2) == "table" then
							for k, v in ipairs(cInfo.markersInfo2[1]) do
								if(isElement(v)) then
									removeEventHandler("onMarkerHit", v, courierData.playerMarkerHit3)
									destroyElement(v)
								end
							end
							for k, v in ipairs(cInfo.markersInfo2[2]) do
								if(isElement(v)) then
									destroyElement(v)
								end
							end
						end
						cInfo.markersInfo2 = nil
						return exports.titan_noti:showBox(player, "Grupa nie posiada uprawnien kurierskich.")
					end
					if not exports.titan_orgs:doesPlayerHavePerm(player, vehInfo.ownerID, "vehicles") then
						table.remove(cInfo.packages, 1)
						exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = UNIX_TIMESTAMP(), status = -1 WHERE ID = ?", packageInfo.ID)
						courierData.playerAnimStop(player)
						table.remove(cInfo.packages, 1)
						cInfo.state = 2

						if type(cInfo.markersInfo2) == "table" then
							for k, v in ipairs(cInfo.markersInfo2[1]) do
								if(isElement(v)) then
									removeEventHandler("onMarkerHit", v, courierData.playerMarkerHit3)
									destroyElement(v)
								end
							end
							for k, v in ipairs(cInfo.markersInfo2[2]) do
								if(isElement(v)) then
									destroyElement(v)
								end
							end
						end
						cInfo.markersInfo2 = nil
						return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do tego pojazdu.")
					end
				else
					table.remove(cInfo.packages, 1)
					exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = UNIX_TIMESTAMP(), status = -1 WHERE ID = ?", packageInfo.ID)
					courierData.playerAnimStop(player)
					table.remove(cInfo.packages, 1)
					cInfo.state = 2

					if type(cInfo.markersInfo2) == "table" then
						for k, v in ipairs(cInfo.markersInfo2[1]) do
							if(isElement(v)) then
								removeEventHandler("onMarkerHit", v, courierData.playerMarkerHit3)
								destroyElement(v)
							end
						end
						for k, v in ipairs(cInfo.markersInfo2[2]) do
							if(isElement(v)) then
								destroyElement(v)
							end
						end
					end
					cInfo.markersInfo2 = nil
					return exports.titan_noti:showBox(player, "Nie posiadasz uprawnien do tego pojazdu.")
				end
			end

			local depositeInfo = exports.titan_db:query("SELECT ID FROM _deposite WHERE intID = ? AND name = ? AND itemType = ? AND itemVal1 = ? AND itemVal2 = ? AND itemVal3 = ? AND itemVolume = ? LIMIT 1", packageInfo.intID, packageInfo.data.itemName, packageInfo.data.itemType, packageInfo.data.itemVal1, packageInfo.data.itemVal2, packageInfo.data.itemVal3, packageInfo.data.itemVolume)
			if depositeInfo and #depositeInfo == 1 then
				exports.titan_db:query_free("UPDATE _deposite SET stock = stock + 1 WHERE ID = ?", depositeInfo[1].ID)
			else
				exports.titan_db:query_free("INSERT INTO _deposite SET intID = ?, name = ?, stock = 1, itemType = ?, itemVal1 = ?, itemVal2 = ?, itemVal3 = ?, itemVolume = ?, itemPrice = ?, sellPrice = ?", packageInfo.intID, packageInfo.data.itemName, packageInfo.data.itemType, packageInfo.data.itemVal1, packageInfo.data.itemVal2, packageInfo.data.itemVal3, packageInfo.data.itemVolume, packageInfo.price, packageInfo.price)
			end
			exports.titan_db:query_free("DELETE FROM _couriers WHERE ID = ?", packageInfo.ID)

			if vehInfo.ownerType == 1 then
				exports.titan_noti:showBox(player, "Paczka została dostarczona pomyślnie. Otrzymałeś wynagrodzenie w postaci $5!")
				exports.titan_cash:addPlayerCash(player, 5)
				exports.titan_logs:playerLog(player, "cash", string.format("Otrzymano pieniądze od: (Praca dorywcza) Kurier (UID: 1), Kwota: $%d.", 5)
			elseif vehInfo.ownerType == 2 then
				local groupInfo = exports.titan_orgs:getGroupInfo(vehInfo.ownerID)
				if not groupInfo then
					exports.titan_noti:showBox(player, "Paczka została dostarczona pomyślnie, jednak grupa, pod ktora podpisany jest pojazd nie istnieje. Pieniadze przepadly.")
				else
					exports.titan_orgs:giveGroupMoney(vehInfo.ownerID, 5, 0, string.format("%s dowiózł paczkę kurierska.", exports.titan_chats:getPlayerICName(player)))
					exports.titan_cash:addPlayerCash(player, 2)	
					exports.titan_noti:showBox(player, "Paczka została dostarczona pomyślnie. Otrzymałeś wynagrodzenie w postaci $2! Twoja grupa otrzymała pieniadze!")
					exports.titan_logs:playerLog(player, "cash", string.format("Otrzymano pieniądze od: (Praca dorywcza) Kurier (UID: 1), Kwota: $%d.", 2)
				end
			else
				exports.titan_noti:showBox(player, "Paczka została dostarczona pomyślnie.")
			end

			

			courierData.playerAnimStop(player)
			table.remove(cInfo.packages, 1)
			cInfo.state = 2

			if type(cInfo.markersInfo2) == "table" then
				for k, v in ipairs(cInfo.markersInfo2[1]) do
					if(isElement(v)) then
						removeEventHandler("onMarkerHit", v, courierData.playerMarkerHit3)
						destroyElement(v)
					end
				end
				for k, v in ipairs(cInfo.markersInfo2[2]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
			end
			cInfo.markersInfo2 = nil
		end
	end
end

function courierData.removePackageOnVehExit(vehicle, seat, jacker)
	outputDebugString("VehicleExit")
	local cInfo = courierData.getPlayerCourierData(source)
	if cInfo then
		if type(cInfo.markersInfo) == "table" then
			for k, v in ipairs(cInfo.markersInfo[1]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
			for k, v in ipairs(cInfo.markersInfo[2]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
		end
		cInfo.markersInfo = nil
		exports.titan_noti:showBox(source, "Namierzanie zostało usunięte. Użyj komendy /kurier rozladuj")
	end
	removeEventHandler("onPlayerVehicleExit", source, courierData.removePackageOnVehExit)
end

function courierData.takePackage(player, boundingData)
	local cInfo = courierData.getPlayerCourierData(player)
	if not cInfo then return end
	if cInfo.state ~= 2 then return end
	
	local query = exports.titan_db:query("SELECT * FROM _couriers WHERE status = 0 ORDER BY ID ASC LIMIT 1")
	if #query == 0 then
		return exports.titan_noti:showBox(player, "Nie ma żadnych paczek do dostarczenia.")
	end
	query = query[1]

	cInfo.state = 3
	cInfo.carriedPackage = tonumber(query.ID)

	exports.titan_db:query_free("UPDATE _couriers SET status = 1, pickedBy = ?, pickedDate = UNIX_TIMESTAMP() WHERE ID = ?", player:getData("charID"), query.ID)
	courierData.playerPackAnim(player)

	local x0, y0, z0, x1, y1, z1 = unpack(boundingData)
	if x0 then
		local matrix = cInfo.vehicle:getMatrix()
		local newMatrix = matrix:transformPosition(Vector3(0, y0 - 1, z0 - 0.5))
		local marker = createMarker(newMatrix, "cylinder", 2.0, 255, 255, 0, 80, player)
		local blip = createBlip(newMatrix, 0, 2, 255, 255, 0, 255, 0, 99999.0, player)
		setElementData(player, "courier:marker", {marker, blip})
		addEventHandler("onMarkerHit", marker, courierData.playerMarkerHit)
		cInfo.boundingData = boundingData
	end
	return exports.titan_noti:showBox(player, "Podniosłeś paczkę z magazynu. Zanieś ją teraz na tyły swojego pojazdu.")
end
addEvent("courierData.takePackage", true)
addEventHandler("courierData.takePackage", root, courierData.takePackage)

function courierData.playerMarkerHit(player, dimensionMatch)
	if dimensionMatch then
		local cInfo = courierData.getPlayerCourierData(player)
		if not cInfo then return end
		if cInfo.state ~= 3 then return end
		if not tonumber(cInfo.carriedPackage) then return end
		table.insert(cInfo.packages, cInfo.carriedPackage)
		exports.titan_db:query_free("UPDATE _couriers SET status = 2 WHERE ID = ?", cInfo.carriedPackage)
		courierData.playerAnimStop(player)
		cInfo.state = 2
		cInfo.carriedPackage = nil

		local markerData = player:getData("courier:marker")
		if markerData then
			local marker, blip = unpack(markerData)
			removeEventHandler("onMarkerHit", marker, courierData.playerMarkerHit)
			destroyElement(marker)
			destroyElement(blip)
			player:removeData("courier:marker")
		end
		return exports.titan_noti:showBox(player, "Paczka została załadowana na pojazd.")
	end
end

function courierData.playerPackAnim(player)
	if isElement(player:getData("courier:object")) then destroyElement(player:getData("courier:object")) end
	setPedAnimation(player, "CARRY", "crry_prtial", 1, true, true, false)
	local object = createObject(2969, player:getPosition())
	object:setCollisionsEnabled(false)
	exports.titan_boneAttach:attachElementToBone(object, player, 4, -0.08, 0.4, -0.4, -90, 0, 0)
	setElementParent(object, player)
	player:setData("courier:object", object)

	triggerClientEvent(player, "courierAnim.toggle", player, true)
end

function courierData.playerAnimStop(player)
	if isElement(player:getData("courier:object")) then destroyElement(player:getData("courier:object")) end
	setPedAnimation (player, "BSKTBALL", "BBALL_idle_O", 0, false, false, true, false)

	triggerClientEvent(player, "courierAnim.toggle", player, false)
end

function courierData.eventOnVehicleStartEnter(player, seat, jacked, door)
	if isElement(activeCouriersVehicle[source]) and getElementType(activeCouriersVehicle[source]) == "player" then
		if player ~= activeCouriersVehicle[source] then
			cancelEvent()
			return exports.titan_noti:showBox(player, "Nie możesz wejść do tego pojazdu. Przeznaczony on jest do pracy kuriera.")
		end
		local cInfo = courierData.getPlayerCourierData(player)
		if cInfo then
			if cInfo.state == 5 or cInfo.state == 4 then
				if type(cInfo.markersInfo2) == "table" then
					for k, v in ipairs(cInfo.markersInfo2[1]) do
						if(isElement(v)) then
							removeEventHandler("onMarkerHit", v, courierData.playerMarkerHit3)
							destroyElement(v)
						end
					end
					for k, v in ipairs(cInfo.markersInfo2[2]) do
						if(isElement(v)) then
							destroyElement(v)
						end
					end
				end
				local markerData = player:getData("courier:marker")
				if markerData then
					local marker, blip = unpack(markerData)
					removeEventHandler("onMarkerHit", marker, courierData.playerMarkerHit)
					destroyElement(marker)
					destroyElement(blip)
					player:removeData("courier:marker")
				end
				cInfo.markersInfo2 = nil
				cInfo.state = 2
				courierData.playerAnimStop(player)
				exports.titan_noti:showBox(player, "Paczka została z powrotem włożona do pojazdu.")
			elseif cInfo.state == 3 and tonumber(cInfo.carriedPackage) then
				local markerData = player:getData("courier:marker")
				if markerData then
					local marker, blip = unpack(markerData)
					removeEventHandler("onMarkerHit", marker, courierData.playerMarkerHit)
					destroyElement(marker)
					destroyElement(blip)
					player:removeData("courier:marker")
					cInfo.state = 2
					courierData.playerAnimStop(player)
					exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = 0, status = 0 WHERE ID = ?", cInfo.carriedPackage)
					exports.titan_noti:showBox(player, "Anulowałeś przenoszenie paczki do pojazdu.")
				end
			end
		end
	end
end
addEventHandler("onVehicleStartEnter", root, courierData.eventOnVehicleStartEnter)

function courierData.eventOnPlayerQuit()
	local cInfo = courierData.getPlayerCourierData(source)
	if cInfo then
		if isElement(cInfo.vehicle) then
			activeCouriersVehicle[cInfo.vehicle] = nil
		end
		exports.titan_db:query_free("UPDATE _couriers SET pickedBy = 0, pickedDate = 0, status = 0 WHERE pickedBy = ?", getElementData(source, "charID"))
		activeCouriers[source] = nil
	end
	--outputDebugString(string.format("Gracz %s %s (%s) zakończył pracę kuriera z powodu wyjścia z serwera.", source:getData("name"), source:getData("lastname"), source:getData("globalName")))
end
addEventHandler("onPlayerQuit", root, courierData.eventOnPlayerQuit)

function courierData.eventOnVehicleDestroy(sourceResource, functionName, isAllowedByACL, luaFilename, luaLineNumber, ...)
	local args = {...}
	if string.lower(tostring(functionName)) == "destroyelement" then
		if isElement(args[1]) and getElementType(args[1]) == "vehicle" then
			if isElement(activeCouriersVehicle[args[1]]) and getElementType(activeCouriersVehicle[args[1]]) == "player" then
				local player = activeCouriersVehicle[args[1]]
				exports.titan_noti:showBox(player, "Pojazd, którego używałeś do przewozu paczek został usunięty. Praca została anulowana.")
				return executeCommandHandler("kurier", player, "anuluj")
			end
		end
	end
end
addDebugHook("preFunction", courierData.eventOnVehicleDestroy)