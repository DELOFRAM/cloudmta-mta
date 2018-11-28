----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()

function getPlayerGangzone()
	local x, y = getElementPosition(localPlayer)
	for k, v in ipairs(getElementsByType("radararea")) do
		if isInsideRadarArea(v, x, y) then return v end
	end
	return false
end

function renderSectorInfo()
	local playerGangzone = getPlayerGangzone()
	if not playerGangzone then return end

	local data = string.format("ID sektoru: %d\nNazwa sektoru: %s\nPozycja: %s\nOwner: %d\nScores: %s", playerGangzone:getData("sectorID"), playerGangzone:getData("sectorName"), toJSON(playerGangzone:getData("sectorPos")), playerGangzone:getData("sectorOwner"), toJSON(playerGangzone:getData("sectorScores")))
	dxDrawText(data, sW - 350, 10)
end
addEventHandler("onClientRender", root, renderSectorInfo)