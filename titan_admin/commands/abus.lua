----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:03
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:06
----------------------------------------------------

function cmdAbus(player, command, arg1, ...)
	if not doesAdminHavePerm(player, "bus") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg2 = table.concat({...}, " ")
	if not tonumber(arg1) or not arg2 or string.len(tostring(arg2)) < 2 then return exports.titan_noti:showBox(player, "TIP: /abus [ID obiektu] [Nazwa przystanku]") end
	arg1 = tonumber(arg1)
	local objectInfo = exports.titan_objects:getObjectInfo(arg1)
	if not objectInfo then return exports.titan_noti:showBox(player, "Obiekt nie istnieje.") end
	if objectInfo.object:getData("isBus") then return exports.titan_noti:showBox(player, "Obiekt jest już przystankiem.") end
	local bID = exports.titan_bus:busCreate(player, arg2, arg1)
	if bID then
		objectInfo.object:setData("isBus", true)
		objectInfo.object:setData("busID", bID)
		exports.titan_noti:showBox(player, "Przystanek został dodany pomyślnie.")
	else
		exports.titan_noti:showBox(player, "Dodawanie przystanku nie powiodło się.")
	end
end
addCommandHandler("abus", cmdAbus, false, false)