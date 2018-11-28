----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local randomSpawnPoints = 
{
	[1] = {1726.61, -1862.35, 14, 307, 0, 0},
	[2] = {1716.39, -1863.15, 14, 288, 0, 0},
	[3] = {1761.03, -1861.75, 14, 330, 0, 0},
	[4] = {1788.80, -1863.02, 14, 20, 0, 0},
	[5] = {1795.34, -1862.62, 14, 20, 0, 0}
}

function onJoin()
	for k, v in ipairs(getElementsByType("radararea")) do
		setElementVisibleTo(v, source, false)
	end
end
addEventHandler("onPlayerJoin", root, onJoin)

function onConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber, playerVersionString)
	local query = exports.titan_db:query("SELECT b.*, m.members_display_name FROM _serialBans b LEFT JOIN ipb_members m ON (b.bannedBy = m.member_id) WHERE b.serial = ? LIMIT 1", string.upper(playerSerial))
	if #query > 0 then
		query = query[1]
		local time = getRealTime(tonumber(query.time) and query.time or 0)
		return cancelEvent(true, string.format("Twój serial został zbanowany przez administratora %s. Data: %0.2d.%0.2d.%0.4dr. Powód: %s", tostring(query.members_display_name), time.monthday, time.month + 1, time.year + 1900, tostring(query.reason)))
	end
end
addEventHandler("onPlayerConnect", root, onConnect)

function setInGameOnStart()
	for k, player in ipairs(getElementsByType("player")) do
		if isElement(player) then
			setElementPosition(player,0,0,0)
			setElementFrozen(player,true)
			for k, v in pairs(getAllElementData(player)) do
				player:removeData(k)
			end
		end
	end
	for k, player in ipairs(getElementsByType("player")) do
		triggerEvent("onPlayerJoin", player)
	end
	if exports.titan_db:query_free("UPDATE _characters SET inGame = '0'") then
		exports.titan_db:query_free("UPDATE ipb_members SET game_inGame = '0'")
		outputServerLog("[TITANIUM_ENGINE][LOGIN] Pomyslnie zmieniono inGame dla graczy na 0")
	else
		outputServerLog("[TITANIUM_ENGINE][LOGIN] Nie udalo sie zmienic inGame dla graczy na 0")
	end
	--exports.titan_db:query_free("UPDATE _users SET inGame = '0'")
end
addEventHandler("onResourceStart",resourceRoot, setInGameOnStart)


function savePlayersOnStop()
	local players = getElementsByType("player")
	for k, player in ipairs(players) do
		if isLogged(player) then
			savePlayer(player)
		end
	end
end

addEventHandler("onResourceStop",resourceRoot,savePlayersOnStop)

--/////////////////
--GUI FUNKCJE KUBAS
--/////////////////

function handlerLogin(user, pass)
	local login = exports.titan_db:escapeStrings(user)
	local res = checkPlayerLoginData(user, pass)
	if(not res) then
		exports.titan_noti:showBox(source, "Ta kombinacja nazwy użytkownika i hasła nie jest znana. Spróbuj ponownie.")
		triggerClientEvent(source, "turnOnSubmitClick", source)
		return
	end

	if res.game_inGame == 1 then
		exports.titan_noti:showBox(source, "To konto globalne jest już zalogowane na serwerze.")
		triggerClientEvent(source, "turnOnSubmitClick", source)
		return
	elseif res.game_ban > getRealTime().timestamp then
		exports.titan_noti:showBox(source, "To konto globalne jest zablokowane.")
		triggerClientEvent(source, "turnOnSubmitClick", source)
		return
	end

	local playerChars = getPlayerCharacters(res.member_id)
	if(not playerChars) then
		exports.titan_noti:showBox(source, "Nie znaleziono żadnej postaci stworzonej na tym koncie. Wróć na forum, stwórz postać i spróbuj jeszcze raz.")
		triggerClientEvent(source, "turnOnSubmitClick", source)
		return
	end
	--[[if res.game_premium ~= 0 then
	setElementData(source, "premium", true)
	else
	setElementData(source, "premium", false)
	end]]

	--local globalData = getPlayerGlobalData(res.ID)
	source:setData("loggedIn", 2)
	source:setData("memberID", res.member_id)
	source:setData("globalName", res.members_display_name)
	source:setData("adminLevel", res.game_adminLevel)
	source:setData("cloudPoints", res.game_cloudPoints)
	source:setData("ajTime", res.game_ajTime)
	source:setData("premium", res.game_premium > getRealTime().timestamp and true or false)
	setPlayerName(source, tostring(res.members_display_name))

	local aPerms = fromJSON(res.game_adminPerms)
	if type(aPerms) ~= "table" then
		aPerms = {}
	end
	source:setData("adminPerms", aPerms)

	--[[if res.game_newPlayer == 1 then
			exports.titan_noti:showBox(source, "Otrzymujesz Quiz z znajomości zasad Role Play aby go przejść musisz mieć minimum 50%.")
		triggerEvent( "Quizzes.selectForPlayer", source, 2 )
		triggerClientEvent(source,"turnOffLoginPanel", source, true)
		return
	end

	if res.game_newPlayer == -1 then
		source:setData("isNewPlayer", true)
	end]]--


	triggerClientEvent(source, "nextToChooseChar", source, playerChars)
	return
end
addEvent("handlerLogin", true)
addEventHandler("handlerLogin", root, handlerLogin)

function handlerSelectChar(charID)

	local res = getPlayerCharacter(getElementData(source, "memberID"), charID)
	if(not res) then
		outputChatBox("BŁĄD: Wystąpił nieznany błąd.", source)
		return
	end

	source:setData("charID", res.ID)
	source:setData("name", res.name)
	source:setData("lastname", res.lastname)
	source:setData("lastPos", {res.x, res.y, res.z, res.angle, res.dimension, res.interior})
	setElementData(source, "lastVisit", res.lastVisit)
	source:setData("skin", res.skin)
	source:setData("shortDNA", res.shortDNA)
	source:setData("defaultSkin", res.defaultSkin)
	source:setData("arrestTime", res.arrestTime)
	source:setData("arrestData", res.arrestData)
	source:setData("sex", res.sex)
	source:setData("DNA", res.DNA)
	source:setData("hungryLevel", res.hungrylevel)
	source:setData("hungryTime", 0)
	source:setData("depType", res.depType)
	source:setData("damageType", res.damagetype)
	source:setData("strength", res.strength)
	source:setData("condition", res.condicion)
	source:setData("tempOnlineTime", res.tempOnlineTime)

	source:setData("player:spawnData", {res.spawnType, res.spawnSubtype, res.spawnOwner})
	if(res.bwTime > 0) then
		source:setData("bwTime", res.bwTime)
	end
	if res.vehBlock < getRealTime().timestamp then
		res.vehBlock = 0
		exports.titan_db:query("UPDATE _characters SET vehBlock = '0' WHERE ID = ?", res.ID)
	end
	if res.runBlock > 0 then
		if res.runBlock < getRealTime().timestamp then
			res.runBlock = 0
			exports.titan_db:query("UPDATE _characters SET runBlock = '0' WHERE ID = ?", res.ID)
		end
	end
	source:setData("hp", res.hp)
	source:setData("money", res.money)
	source:setData("afkTime", res.afkTime)
	source:setData("onlineTime", res.onlineTime)
	source:setData("vehBlock", res.vehBlock)
	source:setData("runBlock", res.runBlock)
	source:setData("oocBlock", res.oocBlock)
	source:setData("charHistory", res.history)
	source:setData("vehLicense", res.vehLicense)
	source:setData("casual", res.casual)
	
	if res.walkingstyle == 0 and getElementData(source, "sex") == 1 then
		setElementData(source, "walkingStyle", 118)
	elseif res.walkingstyle == 0 and getElementData(source, "sex") == 2 then
		setElementData(source, "walkingStyle", 129)
	else
		source:setData("walkingStyle", res.walkingstyle)
	end
	
	source:setData("spawn", res.spawn)
	local y, m, d = get_date_parts(res.dob)
	source:setData("birthday", {year = y, month = m, day = d})
	local ssn = fromJSON(res.ssn)
	if type(ssn) ~= "table" then
		source:setData("ssn", false)
	else
		source:setData("ssn", ssn)
	end
	setElementData(source, "birthplace", res.pob)
	setElementData(source, "eyes", res.eyes)
	setElementData(source, "height", res.height)
	
	local query = exports.titan_db:query("SELECT * FROM _accounts WHERE ownerType = 1 AND owner = ? LIMIT 1", res.ID)
	if #query <= 0 then
		source:setData("accountID", res.accountID)
		source:setData("accountMoney", res.accountMoney)
	else
		source:setData("accountID", query[1].accountID)
		source:setData("accountMoney", query[1].balance)
	end
	
	setElementHealth(source,res.hp)
	exports.titan_db:query_free("UPDATE _characters SET inGame = 1, lastVisit = UNIX_TIMESTAMP() WHERE ID = ?", res.ID)
	exports.titan_db:query_free("UPDATE ipb_members SET game_inGame = 1 WHERE member_id = ?", res.memberID)
	exports.titan_logs:createLoginLog(source, res.ID)
	exports.titan_misc:loadPlayerBeforeSpawn(source)
	
	for _, plr in pairs(getElementsByType("player")) do
	triggerEvent("hud.friends.s", plr)
	end
	
	setPlayerName(source, string.format("%s_%s", res.name, res.lastname))
	triggerClientEvent(source, "confirmSelectChar", source)
end
addEvent("handlerSelectChar", true)
addEventHandler("handlerSelectChar", root, handlerSelectChar)

function spawnPlayerAfterAnimation()
	setPlayerNametagShowing(source, false)
	--[[local position = randomSpawn()
	if tonumber(source:getData("arrestTime")) > 0 and tonumber(source:getData("arrestData")) then
		local arrData = exports.titan_orgs:getArrestData(source:getData("arrestData"))
		if not arrData then
			source:setData("arrestTime", 0)
			source:setData("arrestData", 0)
			exports.titan_db:query_free("UPDATE _characters SET arrestTime = '0', arrestData = '0' WHERE ID = ?", source:getData("charID"))
		else
			position[1], position[2], position[3], position[4] = arrData.x, arrData.y, arrData.z, 0
			position[5] = arrData.dim
			position[6] = arrData.int
		end
	end
	if tonumber(getElementData(source, "ajTime")) and tonumber(getElementData(source, "ajTime")) > 0 then
		--outputChatBox(string.format("W AJOCIE NA %d", tonumber(getElementData(source, "ajTime"))))
		position[1], position[2], position[3] = 1174.3706,-1180.3267,87.0350
		position[4] = 0
		position[5] = math.random(5000, 10000)
		position[6] = 0
		source:setData("inAJ", true)
	end

	spawnPlayer(source, position[1], position[2], position[3] + 1.5, position[4], getElementData(source, "skin"))
	setElementFrozen(source, true)
	setPedWalkingStyle(source, source:getData("walkingStyle"))
	setPedStat(source, 69, 41)
	setPedStat(source, 70, 501)
	setPedStat(source, 71, 201)
	setPedStat(source, 72, 201)
	setPedStat(source, 73, 201)
	setPedStat(source, 74, 201)
	setPedStat(source, 75, 51)
	setPedStat(source, 76, 251)
	setPedStat(source, 77, 201)
	setPedStat(source, 78, 201)
	setPedStat(source, 79, 301)
	setCameraTarget(source, source)
	setTimer(fadeCamera, 1000, 1, source, true)
	exports.titan_noti:showBox(source, string.format("Wybrałeś postać %s %s.\n\nMiłej gry życzy ekipa cloudMTA!", getElementData(source, "name"), getElementData(source, "lastname")))
	showChat(source, true)
	toggleAllControls(source, true)
	--setPlayerHudComponentVisible(source, "radar", true)
	setElementDimension(source, position[5])
	setElementInterior(source, position[6])
	setTimer(setElementFrozen, 2000, 1, source, false)
	source:setData("loggedIn", 1)
	setTimer(function(player) exports.titan_hud:showSGamingHUD(player) end, 2500, 1, source)
	if(getElementData(source, "hp") > 0) then
		setElementHealth(source, getElementData(source, "hp"))
	end
	if(getElementData(source, "runBlock") > 0) then
		toggleControl(source, "jump", false)
		toggleControl(source, "sprint", false)
	end]]
	exports.titan_misc:playerSpawn(source)
	exports.titan_misc:loadPlayerAfterSpawn(source)
end
addEvent("spawnPlayerAfterAnimation", true)
addEventHandler("spawnPlayerAfterAnimation", root, spawnPlayerAfterAnimation)

function randomSpawn()
	local rand = math.random(1, #randomSpawnPoints)
	return randomSpawnPoints[rand]
end