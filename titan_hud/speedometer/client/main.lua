----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()

licznik = 1

local renderData = {}
renderData[1] =
{
	X = sW - 430,
	Y = sH - 380,
	W = 430,
	H = 430,
	fontX = sW - 430 + 164,
	fontY = sH - 380 + 281,
	fontScale = 1.0,
	fuel = 96,
	km = 0.75

}
renderData[2] = 
{
	X = sW - 215,
	Y = sH - 200,
	W = 215,
	H = 215,
	fontX = sW - 215 + 82,
	fontY = sH - 200 + 140,
	fontScale = 0.5,
	fuel = 48,
	km = 0.75
}
renderData[3] = 
{
	X = sW - 300,
	Y = sH - 270,
	W = 300,
	H = 300,
	fontX = sW - 300 + 115,
	fontY = sH - 270 + 196,
	fontScale = 0.69,
	fuel = 96 * 0.69,
	km = 0.75
}
renderData.angle = 0

local dsFont = dxCreateFont("speedometer/client/files/dsfont.ttf", 13, false)

function setSpeedoSize(size)
	if size == 3 then size = 2 elseif
	size == 2 then size = 3 end
	licznik = size
end

function renderSpeedometer()
	if(not isPedInVehicle(localPlayer)) then return end
	--if(getElementData(localPlayer, "phoneState")) then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if(isElement(veh)) then
		if(getVehicleOccupant(veh) ~= localPlayer) then return end
		if getElementModel(veh) == 509 or getElementModel(veh) == 510 or getElementModel(veh) == 481 then return end
		if not getVehicleEngineState(veh) then return end
		local speed = getElementSpeed(veh)
		if(speed > 285) then speed = 285 end
		local angle = renderData[licznik].km * speed
		if(renderData.angle > angle + 2) then
			renderData.angle = renderData.angle - 1
			if(renderData.angle < 0) then renderData.angle = 0 end
		else
			renderData.angle = renderData[licznik].km * speed
		end

		local iState = getElementData(veh, "indicator")
		local hState = getElementData(veh, "handbrake")
		local health = getElementHealth(veh)
		local engine = "engine1"
		if(health < 500) then engine = "engine2" end
		if(health <= 350) then engine = "engine3" end
		local lights = getElementData(veh, "lightState")

		if localPlayer:getData("dashboardOn") then return end

		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, "speedometer/client/files/"..licznik.."/bg.png", 0, 0, 0)
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/%s.png", licznik, iState == 1 and "on_indicatorl" or "indicatorl"), 0, 0, 0)
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/%s.png", licznik, iState == 2 and "on_indicatorr" or "indicatorr"), 0, 0, 0)
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/%s.png", licznik, engine), 0, 0, 0)
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/%s.png", licznik, hState and "on_handbrake" or "handbrake"), 0, 0, 0)
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/%s.png", licznik, lights and "on_lights" or "lights"), 0, 0, 0)
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/fuelbg.png", licznik), 0, 0, 0)
		local vehMaxFuel = getElementData(veh, "vehMaxfuel")
		local vehFuel = getElementData(veh, "vehFuel")
		if(tonumber(vehMaxFuel) and tonumber(vehFuel)) then
			local progress = vehFuel / vehMaxFuel
			if(progress > 0.25) then
				dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/fuel.png", licznik), 0, 0, 0)
			else
				dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/on_fuel.png", licznik), 0, 0, 0)
			end
			dxDrawImage(renderData[licznik].X, renderData[licznik].Y - (renderData[licznik].fuel * progress), renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/fuelcross.png", licznik), 0, 0, 0)
		end

		--------------
		-- DISTANCE --
		--------------
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, string.format("speedometer/client/files/%d/distance.png", licznik), 0, 0, 0)
		--outputChatBox(giveNumberWithZeros(veh:getData("vehDistance")))
		dxDrawText(tostring(giveNumberToSpeedo(math.floor(veh:getData("vehDistance")))), renderData[licznik].fontX, renderData[licznik].fontY, 0, 0, tocolor(255, 255, 255, 200), renderData[licznik].fontScale, dsFont, "left", "top", false, false, false, false, true, 0, 0, 0)
		--------------
		-- WSKAŹNIK --
		--------------
		dxDrawImage(renderData[licznik].X, renderData[licznik].Y, renderData[licznik].W, renderData[licznik].H, "speedometer/client/files/"..licznik.."/arrow.png", renderData.angle, 0, 0)
	end
end--[[renderData[licznik].km * speed]]
addEventHandler("onClientRender", root, renderSpeedometer)

-------------
-- FUNKCJE --
-------------

function getElementSpeed(target)
	local x, y, z = getElementVelocity(target)
	return math.sqrt(x * x + y * y + z * z) * 155
end


function giveNumberToSpeedo(number)
	if not tonumber(number) then return "0 0 0 0 0 0 0" end
	if tonumber(number) > 99999999 then return "9 9 9 9 9 9 9" end
	number = tostring(number)
	--outputChatBox(number)
	local newString = tostring("")
	local lenght = string.len(number)
	local zeros = 7 - lenght
	for i = 1, zeros do
		if string.len(newString) <= 0 then
			newString = "0"
		else 
			newString = string.format("%s 0", newString)
		end
	end
	for i = 1, lenght do
		local newChar = string.char(string.byte(number, i))
		if tonumber(newChar) == 1 then
			newChar = string.format("%s ", newChar)
		end
		if string.len(newString) <= 0 then
			newString = newChar
		else 
			newString = string.format("%s %s", newString, newChar)
		end
	end
	return newString
end

function cmdLicznik()
	if licznik == 1 then licznik = 2 
	elseif licznik == 2 then licznik = 3
	elseif licznik == 3 then licznik = 1
	else licznik = 1 
	end
end
addCommandHandler("licznik", cmdLicznik, false, false)