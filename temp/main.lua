----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function dupacmd(player, cmd, x, y, z)
	setElementPosition(player, x, y, z)
end
addCommandHandler("nosiema", dupacmd, false, false)