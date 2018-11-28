----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local damageTable = {}

function onDamagePlayer(attacker, attackerWeapon, bodypart, loss)
	--outputDebugString("Test uderzenia!")
	if exports.titan_login:isLogged(source) then
		if type(damageTable[source]) ~= "table" then
			damageTable[source] = {}
		end
		damageTable[source][#damageTable[source] + 1] = 
		{
			time = getRealTime().timestamp,
			weapon = attackerWeapon,
			hp = string.format("%0.f", loss),
			bodypart = bodypart
		}
	end
end
addEventHandler("onPlayerDamage", root, onDamagePlayer)

function onWastedPlayer(totalAmmo, killer, weapon, bodypart, stealth)
	if exports.titan_login:isLogged(source) then
		if type(damageTable[source]) ~= "table" then
			damageTable[source] = {}
		end
		damageTable[source][#damageTable[source] + 1] =
		{
			time = getRealTime().timestamp,
			weapon = weapon,
			hp = "--",
			bodypart = bodypart,
			bw = true
		}
	end
end
addEventHandler("onPlayerWasted", root, onWastedPlayer)

function resetPlayerDamage(player)
	--outputDebugString("RESET?!")
	damageTable[player] = {}
end

function cmdObrazenia(player, command, id)
	if not exports.titan_login:isLogged(player) then return end
	if not tonumber(id) then
		exports.titan_noti:showBox(player, "TIP: /obrazenia [ID gracza]")
		return
	end
	id = tonumber(id)
	local target = exports.titan_login:getPlayerByID(id)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end
	local x, y, z = getElementPosition(player)
	local px, py, pz = getElementPosition(target)
	if getDistanceBetweenPoints3D(x, y, z, px, py, pz) > 4.0 then
		exports.titan_noti:showBox(player, "Gracz jest za daleko.")
		return
	end
	if not exports.titan_bw:doesPlayerHaveBW(target) then
		exports.titan_noti:showBox(player, "Gracz nie jest nieprzytomny.")
		return
	end
	local dmg = damageTable[target]
	if type(dmg) ~= "table" or #dmg <= 0 then
		exports.titan_noti:showBox(player, "Gracz nie posiada żadnych widocznych obrażeń.")
		return
	end
	triggerClientEvent(player, "createDamageGUI", target, dmg)
end
addCommandHandler("obrazenia", cmdObrazenia, false, false)