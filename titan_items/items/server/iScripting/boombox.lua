function onClientBoomboxTrigger(player, itemID, optionType)
	if(not exports.titan_login:isLogged(player)) then return end
	local itemInfo = getItemInfo(itemID)
	if(not itemInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono podanego przedmiotu.")
		return
	end

	if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.")
		return
	end

	if(optionType == 1) then
		if(isElement(itemInfo.boomboxObject)) then destroyElement(itemInfo.boomboxObject) end
		if(isTimer(itemInfo.timer)) then killTimer(itemInfo.timer) end
		exports.titan_noti:showBox(player, "Boombox został wyłączony pomyślnie.")
		itemInfo.inHand = false
		itemInfo.onGround = false
		itemInfo.used = 0
		setElementData(player, "boomboxID", false)
		removeElementData(player, "boomboxInHand")
		exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
		return
	elseif(optionType == 2) then
		if(isPedInVehicle(player)) then
			exports.titan_noti:showBox(player, "Nie możesz użyć boomboxa w aucie.")
			return
		end
		
		if(tonumber(getElementData(player, "boomboxID"))) then
			exports.titan_noti:showBox(player, "Używasz już innego boomboxa.")
			return
		end
		if(itemInfo.val1 == 0) then
			exports.titan_noti:showBox(player, "Brak płyty w odtwarzaczu.")
			return
		end

		local discItemInfo = getItemInfo(itemInfo.val1)
		if(not discItemInfo or discItemInfo.type ~= itemTypes.CD) then
			exports.titan_noti:showBox(player, "Włożona została niepoprawna płyta.")
			return
		end
		if(string.len(tostring(discItemInfo.val3)) < 4) then
			exports.titan_noti:showBox(player, "Płyta jest pusta.")
			return
		end
		if getUsedWeapons(player) > 0 then
			exports.titan_noti:showBox(player, "Nie możesz wziać boomboxa do ręki, gdy masz wyciągniętą broń.")
			return
		end
		if(isElement(itemInfo.boomboxObject)) then destroyElement(itemInfo.boomboxObject) end
		local x, y, z = getElementPosition(player)
		itemInfo.boomboxObject = createObject(2226, x, y, z)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
		setElementInterior(itemInfo.boomboxObject, int)
		setElementDimension(itemInfo.boomboxObject, dim)
		exports.titan_boneAttach:attachElementToBone(itemInfo.boomboxObject, player, 12, 0, 0, 0.4, 180, 0, 180)
		itemInfo.inHand = true
		itemInfo.used = 1
		setElementParent(itemInfo.boomboxObject, player)
		setElementData(player, "boomboxID", itemInfo.ID)
		setElementData(player, "boomboxInHand", true)
		triggerClientEvent("setMusicToElementModel", player, itemInfo.boomboxObject, discItemInfo.val3)
		exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
		return
	elseif(optionType == 3) then
		if(isPedInVehicle(player)) then
			exports.titan_noti:showBox(player, "Nie możesz użyć boomboxa w aucie.")
			return
		end

		if(tonumber(getElementData(player, "boomboxID"))) then
			exports.titan_noti:showBox(player, "Używasz już innego boomboxa.")
			return
		end

		if(itemInfo.val1 == 0) then
			exports.titan_noti:showBox(player, "Brak płyty w odtwarzaczu.")
			return
		end

		local discItemInfo = getItemInfo(itemInfo.val1)
		if(not discItemInfo or discItemInfo.type ~= itemTypes.CD) then
			exports.titan_noti:showBox(player, "Włożona została niepoprawna płyta.")
			return
		end
		if(string.len(tostring(discItemInfo.val3)) < 4) then
			exports.titan_noti:showBox(player, "Płyta jest pusta.")
			return
		end
		if(isElement(itemInfo.boomboxObject)) then destroyElement(itemInfo.boomboxObject) end
		local x, y, z = getElementPosition(player)
		local int = getElementInterior(player)
		local dim = getElementDimension(player)
		itemInfo.boomboxObject = createObject(2226, x, y, z - 0.95)
		setElementInterior(itemInfo.boomboxObject, int)
		setElementDimension(itemInfo.boomboxObject, dim)
		itemInfo.onGround = true
		itemInfo.used = 1
		setElementParent(itemInfo.boomboxObject, player)
		setElementData(player, "boomboxID", itemInfo.ID)
		exports.titan_noti:showBox(player, "Pozostawiłeś włączonego boomboxa na ziemi. Jeżeli oddalisz się od niego o 50 metrów - zostanie wyłączony.")
		exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
		itemInfo.timer = setTimer(
		function(player, itemID)
			if(isElement(player) and isElement(itemInfo.boomboxObject)) then
				local pX, pY, pZ = getElementPosition(player)
				local iX, iY, iZ = getElementPosition(itemInfo.boomboxObject)
				local dist = getDistanceBetweenPoints3D(pX, pY, pZ, iX, iY, iZ)
				if(dist > 50.0) then
					exports.titan_noti:showBox(player, "Oddaliłeś się 50 metrów od boomboxa. Został on wyłączony.")
					local itemInfo = getItemInfo(itemID)
					if itemInfo then
						if(isElement(itemInfo.boomboxObject)) then destroyElement(itemInfo.boomboxObject) end
						if(isTimer(itemInfo.timer)) then killTimer(itemInfo.timer) end
						itemInfo.inHand = false
						itemInfo.onGround = false
						itemInfo.used = 0
						exports.titan_db:query_free("UPDATE _items SET used = ?, lastUsed = UNIX_TIMESTAMP(), val2 = ?, lastUsedID = ? WHERE ID = ?", itemInfo.used, itemInfo.val2, getElementData(player, "charID"), itemInfo.ID)
						setElementData(player, "boomboxID", false)
						return
					end
				end
			else
				if(isTimer(itemInfo.timer)) then killTimer(itemInfo.timer) end
			end
		end, 1000, 0, player, itemInfo.ID)
		triggerClientEvent("setMusicToElementModel", player, itemInfo.boomboxObject, discItemInfo.val3)
		return
	end
end
addEvent("onClientBoomboxTrigger", true)
addEventHandler("onClientBoomboxTrigger", root, onClientBoomboxTrigger)

function verifyCDUrl(player, url)
	--fetchRemote(tostring(url), 1, afterVerifyCDUrl, "", false, player, url)
	afterVerifyCDUrl(0, 0, player, url)
end
addEvent("verifyCDUrl", true)
addEventHandler("verifyCDUrl", root, verifyCDUrl)

function afterVerifyCDUrl(data, error, player, url)
	if(tonumber(error) == 0) then
		triggerClientEvent(player, "onVerifySuccessful", player)
	else
		triggerClientEvent(player, "truncateCDGUIMenu", player)
		exports.titan_noti:showBox(player, "Weryfikacja wykazała błędy. Popraw podany link.")
		return
	end
end

function savePlayerCDLink(player, itemID, url)
	local itemInfo = getItemInfo(itemID)
	if(not itemInfo) then
		exports.titan_noti:showBox(player, "Przedmiot nie istnieje.")
		return
	end

	if(itemInfo.ownerType ~= 1 or itemInfo.owner ~= getElementData(player, "charID")) then
		exports.titan_noti:showBox(player, "Przedmiot nie należy do Ciebie.'")
		return
	end

	itemInfo.val3 = url
	exports.titan_db:query_free("UPDATE _items SET val3 = ? WHERE ID = ?", url, itemInfo.ID)
	exports.titan_noti:showBox(player, "Płyta została poprawnie wczytana.")
end
addEvent("savePlayerCDLink", true)
addEventHandler("savePlayerCDLink", root, savePlayerCDLink)