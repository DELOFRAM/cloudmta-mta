----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

Damage = {
[2] = true,
[3] = true,
[4] = true,
[5] = true,
[6] = true,
[7] = true,
[8] = true,
[9] = true
}

function toggleHandbrakeMode(state)
	setControlState("handbrake", state)
end
addEvent("toggleHandbrakeMode", true)
addEventHandler("toggleHandbrakeMode", root, toggleHandbrakeMode)
