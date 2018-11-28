----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:27
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:29
----------------------------------------------------

trailers = {}
trailers[584] = true
trailers[435] = true
trailers[450] = true
trailers[591] = true

function cmdAv(player, command, ...)
	if not doesAdminHavePerm(player, "vehicles") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local legend = "info, uid, stworz, usun, klucze, przypisz, kolor1, kolor2, fix, to, tm, flash, siren, alarm, fuel, windows, respawn, rveh, audio, spawn, flip"

	local arg1 = string.lower(tostring(arg[1]))
	if(arg1 == "stworz") then
		local model = table.concat({...}, " ", 2)
		if(not tonumber(model) and (string.len(tostring(model)) < 1 or not model)) then
			exports.titan_noti:showBox(player, string.format("TIP: /av stworz [model pojazdu/nazwa]"))
			return
		end
		if(tonumber(model)) then
			model = tonumber(model)
			if (string.len(getVehicleNameFromModel(model)) < 1) then
				if trailers[model] then else
					exports.titan_noti:showBox(player, "Wprowadzono niepoprawne ID pojazdu.")
					return
				end
			end
		else
			model = getVehicleModelFromName(model)
			if(not model) then
				exports.titan_noti:showBox(player, "Nie znaleziono modelu pojazdu o podanej nazwie.")
				return
			end
		end
		local x, y, z = getElementPosition(player)
		x, y = getXYInFrontOfPlayer(player, 3)
		local rz, ry, rz = getElementRotation(player)
		local UID = exports.titan_vehicles:vehCreate(1, getElementData(player, "charID"), model, x, y, z, rz - 90, getElementInterior(player), getElementDimension(player))
		if(tonumber(UID)) then
			--exports.titan_logs:commandLog(player, command, {...})
			exports.titan_noti:showBox(player, string.format("Stworzyłeś pojazd. Ma on UID %d.", UID))
			
			--local message = string.format("[%0.2d:%0.2d:%0.2d] %s stworzył pojazd %s (UID: %d)", time.hour, time.minute, time.second, player:getData("globalName"), getVehicleNameFromModel(model), UID)
			exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) stworzył pojazd %s (UID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), getVehicleNameFromModel(model), UID))
		else
			exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie tworzenia pojazdu.")
		end
		return
	elseif arg1 == "klucze" then
		if isPedInVehicle(player) and not arg[2] then
			local veh = getPedOccupiedVehicle(player)
			if not exports.titan_vehicles:isVeh(veh) then return exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)") end
			local vehID = veh:getData("vehID")
			local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end

			local ownerUID = getElementData(player, "charID")
			local itemName = "Klucze "..vehInfo.name.." ("..vehInfo.ID..")"
			local itemVolume = 15
			local itemVal1 = vehInfo.ID
			local itemVal2 = ownerUID
			local itemVal3 = getElementData(player, "charID")
			local itemSlotID = exports.titan_items:getPlayerFreeSlotID(player)
			if(not itemSlotID or itemSlotID > 35) then
				exports.titan_noti:showBox(player, "Gracz nie ma już miejsca w ekwipunku.")
				return
			end
			local state, itemID = exports.titan_items:itemCreate(1, ownerUID, itemName, 10, itemSlotID, itemVolume, itemVal1, itemVal2, itemVal3)
			if(state) then
				exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono parę kluczy o nazwie \"%s\" (UID: %d).", itemName, itemID))
				exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) stworzył klucze do pojazdu (UID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), itemVal2))
				exports.titan_logs:commandLog(player, command, {...})
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie tworzenia kluczy")
			end
			--exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono parę kluczy o nazwie \"%s\" (UID: %d).", itemName, itemID))	
		else
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av klucze [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.")
				return
			end

			ownerUID = getElementData(player, "charID")
			itemName = "Klucze "..vehInfo.name.." ("..vehInfo.ID..")"
			itemVolume = 15
			itemVal1 = vehInfo.ID
			itemVal2 = ownerUID
			itemVal3 = getElementData(player, "charID")
			local itemSlotID = exports.titan_items:getPlayerFreeSlotID(player)
			if(not itemSlotID or itemSlotID > 35) then
				exports.titan_noti:showBox(player, "Gracz nie ma już miejsca w ekwipunku.")
				return
			end
			local state, itemID = exports.titan_items:itemCreate(1, ownerUID, itemName, 10, itemSlotID, itemVolume, itemVal1, itemVal2, itemVal3)
			if(state) then
				exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono parę kluczy o nazwie \"%s\" (UID: %d).", itemName, itemID))
				exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) stworzył klucze do pojazdu (UID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), itemVal2))
				exports.titan_logs:commandLog(player, command, {...})
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie tworzenia kluczy")
			end
		end
	elseif arg1 == "info" then
		if isPedInVehicle(player) then
			local veh = getPedOccupiedVehicle(player)
			if not exports.titan_vehicles:isVeh(veh) then return exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)") end
			local vehID = veh:getData("vehID")
			local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			exports.titan_vehicles:showVehInfo(player, vehInfo.ID)
		else
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av info [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.")
				return
			end
			exports.titan_vehicles:showVehInfo(player, vehInfo.ID)
			exports.titan_logs:commandLog(player, command, {...})
		end
	elseif arg1 == "tuning" then
		if isPedInVehicle(player) then
			local veh = getPedOccupiedVehicle(player)
			if not exports.titan_vehicles:isVeh(veh) then return exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)") end
			local vehID = veh:getData("vehID")
			local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			exports.titan_vehicles:showVehInfo(player, vehInfo.ID)
		else
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av tuning [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.")
				return
			end
			exports.titan_vehicles:showVehTune(player, vehInfo.ID)
			exports.titan_logs:commandLog(player, command, {...})
		end
	elseif(arg1 == "przypisz") then
		local ID = arg[2]
		local nazwa = string.lower(tostring(arg[3]))
		if isPedInVehicle(player) then
			nazwa = string.lower(tostring(arg[2]))
			local veh = getPedOccupiedVehicle(player)
			if not exports.titan_vehicles:isVeh(veh) then return exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)") end
			ID = tonumber(veh:getData("vehID"))
		else
			if(not tonumber(ID)) then return exports.titan_noti:showBox(player, "TIP: /av przypisz [ID pojazdu] [grupa/gracz/praca]") end
			ID = tonumber(ID)
		end
		if(nazwa == "grupa") then
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if not vehInfo then
				return exports.titan_noti:showBox(player, "Taki pojazd nie istnieje!")
			end
			triggerClientEvent(player, "showAssignVehicleGUI", player, ID, exports.titan_orgs:getAllGroups())
			return
		elseif(nazwa == "gracz") then
			local pID = isPedInVehicle(player) and arg[3] or arg[4]
			if(not tonumber(pID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av przypisz [ID pojazdu] gracz [ID gracza]"))
				return
			end
			pID = tonumber(pID)
			local elem = exports.titan_login:getPlayerByID(pID)
			if(not elem) then
				exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
				return
			end
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Taki pojazd nie istnieje!")
				return
			end
			
			if(exports.titan_vehicles:assignVehicle(ID, 1, getElementData(elem, "charID"))) then
				exports.titan_logs:commandLog(player, command, {...}, elem)
				exports.titan_noti:showBox(player, "Pojazd przypisany pomyślnie.")
				exports.titan_noti:showBox(elem, string.format("Administrator przypisał Tobie pojazd %s (UID: %s).", vehInfo.name, vehInfo.ID))
				if isElement(veh) then
					vehInfo.veh:removeData("hasGPS")
					vehInfo.veh:removeData("gpsGroupID")
					vehInfo.veh:removeData("hasGPSOn")
				end
				if isElement(vehInfo.veh:getData("gpsBlip")) then destroyElement(vehInfo.veh:getData("gpsBlip")) vehInfo.veh:removeData("gpsBlip") end
			
				exports.titan_logs:adminLog(player:getData("globalName"), string.format("%s (UID: %d, CID: %d) Przypisał pojazd %s (UID: %d) do gracza %s (UID: %d, CID: %d)", player:getData("globalName"), player:getData("memberID"), player:getData("charID"), vehInfo.name, vehInfo.ID, exports.titan_chats:getPlayerICName(elem), elem:getData("memberID"), elem:getData("charID")))
				exports.titan_logs:commandLog(player, command, {...})
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd w trakcie przypisywania pojazdu.")
				return
			end
		elseif nazwa == "praca" then
			local pID = isPedInVehicle(player) and arg[3] or arg[4]
			if(not tonumber(pID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av przypisz [ID pojazdu] praca [ID pracy (1 - drwal)]"))
				return
			end
			pID = tonumber(pID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Taki pojazd nie istnieje!")
				return
			end
			exports.titan_vehicles:assignVehicle(ID, 3, pID)
			exports.titan_noti:showBox(player, "Pojazd przypisano pomyślnie.")
		else
			if isPedInVehicle(player) then
				exports.titan_noti:showBox(player, string.format("TIP: /av przypisz [grupa/gracz/praca]"))
			else
				exports.titan_noti:showBox(player, string.format("TIP: /av przypisz [ID pojazdu] [grupa/gracz/praca]"))
			end
			return
		end
	elseif(arg1 == "usun") then
		local ID = arg[2]
		if(not tonumber(ID)) then
			exports.titan_noti:showBox(player, string.format("TIP: /av usun [ID pojazdu]"))
			return
		end
		ID = tonumber(ID)
		if(not exports.titan_vehicles:getVehInfo(ID)) then
			exports.titan_noti:showBox(player, "Taki pojazd nie istnieje!")
			return
		end
		exports.titan_logs:commandLog(player, command, {...})
		exports.titan_vehicles:vehDestroy(ID)
		exports.titan_noti:showBox(player, "Pojazd usunięto pomyślnie.")
	elseif(arg1 == "kolor1") then
		if not getPedOccupiedVehicle(player) then
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av kolor1 [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			if(not exports.titan_vehicles:getVehInfo(ID)) then
				exports.titan_noti:showBox(player, "Taki pojazd nie istnieje!")
				return
			end
			triggerClientEvent(player, "playerChooseVehColor", player, 1, ID)
			return
		else
		triggerClientEvent(player, "playerChooseVehColor", player, 1, getElementData(getPedOccupiedVehicle(player), "vehID"))
		end
		return
	elseif(arg1 == "kolor2") then
		if not getPedOccupiedVehicle(player) then
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av kolor2 [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			if(not exports.titan_vehicles:getVehInfo(ID)) then
				exports.titan_noti:showBox(player, "Taki pojazd nie istnieje!")
				return
			end
			triggerClientEvent(player, "playerChooseVehColor", player, 2, ID)
			return
		else
		triggerClientEvent(player, "playerChooseVehColor", player, 2, getElementData(getPedOccupiedVehicle(player), "vehID"))
		end
		return
	elseif(arg1 == "uid") then
		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(exports.titan_vehicles:isVeh(veh)) then
				local vehInfo = exports.titan_vehicles:getVehInfo(getElementData(veh, "vehID"))
				if(not vehInfo) then return end
				exports.titan_noti:showBox(player, string.format("[VEHICLES] POJAZD %s [UID: %d]", vehInfo.name, vehInfo.ID))
				return
			else
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
		else
			local veh = exports.titan_vehicles:getClosestVehicle(player)
			if(not isElement(veh)) then
				exports.titan_noti:showBox(player, "Nie jesteś obok żadnego pojazdu.")
				return
			end
			if(exports.titan_vehicles:isVeh(veh)) then
				local vehInfo = exports.titan_vehicles:getVehInfo(getElementData(veh, "vehID"))
				if(not vehInfo) then return end
				exports.titan_noti:showBox(player, string.format("[VEHICLES] POJAZD %s [UID: %d]", vehInfo.name, vehInfo.ID))
				return
			else
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
		end
	elseif(arg1 == "tm") then
		local ID = arg[2]
		if(not tonumber(ID)) then
			exports.titan_noti:showBox(player, string.format("TIP: /av tm [ID pojazdu]"))
			return
		end
		ID = tonumber(ID)
		local vehInfo = exports.titan_vehicles:getVehInfo(ID)
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o podanym ID.")
			return
		end

		if(not isElement(vehInfo.veh)) then
			exports.titan_noti:showBox(player, "Pojazd nie jest zespawnowany.")
			return
		end

		local x, y, z = getElementPosition(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)

		x, y = getXYInFrontOfPlayer(player, 3)

		setElementInterior(vehInfo.veh, int)
		setElementDimension(vehInfo.veh, dim)
		setElementPosition(vehInfo.veh, x, y, z + 0.5)
		
	elseif(arg1 == "to") then
		local ID = arg[2]
		if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av to [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o podanym ID.")
				return
			end

			if(not isElement(vehInfo.veh)) then
				exports.titan_noti:showBox(player, "Pojazd nie jest zespawnowany.")
				return
			end

			local x, y, z = getElementPosition(vehInfo.veh)
			local int = getElementInterior(vehInfo.veh)
			local dim = getElementDimension(vehInfo.veh)

			setElementInterior(player, int)
			setElementDimension(player, dim)
			setElementPosition(player, x + 1, y + 1, z)
	elseif(arg1 == "fix") then
		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(exports.titan_vehicles:isVeh(veh)) then
				fixVehicle(veh)
				exports.titan_vehicles:fixBrokenVehicle(getElementData(veh, "vehID"))
				exports.titan_vehicles:saveVeh(getElementData(veh, "vehID"))
				exports.titan_noti:showBox(player, "Pojazd został naprawiony.")
				setVehicleDamageProof(veh, false)
				return
			else
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
		else
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av fix [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)

			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			fixVehicle(vehInfo.veh)
			exports.titan_vehicles:fixBrokenVehicle(getElementData(vehInfo.veh, "vehID"))
			exports.titan_vehicles:saveVeh(getElementData(vehInfo.veh, "vehID"))
			exports.titan_noti:showBox(player, "Pojazd został naprawiony.")
			return
		end
	elseif(arg1 == "flash") then
		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(exports.titan_vehicles:isVeh(veh)) then
				local flashID = arg[2]
				if(not tonumber(flashID)) then
					exports.titan_noti:showBox(player, string.format("TIP: /av flash [Typ świateł]"))
					return
				end
				flashID = tonumber(flashID)
				local vehID = getElementData(veh, "vehID")
				if(not tonumber(vehID)) then return end
				if(exports.titan_vehicles:setVehFlashType(vehID, flashID)) then
					exports.titan_noti:showBox(player, "Typ świateł [emergency] został pomyślnie zmieniony!")
				else
					exports.titan_noti:showBox(player, "Wystąpił błąd.")
				end
				return
			else
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
		else
			local ID = arg[2]
			local flashID = arg[3]
			if(not tonumber(ID) or not tonumber(flashID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av flash [ID pojazdu] [Typ świateł]"))
				return
			end
			ID = tonumber(ID)
			flashID = tonumber(flashID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			if(exports.titan_vehicles:setVehFlashType(vehInfo.ID, flashID)) then
				exports.titan_noti:showBox(player, "Typ świateł [emergency] został pomyślnie zmieniony!")
			else
				exports.titan_noti:showBox(player, "Wystąpił błąd.")
			end
			return
		end
	elseif arg1 == "siren" then
		if(isPedInVehicle(player)) then
			local veh = getPedOccupiedVehicle(player)
			if(exports.titan_vehicles:isVeh(veh)) then
				local flashID = arg[2]
				if(not tonumber(flashID)) then
					exports.titan_noti:showBox(player, string.format("TIP: /av siren [Typ syren]"))
					return
				end
				flashID = tonumber(flashID)
				local vehID = getElementData(veh, "vehID")
				if(not tonumber(vehID)) then return end
				exports.titan_vehicles:changeVehicleData(vehID, "sirenType", flashID)
				setElementData(veh, "siren:type", flashID)
				exports.titan_noti:showBox(player, "Pomyślnie zmieniono typ syren.")
				return
			else
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
		else
			local ID = arg[2]
			local flashID = arg[3]
			if(not tonumber(ID) or not tonumber(flashID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av siren [ID pojazdu] [Typ syren]"))
				return
			end
			ID = tonumber(ID)
			flashID = tonumber(flashID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			exports.titan_vehicles:changeVehicleData(vehInfo.ID, "sirenType", flashID)
			if isElement(vehInfo.veh) then setElementData(vehInfo.veh, "siren:type", flashID) end
			exports.titan_noti:showBox(player, "Pomyślnie zmieniono typ syren.")
			return
		end
	elseif(arg1 == "fuel") then
		local ID = arg[2]
		local fuel = arg[3]
		if isPedInVehicle(player) then
			fuel = arg[2]
			if not tonumber(fuel) then return exports.titan_noti:showBox(player, "TIP: /av fuel [Ilość paliwa]") end
			fuel = tonumber(fuel)
			local veh = getPedOccupiedVehicle(player)
			if not exports.titan_vehicles:isVeh(veh) then return exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)") end
			ID = tonumber(veh:getData("vehID"))
		else
			if(not tonumber(ID) or not tonumber(fuel)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av fuel [ID pojazdu] [Ilość paliwa]"))
				return
			end
			ID = tonumber(ID)
			fuel = tonumber(fuel)
		end
		if(fuel < 0) then return end
		local vehInfo = exports.titan_vehicles:getVehInfo(ID)
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
			return
		end
		if(vehInfo.maxfuel < fuel) then fuel = vehInfo.maxfuel end
		exports.titan_vehicles:changeVehicleData(vehInfo.ID, "fuel", fuel)
		exports.titan_noti:showBox(player, "Pomyślnie zmieniono ilość paliwa.")
		if(isElement(vehInfo.veh)) then setElementData(vehInfo.veh, "vehFuel", fuel) end
	elseif arg1 == "windows" then
		local ID = arg[2]
		local typ = arg[3]
		if(not tonumber(ID) or not tonumber(typ)) then
			exports.titan_noti:showBox(player, string.format("TIP: /av windows [ID pojazdu] [wartość] (1 - włączone, 0 - wyłączone)"))
			return
		end
		ID = tonumber(ID)
		typ = tonumber(typ)
		if(typ ~= 1 and typ ~= 0) then return end
		local vehInfo = exports.titan_vehicles:getVehInfo(ID)
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
			return
		end
		exports.titan_vehicles:changeVehicleData(vehInfo.ID, "darkWindows", typ)
		exports.titan_noti:showBox(player, "Pomyślnie zmieniono typ szyb.")
		if(isElement(vehInfo.veh)) then setElementData(vehInfo.veh, "vehDarkWindows", typ) end
	elseif(arg1 == "alarm") then
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av alarm [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			if(vehInfo.hasAlarm == 1) then exports.titan_vehicles:changeVehicleData(vehInfo.ID, "hasAlarm", 0)
			else exports.titan_vehicles:changeVehicleData(vehInfo.ID, "hasAlarm", 1) end
			exports.titan_noti:showBox(player, string.format("Alarm został %s.", vehInfo.hasAlarm == 1 and "wyłączony" or "włączony"))
			return
	elseif(arg1 == "respawn") then
		local vehs = exports.titan_vehicles:getAllVehicles()
		for k, v in ipairs(vehs) do
			if isElement(v.veh) then
				if isVehicleEmpty(v.veh) then
					respawnVehicle(v.veh)
					exports.titan_vehicles:turnOffVeh(k)
				end
			end
		end
		outputChatBox("** Administrator zrespawnował wszystkie pojazdy. **", root, 255, 0, 0)
	elseif arg1 == "rveh" then
		local vehID = arg[2]
		if not tonumber(vehID) then return exports.titan_noti:showBox(player, "TIP: /av rveh [UID pojazdu]") end
		vehID = tonumber(vehID)
		local vehInfo, vehIndex = exports.titan_vehicles:getVehInfo(vehID)
		if not vehInfo then return exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.") end
		if not isElement(vehInfo.veh) then return exports.titan_noti:showBox(player, "Pojazd nie jest zespawnowany.") end
		if not isVehicleEmpty(vehInfo.veh) then return exports.titan_noti:showBox(player, "Pojazd nie jest pusty.") end
		respawnVehicle(vehInfo.veh)
		exports.titan_vehicles:turnOffVeh(vehIndex)
		exports.titan_noti:showBox(player, string.format("Pojazd %s (UID: %d) został przeniesiony na miejsce spawnu.", vehInfo.name, vehInfo.ID))
	elseif arg1 == "audio" then
		if isPedInVehicle(player) then
			local veh = getPedOccupiedVehicle(player)
			if not exports.titan_vehicles:isVeh(veh) then return exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)") end
			local vehID = veh:getData("vehID")
			local vehInfo = exports.titan_vehicles:getVehInfo(vehID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Pojazd nie stworzony przez system pojazdów ;)")
				return
			end
			if vehInfo.caraudio == 1 then
				exports.titan_vehicles:changeVehicleData(vehInfo.ID, "caraudio", 0)
				veh:removeData("carAudio")
				exports.titan_noti:showBox(player, "Car Audio zostało usunięte z pojazdu.")
			else
				exports.titan_vehicles:changeVehicleData(vehInfo.ID, "caraudio", 1)
				veh:setData("carAudio", true)
				exports.titan_noti:showBox(player, "Car Audio zostało zamontowane w pojeździe.")
			end
		else
			local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av audio [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.")
				return
			end
			if vehInfo.caraudio == 1 then
				exports.titan_vehicles:changeVehicleData(vehInfo.ID, "caraudio", 0)
				if isElement(vehInfo.veh) then vehInfo.veh:removeData("carAudio") end
				exports.titan_noti:showBox(player, "Car Audio zostało usunięte z pojazdu.")
			else
				exports.titan_vehicles:changeVehicleData(vehInfo.ID, "caraudio", 1)
				exports.titan_noti:showBox(player, "Car Audio zostało zamontowane w pojeździe.")
			end
		end
	elseif arg1 == "spawn" then
		local ID = arg[2]
			if(not tonumber(ID)) then
				exports.titan_noti:showBox(player, string.format("TIP: /av spawn [ID pojazdu]"))
				return
			end
			ID = tonumber(ID)
			local vehInfo = exports.titan_vehicles:getVehInfo(ID)
			if(not vehInfo) then
				exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.")
				return
			end
			if isElement(vehInfo.veh) and not isVehicleEmpty(vehInfo.veh) then return exports.titan_noti:showBox(player, "Pojazd nie jest pusty.") end
			if isElement(vehInfo.veh) then
				exports.titan_vehicles:uSVehicle(vehInfo.ID)
				exports.titan_noti:showBox(player, string.format("Pojazd %s (UID: %d) został odspawnowany.", vehInfo.name, vehInfo.ID))
				return
			else
				exports.titan_vehicles:sVehicle(vehInfo.ID)
				exports.titan_noti:showBox(player, string.format("Pojazd %s (UID: %d) został zespawnowany.", vehInfo.name, vehInfo.ID))
				return
			end
	elseif arg1 == "pj" then
		local ID = arg[2]
		local pj = arg[3]
		if not tonumber(ID) or not tonumber(pj) then
			exports.titan_noti:showBox(player, "TIP: /av pj [ID pojazdu] [ID paintjoba]")
			return
		end
		ID = tonumber(ID)
		pj = tonumber(pj)
		local vehInfo = exports.titan_vehicles:getVehInfo(ID)
		if(not vehInfo) then
			exports.titan_noti:showBox(player, "Nie znaleziono pojazdu o takim ID.")
			return
		end
		if pj < 0 then return exports.titan_noti:showBox(player, "Paintjob musi być większy lub równy od 0.") end
		exports.titan_vehicles:changeVehicleData(vehInfo.ID, "customPj", pj)
		if isElement(vehInfo.veh) then
			setElementData(vehInfo.veh, "customPJ", pj)
			exports.titan_paintjobs:updatePaintjob(vehInfo.veh)
		end
		exports.titan_noti:showBox(player, "Pomyślnie zmieniono paintjoba pojazdu.")
	elseif arg1 == "flip" then
		local veh = getPedOccupiedVehicle(player)
		if(not isElement(veh)) then return false end
		local x, y, z = getElementRotation(veh)
		setElementRotation(veh, 0, 0, z)
		return
	else
		exports.titan_noti:showBox(player, string.format("TIP: /av ["..legend.."]"))
		return
	end

end
addCommandHandler("av", cmdAv, false, false)

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y
end

function isVehicleEmpty( vehicle )
	if not isElement( vehicle ) or getElementType( vehicle ) ~= "vehicle" then
		return true
	end
 
	local passengers = getVehicleMaxPassengers( vehicle )
	if type( passengers ) == 'number' then
		for seat = 0, passengers do
			if getVehicleOccupant( vehicle, seat ) then
				return false
			end
		end
	end
	return true
end