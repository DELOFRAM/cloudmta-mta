----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function setPlayerID()
	local i = 1
	while(true) do
		if(not isElement(getElementByID("pid"..i))) then setElementID(source, "pid"..i) setElementData(source, "playerID", i) return end
		i = i + 1
	end
end
addEventHandler("onPlayerJoin", root, setPlayerID)

function getPlayerByID(ID)
	local elem = getElementByID("pid"..ID)
	if(not isElement(elem)) then return false end
	if(not exports.titan_login:isLogged(elem)) then return false end
	return elem
end