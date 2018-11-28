----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

--QUIT EVENT

function playerExit(qt)
	if(isLogged(source)) then
		exports.titan_items:disarmPlayer(source)
		savePlayer(source)
		exports.titan_logs:saveLoginLogQuit(source)
		x, y, z = getElementPosition(source)
		charID = getElementData(source, "charID")
		oldx = getElementData(source, "lastPos")[1]
		oldy = getElementData(source, "lastPos")[2]
		oldz = getElementData(source, "lastPos")[3]
		exports.titan_hud:createQuitText(x, y, z, string.format("%s wyszedł z gry (%s)", exports.titan_chats:getPlayerICName(source), qt))
		if qt == "Kicked" or qt == "Timed Out" or qt == "Bad Connection" or qt == "Unknown" then
			exports.titan_db:query_free("UPDATE _characters SET x = ?, y = ?, z = ? WHERE ID = ?", x, y, z, charID)
			setTimer(function()
			exports.titan_db:query_free("UPDATE _characters SET x = ?, y = ?, z = ? WHERE ID = ?", oldx, oldy, oldz, charID)
			end, 10*60000, 1)
		end
	else
		local memberID = getElementData(source, "memberID")
		if tonumber(memberID) then
			exports.titan_db:query_free("UPDATE ipb_members SET game_inGame = 0 WHERE ID = ?", memberID)
		end
	end
end
addEventHandler("onPlayerQuit", getRootElement(), playerExit)

addCommandHandler("qs", function(player)
	
end)