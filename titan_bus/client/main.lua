----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:01
-- Ostatnio zmodyfikowano: 2016-01-09 15:44:05
----------------------------------------------------

local distPrice = 0.03
local distTime = 0.15
local busFunc = {}
local sW, sH = guiGetScreenSize()
function busFunc.create(data, object)
	if isElement(busFunc.okno) then destroyElement(busFunc.okno) end
	busFunc.okno = guiCreateWindow(sW / 2 - 313 / 2, sH / 2 - 334 / 2, 313, 334, "Wybór przystanku", false)
	guiWindowSetSizable(busFunc.okno, false)

	busFunc.lista = guiCreateGridList(10, 29, 293, 247, false, busFunc.okno)
	guiGridListAddColumn(busFunc.lista, "Nazwa przystanku", 0.6)
	guiGridListAddColumn(busFunc.lista, "Cena", 0.3)
	busFunc.close = guiCreateButton(10, 286, 293, 38, "Zamknij", false, busFunc.okno)
	exports.titan_cursor:showCustomCursor("busMain")
	addEventHandler("onClientGUIClick", busFunc.close, busFunc.delete, false)
	addEventHandler("onClientGUIDoubleClick", busFunc.lista, busFunc.choose, false)

	local pPos = Vector2(object:getPosition())
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(busFunc.lista)
		if isElement(v.object) then
			local oPos = Vector2(v.object:getPosition())
			local distance = getDistanceBetweenPoints2D(pPos, oPos)
			local price = math.floor(distance * distPrice)
			local time = math.floor(distance * distTime)
			guiGridListSetItemText(busFunc.lista, row, 1, v.name, false, false)
			guiGridListSetItemText(busFunc.lista, row, 2, "$"..price, false, false)
			guiGridListSetItemData(busFunc.lista, row, 1, {dist = distance, price = price, time = time, ID = v.ID})
		end
	end
end
addEvent("busFunc.create", true)
addEventHandler("busFunc.create", root, busFunc.create)

function busFunc.delete()
	if isElement(busFunc.okno) then destroyElement(busFunc.okno) end
	exports.titan_cursor:hideCustomCursor("busMain")
end

function busFunc.choose()
	local row = guiGridListGetSelectedItem(busFunc.lista)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(busFunc.lista, row, 1)
	if type(data) == "table" then
		busFunc.delete()
		triggerServerEvent("busFunc.startTravel", localPlayer, data.ID, data.price, data.time)
	end
end

function busFunc.startTravel(time, posX, posY, posZ)
	if busFunc.state then return exports.titan_noti:showBox("Jesteś już w podróży.") end
	busFunc.state = true
	fadeCamera(false)
	setTimer(
		function(time, posX, posY, posZ)
			busFunc.startTime = getTickCount()
			busFunc.travelTime = time * 1000
			busFunc.pos = Vector3(posX, posY, posZ)

			localPlayer:setPosition(posX, posY, posZ + 500)
			localPlayer:setFrozen(true)
			localPlayer:setDimension(math.random(11111, 99999))

			toggleAllControls(false, true, false)

			addEventHandler("onClientRender", root, busFunc.renderTravel)
		end, 1200, 1, time, posX, posY, posZ)
end
addEvent("busFunc.startTravel", true)
addEventHandler("busFunc.startTravel", root, busFunc.startTravel)

function busFunc.endTravel()
	busFunc.state = false
	fadeCamera(true)
	triggerServerEvent("busFunc.endTravel", localPlayer)
	localPlayer:setPosition(busFunc.pos)
	localPlayer:setFrozen(true)
	localPlayer:setDimension(0)
	toggleAllControls(true)
	setTimer(setElementFrozen, 2000, 1, localPlayer, false)
end

function busFunc.renderTravel()
	local progress = ((getTickCount() - busFunc.startTime) / busFunc.travelTime)
	local percent = interpolateBetween(0, 0, 0, 100, 0, 0, progress, "Linear")
		dxDrawText(string.format("Przebyta trasa: %0.1f%%", percent), 0, sH / 2 - 10, sW, sH / 2 + 10, tocolor(255, 255, 255, 200), 2.0, "default-bold", "center", "center")
	if progress > 1 then
		busFunc.endTravel()
		removeEventHandler("onClientRender", root, busFunc.renderTravel)
		return
	end
end