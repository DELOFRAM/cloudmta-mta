----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:13
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:16
----------------------------------------------------

function cmdAset(player, command, arg1, arg2, arg3, ...)
	if not doesAdminHavePerm(player, "aset") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local legend = "int, vw, hp, admin, addmoney, cp, time, weather, skin, nick, glod, ws"
	arg1 = string.lower(tostring(arg1))
	if(arg1 == "int") then
		if(not tonumber(arg2) or not tonumber(arg3)) then
			exports.titan_noti:showBox(player, string.format("TIP: /aset int [ID gracza] [Numer interioru]"))
			return
		end
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)

		local target = exports.titan_login:getPlayerByID(arg2)
		if(not isElement(target)) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end

		if(arg3 < 0) then
			exports.titan_noti:showBox(player, "Niepoprawny interior.")
			return
		end
		setElementInterior(target, arg3)
		if(isPedInVehicle(target) and getVehicleOccupant(getPedOccupiedVehicle(target)) == target) then
			setElementInterior(getPedOccupiedVehicle(target), arg3)
		end
		exports.titan_noti:showBox(player, "Zmieniłeś interior graczowi na "..arg3..".")
		exports.titan_noti:showBox(target, "Administrator zmienił Ci interior na "..arg3..".")
		return
	elseif(arg1 == "vw") then
		if(not tonumber(arg2) or not tonumber(arg3)) then
			exports.titan_noti:showBox(player, string.format("TIP: /aset vw [ID gracza] [Numer vw]"))
			return
		end
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)

		local target = exports.titan_login:getPlayerByID(arg2)
		if(not isElement(target)) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end

		if(arg3 < 0) then
			exports.titan_noti:showBox(player, "Niepoprawny vw.")
			return
		end
		setElementDimension(target, arg3)
		if(isPedInVehicle(target) and getVehicleOccupant(getPedOccupiedVehicle(target)) == target) then
			setElementDimension(getPedOccupiedVehicle(target), arg3)
		end
		exports.titan_noti:showBox(player, "Zmieniłeś vw graczowi na "..arg3..".")
		exports.titan_noti:showBox(target, "Administrator zmienił Ci vw na "..arg3..".")
		return
	elseif(arg1 == "hp") then
		if(not tonumber(arg2) or not tonumber(arg3)) then
			outputChatBox(string.format("TIP: /aset hp [ID gracza] [Ilość hp]"), player, 180, 180, 180)
			return
		end
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)

		local target = exports.titan_login:getPlayerByID(arg2)
		if(not isElement(target)) then
			outputChatBox("Nie znaleziono gracza o podanym ID.", player, 180, 180, 180)
			return
		end
		if(arg3 < 0) then arg3 = 0 end
		setElementHealth(target, arg3)
		exports.titan_noti:showBox(player, "Zmieniłeś hp graczowi na "..arg3..".")
		exports.titan_noti:showBox(target, "Administrator zmienił Ci hp na "..arg3..".")
	elseif(arg1 == "glod") then
		if(not tonumber(arg2) or not tonumber(arg3)) then
			outputChatBox(string.format("TIP: /aset glod [ID gracza] [Ilość glodu]"), player, 180, 180, 180)
			return
		end
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)

		local target = exports.titan_login:getPlayerByID(arg2)
		if(not isElement(target)) then
			outputChatBox("Nie znaleziono gracza o podanym ID.", player, 180, 180, 180)
			return
		end
		if(arg3 < 0) then arg3 = 0 end
		target:setData("hungryLevel",arg3)
		exports.titan_noti:showBox(player, "Zmieniłeś głód graczowi na "..arg3..".")
		exports.titan_noti:showBox(target, "Administrator zmienił Ci głód na "..arg3..".")


	elseif arg1 == "ws" then
		if not tonumber(arg2) then
			return exports.titan_noti:showBox(player, "TIP: /aset ws [ID gracza]")
		end
		arg2 = tonumber(arg2)
		local target = exports.titan_login:getPlayerByID(arg2)
		if not isElement(target) then
			outputChatBox("Nie znaleziono gracza o podanym ID.", player, 180, 180, 180)
			return
		end
		exports.titan_noti:showBox(player, string.format("Walking Style gracza %s to %d.", exports.titan_chats:getPlayerICName(target), getPedWalkingStyle(target)))
	elseif(arg1 == "admin") then
		if not doesAdminHavePerm(player, "manageadmins") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
		if(not tonumber(arg2)) then
			exports.titan_noti:showBox(player, string.format("TIP: /aset admin [ID gracza]"))
			return
		end
		arg2 = tonumber(arg2)

		local target = exports.titan_login:getPlayerByID(arg2)
		if(not isElement(target)) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end

		local tmpTable = 
		{
			elem = target,
			perms = target:getData("adminPerms")
		}
		triggerClientEvent(player, "eAdminData.create", player, tmpTable)
	elseif(arg1 == "addmoney") then
		if not doesAdminHavePerm(player, "aset_money") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
		if(not tonumber(arg2) or not tonumber(arg3)) then
			exports.titan_noti:showBox(player, string.format("TIP: /aset addmoney [ID gracza] [ilość pieniędzy]"))
			return
		end
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)

		local target = exports.titan_login:getPlayerByID(arg2)
		if(not isElement(target)) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end
		if(arg3 < 0) then
			exports.titan_cash:takePlayerCash(target, math.abs(arg3))
			exports.titan_noti:showBox(target, string.format("* Zostało Ci zabrane $%s przez administratora.", tostring(arg3):gsub("-", "")))
			exports.titan_noti:showBox(player, string.format("* Zabrałeś $%s graczowi o ID %d.", tostring(arg3):gsub("-", ""), arg2))
			exports.titan_logs:playerLog(target, "cash", string.format("Oddano pieniądze dla: (Administrator) %s (UID: %d, CID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(player), player:getData("memberID"), player:getData("charID"), math.abs(arg3)))
		else
			exports.titan_cash:addPlayerCash(target, arg3)
			exports.titan_noti:showBox(player, string.format("* Dałeś $%d graczowi o ID %d.", arg3, arg2))
			exports.titan_noti:showBox(target, string.format("* Otrzymałeś $%d od administratora.", arg3))
			exports.titan_logs:playerLog(target, "cash", string.format("Otrzymano pieniądze od: (Administrator) %s (UID: %d, CID: %d), Kwota: $%d.", exports.titan_chats:getPlayerICName(player), player:getData("memberID"), player:getData("charID"), arg3))
		end
	elseif arg1 == "cp" then
		local reason = table.concat({...}, " ")
		if not tonumber(arg2) or not tonumber(arg3) or not tostring(reason) or string.len(tostring(reason)) < 1 then
			exports.titan_noti:showBox(player, "TIP: /aset cp [ID gracza] [ilość cloudPoints do dodania] [powód]")
			return
		end
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)

		local target = exports.titan_login:getPlayerByID(arg2)
		if not isElement(target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end
		if arg3 == 0 then
			exports.titan_noti:showBox(player, "Podano niepoprawna ilość cloudPoints.")
			return
		end
		if arg3 < 0 then
		exports.titan_noti:showBox(target, string.format("* Administrator zabrał Ci %s cloudPoints.", tostring(arg3):gsub("-", "")))
		exports.titan_noti:showBox(player, string.format("* Zabrałeś %s cloudPoints graczowi o ID %d.", tostring(arg3):gsub("-", ""), arg2))
		else
		exports.titan_noti:showBox(target, string.format("* Otrzymałeś %d cloudPoints od administratora.", arg3))
		exports.titan_noti:showBox(player, string.format("* Dałeś %d cloudPoints graczowi o ID %d.", arg3, arg2))
		end
		local adminName = tostring(getElementData(player, "globalName"))
		local playerName = string.format("%s (%s)", exports.titan_chats:getPlayerICName(target), tostring(getElementData(target, "globalName")))
		reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
		exports.titan_hud:showPenalty(adminName, playerName, 13, reason, arg3)
		exports.titan_misc:addCloudPoints(target, arg3)
		savePenalty(13, player, target, arg3, reason)
		return
	elseif arg1 == "time" then
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)
		if not arg2 then return exports.titan_noti:showBox(player, "/aset time [godzina] [czas](opcjonalnie)") end
		if not arg3 then arg3 = 0 end
		setTime(tonumber(arg2), tonumber(arg3))
		exports.titan_noti:showBox(player, "Ustawiono czas na "..arg2..":"..arg3)
		return
	elseif arg1 == "weather" then
		arg2 = tonumber(arg2)
		if tonumber(arg2) < 0 or tonumber(arg2) > 20 then return exports.titan_noti:showBox(player, "/aset weather [Typ pogody (0-20)]") end
		setWeather(tonumber(arg2))
		exports.titan_noti:showBox(player, "Zmieniono pogodę na ID "..arg2)
		return
	elseif arg1 == "skin" then
		arg2 = tonumber(arg2)
		arg3 = tonumber(arg3)
		if not arg2 then return exports.titan_noti:showBox(player, "/aset skin [ID gracza] [ID skina]") end
		
		local target = exports.titan_login:getPlayerByID(arg2)
		if not isElement(target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end
		
		if not arg3 then return exports.titan_noti:showBox(player, "/aset skin [ID gracza] [ID skina]") end
		if tonumber(arg3) == 3 or tonumber(arg3) == 4 or tonumber(arg3) == 5 or tonumber(arg3) == 6 or tonumber(arg3) == 8 or tonumber(arg3) == 42 or tonumber(arg3) == 65 or tonumber(arg3) == 74 or tonumber(arg3) == 86 or tonumber(arg3) == 119 or tonumber(arg3) == 149 or tonumber(arg3) == 208 or tonumber(arg3) == 273 or tonumber(arg3) == 289 then return exports.titan_noti:showBox(player, "To ID jest wyłączone w MTA i nie może być ustawione jako skin") end
		
		setElementModel(target, tonumber(arg3))
		exports.titan_noti:showBox(player, "Ustawiono skin "..exports.titan_chats:getPlayerICName(target).." na "..arg3)
		exports.titan_noti:showBox(target, string.format("Administrator %s ustawił Ci skin na %d.", getElementData(player, "globalName"), arg3))
		exports.titan_db:query_free("UPDATE `_characters` SET `skin` = ? WHERE `ID` = ?", arg3, target:getData("charID"))
	elseif arg1 == "nick" then
		arg2 = tonumber(arg2)
		arg4 = table.concat({...}, " ")
		if not arg2 then return exports.titan_noti:showBox(player, "/aset nick [ID gracza] [Imię] [Nazwisko (opcjonalnie]") end
		if not arg3 then return exports.titan_noti:showBox(player, "/aset nick [ID gracza] [Imię] [Nazwisko (opcjonalnie]") end
		
		local target = exports.titan_login:getPlayerByID(arg2)
		if not isElement(target) then
			exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
			return
		end
		
		local oldNick = exports.titan_chats:getPlayerICName(target)
		setElementData(target, "name", arg3)
		setElementData(target, "lastname", arg4 or "")
		
		exports.titan_noti:showBox(player, "Ustawiono nick "..oldNick.." na "..exports.titan_chats:getPlayerICName(target))
		exports.titan_noti:showBox(target, "Administrator zmienił Ci nick na "..exports.titan_chats:getPlayerICName(target))
	else
		exports.titan_noti:showBox(player, string.format("TIP: /aset [%s]", legend))
	end
end
addCommandHandler("aset", cmdAset, false, false)


function hide1(player)
	player:setData("hide:playerNames", not player:getData("hide:playerNames"))
end
addCommandHandler("hide1", hide1, false, false)

function hide2(player)
	player:setData("hide:playerRadar", not player:getData("hide:playerRadar"))
end
addCommandHandler("hide2", hide2, false, false)