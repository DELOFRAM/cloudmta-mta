----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function showBox(player, text)
	if isElement(player) then
		triggerClientEvent(player, "showBox", player, text)
	end
end

function showFriend(player, data, text)
	if isElement(player) then
		triggerClientEvent(player, "showFriend", player, data, text)
	end
end