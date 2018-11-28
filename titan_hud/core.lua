----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function updateHUDReportsState(state, player)
	triggerClientEvent(isElement(player) and player or root, "onReportsChange", resourceRoot, state)
end