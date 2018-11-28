----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:43:14
-- Ostatnio zmodyfikowano: 2016-01-09 15:43:20
----------------------------------------------------

function onClientChooseGroup(veh, group)
	if(not isPlayerAdmin(source)) then return end
	local vehInfo = exports.titan_vehicles:getVehInfo(veh)
	if vehInfo then
		if(exports.titan_vehicles:assignVehicle(vehInfo.ID, 2, group)) then
			exports.titan_noti:showBox(source, "Pojazd przypisano pomyślnie.")
			local groupInfo = exports.titan_orgs:getGroupInfo(group)
			if groupInfo then
				exports.titan_logs:adminLog(source:getData("globalName"), string.format("%s (UID: %d, CID: %d) przypisał pojazd %s (UID: %d) - (OwnerType: 2, Owner: %s (%d)", source:getData("globalName"), source:getData("memberID"), source:getData("charID"), vehInfo.name, vehInfo.ID, groupInfo.name, groupInfo.ID))
				--exports.titan_logs:commandLog(player, command, {...})
			end
			if isElement(vehInfo.veh) then
				if exports.titan_orgs:doesGroupHavePerm(group, "gps") then
					local r, g, b = exports.titan_orgs:getGroupColor(group)
					if not r then
						r = 255
						g = 0
						b = 0
					end
					vehInfo.veh:setData("hasGPS", true)
					vehInfo.veh:setData("gpsGroupID", group)
					vehInfo.veh:setData("hasGPSOn", true)
					vehInfo.veh:setData("gpsColor", {r, g, b})
				else
					vehInfo.veh:removeData("hasGPS")
					vehInfo.veh:removeData("gpsGroupID")
					vehInfo.veh:removeData("hasGPSOn")
					vehInfo.veh:removeData("gpsColor")
				end
			else
				exports.titan_noti:showBox(source, "Coś jest nie tak.")
			end
		end
	end
end
addEvent("onClientChooseGroup", true)
addEventHandler("onClientChooseGroup", root, onClientChooseGroup)