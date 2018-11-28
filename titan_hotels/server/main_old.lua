----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 22:19:31
-- Ostatnio zmodyfikowano: 2016-01-09 23:12:04
----------------------------------------------------

local hotelFunc = {}
local hotelData = {}
local hotelIndex = {}

function hotelFunc.loadHotels()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM `_hotels`")
	for k, v in ipairs(query) do
		local index = hotelFunc.getFreeID()
		hotelData[index] = v
		hotelIndex["ID"..v.ID] = index
		hotelIndex["doorID"..v.interiorID] = index
	end
	outputDebugString(string.format("[HOTELS] Załadowano hotele (%d). | %d ms", #query, getTickCount() - time))
end
addEventHandler("onResourceStart", resourceRoot, hotelFunc.loadHotels)

function hotelFunc.getFreeID()
	local i = 1
	while true do
		if type(hotelData[i]) ~= "table" then return i end
		i = i + 1
	end
end

function hotelFunc.addNewHotel(interiorID, hotelPrice)
	local time = getTickCount()
	local res, rows, lastID = exports.titan_db:query(string.format("INSERT INTO `_hotels` SET `interiorID` = '%d', `price` = '%d'", interiorID, hotelType, hotelPrice))
	local index = hotelFunc.greFreeID()
	hotelData = {ID = lastID, interiorID = interiorID, type = hotelType, price = hotelPrice}
	hotelIndex["ID"..lastID] = index
	hotelIndex["doorID"..interiorID] = index
	outputChatBox(string.format("[HOTELS] Dodano nowy hotel. | %d ms",  getTickCount() - time))
end
addNewHotel = hotelFunc.addNewHotel

function hotelFunc.removeHotel(interiorID)
	
end

function hotelFunc.getHotelFromDimension(dimension)
	local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dimension)
	if not doorInfo then return false end
	
	if not tonumber(hotelIndex["doorID"..doorInfo.ID]) then return false end
	if type(hotelData[hotelIndex["doorID"..doorInfo.ID]]) ~= "table" then return false end
	return hotelData[hotelIndex["doorID"..doorInfo.ID]]
end

function hotelFunc.command(player, command, arg1, arg2)
	if not exports.titan_login:isLogged(player) then return end
	arg1 = string.lower(tostring(arg1))
	local dimension = player:getDimension()
	if dimension == 0 then return end
	local hotelInfo = hotelFunc.getHotelFromDimension(dimension)
	if not hotelInfo then
		if dimension > 10000 then
			local hotelID = dimension - 10000
			if hotelID > 0 then
				local hotelInfo = exports.titan_db:query(string.format("SELECT _hotels.* FROM `_hotels` LEFT JOIN `_hotels_members` ON (_hotels_members.hotelID = _hotels.ID) WHERE _hotels_members.ID = '%d' LIMIT 1", hotelID))
				if #hotelInfo <= 0 then return exports.titan_noti:showBox(player, "Nie jesteś w pokoju hotelowym.") end
				hotelInfo = hotelInfo[1]
				if arg1 == "wyjdz" then
					local doorInfo = exports.titan_doors:getFirstPickup(hotelInfo.interiorID)
					if not doorInfo then return exports.titan_noti:showBox(player, "Drzwi hotelowe są uszkodzone.") end

					player:setPosition(doorInfo.inX, doorInfo.inY, doorInfo.inZ)
					player:setRotation(0, 0, doorInfo.inAngle)
					player:setInterior(doorInfo.inInt)
					player:setDimension(doorInfo.inDim)
					return
				else
					return exports.titan_noti:showBox(player, "TIP: /hotel [wyjdz]")
				end
			end
		end
		return exports.titan_noti:showBox(player, "Nie jesteś w hotelu.")
	end

	if arg1 == "wejdz" then
		if not tonumber(arg2) then return exports.titan_noti:showBox(player, "TIP: /hotel wejdz [numer pokoju]") end
		arg2 = tonumber(arg2)
		local roomInfo = exports.titan_db:query(string.format("SELECT * FROM `_hotels_members` WHERE `ID` = '%d' LIMIT 1", arg2))
		if #roomInfo <= 0 then return exports.titan_noti:showBox(player, "Pokój o takim numerze nie istnieje") end
		roomInfo = roomInfo[1]
		if roomInfo.hotelID ~= hotelInfo.ID then return exports.titan_noti:showBox(player, "Taki pokój nie istnieje w tym hotelu.") end
		player:setPosition(hotelInfo.posX, hotelInfo.posY, hotelInfo.posZ)
		player:setRotation(0, 0, hotelInfo.posAngle)
		player:setInterior(hotelInfo.interior)
		player:setDimension(10000 + roomInfo.ID)
	elseif arg1 == "numer" then
		local memberInfo = exports.titan_db:query(string.format("SELECT `ID` FROM `_hotels_members` WHERE `hotelID` = '%d' AND `memberID` = '%d'", hotelInfo.ID, player:getData("charID")))
		if #memberInfo <= 0 then return exports.titan_noti:showBox(player, "Nie masz pokoju w tym hotelu. Aby wynająć pokój w tym hotelu wpisz komendę /hotel wynajmij.") end
		memberInfo = memberInfo[1]
		return exports.titan_noti:showBox(player, string.format("Twój pokój ma numer %d.", memberInfo.ID))
	elseif arg1 == "wynajmij" then
		local memberInfo = exports.titan_db:query(string.format("SELECT `ID` FROM `_hotels_members` WHERE `hotelID` = '%d' AND `memberID` = '%d'", hotelInfo.ID, player:getData("charID")))
		if #memberInfo > 0 then return exports.titan_noti:showBox(player, "W jednym hotelu można mieć maksymalnie jeden pokój.") end
		exports.titan_db:query_free("ALTER TABLE `_hotels_members` AUTO_INCREMENT = 1")
		local res, rows, lastID = exports.titan_db:query(string.format("INSERT INTO `_hotels_members` SET `hotelID` = '%d', `memberID` = '%d'", hotelInfo.ID, player:getData("charID")))
		return exports.titan_noti:showBox(player, string.format("Pomyślnie założyłeś pokój w hotelu. Ma on numer %d.", lastID))
	else
		return exports.titan_noti:showBox(player, "TIP: /hotel [wejdz, numer, wynajmij]")
	end
end
addCommandHandler("hotel", hotelFunc.command, false, false)