----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local ZASILEK = 100

local govermentGroupID = 1

function paydayFunction()
	local time = getTickCount()
	local allGroups = exports.titan_db:query("SELECT * FROM _groups")
	if type(allGroups) == "table" then
		for k, v in ipairs(allGroups) do
			local groupDonate = tonumber(v.dotation)
			local groupMembers = exports.titan_db:query("SELECT userID, cash FROM _groups_members WHERE groupID = ?", v.ID)
			if type(groupMembers) == "table" then
				for k1, v1 in ipairs(groupMembers) do
					local money = 0
					local dutyTime = getPlayerDutyGroup(v1.userID, v.ID)
					--if v1.userID == 67 then
					--	outputServerLog(string.format("GRUPA: %s, dutyTime: %s", tostring(v.name), tostring(dutyTime)))
					--end
					if dutyTime > 1800 then
						money = money + v1.cash
					end
					if dutyTime > 2700 then
						money = money + math.floor(v1.cash * 0.25)
					end
					if dutyTime > 5400 then
						money = money + math.floor(v1.cash * 0.5)
					end

					if money > 0 then
						local query = exports.titan_db:query("SELECT ID, balance FROM _accounts WHERE ownerType = 1 AND owner = ? ORDER BY ID ASC LIMIT 1", v1.userID)
						if #query == 1 then
							outputServerLog(string.format("[PAYDAY] Gracz o UID $%d dostal %d wyplaty z grupy %s (UID %d)", v1.userID, money, v.name, v.ID))
							exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", money, query[1].ID)
							exports.titan_db:query_free("INSERT INTO _accounts_logs SET accountID = ?, title = ?, cash = ?, actualBalance = ?", query[1].ID, string.format("Wypłata z grupy %s", v.name), money, query[1].balance + money)
						else
							outputServerLog(string.format("[PAYDAY] Gracz o UID %d powinien dostac $%d wyplaty z grupy %s (UID %d), ale nie ma konta bankowego.", v1.userID, money, v.name, v.ID))
						end
					end
				end
			end
		end
	end
	exports.titan_db:query_free("UPDATE _groups_duty SET old = 1")

	-- ZASIŁKI
	local players = exports.titan_db:query("SELECT ID, tempOnlineTime, ssn FROM _characters WHERE tempOnlineTime > 1800")
	if type(players) == "table" then
		for k, v in ipairs(players) do
			v.ssn = fromJSON(tostring(v.ssn))
			if v.ssn and type(v.ssn) == "table" then
				local groupsCount = exports.titan_db:query("SELECT COUNT(*) as liczba FROM _groups_members WHERE cash > 0 AND userID = ?", v.ID)
				if groupsCount[1].liczba == 0 then
					local money = 0
					if v.tempOnlineTime > 1800 then
						money = money + ZASILEK
					end
					if v.tempOnlineTime > 2700 then
						money = money + math.floor(ZASILEK * 0.25)
					end
					if v.tempOnlineTime > 5400 then
						money = money + math.floor(ZASILEK * 0.5)
					end
					if money > 0 then
						local query = exports.titan_db:query("SELECT ID, balance FROM _accounts WHERE ownerType = 1 AND owner = ? ORDER BY ID ASC LIMIT 1", v.ID)
						if #query == 1 then
							outputServerLog(string.format("[PAYDAY] Gracz o UID %d dostal $%d zasilku.", v.ID, money))
							exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", money, query[1].ID)
							exports.titan_db:query_free("INSERT INTO _accounts_logs SET accountID = ?, title = 'Zasiłek dla bezrobotnych', cash = ?, actualBalance = ?", query[1].ID, money, query[1].balance + money)
						else
							outputServerLog(string.format("[PAYDAY] Gracz o UID %d dostal $%d zasilku, ale nie mial konta, co by je przelac.", v.ID, money))
						end
					end
				end
			end
		end
	end
	exports.titan_db:query_free("UPDATE _characters SET tempOnlineTime = 0")

	-- LOGI
	outputServerLog(string.format("[PAYDAY] Wyplaty! | %dms", getTickCount() - time))
	outputConsole(string.format("[PAYDAY] Wyplaty! | %dms", getTickCount() - time))
	outputDebugString(string.format("[PAYDAY] Wyplaty! | %dms", getTickCount() - time))
end

function getPlayerDutyGroup(playerID, groupID)
	local query = exports.titan_db:query("SELECT * FROM _groups_duty WHERE old = 0 AND groupID = ? AND userID = ?", groupID, playerID)
	local dutyTime = 0
	if type(query) == "table" then
		for k, v in ipairs(query) do
			if v["start"] > 0 and v["end"] > 0 then
				dutyTime = dutyTime + (v["end"] - v["start"])
			end
		end
	end
	return tonumber(dutyTime)
end

function resourceStart()
	local time = getRealTime()
	if time.hour > 3 and time.hour < 7 then
		paydayFunction()
	end
end
addEventHandler("onResourceStart", resourceRoot, resourceStart)