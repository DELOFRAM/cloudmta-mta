----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local skinsData = {}
local skinFunc = {}
function skinFunc.replace()
	local txd = engineLoadTXD("client/skin60/omyst.txd")
	local dff = engineLoadDFF("client/skin60/omyst.dff")
	engineImportTXD(txd, 60)
	engineReplaceModel(dff, 60)

	local txd = engineLoadTXD("client/skin7/male01.txd")
	local dff = engineLoadDFF("client/skin7/male01.dff")
	engineImportTXD(txd, 7)
	engineReplaceModel(dff, 7)

	local txd = engineLoadTXD("client/skin106/fam2.txd")
	local dff = engineLoadDFF("client/skin106/fam2.dff")
	engineImportTXD(txd, 106)
	engineReplaceModel(dff, 106)

	local txd = engineLoadTXD("client/skin111/maffa.txd")
	local dff = engineLoadDFF("client/skin111/maffa.dff")
	engineImportTXD(txd, 111)
	engineReplaceModel(dff, 111)
end
addEventHandler("onClientResourceStart", resourceRoot, skinFunc.replace)

function skinFunc.streamIn()
	if source:getType() == "player" then
		if type(skinsData[source]) == "table" then
			for k, v in ipairs(skinsData[source]) do
				if isElement(v) then destroyElement(v) end
			end
		end
		skinsData[source] = nil
		if type(source:getData("skinData")) == "table" then
			skinsData[source] = {}
			for k, v in ipairs(source:getData("skinData")) do
				local shader = skinFunc.skinReplace(source, v.name, v.src)
				table.insert(skinsData[source], shader)
			end
		end
	end
end
addEventHandler("onClientElementStreamIn", root, skinFunc.streamIn)

function skinFunc.streamOut()
	if source:getType() == "player" then
		if type(skinsData[source]) == "table" then
			for k, v in ipairs(skinsData[source]) do
				if isElement(v) then destroyElement(v) end
			end
		end
		skinsData[source] = nil
	end
end
addEventHandler("onClientElementStreamOut", root, skinFunc.streamOut)

function skinFunc.update(player)
	if type(skinsData[player]) == "table" then
		for k, v in ipairs(skinsData[player]) do
			if isElement(v) then destroyElement(v) end
		end
	end
	skinsData[player] = nil
	if isElementStreamedIn(player) then
		if type(player:getData("skinData")) == "table" then
			skinsData[player] = {}
			for k, v in ipairs(player:getData("skinData")) do
				local shader = skinFunc.skinReplace(player, v.name, v.src)
				table.insert(skinsData[player], shader)
			end
		end
	end
end
addEvent("skinFunc.update", true)
addEventHandler("skinFunc.update", root, skinFunc.update)

function skinFunc.skinReplace(player, textureName, textureSrc)
	local shader = dxCreateShader("client/texture.fx", 0, 0, false, "ped")
	local texture = dxCreateTexture(textureSrc, "dxt1", false, "clamp")
	if isElement(texture) and isElement(shader) then
		dxSetShaderValue(shader, "gTexture", texture)
		engineApplyShaderToWorldTexture(shader, textureName, player)
		destroyElement(texture)
	end
	shader:setParent(player)
	return shader
end