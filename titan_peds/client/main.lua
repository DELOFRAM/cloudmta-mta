----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cancelPedDamage ( attacker )
	cancelEvent()
end
addEventHandler ( "onClientPedDamage", root, cancelPedDamage )