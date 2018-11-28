----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

casualTypes =
{
	KURIER = 1,
	DOSTAWCA_PIZZY = 2
}

local casualPickupData = {Vector3(1465.150, -1749.034, 15.445), 0, 0}
local casualPickup = nil

function casualOnPickupHit(element)
	if getElementType(element) == "player" then
		if not isPedInVehicle(element) then
			triggerClientEvent(element, "chooseGUICreate", element)
		end
	end
end

function casualEventOnClientTriedToChooseCasual(workID)
	if not exports.titan_login:isLogged(source) then return end
	exports.titan_db:query_free("UPDATE _characters SET casual = ? WHERE ID = ?", workID, source:getData("charID"))
	source:setData("casual", workID)
	exports.titan_noti:showBox(source, "Praca dorywcza została zmieniona.")
end
addEvent("casualEventOnClientTriedToChooseCasual", true)
addEventHandler("casualEventOnClientTriedToChooseCasual", root, casualEventOnClientTriedToChooseCasual)

function casualOnResourceStart()
	casualPickup = createPickup(casualPickupData[1].x, casualPickupData[1].y, casualPickupData[1].z, 3, 1272, 0)
	addEventHandler("onPickupHit", casualPickup, casualOnPickupHit)
end
addEventHandler("onResourceStart", resourceRoot, casualOnResourceStart)

function getPlayerCasualWork(player)
	if not exports.titan_login:isLogged(player) then return 0 end
	if not tonumber(player:getData("casual")) then return 0 end
	return player:getData("casual")
end