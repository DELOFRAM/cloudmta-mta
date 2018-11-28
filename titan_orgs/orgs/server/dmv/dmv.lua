----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local dmvPed
function createDMV()
	dmvPed = createPed(60, -2035.09, -117.41, 1035.17, 270, false)
	setElementFrozen(dmvPed, true)

	setElementInterior(dmvPed, 3)
	setElementDimension(dmvPed, 7)
end

function cmdDmv(player)
	if(not exports.titan_login:isLogged(player)) then return end
	if(getElementDimension(player) ~= getElementDimension(dmvPed)) then return end
	if(getElementInterior(player) ~= getElementInterior(dmvPed)) then return end

	
end
addCommandHandler("dmv", cmdDmv, false, false)