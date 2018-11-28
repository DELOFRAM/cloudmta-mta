----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local paydayHour = nil
local restartDay = nil
function globalTimer()
	if not tonumber(paydayHour) then setPaydayHour() end
	local realTime = getRealTime()
	if tonumber(realTime.hour) == tonumber(paydayHour) and tonumber(restartDay) == tonumber(realTime.monthday) then
		shutdown("Restart serwera o 4:00")
	end
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			local arrestTime = v:getData("arrestTime")
			if tonumber(arrestTime) and arrestTime > 0 then
				arrestTime = arrestTime - 1
				if arrestTime <= 0 then
					v:setData("arrestTime", 0)
					v:setData("arrestData", 0)
					local sData = exports.titan_misc:randomSpawn()
					v:setDimension(0)
					v:setInterior(0)
					v:setPosition(sData[1], sData[2], sData[3])
					exports.titan_db:query_free("UPDATE _characters SET arrestTime = '0', arrestData = '0' WHERE ID = ?", v:getData("charID"))
					exports.titan_noti:showBox(v, "Czas aresztu dobiegł końca.")
				else
					v:setData("arrestTime", arrestTime)
				end
			end
			if getElementData(v, "ajTime") then
				local ajTime = getElementData(v, "ajTime")
				if ajTime > 0 then
					setElementData(v, "ajTime", ajTime - 1)
				else
					if getElementData(v, "inAJ") then
						setElementData(v, "ajTime", 0)
						exports.titan_noti:showBox(v, "Następnym razem pomyśl, zanim zrobisz jakaś głupotę!")
						setElementPosition(v, 1811.20, -1868.06, 13.58)
						setElementInterior(v, 0)
						setElementDimension(v, 0)
						setElementData(v, "inAJ", false)
					end
				end
			end
			if tonumber(getElementData(v, "runBlock")) and getElementData(v, "runBlock") > 0 then
				if getElementData(v, "runBlock") < realTime.timestamp then
					setElementData(v, "runBlock", 0)
					toggleControl(v, "sprint", true)
					toggleControl(v, "jump", true)
					exports.titan_noti:showBox(v, "Czas blokady biegania dobiegł końca.")
				end
			end
			local hungryTime = v:getData("hungryTime")
			v:setData("hungryTime", hungryTime + 1, false)
			if hungryTime == 100 then v:setData("hungryTime", 1, false) end

			if not exports.titan_admin:doesPlayerHaveAdminDuty(v) then
				if hungryTime % 20 == 0 then
					local hungryLevel = v:getData("hungryLevel")
					if tonumber(hungryLevel) and hungryLevel > 0 then
						v:setData("hungryLevel", hungryLevel - 0.1)
						if hungryLevel >= 90 then
							if not exports.titan_bw:doesPlayerHaveBW(v) then
								if getElementHealth(v) < 100 then
									local dmgType = v:getData("damageType")
									if not tonumber(dmgType) or tonumber(dmgType) ~= 3 then
										setElementHealth(v, getElementHealth(v) + math.ceil(math.random(4, 6)))
									end
								end
							end
						end
					else
						if getElementHealth(v) > 50 then
							setElementHealth(v, getElementHealth(v) - 2)
							if(isTimer(getElementData(v, "damageColorNickTimer"))) then
								killTimer(getElementData(v, "damageColorNickTimer"))
							end
							local timer = setTimer(function(v) setElementData(v, "damageColorNick", false) end, 500, 1, v)
							setElementData(v, "damageColorNickTimer", timer)
							setElementData(v, "damageColorNick", true)
							exports.titan_hud:colorPlayer(v)
						end
					end
				end
			end
			
			if isElement(getElementData(v, "cuffedPlayer")) and getElementData(v, "bwTime") then
				detachElements(getElementData(v, "cuffedPlayer"), v)
				toggleAllControls(getElementData(v, "cuffedPlayer"), true)
				setElementCollisionsEnabled(getElementData(v, "cuffedPlayer"), true)
				removeElementData(getElementData(v, "cuffedPlayer"), "cuffedBy")
				removeElementData(v, "cuffedPlayer")
			end
			if isElement(getElementData(v, "cuffedBy")) and getElementData(v, "bwTime") then
				detachElements(v, getElementData(v, "cuffedBy"))
				setElementCollisionsEnabled(v, true)
				removeElementData(getElementData(v, "cuffedBy"), "cuffedPlayer")
				removeElementData(v, "cuffedBy")
			end
		end
	end
end
setTimer(globalTimer, 1000, 0)

function setPaydayHour()
	local tTime = getTickCount()
	local realTime = getRealTime()
	if realTime.hour < 4 then
		restartDay = realTime.monthday
	elseif realTime.hour >= 4 then
		restartDay = realTime.monthday + 1
	end
	time = 4
	paydayHour = time
	outputDebugString(string.format("[TIMERS] Ustawiono godzinę restartu na %s dnia %d. | %d ms", time, restartDay, getTickCount() - tTime))
end

function playerAddCloudPoints()
	if getElementData(source, "premium") then
		exports.titan_noti:showBox(source, "Przegrałeś kolejną godzinę na serwerze, otrzymujesz 20 cPoints!")
		exports.titan_misc:addCloudPoints(source, 20)
	else
		exports.titan_noti:showBox(source, "Przegrałeś kolejną godzinę na serwerze, otrzymujesz 10 cPoints!")
		exports.titan_misc:addCloudPoints(source, 10)
	end	
end
addEvent("playerAddCloudPoints", true)
addEventHandler("playerAddCloudPoints", root, playerAddCloudPoints)

--[[function paydayTime()
	local hTime = getRealTime().timestamp
	for k, player in ipairs(getElementsByType("player")) do
		local payday = 0
		if exports.titan_login:isLogged(player) then
			--outputChatBox("|___WYPŁATA___|", player, 255, 255, 255)
			local playerGroups = exports.titan_orgs:getPlayerGroups(player)
			if playerGroups then
				local tempTable = {}
				for k, v in ipairs(playerGroups) do
					local dutyTime = exports.titan_orgs:getPlayerDutyTime(player:getData("charID"), v.groupInfo.ID, hTime - 3600, hTime)
					--outputChatBox(string.format("   %s", tostring(v.groupInfo.name)), player, v.groupInfo.r, v.groupInfo.g, v.groupInfo.b)
					--outputChatBox(string.format("    Czas duty: %dmin", math.floor(dutyTime / 60)), player, 255, 255, 255)
					if dutyTime > 60 * 40 then
						--outputChatBox(string.format("    - $%s", tostring(v.cash)), player, 255, 255, 255)
						if tonumber(v.cash) then payday = payday + tonumber(v.cash) end
						table.insert(tempTable, string.format("$%s - %s (%dm)", tostring(v.cash), tostring(v.groupInfo.name), math.floor(dutyTime / 60)))
					else
						table.insert(tempTable, string.format("$0 - %s (%dm)", tostring(v.groupInfo.name), math.floor(dutyTime / 60)))
					end
				end
				exports.titan_hud:showPayday(player, tempTable)
			end
			if type(playerGroups) ~= "table" or #playerGroups <= 0 then
				payday = payday + 200
				local tempTable = {}
				table.insert(tempTable, "$200 - Zasiłek dla bezrobotnych")
				exports.titan_hud:showPayday(player, tempTable)
				--outputChatBox(string.format("   Zasiłek dla bezrobotnych"), player)
				--outputChatBox(string.format("    - $200"), player)
			end
			--outputChatBox("", player, 255, 255, 255)
			--outputChatBox(string.format("     SUMA: $%d", payday), player, 30, 180, 20)
			if payday > 0 then
				local query = exports.titan_db:query("SELECT ID, balance FROM _accounts WHERE ownerType = '1' AND owner = ? ORDER BY ID ASC LIMIT 1", player:getData("charID"))
				if #query <= 0 then
					exports.titan_noti:showBox(player, "Wypłata nie została naliczona, ponieważ nie posiadasz założonego konta w banku.")
				else
					exports.titan_db:query_free("UPDATE _accounts SET balance = balance + ? WHERE ID = ?", payday, query[1].ID)
					exports.titan_db:query_free("INSERT INTO _accounts_logs SET accountID = ?, title = 'Payday', cash = ?, actualBalance = ?", query[1].ID, payday, query[1].balance + payday)
				end
			end
		end
	end
end]]