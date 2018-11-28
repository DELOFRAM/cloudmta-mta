----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local objectShader = {}

function streamIn()
	if getElementType(source) == "object" then
		local texData = getElementData(source, "textures:data")
		if type(texData) == "table" then
			for k, v in ipairs(texData) do
				local texName, texID = unpack(v)
				if texName and texID then
					setObjectTexture(source, texName, texID)
				end
			end
		end
	end
end
addEventHandler("onClientElementStreamIn", root, streamIn)

function streamOut()
	if type(objectShader[source]) == "table" then
		for k, v in ipairs(objectShader[source]) do
			if isElement(v.shader) then
				destroyElement(v.shader)
			end
		end
		objectShader[source] = nil
	end
end
addEventHandler("onClientElementStreamOut", root, streamOut)

function setObjectTexture(object, textureName, textureID)
	if textureName ~= "side1" and textureName ~= "side2" then return end

	if isElementStreamedIn(object) then
		local texDir = string.format("textures/%d.jpg", textureID)
		if fileExists(texDir) then
			if type(objectShader[object]) ~= "table" then objectShader[object] = {} end
			for k, v in ipairs(objectShader[object]) do
				if v.texName == textureName then
					destroyElement(v.shader)
				end
				table.remove(objectShader[object], k)
			end

			local tempTable = 
			{
				texName = textureName,
				shader = dxCreateShader("textures/texture.fx")
			}

			if isElement(tempTable.shader) then
				tempTable.shader:setParent(object)
				table.insert(objectShader[object], tempTable)
				local texture = dxCreateTexture(texDir, "dxt1", false, "clamp")
				if isElement(texture) then
					dxSetShaderValue(tempTable.shader, "gTexture", texture)
					engineApplyShaderToWorldTexture(tempTable.shader, textureName, object)
					destroyElement(texture)
				end
			end
		end
	end
end
addEvent("setObjectTexture", true)
addEventHandler("setObjectTexture", root, setObjectTexture)

function removeObjectTexture(object, textureName)
	if type(objectShader[object]) == "table" then
		for k, v in ipairs(objectShader[object]) do
			if isElement(v.shader) and v.texName == textureName then
				destroyElement(v.shader)
				table.remove(objectShader[object], k)
			end
		end
	end
end
addEvent("removeObjectTexture", true)
addEventHandler("removeObjectTexture", root, removeObjectTexture)