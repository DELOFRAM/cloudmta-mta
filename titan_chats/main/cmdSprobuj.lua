----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:36
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:38
----------------------------------------------------

function cmdSprobuj(player, command, ...)
	if not exports.titan_login:isLogged(player) then return end
	local message = table.concat({...}, " ")
	if string.len(message) < 1 then return exports.titan_noti:showBox(player, "TIP: /sprobuj [akcja]") end
	local state = math.random(0, 1)
	if getElementData(player, "sex") == 1 and state == 0 then text = "odniósł sukces" end
	if getElementData(player, "sex") == 1 and state == 1 then text = "zawiódł" end
	if getElementData(player, "sex") == 2 and state == 0 then text = "odniosła sukces" end
	if getElementData(player, "sex") == 2 and state == 1 then text = "zawiodła" end
	sendPlayerLocalSprobujRadius(player, string.format("%s, próbując %s. ", text, message), 10.0)
end
addCommandHandler("sprobuj", cmdSprobuj, false, false)