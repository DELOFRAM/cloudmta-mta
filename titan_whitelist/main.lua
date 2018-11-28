----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function onConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)
	--local query = exports.titan_db:query("SELECT ID FROM _whitelist WHERE serial = ?", playerSerial)
	
	--[[if playerSerial == "B0A143A01145E7578CA05E8BD0DFBF03" or playerSerial == "E5EC92D8ABCD768AB8FDCF641A2DD6F4" or playerIP == "78.88.179.50" then
		cancelEvent(true, "Serial został zbanowany.")
	end]]

	local players = 0
	for k, v in ipairs(getElementsByType("player")) do
		if not exports.titan_login:isLogged(v) then players = players + 1 end
	end
	if players >= 100 then
		cancelEvent(true, "Wpuszczamy po 100 osób.")
	end
end
addEventHandler("onPlayerConnect", root, onConnect)