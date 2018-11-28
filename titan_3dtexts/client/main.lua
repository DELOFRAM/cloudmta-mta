----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------
local MAX_VISIBLE = 20
local font = dxCreateFont("client/files/myriad.otf", 10, false)
if not isElement(font) then font = "default" end
function render3DTexts()
	local camX, camY, camZ = getCameraMatrix()
	for k, v in ipairs(getElementsByType("3dtext")) do
		if v:getDimension() == localPlayer:getDimension() and v:getInterior() == localPlayer:getInterior() then
			local pX, pY, pZ = getElementPosition(localPlayer)
			local tX, tY, tZ = getElementPosition(v)
			local dist = getDistanceBetweenPoints3D(pX, pY, pZ, tX, tY, tZ)
			if dist < MAX_VISIBLE then
				local text = v:getData("text")
				if text then
					local progress = dist / MAX_VISIBLE
					if progress < 1 then
						if not processLineOfSight(camX, camY, camZ, tX, tY, tZ, true, false, false, true, false, true) then
							local screenW, screenH = getScreenFromWorldPosition(tX, tY, tZ, 10, false)
							if screenW and screenH then
								local alpha, scale, offset = interpolateBetween(255, 1.0, 0, 0, 0.8, 1, progress, "Linear")
								dxDrawText(text, screenW + 1 - 150, screenH + 1 + offset, screenW + 151, 0, tocolor(0, 0, 0, alpha), scale, font, "center", "top", false, true, false, false, false)
								dxDrawText(text, screenW - 150, screenH + offset, screenW + 150, 0, tocolor(v:getData("r"), v:getData("g"), v:getData("b"), alpha), scale, font, "center", "top", false, true, false, false, false)
							end	
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, render3DTexts)