----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local gFunc = {}

function gFunc.itemOffer(target, itemID, price)
	if doesPlayerHaveOffer(source) then return exports.titan_noti:showBox(source, "Złożyłeś już inną ofertę.") end
	if not isElement(target) or not exports.titan_login:isLogged(target) then return exports.titan_noti:showBox(source, "Nie znaleziono podanego gracza, lub nie jest on zalogowany.") end
	if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(source, "Gracz posiada już inną ofertę.") end
	if not doesPlayerHaveAppropriateDist(source, target) then return exports.titan_noti:showBox(source, "Gracz jest za daleko.") end
	local itemInfo = exports.titan_items:getItemInfo(itemID)
	if not itemInfo then return exports.titan_noti:showBox(source, "Nie znaleizono podanego przedmiotu.") end
	if itemInfo.ownerType ~= 1 or itemInfo.owner ~= source:getData("charID") then return exports.titan_noti:showBox(source, "Ten przedmiot nie należy do Ciebie.") end
	if itemInfo.used == 1 then return exports.titan_noti:showBox(source, "Przedmiot oferowany nie może być używany.") end
	createNewOffer(source, target, "item", {itemID = itemInfo.ID, price = price, name = itemInfo.name})
	local nickname = exports.titan_chats:getPlayerICName(target)
	return exports.titan_noti:showBox(source, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", nickname))
end
addEvent("gFunc.itemOffer", true)
addEventHandler("gFunc.itemOffer", root, gFunc.itemOffer)

function createRepairOffer(mechanic, target, component, price)
	if doesPlayerHaveOffer(mechanic) then return exports.titan_noti:showBox(mechanic, "Złożyłeś już inną ofertę.") end
	if not isElement(target) or not exports.titan_login:isLogged(target) then return exports.titan_noti:showBox(mechanic, "Nie znaleziono podanego gracza, lub nie jest on zalogowany.") end
	if doesPlayerHaveOffer(target) then return exports.titan_noti:showBox(mechanic, "Gracz posiada już inną ofertę.") end
	if not doesPlayerHaveAppropriateDist(mechanic, target) then return exports.titan_noti:showBox(mechanic, "Gracz jest za daleko.") end

	local playerVehicle = getPedOccupiedVehicle(target)
	if not isElement(playerVehicle) then return exports.titan_noti:showBox(mechanic, "Gracz musi siedzieć w pojeździe.") end
	local vehInfo = exports.titan_vehicles:getVehInfo(playerVehicle:getData("vehID"))
	if not vehInfo then return exports.titan_noti:showBox(mechanic, "Tego pojazdu nie znaleziono w systemie, nie można go naprawić.") end

	createNewOffer(mechanic, target, "fix", {component = component, price = 0, name = "Naprawa komponentu: "..component, price = price})
	local nickname = exports.titan_chats:getPlayerICName(target)
	return exports.titan_noti:showBox(mechanic, string.format("Złożyłeś ofertę graczowi %s. Poczekaj na odpowiedź.", nickname))
end