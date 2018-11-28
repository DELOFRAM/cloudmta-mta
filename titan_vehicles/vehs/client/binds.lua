--[[local function bindKey2()
	if(isPedInVehicle(localPlayer)) then
		if(getKeyState("e")) then
			engineStart()
		end
	end
end

local function bindKeyE()
	if(isPedInVehicle(localPlayer)) then
		if(getKeyState("2")) then
			engineStart()
		end
	end
end

function engineStart()
	triggerServerEvent("cmdSilnik", localPlayer, localPlayer)
end

local function onStart()
	bindKey("2", "down", bindKey2)
	bindKey("e", "down", bindKeyE)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)]]--