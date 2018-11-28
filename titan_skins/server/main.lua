----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local skinFunc = {}
function skinFunc.cmd(player, command, ID, name, src)
	ID = tonumber(ID)
	local target = exports.titan_login:getPlayerByID(ID)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return
	end
	local tempTable = {}
	table.insert(tempTable, {name = name, src = src})
	target:setData("skinData", tempTable)
	exports.titan_noti:showBox(player, "Gotowe")
	triggerClientEvent("skinFunc.update", resourceRoot, target)
end
addCommandHandler("skintemp", skinFunc.cmd, false, false)