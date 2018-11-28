----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local healScript = {}

local sW, sH = guiGetScreenSize()
healScript.oneHPTime = 0.3

function healScript.createGUI()
	if healScript.showing then return end
	if isElement(healScript.window) then destroyElement(healScript.window) end
	healScript.window = guiCreateWindow(570/1680*sW, 372/1050*sH, 515/1680*sW, 195/1050*sH, "Potwierdzenie rozpoczęcia leczenia.", false)
	guiWindowSetSizable(healScript.window, false)
	guiWindowSetMovable(healScript.window, false)
	healScript.label = guiCreateLabel(9/1680*sW, 23/1050*sH, 496/1680*sW, 35/1050*sH, "Czy chcesz rozpocząć proces leczenia? Może on zająć do siedmiu minut w zalezności od obrażen.", false, healScript.window)
	healScript.button1 = guiCreateButton(11/1680*sW, 111/1050*sH, 231/1680*sW, 74/1050*sH, "Tak (X$)", false, healScript.window)
	healScript.button2 = guiCreateButton(274/1680*sW, 111/1050*sH, 231/1680*sW, 74/1050*sH, "Nie, jednak nie.", false, healScript.window)
	guiSetFont(healScript.label, "clear-normal")
	guiLabelSetHorizontalAlign(healScript.label, "left", true)
	guiSetProperty(healScript.button1, "NormalTextColour", "FFAAAAAA")
	guiSetProperty(healScript.button2, "NormalTextColour", "FFAAAAAA")
	exports.titan_cursor:showCustomCursor("orgsClientHealScript")
	healScript.showing = true
end

function healScript.deleteGUI()
	if isElement(healScript.window) then destroyElement(healScript.window) end
	exports.titan_cursor:hideCustomCursor("orgsClientHealScript")
	healScript.showing = false
end

function healScript.render()
	dxDrawText(string.format("Trwa proces leczenia..."), sW / 2, sH / 2)
end

function healScript.startHeal()
	addEventHandler("onClientRender", root, healScript.render)
end

function healScript.stopHeal()
	removeEventHandler("onClientRender", root, healScript.render)
end