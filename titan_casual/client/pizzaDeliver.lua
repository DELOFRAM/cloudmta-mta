----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local markerPositions = 
{
	Vector3(1092.51, -1094.03, 25),
	Vector3(1090.74, -1067.89, 28),
	Vector3(1118.29, -1030.73, 31),
	Vector3(1127.49, -1031.01, 31),
	Vector3(1170.55, -1074.24, 27),
	Vector3(1171.66, -1100.63, 25),
	Vector3(1195.66, -1133.71, 23),
	Vector3(1234.80, -1157.10, 23),
	Vector3(1304.56, -1133.86, 23),
	Vector3(1313.34, -1156.14, 23)
}

local jobData =
{
	mainMarker = Vector3(2095, -1806, 12.5)
}

function startPizzaDeliverJob()
	stopPizzaDeliverJob()
	exports.titan_noti:showBox("Rozpoczałeś pracę rozwoziciela pizzy. Jedź w stronę markera zaznaczonego na mapie, aby dostarczyć pizzę. Aby anulować pracę zejdź z pojazdu.")
	local randomIndex = math.random(1, #markerPositions)

	jobData.marker = createMarker(markerPositions[randomIndex], "cylinder", 2.0, 100, 100, 200, 100)
	jobData.blip = createBlip(markerPositions[randomIndex], 0, 2, 100, 100, 200, 255)

	addEventHandler("onClientMarkerHit", jobData.marker, changeMarker)

end
addEvent("startPizzaDeliverJob", true)
addEventHandler("startPizzaDeliverJob", root, startPizzaDeliverJob)

function stopPizzaDeliverJob()
	if isElement(jobData.marker) then destroyElement(jobData.marker) end
	if isElement(jobData.blip) then destroyElement(jobData.blip) end
end
addEvent("stopPizzaDeliverJob", true)
addEventHandler("stopPizzaDeliverJob", root, stopPizzaDeliverJob)

function changeMarker(player, dimension)
	if dimension and localPlayer == player then 
		exports.titan_noti:showBox("Dowiozłeś pizzę. Teraz wróć pojazdem pod pizzerię aby otrzymać wypłatę.")

		stopPizzaDeliverJob()
		jobData.marker = createMarker(jobData.mainMarker, "cylinder", 2.0, 100, 100, 200, 100)
		jobData.blip = createBlip(jobData.mainMarker, 0, 2, 100, 100, 200, 255)

		addEventHandler("onClientMarkerHit", jobData.marker, jobDone)
	end
end

function jobDone(player, dimension)
	if localPlayer == player and dimension then
		stopPizzaDeliverJob()
		triggerServerEvent("pizzaDeliverJobDone", localPlayer, localPlayer, getPedOccupiedVehicle(localPlayer))
	end
end
	
function tempCmd()
	local x, y, z = getElementPosition(localPlayer)
	if isPedInVehicle(localPlayer) then x, y, z = getElementPosition(getPedOccupiedVehicle(localPlayer)) end
	outputConsole(string.format("Vector3(%0.2f, %0.2f, %0.2f)", x, y, z))
end
addCommandHandler("abc", tempCmd, false, false)