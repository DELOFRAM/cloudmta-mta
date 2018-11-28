----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local spheresFunc = {}

function spheresFunc.polygonEnter(player, matchingDimension)
	if getElementType(player) == "player" and matchingDimension then
		if isElement(source) and spheresFunc.isSphere(source) then
			setElementData(player, "playerSphere:ID", tonumber(getElementData(source, "sphere:ID")))
		end
	end
end
addEventHandler("onClientColShapeHit", resourceRoot, spheresFunc.polygonEnter)

function spheresFunc.isSphere(element)
	if isElement(element) and getElementData(element, "sphere:bool") and tonumber(getElementData(element, "sphere:ID")) then return true end
	return false
end

function spheresFunc.polygonLeave(player, matchingDimension)
	if getElementType(player) == "player" and matchingDimension then
		if isElement(source) and spheresFunc.isSphere(source) then
			setElementData(player, "playerSphere:ID", false)
		end
	end
end
addEventHandler("onClientColShapeLeave", resourceRoot, spheresFunc.polygonLeave)