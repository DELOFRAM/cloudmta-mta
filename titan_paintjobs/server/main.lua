----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function updatePaintjob(vehicle)
	triggerClientEvent("pjFunc.update", resourceRoot, vehicle)
end