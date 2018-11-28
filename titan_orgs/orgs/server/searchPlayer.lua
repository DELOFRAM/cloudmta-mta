------------------------------------------
--                                      --
-- cloudMTA  v1.0		                --
-- 2015								    --
--                                      --
------------------------------------------
-- Created: 2015-07-11 20:49:45

function getXYInFrontOfPlayer(player, distance)
	local x, y, z = getElementPosition(player)
	local _, _, rot = getElementRotation(player)
	x = x + math.sin(math.rad( -rot)) * distance
	y = y + math.cos(math.rad(-rot)) * distance
	return x, y, z
end

function cmdPrzeszukaj(player, command, typ, id)
	if(not exports.titan_login:isLogged(player)) then return end

	local pDuty = getPlayerDuty(player)
	if not pDuty then
		exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.")
		return
	end
	if not doesGroupHavePerm(pDuty, "search") then
		exports.titan_noti:showBox(player, "Twoja grupa nie posiada uprawnień do przeszukiwania graczy.")
		return
	end
	if not doesPlayerHavePerm(player, pDuty, "search") then
		exports.titan_noti:showBox(player, "Nie posiadasz nadanych uprawnień umożliwiających wywołanie komendy.")
		return
	end

	local typ = string.lower(tostring(typ))
	if typ == "gracz" then
		if not tonumber(id) then
			outputChatBox("TIP: /przeszukaj gracz [ID gracza]", player, 200, 200, 200)
			return
		end
		id = tonumber(id)
		local target = exports.titan_login:getPlayerByID(id)
		if not isElement(target) or not exports.titan_login:isLogged(target) then
			exports.titan_noti:showBox(player, "Nie znaleziono podanego gracza, lub nie jest on zalogowany.")
			return
		end
		-- if player == target then
			-- exports.titan_noti:showBox(player, "Nie możesz przeszukać samego siebie.")
			-- return
		-- end
		local pX, pY, pZ = getElementPosition(player)
		local tX, tY, tZ = getElementPosition(target)
		if player == target then
			exports.titan_noti:showBox(player, "Nie możesz przeszukać sam siebie.")
			return
		end

		if getDistanceBetweenPoints3D(pX, pY, pZ, tX, tY, tZ) > 1.8 and not (isPedInVehicle(player) and isPedInVehicle(target) and getPedOccupiedVehicle(player) == getPedOccupiedVehicle(target)) then
			exports.titan_noti:showBox(player, "Gracz jest za daleko.")
			return
		end
		if isPedInVehicle(target) then
			exports.titan_noti:showBox(player, "Gracz siedzi w pojeździe.")
			return
		end
		local playerItems = exports.titan_items:getPlayerItems(target)
		if not playerItems then playerItems = {} end
		exports.titan_chats:sendPlayerLocalMeRadius(player, "przeszukał "..exports.titan_chats:getPlayerICName(target)..".", 10.0)
		triggerClientEvent(player, "createSearchGUI", target, 1, playerItems, target)
		exports.titan_noti:showBox(target, string.format("Zostałeś przeszukany przez %s.", exports.titan_chats:getPlayerICName(player)))
	elseif typ == "pojazd" then
		if not isPedInVehicle(player) then
			exports.titan_noti:showBox(player, "Musisz siedzieć w pojeździe, aby użyć tej komendy.")
			return
		end
		local veh = getPedOccupiedVehicle(player)
		if not veh:getData("vehID") then
			exports.titan_noti:showBox(player, "Tego pojazdu nie możesz przeszukać.")
			return
		end

		local vehItems = exports.titan_items:getVehicleItems(veh:getData("vehID"))
		if not vehItems then vehItems = {} end
		exports.titan_chats:sendPlayerLocalMeRadius(player, "przeszukał pojazd.", 10.0)
		triggerClientEvent(player, "createSearchGUI", player, 2, vehItems)
	elseif typ == "budynek" then
		local doorID = getElementData(player, "nearestDoorID")
		local doorType = getElementData(player, "nearestDoorType")
		if(not tonumber(doorID)) then
			exports.titan_noti:showBox(player, "Nie stoisz przy żadnym budynku.")
			return
		end
		local Items = exports.titan_items:getItemsOwner(tonumber(doorID), 4)
		if not Items then Items = {} end
		exports.titan_chats:sendPlayerLocalMeRadius(player, "przeszukał budynek.", 10.0)
		triggerClientEvent(player, "createSearchGUI", player, 3, Items)	

	elseif typ == "smietnik" then
		local x, y, z = getXYInFrontOfPlayer(player, 1)
		local col = createColSphere( x, y, z, 3 )
		local with = getElementColShape( col )
		local objects = getElementsWithinColShape ( col, "object" )
		destroyElement( col )
		if #objects == 0 then return exports.titan_noti:showBox(player, "Nie jesteś pobliżu żadnego śmietnika.") end
		local trash = nil
		for i,v in ipairs(objects) do
			if trash == nil and v:getData("isTrash") then
				trash = v
			end
		end
		if trash == nil then return exports.titan_noti:showBox(player, "Nie jesteś pobliżu żadnego śmietnika.") end 

		local trashItems = exports.titan_items:getItemsOwner(trash:getData("trashID"), 5)
		if not trashItems then trashItems = {} end
		exports.titan_chats:sendPlayerLocalMeRadius(player, "przeszukał śmietnik.", 10.0)
		triggerClientEvent(player, "createSearchGUI", player, 4, trashItems)
	else
		outputChatBox("TIP: /przeszukaj [gracz, pojazd, budynek, smietnik]", player, 200, 200, 200)
	end
end
addCommandHandler("przeszukaj", cmdPrzeszukaj, false, false)


function onPlayerTakeItem(player, item)
	--if #itemTable == 0 then return end
	if isElement(player) then
		local pDuty = getPlayerDuty(source)
		if not pDuty then
			exports.titan_noti:showBox(source, "Nie jesteś na duty żadnej grupy.")
			return
		end
		if not doesGroupHavePerm(pDuty, "itemsteal") then
			exports.titan_noti:showBox(source, "Twoja grupa nie posiada uprawnień do zabierania przedmiotów.")
			return
		end
		if not doesPlayerHavePerm(source, pDuty, "itemsteal") then
			exports.titan_noti:showBox(source, "Nie posiadasz nadanych uprawnień umożliwiających wywołanie komendy.")
			return
		end
		
		local slot = exports.titan_items:getPlayerFreeSlotID(source)
		if not slot then
			exports.titan_noti:showBox(source, "Nie masz miejsca w ekwipunku.")
			return
		end
			
		local itemInfo = exports.titan_items:getItemInfo(item)
		if not itemInfo then
			exports.titan_noti:showBox(source, "Ten przedmiot nie istnieje.")
			return
		end
			
		if itemInfo.ownerType ~= 1 or itemInfo.owner ~= player:getData("charID") then
			exports.titan_noti:showBox(source, "Ten przedmiot nie należy do gracza.")
			return
		end
			
		if itemInfo.used == 1 then
			exports.titan_items:playerUseItem(player, item)
		end
			
			exports.titan_items:changeItemOwner(item, 1, source:getData("charID"))
			exports.titan_items:changeItemSlot(item, slot)

		exports.titan_chats:sendPlayerLocalMeRadius(source, string.format("%s %s %s.", getElementData(source, "sex") == 1 and "zabrał" or "zabrała", "przedmiot", exports.titan_chats:getPlayerICName(player)), 10.0)
		exports.titan_noti:showBox(player, string.format("%s %s Ci %s.", exports.titan_chats:getPlayerICName(source), getElementData(source, "sex") == 1 and "zabrał" or "zabrała", "przedmiot"))
		return
	else
		exports.titan_noti:showBox(source, "Gracz nie jest podłączony.")
		return
	end
end
addEvent("onPlayerTakeItem", true)
addEventHandler("onPlayerTakeItem", root, onPlayerTakeItem)