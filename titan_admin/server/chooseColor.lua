----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:43:21
-- Ostatnio zmodyfikowano: 2016-01-09 15:43:24
----------------------------------------------------

function changeVehicleColor(veh, color, r, g, b)
	if not doesAdminHavePerm(source, "vehicles") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	if(color == 1 or color == 2) then
		if(exports.titan_vehicles:changeVehicleColor(veh, color, r, g, b)) then
			exports.titan_noti:showBox(source, "Kolor pojazdu zmieniony pomyślnie.")
			return
		else
			exports.titan_noti:showBox(source, "Nie udało się zmienić koloru.")
			return
		end
	end
end
addEvent("changeVehicleColor", true)
addEventHandler("changeVehicleColor", root, changeVehicleColor)

function changeGroupColor(groupID, r, g, b)
	if not doesAdminHavePerm(source, "orgs") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
	if not groupInfo then return exports.titan_noti:showBox(source, "Nie znaleziono grupy o podanym ID.") end
	exports.titan_orgs:changeGroupData(groupInfo.ID, "r", r)
	exports.titan_orgs:changeGroupData(groupInfo.ID, "g", g)
	exports.titan_orgs:changeGroupData(groupInfo.ID, "b", b)
	exports.titan_noti:showBox(source, "Kolor grupy został zmieniony.")

end
addEvent("changeGroupColor", true)
addEventHandler("changeGroupColor", root, changeGroupColor)