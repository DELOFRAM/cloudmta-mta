----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function showCustomCursor(player, cursorString)
	triggerClientEvent(player, "showCustomCursor", resourceRoot, cursorString)
end

function hideCustomCursor(player, cursorString)
	triggerClientEvent(player, "hideCustomCursor", resourceRoot, cursorString)
end