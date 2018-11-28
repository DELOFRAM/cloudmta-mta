----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:03
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:06
----------------------------------------------------

function cmdAMaster(player, command, user, pass)
	if not doesAdminHavePerm(player, "masteradmin") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	if not user or not pass then
		exports.titan_noti:showBox(player, "TIP: /amaster [login] [hasło]")
		return
	end
	local account = getAccount(user, pass)
	if not account then
		exports.titan_noti:showBox(player, "Podano błędne dane logowania.")
		return
	end
	logIn(player, account, pass)
end
addCommandHandler("amaster", cmdAMaster, false, false)