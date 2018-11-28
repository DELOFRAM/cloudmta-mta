----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:23
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:26
----------------------------------------------------

function cmdAdmins(player)
	if exports.titan_login:isLogged(player) then
		local admins = getAvailableAdmins(true)
		if not admins or #admins <= 0 then 
			exports.titan_noti:showBox(player, "Nie ma żadnego administratora dostępnego na duty.")
			return
		end
		triggerClientEvent(player, "adminsGUI", player, admins)
	end
end
addCommandHandler("admins", cmdAdmins, false, false)
addCommandHandler("a", cmdAdmins, false, false)