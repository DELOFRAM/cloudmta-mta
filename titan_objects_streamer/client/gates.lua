----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local movingGates = {}
gFunc = {}

function gFunc.new(elem, stopPos, time)
	if not time then time = 2000 end
	if not isElement(elem) then return end
	local startPos

	local isMoving = false
	for k, v in ipairs(movingGates) do
		if isElement(v.oElement) then
			if v.oElement == elem then
				local progress = (getTickCount() - v.started) / v.time
				local x, y, z = interpolateBetween(v.startingPos[1], v.startingPos[2], v.startingPos[3], v.stoppingPos[1], v.stoppingPos[2], v.stoppingPos[3], progress, "InOutQuad")
				local rx, ry, rz = interpolateBetween(v.startingPos[4], v.startingPos[5], v.startingPos[6], v.stoppingPos[4], v.stoppingPos[5], v.stoppingPos[6], progress, "InOutQuad")
				startPos = {x, y, z, rx, ry, rz}
				time = time - (time - progress * time)
				table.remove(movingGates, k)
				isMoving = true
				break
			end
		end
	end

	if not isMoving then
		local objectInfo = getObjectInfo(elem:getData("objectID"))
		if not objectInfo then return end

		startPos = objectInfo.gateOpened and {objectInfo.gx, objectInfo.gy, objectInfo.gz, objectInfo.grx, objectInfo.gry, objectInfo.grz} or {objectInfo.x, objectInfo.y, objectInfo.z, objectInfo.rx, objectInfo.ry, objectInfo.rz}

		--startPos = not elem:getData("gateState") and elem:getData("gatePos") or elem:getData("closePos")
	end

	table.insert(movingGates, {
		oElement = elem,
		startingPos = startPos,
		stoppingPos = stopPos,
		time = time,
		started = getTickCount()
		})

end
addEvent("gFunc.new", true)
addEventHandler("gFunc.new", root, gFunc.new)

function gFunc.renderGates()
	for k, v in ipairs(movingGates) do
		local progress = (getTickCount() - v.started) / v.time
		if progress > 1 then
			local x, y, z = interpolateBetween(v.startingPos[1], v.startingPos[2], v.startingPos[3], v.stoppingPos[1], v.stoppingPos[2], v.stoppingPos[3], 1, "InOutQuad")
			local rx, ry, rz = interpolateBetween(v.startingPos[4], v.startingPos[5], v.startingPos[6], v.stoppingPos[4], v.stoppingPos[5], v.stoppingPos[6], 1, "InOutQuad")
			v.oElement:setPosition(x, y, z)
			v.oElement:setRotation(rx, ry, rz)
			table.remove(movingGates, k)
		else
			if isElement(v.oElement) and isElementStreamedIn(v.oElement) then
				local x, y, z = interpolateBetween(v.startingPos[1], v.startingPos[2], v.startingPos[3], v.stoppingPos[1], v.stoppingPos[2], v.stoppingPos[3], progress, "InOutQuad")
				local rx, ry, rz = interpolateBetween(v.startingPos[4], v.startingPos[5], v.startingPos[6], v.stoppingPos[4], v.stoppingPos[5], v.stoppingPos[6], progress, "InOutQuad")
				v.oElement:setPosition(x, y, z)
				v.oElement:setRotation(rx, ry, rz)
			end
		end
	end
end
addEventHandler("onClientRender", root, gFunc.renderGates)