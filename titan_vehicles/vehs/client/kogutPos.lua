----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function checkPoliceKogutPosition()
	local veh = getPedOccupiedVehicle(localPlayer)
	if(isElement(veh)) then
			local x, y, z = getElementPosition(veh)
			local hit, hX, hY, hZ, hitElement = processLineOfSight(x, y, z + 4, x, y, z - 3, false, true, false, false, false, false)
			if(hit) then
				local zetka = math.abs(hZ - z) + 0.1
				triggerServerEvent("onClientFinalizeKogutPosCheck", localPlayer, localPlayer, zetka)
				return
			end
	end
	triggerServerEvent("onClientFinalizeKogutPosCheck", localPlayer, localPlayer, false)
end
addEvent("checkPoliceKogutPosition", true)
addEventHandler("checkPoliceKogutPosition", root, checkPoliceKogutPosition)