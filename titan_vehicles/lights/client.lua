----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local streamableVehicles = {}

local lights = {}
lights[1] = {[1] = {255, 0, 0}, [2] = {0, 0, 255}}
lights[2] = {[1] = {255, 0, 0}, [2] = {246, 215, 59}}

function onElementStreamIn()
	if(getElementType(source) == "vehicle") then
		if(not streamableVehicles[source]) then
			streamableVehicles[source] = 2
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)

local function onResStart()
	for k, v in ipairs(getElementsByType("vehicle")) do
		if(isElementStreamedIn(v)) then
			streamableVehicles[v] = 1
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)

function onElementStreamOut()
	if(getElementType(source) == "vehicle") then
		if(streamableVehicles[source]) then
			streamableVehicles[source] = false
		end
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

function lightTimer()
	for k, v in pairs(streamableVehicles) do
		if(isElement(k)) then
			if(tonumber(v)) then
				local flashType = getElementData(k, "flashType")
				if(tonumber(flashType)) then
					setVehicleOverrideLights(k, 2)
					if(v == 1) then
						setVehicleHeadLightColor(k, lights[flashType][1][1], lights[flashType][1][2], lights[flashType][1][3])
						setVehicleLightState(k, 0, 0)
						setVehicleLightState(k, 1, 1)
						setVehicleLightState(k, 2, 0)
						setVehicleLightState(k, 3, 0)
						streamableVehicles[k] = 2
					else
						if(flashType ~= 1 and flashType ~= 2) then flashType = 1 end
						setVehicleHeadLightColor(k, lights[flashType][2][1], lights[flashType][2][2], lights[flashType][2][3])
						setVehicleLightState(k, 0, 1)
						setVehicleLightState(k, 1, 0)
						setVehicleLightState(k, 2, 1)
						setVehicleLightState(k, 3, 1)
						streamableVehicles[k] = 1
					end
				end
			end
		end
	end
end
setTimer(lightTimer, 200, 0)