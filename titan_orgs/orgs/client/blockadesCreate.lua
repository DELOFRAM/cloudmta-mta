----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local bGUI = {}
local bRender = {}
local sW, sH = guiGetScreenSize()
---------
-- GUI --
---------

function bGUI.create(data)
	if bGUI.state then
		exports.titan_noti:showBox("Tworzysz już jedną blokadę.")
		return
	end
	if bRender.remove then
		exports.titan_noti:showBox("Nie możesz tworzyć blokady będąc w trybie usuwania. Aby wyjść z trybu naciśnij Prawy Przycisk Myszy (PPM).")
	end
	bGUI.okno = guiCreateWindow(sW / 2 - 278 / 2, sH / 2 - 295 / 2, 278, 295, "Jaką blokadę chcesz postawić?", false)
	bGUI.lista = guiCreateGridList(10, 27, 258, 218, false, bGUI.okno)
	guiGridListAddColumn(bGUI.lista, "Nazwa", 0.9)
	bGUI.zamknij = guiCreateButton(10, 255, 258, 30, "Zamknij", false, bGUI.okno)
	guiWindowSetSizable(bGUI.okno, false)
	exports.titan_cursor:showCustomCursor("orgsClientBlockadesCreate")
	addEventHandler("onClientGUIClick", bGUI.zamknij, bGUI.delete, false)
	addEventHandler("onClientGUIDoubleClick", bGUI.lista, bGUI.add, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(bGUI.lista)
		guiGridListSetItemText(bGUI.lista, row, 1, v.name, false, false)
		guiGridListSetItemData(bGUI.lista, row, 1, {v.ID, v.model})
	end
end
addEvent("bGUI.create", true)
addEventHandler("bGUI.create", root, bGUI.create)

function bGUI.delete()
	if isElement(bGUI.okno) then destroyElement(bGUI.okno) end
	exports.titan_cursor:hideCustomCursor("orgsClientBlockadesCreate")
end

function bGUI.add()
	local row = guiGridListGetSelectedItem(bGUI.lista)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(bGUI.lista, row, 1)
	if data then
		bGUI.delete()
		bGUI.state = true
		local x, y, z = bRender.getPositionInFrontOfPlayer(3.0)
		local rx, ry, rz = getElementRotation(localPlayer)
		if isElement(bRender.object) then destroyElement(bRender.object) end
		bRender.object = createObject(data[2], x, y, z, 0, 0, rz)
		setElementCollisionsEnabled(bRender.object, false)
		local x0, y0, z0 = getElementBoundingBox(bRender.object)
		local z1 = bRender.getZPosition(x, y, z)
		bRender.object:setPosition(x, y, z1 + math.abs(z0))
		bRender.object:setRotation(0, 0, rz)
		bRender.objectID = data[2]

		bRender.pos = {x, y, z1 + math.abs(z0), rz}
		bRender.radius = {0, 0, 0}

		exports.titan_cursor:showCustomCursor("orgsClientBlockadesCreate")
		addEventHandler("onClientRender", root, bRender.render)
		addEventHandler("onClientKey", root, bRender.keyHandler)
	end
end

------------
-- RENDER --
------------

function bRender.render()
	if getKeyState("space") then
		exports.titan_cursor:hideCustomCursor("orgsClientBlockadesCreate")
	else
		exports.titan_cursor:showCustomCursor("orgsClientBlockadesCreate")
	end
	if isElement(bRender.object) then
		local oX, oY, oZ = getElementPosition(bRender.object)
		local oRX, oRY, oRZ = getElementRotation(bRender.object)

		local xVel1, yVel1 = bRender.velocityAngleZtoX(oRZ)
		local xVel2, yVel2 = bRender.velocityAngleZtoY(-oRZ)

		dxDrawLine3D(oX - xVel1, oY - yVel1, oZ, oX + xVel1, oY + yVel1, oZ, tocolor(255, 0, 0, 255), 2, true)
		dxDrawLine3D(oX - xVel2, oY - yVel2, oZ, oX + xVel2, oY + yVel2, oZ, tocolor(0, 255, 0, 255), 2, true)
		dxDrawLine3D(oX, oY, oZ - 1, oX, oY, oZ + 1, tocolor(0, 0, 255, 255), 2, true)

		local multiple = 1.0 
		if getKeyState("lshift") then multiple = 0.1 end

		if not getKeyState("space") and not getKeyState("lctrl") then
			if getKeyState("w") then
				bRender.radius[1] = bRender.radius[1] + 0.1 * multiple
			end
			if getKeyState("s") then
				bRender.radius[1] = bRender.radius[1] - 0.1 * multiple
			end
			if getKeyState("a") then
				bRender.radius[2] = bRender.radius[2] + 0.1 * multiple
			end
			if getKeyState("d") then
				bRender.radius[2] = bRender.radius[2] - 0.1 * multiple
			end
		end
		if getKeyState("lctrl") then
			if getKeyState("w") then
				bRender.radius[3] = bRender.radius[3] + 0.1 * multiple
			end
			if getKeyState("s") then
				bRender.radius[3] = bRender.radius[3] - 0.1 * multiple
			end
		end
		xVel1, yVel1 = bRender.velocityAngleZtoX(oRZ, bRender.radius[1])
		xVel2, yVel2 = bRender.velocityAngleZtoY(-oRZ, bRender.radius[2])
		local newPos =
		{
			bRender.pos[1] + xVel1 + xVel2,
			bRender.pos[2] + yVel1 + yVel2,
			bRender.pos[3] + bRender.radius[3],
			bRender.pos[4]
		}
		bRender.object:setPosition(newPos[1], newPos[2], newPos[3])
		bRender.object:setRotation(oRX, oRY, bRender.pos[4])

		bRender.pos = newPos
		bRender.radius = {0, 0, 0}

	end
end

function bRender.keyHandler(key, press)
	if isElement(bRender.object) then
		if press then
			local multiple = 1.0 
			if getKeyState("lshift") then multiple = 0.1 end
			if key == "mouse_wheel_up" then
				bRender.pos[4] = bRender.pos[4] + 10.0 * multiple
			elseif key == "mouse_wheel_down" then
				bRender.pos[4] = bRender.pos[4] - 10.0 * multiple
			elseif key == "enter" then
				cancelEvent()
				local oX, oY, oZ = getElementPosition(bRender.object)
				local oRX, oRY, oRZ = getElementRotation(bRender.object)
				exports.titan_cursor:hideCustomCursor("orgsClientBlockadesCreate")
				removeEventHandler("onClientRender", root, bRender.render)
				removeEventHandler("onClientKey", root, bRender.keyHandler)
				destroyElement(bRender.object)
				bGUI.state = false
				bRender.pos = {}
				bRender.radius = {}
				triggerServerEvent("createBlockade", localPlayer, bRender.objectID, oX, oY, oZ, oRX, oRY, oRZ)
			end
		end
	end
end

function bRender.getPositionInFrontOfPlayer(distance)
	local x, y, z = getElementPosition(localPlayer)
	local _, _, rot = getElementRotation(localPlayer)
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z, rot
end

function bRender.getZPosition(x, y, z)
	local hit, hitX, hitY, hitZ = processLineOfSight(x, y, z, x, y, z - 5)
	if hit then return hitZ else return z end
end

function bRender.velocityAngleZtoX(angle, distance)
	if not distance then distance = 1 end
	local xVel = math.cos(math.rad(angle)) * distance
	local yVel = math.sin(math.rad(angle)) * distance
	return xVel, yVel
end

function bRender.velocityAngleZtoY(angle, distance)
	if not distance then distance = 1 end
	local xVel = math.sin(math.rad(angle)) * distance
	local yVel = math.cos(math.rad(angle)) * distance
	return xVel, yVel
end

-- RENDERING TEXTU
local renderedObjects = {}
local RENDERDIST = 10.0
function onElementStreamIn()
	if(getElementType(source) == "object" and getElementData(source, "isBlockade")) then
		if(not renderedObjects[source]) then
			renderedObjects[source] = true
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)

local function onResStart()
	for k, v in ipairs(getElementsByType("object")) do
		if(isElementStreamedIn(v) and getElementData(v, "isBlockade")) then
			renderedObjects[v] = true
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)

function onElementStreamOut()
	if(getElementType(source) == "object") then
		if(renderedObjects[source]) then
			renderedObjects[source] = false
		end
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

function renderTexts()
	local camX, camY, camZ = getCameraMatrix()
	for object in pairs(renderedObjects) do
		if isElement(object) and object:getType() == "object" and object:getData("isBlockade") then
			local oX, oY, oZ = getElementPosition(object)
			local distance = getDistanceBetweenPoints3D(camX, camY, camZ, oX, oY, oZ)
			if distance < RENDERDIST then
				local progress = distance / RENDERDIST
				--if not processLineOfSight(camX, camY, camZ, oX, oY, oZ, true, true, false, true, true, false, false, false) then
					local screenW, screenH = getScreenFromWorldPosition(oX, oY, oZ, 10, false)
					if screenW then
						local text = tostring(object:getData("blockadeGroup"))
						dxDrawText(text, screenW - 9, screenH - 9, screenW + 11, screenH + 11, tocolor(0, 0, 0, 180), 0.8, "default-bold", "center", "center")
						dxDrawText(text, screenW - 10, screenH - 10, screenW + 10, screenH + 10, tocolor(255, 255, 255, 180), 0.8, "default-bold", "center", "center")
					end
				--end
			end
		end
	end
end
addEventHandler("onClientRender", root, renderTexts)

function bRender.clickButtonSelect(button, state)
	if button == "right" and state == "down" then
		removeEventHandler("onClientClick", root, bRender.clickButtonSelect)
		exports.titan_cursor:hideCustomCursor("orgsClientBlockadesDelete")
		bRender.remove = false
		return
	elseif button == "left" and state == "up" then
		if isCursorShowing() then
			local cX, cY = getCursorPosition()
			if cX then
				local absX = cX * sW
				local absY = cY * sH
				local camX, camY, camZ = getCameraMatrix()
				local wX, wY, wZ = getWorldFromScreenPosition(absX, absY, 100.0)
				local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(camX, camY, camZ, wX, wY, wZ, false, false, false, true, false)
				if hit and isElement(hitElement) and getElementType(hitElement) == "object" and getElementData(hitElement, "isBlockade") then
					triggerServerEvent("removeBlockade", localPlayer, hitElement)
				end
			end
		end
	end
end

function bRender.toggleRemoveBlockade()
	if not bRender.remove then
		if bGUI.state then
			exports.titan_noti:showBox("Jesteś w trakcie tworzenia blokady.")
			return
		end
		bRender.remove = true
		addEventHandler("onClientClick", root, bRender.clickButtonSelect)
		exports.titan_cursor:showCustomCursor("orgsClientBlockadesDelete")
	else
		removeEventHandler("onClientClick", root, bRender.clickButtonSelect)
		exports.titan_cursor:hideCustomCursor("orgsClientBlockadesDelete")
		bRender.remove = false
		return
	end
end
addEvent("bRender.toggleRemoveBlockade", true)
addEventHandler("bRender.toggleRemoveBlockade", root, bRender.toggleRemoveBlockade)