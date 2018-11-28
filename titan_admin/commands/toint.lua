----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:43:02
-- Ostatnio zmodyfikowano: 2016-01-14 22:10:03
----------------------------------------------------

function cmdToInt(player, command, arg1)
	if not doesAdminHavePerm(player, "doors") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	if(not tonumber(arg1)) then
		exports.titan_noti:showBox(player, "TIP: /toint [numer interioru]")
		local query = exports.titan_db:query("SELECT * FROM _intlist ORDER BY name ASC")
		if(#query > 0) then
			outputConsole("---INTERIORY---", player)
			for k, v in ipairs(query) do
				outputConsole(string.format("UID: %d, Nazwa: %s", v.uid, v.name), player)
			end
		end
		return
	end
	arg1 = tonumber(arg1)

	local query = exports.titan_db:query("SELECT * FROM _intlist WHERE uid = ?", arg1)
	if(#query <= 0) then
		exports.titan_noti:showBox(player, "Nie istnieje taki interior.")
		return
	end
	query = query[1]

	setElementPosition(player, query.x, query.y, query.z)
	local rX, rY, rZ = getElementRotation(player)
	setElementRotation(player, rX, rY, query.a)
	setElementInterior(player, query.int)

end
addCommandHandler("toint", cmdToInt, false, false)