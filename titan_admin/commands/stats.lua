----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-10 14:34:22
-- Ostatnio zmodyfikowano: 2016-01-10 15:09:24
----------------------------------------------------

function cmdStats(player, command, arg1)
	if not exports.titan_login:isLogged(player) then return end
	if arg1 then
		if isPlayerAdmin(player) then
			if tonumber(arg1) then
				arg1 = tonumber(arg1)
				local target = exports.titan_login:getPlayerByID(arg1)
				if not target then return exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID, lub nie jest on zalogowany.") end
				local vehs = exports.titan_vehicles:getVehiclesToDashboard(target)
				local interiors = exports.titan_doors:getPlayerInteriors(target)
				local groups = exports.titan_orgs:getGroupsToDashboard(target)
				local accounts = exports.titan_cash:getPlayerAccounts(target)
				return triggerClientEvent(player, "createStatsGUI", player, target, vehs, interiors, groups, accounts)
			elseif tostring(arg1) then
				arg1 = tostring(arg1)
				if string.len(arg1) ~= 4 then return exports.titan_noti:showBox(player, "Kod DNA składa się z 4 znaków alfanumerycznych.") end
				local res = exports.titan_db:query("SELECT ID FROM _characters WHERE shortDNA = ? LIMIT 1", string.upper(arg1))
				if #res <= 0 then return exports.titan_noti:showBox(player, "Nie znaleziono gracza, który posiadałby takie DNA.") end
				local playerElement = nil
				for k, v in ipairs(getElementsByType("player")) do
					if exports.titan_login:isLogged(v) then
						if tonumber(v:getData("charID")) == res[1].ID then
							playerElement = v
							break
						end
					end
				end
				if not isElement(playerElement) then return exports.titan_noti:showBox(player, "Ten gracz obecnie nie znajduje się na serwerze.") end
				local vehs = exports.titan_vehicles:getVehiclesToDashboard(playerElement)
				local interiors = exports.titan_doors:getPlayerInteriors(playerElement)
				local groups = exports.titan_orgs:getGroupsToDashboard(playerElement)
				local accounts = exports.titan_cash:getPlayerAccounts(playerElement)
				return triggerClientEvent(player, "createStatsGUI", player, playerElement, vehs, interiors, groups, accounts)
			end
		else
			local vehs = exports.titan_vehicles:getVehiclesToDashboard(player)
			local interiors = exports.titan_doors:getPlayerInteriors(player)
			local groups = exports.titan_orgs:getGroupsToDashboard(player)
			local accounts = exports.titan_cash:getPlayerAccounts(player)
			return triggerClientEvent(player, "createStatsGUI", player, player, vehs, interiors, groups, accounts)
		end
	else
		local vehs = exports.titan_vehicles:getVehiclesToDashboard(player)
		local interiors = exports.titan_doors:getPlayerInteriors(player)
		local groups = exports.titan_orgs:getGroupsToDashboard(player)
		local accounts = exports.titan_cash:getPlayerAccounts(player)
		return triggerClientEvent(player, "createStatsGUI", player, player, vehs, interiors, groups, accounts)
	end
end
addCommandHandler("stats", cmdStats, false, false)