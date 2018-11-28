----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function showTitanCursor(showing, controls, force)
if not controls then controls = true end
if not showing then showing = false end
if force == true then showCursor(showing or false) return end
	if showing == true then
	showCursor(true, controls)
	else
		if #getElementsByType("titan-gui") <= 1 then
		showCursor(false)
		end
	end
end

addCommandHandler("cursor", function()
if getElementData(localPlayer, "adminLevel") < 3 then return end
outputDebugString(string.format("[CURSOR] Titan UI elements: %d", #getElementsByType("titan-gui")))
end)