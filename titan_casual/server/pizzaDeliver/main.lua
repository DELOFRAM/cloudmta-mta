----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function pizzaDeliverOnVehicleEnter(player, vehicle)
	triggerClientEvent(player, "startPizzaDeliverJob", player)
end

function pizzaDeliverOnVehicleExit(player, vehicle)
	local vehInfo = exports.titan_vehicles:getVehInfo(vehicle:getData("vehID"))
	if vehInfo then
		exports.titan_noti:showBox(player, "Praca rozwoziciela pizzy została anulowana.")
		triggerClientEvent(player, "stopPizzaDeliverJob", player)
		exports.titan_vehicles:uSVehicle(vehInfo.ID)
		exports.titan_vehicles:sVehicle(vehInfo.ID)
		exports.titan_vehicles:fixBrokenVehicle(vehInfo.ID)
		exports.titan_vehicles:saveVeh(vehInfo.ID)
	end
end

function pizzaDeliverJobDone(player, vehicle)
	local jobDonePayout = 5
	local vehInfo = exports.titan_vehicles:getVehInfo(vehicle:getData("vehID"))
	if vehInfo then
		-- removePedFromVehicle(player)
		exports.titan_noti:showBox(player, "Praca zakonczona. Zarobiłeś $"..jobDonePayout.."!")
		exports.titan_cash:addPlayerCash(player, jobDonePayout)
		exports.titan_logs:playerLog(player, "cash", string.format("Otrzymano pieniądze od: (Praca dorywcza) Rozwoziciel pizzy (UID: 3), Kwota: $%d.", jobDonePayout))
		exports.titan_vehicles:uSVehicle(vehInfo.ID)
		exports.titan_vehicles:sVehicle(vehInfo.ID)
		exports.titan_vehicles:fixBrokenVehicle(vehInfo.ID)
		exports.titan_vehicles:saveVeh(vehInfo.ID)
	end
end
addEvent("pizzaDeliverJobDone", true)
addEventHandler("pizzaDeliverJobDone", root, pizzaDeliverJobDone)