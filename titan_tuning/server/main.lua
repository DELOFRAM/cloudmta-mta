Action = {}


function removeVehicleComponentMain(player, sucess)
	if type(Action[player]) == "table" then
	local vehicle = Action[player].data.vehicle
	local item = Action[player].data.slot
	local target = Action[player].data.target
	local price = Action[player].data.price
	local sucess, error = removeVehicleComponent(vehicle, item.type, item.id, true)
		if sucess then
			setElementData(target,"money", getElementData(target,"money") - price)		
			setElementData(player,"money", getElementData(player,"money") + price)
			exports.titan_noti:showBox(player,"Pomyślnie zdemontowano część w pojeździe.")
			exports.titan_noti:showBox(target,"Pomyślnie zdemontowano część w pojeździe.")
			Action[player] = false
		elseif not sucess and error == 0 then
			exports.titan_noti:showBox(player,"Nieznany model części.")
			Action[player] = false
		elseif not sucess and error == 2 then
			Action[player] = false
			exports.titan_noti:showBox(player,"Wystąpił błąd powiadom o tym administratora.")
		elseif type(Action[player]) == "table" and not sucess then
			exports.titan_noti:showBox(player,"Oferta została przerwana.")
			Action[player] = false
		end
		elseif type(Action[player]) == "table" and not sucess then
			exports.titan_noti:showBox(player,"Oferta została przerwana.")
			Action[player] = false	
	end
end
addEvent("removeVehicleComponentMain", true)
addEventHandler("removeVehicleComponentMain", root, removeVehicleComponentMain)

function setVehicleComponentMain(player, sucess)
	if type(Action[player]) == "table" then
		local vehicle = Action[player].data.vehicle
		local item = Action[player].data.item
		local target = Action[player].data.target
		local price = Action[player].data.price
		local sucess, error = setVehicleComponent(vehicle, item.val1, item.val2, player, true)
		if sucess then
			setElementData(target,"money", getElementData(target,"money") - price)		
			setElementData(player,"money", getElementData(player,"money") + price)
			exports.titan_noti:showBox(player,"Pomyślnie zamontowałeś część w pojeździe.")
			exports.titan_noti:showBox(target,"Pomyślnie zamontowano część w pojeździe.")

			exports.titan_items:removeItem(tonumber(item.ID), true)
			triggerEvent( "updatePlayerEquip", player, player )

			Action[player] = false
		elseif not sucess and error == 0 then
			Action[player] = false
			exports.titan_noti:showBox(player,"Nieznany model części.")
		elseif not sucess and error == 1 then
			Action[player] = false
			exports.titan_noti:showBox(player,"Pojazd posiada już zamontowaną cześć tego typu.")
		elseif not sucess and error == 2 then
			Action[player] = false
			exports.titan_noti:showBox(player,"Wystąpił błąd powiadom o tym administratora.")
		end
		elseif type(Action[player]) == "table" and not sucess then
			exports.titan_noti:showBox(player,"Oferta została przerwana.")
			Action[player] = false
	end
end
addEvent("setVehicleComponentMain", true)
addEventHandler("setVehicleComponentMain", root, setVehicleComponentMain)


function UninstallationVehicleComponent(player, target, price, value)
	if type(Action[player]) == "table" and Action[player].type == "installing" then exports.titan_noti:showBox(player, "Prowadzisz aktualnie montaż!") return false end
	if type(Action[player]) == "table" and Action[player].type == "uninstalling" then exports.titan_noti:showBox(player, "Prowadzisz aktualnie demontaż!") return false end
	local slot = getComponentDataVehicle( getPedOccupiedVehicle( target ), value )
	if not slot then
		exports.titan_noti:showBox(player,"Pojazd nie posiada żadnego przedmiotu na wybranym slocie!")	
		return false
	end 

	
	Action[player] = {}
	Action[player].type = "uninstalling"
	Action[player].data = {target=target, vehicle=getPedOccupiedVehicle( target ), price=price, slot=slot}
	Action[player].data.admin = exports.titan_admin:doesPlayerHaveAdminDuty(player)
	triggerClientEvent(player,"ProgressEventComponent", player, player, Action[player].data, math.random(1,5), "remove" )
	return true
end

function installationVehicleComponent(player, target, price, itemUID)
	if type(Action[player]) == "table" and Action[player].type == "installing" then exports.titan_noti:showBox(player, "Prowadzisz aktualnie montaż!") return false end
	if type(Action[player]) == "table" and Action[player].type == "uninstalling" then exports.titan_noti:showBox(player, "Prowadzisz aktualnie demontaż!") return false end
		part = getPlayerItemTuning(player, itemUID)

		if part == nil then
			 exports.titan_noti:showBox(player,"Tego przedmiotu nie można zamontować w pojeździe!")	
			 return	false
		elseif not( part ) then
			 exports.titan_noti:showBox(player,"Nie posiadasz przy sobie przedmiotu o podanym UID!")
			 return false
		end

		if not getComponentData(part.val1, part.val2) then
			exports.titan_noti:showBox(player,"Ten przedmiot nie posiada żadnej specyfikacji!")
			return false
		end

		Action[player] = {}
		Action[player].type = "installing"
		Action[player].data = {target=target, vehicle=getPedOccupiedVehicle( target ), price=price, item=part}
		Action[player].data.admin = exports.titan_admin:doesPlayerHaveAdminDuty(player)
		triggerClientEvent(player,"ProgressEventComponent", player, player, Action[player].data, math.random(1,5), "set" )
		return true
end