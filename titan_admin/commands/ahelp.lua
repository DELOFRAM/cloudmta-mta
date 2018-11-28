----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:38
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:46
----------------------------------------------------

function cmdAHelp(player)
	if(not isPlayerAdmin(player)) then return false end
	-- outputChatBox("Lista komend admina została wydrukowana w konsoli.", player, 255, 0, 0)
	-- outputConsole("-------------------------------------", player)
	-- outputConsole("|****** Komendy Administratora", player)

	-- outputConsole("|**** Komendy dot. kar", player)
	-- outputConsole("|* /ablock", player)
	-- outputConsole("|* /akick", player)
	-- outputConsole("|* /aban", player)
	-- outputConsole("|* /awarn", player)

	-- outputConsole("|**** Komendy do zarzadzania", player)
	-- outputConsole("|* /av - zarzadznie pojazdami", player)
	-- outputConsole("|* /ad - zarzadznie drzwiami", player)
	-- outputConsole("|* /ag - zarzadznie grupami", player)
	-- outputConsole("|* /ap - zarzadznie przemiotami", player)
	triggerClientEvent( player, "adminHelperGUI", player )

end
addCommandHandler("ahelp", cmdAHelp, false, false)