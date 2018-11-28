----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local MOVING = 0.02
local startPos = {}
local animInfo = {}
local animationInfo = {}

function renderAnim()
	local rx, ry, rz = getElementRotation(localPlayer)
	if getKeyState("w") then changePosition(rz, MOVING) end
	if getKeyState("s") then changePosition(rz + 180, MOVING) end
	if getKeyState("a") then changePosition(rz + 90, MOVING) end
	if getKeyState("d") then changePosition(rz - 90, MOVING) end
	if getKeyState("num_add") then setPosZ(MOVING) end
	if getKeyState("num_sub") then setPosZ(MOVING*(-1)) end
end

function bindShift(key, state)
	if state == "down" then
		addEventHandler("onClientRender", root, renderAnim)
		--[[toggleControl("fire", false)
		toggleControl("forwards", false)
		toggleControl("backwards", false)
		toggleControl("left", false)
		toggleControl("right", false)
		toggleControl("jump", false)
		toggleControl("aim_weapon", false)]]
	else
		removeEventHandler("onClientRender", root, renderAnim)
		--[[toggleControl("fire", true)
		toggleControl("forwards", true)
		toggleControl("backwards", true)
		toggleControl("left", true)
		toggleControl("right", true)
		toggleControl("jump", true)
		toggleControl("aim_weapon", true)]]
	end
end

function changePosition(angle, distance)
	local x, y, z = getElementPosition(localPlayer)
	local nX, nY = x + math.sin(math.rad(-angle)) * distance, y + math.cos(math.rad(-angle)) * distance
	if getDistanceBetweenPoints3D(startPos.x, startPos.y, startPos.z, nX, nY, z) > 2 then return end
	localPlayer:setPosition(nX, nY, z)
	setPedAnimation(localPlayer, animInfo.animlib, animInfo.animname, -1, animInfo.loop == 1 and true or false, animInfo.updatepos == 1 and true or false, animInfo.interruptable == 1 and true or false, animInfo.freeze == 1 and true or false)
end

function setPosZ(number)
	local x, y, z = getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(startPos.x, startPos.y, startPos.z, x, y, z + number) > 2 then return end
	setElementPosition(localPlayer, x, y, z + number)
	setPedAnimation(localPlayer, animInfo.animlib, animInfo.animname, -1, animInfo.loop == 1 and true or false, animInfo.updatepos == 1 and true or false, animInfo.interruptable == 1 and true or false, animInfo.freeze == 1 and true or false)
	return
end

function cancelAnim()
	triggerServerEvent("playerStopAnim", localPlayer, localPlayer)
end

function onAnimStarted(pos, info)
	startPos =
	{
		x = pos[1],
		y = pos[2],
		z = pos[3]
	}
	animInfo = info
	bindKey("space", "down", cancelAnim)
	if animInfo.updatepos == 0 and animInfo.loop == 1 then
		--addEventHandler("onClientRender", root, renderTitle)
		exports.titan_noti:showBox("Przytrzymaj SHIFT aby włączyć przesuwanie postaci. Naciśnij spację, aby wyłączyć animację.")
		bindKey("lshift", "down", bindShift)
		bindKey("lshift", "up", bindShift)
		setElementCollisionsEnabled(localPlayer, false)
	end
end
addEvent("onAnimStarted", true)
addEventHandler("onAnimStarted", root, onAnimStarted)

function onAnimStopped()
	--removeEventHandler("onClientRender", root, renderTitle)
	removeEventHandler("onClientRender", root, renderAnim)
	unbindKey("lshift", "down", bindShift)
	unbindKey("lshift", "up", bindShift)
	unbindKey("space", "down", cancelAnim)
	toggleControl("fire", true)
	toggleControl("forwards", true)
	toggleControl("backwards", true)
	toggleControl("left", true)
	toggleControl("right", true)
	toggleControl("jump", true)
	toggleControl("aim_weapon", true)
	if animInfo.updatepos == 0 and animInfo.loop == 1 then
		local x, y, z = getElementPosition(localPlayer)
		animationInfo =
		{
			x1 = x,
			y1 = y,
			z1 = z,
			x2 = startPos.x,
			y2 = startPos.y,
			z2 = startPos.z,
			start = getTickCount()
		}
		if getDistanceBetweenPoints3D(x, y, z, startPos.x, startPos.y, startPos.z) < 3 then
			addEventHandler("onClientRender", root, setOldPosition)
		end
	end
	startPos = {}
	animInfo = {}
	setElementCollisionsEnabled(localPlayer, true)
end
addEvent("onAnimStopped", true)
addEventHandler("onAnimStopped", root, onAnimStopped)

function setOldPosition()
	local progress = (getTickCount() - animationInfo.start) / 200
	local x, y, z = interpolateBetween(animationInfo.x1, animationInfo.y1, animationInfo.z1, animationInfo.x2, animationInfo.y2, animationInfo.z2, progress, "Linear")
	setElementPosition(localPlayer, x, y, z)
	if progress > 1 then
		removeEventHandler("onClientRender", root, setOldPosition)
	end
end