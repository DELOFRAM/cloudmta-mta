----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local vehDist = {}

function vehDist.render()
	if isPedInVehicle(localPlayer) and getVehicleOccupant(getPedOccupiedVehicle(localPlayer)) == localPlayer then
		local veh = getPedOccupiedVehicle(localPlayer)
		if not vehDist.oldPos then vehDist.oldPos = veh:getPosition() end
		if not vehDist.distance then vehDist.distance = 0 end
		local vehPos = veh:getPosition()
		local dist = getDistanceBetweenPoints3D(vehDist.oldPos, vehPos)
		vehDist.distance = vehDist.distance + dist
		vehDist.oldPos = vehPos
	else
		return vehDist.stopRenderDist() 
	end
end

function vehDist.startNewRenderDist(element)
	vehDist.element = element
	vehDist.oldPos = element:getPosition()
	vehDist.distance = 0
	addEventHandler("onClientRender", root, vehDist.render)
	if isTimer(vehDist.timer) then killTimer(vehDist.timer) end
	vehDist.timer = setTimer(vehDist.save, 1000, 0)
end
addEvent("vehDist.startNewRenderDist", true)
addEventHandler("vehDist.startNewRenderDist", root, vehDist.startNewRenderDist)

function vehDist.save()
	if isElement(vehDist.element) then
		--local previousDistance = vehDist.element:getData("vehDistance")
		--if not tonumber(previousDistance) then previousDistance = 0 end
		triggerServerEvent("changeVehicleDistance", localPlayer, vehDist.element, vehDist.distance / 500)
		--vehDist.element:setData("vehDistance", previousDistance + vehDist.distance / 500)
		vehDist.distance = 0
	else
		return killTimer(vehDist.timer)
	end
end

function vehDist.stopRenderDist()
	vehDist.save()
	removeEventHandler("onClientRender", root, vehDist.render)
end