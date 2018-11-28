----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:31
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:34
----------------------------------------------------

-- function cmdBW(player, command, arg1, arg2)
--	if not doesAdminHavePerm(player, "bw") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end

--	if(not tonumber(arg1) or not tonumber(arg2)) then
--		outputChatBox(string.format("TIP: /bw [ID gracza] [Czas (sekundy)]"), player, 180, 180, 180)
--		return
--	end

--	local elem = exports.titan_login:getPlayerByID(tonumber(arg1))
--	if(not elem) then
--		exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
--		return
--	end
--
--	if(tonumber(arg2) == 0) then
--		if(not exports.titan_bw:doesPlayerHaveBW(elem)) then
--			exports.titan_noti:showBox(player, string.format("%s nie ma BW.", exports.titan_chats:getPlayerICName(elem)))
--			return
--		end
--		exports.titan_bw:turnBWOff(elem)
--		exports.titan_noti:showBox(player, string.format("Zdjąłeś BW %s.", exports.titan_chats:getPlayerICName(elem)))
--	else
--		exports.titan_bw:setPlayerBW(elem, tonumber(arg2))
--		exports.titan_noti:showBox(player, string.format("Zmieniłeś czas BW %s na %d sekund.", exports.titan_chats:getPlayerICName(elem), arg2))
--		setElementData(elem, "CKReason", {killerDNA = "N/D", weaponID = "N/D", weaponData = "N/D"})
---	end
--	return
--	exports.titan_logs:commandLog(player, command, {arg1, arg2})
--end
--addCommandHandler("bw", cmdBW, false, false)

function cmdBW(player, command, arg1, arg2)
    if not doesAdminHavePerm(player, "bw") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
 
    if(not tonumber(arg1) or not tonumber(arg2)) then
        outputChatBox(string.format("TIP: /bw [ID gracza] [Czas (sekundy)]"), player, 180, 180, 180)
        return
    end
 
    local elem = exports.titan_login:getPlayerByID(tonumber(arg1))
    if(not elem) then
        exports.titan_noti:showBox(player, "Nie znaleziono gracza o podanym ID.")
        return
    end
 
    if(tonumber(arg2) == 0) then
        if(not exports.titan_bw:doesPlayerHaveBW(elem)) then
            exports.titan_noti:showBox(player, string.format("%s nie ma BW.", exports.titan_chats:getPlayerICName(elem)))
            return
        end
        exports.titan_bw:turnBWOff(elem)
        exports.titan_noti:showBox(player, string.format("Zdjąłeś BW %s.", exports.titan_chats:getPlayerICName(elem)))
    else
        exports.titan_bw:setPlayerBW(elem, tonumber(arg2))
        exports.titan_noti:showBox(player, string.format("Zmieniłeś czas BW %s na %d sekund.", exports.titan_chats:getPlayerICName(elem), arg2))
        setElementData(elem, "CKReason", {killerDNA = "N/D", weaponID = "N/D", weaponData = "N/D"})
    end
    return
    exports.titan_logs:commandLog(player, command, {arg1, arg2}, elem)
end
addCommandHandler("bw", cmdBW, false, false)