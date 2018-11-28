----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function createQuitText(x, y, z, text)
	triggerClientEvent("createQuitText", resourceRoot, x, y, z, text)
end