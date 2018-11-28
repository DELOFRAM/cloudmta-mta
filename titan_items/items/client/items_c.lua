----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function onWeapFire(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	triggerServerEvent("onPlayerWeapFire", localPlayer, weapon)
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, onWeapFire)

local animGuns =
{
	[24] = true,
	[30] = true,
	[31] = true
}

local function onDamage(attacker, weapon, bodypart, loss)
	if(isElement(attacker)) then
		local taserID = getElementData(attacker, "taserID")
		if(tonumber(taserID)) then
			if(taserID == weapon) then
				cancelEvent()
				if(tonumber(getElementData(localPlayer, "bwTime")) and tonumber(getElementData(localPlayer, "bwTime")) > 0) then return end
				if(not isPedInVehicle(localPlayer)) then
					if(weapon == 24) then
						local aX, aY, aZ = getElementPosition(attacker)
						local pX, pY, pZ = getElementPosition(localPlayer)
						local distance = getDistanceBetweenPoints3D(aX, aY, aZ, pX, pY, pZ)
						if(distance > 10) then return end
					end
					local taserTimer = getElementData(localPlayer, "taserTimer")
					if(isTimer(taserTimer)) then killTimer(taserTimer) else triggerServerEvent("animTaserSynchronise", localPlayer, 1) end
					taserTimer = setTimer(disableTaser, 10000, 1)
					setElementData(localPlayer, "taserTimer", taserTimer)
					toggleAllControls(false, true, false)
				end
			end
		end
		if weapon == 34 or bodypart == 9 and taserID ~= weapon then
			if getElementHealth(source) > 0 then
				return triggerServerEvent("triggerKillPed", localPlayer, localPlayer, attacker, weapon, bodypart)
			end
		end
		if getElementHealth(source) > 0 and getElementHealth(source) < 50 then
			if bodypart == 7 or bodypart == 8 then
				if animGuns[weapon] then
					local taserTimer = getElementData(localPlayer, "taserTimer")
					if(isTimer(taserTimer)) then killTimer(taserTimer) else triggerServerEvent("animTaserSynchronise", localPlayer, 1) end
					taserTimer = setTimer(disableTaser, 10000, 1)
					setElementData(localPlayer, "taserTimer", taserTimer)
					toggleAllControls(false, true, false)
				end
			end
		end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDamage)

function disableTaser()
	if(not isElement(getElementData(localPlayer, "cuffedBy"))) then
		toggleAllControls(true)
	end
	triggerServerEvent("animTaserSynchronise", localPlayer, 2)

	local taserTimer = getElementData(localPlayer, "taserTimer")
	if(isTimer(taserTimer)) then
		killTimer(taserTimer)
		setElementData(localPlayer, "taserTimer", false)
	end
end

local isControl = false

function cuff()
	local cuffedBy = getElementData(localPlayer, "cuffedBy")
	if(isElement(cuffedBy)) then
		local rX, rY, rZ = getElementRotation(cuffedBy)
		local pX, pY, pZ = getElementPosition(cuffedBy)
		pX, pY = getXYInFrontOfPlayer(cuffedBy, 1.5)
		--setElementPosition(localPlayer, pX, pY, pZ)
		setElementRotation(localPlayer, rX, rY, rZ)
	end
end
addEventHandler("onClientRender", root, cuff)
local shakeData =
{
	state = false,
	start = getTickCount(),
	duration = 10000,
	level = 255
}
function setDrunkLevel(percent, duration)
	shakeData.level = (percent / 100) * 255
	shakeData.duration = duration
	shakeData.start = getTickCount()
	if not shakeData.state then
		addEventHandler("onClientRender", root, drunkRender)
		shakeData.state = true
	end
end
addEvent("setDrunkLevel", true)
addEventHandler("setDrunkLevel", root, setDrunkLevel)

function drunkRender()
	if shakeData.state then
		local progress = (getTickCount() - shakeData.start) / shakeData.duration
		if progress > 1 then
			setCameraShakeLevel(0)
			removeEventHandler("onClientRender", root, drunkRender)
			shakeData.state = false
			setElementData(localPlayer, "isDrunk", false)
			return
		end
		local sLevel = interpolateBetween(shakeData.level, 0, 0, 0, 0, 0, progress, "Linear")
		setCameraShakeLevel(sLevel)
	end
end

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y
end
function onPreEvent( sourceResource, eventName, eventSource, eventClient, luaFilename, luaLineNumber, ... )
    local args = { ... }
    local srctype = eventSource and getElementType(eventSource)
    local resname = sourceResource and getResourceName(sourceResource)
    local plrname = eventClient and getPlayerName(eventClient)
    outputDebugString( "preEvent"
        .. " " .. tostring(resname)
        .. " " .. tostring(eventName)
        .. " source:" .. tostring(srctype)
        .. " player:" .. tostring(plrname)
        .. " file:" .. tostring(luaFilename)
        .. "(" .. tostring(luaLineNumber) .. ")"
        .. " numArgs:" .. tostring(#args)
        .. " arg1:" .. tostring(args[1])
        )
end

--addDebugHook( "postEvent", onPreEvent, {"onClientPlayerDamage"})

addEventHandler("onClientResourceStart", root, function()
	for _, obj in ipairs(getElementsByType("object")) do
		if getElementModel(obj) == 1271 or getElementModel(obj) == 1486 then setObjectBreakable(obj, false) end
	end
end)