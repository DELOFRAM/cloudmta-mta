----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function cmdTog(player, command, arg)
	if not exports.titan_login:isLogged(player) then return end
	arg = string.lower(tostring(arg))
	if arg == "w" then
		if getElementData(player, "tog:w") then
			removeElementData(player, "tog:w")
			return exports.titan_noti:showBox(player, "Wyłaczyłeś blokadę otrzymywania wiadomości prywatnych.")
		else
			setElementData(player, "tog:w", true)
			return exports.titan_noti:showBox(player, "Właczyłeś blokadę otrzymywania wiadomości prywatnych.")
		end
	else
		return exports.titan_noti:showBox(player, "TIP: /tog [w]")
	end
end
addCommandHandler("tog", cmdTog, false, false)