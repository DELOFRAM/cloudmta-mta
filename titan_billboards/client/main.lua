----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:43:51
-- Ostatnio zmodyfikowano: 2016-01-09 15:43:53
----------------------------------------------------

local billboardFunc = {}
local billboardData = {}
engineSetModelLODDistance(4238, 400)

function billboardFunc.load()
	local time = getTickCount()
	for k, v in ipairs(bbList) do
		if type(v.ironObject) == "table" then
			local obj = createObject(v.ironObject.model, v.ironObject.pos, v.ironObject.rot)
			obj:setScale(v.ironObject.scale)
		end
		billboardData[k] = 
		{
			object = createObject(4238, v.pos, v.rot),
			shader = dxCreateShader("client/replace.fx")
		}
		billboardData[k].object:setScale(v.scale)
		billboardData[k].object:setCollisionsEnabled(false)
		local texture = dxCreateRenderTarget(650, 200, true)
		dxSetRenderTarget(texture)
			dxSetBlendMode("modulate_add")
				dxDrawImage(0, 0, 650, 200, "client/1.jpg")
				dxDrawText(string.format("Billboard nr. %d", k), 10, 10, 0, 0, tocolor(255, 255, 255, 200), 1.5, "default-bold")
			dxSetBlendMode("blend")
		dxSetRenderTarget()
		dxSetShaderValue(billboardData[k].shader, "Tex0", texture)
		engineApplyShaderToWorldTexture(billboardData[k].shader, "heat_02", billboardData[k].object)
	end
	outputDebugString(string.format("[BILLBOARDS] Załadowano billboardy (%d). | %d ms", #billboardData, getTickCount() - time))
end
addEventHandler("onClientResourceStart", resourceRoot, billboardFunc.load)

function billboardFunc.restore(clearRenderTargets)
	if clearRenderTargets then
		for k, v in ipairs(billboardData) do
			if isElement(v.object) then destroyElement(v.object) end
			if isElement(v.shader) then destroyElement(v.shader) end
		end
		billboardData = {}
		billboardFunc.load()
	end
end
addEventHandler("onClientRestore", root, billboardFunc.restore)