----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local carSalonFunc = {}

exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_carsalon_cat` ( `ID` int NOT NULL AUTO_INCREMENT PRIMARY KEY, `name` varchar(255) COLLATE 'utf8_general_ci' NOT NULL, `pedID` int NOT NULL) ENGINE='InnoDB' COLLATE 'utf8_general_ci';")
exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS `_carsalon_cars` (`ID` int NOT NULL AUTO_INCREMENT PRIMARY KEY, `catID` int NOT NULL, `name` varchar(255) NOT NULL, `model` int NOT NULL, `price` int NOT NULL) ENGINE='InnoDB' COLLATE 'utf8_general_ci';")

function carSalonFunc.cmd(player)
	if not exports.titan_login:isLogged(player) then return end
	local pedID = exports.titan_peds:isPedNear(player, "salonsamochodowy", 5.0)
	if not pedID then return exports.titan_noti:showBox(player, "Nie znajdujesz się obok przedstawiciela salonu samochodowego!") end
	local cats = exports.titan_db:query("SELECT * FROM _carsalon_cat WHERE pedID = ?", pedID)
	if #cats <= 0 then return exports.titan_noti:showBox(player, "Przedstawiciel salonu samochodowego nie ma do zaoferowania żadnego pojazdu!") end
	for k, v in ipairs(cats) do
		local vehs = exports.titan_db:query("SELECT * FROM _carsalon_cars WHERE catID = ? ORDER BY name ASC", v.ID)
		if #vehs <= 0 then v.vehicles = {}
		else v.vehicles = vehs end
	end
	triggerClientEvent(player, "carSalonFunc.guiCreate", resourceRoot, cats)
	exports.titan_noti:showBox(player, "Aby zamówić dany pojazd należy nacisnąć na jego nazwę dwukrotnie.")
end
addCommandHandler("zamowpojazd", carSalonFunc.cmd, false, false)

function carSalonFunc.responsePlayer(player, vehicleID)
	if not exports.titan_login:isLogged(player) then return false end
	local pedID = exports.titan_peds:isPedNear(player, "salonsamochodowy", 5.0)
	if not pedID then return exports.titan_noti:showBox(player, "Nie znajdujesz się obok przedstawiciela salonu samochodowego!") end

	local vehInfo = exports.titan_db:query("SELECT * FROM _carsalon_cars WHERE ID = ?", vehicleID)
	if #vehInfo == 0 then return exports.titan_noti:showBox(player, "Nie znaleziono informacji o danym pojeździe.") end
	vehInfo = vehInfo[1]

	if exports.titan_cash:getPlayerCash(player) < vehInfo.price then return exports.titan_noti:showBox(player, "Nie posiadasz wystarczającej ilości gotówki.") end
	if not exports.titan_offers:createNewOffer("Dealer pojazdów", player, "carsalon", {price = vehInfo.price, name = vehInfo.name, model = vehInfo.model}) then return exports.titan_noti:showBox(player, "Posiadasz już inną aktywną ofertę.") end
end
addEvent("carSalonFunc.responsePlayer", true)
addEventHandler("carSalonFunc.responsePlayer", root, carSalonFunc.responsePlayer)