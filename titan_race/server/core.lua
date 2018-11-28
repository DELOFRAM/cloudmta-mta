function findFreeIndexTable(tab)
	table.sort(tab)
	local free_index = 1
	for i,v in ipairs(tab) do
		if (v==free_index) then free_index = free_index+1 end
		if (v>free_index) then return free_index end
	end
	if free_index == 0 then free_index = 1 end
	return free_index
end

function serachPlayerID(player, value)
local target = exports.titan_login:getPlayerByID(value)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID lub nie jest zalogowany.")
		return false
	end
	return target
end