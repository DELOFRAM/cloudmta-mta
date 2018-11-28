----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

--RDZEŃ

--Sprawdź czy gracz istnieje, sprawdź login i hasło i pobierz jego dane z bazy
--[[function checkPlayerLoginData(user,pass)
	local res, rows = exports.titan_db:query(string.format("SELECT * FROM `mybb_users` WHERE `username` = '%s' AND `password` = MD5(CONCAT(MD5(`salt`), '', '%s'))", user, string.lower(md5(pass))))
	if rows > 0 then
		return res[1]
	else
		return false
	end
end]]

function checkPlayerLoginData(user, pass)
	local res, rows = exports.titan_db:query("SELECT * FROM ipb_members WHERE name = ? AND members_pass_hash = MD5(CONCAT(MD5(members_pass_salt), '', ?))", user, string.lower(md5(pass)))
	if tonumber(rows) and rows > 0 then return res[1] else return false end
end

function getPlayerGlobalData(globalID)
	local query = exports.titan_db:query("SELECT * FROM _globaldata WHERE UID = ? LIMIT 1", globalID)
	if #query <= 0 then
		local query, rows, lastID = exports.titan_db:query("INSERT INTO _globaldata SET UID = ?, adminLevel = '0', cloudPoints = '0'", globalID)
		return {ID = lastID, UID = globalID, adminLevel = 0, cloudPoints = 0}
	end
	return query[1]
end

function getPlayerCharacters(memberID)
	local res, rows = exports.titan_db:query("SELECT * FROM _characters WHERE blocked = 0 AND memberID = ?", memberID)
	if rows > 0 then
		return res, rows
	else
		return false
	end
end

function getPlayerCharacter(memberID,charID)
	local res, rows = exports.titan_db:query("SELECT * FROM _characters WHERE blocked = 0 AND memberID = ? AND ID = ?", memberID, charID)
	if rows > 0 then
		return res[1], rows
	else
		return false
	end
end

function isLogged(player)
	if isElement(player) then
		if getElementType(player) == "player" then
			if getElementData(player,"loggedIn") then
				if getElementData(player,"loggedIn") == 1 then
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end

function savePlayer(player)
	if isLogged(player) then
		local charID = getElementData(player,"charID")
		local x, y, z
		local rx, ry, angle
		local dim = getElementDimension(player)
		local int = getElementInterior(player)
		if tonumber(getElementData(player, "ajTime")) and tonumber(getElementData(player, "ajTime")) > 0 then
			local position = getElementData(player, "lastPos")
			x, y, z = position[1], position[2], position[3]
			angle = position[4]
			setElementData(player, "inAJ", true)
		elseif getElementData(player, "bwTime") then
			x, y, z = getElementPosition(player)
		else
			x, y, z = getElementPosition(player)
			rx, ry, angle = getElementRotation(player)
		end		
		local hp = getElementHealth(player)
		local bwTime = getElementData(player, "bwTime") == false and 0 or getElementData(player, "bwTime")
		local onlineTime = getElementData(player, "onlineTime") == false and 0 or getElementData(player, "onlineTime")
		local afkTime = getElementData(player, "afkTime") == false and 0 or getElementData(player, "afkTime")
		local ajTime = not getElementData(player, "ajTime") and 0 or getElementData(player, "ajTime")
		local vehBlock = getElementData(player, "vehBlock") == false and 0 or getElementData(player, "vehBlock")
		local runBlock = getElementData(player, "runBlock") == false and 0 or getElementData(player, "runBlock")
		local oocBlock = getElementData(player, "oocBlock") == false and 0 or getElementData(player, "oocBlock")
		local cloudPoints = getElementData(player, "cloudPoints") == false and 0 or getElementData(player, "cloudPoints")
		local hungryLevel = getElementData(player, "hungryLevel") == false and 0 or getElementData(player, "hungryLevel")
		local damageType = getElementData(player, "damageType") == false and 0 or getElementData(player, "damageType")
		local tempOnlineTime = getElementData(player, "tempOnlineTime") == false and 0 or getElementData(player, "tempOnlineTime")
		
		if not exports.titan_db:query_free("UPDATE _characters SET hp = ?, x = ?, y = ?, z = ?, angle = ?, dimension = ?, interior = ?, bwTime = ?, inGame = '0', onlineTime = ?, afkTime = ?, lastVisit = UNIX_TIMESTAMP(), vehBlock = ?, runBlock = ?, oocBlock = ?, hungrylevel = ?, damageType = ?, tempOnlineTime = ? WHERE ID = ?", hp, x, y, z, angle, dim, int, bwTime, onlineTime, afkTime, vehBlock, runBlock, oocBlock, hungryLevel, damageType, tempOnlineTime, charID) then
			outputServerLog("[TITANIUM_ENGINE][LOGIN] Nie udalo sie zapisac danych gracza o ID: "..playerID)
		end
		exports.titan_db:query_free("UPDATE ipb_members SET game_inGame = ?, game_cloudPoints = ?, game_ajTime = ? WHERE member_id = ?", 0, cloudPoints, ajTime, getElementData(player, "memberID"))
	else
		if tonumber(getElementData(player, "loggedIn")) and getElementData(player, "loggedIn") == 2 then
			exports.titan_db:query_free("UPDATE ipb_members SET game_inGame = 0 WHERE member_id = ?", getElementData(player, "memberID"))
		end
	end
end

function getPlayerByCharID(charID)
	for k, v in ipairs(getElementsByType("player")) do
		if(isLogged(v)) then
			local pcharid = tonumber(getElementData(v, "charID"))
			if(pcharid == tonumber(charID)) then return v end
		end
	end
	return false
end

function get_date_parts(date_str)
  _,_,y,m,d=string.find(date_str, "(%d+)-(%d+)-(%d+)")
  return tonumber(y),tonumber(m),tonumber(d)
end