----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function gType()
	triggerClientEvent(source, "gType_c", source, tostring(getGameType()))
end
addEvent("gType", true)
addEventHandler("gType", root, gType)

function getAdminRank(rankID)
	local tempTable =
	{
		[1] =
		{
			color = "3689FF",
			name = "Supporter"
		},
		[2] =
		{
			color = "CC6600",
			name = "Moderator"
		},
		[3] =
		{
			color = "6A4590",
			name = "Developer"
		},
		[4] =
		{
			color = "611616",
			name = "Administrator Techniczny"
		},
		[5] = 
		{
			color = "1F8B4C",
			name = "Administrator Rozgrywki"
		},
		[6] = 
		{
			color = "DC0000",
			name = "Główny Administrator"
		},
		[7] =
		{
			color = "11F2F2",
			name = "Beta Tester"
		}
	}
	if type(tempTable[rankID]) ~= "table" then return {color = "FFFFFF", name = "Niepoprawna Ranga"} end
	return tempTable[rankID]
end

function generateGunID() 
	while(true) do 
	local gunID = string.upper(string.random(7)) 
	local query = exports.titan_db:query("SELECT ID FROM _items WHERE val3 = ?", gunID) 
	if(#query <= 0) then return gunID end 
	end 
end 

function generateAccountID()
	while true do 
		local accID = string.random(8, "%d") 
		if tonumber(accID) then 
			local query = exports.titan_db:query("SELECT ID FROM _accounts WHERE accountID = ?", accID) 
			if(#query == 0) then return accID end 
		end 
	end
end

function generateCarPlate() 
	while true do 
	local carplate = string.upper(string.random(7)) 
	local query = exports.titan_db:query("SELECT ID FROM _vehicles WHERE carplate = ?", carplate) 
	if #query <= 0 then return carplate end 
	end 
end 

local randomSpawnPoints = 
{
	[1] = {1726.61, -1862.35, 14, 307, 0, 0},
	[2] = {1716.39, -1863.15, 14, 288, 0, 0},
	[3] = {1761.03, -1861.75, 14, 330, 0, 0},
	[4] = {1788.80, -1863.02, 14, 20, 0, 0},
	[5] = {1795.34, -1862.62, 14, 20, 0, 0}
}

local function main()
	 setGameType("CloudMTA 1.05 [16.10.2016]")
end
addEventHandler("onResourceStart", resourceRoot, main)

local Chars = {}
for Loop = 0, 255 do
	 Chars[Loop+1] = string.char(Loop)
end
local String = table.concat(Chars)

local Built = {['.'] = Chars}

local AddLookup = function(CharSet)
	local Substitute = string.gsub(String, '[^'..CharSet..']', '')
	local Lookup = {}
	for Loop = 1, string.len(Substitute) do
		Lookup[Loop] = string.sub(Substitute, Loop, Loop)
	end
	Built[CharSet] = Lookup
	return Lookup
end

function string.random(Length, CharSet)
	 if not CharSet then CharSet = '%l%d' end
	 if CharSet == '' then
		return ''
	 else
		local Result = {}
		local Lookup = Built[CharSet] or AddLookup(CharSet)
		local Range = table.getn(Lookup)

		for Loop = 1,Length do
		 Result[Loop] = Lookup[math.random(1, Range)]
		 if Loop == 1 and Result[Loop] == 0 then Loop = 1 end
		end

		return table.concat(Result)
	 end
end

function randomNumber()
	local number = math.floor(math.random(111111, 999999))
	return number
end

function generateGunID()
	while(true) do
		local gunID = string.upper(string.random(7))
		local query = exports.titan_db:query("SELECT ID FROM _items WHERE val3 = ?", gunID)
		if(#query <= 0) then return gunID end
	end
end

function generatePhoneNumber()
	while(true) do
		local number = randomNumber()
		local query = exports.titan_db:query("SELECT ID FROM _items WHERE val1 = ? AND type = ?", number, 8)
		if(#query <= 0) then return number end
	end
end

function generateSSN()
	while(true) do
		local accID = string.random(9, "%d")
		local query = exports.titan_db:query("SELECT ID FROM _characters WHERE ssn LIKE ?", "%"..accID.."%")
		if(#query <= 0) then return accID end
	end
end

function generateAccountID()
	while true do
		local accID = string.random(8, "%d")
		if tonumber(accID) then
			local query = exports.titan_db:query("SELECT ID FROM _accounts WHERE accountID = ?", accID)
			if(#query == 0) then return accID end
		end
	end
end

function generateCarPlate()
	while true do
		local carplate = string.upper(string.random(7))
		local query = exports.titan_db:query("SELECT ID FROM _vehicles WHERE carplate = ?", carplate)
		if #query <= 0 then return carplate end
	end
end

function addCloudPoints(player, points)
	if not exports.titan_login:isLogged(player) then return end
	local cpoints = player:getData("cloudPoints")
	if not tonumber(points) then cpoints = 0 end
	player:setData("cloudPoints", cpoints + points)
	exports.titan_db:query_free("UPDATE ipb_members SET game_cloudPoints = ? WHERE member_id = ?", cpoints + points, getElementData(player, "memberID"))
end

function randomSpawn()
	local rand = math.random(1, #randomSpawnPoints)
	return randomSpawnPoints[rand]
end

function findRotation( x1, y1, x2, y2 ) 
	local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
	return t < 0 and t + 360 or t
end

function getXYZInFrontOfPlayer(player, distance, isWypchnij)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	if isWypchnij then rot = rot - 90 end
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z
end

function cmdGetPos(player)
	outputChatBox("POS: "..tostring(player:getPosition()), player)
	outputChatBox("ROT: "..tostring(player:getRotation()), player)
	outputChatBox("INTERIOR: "..tostring(player:getInterior()), player)
	outputChatBox("DIMENSION: "..tostring(player:getDimension()), player)
end
addCommandHandler("getpos", cmdGetPos, false, false)

function playerSpawn(player)
	local spawns = 
	{
		aj =
		{
			pos = Vector3(1174.3706, -1180.3267, 87.0350),
			rot = 0,
			int = 0,
			dim = math.random(5000, 10000)
		},
		default = 
		{
			pos = Vector3(1726.61, -1862.35, 14),
			rot = 0,
			int = 0,
			dim = 0
		},
		
		--
		-- SOUTH CENTRAL --
		--

		-- Ganton --
		[4] = 
		{
			pos = Vector3(2263.422, -1757.656, 13.547),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Apple Street --
		[5] = 
		{
			pos = Vector3(2072.383, -1682.134, 13.547),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Idlewood
		[6] = 
		{
			pos = Vector3(1779.837, -1862.482, 13.576),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- El corona
		[7] =
		{
			pos = Vector3(1875.830, -2021.685, 13.539),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Willowfield
		[8] = 
		{
			pos = Vector3(2322.773, -1909.605, 13.617),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Seville
		[9] =
		{
			pos = Vector3(2744.896, -1249.852, 59.719),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Los Flores
		[10] = 
		{
			pos = Vector3(2458.657, -1370.455, 23.987),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Jefferson
		[11] = 
		{
			pos = Vector3(2219.357, -1376.282, 24),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Glen Park
		[12] = 
		{
			pos = Vector3(1979.174, -1267.378, 23.984),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Las Colinas
		[13] = 
		{
			pos = Vector3(2157.202, -1016.474, 62.873),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- East Beach
		[14] = 
		{
			pos = Vector3(2744.896, -1249.852, 59.719),
			rot = 0,
			int = 0,
			dim = 0
		},

		--
		-- CENTRUM --
		--

		-- Pershing Square
		[15] = 
		{
			pos = Vector3(1488.065, -1738.392, 13.547),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Verona Beach
		[16] = 
		{
			pos = Vector3(801.282, -1791.882, 13.211),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Rodeo
		[17] = 
		{
			pos = Vector3(498.480, -1442.842, 15.815),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Market
		[18] =
		{
			pos = Vector3(816.681, -1345.892, 13.528),
			rot = 0,
			int = 0,
			dim = 0
		},
		-- Temple
		[19] = 
		{
			pos = Vector3(1204.391, -1273.839, 13.547),
			rot = 0,
			int = 0,
			dim = 0
		}
	}

	player:setData("loggedIn", 1)

	--if not exports.titan_login:isLogged(player) then return kickPlayer(player) end
	local spawnData
	if type(spawns[player:getData("spawn")]) == "table" then
		spawnData = spawns[player:getData("spawn")] 
	else
		spawnData = spawns.default
	end
	
	local spawnData = player:getData("player:spawnData")
	if type(spawnData) == "table" then
		if spawnData[1] == 2 then
			local doorInfo = exports.titan_doors:getDoorInfo(spawnData[2])
			if doorInfo then
				if doorInfo.ownerType == 1 and doorInfo.owner == player:getData("charID") then
					local pickupInfo = exports.titan_doors:getPickupInfo(spawnData[3])
					if pickupInfo.parentID == doorInfo.ID then
						if pickupInfo.inX and pickupInfo.inY and pickupInfo.inZ and pickupInfo.inAngle and pickupInfo.inDim and pickupInfo.inInt then
							spawnData.pos = Vector3(pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ)
							spawnData.rot = pickupInfo.inAngle
							spawnData.dim = pickupInfo.inDim
							spawnData.int = pickupInfo.inInt
						end
					end
				end
			end
		elseif spawnData[1] == 3 then
			local hotelInfo = exports.titan_hotels:getHotelFromID(spawnData[2])
			if hotelInfo then
				local playerHotel = exports.titan_hotels:getPlayerHotel(player, spawnData[3])
				if playerHotel then
					local doorInfo = exports.titan_doors:getDoorInfo(playerHotel.doorID)
					if doorInfo then
						spawnData.pos = Vector3(hotelInfo.posX, hotelInfo.posY, hotelInfo.posZ)
						spawnData.rot = hotelInfo.posAngle
						spawnData.dim = doorInfo.dimension
						spawnData.int = hotelInfo.interior
					end
				end
			end
		elseif spawnData[1] == 4 then
			local groupInfo = exports.titan_orgs:getGroupInfo(spawnData[2])
			if groupInfo then
				if exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "spawn") then
					if exports.titan_orgs:doesPlayerHavePerm(player, groupInfo.ID, "spawn") then
						local pickupInfo = exports.titan_doors:getPickupInfo(spawnData[3])
						if pickupInfo then
							local doorInfo = exports.titan_doors:getDoorInfo(pickupInfo.parentID)
							if doorInfo then
								if doorInfo.ID == pickupInfo.parentID then
									if pickupInfo.inX and pickupInfo.inY and pickupInfo.inZ and pickupInfo.inAngle and pickupInfo.inDim and pickupInfo.inInt then
										spawnData.pos = Vector3(pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ)
										spawnData.rot = pickupInfo.inAngle
										spawnData.dim = pickupInfo.inDim
										spawnData.int = pickupInfo.inInt
									end
								end
							end
						end
					end
				end
			end
		end
	end

	if not spawnData.pos or not spawnData.rot or not spawnData.dim or not spawnData.int then
		if type(spawns[player:getData("spawn")]) == "table" then
			spawnData = spawns[player:getData("spawn")] 
		else
			spawnData = spawns.default
		end
	end

	--[[if getRealTime().timestamp - getElementData(player, "lastVisit") <= 600 then
		local spawnTable = getElementData(player, "lastPos")
		spawnData.pos = Vector3(spawnTable[1], spawnTable[2], spawnTable[3])
		spawnData.rot = spawnTable[4]
		spawnData.dim = spawnTable[5]
		spawnData.int = spawnTable[6]
	end]]
	
	local ajTime = player:getData("ajTime")
	if tonumber(ajTime) then
		ajTime = tonumber(ajTime)
		if ajTime > 5 then
			spawnData = spawns.aj
			player:setData("inAJ", true)
		else
			player:setData("ajTime", 0)
		end
	end
	
	if getElementData(player, "bwTime") then
		local spawnTable = getElementData(player, "lastPos")
		spawnData.pos = Vector3(spawnTable[1], spawnTable[2], spawnTable[3])
		spawnData.rot = spawnTable[4]
		spawnData.dim = spawnTable[5]
		spawnData.int = spawnTable[6]
	end
	
	
	player:spawn(spawnData.pos, spawnData.rot, player:getData("skin"), spawnData.int, spawnData.dim)
	player:setFrozen(true)
	player:setWalkingStyle(player:getData("walkingStyle") == 0 and 118 or player:getData("walkingStyle")) 
	if player:getWalkingStyle() == 0 or player:getWalkingStyle() == 54 then player:setWalkingStyle(118) end 
	player:setCameraTarget(player)
	setTimer(fadeCamera, 1000, 1, player, true)
	setTimer(setElementFrozen, 2000, 1, player, false)
	setTimer(function(player) exports.titan_hud:showSGamingHUD(player) end, 2500, 1, player)

	if not player:getData("sampChat") then
		showChat(player, true)
	end
	exports.titan_chats:sendPlayerChatMessage(player, string.format("Witaj, #922418%s #bbbdb5(GUID: %d)#ffffff. Zalogowano jako %s #bbbdb5(UID: %d)#ffffff.", player:getData("globalName"), player:getData("memberID"), exports.titan_chats:getPlayerICName(player), player:getData("charID")), 255, 255, 255, true) 
	exports.titan_chats:sendPlayerChatMessage(player, "Miłej gry życzy ekipa CloudMTA!", 119,140,56, false) 
	 
	if player:getData("premium") then 
		exports.titan_chats:sendPlayerChatMessage(player, "Posiadasz aktywne Konto Premium.", 255, 215, 0, false) 
	end 
	toggleAllControls(player, true)

	if player:getData("hp") > 0 then player:setHealth(player:getData("hp")) end
	if player:getData("runBlock") > 0 then
		toggleControl(player, "jump", false)
		toggleControl(player, "sprint", false)
		exports.titan_chats:sendPlayerChatMessage(player, "Posiadasz aktywną blokadę biegania i skakania.", 255, 0, 0, false) 
	end

	setPedStat(player, 69, 41)
	setPedStat(player, 70, 501)
	setPedStat(player, 71, 201)
	setPedStat(player, 72, 201)
	setPedStat(player, 73, 201)
	setPedStat(player, 74, 201)
	setPedStat(player, 75, 51)
	setPedStat(player, 76, 251)
	setPedStat(player, 77, 201)
	setPedStat(player, 78, 201)
	setPedStat(player, 79, 301)
	
	return true
end

function loadPlayerBeforeSpawn(player)
	exports.titan_orgs:loadGroupsForPlayer(player)
	exports.titan_hotels:loadMemberHotels(player)
	exports.titan_friends:playerFriends(player)

	exports.titan_newDash:setSettings(player)
end

function loadPlayerAfterSpawn(player)
	exports.titan_hud:toggleRadarVisible(player, true)
	exports.titan_news:showNews(true, player)
	exports.titan_items:synchronizeBoomboxesToPlayer(player)
	exports.titan_chats:turnOOCOn(player)
	exports.titan_reports:onPlayerJoinToServer(player)
end

function getPlayerByCharID(charID)
	for k, v in ipairs(getElementsByType("player")) do
		if v:getData("charID") == charID then return v end
	end
	return false
end

function getVehicleByVehID(vehID)
	for k, v in pairs(getElementsByType("vehicle")) do
		if getElementData(v, "vehID") then return v end
	end
	return false
end

function httpPenalty(playerID, penaltyType, penaltyTime, penaltyReason, penaltyAdminID, penaltyAdminName)
	playerID = tonumber(playerID)
	penaltyTime = tonumber(penaltyTime)
	penaltyType = tonumber(penaltyType)
	penaltyReason = tostring(penaltyReason)
	penaltyAdminID = tonumber(penaltyAdminID)
	penaltyAdminName = tostring(penaltyAdminName)
	local player = getPlayerByCharID(playerID)
	if not player then return false end
	local playerName = string.format("%s (%s)", exports.titan_chats:getPlayerICName(player), tostring(getElementData(player, "globalName")))
	penaltyReason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(penaltyReason))
	exports.titan_hud:showPenalty(penaltyAdminName, playerName, penaltyType, penaltyReason, penaltyTime*60)
	
	if penaltyType == 1 then -- kick
		outputConsole("------KICK------", player)
		outputConsole(string.format("| Nadano przez: %s", penaltyAdminName), player)
		outputConsole("| Powód:", player)
		outputConsole("| "..penaltyReason, player)
		kickPlayer(player, "Informacje w konsoli ([`] - tylda)")
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
	elseif penaltyType == 2 then -- ban
	
		if penaltyTime == 0 then
			czas = "Permanentnie"
			exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
			exports.titan_db:query_free("UPDATE ipb_members SET game_ban = ? WHERE member_id = ?", getRealTime().timestamp+86313600, getElementData(player, "memberID"))
		else
			czas = penaltyTime
			exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, getRealTime().timestamp+(penaltyTime*86400), penaltyReason)
			exports.titan_db:query_free("UPDATE ipb_members SET game_ban = ? WHERE member_id = ?", getRealTime().timestamp+(penaltyTime*86400), getElementData(player, "memberID"))
		end
		
		outputConsole("---------------------------", player)
		outputConsole(string.format("Banowany: %s", playerName), player)
		outputConsole(string.format("Banujący: %s", penaltyAdminName), player)
		outputConsole(string.format("Powód: %s", penaltyReason), player)
		outputConsole(string.format("Ilość dni: %s", czas), player)
		outputConsole("---------------------------", player)
		kickPlayer(player, string.format("Zostałeś zbanowany. Informacje w konsoli."))
	elseif penaltyType == 3 then -- warn
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
	elseif penaltyType == 4 then -- blokada postaci
		exports.titan_db:query_free("UPDATE _characters SET blocked = 1 WHERE ID = ?", player:getData("charID"))
		outputConsole("---------------------------", player)
		outputConsole(string.format("Blokowany: %s", playerName), player)
		outputConsole(string.format("Blokujący: %s", penaltyAdminName), player)
		outputConsole(string.format("Powód: %s", penaltyReason), player)
		outputConsole("---------------------------", player)
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
		kickPlayer(player, string.format("Twoja postać została zablokowana. Informacje w konsoli"))
	elseif penaltyType == 5 then -- aj
		if isPedInVehicle(player) then
			removePedFromVehicle(player)
		end
		outputChatBox("Admin umieścił Cię w Admin Jailu!", player, 255, 0, 0)
		setElementPosition(player, 1174.3706,-1180.3267,87.0350)
		setElementDimension(player, math.random(5000, 10000))
		setElementData(player, "ajTime", penaltyTime*60)
		setElementData(player, "inAJ", true)
		exports.titan_db:query_free("UPDATE ipb_members SET game_ajTime = ? WHERE member_id = ?", penaltyTime*60, getElementData(player, "memberID"))
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, penaltyTime*60, penaltyReason)
	elseif penaltyType == 6 then -- wypuszczenie z aj
		setElementData(player, "ajTime", 0)
		outputChatBox("Następnym razem pomyśl, zanim zrobisz jakaś głupotę!", player, 255, 0, 0)
		setElementPosition(player, 1811.20, -1868.06, 13.58)
		setElementInterior(player, 0)
		setElementDimension(player, 0)
		setElementData(player, "inAJ", false)
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
	elseif penaltyType == 7 then -- blokada pojazdów
		local timestamp = getRealTime().timestamp+penaltyTime*60
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, timestamp, penaltyReason)

		if isPedInVehicle(player) then
			if getPedOccupiedVehicleSeat(player) == 0 then
				removePedFromVehicle(player)
			end
		end
		outputChatBox("Otrzymałeś blokadę pojazdów!", player, 255, 0, 0)
		outputChatBox(string.format("Blokada kończy się za: %s minut.", tostring(penaltyTime)), player, 255, 0, 0)
		player:setData("vehBlock", timestamp)
		exports.titan_db:query_free("UPDATE _characters SET vehBlock = ? WHERE ID = ?", timestamp, player:getData("charID"))
	elseif penaltyType == 8 then -- oblokowanie pojazdów
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
		outputChatBox("Blokada pojazdów została zdjęta.", player, 255, 0, 0)
		player:setData("vehBlock", 0)
		exports.titan_db:query_free("UPDATE _characters SET vehBlock = 0 WHERE ID = ?", player:getData("charID"))
	elseif penaltyType == 9 then -- blokada OOC
		local timestamp = getRealTime().timestamp+penaltyTime*60
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, timestamp, penaltyReason)
		outputChatBox("Otrzymałeś blokadę czatu OOC!", player, 255, 0, 0)
		outputChatBox(string.format("Blokada kończy się za: %s minut.", tostring(penaltyTime)), player, 255, 0, 0)
		player:setData("oocBlock", timestamp)
		exports.titan_db:query_free("UPDATE _characters SET oocBlock = ? WHERE ID = ?", timestamp, player:getData("charID"))
	elseif penaltyType == 10 then -- odblokowanie OOC
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
		outputChatBox("Blokada czatu OOC została zdjęta.", player, 255, 0, 0)
		player:setData("oocBlock", 0)
		exports.titan_db:query_free("UPDATE _characters SET oocBlock = 0 WHERE ID = ?", player:getData("charID"))
	elseif penaltyType == 11 then -- blokada biegania
		local timestamp = getRealTime().timestamp+penaltyTime*60
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, timestamp, penaltyReason)
		outputChatBox("Otrzymałeś blokadę biegania!", player, 255, 0, 0)
		outputChatBox(string.format("Blokada kończy się za: %s minut.", tostring(penaltyTime)), player, 255, 0, 0)
		player:setData("runBlock", timestamp)
		exports.titan_db:query_free("UPDATE _characters SET runBlock = ? WHERE ID = ?", timestamp, player:getData("charID"))
		toggleControl(player, "sprint", false)
		toggleControl(player, "jump", false)
	elseif penaltyType == 12 then -- odblokowanie biegania
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, 0, penaltyReason)
		outputChatBox("Blokada biegania została zdjęta.", player, 255, 0, 0)
		player:setData("runBlock", 0)
		exports.titan_db:query_free("UPDATE _characters SET runBlock = 0 WHERE ID = ?", player:getData("charID"))
		toggleControl(player, "sprint", true)
		toggleControl(player, "jump", true)
	elseif penaltyType == 13 then -- cloudPoints
		exports.titan_misc:addCloudPoints(player, penaltyTime)
		exports.titan_admin:savePenalty(penaltyType, penaltyAdminID, player, penaltyTime, penaltyReason)
	else return false end
end

function httpAddMoney(playerID, moneyValue)
	local player = getPlayerByCharID(playerID)
	if not player then return false end
	exports.titan_cash:addPlayerCash(player, tonumber(moneyValue))
	exports.titan_noti:showBox(player, string.format("Otrzymałeś %d rekompensaty za usługę!", tonumber(moneyValue)))
end

function httpRemoveFromGroup(playerID, groupID)
	local player = getPlayerByCharID(playerID)
	if not player then return false end
	if not exports.titan_orgs:getGroupInfo(groupID) then return false end
	exports.titan_orgs:removePlayerFromGroup(player, groupID)
	local groupInfo = exports.titan_orgs:getGroupInfo(groupID)
	outputDebugString(string.format("[HTTP] Usuwam gracza %s z grupy %s", exports.titan_chats:getPlayerICName(player), groupInfo.name))
end

function httpReloadVehicle(vehID)
	local veh = getVehicleByVehID(vehID)
	if not veh then return false end
	if not exports.titan_vehicles:isVehicleEmpty(veh) then return false end
	exports.titan_vehicles:reloadVehicle(veh)
	outputDebugString("[HTTP] Przeładowuję pojazd o UID: "..vehID)
	return true
end

function cmdSpawn(player)
	if not exports.titan_login:isLogged(player) then return false end

	local spawnTable = 
	{
		[1] = {"Domyślny spawn", 1, 1, 1}
	}

	local playerInteriors = exports.titan_doors:getPlayerInteriors(player)
	if #playerInteriors > 0 then
		for k, v in ipairs(playerInteriors) do
			local doors = exports.titan_doors:getDoorsOnDimension(v.dimension)
			if type(doors) == "table" then
				for k1, v1 in ipairs(doors) do
					if v1.type == 2 then
						table.insert(spawnTable, {v1.name.." ("..v.name..")", 2, v.ID, v1.ID})
					end
				end
			end
		end
	end

	local playerHotels = exports.titan_hotels:getPlayerHotels(player)
	if #playerHotels > 0 then
		for k, v in ipairs(playerHotels) do
			local hotelInfo = exports.titan_hotels:getHotelFromID(v.hotelID)
			if type(hotelInfo) == "table" then
				local doorInfo = exports.titan_doors:getDoorInfo(hotelInfo.interiorID)
				if doorInfo then
					table.insert(spawnTable, {doorInfo.name, 3, hotelInfo.ID, v.ID})
				end
			end
		end
	end

	local playerGroups = exports.titan_orgs:getPlayerGroups(player)
	if playerGroups then
		for k, v in ipairs(playerGroups) do
			if exports.titan_orgs:doesGroupHavePerm(v.groupInfo.ID, "spawn") then
				if exports.titan_orgs:doesPlayerHavePerm(player, v.groupInfo.ID, "spawn") then
					local groupDoors = exports.titan_doors:getDoorsByOwner(2, v.groupInfo.ID)
					if groupDoors then
						for k1, v1 in ipairs(groupDoors) do
							local groupDoorPickups = exports.titan_doors:getDoorsOnDimension(v1.dimension)
							if type(groupDoorPickups) == "table" then
								for k2, v2 in ipairs(groupDoorPickups) do
									if v2.type == 2 then
										table.insert(spawnTable, {v2.name.." ("..v.groupInfo.name..")", 4, v.groupInfo.ID, v2.ID})
									end
								end
							end
						end
					end
				end
			end
		end
	end

	triggerClientEvent(player, "createSpawnGUI", player, spawnTable)
end
addCommandHandler("spawn", cmdSpawn, false, false)

function guiSetPlayerSpawn(player, val1, val2, val3)
	if exports.titan_login:isLogged(player) then
		exports.titan_db:query_free("UPDATE _characters SET spawnType = ?, spawnSubtype = ?, spawnOwner = ? WHERE ID = ?", val1, val2, val3, player:getData("charID"))
		exports.titan_noti:showBox(player, "Spawn postaci został zmieniony pomyślnie!")
		player:setData("player:spawnData", {val1, val2, val3})
	end
end
addEvent("guiSetPlayerSpawn", true)
addEventHandler("guiSetPlayerSpawn", root, guiSetPlayerSpawn)



function temp()
	local query = exports.titan_db:query("SELECT * FROM _items WHERE (type = 1 OR type = 5 OR type = 14) AND val3 = ''")
	for k, v in ipairs(query) do
		exports.titan_db:query_free("UPDATE _items SET val3 = ? WHERE ID = ?", generateGunID(), v.ID)
	end
end
temp()