----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local data = {0, 0}
function onStart()
	shader = dxCreateShader("tex.fx")
	local x, y, z = getElementPosition(localPlayer)
	veh = createVehicle(541, x, y, z)
	--setTimer(setVehicleColor, 50, 1, veh, 255, 255, 255, 255, 255, 255)
	--setTimer(update, 51, 1)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)

function update()
	local texture = dxCreateRenderTarget(1024, 1024, true)
	dxSetRenderTarget(texture)
		dxDrawRectangle(0, 0, 1024, 1024, tocolor(0, 255, 0, 255))

		dxDrawImage(data[1], data[2], 300, 300, "texture.png", 180, 150, 150, tocolor(255, 255, 255, 255))
	dxSetRenderTarget()
	dxSetShaderValue(shader, "gTexture", texture)
	engineApplyShaderToWorldTexture(shader, "map", veh)
	destroyElement(texture)
end

addEventHandler("onClientKey", root, function(key, state)
	if state then
		if key == "b" then
			data[1] = data[1] + 5 update()
		elseif key == "n" then
			data[1] = data[1] - 5 update()
		elseif key == "m" then
			data[2] = data[2] + 5 update()
		elseif key == "," then
			data[2] = data[2] - 5 update()
		end
		
	end
end)