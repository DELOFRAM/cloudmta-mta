----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:40:39
-- Ostatnio zmodyfikowano: 2016-01-09 15:40:45
----------------------------------------------------

function cmdAArest(player, command, option)
	if not doesAdminHavePerm(player, "arrest") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	option = string.lower(tostring(option))
	local dim = player:getDimension()
	if option == "stworz" then
		if dim == 0 then
			exports.titan_noti:showBox(player, "Nie możesz tworzyć cel na virtualworldzie 0.")
			return
		end
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dim)
		if not doorInfo then
			exports.titan_noti:showBox(player, "W tym virtualworldzie nie jest stworzone żadne pomieszczenie.")
			return
		end
		triggerClientEvent(player, "aresztData.create", player)
	elseif option == "lista" then
		if dim == 0 then
			exports.titan_noti:showBox(player, "Nie możesz tworzyć cel na virtualworldzie 0.")
			return
		end
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dim)
		if not doorInfo then
			exports.titan_noti:showBox(player, "W tym virtualworldzie nie jest stworzone żadne pomieszczenie.")
			return
		end
		local arrestData = exports.titan_orgs:getArrestsDataFromInterior(doorInfo.ID)
		if not arrestData then
			exports.titan_noti:showBox(player, "W tym pomieszczeniu nie znajduje się żadna cela.")
			return
		end
		triggerClientEvent(player, "aresztData.create2", player, arrestData)
	else
		exports.titan_noti:showBox(player, "TIP: /aareszt [stworz, lista]")
		return
	end
end
addCommandHandler("aareszt", cmdAArest, false)

function createNewArrest(name)
	if not doesAdminHavePerm(source, "arrest") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local x, y, z = getElementPosition(source)
	local int = source:getInterior()
	local dim = source:getDimension()
	if dim == 0 then
		exports.titan_noti:showBox(source, "Nie możesz tworzyć cel na virtualworldzie 0.")
		return
	end
	local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dim)
	if not doorInfo then
		exports.titan_noti:showBox(source, "W tym virtualworldzie nie jest stworzone żadne pomieszczenie.")
		return
	end
	local newArrest = exports.titan_orgs:createNewArrest(doorInfo.ID, x, y, z, name, int, dim)
	if newArrest then
		exports.titan_noti:showBox(source, "Cela została pomyślnie umiejscowiona w tym miejscu.")
		return
	else
		exports.titan_noti:showBox(source, "Wystąpił błąd. Niezwłocznie powiadom administratora!1!!one!1! (#001)")
		return
	end
end
addEvent("createNewArrest", true)
addEventHandler("createNewArrest", root, createNewArrest)

function removeArrest(ID)
	if not doesAdminHavePerm(source, "arrest") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local removeArrest = exports.titan_orgs:removeArrest(ID)
	if removeArrest then
		exports.titan_noti:showBox(source, "Areszt poprawnie usunięty.")
	else
		exports.titan_noti:showBox(source, "Wystąpił błąd. Niezwłocznie powiadom administratora!1!!one!1! (#002)")
	end
end
addEvent("removeArrest", true)
addEventHandler("removeArrest", root, removeArrest)