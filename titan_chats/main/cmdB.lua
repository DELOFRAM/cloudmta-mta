----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:03
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:06
----------------------------------------------------

function cmdB(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return false end

	local message = table.concat({...}, " ")
	if(string.len(message) < 1 and command ~= "Say(OOC)") then
		exports.titan_noti:showBox(player, "TIP: /b [treść]")
		return false 
	end
	if tonumber(player:getData("oocBlock")) and player:getData("oocBlock") > 0 then
		if player:getData("oocBlock") > getRealTime().timestamp then
			exports.titan_noti:showBox(player, "Posiadasz nałożona blokadę OOC!")
			return
		else
			player:setData("oocBlock", 0)
			exports.titan_db:query("UPDATE _characters SET oocBlock = '0' WHERE ID = ?", player:getData("charID"))
		end
	end
	message = firstToUpper(message)
	message = addStop(message)
	local radius = 10.0
	local pX, pY, pZ = getElementPosition(player)
	local sphere = createColSphere(pX, pY, pZ, radius)
	local players = getElementsWithinColShape(sphere, "player")
	destroyElement(sphere)
	local int, vw = getElementInterior(player), getElementDimension(player)
	for k, v in ipairs(players) do
		if(getElementInterior(v) == int and getElementDimension(v) == vw) then
			if(getElementData(v, "loggedIn") == 1) then
				local tPX, tPY, tPZ = getElementPosition(v)
				local dist = getDistanceBetweenPoints3D(pX, pY, pZ, tPX, tPY, tPZ)
				local progress = dist / radius
				local r, g, b = interpolateBetween(230, 230, 230, 110, 110, 110, progress, "Linear")
			end
		end
	end
	sendPlayerOOCMessageRadius(player, message, 10.0)
	return true
end
addCommandHandler("b", cmdB, false, false)
addCommandHandler("Say(OOC)", cmdB)