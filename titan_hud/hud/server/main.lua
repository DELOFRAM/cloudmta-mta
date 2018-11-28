----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function showSGamingHUD(player)
	triggerClientEvent(player, "showSGamingHUD", player)
end

function hideSGamingHUD(player)
	triggerClientEvent(player, "hideSGamingHUD", player)
end

function cashClick(player)
	triggerClientEvent(player, "cashClick", player)
end

function showClientOffer(player, offerType, from, fromID, price, name)
	triggerClientEvent(player, "onClientGetOffer", player, offerType, from, fromID, price, name)
end

function hideClientOffer(player)
	triggerClientEvent(player, "onClientHideOffer", player)
end

function onClientOffer(player, state)
	if(state) then
		exports.titan_offers:acceptOffer(player)
	else
		exports.titan_offers:cancelOffer(player)
	end
end
addEvent("onClientOffer", true)
addEventHandler("onClientOffer", root, onClientOffer)

function getPlayerFriends()
	local query = exports.titan_db:query("SELECT m.members_display_name, m.member_id, m.game_inGame FROM ipb_profile_friends f LEFT JOIN ipb_members m ON (f.friends_friend_id = m.member_id) WHERE f.friends_member_id = ?", getElementData(source, "memberID"))
	triggerClientEvent(source, "hud.friends.c", source, query)
end
addEvent("hud.friends.s", true)
addEventHandler("hud.friends.s", root, getPlayerFriends)

function getPlayerItems()
local items = exports.titan_items:getPlayerItems(source)
if type(items) ~= "table" then items = 0 else items = #items end
triggerClientEvent(source, "hud.items.c", source, items)
end
addEvent("hud.items.s", true)
addEventHandler("hud.items.s", root, getPlayerItems)