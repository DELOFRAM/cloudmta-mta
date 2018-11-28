------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-08-11 14:59:47

local soundData = {}

function executeBind(keyNumber)
	if isChatBoxInputActive() or isConsoleActive() then return end
	local veh = localPlayer:getOccupiedVehicle()
	if isElement(veh) then
		if veh:getData("siren:type") and veh:getData("siren:type") > 0 then
			local sirInfo = sirenInfo[veh:getData("siren:type")][keyNumber]
			if sirInfo then
				if sirInfo.dir == "lights" then
					triggerServerEvent("changeLights", localPlayer, veh)
					return
				end
				if not sirInfo.loop then
					triggerServerEvent("turnSirenOn", localPlayer, veh, false, tonumber(keyNumber))
					return
				else
					if veh:getData("siren:on") then
						if veh:getData("siren:subType") ~= tonumber(keyNumber) then
							veh:setData("siren:on", false)
							veh:setData("siren:subType", tonumber(keyNumber))
							veh:setData("siren:on", true)
						else
							veh:setData("siren:on", false)
						end
					else
						veh:setData("siren:subType", tonumber(keyNumber))
						veh:setData("siren:on", true)
					end
				end
			end
		end
	end
end

function turnSirenOff(veh)
	if type(soundData[veh]) == "table" then
		if tonumber(soundData[veh].sound) then exports.titan_sounds:destroy3DSound(soundData[veh].sound) end
	end
	soundData[veh] = {}
end

function turnSirenOn(veh, loop, subType)
	if isElementStreamedIn(veh) then
		if not loop then
			local sirInfo = sirenInfo[veh:getData("siren:type")][subType]
			if sirInfo then
				exports.titan_sounds:create3DSound(":titan_vehicles/"..sirInfo.dir, false, nil, nil, 100, 50, 1.0, veh, nil, nil, 4000)
			end
		else
			if type(soundData[veh]) == "table" then
				if tonumber(soundData[veh].sound) then exports.titan_sounds:destroy3DSound(soundData[veh].sound) end
			end
			soundData[veh] = {}
			local sirInfo = sirenInfo[veh:getData("siren:type")][subType]
			if sirInfo then
				soundData[veh].sound = exports.titan_sounds:create3DSound(":titan_vehicles/"..sirInfo.dir, true, nil, nil, 100, 50, 1.0, veh, nil, nil, nil)
			end
		end

	end
end
addEvent("turnSirenOn", true)
addEventHandler("turnSirenOn", root, turnSirenOn)

function onDataChange(dataName)
	if source:getType() == "vehicle" then
		if dataName == "siren:on" then
			if source:getData("siren:on") then
				if isElementStreamedIn(source) then
					turnSirenOn(source, true, source:getData("siren:subType"))
				end
			else
				turnSirenOff(source)
				return
			end
		end
	end
end
addEventHandler("onClientElementDataChange", root, onDataChange)

function onStreamIn()
	if source:getType() == "vehicle" then
		if source:getData("siren:on") then
			turnSirenOn(source, true, source:getData("siren:subType"))
			return
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onStreamIn)

function onStreamOut()
	if source:getType() == "vehicle" then
		turnSirenOff(source)
		return
	end
end
addEventHandler("onClientElementStreamOut", root, onStreamOut)

function bindSirens(button, press)
	if getElementData(localPlayer, "bwTime") then return end
	if press then
		if localPlayer:isInVehicle() and (localPlayer:getOccupiedVehicleSeat() == 0 or localPlayer:getOccupiedVehicleSeat() == 1) then
			if button == "lshift" or button == "rshift" then
				for i = 1, 9 do
					if getKeyState(tostring(i)) then
						executeBind(i)
						return
					end
				end
			elseif tonumber(button) then
				if getKeyState("lshift") or getKeyState("rshift") then
					executeBind(tonumber(button))
					return
				end
			end
		end
	end
end
addEventHandler("onClientKey", root, bindSirens)