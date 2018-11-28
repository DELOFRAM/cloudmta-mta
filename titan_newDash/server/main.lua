----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local dashFunc = {}
dashFunc.tmpTable = {}
function dashFunc.hideHUD()
	exports.titan_hud:hideSGamingHUD(source)
	exports.titan_hud:toggleRadarVisible(source, false)
	source:setData("dashActive", true)
	if not source:getData("sampChat") then
		--showChat(source, false)
	end
end
addEvent("dashFunc.hideHUD", true)
addEventHandler("dashFunc.hideHUD", root, dashFunc.hideHUD)

function dashFunc.showHUD()
	exports.titan_hud:showSGamingHUD(source)
	exports.titan_hud:toggleRadarVisible(source, true)
	source:setData("dashActive", false)
	if not source:getData("sampChat") then
		--showChat(source, true)
	end
end
addEvent("dashFunc.showHUD", true)
addEventHandler("dashFunc.showHUD", root, dashFunc.showHUD)

function dashFunc.loadData()
	if exports.titan_login:isLogged(source) then
		local link = "https://cmta.pl/public/style_images/master/profile/default_large.png"
		local query = exports.titan_db:query("SELECT pp_photo_type, pp_thumb_photo, pp_gravatar FROM ipb_profile_portal WHERE pp_member_id = ?", getElementData(source, "memberID"))

		if query[1].pp_photo_type == "custom" then
			link = string.format("https://cmta.pl/uploads/%s", query[1].pp_thumb_photo)
		elseif query[1].pp_photo_type == "gravatar" then
			link = string.format("http://www.gravatar.com/avatar/%s?s=150", string.lower(md5(query[1].pp_gravatar)))
		end
		if string.find(link, ".gif") then name = "default_large" end
		--[[fetchRemote(link, function(data, errno, player, query)
			if errno == 0 then
			triggerClientEvent(player, "dashFunc.getData", player, exports.titan_vehicles:getVehiclesToDashboard(player), exports.titan_doors:getPlayerInteriors(player), exports.titan_orgs:getGroupsToDashboard(player), query.pp_photo_type == "custom" and tostring(getElementData(player, "memberID")) or query.pp_photo_type == "gravatar" and "grav_"..string.lower(md5(query.pp_gravatar)) or "default_large", data)
			end
		end, "", false, source, query[1])]]
	end
end
addEvent("dashFunc.loadData", true)
addEventHandler("dashFunc.loadData", root, dashFunc.loadData)

function dashFunc.loadFriends()
	local query = exports.titan_db:query("SELECT m.members_display_name, m.member_id, m.game_inGame FROM ipb_profile_friends f LEFT JOIN ipb_members m ON (f.friends_friend_id = m.member_id) WHERE f.friends_member_id = ?", source:getData("memberID"))

	for k, v in pairs(query) do
		local que = exports.titan_db:query("SELECT pp_photo_type, pp_thumb_photo, pp_gravatar FROM ipb_profile_portal WHERE pp_member_id = ?", v.member_id)
		if #que <= 0 or not que then
			link = "https://cmta.pl/public/style_images/master/profile/default_large.png"
			name = "default_large"
		elseif que[1].pp_photo_type == "custom" then
			link = string.format("http://cmta.pl/uploads/%s", que[1].pp_thumb_photo)
			name = tostring(v.member_id)
		elseif que[1].pp_photo_type == "gravatar" then
			link = string.format("http://www.gravatar.com/avatar/%s?s=150", string.lower(md5(que[1].pp_gravatar)))
			name = "grav_"..string.lower(md5(que[1].pp_gravatar))
		else
			link = "http://cmta.pl/public/style_images/master/profile/default_large.png"
			name = "default_large"
		end
		if string.find(link, ".gif") then name = "default_large" end
		--[[fetchRemote(link,
		function(data, errno, player, memberID, name)
			if errno == 0 then
			triggerClientEvent(player, "dashFunc.setImageTable", player, memberID, data, name)
			end
		end
		, "", false, source, v.member_id, name)]]
	end

	triggerClientEvent(source, "dashFunc.getFriendsData", source, query)
end
addEvent("dashFunc.loadFriends", true)
addEventHandler("dashFunc.loadFriends", root, dashFunc.loadFriends)

function dashFunc.loadLogs()
	local query = exports.titan_db:query("SELECT * FROM _login_logs WHERE charID = ? ORDER BY ID DESC LIMIT 8", source:getData("charID"))
	triggerClientEvent(source, "dashFunc.getLogsData", source, query)
end
addEvent("dashFunc.loadLogs", true)
addEventHandler("dashFunc.loadLogs", root, dashFunc.loadLogs)

function dashFunc.cmdWs(player)
	if not exports.titan_login:isLogged(player) then return end
	triggerClientEvent(player, "wsFunc.create", player)
end
addCommandHandler("ws", dashFunc.cmdWs, false, false)

function dashFunc.changeWalkingStyle(player, id)
	if not exports.titan_login:isLogged(player) then return end
	setPedWalkingStyle(player, id)
	exports.titan_db:query_free("UPDATE _characters SET walkingstyle = ? WHERE ID = ?", id, player:getData("charID"))
	player:setData("wakingStyle", id)
	exports.titan_noti:showBox(player, "Pomyślnie zmieniono styl chodzenia.")
	triggerClientEvent(player, "wsFunc.destroy", player)
end
addEvent("dashFunc.changeWalkingStyle", true)
addEventHandler("dashFunc.changeWalkingStyle", root, dashFunc.changeWalkingStyle)

function setSettings(player)
	triggerClientEvent(player, "dashFunc.setSettings", resourceRoot)
end
