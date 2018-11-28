----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()

local renderedPlayers = {}
local renderedVehicles = {}
function onElementStreamIn()
	if(getElementType(source) == "player") then
		if(not renderedPlayers[source]) then
			renderedPlayers[source] = true
		end
	elseif getElementType(source) == "vehicle" then
		if not renderedVehicles[source] then
			renderedVehicles[source] = true
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)

function onElementStreamOut()
	if(getElementType(source) == "player") then
		if(renderedPlayers[source]) then
			renderedPlayers[source] = false
		end
	elseif getElementType(source) == "vehicle" then
		if renderedVehicles[source] then
			renderedVehicles[source] = false
		end
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

local function onResStart()
	for k, v in ipairs(getElementsByType("player")) do
		if(isElementStreamedIn(v)) then
			renderedPlayers[v] = true
		end
	end
	for k, v in ipairs(getElementsByType("vehicle")) do
		if isElementStreamedIn(v) then
			renderedVehicles[v] = true
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)

local MAXDIST = 15
local MAXDIST_VEH = 23

renderedPlayers[localPlayer] = true

local x, y = 300, 500
local renderTarget = dxCreateRenderTarget(x, y, true)

function renderDesc()
	if localPlayer:getData("hide:playerNames") then return end
	local camX, camY, camZ = getCameraMatrix()
	for v in pairs(renderedPlayers) do
		if(isElement(v)) then
			if v ~= localPlayer or (v == localPlayer and getElementData(localPlayer, "previewDesc")) then
				if(getElementData(v, "loggedIn") == 1) then
					local desc = getElementData(v, "playerDesc")
					if desc and not v:getData("specData") and not isPedInVehicle(v) and v:getAlpha() > 0 then
						local valX, valY, valZ = getPedBonePosition(v, 2)
						local distance = getDistanceBetweenPoints3D(camX, camY, camZ, valX, valY, valZ)
						local progress = distance / MAXDIST
						if(progress < 1) then
							if not processLineOfSight(camX, camY, camZ, valX, valY, valZ, true, true, false, true, true, false, false, false, v) then
								local screenW, screenH = getScreenFromWorldPosition (valX, valY, valZ, 10, false)
								if(screenW and screenH) then
									local testProgress, alpha, alpha2 = interpolateBetween(1.2, 255, 200, 0.8, 0, 0, progress, "OutQuad")
									local newX, newY = x * testProgress, y * testProgress	
									dxSetRenderTarget(renderTarget, true)
										dxSetBlendMode("modulate_add")			
											dxDrawText(desc, 1, 1, x + 1, y + 1, tocolor(0, 0, 0, alpha), 1.0, "default-bold", "center", "center", false, true)						
											dxDrawText(desc, 0, 0, x, y, tocolor(255, 255, 255, alpha), 1.0, "default-bold", "center", "center", false, true)
										dxSetBlendMode("blend")
									dxSetRenderTarget()								
									dxSetBlendMode("add")
									dxDrawImage(screenW - newX / 2, screenH - newY / 2, newX, newY, renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255))							
									dxSetBlendMode("blend")
								end
							end
						end
					end
				end
			end
		else
			renderedPlayers[v] = false
		end
	end

	for v in pairs(renderedVehicles) do
		if(isElement(v)) then
			local desc = getElementData(v, "vehDesc")
			if(desc) then
				local valX, valY, valZ = getElementPosition(v)
				local distance = getDistanceBetweenPoints3D(camX, camY, camZ, valX, valY, valZ)
				local progress = distance / MAXDIST_VEH
				if(progress < 1) then
					if not processLineOfSight(camX, camY, camZ, valX, valY, valZ, true, true, false, true, true, false, false, false, v) then
						local screenW, screenH = getScreenFromWorldPosition (valX, valY, valZ, 10, false)
						if(screenW and screenH) then
							local testProgress, alpha, alpha2 = interpolateBetween(1.2, 255, 200, 0.8, 0, 0, progress, "OutQuad")
							local newX, newY = x * testProgress, y * testProgress
							dxSetRenderTarget(renderTarget, true)
								dxSetBlendMode("modulate_add")
									dxDrawText(desc, 1, 1, x + 1, y + 1, tocolor(0, 0, 0, alpha), 1.0, "default-bold", "center", "center", false, true)
									dxDrawText(desc, 0, 0, x, y, tocolor(190, 132, 214, alpha), 1.0, "default-bold", "center", "center", false, true)
								dxSetBlendMode("blend")
							dxSetRenderTarget()

							dxSetBlendMode("add")
								dxDrawImage(screenW - newX / 2, screenH - newY / 2, newX, newY, renderTarget, 0, 0, 0, tocolor(255, 255, 255, 255))
							dxSetBlendMode("blend")
						end
					end
				end
			end
		else
			renderedPlayers[v] = false
		end
	end
end
addEventHandler("onClientRender", root, renderDesc)