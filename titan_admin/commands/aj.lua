----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:49
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:54
----------------------------------------------------

function cmdAJ(player, command, ID, time, ...)
	if not doesAdminHavePerm(player, "aj") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local reason = table.concat({...}, " ")

	if(not tonumber(ID) or not tonumber(time) or not reason or string.len(reason) < 1) then
		exports.titan_noti:showBox(player, "TIP: /aj [ID gracza] [czas (w minutach)] [powód]")
		return
	end
	reason = tostring(reason)
	ID = tonumber(ID)
	time = tonumber(time)
	if time > 240 then
		exports.titan_noti:showBox(player, "AJ może wynosić maksymalnie 240 minut.")
		return
	end

	if time < 1 then
		exports.titan_noti:showBox(player, "Czas AJ nie może być krótszy od 1 minuty.")
		return
	end

	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end

	local adminName = tostring(getElementData(player, "globalName"))
	local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
	reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
	exports.titan_hud:showPenalty(adminName, playerName, 5, reason, time)
	savePenalty(5, player, target, time * 60, reason)
	outputChatBox("Admin umieścił Cię w Admin Jailu!", target, 255, 0, 0)

	if isPedInVehicle(target) then
		removePedFromVehicle(target)
	end
	setElementPosition(target, 1174.3706,-1180.3267,87.0350)
	setElementDimension(target, math.random(5000, 10000))
	setElementData(target, "ajTime", time * 60)
	setElementData(target, "inAJ", true)
	exports.titan_db:query_free("UPDATE ipb_members SET game_ajTime = ? WHERE member_id = ?", time*60, getElementData(target, "memberID"))
end
addCommandHandler("aj", cmdAJ, false, false)

function cmdUnaj(player, command, ID, ...)
	if(not isPlayerAdmin(player)) then return false end
	local reason = table.concat({...}, " ")
	if(not tonumber(ID) or not reason or string.len(reason) < 1) then
		exports.titan_noti:showBox(player, "TIP: /unaj [ID gracza] [powód]")
		return
	end
	ID = tonumber(ID)
	reason = tostring(reason)

	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end

	if not getElementData(target, "inAJ") then
		exports.titan_noti:showBox(player, "Gracz nie jest w AJ.")
		return
	end

	local adminName = tostring(getElementData(player, "globalName"))
	local playerName = string.format("%s %s (%s)", tostring(target:getData("name")), tostring(target:getData("lastname")), tostring(getElementData(target, "globalName")))
	exports.titan_hud:showPenalty(adminName, playerName, 6, reason, 0)
	savePenalty(6, player, target, 0, reason)
	setElementData(target, "ajTime", 0)
	outputChatBox("Następnym razem pomyśl, zanim zrobisz jakaś głupotę!", target, 255, 0, 0)
	setElementPosition(target, 1811.20, -1868.06, 13.58)
	setElementInterior(target, 0)
	setElementDimension(target, 0)
	setElementData(target, "inAJ", false)

end
addCommandHandler("unaj", cmdUnaj, false, false)