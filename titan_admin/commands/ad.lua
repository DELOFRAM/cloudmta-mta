----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:09
-- Ostatnio zmodyfikowano: 2016-01-10 14:03:53
----------------------------------------------------

function cmdAD(player, command, ...)
	if not doesAdminHavePerm(player, "doors") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end

	local arg = {...}
	local mode = string.lower(tostring(arg[1]))
	if mode == "interior" then
		local option = string.lower(tostring(arg[2]))
		if option == "stworz" then
			local noun = string.lower(tostring(arg[3]))
			if noun == "gracz" then
				local playerID = arg[4]
				local name = table.concat(arg, " ", 5)
				if not tonumber(playerID) or string.len(tostring(name)) < 3 then
					return exports.titan_noti:showBox(player, "TIP: /ad interior stworz gracz [ID gracza] [Nazwa]")
				end
				playerID = tonumber(playerID)
				name = tostring(name)
				local target = exports.titan_login:getPlayerByID(playerID)
				if not target then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
				
				local ID, dimID = exports.titan_doors:doorCreate(1, getElementData(target, "charID"), name)
				if ID then
					return exports.titan_noti:showBox(player, string.format("Stworzono drzwi.\nWłaściciel: %s\nUID: %d, VW: %d", exports.titan_chats:getPlayerICName(target), ID, dimID))
				else
					return exports.titan_noti:showBox(player, "Wystapił bład w momencie tworzenia interioru.")
				end

			elseif noun == "grupa" then
				local groupID = arg[4]
				local name = table.concat(arg, " ", 5)
				if not tonumber(groupID) or string.len(tostring(name)) < 3 then
					return exports.titan_noti:showBox(player, "TIP: /ad interior stworz grupa [ID grupy] [Nazwa]")
				end
				groupID = tonumber(groupID)
				name = tostring(name)

				local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
				if not groupInfo then return exports.titan_noti:showBox(player, "Grupa o takim ID nie istnieje.") end
				local ID, dimID = exports.titan_doors:doorCreate(2, groupInfo.ID, name)
				if ID then
					return exports.titan_noti:showBox(player, string.format("Stworzono drzwi.\nWłaściciel: %s\nUID: %d, VW: %d", groupInfo.name, ID, dimID))
				else
					return exports.titan_noti:showBox(player, "Wystapił bład w momencie tworzenia interioru.")
				end
			else
				return exports.titan_noti:showBox(player, "TIP: /ad interior stworz [gracz, grupa]")
			end
		elseif option == "usun" then
			local intID = arg[3]
			if not tonumber(intID) then
				return exports.titan_noti:showBox(player, "TIP: /ad interior usun [ID interioru]")
			end
			intID = tonumber(intID)
			local intInfo = exports.titan_doors:getDoorInfo(intID)
			if not intInfo then
				return exports.titan_noti:showBox(player, "Nie znaleziono interioru o takim ID.")
			end
			if exports.titan_doors:doorDestroy(intInfo.ID) then
				return exports.titan_noti:showBox(player, "Skasowano interior o podanym ID.")
			else
				return exports.titan_noti:showBox(player, "Nie udało się skasować interioru o podanym ID.")
			end
		elseif option == "przypisz" then
			local noun = string.lower(tostring(arg[3]))
			if noun == "gracz" then
				local intID = arg[4]
				local playerID = arg[5]
				if not tonumber(intID) or not tonumber(playerID) then
					return exports.titan_noti:showBox(player, "TIP: /ad interior przypisz gracz [ID interioru] [ID gracza]")
				end
				intID = tonumber(intID)
				playerID = tonumber(playerID)
				local target = exports.titan_login:getPlayerByID(playerID)
				if not target then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
				
				local intInfo = exports.titan_doors:getDoorInfo(intID)
				if not intInfo then
					return exports.titan_noti:showBox(player, "Nie znaleziono interioru o takim ID.")
				end
				exports.titan_doors:changeInteriorData(intInfo.ID, "ownerType", 1)
				exports.titan_doors:changeInteriorData(intInfo.ID, "owner", getElementData(target, "charID"))
				exports.titan_noti:showBox(player, string.format("Przypisałeś interior o UID %d graczowi %s.", intInfo.ID, exports.titan_chats:getPlayerICName(target)))
				exports.titan_noti:showBox(target, string.format("Administrator %s przypisał Ci interior o UID %d.", getElementData(player, "globalName"), intInfo.ID))
				return
			elseif noun == "grupa" then
				local intID = arg[4]
				local groupID = arg[5]
				if not tonumber(intID) or not tonumber(groupID) then
					return exports.titan_noti:showBox(player, "TIP: /ad interior przypisz grupa [ID interioru] [ID grupy]")
				end
				intID = tonumber(intID)
				groupID = tonumber(groupID)
				local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
				if not groupInfo then
					return exports.titan_noti:showBox(player, "Grupa o takim ID nie istnieje.")
				end
				local intInfo = exports.titan_doors:getDoorInfo(intID)
				if not intInfo then
					return exports.titan_noti:showBox(player, "Nie znaleziono interioru o takim ID.")
				end
				exports.titan_doors:changeInteriorData(intInfo.ID, "ownerType", 2)
				exports.titan_doors:changeInteriorData(intInfo.ID, "owner", groupInfo.ID)
				exports.titan_noti:showBox(player, string.format("Przypisałeś interior o UID %d grupie %s.", intInfo.ID, groupInfo.name))
				return
			elseif noun == "manual" then
				local intID = arg[4]
				local ownerType = arg[5]
				local owner = arg[6]
				if not tonumber(intID) or not tonumber(ownerType) or not tonumber(owner) then
					return exports.titan_noti:showBox(player, "TIP: /ad interior przypisz manual [ID interioru] [ownerType] [owner]")
				end
				intID = tonumber(intID)
				ownerType = tonumber(ownerType)
				owner = tonumber(owner)
				local intInfo = exports.titan_doors:getDoorInfo(intID)
				if not intInfo then
					return exports.titan_noti:showBox(player, "Nie znaleziono interioru o takim ID.")
				end
				exports.titan_doors:changeInteriorData(intInfo.ID, "ownerType", ownerType)
				exports.titan_doors:changeInteriorData(intInfo.ID, "owner", owner)
				exports.titan_noti:showBox(player, string.format("Przypisałeś interior o UID %d Typowi %d i ID %d.", intInfo.ID, ownerType, owner))
			else
				return exports.titan_noti:showBox(player, "TIP: /ad interior przypisz [gracz, grupa]")
			end
		else
			return exports.titan_noti:showBox(player, "TIP: /ad interior [stworz, usun, przypisz]")
		end
	elseif mode == "pickup" then
		local option = string.lower(tostring(arg[2]))
		if option == "uid" then
			local doorID = getElementData(player, "nearestDoorID")
			local doorType = getElementData(player, "nearestDoorType")
			if not tonumber(doorID) then
				return exports.titan_noti:showBox(player, "Nie stoisz przy żadnych drzwiach.")
			end
			local pickupInfo = exports.titan_doors:getPickupInfo(doorID)
			if not pickupInfo then
				return exports.titan_noti:showBox(player, "Nie znaleziono takiego pickupa w systemie.")
			end
			return exports.titan_noti:showBox(player, string.format("Drzwi %s, UID %d: %s", pickupInfo.type == 1 and "WEJŚCIOWE" or "WYJŚCIOWE", pickupInfo.ID, pickupInfo.name))
		elseif option == "stworz" then
			local intID = arg[3]
			local name = table.concat(arg, " ", 4)
			if not tonumber(intID) or string.len(name) < 1 then return exports.titan_noti:showBox(player, "TIP: /ad pickup stworz [ID interioru] [Nazwa]") end
			intID = tonumber(intID)
			name = tostring(name)

			if not exports.titan_doors:getDoorInfo(intID) then return exports.titan_noti:showBox(player, "Interior o takim ID nie istnieje.") end
			local posX, posY, posZ = getElementPosition(player)
			local rotX, rotY, rotZ = getElementRotation(player)
			local interior = getElementInterior(player)
			local dimension = getElementDimension(player)
			local pickupID = exports.titan_doors:doorPickupEnterCreate(intID, 1239, posX, posY, posZ, rotZ, interior, dimension, name)
			if tonumber(pickupID) then
				return exports.titan_noti:showBox(player, string.format("Poprawnie stworzono drzwi. Przybrały one UID %d.", pickupID))
			else
				return exports.titan_noti:showBox(player, "Wystąpił jakiś błąd.")
			end
		elseif option == "usun" then
			local pickupID = arg[3]
			if not tonumber(pickupID) then
				return exports.titan_noti:showBox(player, "TIP: /ad pickup usun [ID pickupa]")
			end
			pickupID = tonumber(pickupID)
			if not exports.titan_doors:getPickupInfo(pickupID) then
				return exports.titan_noti:showBox(player, "Nie istnieje pickup o podanym ID.")
			end
			if exports.titan_doors:doorPickupDestroy(pickupID) then
				return exports.titan_noti:showBox(player, "Pickupy usunięte pomyślnie.")
			else
				return exports.titan_noti:showBox(player, "Coś poszło nie tak.")
			end
		elseif option == "wejscie" then
			local doorID = arg[3]
			if not tonumber(doorID) then
				return exports.titan_noti:showBox(player, "TIP: /ad pickup wejscie [ID pickupa]")
			end
			doorID = tonumber(doorID)
			local info = exports.titan_doors:getPickupInfo(doorID)
			if not info then
				return exports.titan_noti:showBox(player, "Nie znaleziono takich drzwi.")
			end

			local intInfo = exports.titan_doors:getDoorInfo(info.parentID)
			if not intInfo then
				return exports.titan_noti:showBox(player, "Interior do którego drzwi są przypisane nie istnieje.")
			end

			local pX, pY, pZ = getElementPosition(player)
			local rX, rY, rZ = getElementRotation(player)
			local int = getElementInterior(player)
			local dim = getElementDimension(player)

			if exports.titan_doors:doorPickupEnterChange(doorID, pX, pY, pZ, rZ, int, dim, 1239) then
				return exports.titan_noti:showBox(player, "Pomyślnie ustawiono wyjście.")
			else
				return exports.titan_noti:showBox(player, "Coś poszło nie tak.")
			end
		elseif option == "wyjscie" then
			local doorID = arg[3]
			if not tonumber(doorID) then
				return exports.titan_noti:showBox(player, "TIP: /ad pickup wyjscie [ID pickupa]")
			end
			doorID = tonumber(doorID)
			local info = exports.titan_doors:getPickupInfo(doorID)
			if not info then
				return exports.titan_noti:showBox(player, "Nie znaleziono takich drzwi.")
			end

			local intInfo = exports.titan_doors:getDoorInfo(info.parentID)
			if not intInfo then
				return exports.titan_noti:showBox(player, "Interior do którego drzwi są przypisane nie istnieje.")
			end

			local pX, pY, pZ = getElementPosition(player)
			local rX, rY, rZ = getElementRotation(player)
			local int = getElementInterior(player)
			local dim = getElementDimension(player)

			if intInfo.dimension ~= dim  then
				return exports.titan_noti:showBox(player, string.format("Drzwi wyjściowe muszą znajdować się na virtualworldzie %d", intInfo.dimension))
			end

			if exports.titan_doors:doorPickupLeaveCreate(doorID, pX, pY, pZ, rZ, int, dim, 1318) then
				return exports.titan_noti:showBox(player, "Pomyślnie ustawiono wyjście.")
			else
				return exports.titan_noti:showBox(player, "Coś poszło nie tak.")
			end
		elseif option == "przejazd" then
			local doorID = arg[3]
			if not tonumber(doorID) then
				return exports.titan_noti:showBox(player, "TIP: /ad pickup przejazd [ID pickupa]")
			end
			doorID = tonumber(doorID)
			local pickupInfo = exports.titan_doors:getPickupInfo(doorID)
			if not pickupInfo then
				return exports.titan_noti:showBox(player, "Nie znaleziono takich drzwi.")
			end
			local intInfo = exports.titan_doors:getDoorInfo(pickupInfo.parentID)
			if not intInfo then
				return exports.titan_noti:showBox(player, "Interior do którego drzwi są przypisane nie istnieje.")
			end
			exports.titan_doors:changePickupData(pickupInfo.ID, "vehpass", pickupInfo.vehpass == 1 and 0 or 1)
			return exports.titan_noti:showBox(player, string.format("%s możliwość przejeżdżania pojazdami przez pickup %s.", pickupInfo.vehpass == 1 and "wyłaczyłeś" or "właczyłeś", pickupInfo.name))
		else
			return exports.titan_noti:showBox(player, "TIP: /ad pickup [uid, stworz, usun, wejscie, wyjscie, przejazd]")
		end
	else
		return exports.titan_noti:showBox(player, "TIP: /ad [interior, pickup]")
	end
end
addCommandHandler("ad", cmdAD, false, false)
--[[
function cmdAd(player, command, ...)
	if not doesAdminHavePerm(player, "doors") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end

	local legend = "pickuppstworz, pwyjscie, pusun, istworz, iusun, iprzypisz, przejazd"
	local arg = {...}
	local arg1 = arg[1]
	arg1 = string.lower(tostring(arg1))
	if(arg1 == "pstworz") then
		local intID = arg[2]
		local name = table.concat(arg, " ", 3)

		if(not tonumber(intID) or string.len(name) < 1) then
			outputChatBox(string.format("TIP: /ad pstworz [parent ID] [nazwa]"), player, 180, 180, 180)
			return
		end
		intID = tonumber(intID)
		name = tostring(name)

		local pX, pY, pZ = getElementPosition(player)
		local rX, rY, rZ = getElementRotation(player)

		if(not exports.titan_doors:getDoorInfo(intID)) then
			exports.titan_noti:showBox(player, "Interior o takim ID nie istnieje.")
			return
		end
		local pX, pY, pZ = getElementPosition(player)
		local rX, rY, rZ = getElementRotation(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
		local lastID = exports.titan_doors:doorPickupEnterCreate(intID, 1239, pX, pY, pZ, rZ, int, dim, name)
		if(tonumber(lastID)) then
			exports.titan_noti:showBox(player, string.format("Poprawnie stworzono drzwi. Przybrały one UID %d.", lastID))
		else
			exports.titan_noti:showBox(player, "Wystąpił jakiś błąd.")
			return
		end
	elseif arg1 == "iprzypisz" then
		local time = getTickCount()
		local noun = string.lower(tostring(arg[3]))
		local iID = arg[2]
		local oID = arg[4]
		if not tonumber(iID) then return exports.titan_noti:showBox(player, "TIP: /ad iprzypisz [ID interioru] [gracz, grupa]") end
		iID = tonumber(iID)
		local intInfo = exports.titan_doors:getDoorInfo(iID)
		if not intInfo then return exports.titan_noti:showBox(player, "Taki interior nie istnieje") end
		if noun == "gracz" then
			if not tonumber(oID) then return exports.titan_noti:showBox(player, "TIP: /ad iprzypisz [ID interioru] gracz [ID gracza]") end
			oID = tonumber(oID)
			local target = exports.titan_login:getPlayerByID(oID)
			if not target then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
			oID = target:getData("charID")
			exports.titan_doors:changeInteriorData(intInfo.ID, "ownerType", 1)
			exports.titan_doors:changeInteriorData(intInfo.ID, "owner", oID)
			exports.titan_noti:showBox(player, "Pomyślnie przypisano drzwi do gracza.")
			outputChatBox(string.format("* Administrator przypisał Ci drzwi o nazwie \"%s\".", intInfo.name), target, 0, 255, 0)
			outputDebugString(string.format("[DOORS] Przypisano interior (UID: %s, ownerType: 1, owner: %s), Administrator: %s. | %d ms", tostring(intInfo.ID), player:getData("globalName"), tostring(oID), getTickCount() - time))
		elseif noun == "grupa" then
			if not tonumber(oID) then return exports.titan_noti:showBox(player, "TIP: /ad iprzypisz [ID interioru] grupa [ID grupy]") end
			oID = tonumber(oID)
			local groupInfo = exports.titan_orgs:getGroupInfo(oID)
			if not groupInfo then return exports.titan_noti:showBox(player, "Grupa o takim ID nie istnieje.") end
			oID = groupInfo.ID
			exports.titan_doors:changeInteriorData(intInfo.ID, "ownerType", 2)
			exports.titan_doors:changeInteriorData(intInfo.ID, "owner", oID)
			exports.titan_noti:showBox(player, "Pomyślnie przypisano drzwi do grupy \""..groupInfo.name.."\".")
			outputDebugString(string.format("[DOORS] Przypisano interior (UID: %s, ownerType: 2, owner: %s), Administrator: %s. | %d ms", tostring(intInfo.ID), player:getData("globalName"), tostring(oID), getTickCount() - time))
		else
			return exports.titan_noti:showBox(player, "TIP: /ad iprzypisz [ID interioru] [gracz, grupa]")
		end
	elseif(arg1 == "pwyjscie") then
		local doorID = arg[2]
		if(not tonumber(doorID)) then
			outputChatBox(string.format("TIP: /ad pwyjscie [doorID]"), player, 180, 180, 180)
			return
		end
		doorID = tonumber(doorID)
		local info = exports.titan_doors:getPickupInfo(doorID)
		if(not info) then
			exports.titan_noti:showBox(player, "Nie znaleziono takich drzwi.")
			return
		end

		local intInfo = exports.titan_doors:getDoorInfo(info.parentID)
		if(not intInfo) then
			exports.titan_noti:showBox(player, "Interior do którego drzwi są przypisane nie istnieje.")
			return
		end

		local pX, pY, pZ = getElementPosition(player)
		local rX, rY, rZ = getElementRotation(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)

		if(intInfo.dimension ~= dim) then
			exports.titan_noti:showBox(player, string.format("Drzwi wyjściowe muszą znajdować się na virtualworldzie %d", intInfo.dimension))
			return
		end

		if(exports.titan_doors:doorPickupLeaveCreate(doorID, pX, pY, pZ, rZ, int, dim, 1318)) then
			exports.titan_noti:showBox(player, "Pomyślnie ustawiono wyjście.")
		else
			exports.titan_noti:showBox(player, "Coś poszło nie tak.")
		end
	elseif(arg1 == "pwejscie") then
		local doorID = arg[2]
		if(not tonumber(doorID)) then
			outputChatBox(string.format("TIP: /ad pwejscie [doorID]"), player, 180, 180, 180)
			return
		end
		doorID = tonumber(doorID)
		local info = exports.titan_doors:getPickupInfo(doorID)
		if(not info) then
			exports.titan_noti:showBox(player, "Nie znaleziono takich drzwi.")
			return
		end

		local intInfo = exports.titan_doors:getDoorInfo(info.parentID)
		if(not intInfo) then
			exports.titan_noti:showBox(player, "Interior do którego drzwi są przypisane nie istnieje.")
			return
		end

		local pX, pY, pZ = getElementPosition(player)
		local rX, rY, rZ = getElementRotation(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)

		if(exports.titan_doors:doorPickupEnterChange(doorID, pX, pY, pZ, rZ, int, dim, 1239)) then
			exports.titan_noti:showBox(player, "Pomyślnie ustawiono wyjście.")
		else
			exports.titan_noti:showBox(player, "Coś poszło nie tak.")
		end
	elseif(arg1 == "pusun") then
		local pickupID = arg[2]
		if(not tonumber(pickupID)) then
			outputChatBox(string.format("TIP: /ad pusun [ID pickupa]"), player, 180, 180, 180)
			return
		end
		pickupID = tonumber(pickupID)

		if(not exports.titan_doors:getPickupInfo(pickupID)) then
			exports.titan_noti:showBox(player, "Nie istnieje pickup o podanym ID.")
			return
		end
		if(exports.titan_doors:doorPickupDestroy(pickupID)) then
			exports.titan_noti:showBox(player, "Pickupy usunięte pomyślnie.")
		else
			exports.titan_noti:showBox(player, "Coś poszło nie tak.")
		end
	elseif arg1 == "przejazd" then
		local pickupID = arg[2]
		if(not tonumber(pickupID)) then
			exports.titan_noti:showBox(player, "TIP: /ad przejazd [ID pickupa]")
			return
		end
		pickupID = tonumber(pickupID)

		local pickupInfo = exports.titan_doors:getPickupInfo(pickupID)
		if(not pickupInfo) then
			exports.titan_noti:showBox(player, "Nie istnieje pickup o podanym ID.")
			return
		end

	elseif(arg1 == "istworz") then
		local ownerType = arg[2]
		local owner = arg[3]
		local name = table.concat(arg, " ", 4)
		if(not tonumber(ownerType) or not tonumber(owner) or not name or string.len(tostring(name)) < 1) then
			outputChatBox(string.format("TIP: /ad istworz [ownerType] [owner] [nazwa]", legend), player, 180, 180, 180)
			return
		end
		ownerType = tonumber(ownerType)
		owner = tonumber(owner)
		name = tostring(name)
		local ID, dimID = exports.titan_doors:doorCreate(ownerType, owner, name)
		if(tonumber(ID)) then
			exports.titan_noti:showBox(player, string.format("Pomyślnie stworzono interior. Przyjął on UID %d, a virtualworld na którym się znajduje to %d.", ID, dimID))
			return
		else
			exports.titan_noti:showBox(player, "Wystąpił jakiś błąd.")
			return
		end
	else
		exports.titan_noti:showBox(player, "TIP: /ad ["..legend.."]")
		return
	end
end]]