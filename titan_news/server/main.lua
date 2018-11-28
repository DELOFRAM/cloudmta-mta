----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local newsData = {}
newsData.showing = false

exports.titan_db:query_free("CREATE TABLE IF NOT EXISTS _ads (id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT, text TEXT CHARACTER SET utf8, reporter TEXT NOT NULL, time INTEGER NOT NULL)")

function cmdNews(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return end

	local playerDuty = exports.titan_orgs:getPlayerDuty(player)
	if(not playerDuty or not exports.titan_orgs:isGroup(playerDuty)) then return exports.titan_noti:showBox(player, "Nie jesteś na służbie żadnej grupy.") end

	if(not exports.titan_orgs:doesGroupHavePerm(playerDuty, "news")) then return exports.titan_noti:showBox(player, "Grupa, na której służbie jesteś nie posiada dostępu do newsów.") end
	
	if(not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "news")) then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do używania newsów.") end
	
	if isTimer(newsData.timer) then killTimer(newsData.timer) end
	local text = table.concat({...}, " ")
	if not text or string.len(text) <= 0 then return exports.titan_noti:showBox(player, "TIP: /news [tekst]") end
	
	newsData.text = text
	newsData.who = exports.titan_chats:getPlayerICName(player)
	
	if newsData.showing == false then
	showNews(true)
	end
	
	triggerClientEvent("newsData.addMessage", player, exports.titan_chats:getPlayerICName(player), text, 1)
	exports.titan_db:query_free("UPDATE _san_news SET content=?, reporterName=?, newsType=?, timestamp=? WHERE ID=1", text:gsub("#%x%x%x%x%x%x", ""), exports.titan_chats:getPlayerICName(player), 1, getRealTime(). timestamp)
	
	newsData.timer = setTimer(function()
	showNews(false)
	newsData.text = nil
	exports.titan_db:query_free("UPDATE _san_news SET content=?, reporterName=?, newsType=?, timestamp=? WHERE ID=1", "Radio nadaje aktualnie standardowy blok muzyczny.", "", 0, getRealTime(). timestamp)
	end, 15*60*1000, 1)
end
addCommandHandler("news", cmdNews, false, false)

function addInterviewMessage(player, text)
	if newsData.showing == false then
	showNews(true)
	end
	
	triggerClientEvent("newsData.addMessage", player, exports.titan_chats:getPlayerICName(player), text:gsub("#%x%x%x%x%x%x", ""), 3)
	exports.titan_db:query_free("UPDATE _san_news SET content=?, reporterName=?, newsType=?, timestamp=? WHERE ID=1", text:gsub("#%x%x%x%x%x%x", ""), exports.titan_chats:getPlayerICName(player), 3, getRealTime(). timestamp)
end

function showAd()
	local que = exports.titan_db:query("SELECT * FROM _ads ORDER BY id LIMIT 1")

	if #que == 0 then showNews(false) newsData.text = nil exports.titan_db:query_free("UPDATE _san_news SET content=?, reporterName=?, newsType=?, timestamp=? WHERE ID=1", "Radio nadaje aktualnie standardowy blok muzyczny.", "", 0, getRealTime(). timestamp) return end
	
	if newsData.showing == false then
	showNews(true)
	end
		
	triggerClientEvent("newsData.addMessage", getRootElement(), que[1]["reporter"]:gsub("#%x%x%x%x%x%x", ""), que[1]["text"]:gsub("#%x%x%x%x%x%x", ""), 2)
	exports.titan_db:query_free("UPDATE _san_news SET content=?, reporterName=?, newsType=?, timestamp=? WHERE ID=1", que[1]["text"]:gsub("#%x%x%x%x%x%x", ""), que[1]["reporter"]:gsub("#%x%x%x%x%x%x", ""), 2, getRealTime(). timestamp)
	
	newsData.timer = setTimer(function()
	exports.titan_db:query("DELETE FROM _ads WHERE id=?", que[1]["id"])
	showAd()
	end, que[1]["time"]*60*1000, 1)
end

function addNewsFromGUI(player, reporter, text)
	newsData.text = manageColors(text:gsub("#%x%x%x%x%x%x", ""))
	newsData.who = reporter
	triggerClientEvent("addNews", player, newsData.text, newsData.who, 1)
end
addEvent("addNewsFromGUI", true)
addEventHandler("addNewsFromGUI", root, addNewsFromGUI)

function manageColors(text)
	text = string.gsub(text, "{r}", "#FF0000")
	text = string.gsub(text, "{g}", "#00FF00")
	text = string.gsub(text, "{b}", "#0000FF")
	text = string.gsub(text, "{c}", "#000000")
	return text
end

function newsOnStart()
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			if(newsData.text) then
				showNews(true)
				triggerClientEvent(player, "newsData.addMessage", player, newsData.who, newsData.text)
			else
			showAd()
			end
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, function() setTimer(newsOnStart, 5000, 1) end)

function cancelInterview(player, com, typ, id)
local interview = {}
	if typ == "z" or typ == "zakoncz" then
		if com == "quit" then
			for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "interviewLSN") == true then table.insert(interview, v) end
			end
			
			if #interview <=1 then 
				for _, player in pairs(interview) do
					setElementData(v, "interviewLSN", nil)
				end
				
				showNews(false)
				newsData.text = nil
				interview = {}
				return
			end
			return
		else
			if not tonumber(id) then return exports.titan_noti:showBox(player, "TIP: /wywiad z(akoncz) [ID gracza]") end
			local target = exports.titan_login:getPlayerByID(tonumber(id))
			if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
			local groupInfo = exports.titan_orgs:getGroupInfo(exports.titan_orgs:getPlayerDuty(player))
			if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "interview") then return end
			if not exports.titan_orgs:doesPlayerHavePerm(player, groupInfo.ID, "interview") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z wywiadów!") end
			if not target then return exports.titan_noti:showBox(player, "Nie ma gracza o podanym ID") end
			if not getElementData(target, "interviewLSN") then return exports.titan_noti:showBox(player, "Gracz nie jest uczestnikiem wywiadu!") end
			setElementData(target, "interviewLSN", nil)
			exports.titan_noti:showBox(player, "Zakończyłeś wywiad z "..exports.titan_chats:getPlayerICName(target))
			exports.titan_noti:showBox(target, exports.titan_chats:getPlayerICName(player).." zakończył z Tobą wywiad!")
			
			for k,v in ipairs(getElementsByType("player")) do
			if getElementData(v, "interviewLSN") == true then table.insert(interview, v) end
			end
			
			if #interview <=1 then 
				for _, player in pairs(interview) do
					setElementData(v, "interviewLSN", nil)
				end
				
				showNews(false)
				newsData.text = nil
				interview = {}
				return
			end
		end
	end
end
addCommandHandler("wywiad", cancelInterview)

function showAds(player)
	if not exports.titan_orgs:getPlayerDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy!") end
	local groupInfo = exports.titan_orgs:getGroupInfo(exports.titan_orgs:getPlayerDuty(player))
	if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "interview") then return end
	if not exports.titan_orgs:doesPlayerHavePerm(player, groupInfo.ID, "interview") then return exports.titan_noti:showBox(player, "Nie masz uprawnień do korzystania z reklam!") end
	if isTimer(newsData.timer) then return end
	showAd()
end
addCommandHandler("reklamy", showAds)

function showNews(bool, player)
	if newsData.text == nil then bool = false end
	if bool == false then
	triggerClientEvent(player or getRootElement(), "newsData.showNews", player or getRootElement(), false)
	newsData.showing = false
	elseif bool == true then
	triggerClientEvent(player or getRootElement(), "newsData.showNews", player or getRootElement(), true)
	if newsData.text ~= nil then triggerClientEvent(player or getRootElement(), "newsData.addMessage", player or getRootElement(), newsData.who, newsData.text) end
	newsData.showing = true
	end
end

addEventHandler("onPlayerQuit", root, function()
	if getElementData(source, "interviewLSN") == true then
	cancelInterview(source, "quit", "z")
	end
end)