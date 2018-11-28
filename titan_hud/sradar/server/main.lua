----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function toggleRadarVisible(player, state)
	if(isElement(player)) then
		triggerClientEvent(player, "toggleRadarVisible", player, state)
	end
end

function showPenalty(adminName, playerName, penaltyType, reason, penaltyTime)
	if penaltyType == 1 then
		penaltyType = "Kick"
	elseif penaltyType == 2 then
		if(penaltyTime == 0) then
			penaltyType = "Ban (na zawsze)"
		elseif(penaltyTime == 1) then
			penaltyType = "Ban (1 dzień)"
		else
			penaltyType = string.format("Ban (%d dni)", penaltyTime)
		end
	elseif penaltyType == 3 then
		penaltyType = "Warn"
	elseif penaltyType == 4 then
		penaltyType = "Blokada postaci"
	elseif penaltyType == 5 then
		penaltyType = string.format("Admin Jail (%d min)", penaltyTime)
	elseif penaltyType == 6 then
		penaltyType = "Uwolnienie z Admin Jaila"
	elseif penaltyType == 7 then
		-- local time1 = penaltyTime[1]
		-- local time2 = penaltyTime[2]
		-- if time2 == "dni" then
			-- if time1 == 1 then time2 = "dzień" else time2 = "dni" end
		-- else
			-- if time1 == 1 then time2 = "godzina" elseif (time1 > 1 and time1 < 5) or (time1 > 20 and time2 < 25)  then time2 = "godziny" else time2 = "godzin" end
		-- end
		--penaltyType = string.format("Blokada pojazdów (%s %s)", time1, time2)
		penaltyType = string.format("Blokada pojazdów")
	elseif penaltyType == 8 then
		penaltyType = "Anulowanie blokady pojazdów"
	elseif penaltyType == 9 then
		-- local time1 = penaltyTime[1]
		-- local time2 = penaltyTime[2]
		-- if time2 == "dni" then
			-- if time1 == 1 then time2 = "dzień" else time2 = "dni" end
		-- else
			-- if time1 == 1 then time2 = "godzina" elseif (time1 > 1 and time1 < 5) or (time1 > 20 and time2 < 25)  then time2 = "godziny" else time2 = "godzin" end
		-- end
		--penaltyType = string.format("Blokada OOC (%s %s)", time1, time2)
		penaltyType = string.format("Blokada OOC")
	elseif penaltyType == 10 then
		penaltyType = "Anulowanie blokady OOC"
	elseif penaltyType == 11 then
		-- local time1 = penaltyTime[1]
		-- local time2 = penaltyTime[2]
		-- if time2 == "dni" then
			-- if time1 == 1 then time2 = "dzień" else time2 = "dni" end
		-- else
			-- if time1 == 1 then time2 = "godzina" elseif (time1 > 1 and time1 < 5) or (time1 > 20 and time2 < 25)  then time2 = "godziny" else time2 = "godzin" end
		-- end
		--penaltyType = string.format("Blokada biegania (%s %s)", time1, time2)
		penaltyType = string.format("Blokada biegania")
	elseif penaltyType == 12 then
		penaltyType = "Anulowanie blokady biegania"
	elseif penaltyType == 13 then
		penaltyType = string.format("cloudPoints (%s%d)", penaltyTime > 0 and "+" or "-", math.abs(penaltyTime))
	elseif penaltyType == 14 then
		penaltyType = "Character Kill"
	else
		penaltyType = "Nieznany typ kary"
	end
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			triggerClientEvent(v, "showPenalty", v, adminName, playerName, penaltyType, reason, penaltyTime)
		end
	end
end

function showPayday(player, data)
	if exports.titan_login:isLogged(player) then triggerClientEvent(player, "showPayday", resourceRoot, data) end
end