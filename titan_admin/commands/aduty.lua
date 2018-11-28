----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:28
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:31
----------------------------------------------------

exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_admins_duty` (`ID` int NOT NULL AUTO_INCREMENT PRIMARY KEY, `userID` int NOT NULL, `start` int NOT NULL, `end` int NOT NULL, `afkTime` int NOT NULL);")

function cmdAduty(player, command)
	if(not isPlayerAdmin(player)) then return false end
	if(getElementData(player, "adminDuty")) then
		setElementData(player, "adminDuty", false)
		exports.titan_noti:showBox(player, "Zakończyłeś duty administratora.")
		if player:getData("adminDutyDatabaseID") then
			local lastID = player:getData("adminDutyDatabaseID")
			exports.titan_db:query_free("UPDATE _admins_duty SET end = UNIX_TIMESTAMP(), afkTime = ? - afkTime WHERE ID = ?", player:getData("afkTime"), lastID)
			player:removeData("adminDutyDatabaseID")
		end
		--outputChatBox("* Zakończyłeś duty administratora.", player, 0, 122, 204)
	else
		setElementData(player, "adminDuty", true)
		exports.titan_noti:showBox(player, "Wszedłeś na duty administratora.")

		local query, rows, lastID = exports.titan_db:query("INSERT INTO _admins_duty SET userID = ?, start = UNIX_TIMESTAMP(), end = 0, afkTime = ?", player:getData("charID"), player:getData("afkTime"))
		if lastID then player:setData("adminDutyDatabaseID", lastID) end
		--outputChatBox("* Wszedłeś na duty administratora.", player, 0, 122, 204)
	end
end
addCommandHandler("aduty", cmdAduty, false, false)

function adutyOnPlayerQuit()
	local lastID = source:getData("adminDutyDatabaseID")
	if lastID then
		exports.titan_db:query_free("UPDATE _admins_duty SET end = UNIX_TIMESTAMP(), afkTime = ? - afkTime WHERE ID = ?", source:getData("afkTime"), lastID)
	end
end
addEventHandler("onPlayerQuit", root, adutyOnPlayerQuit)

function adutyOnStop()
	for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
			if v:getData("adminDuty") then
				exports.titan_noti:showBox(v, "Moduł administratora został zrestartowany. Twoje duty administratora zostało dezaktywowane.")
				v:removeData("adminDuty")
				local lastID = v:getData("adminDutyDatabaseID")
				if lastID then
					exports.titan_db:query_free("UPDATE _admins_duty SET end = UNIX_TIMESTAMP(), afkTime = ? - afkTime WHERE ID = ?", v:getData("afkTime"), lastID)
				end
			end
		end
	end
end
addEventHandler("onResourceStop", resourceRoot, adutyOnStop)