----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local pjFunc = {}

pjFunc.vehiclesTextures =
{
	[407] = "remapfiretruk292body256",
	[416] = "remapambulan292body256"
}
pjFunc.shaderElement = {}

function pjFunc.streamIn()
	if getElementType(source) == "vehicle" then
		pjFunc.update(source)
	end
end
addEventHandler("onClientElementStreamIn", root, pjFunc.streamIn)

function pjFunc.streamOut()
	if getElementType(source) == "vehicle" then
		pjFunc.vehicleDeleteShader(source)
	end
end
addEventHandler("onClientElementStreamOut", root, pjFunc.streamOut)

function pjFunc.update(veh)
	if isElement(veh) and isElementStreamedIn(veh) then
		pjFunc.vehicleDeleteShader(veh)
		local textureName = pjFunc.getVehicleModelTextureName(getElementModel(veh))
		if not textureName then return end
		local elementData = veh:getData("customPJ")
		if tonumber(elementData) then
			elementData = tonumber(elementData)
			if elementData ~= 0 then
				if fileExists(string.format("files/%d/%d.png", getElementModel(veh), elementData)) then
					pjFunc.shaderElement[veh] = dxCreateShader("client/texture.fx", 0, 0, false, "vehicle")
					if isElement(pjFunc.shaderElement[veh]) then
						local texture = dxCreateTexture(string.format("files/%d/%d.png", getElementModel(veh), elementData), "dxt1", false, "clamp")
						if isElement(texture) then
							dxSetShaderValue(pjFunc.shaderElement[veh], "gTexture", texture)
							engineApplyShaderToWorldTexture(pjFunc.shaderElement[veh], textureName, veh)
							setElementParent(pjFunc.shaderElement[veh], veh)
						end
					end
				end
			end
		end
	end
end
addEvent("pjFunc.update", true)
addEventHandler("pjFunc.update", root, pjFunc.update)

function pjFunc.vehicleDeleteShader(veh)
	if isElement(pjFunc.shaderElement[veh]) then
		destroyElement(pjFunc.shaderElement[veh])
	end
end

function pjFunc.getVehicleModelTextureName(vehModel)
	if not pjFunc.vehiclesTextures[vehModel] then return false end
	return pjFunc.vehiclesTextures[vehModel]
end