----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local hotelFunc = {}
local hotelData = {}
local hotelMembers = {}

function hotelFunc.loadMember(player)
	if type(hotelMembers[player]) ~= "table" then hotelMembers[player] = {} end
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _hotels_members WHERE memberID = ?", player:getData("charID"))
	for k, v in ipairs(query) do
		table.insert(hotelMembers[player], v)
	end
	outputDebugString(string.format("[HOTELS] Załadowano pokoje hotelowe gracza %s %s. (%d). | %d ms", player:getData("name"), player:getData("lastname"), #query, getTickCount() - time))
end
loadMemberHotels = hotelFunc.loadMember

function hotelFunc.loadHotels()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _hotels")
	for k, v in ipairs(query) do
		hotelData[v.interiorID] = v
		hotelMembers[v.ID] = {}
	end
	outputDebugString(string.format("[HOTELS] Załadowano hotele (%d). | %d ms", #query, getTickCount() - time))

	for k, v in ipairs(getElementsByType("player")) do if exports.titan_login:isLogged(v) then hotelFunc.loadMember(v) end end
end
addEventHandler("onResourceStart", resourceRoot, hotelFunc.loadHotels)

function hotelFunc.getPlayerHotels(player)
	if type(hotelMembers[player]) ~= "table" then return {} end
	return hotelMembers[player]
end
getPlayerHotels = hotelFunc.getPlayerHotels

function hotelFunc.getPlayerHotel(player, hotelID)
	if type(hotelMembers[player]) ~= "table" then return false end
	for k, v in ipairs(hotelMembers[player]) do
		if v.ID == hotelID then return v end
	end
	return false
end
getPlayerHotel = hotelFunc.getPlayerHotel

function hotelFunc.addNewHotel(interiorID, hotelPrice)
	local time = getTickCount()
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _hotels SET interiorID = ?, price = ?", interiorID, hotelType, hotelPrice)
	hotelData[interiorID] = 
	{
		ID = lastID,
		interiorID = interiorID,
		price = hotelPrice
	}
	
	outputChatBox(string.format("[HOTELS] Dodano nowy hotel. | %d ms",  getTickCount() - time))
end
addNewHotel = hotelFunc.addNewHotel

function hotelFunc.getHotelFromDimension(dimension)
	local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dimension)
	if not doorInfo then return false end
	if type(hotelData[doorInfo.ID]) ~= "table" then return false end
	return hotelData[doorInfo.ID]
end

function hotelFunc.getHotelFromID(ID)
	for k, v in pairs(hotelData) do
		if v and v.ID == ID then return v end
	end
	--if type(hotelData[hotelID]) ~= "table" then return false end
	--return hotelData[hotelID]
	return false
end
getHotelFromID = hotelFunc.getHotelFromID

function hotelFunc.command(player, command, option, value)
	option = string.lower(tostring(option))
	if not exports.titan_login:isLogged(player) then return end
	local dimension = player:getDimension() if dimension == 0 then return end
	local hotelInfo = hotelFunc.getHotelFromDimension(dimension)
	if hotelInfo then
		--return exports.titan_noti:showBox(player, "Nie znajdujesz się w hotelu.")
		if option == "wejdz" then
			local memberInfo = exports.titan_db:query("SELECT * FROM _hotels_members WHERE hotelID = ? AND memberID = ?", hotelInfo.ID, player:getData("charID"))
			if #memberInfo <= 0 then return exports.titan_noti:showBox(player, "Nie posiadasz pokoju w tym hotelu.") end
			memberInfo = memberInfo[1]
			local doorInfo = exports.titan_doors:getDoorInfo(memberInfo.doorID)
			if not doorInfo then return exports.titan_noti:showBox(player, "Twoje mieszkanie w hotelu jest uszkodzone. Napisz to administratorowi.") end

			setElementDimension(player, doorInfo.dimension)
			setElementInterior(player, hotelInfo.interior)
			setElementPosition(player, hotelInfo.posX, hotelInfo.posY, hotelInfo.posZ)
			setElementRotation(player, 0, 0, hotelInfo.posAngle)

			exports.titan_noti:showBox(player, string.format("Wszedłeś do swojego pokoju hotelowego. Pokój ma numer %d.", memberInfo.ID))
		elseif option == "numer" then
			if not tonumber(value) then return exports.titan_noti:showBox(player, "TIP: /hotel numer [numer pokoju]") end
			value = tonumber(value)

			local memberInfo = exports.titan_db:query("SELECT * FROM _hotels_members WHERE ID = ?", value)
			if #memberInfo <= 0 then return exports.titan_noti:showBox(player, "Pokój o takim numerze w tym hotelu nie istnieje.") end
			memberInfo = memberInfo[1]
			local doorInfo = exports.titan_doors:getDoorInfo(memberInfo.doorID)
			if not doorInfo then return exports.titan_noti:showBox(player, "To mieszkanie w hotelu jest uszkodzone. Napisz to administratorowi.") end

			setElementDimension(player, doorInfo.dimension)
			setElementInterior(player, hotelInfo.interior)
			setElementPosition(player, hotelInfo.posX, hotelInfo.posY, hotelInfo.posZ)
			setElementRotation(player, 0, 0, hotelInfo.posAngle)

			exports.titan_noti:showBox(player, string.format("Wszedłeś do pokoju hotelowego numer %d o nazwie \"%s\".", memberInfo.ID, doorInfo.name))	
		elseif option == "wynajmij" then
			local memberInfo = exports.titan_db:query("SELECT ID FROM _hotels_members WHERE hotelID = ? AND memberID = ?", hotelInfo.ID, player:getData("charID"))
			if #memberInfo > 0 then return exports.titan_noti:showBox(player, "W jednym hotelu można mieć maksymalnie jeden pokój.") end
			local doorID = exports.titan_doors:doorCreate(4, player:getData("charID"), string.format("Pokój hotelowy: %s %s", player:getData("name"), player:getData("lastname")), hotelInfo.ID)
			if not tonumber(doorID) then outputDebugString("[HOTELS] BŁĄD!!!") return exports.titan_noti:showBox(player, "Wystąpił błąd w momencie tworzenia pokoju.") end
			local query, rows, lastID = exports.titan_db:query("INSERT INTO _hotels_members SET hotelID = ?, memberID = ?, doorID = ?", hotelInfo.ID, player:getData("charID"), doorID)
			if type(hotelMembers[player]) ~= "table" then hotelMembers[player] = {} end
			table.insert(hotelMembers[player], 
			{
				ID = lastID,
				hotelID = hotelInfo.ID,
				memberID = player:getData("charID"),
				doorID = doorID
			})
			return exports.titan_noti:showBox(player, string.format("%s pokój. Opłata za noc wynosi $%d. Aby wejść do pokoju wpisz /pokoj wejdz.", getElementData(player, "sex") == 1 and "Wynająłeś" or "Wynajęłaś", hotelInfo.price))
		elseif option == "rozwiaz" then
			local memberInfo = exports.titan_db:query("SELECT * FROM _hotels_members WHERE hotelID = ? AND memberID = ?", hotelInfo.ID, player:getData("charID"))
			if #memberInfo <= 0 then return exports.titan_noti:showBox(player, "Nie posiadasz pokoju w tym hotelu.") end
			memberInfo = memberInfo[1]
			if type(hotelMembers[player]) == "table" then
				for k, v in ipairs(hotelMembers[player]) do
					if v.ID == memberInfo.ID then table.remove(hotelMembers[player], k) break end
				end
			end
			exports.titan_db:query_free("DELETE FROM _hotels_members WHERE ID = ?", memberInfo.ID)
			exports.titan_doors:doorDestroy(memberInfo.doorID)
			exports.titan_noti:showBox(player, "Nie wynajmujesz już pokoju w tym hotelu.")
		else return exports.titan_noti:showBox(player, "TIP: /hotel [wejdz, numer, wynajmij, rozwiaz]") end
	else
		local doorInfo = exports.titan_doors:getDoorInfoFromDimension(dimension)
		if doorInfo and tonumber(doorInfo.hotelData) and doorInfo.hotelData > 0 then
			local hotelInfo = hotelFunc.getHotelFromID(doorInfo.hotelData)
			if hotelInfo then
				local doorInfo2 = exports.titan_doors:getDoorInfo(hotelInfo.interiorID)
				if doorInfo2 then
					local doors = exports.titan_doors:getDoorsOnDimension(doorInfo2.dimension)
					if doors and #doors > 0 then
						doors = doors[1]
						local doors = exports.titan_doors:getPickupInfo(doors.ID)
						if doors then
							--outputChatBox(toJSON(doors))
							setElementDimension(player, doors.inDim)
							setElementInterior(player, doors.inInt)
							setElementPosition(player, doors.inX, doors.inY, doors.inZ)
							setElementRotation(player, 0, 0, doors.inAngle)
							return exports.titan_noti:showBox(player, "Wyszedłeś z pokoju hotelowego.")
						end
					end
				end
			end
		end
		return exports.titan_noti:showBox(player, "Nie znajdujesz się w hotelu.")
	end
end
addCommandHandler("hotel", hotelFunc.command, false, false)