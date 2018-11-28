----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local newsData = {}

function startNewsWindow(player)
	triggerClientEvent(player, "newsData.showNews", player)
end

function cmdNews(player, command, ...)
	if(not exports.titan_login:isLogged(player)) then return end

	local playerDuty = exports.titan_orgs:getPlayerDuty(player)
	if(not playerDuty or not exports.titan_orgs:isGroup(playerDuty)) then
		exports.titan_noti:showBox(player, "Nie jesteś na służbie żadnej grupy.")
		return
	end

	if(not exports.titan_orgs:doesGroupHavePerm(playerDuty, "news")) then
		exports.titan_noti:showBox(player, "Grupa, na której służbie jesteś nie posiada dostępu do newsów.")
		return
	end

	if(not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "news")) then
		exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do używania newsów.")
		return
	end


	triggerClientEvent(player, "newsFunc.create", player)
end
addCommandHandler("news", cmdNews, false, false)

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
			startNewsWindow(v)
		end
	end
end
addEventHandler("onResourceStart", resourceRoot, function() setTimer(newsOnStart, 5000, 1) end)