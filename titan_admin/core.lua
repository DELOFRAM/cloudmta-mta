----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:39:03
-- Ostatnio zmodyfikowano: 2016-01-09 15:39:13
----------------------------------------------------

function doesPlayerHaveAdminDuty(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(not isPlayerAdmin(player)) then return false end
	if(not getElementData(player, "adminDuty")) then return false end
	return true
end

function isPlayerAdmin(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	if(getElementData(player, "adminLevel") > 0) then return true end
	return false
end

function getPlayerAdminLevel(player)
	if(not exports.titan_login:isLogged(player)) then return false end
	return getElementData(player, "adminLevel")
end

function getAdminColor(adminLevel)
	if(not tonumber(adminLevel)) then return false end
	local color = "#ffffff"
	if(adminLevel == 6) then color = "#dc0000" end -- Główny Administrator
	if(adminLevel == 5) then color = "#1F8B4C" end -- Administrator Rozgrywki
	if(adminLevel == 4) then color = "#611616" end -- Administrator Techniczny
	if(adminLevel == 3) then color = "#6a4590" end -- Developer
	if(adminLevel == 2) then color = "#3577B8" end -- Moderator
	if(adminLevel == 1) then color = "#C27C0E" end -- Nauczyciel
	
	if(adminLevel == 7) then color = "#11F2F2" end -- Beta - Tester
	return color
end

function getAvailableAdmins(duty)
	local tmpTable = {}
	for k, v in ipairs(getElementsByType("player")) do
		if(isPlayerAdmin(v)) then
			if duty then
				if doesPlayerHaveAdminDuty(v) then
					table.insert(tmpTable, v)
				end
			else
				table.insert(tmpTable, v)
			end
		end
	end
	if(#tmpTable <= 0) then return false end
	return tmpTable
end

function savePenalty(penaltyType, admin, user, expire, reason, penaltyType2)
	if (isElement(admin) or admin == 0 or tonumber(admin)) and isElement(user) then
		local serial = getPlayerSerial(user)
		local ip = getPlayerIP(user)
		exports.titan_db:query_free("INSERT INTO _penalty_logs SET userID = ?, adminID = ?, serial = ?, ip = ?, reason = ?, time = UNIX_TIMESTAMP(), expire = ?, type = ?", user:getData("charID"), isElement(admin) and admin:getData("memberID") or tonumber(admin) and admin or 0, serial, ip, reason, expire, penaltyType)
		if tonumber(penaltyType2) then
			exports.titan_db:query_free("UPDATE _penalty_logs SET expire = -1 WHERE ID = (SELECT ID FROM (SELECT MAX(ID) AS ID FROM _penalty_logs WHERE userID = ? AND type = ?) AS tmp)", user:getData("charID"), penaltyType2)
		end
	end
end

function doesAdminHavePerm(player, permName)
	if not isElement(player) then return false end
	if not isPlayerAdmin(player) then return false end

	local aPerms = player:getData("adminPerms")
	if type(aPerms) ~= "table" then return false end
	if aPerms[permName] then return true end
	return false
end

function saveAdminPerms(player, adminLevel, adminPerms)
	if isElement(player) then
		player:setData("adminLevel", tonumber(adminLevel))
		player:setData("adminPerms", adminPerms)

		local aPermsJSON = toJSON(adminPerms)
		if aPermsJSON then
			exports.titan_db:query("UPDATE ipb_members SET game_adminLevel = ?, game_adminPerms = ? WHERE member_id = ?", tonumber(adminLevel), tostring(aPermsJSON), player:getData("memberID"))
		end
		exports.titan_noti:showBox(source, "Uprawnienia administratora ustawiono pomyślnie.")
		exports.titan_noti:showBox(player, "Uprawnienia administratora zostały zmienione.")
	end
end
addEvent("saveAdminPerms", true)
addEventHandler("saveAdminPerms", root, saveAdminPerms)

function onCommand(cmd)
	if string.lower(tostring(cmd)) == "login" or string.lower(tostring(cmd)) == "logout" then cancelEvent() end
end
addEventHandler("onPlayerCommand", root, onCommand)