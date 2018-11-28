----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function giveClientFaceCodes(player, data)
	triggerClientEvent(player, "loadFaceCodesClient", player, data)
end

function giveClientFaceCode(player, faceCode, name)
	triggerClientEvent(player, "loadFaceCodeClient", player, faceCode, name)
end

function colorPlayer(player)
	triggerClientEvent(player, "colorPlayer", player)
end