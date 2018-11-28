----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local EasingType = {
{"Linear"},
{"InQuad"},
{"OutQuad"},
{"InOutQuad"},
{"OutInQuad"},
{"InElastic"},
{"OutElastic"},
{"InOutElastices"},	
{"OutInElastices"},
{"InBack"},
{"OutBack"},
{"InOutBack"},
{"OutInBack"},
{"InBounce"},
{"OutBounce"},
{"InOutBounce"},
{"OutInBounce"},
{"SineCurve"},
{"CosineCurve"}
}


local editor =
{
	state = false,
	object = nil,
	editAxis = 0,
	cursorOldPos = {0, 0}
}
local sW, sH = guiGetScreenSize()
local MAX_DISTANCE = 150
local infoRender = {}
infoRender.sW, infoRender.sH = guiGetScreenSize()
infoRender.rectangle = {X = infoRender.sW - 200, Y = infoRender.sH - 200, W = 200, H = 100}


local gates =
{
	state = false
}

local buttons =
{
	W = 20,
	H = 20,
	X =
	{
		posX = sW / 2 - 200,
		posY = sH / 2 + 100
	},
	Y =
	{
		posX = sW / 2 - 180,
		posY = sH / 2 + 100
	},
	Z =
	{
		posX = sW / 2 - 160,
		posY = sH / 2 + 100
	},

	RX =
	{
		posX = sW / 2 - 200,
		posY = sH / 2 + 120
	},

	RY =
	{
		posX = sW / 2 - 180,
		posY = sH / 2 + 120
	},	


	RZ =
	{
		posX = sW / 2 - 160,
		posY = sH / 2 + 120
	},
	chosen = 1
}

editor.editGui = {}
function editor.createEditGUI()
	if isElement(editor.editGui.window) then destroyElement(editor.editGui.window) end
	local objectID = getElementData(editor.object, "objectID")
	local posX, posY, posZ = getElementPosition(editor.object)
	local rotX, rotY, rotZ = getElementRotation(editor.object)

	editor.editGui.window = guiCreateWindow(sW - 273, sH / 2 - 150, 263, 300, "Edycja obiektu", false)
	guiWindowSetSizable(editor.editGui.window, false)

	editor.editGui.info = guiCreateEdit(10, 28, 243, 27, string.format("ID obiektu: %d", objectID), false, editor.editGui.window)
	
	editor.editGui.posx = guiCreateEdit(10, 95, 104, 27, posX, false, editor.editGui.window)
	editor.editGui.posy = guiCreateEdit(10, 132, 104, 27, posY, false, editor.editGui.window)
	editor.editGui.posz = guiCreateEdit(10, 169, 104, 27, posZ, false, editor.editGui.window)
	editor.editGui.posrx = guiCreateEdit(139, 95, 104, 27, rotX, false, editor.editGui.window)
	editor.editGui.posry = guiCreateEdit(139, 132, 104, 27, rotY, false, editor.editGui.window)
	editor.editGui.posrz = guiCreateEdit(139, 169, 104, 27, rotZ, false, editor.editGui.window)
	
	editor.editGui.cancel = guiCreateButton(10, 259, 243, 31, "Anuluj", false, editor.editGui.window)
	editor.editGui.save = guiCreateButton(10, 216, 77, 33, "Zapisz obiekt", false, editor.editGui.window)
	editor.editGui.refresh = guiCreateButton(97, 216, 77, 33, "Odśwież zmiany", false, editor.editGui.window)
	editor.editGui.gate = guiCreateButton(186, 216, 67, 33, "Edytor bramy", false, editor.editGui.window)

	addEventHandler("onClientGUIClick", editor.editGui.cancel, editor.editGuiCancel, false)
	addEventHandler("onClientGUIClick", editor.editGui.refresh, editor.editGuiRefresh, false)
	addEventHandler("onClientGUIClick", editor.editGui.gate, gates.createGUI, false)
	addEventHandler("onClientGUIClick", editor.editGui.save, editor.editGuiSave, false)
	window = createElement("titan-gui")

	guiSetEnabled(editor.editGui.info, false)
end

function editor.destroyEditGUI()
	if isElement(editor.editGui.window) then destroyElement(editor.editGui.window) end
	if isElement(window) then destroyElement(window) end
end

function editor.editGuiCancel()
	if editor.state and isElement(editor.object) then
		removeEventHandler("onClientRender", root, editor.objectEdit)
		removeEventHandler("onClientClick", root, editor.mouseHandler)
		removeEventHandler("onClientKey", root, editor.changeKey)
		editor.destroyEditGUI()
		gates.closeGUI()
		gates.closePos = nil
		gates.openPos = nil
		setElementPosition(editor.object, editor.oldPos.X, editor.oldPos.Y, editor.oldPos.Z)
		setElementRotation(editor.object, editor.oldPos.RX, editor.oldPos.RY, editor.oldPos.RZ)
		editor.state = false
		triggerServerEvent("objectEngine.setObjectEditBy", localPlayer, editor.object, false)
		editor.object = nil
		exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
	end
end

function editor.isObjectInSphere()
	if isElement(editor.polygon) then
		if isElementWithinColShape(editor.object, editor.polygon) then
			return true
		end
	else
		return true
	end
	return false
end

function editor.editGuiSave()
	if(not editor.state) then
		exports.titan_noti:showBox("Nie edytujesz żadnego obiektu.")
		return
	end
	if not editor.isObjectInSphere() then
		exports.titan_noti:showBox("Obiekt musi znajdować się wewnatrz strefy.")
		return
	end
	local x, y, z = getElementPosition(editor.object)
	local rx, ry, rz = getElementRotation(editor.object)
	setElementPosition(editor.object, editor.oldPos.X, editor.oldPos.Y, editor.oldPos.Z)
	setElementRotation(editor.object, editor.oldPos.RX, editor.oldPos.RY, editor.oldPos.RZ)
	triggerServerEvent("saveObject", localPlayer, getElementData(editor.object, "objectID"), x, y, z, rx, ry, rz)
	-- JAK SIĘ WYŁĄCZY
	triggerServerEvent("objectEngine.setObjectEditBy", localPlayer, editor.object, false)
	removeEventHandler("onClientRender", root, editor.objectEdit)
	removeEventHandler("onClientClick", root, editor.mouseHandler)
	removeEventHandler("onClientKey", root, editor.changeKey)
	editor.destroyEditGUI()
	gates.closeGUI()
	gates.closePos = nil
	gates.openPos = nil
	editor.state = false
	editor.object = nil
	exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
end

function editor.editGuiRefresh()
	if editor.state and isElement(editor.object) then
		local x = tonumber(guiGetText(editor.editGui.posx))
		local y = tonumber(guiGetText(editor.editGui.posy))
		local z = tonumber(guiGetText(editor.editGui.posz))
		local rx = tonumber(guiGetText(editor.editGui.posrx))
		local ry = tonumber(guiGetText(editor.editGui.posry))
		local rz = tonumber(guiGetText(editor.editGui.posrz))
		setElementPosition(editor.object, x, y, z)
		setElementRotation(editor.object, rx, ry, rz)
	end
end

function editor.selectInfo()
	if getKeyState("space") then
		if isCursorShowing() then
			local curX, curY = getCursorPosition()
			editor.cursorOldPos = {curX, curY}
			exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
		end
	else
		exports.titan_cursor:showCustomCursor("objectsEditorClientMain")
	end
	if isCursorShowing() then
		local cX, cY = getCursorPosition()
		if cX then
			local absX = cX * sW
			local absY = cY * sH
			local camX, camY, camZ = getCameraMatrix()
			local wX, wY, wZ = getWorldFromScreenPosition(absX, absY, MAX_DISTANCE)
			local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(camX, camY, camZ, wX, wY, wZ, false, false, false, true, false)
			if hit and isElement(hitElement) and getElementType(hitElement) == "object" and getElementData(hitElement, "isObject") then
				dxDrawRectangle(sW / 2 - 150, sH - 100, 300, 50, tocolor(0, 0, 0, 180))
				local oX, oY, oZ = getElementPosition(hitElement)
				local rx, ry, rz = getElementRotation(hitElement)
				dxDrawText(string.format("Obiekt(%d): %d\nPozycja: %0.2f %0.2f %0.2f %0.2f, %0.2f, %0.2f", getElementData(hitElement, "objectID"), getElementModel(hitElement), oX, oY, oZ, rx, ry, rz), sW / 2 - 145, sH - 95, 0, 0, tocolor(130, 130, 130, 200), 1.0, "default-bold")
			end
		end
	end
end

function editor.objectEdit()
	if getKeyState("space") then
		exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
	else
		exports.titan_cursor:showCustomCursor("objectsEditorClientMain")
	end

	local objectID = getElementData(editor.object, "objectID")
	local posX, posY, posZ = getElementPosition(editor.object)
	local rotX, rotY, rotZ = getElementRotation(editor.object)

	local oldPos = {posX, posY, posZ}
	--rotZ = rotZ + 0.5
	--rotX = rotX + 0.5
	if rotZ > 360 then rotZ = 0 end
	if rotX > 360 then rotX = 0 end
	if rotY > 360 then rotY = 0 end

	local xxVel1, xyVel1 = editor.velocityAngleZtoX(rotZ)
	local yxVel1, yyVel1 = editor.velocityAngleZtoY(-rotZ)

	local cX = tocolor(255, 0, 0, 255)
	local cY = tocolor(0, 255, 0, 255)
	local cZ = tocolor(0, 0, 255, 255)
	local alpha = {0.5, 0.5, 0.5, 0.5, 0.5, 0.5}

	if buttons.chosen == 1 then
		cY = tocolor(0, 255, 0, 20)
		cZ = tocolor(0, 0, 255, 20)
		alpha[1] = 1.0
	elseif buttons.chosen == 2 then
		cX = tocolor(255, 0, 0, 20)
		cZ = tocolor(0, 0, 255, 20)
		alpha[2] = 1.0
	elseif buttons.chosen == 3 then
		cX = tocolor(255, 0, 0, 20)
		cY = tocolor(0, 255, 0, 20)
		alpha[3] = 1.0
	elseif buttons.chosen == 4 then
		cY = tocolor(0, 255, 0, 20)
		cZ = tocolor(0, 0, 255, 20)
		alpha[4] = 1.0
	elseif buttons.chosen == 5 then
		cX = tocolor(255, 0, 0, 20)
		cZ = tocolor(0, 0, 255, 20)
		alpha[5] = 1.0
	elseif buttons.chosen == 6 then
		cX = tocolor(255, 0, 0, 20)
		cY = tocolor(0, 255, 0, 20)
		alpha[6] = 1.0
	end

	-- BUTTONY --
	-- X
	dxDrawRectangle(buttons.X.posX, buttons.X.posY, buttons.W, buttons.H, tocolor(60, 60, 60, 200 * alpha[1]))
	dxDrawText("X", buttons.X.posX, buttons.X.posY, buttons.X.posX + 20, buttons.X.posY + 20, tocolor(255, 255, 255, 255 * alpha[1]), 1.0, "default-bold", "center", "center")
	-- Y
	dxDrawRectangle(buttons.Y.posX, buttons.Y.posY, buttons.W, buttons.H, tocolor(60, 60, 60, 200 * alpha[2]))
	dxDrawText("Y", buttons.Y.posX, buttons.Y.posY, buttons.Y.posX + 20, buttons.Y.posY + 20, tocolor(255, 255, 255, 255 * alpha[2]), 1.0, "default-bold", "center", "center")
	-- Z
	dxDrawRectangle(buttons.Z.posX, buttons.Z.posY, buttons.W, buttons.H, tocolor(60, 60, 60, 200 * alpha[3]))
	dxDrawText("Z", buttons.Z.posX, buttons.Z.posY, buttons.Z.posX + 20, buttons.Z.posY + 20, tocolor(255, 255, 255, 255 * alpha[3]), 1.0, "default-bold", "center", "center")
	
	-- rX
	dxDrawRectangle(buttons.RX.posX, buttons.RX.posY, buttons.W, buttons.H, tocolor(60, 60, 60, 200 * alpha[4]))
	dxDrawText("rX", buttons.RX.posX, buttons.RX.posY, buttons.RX.posX + 20, buttons.RZ.posY + 20, tocolor(255, 255, 255, 255 * alpha[4]), 1.0, "default-bold", "center", "center")

	-- rY
	dxDrawRectangle(buttons.RY.posX, buttons.RY.posY, buttons.W, buttons.H, tocolor(60, 60, 60, 200 * alpha[5]))
	dxDrawText("rY", buttons.RY.posX, buttons.RY.posY, buttons.RY.posX + 20, buttons.RY.posY + 20, tocolor(255, 255, 255, 255 * alpha[5]), 1.0, "default-bold", "center", "center")

	-- rZ
	dxDrawRectangle(buttons.RZ.posX, buttons.RZ.posY, buttons.W, buttons.H, tocolor(60, 60, 60, 200 * alpha[6]))
	dxDrawText("rZ", buttons.RZ.posX, buttons.RZ.posY, buttons.RZ.posX + 20, buttons.RZ.posY + 20, tocolor(255, 255, 255, 255 * alpha[6]), 1.0, "default-bold", "center", "center")

	dxDrawLine3D(posX - xxVel1, posY - xyVel1, posZ, posX + xxVel1, posY + xyVel1, posZ, cX, 2, true)
	dxDrawLine3D(posX - yxVel1, posY - yyVel1, posZ, posX + yxVel1, posY + yyVel1, posZ, cY, 2, true)
	dxDrawLine3D(posX, posY, posZ - 1, posX, posY, posZ + 1, cZ, 2, true)

	-- START
	local gx, gy = guiGetPosition(editor.editGui.window, false)
	if editor.mode == "start" and not gates.state and not editor.isCursorGet(gx, gy, gx + 263, gy + 300) then
		local startPos = editor.startPos
		local curX, curY = getCursorPosition()
		if curX or curY then

			if buttons.chosen == 1 then
				dxDrawLine(startPos[1] * sW, startPos[2] * sH, curX * sW, startPos[2] * sH, tocolor(255,0,0,255))
				vector = curX - startPos[1]
			elseif buttons.chosen == 2 then
				dxDrawLine(startPos[1] * sW, startPos[2] * sH, curX * sW, startPos[2] * sH, tocolor(0,255,0,255))
				vector = curX - startPos[1]
			elseif buttons.chosen == 3 then
				dxDrawLine(startPos[1] * sW, startPos[2] * sH, curX * sW, startPos[2] * sH, tocolor(0,0,255,255))
				vector = curX - startPos[1]	
				vector = -vector
			elseif buttons.chosen == 4 then
				dxDrawLine(startPos[1] * sW, startPos[2] * sH, curX * sW, startPos[2] * sH, tocolor(255,0,0,255))
				vector = curX - startPos[1]
			elseif buttons.chosen == 5 then
				dxDrawLine(startPos[1] * sW, startPos[2] * sH, curX * sW, startPos[2] * sH, tocolor(0,255,0,255))
				vector = curX - startPos[1]
			elseif buttons.chosen == 6 then
				dxDrawLine(startPos[1] * sW, startPos[2] * sH, curX * sW, startPos[2] * sH, tocolor(0,0,255,255))
				vector = curX - startPos[1]	
			end

			if buttons.chosen == 1 then
				xxVel1, xyVel1 = editor.velocityAngleZtoX(rotZ, vector * 10)
				posX = editor.tmpPos.X + xxVel1
				posY = editor.tmpPos.Y + xyVel1
			elseif buttons.chosen == 2 then
				yxVel1, yyVel1 = editor.velocityAngleZtoY(-rotZ, vector * 10)
				posX = editor.tmpPos.X + yxVel1
				posY = editor.tmpPos.Y + yyVel1
			elseif buttons.chosen == 3 then
				posZ = editor.tmpPos.Z + vector * 10
			elseif buttons.chosen == 4 then
				rotX = editor.tmpPos.RX + vector * 100	
			elseif buttons.chosen == 5 then
				rotY = editor.tmpPos.RY + vector * 100
			elseif buttons.chosen == 6 then
				rotZ = editor.tmpPos.RZ + vector * 100
			end
		end
	end


	--[[dxDrawRectangle(infoRender.rectangle.X, infoRender.rectangle.Y, infoRender.rectangle.W, infoRender.rectangle.H, tocolor(0, 0, 0, 150), false)
	dxDrawText(string.format("Informacje o obiekcie (ID: %d)", objectID), infoRender.rectangle.X, infoRender.rectangle.Y + 2, infoRender.rectangle.X + infoRender.rectangle.W, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold", "center", "top")
	dxDrawText("Pozycja", infoRender.rectangle.X + 5, infoRender.rectangle.Y + 15, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("X: %0.2f", posX), infoRender.rectangle.X + 15, infoRender.rectangle.Y + 30, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("Y: %0.2f", posY), infoRender.rectangle.X + 15, infoRender.rectangle.Y + 45, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("Z: %0.2f", posZ), infoRender.rectangle.X + 15, infoRender.rectangle.Y + 60, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("rX: %0.2f", rotX), infoRender.rectangle.X + 110, infoRender.rectangle.Y + 30, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("rY: %0.2f", rotY), infoRender.rectangle.X + 110, infoRender.rectangle.Y + 45, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("rZ: %0.2f", rotZ), infoRender.rectangle.X + 110, infoRender.rectangle.Y + 60, 0, 0, tocolor(255, 255, 255, 200), 1.0, "default-bold")
	dxDrawText(string.format("/ea aby wyjść"), infoRender.rectangle.X, infoRender.rectangle.Y + 80, infoRender.rectangle.X + infoRender.rectangle.W, 0, tocolor(255, 14, 14, 200), 1.0, "default-bold", "center", "top")
	]]

	setElementPosition(editor.object, posX, posY, posZ)
	setElementRotation(editor.object, rotX, rotY, rotZ)

	if isElement(editor.polygon) and not isElementWithinColShape(editor.object, editor.polygon) then
		setElementPosition(editor.object, unpack(oldPos))
	end
	local posX, posY, posZ = getElementPosition(editor.object)
	local rotX, rotY, rotZ = getElementRotation(editor.object)
	if editor.mode == "start" and not gates.state and not editor.isCursorGet(gx, gy, gx + 263, gy + 300) then
		guiSetText(editor.editGui.posx, posX)
		guiSetText(editor.editGui.posy, posY)
		guiSetText(editor.editGui.posz, posZ)
		guiSetText(editor.editGui.posrx, rotX)	
		guiSetText(editor.editGui.posry, rotY)
		guiSetText(editor.editGui.posrz, rotZ)
	end

end

function editor.mouseHandler(button, state)
	if button == "left" then
		if state == "down" and editor.isCursorGet(buttons.X.posX, buttons.X.posY, buttons.X.posX + 20, buttons.X.posY + 20) then
			buttons.chosen = 1
		elseif state == "down" and editor.isCursorGet(buttons.Y.posX, buttons.Y.posY, buttons.Y.posX + 20, buttons.Y.posY + 20) then
			buttons.chosen = 2
		elseif state == "down" and editor.isCursorGet(buttons.Z.posX, buttons.Z.posY, buttons.Z.posX + 20, buttons.Z.posY + 20) then
			buttons.chosen = 3
		elseif state == "down" and editor.isCursorGet(buttons.RX.posX, buttons.RX.posY, buttons.RX.posX + 20, buttons.RX.posY + 40) then
			buttons.chosen = 4
		elseif state == "down" and editor.isCursorGet(buttons.RY.posX, buttons.RX.posY, buttons.RY.posX + 20, buttons.RY.posY + 40) then
			buttons.chosen = 5
		elseif state == "down" and editor.isCursorGet(buttons.RZ.posX, buttons.RZ.posY, buttons.RZ.posX + 20, buttons.RZ.posY + 40) then
			buttons.chosen = 6
		else
			if state == "down" then
				local posX, posY = getCursorPosition()
				editor.startPos = {posX, posY}
				local x, y, z = getElementPosition(editor.object)
				local rx, ry, rz = getElementRotation(editor.object)
				editor.tmpPos = {X = x, Y = y, Z = z, RX = rx, RY = ry, RZ = rz}
				editor.mode = "start"
			else
				editor.startPos = {}
				editor.mode = nil
			end
		end
	end
end

function editor.changeKey(button, press)
	if press then
		if tonumber(button) then
			button = tonumber(button)
			if button > 0 and button < 7 then
				buttons.chosen = button
			end
		end
	end
end

function editor.clickButtonSelect(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
	if button == "left" and state == "up" then
		if editor.state then
			if isCursorShowing() then
				local cX, cY = getCursorPosition()
				if cX then
					local absX = cX * sW
					local absY = cY * sH
					local camX, camY, camZ = getCameraMatrix()
					local wX, wY, wZ = getWorldFromScreenPosition(absX, absY, MAX_DISTANCE)
					local hit, hitX, hitY, hitZ, hitElement = processLineOfSight(camX, camY, camZ, wX, wY, wZ, false, false, false, true, false)
					if hit and isElement(hitElement) and getElementType(hitElement) == "object" and getElementData(hitElement, "isObject") then
						local editBy = getElementData(hitElement, "object:editBy")
						if isElement(editBy) and getElementType(editBy) == "player" and editBy ~= localPlayer then
							return exports.titan_noti:showBox("Inny gracz edytuje już ten obiekt.")
						end
						--[[triggerServerEvent("objectEngine.setObjectEditBy", localPlayer, hitElement, true)
						editor.object = hitElement
						local oX, oY, oZ = getElementPosition(hitElement)
						local rX, rY, rZ = getElementRotation(hitElement)
						editor.oldPos = {X = oX, Y = oY, Z = oZ, RX = rX, RY = rY, RZ = rZ}
						editor.tmpPos = {X = oX, Y = oY, Z = oZ, RX = rX, RY = rY, RZ = rZ}
						removeEventHandler("onClientRender", root, editor.selectInfo)
						removeEventHandler("onClientClick", root, editor.clickButtonSelect)
						addEventHandler("onClientRender", root, editor.objectEdit)
						addEventHandler("onClientClick", root, editor.mouseHandler)
						addEventHandler("onClientKey", root, editor.changeKey)
						buttons.chosen = 1
						editor.mode = ""
						local gateData = hitElement:getData("gatePos")
						if type(gateData) == "table" then
							gates.openPos = {X = gateData[1], Y = gateData[2], Z = gateData[3], rX = gateData[4], rY = gateData[5], rZ = gateData[6]}
						else
							gates.openPos = {X = 0, Y = 0, Z = 0, rX = 0, rY = 0, rZ = 0}
						end
						gates.closePos = {X = oX, Y = oY, Z = oZ, rX = rX, rY = rY, rZ = rZ}
						gates.animTimeSaved = hitElement:getData("gateTime")
						gates.rangeSaved = hitElement:getData("gateRange")
						editor.createEditGUI()]]
						editor.oSelect(false)
						triggerServerEvent("objectEngine.objectEdit", localPlayer, localPlayer, hitElement:getData("objectID"))
					end
				end
			end
		end
	end
end

function editor.serverObjectEdit(element, polygon)
	if not editor.state then
		editor.mode = ""
		editor.object = element
		editor.polygon = polygon
		local oX, oY, oZ = getElementPosition(element)
		local rX, rY, rZ = getElementRotation(element)
		editor.oldPos = {X = oX, Y = oY, Z = oZ, RX = rX, RY = rY, RZ = rZ}
		editor.tmpPos = {X = oX, Y = oY, Z = oZ, RX = rX, RY = rY, RZ = rZ}

		addEventHandler("onClientRender", root, editor.objectEdit)
		addEventHandler("onClientClick", root, editor.mouseHandler)
		addEventHandler("onClientKey", root, editor.changeKey)
		editor.createEditGUI()
		buttons.chosen = 1
		exports.titan_cursor:showCustomCursor("objectsEditorClientMain")
		editor.state = true

		local gateData = element:getData("gatePos")
		if type(gateData) == "table" then
			gates.openPos = {X = gateData[1], Y = gateData[2], Z = gateData[3], rX = gateData[4], rY = gateData[5], rZ = gateData[6]}
		else
			gates.openPos = {X = 0, Y = 0, Z = 0, rX = 0, rY = 0, rZ = 0}
		end
		gates.closePos = {X = oX, Y = oY, Z = oZ, rX = rX, rY = rY, rZ = rZ}
	end
end
addEvent("editor.serverObjectEdit", true)
addEventHandler("editor.serverObjectEdit", root, editor.serverObjectEdit)

function editor.oSelect(state)
	if editor.state and isElement(editor.object) then return end
	if state then
		--showCursor(true)
		exports.titan_cursor:showCustomCursor("objectsEditorClientMain")
		editor.state = true
		addEventHandler("onClientRender", root, editor.selectInfo)
		addEventHandler("onClientClick", root, editor.clickButtonSelect)
	else
		--showCursor(false)
		exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
		editor.state = false
		removeEventHandler("onClientRender", root, editor.selectInfo)
		removeEventHandler("onClientClick", root, editor.clickButtonSelect)
	end

end

function editor.velocityAngleZtoX(angle, distance)
	if not distance then distance = 1 end
	local xVel = math.cos(math.rad(angle)) * distance
	local yVel = math.sin(math.rad(angle)) * distance
	return xVel, yVel
end

function editor.velocityAngleZtoY(angle, distance)
	if not distance then distance = 1 end
	local xVel = math.sin(math.rad(angle)) * distance
	local yVel = math.cos(math.rad(angle)) * distance
	return xVel, yVel
end

function editor.zVector(rX, rY, rZ)
	local xVec = (math.cos(math.rad(rY)) * 1) * math.cos(math.rad(rX))
	local yVec = (math.cos(math.rad(rX)) * 1) * math.cos(math.rad(rY))
end

function editor.isCursorGet(minX, minY, maxX, maxY)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * sW, cY * sH
	if(cX > minX and cX < maxX and cY > minY and cY < maxY) then return true end
	return false
end

function cmdOsel()
	if editor.state then
		editor.oSelect(false)
	else
		editor.oSelect(true)
	end
end
addCommandHandler("osel", cmdOsel, false, false)

-- function cmdEa()
-- 	if editor.state and isElement(editor.object) then
-- 		removeEventHandler("onClientRender", root, editor.objectEdit)
-- 		removeEventHandler("onClientClick", root, editor.mouseHandler)
-- 		removeEventHandler("onClientKey", root, editor.changeKey)
-- 		editor.destroyEditGUI()
-- 		gates.closeGUI()
-- 		gates.closePos = nil
-- 		gates.openPos = nil
-- 		setElementPosition(editor.object, editor.oldPos.X, editor.oldPos.Y, editor.oldPos.Z)
-- 		setElementRotation(editor.object, editor.oldPos.RX, editor.oldPos.RY, editor.oldPos.RZ)
-- 		editor.state = false
-- 		editor.object = nil
-- 		exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
-- 	end
-- end
-- addCommandHandler("ea", cmdEa, false, false)

-- function cmdESave()
-- 	if(not editor.state) then
-- 		exports.titan_noti:showBox("Nie edytujesz żadnego obiektu.")
-- 		return
-- 	end
-- 	local x, y, z = getElementPosition(editor.object)
-- 	local rx, ry, rz = getElementRotation(editor.object)
-- 	setElementPosition(editor.object, editor.oldPos.X, editor.oldPos.Y, editor.oldPos.Z)
-- 	setElementRotation(editor.object, editor.oldPos.RX, editor.oldPos.RY, editor.oldPos.RZ)
-- 	triggerServerEvent("saveObject", localPlayer, getElementData(editor.object, "objectID"), x, y, z, rx, ry, rz)
-- 	-- JAK SIĘ WYŁĄCZY
-- 	removeEventHandler("onClientRender", root, editor.objectEdit)
-- 	removeEventHandler("onClientClick", root, editor.mouseHandler)
-- 	removeEventHandler("onClientKey", root, editor.changeKey)
-- 	editor.destroyEditGUI()
-- 	gates.closeGUI()
-- 	gates.closePos = nil
-- 	gates.openPos = nil
-- 	editor.state = false
-- 	editor.object = nil
-- 	exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
-- end
-- addCommandHandler("es", cmdESave, false, false)

function cmdOt(command, arg1, arg2)
	if not editor.state then
		exports.titan_noti:showBox("Nie edytujesz żadnego obiektu.")
		return
	end
	if not arg1 or not tonumber(arg2) then
		return exports.titan_noti:showBox("TIP: /ot [texName] [texID]")
	end
	if isElement(editor.object) and (getElementModel(editor.object) == 8981 or getElementModel(editor.object) == 9352 or getElementModel(editor.object) == 9558 or getElementModel(editor.object) == 9567 or getElementModel(editor.object) == 9568 or getElementModel(editor.object) == 9589) then
		triggerServerEvent("objectEngine.setObjectTexture", localPlayer, getElementData(editor.object, "objectID"), string.lower(tostring(arg1)), tonumber(arg2))
		
		--setObjectTexture(editor.object, arg1, tonumber(arg2))
	end
end
addCommandHandler("ot", cmdOt, false, false)

function cmdEDel()
	if not editor.state then
		exports.titan_noti:showBox("Nie edytujesz żadnego obiektu.")
		return
	end
	triggerServerEvent("delObject", localPlayer, getElementData(editor.object, "objectID"))
	removeEventHandler("onClientRender", root, editor.objectEdit)
	removeEventHandler("onClientClick", root, editor.mouseHandler)
	removeEventHandler("onClientKey", root, editor.changeKey)
	editor.destroyEditGUI()
	gates.closeGUI()
	gates.closePos = nil
	gates.openPos = nil
	editor.state = false
	editor.object = nil
	exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
	exports.titan_noti:showBox("Obiekt został usunięty.")
end
addCommandHandler("ed", cmdEDel, false, false)

-- function cmdRx(command, rx)
-- 	if editor.state and isElement(editor.object) then
-- 		local x, y, z = getElementRotation(editor.object)
-- 		setElementRotation(editor.object, rx, y, z)
-- 	end
-- end
-- addCommandHandler("rx", cmdRx, false, false)

-- function cmdRy(command, rx)
-- 	if editor.state and isElement(editor.object) then
-- 		local x, y, z = getElementRotation(editor.object)
-- 		setElementRotation(editor.object, x, rx, z)
-- 	end
-- end
-- addCommandHandler("ry", cmdRy, false, false)

-- function cmdRz(command, rx)
-- 	if editor.state and isElement(editor.object) then
-- 		local x, y, z = getElementRotation(editor.object)
-- 		setElementRotation(editor.object, x, y, rx)
-- 	end
-- end
-- addCommandHandler("rz", cmdRz, false, false)

-- function cmdEg()
-- 	if editor.state and isElement(editor.object) then
-- 		gates.createGUI()
-- 	end
-- end
-- addCommandHandler("eg", cmdEg, false, false)



---------- BRAMY
---------
--------
-------
------
-----
----
---
--

function gates.createGUI()
	gates.state = true
	gates.okno = guiCreateWindow(sW / 2 - 386 / 2, sH / 2 - 423 / 2, 386, 423, "Tworzenie bramy", false)

	gates.label0 = guiCreateLabel(10, 24, 366, 36, "Wypełnij wszystkie potrzebne pola", false, gates.okno)

	gates.scrollpanel = guiCreateScrollPane(10, 70, 366, 297, false, gates.okno)

	gates.label1 = guiCreateLabel(10, 10, 154, 22, "Pozycja bramy zamkniętej", false, gates.scrollpanel)
	window = createElement("titan-gui")
	gates.eCX = guiCreateEdit(29, 41, 96, 31, "", false, gates.scrollpanel)
	gates.eCY = guiCreateEdit(135, 41, 96, 31, "", false, gates.scrollpanel)
	gates.eCZ = guiCreateEdit(241, 41, 96, 31, "", false, gates.scrollpanel)
	gates.eCRX = guiCreateEdit(29, 82, 96, 31, "", false, gates.scrollpanel)
	gates.eCRY = guiCreateEdit(135, 82, 96, 31, "", false, gates.scrollpanel)
	gates.eCRZ = guiCreateEdit(241, 82, 96, 31, "", false, gates.scrollpanel)

	gates.bCRX = guiCreateButton(29, 123, 96, 27, "Odwróć rX", false, gates.scrollpanel)
	gates.bCRY = guiCreateButton(135, 123, 96, 27, "Odwróć rY", false, gates.scrollpanel)
	gates.bCRZ = guiCreateButton(241, 123, 96, 27, "Odwróć rZ", false, gates.scrollpanel)

	gates.bCD = guiCreateButton(29, 160, 308, 27, "Pobierz koordynaty obiektu", false, gates.scrollpanel)

	gates.label2 = guiCreateLabel(10, 197, 154, 22, "Pozycja bramy otwartej", false, gates.scrollpanel)

	gates.eOX = guiCreateEdit(29, 229, 96, 31, "", false, gates.scrollpanel)
	gates.eOY = guiCreateEdit(135, 229, 96, 31, "", false, gates.scrollpanel)
	gates.eOZ = guiCreateEdit(241, 229, 96, 31, "", false, gates.scrollpanel)
	gates.eORX = guiCreateEdit(29, 270, 96, 31, "", false, gates.scrollpanel)
	gates.eORY = guiCreateEdit(135, 270, 96, 31, "", false, gates.scrollpanel)
	gates.eORZ = guiCreateEdit(241, 270, 96, 31, "", false, gates.scrollpanel)

	gates.bORX = guiCreateButton(29, 311, 96, 27, "Odwróć rX", false, gates.scrollpanel)
	gates.bORY = guiCreateButton(135, 311, 96, 27, "Odwróć rY", false, gates.scrollpanel)
	gates.bORZ = guiCreateButton(241, 311, 96, 27, "Odwróć rZ", false, gates.scrollpanel)

	gates.bOD = guiCreateButton(29, 348, 308, 27, "Pobierz koordynaty obiektu", false, gates.scrollpanel)

	gates.label3 = guiCreateLabel(10, 390, 300, 22, "Czas animacji (w milisekundach, 1sek = 1000ms)", false, gates.scrollpanel)
	gates.animTime = guiCreateEdit(29, 420, 96, 31, "1000", false, gates.scrollpanel)

	gates.label4 = guiCreateLabel(10, 461, 154, 22, "Zasięg działania bramy", false, gates.scrollpanel)
	gates.range = guiCreateEdit(29, 493, 96, 31, "10.0", false, gates.scrollpanel)

	--[[gates.label5 = guiCreateLabel(10, 543, 154, 22, "Komenda:", false, gates.scrollpanel)
	gates.Command = guiCreateComboBox (29, 575, 308, 80,"Wybierz komende",false, gates.scrollpanel)
	guiComboBoxAddItem ( gates.Command, "brama/gate")
	guiComboBoxAddItem ( gates.Command, "drzwi/door")
	guiComboBoxSetSelected(gates.Command, 0)


	gates.label6 = guiCreateLabel(10, 607, 154, 22, "Typ ruchu:", false, gates.scrollpanel)
	gates.Animation = guiCreateComboBox (29, 639, 308, 80,"Wybierz ruch",false, gates.scrollpanel)
	for i,v in ipairs(EasingType) do
		guiComboBoxAddItem ( gates.Animation, v[1] )
	end
	guiComboBoxSetSelected(gates.Animation, 0)]]


	gates.globalSave = guiCreateButton(10, 385, 96, 28, "Zapisz", false, gates.okno)
	gates.globalHide  = guiCreateButton(116, 385, 96, 28, "Ukryj", false, gates.okno)

	--guiSetFont(gates.label6, "default-bold-small")
	guiSetFont(gates.label5, "default-bold-small")
	guiSetFont(gates.label4, "default-bold-small")
	guiSetFont(gates.label3, "default-bold-small")
	guiSetFont(gates.label2, "default-bold-small")
	guiSetFont(gates.label1, "default-bold-small")
	guiWindowSetSizable(gates.okno, false)
	guiSetFont(gates.label0, "default-small")
	guiLabelSetHorizontalAlign(gates.label0, "center", false)
	guiLabelSetVerticalAlign(gates.label0, "center")

	addEventHandler("onClientGUIClick", gates.bCRX, gates.closeReverseX, false)
	addEventHandler("onClientGUIClick", gates.bCRY, gates.closeReverseY, false)
	addEventHandler("onClientGUIClick", gates.bCRZ, gates.closeReverseZ, false)
	addEventHandler("onClientGUIClick", gates.bCD, gates.getCloseCoords, false)

	addEventHandler("onClientGUIClick", gates.bORX, gates.openReverseX, false)
	addEventHandler("onClientGUIClick", gates.bORY, gates.openReverseY, false)
	addEventHandler("onClientGUIClick", gates.bORZ, gates.openReverseZ, false)
	addEventHandler("onClientGUIClick", gates.bOD, gates.getOpenCoords, false)

	addEventHandler("onClientGUIClick", gates.globalHide, gates.closeGUI, false)
	addEventHandler("onClientGUIClick", gates.globalSave, gates.save, false)

	guiSetEnabled(gates.eCX, false)
	guiSetEnabled(gates.eCY, false)
	guiSetEnabled(gates.eCZ, false)
	guiSetEnabled(gates.eCRX, false)
	guiSetEnabled(gates.eCRY, false)
	guiSetEnabled(gates.eCRZ, false)

	guiSetEnabled(gates.eOX, false)
	guiSetEnabled(gates.eOY, false)
	guiSetEnabled(gates.eOZ, false)
	guiSetEnabled(gates.eORX, false)
	guiSetEnabled(gates.eORY, false)
	guiSetEnabled(gates.eORZ, false)

	if type(gates.closePos) == "table" then
		guiSetText(gates.eCX, string.format("%0.2f", gates.closePos.X))
		guiSetText(gates.eCY, string.format("%0.2f", gates.closePos.Y))
		guiSetText(gates.eCZ, string.format("%0.2f", gates.closePos.Z))
		guiSetText(gates.eCRX, string.format("%0.2f", gates.closePos.rX))
		guiSetText(gates.eCRY, string.format("%0.2f", gates.closePos.rY))
		guiSetText(gates.eCRZ, string.format("%0.2f", gates.closePos.rZ))
	end

	if type(gates.openPos) == "table" then
		guiSetText(gates.eOX, string.format("%0.2f", gates.openPos.X))
		guiSetText(gates.eOY, string.format("%0.2f", gates.openPos.Y))
		guiSetText(gates.eOZ, string.format("%0.2f", gates.openPos.Z))
		guiSetText(gates.eORX, string.format("%0.2f", gates.openPos.rX))
		guiSetText(gates.eORY, string.format("%0.2f", gates.openPos.rY))
		guiSetText(gates.eORZ, string.format("%0.2f", gates.openPos.rZ))
	end

	if tonumber(gates.animTimeSaved) then
		guiSetText(gates.animTime, tonumber(gates.animTimeSaved))
	end
	if tonumber(gates.rangeSaved) then
		guiSetText(gates.range, tonumber(gates.rangeSaved))
	end
end

function gates.save()
	if type(gates.closePos) ~= "table" or type(gates.openPos) ~= "table" then return end
	if not tonumber(gates.closePos.X) or tonumber(gates.closePos.X) == 0 then return end
	if not tonumber(gates.closePos.Y) or tonumber(gates.closePos.Y) == 0 then return end
	if not tonumber(gates.closePos.Z) or tonumber(gates.closePos.Z) == 0 then return end

	if not tonumber(gates.openPos.X) or tonumber(gates.openPos.X) == 0 then return end
	if not tonumber(gates.openPos.Y) or tonumber(gates.openPos.Y) == 0 then return end
	if not tonumber(gates.openPos.Z) or tonumber(gates.openPos.Z) == 0 then return end

	gates.animTimeSaved = guiGetText(gates.animTime)
	gates.rangeSaved = guiGetText(gates.range)
	if not tonumber(gates.animTimeSaved) then gates.animTimeSaved = 2000 end
	if not tonumber(gates.rangeSaved) then gates.rangeSaved = 10 end

	triggerServerEvent("objectEngine.setObjectEditBy", localPlayer, editor.object, false)
	triggerServerEvent("objectEngine.createGate", localPlayer, editor.object:getData("objectID"), gates.closePos, gates.openPos, tonumber(gates.animTimeSaved), tonumber(gates.rangeSaved))
	gates.closeGUI()
	removeEventHandler("onClientRender", root, editor.objectEdit)
	removeEventHandler("onClientClick", root, editor.mouseHandler)
	removeEventHandler("onClientKey", root, editor.changeKey)
	editor.destroyEditGUI()
	gates.closePos = nil
	gates.openPos = nil
	editor.state = false
	editor.object = nil
	exports.titan_cursor:hideCustomCursor("objectsEditorClientMain")
end

function gates.closeGUI()
	if isElement(gates.okno) then
		gates.animTimeSaved = guiGetText(gates.animTime)
		gates.rangeSaved = guiGetText(gates.range)
		destroyElement(gates.okno)
	end
	gates.state = false
end

function gates.getCloseCoords()
	if isElement(editor.object) then
		local x, y, z = getElementPosition(editor.object)
		local rx, ry, rz = getElementRotation(editor.object)
		guiSetText(gates.eCX, string.format("%0.2f", x))
		guiSetText(gates.eCY, string.format("%0.2f", y))
		guiSetText(gates.eCZ, string.format("%0.2f", z))
		guiSetText(gates.eCRX, string.format("%0.2f", rx))
		guiSetText(gates.eCRY, string.format("%0.2f", ry))
		guiSetText(gates.eCRZ, string.format("%0.2f", rz))
		gates.closePos = {X = x, Y = y, Z = z, rX = rx, rY = ry, rZ = rz}
	end
end

function gates.getOpenCoords()
	if isElement(editor.object) then
		local x, y, z = getElementPosition(editor.object)
		local rx, ry, rz = getElementRotation(editor.object)
		guiSetText(gates.eOX, string.format("%0.2f", x))
		guiSetText(gates.eOY, string.format("%0.2f", y))
		guiSetText(gates.eOZ, string.format("%0.2f", z))
		guiSetText(gates.eORX, string.format("%0.2f", rx))
		guiSetText(gates.eORY, string.format("%0.2f", ry))
		guiSetText(gates.eORZ, string.format("%0.2f", rz))
		gates.openPos = {X = x, Y = y, Z = z, rX = rx, rY = ry, rZ = rz}
	end
end

function gates.closeReverseX()
	local data = guiGetText(gates.eCRX)
	if tonumber(data) then
		data = tonumber(data)
		if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0
		end
		guiSetText(gates.eCRX, string.format("%0.2f", data))
		gates.closePos.rX = data
	end
end

function gates.closeReverseY()
	local data = guiGetText(gates.eCRY)
	if tonumber(data) then
		data = tonumber(data)
		if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0
		end
		guiSetText(gates.eCRY, string.format("%0.2f", data))
		gates.closePos.rY = data
	end
end

function gates.closeReverseZ()
	local data = guiGetText(gates.eCRZ)
	if tonumber(data) then
		data = tonumber(data)
		if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0
		end
		guiSetText(gates.eCRZ, string.format("%0.2f", data))
		gates.closePos.rZ = data
	end
end

function gates.openReverseX()
	local data = guiGetText(gates.eORX)
	if tonumber(data) then
		data = tonumber(data)
		if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0
		end
		guiSetText(gates.eORX, string.format("%0.2f", data))
		gates.openPos.rX = data
	end
end

function gates.openReverseY()
	local data = guiGetText(gates.eORY)
	if tonumber(data) then
		data = tonumber(data)
		if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0
		end
		guiSetText(gates.eORY, string.format("%0.2f", data))
		gates.openPos.rY = data
	end
end

function gates.openReverseZ()
	local data = guiGetText(gates.eORZ)
	if tonumber(data) then
		data = tonumber(data)
		if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0	
		end
		guiSetText(gates.eORZ, string.format("%0.2f", data))
		gates.openPos.rZ = data
	end
end

function editor.selectObjectCategory(comboBox, textSearch)
	if ( comboBox == editor.editObjectGui.list ) then
       local text = tostring ( guiComboBoxGetItemText ( editor.editObjectGui.list ,  guiComboBoxGetSelected ( editor.editObjectGui.list ) ) )
       if ( text ~= "" ) then
            guiGridListClear(editor.editObjectGui.gridList)
            for i,v in ipairs(editor.editObjectGui.table.object[text]) do
            	if textSearch and string.len(textSearch) > 0 or tonumber(textSearch) then
             		if string.find(string.gsub(v.name:lower(),"#%x%x%x%x%x%x", ""), textSearch:lower(), 1, true) or string.find(string.gsub(v.model:lower(),"#%x%x%x%x%x%x", ""), textSearch:lower(), 1, true) then
             			local row = guiGridListAddRow ( editor.editObjectGui.gridList )
             			guiGridListSetItemText (editor.editObjectGui.gridList, row, editor.editObjectGui.Element, v.name, false, false)
             			guiGridListSetItemText (editor.editObjectGui.gridList, row, editor.editObjectGui.Element_ID, v.model, false, false)
             		end
             	else
             		local row = guiGridListAddRow ( editor.editObjectGui.gridList )
             		guiGridListSetItemText (editor.editObjectGui.gridList, row, editor.editObjectGui.Element, v.name, false, false)
             		guiGridListSetItemText (editor.editObjectGui.gridList, row, editor.editObjectGui.Element_ID, v.model, false, false)
            	end
            end
       end
    end
end

function editor.createObjectCategory()
local select = guiGridListGetSelectedItem ( editor.editObjectGui.gridList )
	if select ~= -1 then
	 	name = guiGridListGetItemText ( editor.editObjectGui.gridList, select, 1 )
	 	model = guiGridListGetItemText ( editor.editObjectGui.gridList, select, 2 )
	 	if isElement(editor.editObjectGui.object) then destroyElement( editor.editObjectGui.object ) end
	 	local x, y ,z = getElementPosition( getLocalPlayer(  ) )
	 	editor.editObjectGui.object = createObject(model, x, y , z)
	 	setElementCollisionsEnabled( editor.editObjectGui.object, false )
	end
end

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z
end

function editor.acceptObjectGUI()
local select = guiGridListGetSelectedItem ( editor.editObjectGui.gridList )
	if select ~= -1 then
	 	model = guiGridListGetItemText ( editor.editObjectGui.gridList, select, 2 )
	 	local x,y,z = getXYInFrontOfPlayer(getLocalPlayer(  ), 3+getElementRadius( editor.editObjectGui.object ) )
	 	triggerServerEvent( "createPanelObject", getLocalPlayer(  ), getLocalPlayer(  ), model, x, y, z )
		editor.destroyObjectGUI()
	end
end

function editor.objecEditShowSelect()
	if isElement(editor.editObjectGui.object) then
		local x,y,z = getXYInFrontOfPlayer(getLocalPlayer(  ), 3+getElementRadius( editor.editObjectGui.object ) )
		local rx,ry,rz = getElementRotation( editor.editObjectGui.object )
		setElementPosition( editor.editObjectGui.object, x, y, z )
		setElementRotation( editor.editObjectGui.object, rx, ry, rz+1 )
		setElementInterior(editor.editObjectGui.object, getElementInterior( getLocalPlayer(  ) ) )
		setElementInterior(editor.editObjectGui.object, getElementInterior( getLocalPlayer(  ) ) )
	end
end

function editor.destroyObjectGUI()
	if editor.editObjectGui then
		removeEventHandler ( "onClientGUIClick", editor.editObjectGui.create,  editor.acceptObjectGUI, false )
		removeEventHandler ( "onClientGUIClick", editor.editObjectGui.cancel,  editor.destroyObjectGUI, false )
		removeEventHandler ( "onClientGUIClick", editor.editObjectGui.gridList,  editor.createObjectCategory, false )
		removeEventHandler ( "onClientGUIComboBoxAccepted", editor.editObjectGui.list, editor.selectObjectCategory)	
		removeEventHandler("onClientRender", root, editor.objecEditShowSelect)
		removeEventHandler("onClientGUIChanged", editor.editObjectGui.search, editor.getTextSearch)
		destroyElement( editor.editObjectGui.window )
		if isElement(editor.editObjectGui.object) then
			destroyElement( editor.editObjectGui.object )
		end
		editor.editObjectGui = nil
		exports.titan_cursor:hideCustomCursor("objects/editor/client/main:editObjectGUI")
	end
end

function editor.getTextSearch(search)
	local text = guiGetText(search)
	if string.len(text) > 0 then
		editor.selectObjectCategory(editor.editObjectGui.list, text )
	else
		editor.selectObjectCategory(editor.editObjectGui.list, false )		
	end
end

function editor.createObjectGUI()
	if not(editor.editObjectGui) then editor.editObjectGui = {} end
	if isElement(editor.editObjectGui.window) then destroyElement(editor.editObjectGui.window) end
	editor.editObjectGui.window = guiCreateWindow(sW - 273, sH / 2 - 150, 263, 450, "Tworzenie obiektu", false)
	guiWindowSetSizable(editor.editObjectGui.window, false)
	editor.editObjectGui.list = guiCreateComboBox( 10, 28, 243, 250, "Kategoria", false,editor.editObjectGui.window)
	editor.editObjectGui.search = guiCreateEdit(10, 60, 243, 27,"", false, editor.editObjectGui.window)
	editor.editObjectGui.gridList = guiCreateGridList(10, 95, 243, 300, false, editor.editObjectGui.window)
	editor.editObjectGui.Element = guiGridListAddColumn( editor.editObjectGui.gridList, "Nazwa", 0.60 )
	editor.editObjectGui.Element_ID = guiGridListAddColumn( editor.editObjectGui.gridList, "[ID]", 0.20 )
	editor.editObjectGui.table = getObjectList()

	editor.editObjectGui.create = guiCreateButton(10, 405, 111, 27, "Stwórz", false, editor.editObjectGui.window)
	editor.editObjectGui.cancel = guiCreateButton(150, 405, 111, 27, "Anuluj", false, editor.editObjectGui.window)


	for i,v in pairs(editor.editObjectGui.table.category) do
		guiComboBoxAddItem( editor.editObjectGui.list, v )
	end	

	addEventHandler ( "onClientGUIClick", editor.editObjectGui.create,  editor.acceptObjectGUI, false )
	addEventHandler ( "onClientGUIClick", editor.editObjectGui.cancel,  editor.destroyObjectGUI, false )
	addEventHandler ( "onClientGUIClick", editor.editObjectGui.gridList,  editor.createObjectCategory, false )
	addEventHandler ( "onClientGUIComboBoxAccepted", editor.editObjectGui.list, editor.selectObjectCategory)
	addEventHandler("onClientGUIChanged", editor.editObjectGui.search, editor.getTextSearch)
	addEventHandler("onClientRender", root, editor.objecEditShowSelect)

	guiComboBoxSetSelected( editor.editObjectGui.list, 0 )
	editor.selectObjectCategory(editor.editObjectGui.list)

	exports.titan_cursor:showCustomCursor("objects/editor/client/main:editObjectGUI")

	-- editor.editGui.info = guiCreateEdit(10, 28, 243, 27, string.format("ID obiektu: %d", objectID), false, editor.editGui.window)
	
	-- editor.editGui.posx = guiCreateEdit(10, 95, 104, 27, posX, false, editor.editGui.window)
	-- editor.editGui.posy = guiCreateEdit(10, 132, 104, 27, posY, false, editor.editGui.window)
	-- editor.editGui.posz = guiCreateEdit(10, 169, 104, 27, posZ, false, editor.editGui.window)
	-- editor.editGui.posrx = guiCreateEdit(139, 95, 104, 27, rotX, false, editor.editGui.window)
	-- editor.editGui.posry = guiCreateEdit(139, 132, 104, 27, rotY, false, editor.editGui.window)
	-- editor.editGui.posrz = guiCreateEdit(139, 169, 104, 27, rotZ, false, editor.editGui.window)
	
	-- editor.editGui.cancel = guiCreateButton(10, 259, 243, 31, "Anuluj", false, editor.editGui.window)
	-- editor.editGui.save = guiCreateButton(10, 216, 77, 33, "Zapisz obiekt", false, editor.editGui.window)
	-- editor.editGui.refresh = guiCreateButton(97, 216, 77, 33, "Odśwież zmiany", false, editor.editGui.window)
	-- editor.editGui.gate = guiCreateButton(186, 216, 67, 33, "Edytor bramy", false, editor.editGui.window)

	-- addEventHandler("onClientGUIClick", editor.editGui.cancel, editor.editGuiCancel, false)
	-- addEventHandler("onClientGUIClick", editor.editGui.refresh, editor.editGuiRefresh, false)
	-- addEventHandler("onClientGUIClick", editor.editGui.gate, gates.createGUI, false)
	-- addEventHandler("onClientGUIClick", editor.editGui.save, editor.editGuiSave, false)
	-- window = createElement("titan-gui")

	-- guiSetEnabled(editor.editGui.info, false)
end
addEvent("editor.createObjectGUI", true)
addEventHandler("editor.createObjectGUI", root, editor.createObjectGUI)