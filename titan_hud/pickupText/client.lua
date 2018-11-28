----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local renderedPickups = {}

function onElementStreamIn()
	if(getElementType(source) == "player") then
		if(not renderedPickups[source]) then
			renderedPickups[source] = true
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)

function onElementStreamOut()
	if(getElementType(source) == "player") then
		if(renderedPickups[source]) then
			renderedPickups[source] = false
		end
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

local function onResStart()
	for k, v in ipairs(getElementsByType("pickup")) do
		if(isElementStreamedIn(v)) then
			renderedPickups[v] = true
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)

local MAXDIST = 15
local MAXDIST_VEH = 23
local x, y = 300, 500
local renderTarget = dxCreateRenderTarget(x, y, true)

function renderDesc()
	if localPlayer:getData("hide:playerNames") then return end
	local camX, camY, camZ = getCameraMatrix()
	for v in pairs(renderedPickups) do
		if(isElement(v)) then
			if getElementType(v) == "pickup" then
					local desc = getElementData(v, "Desc")
					if desc then
						local valX, valY, valZ = getElementPosition( v )
						local valX = valX-0.1
						local valZ = valZ+0.5
						local distance = getDistanceBetweenPoints3D(camX, camY, camZ, valX, valY, valZ)
						local progress = distance / MAXDIST
						if(progress < 1) then
							if not processLineOfSight(camX, camY, camZ, valX, valY, valZ, true, true, false, true, true, false, false, false, v) then
								local screenW, screenH = getScreenFromWorldPosition (valX, valY, valZ, 10, false)
								if(screenW and screenH) then
									dxSetRenderTarget(renderTarget, true)										
									dxDrawText(desc, 0, 0, x, y, tocolor(152,173,140, 255), 1.3, "default-bold", "center", "center", false, true)
									dxSetRenderTarget()
									local testProgress, alpha, alpha2 = interpolateBetween(1.2, 200, 200, 0.8, 0, 0, progress, "OutQuad")
									local newX, newY = x * testProgress, y * testProgress
									dxDrawImage(screenW - newX / 2, screenH - newY / 2, newX, newY, renderTarget, 0, 0, 0, tocolor(255, 255, 255, alpha))														
							end
						end
					end
				end
			end
		else
			renderedPickups[v] = false
		end
	end
end
addEventHandler("onClientRender", root, renderDesc)