----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-19 19:15:04
-- Ostatnio zmodyfikowano: 2016-01-19 21:43:01
----------------------------------------------------

local dashCamFunc = {}
local sW, sH = guiGetScreenSize()

dashCamFunc.renderData = {sW / 2 - 256, sH - 256, 512, 256}

function dashCamFunc.render()
	if isPedInVehicle(localPlayer) and (localPlayer:getOccupiedVehicleSeat() == 0 or localPlayer:getOccupiedVehicleSeat() == 1) and localPlayer:getOccupiedVehicle():getData("dashcamActive") then
		local time = getRealTime()
		dxDrawImage(dashCamFunc.renderData[1], dashCamFunc.renderData[2], dashCamFunc.renderData[3], dashCamFunc.renderData[4], "dashcam/client/files/dashcam.png")
		local x1, y1, z1, x2, y2, z2 = getElementBoundingBox(localPlayer:getOccupiedVehicle())
		local matrix = localPlayer:getMatrix()
		local newMatrix = matrix:transformPosition(Vector3(0, 25, 0))
		local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(matrix:getPosition(), newMatrix, true, true, false, true, true, false, false, false, getPedOccupiedVehicle(localPlayer), false, true)
		--dxDrawLine3D(matrix:getPosition(), newMatrix, tocolor(255, 255, 255, 255))
		if hit then
			if isElement(hitElement) and hitElement:getType() == "vehicle" then
				if dashCamFunc.veh ~= hitElement then
					dashCamFunc.veh = hitElement
					dashCamFunc.maxSpeed = 0
				end
				if tonumber(dashCamFunc.tick) then dashCamFunc.tick = nil end
			end
		else
			if isElement(dashCamFunc.veh) then
				if not tonumber(dashCamFunc.tick) then dashCamFunc.tick = getTickCount() end
				if getTickCount() - dashCamFunc.tick > 2000 then dashCamFunc.veh = nil dashCamFunc.tick = nil end
			end
		end
		local dist = isElement(dashCamFunc.veh) and math.floor(getDistanceBetweenPoints2D(localPlayer:getOccupiedVehicle():getPosition(), dashCamFunc.veh:getPosition())).."m" or "n/d"
		local plate = isElement(dashCamFunc.veh) and tostring(dashCamFunc.veh:getPlateText()) or "n/d"
		local speed = isElement(dashCamFunc.veh) and math.floor(getElementSpeed(dashCamFunc.veh)) or "Brak pomiaru"
		if tonumber(speed) then
			if speed > dashCamFunc.maxSpeed then dashCamFunc.maxSpeed = speed end
		end
		local name = isElement(dashCamFunc.veh) and dashCamFunc.veh:getName() or "n/d"
		local maxSpeed = isElement(dashCamFunc.veh) and dashCamFunc.maxSpeed.." km/h" or "n/d"
		if tonumber(speed) then speed = speed.." km/h" end
		dxDrawText(name, dashCamFunc.renderData[1] + 410, dashCamFunc.renderData[2] + 69, 0, 0, tocolor(220, 220, 220, 255), 1.0, "default-bold")
		dxDrawText(dist, dashCamFunc.renderData[1] + 410, dashCamFunc.renderData[2] + 81, 0, 0, tocolor(220, 220, 220, 255), 1.0, "default-bold")
		dxDrawText(plate, dashCamFunc.renderData[1] + 410, dashCamFunc.renderData[2] + 111.5, 0, 0, tocolor(220, 220, 220, 255), 1.0, "default-bold")
		dxDrawText(string.format("%0.2d:%0.2d:%0.2d", time.hour, time.minute, time.second), dashCamFunc.renderData[1] + 410, dashCamFunc.renderData[2] + 153, 0, 0, tocolor(220, 220, 220, 255), 1.0, "default-bold")
		dxDrawText(maxSpeed, dashCamFunc.renderData[1] + 80, dashCamFunc.renderData[2] + 68, 0, 0, tocolor(220, 220, 220, 255), 1.0, "default-bold")
		dxDrawText(speed, dashCamFunc.renderData[1] + 30, dashCamFunc.renderData[2] + 85, dashCamFunc.renderData[1] + 350, dashCamFunc.renderData[2] + 180, tocolor(220, 220, 220, 255), 3.0, "default-bold", "center", "center")
	end
end
addEventHandler("onClientRender", root, dashCamFunc.render)

function getElementSpeed(target)
	local x, y, z = getElementVelocity(target)
	return math.sqrt(x * x + y * y + z * z) * 155
end