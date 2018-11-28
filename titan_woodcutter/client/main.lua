local sW, sH = guiGetScreenSize()
local importantVar = 0
local additionalVar = 0

function mathSine()
	return math.sin(math.rad(importantVar))
end
function testRender()
	local sine = mathSine()
	dxDrawRectangle(sW / 2 - 100, sH / 2 - 10, 200, 20, tocolor(255, 0, 255, 180))
	local sum = (sine * 100) + additionalVar
	local x = sW / 2 + sum
	local y = sH / 2 - 15
	dxDrawLine(x, y, x, y + 30, tocolor(255, 255, 255, 255), 1.0)

	if getKeyState("m") then additionalVar = additionalVar + 3 end
	if getKeyState("n") then additionalVar = additionalVar - 3 end

	if sum > 85 or sum < -85 then
		
	end

	importantVar = importantVar + 1
	if importantVar == 360 then importantVar = 0 end
end
addEventHandler("onClientRender", root, testRender)