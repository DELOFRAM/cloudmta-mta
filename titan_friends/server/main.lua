----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function playerFriends(player)
	local friendsList = exports.titan_db:query("SELECT friends_friend_id FROM ipb_profile_friends WHERE friends_member_id = ?", player:getData("memberID"))
	if #friendsList <= 0 then return end
	local link = "http://cmta.pl/public/style_images/master/profile/default_large.png"
	local query = exports.titan_db:query("SELECT pp_photo_type, pp_thumb_photo, pp_gravatar FROM ipb_profile_portal WHERE pp_member_id = ?", player:getData("memberID"))
	if #query == 1 then
		query = query[1]

		if query.pp_photo_type == "custom" then
			link = string.format("https://cmta.pl/uploads/%s", query.pp_thumb_photo)
		elseif query.pp_photo_type == "gravatar" then
			link = string.format("http://www.gravatar.com/avatar/%s?s=150", string.lower(md5(query.pp_gravatar)))
		end
	end
	--fetchRemote(link, onFetchRemote, "", false, player, friendsList)
end

function onFetchRemote(responseData, errno, player, friendsList)
	if errno == 0 then
		if isElement(player) then
			local globalName = player:getData("globalName") or "?"
			for k, v in ipairs(friendsList) do
				local playerElement = getPlayerByGlobalID(v.friends_friend_id)
				if isElement(playerElement) then
					exports.titan_noti:showFriend(playerElement, responseData, string.format("Znajomy %s właśnie wszedł do gry!", globalName))
				end
			end
		end
	end
end

function getPlayerByGlobalID(globalID)
	for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
			if tonumber(v:getData("memberID")) == globalID then
				return v
			end
		end
	end
end

