----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local data = 0
function globalTimer()
	data = data + 1
	local isSynchronize = data % 10 == 0 and true or false
	if localPlayer:getData("loggedIn") and localPlayer:getData("loggedIn") == 1 then
		if not localPlayer:getData("tempOnlineTime") then localPlayer:setData("tempOnlineTime", 0) end
		if localPlayer:getData("isAFK") then
			local afkTime = localPlayer:getData("afkTime")
			if tonumber(afkTime) then
				localPlayer:setData("afkTime", afkTime + 1, isSynchronize)
			end
		else
			local onlineTime = localPlayer:getData("onlineTime")
			if tonumber(onlineTime) then
				localPlayer:setData("onlineTime", onlineTime + 1, isSynchronize)
				if onlineTime % 3600 == 0 and onlineTime > 0 then
					triggerServerEvent("playerAddCloudPoints", localPlayer)
				end
			end
		end
		localPlayer:setData("tempOnlineTime", localPlayer:getData("tempOnlineTime") + 1, isSynchronize)
	end
	if data > 20 then data = 1 end
end
setTimer(globalTimer, 1000, 0)

