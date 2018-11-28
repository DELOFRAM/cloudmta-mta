----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:41:03
-- Ostatnio zmodyfikowano: 2016-01-09 15:41:06
----------------------------------------------------

function cmdATrash(player, command, arg1, arg3, ...)
	if not doesAdminHavePerm(player, "bus") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg2 = table.concat({...}, " ")
	if not tonumber(arg1) or not arg2 or string.len(tostring(arg2)) < 2 or not arg3 then return exports.titan_noti:showBox(player, "TIP: /atrash [ID obiektu] [Pojemność] [Nazwa Śmietnika]") end
	arg1 = tonumber(arg1)
	arg3 = tonumber(arg3)
	local objectInfo = exports.titan_objects:getObjectInfo(arg1)
	if not objectInfo then return exports.titan_noti:showBox(player, "Obiekt nie istnieje.") end
	if objectInfo.object:getData("isTrash") then return exports.titan_noti:showBox(player, "Obiekt jest już śmietnikiem.") end
	local tID = exports.titan_trash:DustbinsCreate(player, arg2, arg1, arg3)
	if tID then
		objectInfo.object:setData("isTrash", true)
		objectInfo.object:setData("trashID", bID)
		exports.titan_noti:showBox(player, "Śmietnik został dodany pomyślnie.")
	else
		exports.titan_noti:showBox(player, "Dodawanie śmietnika nie powiodło się.")
	end
end
addCommandHandler("atrash", cmdATrash, false, false)