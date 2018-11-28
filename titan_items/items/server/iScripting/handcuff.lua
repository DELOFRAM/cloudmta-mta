function cmdSkuj(player, command, arg1)
	if(not exports.titan_login:isLogged(player)) then return end
	if getElementData(player, "bwTime") then return end

	if(not tonumber(arg1)) then
		exports.titan_noti:showBox(player, "TIP: /skuj [ID gracza]")
		return
	end
	arg1 = tonumber(arg1)

	local target = exports.titan_login:getPlayerByID(arg1)
	if(not target) then
		exports.titan_noti:showBox(player, "Nie znaleziono gracza o danym ID, lub nie jest on zalogowany.")
		return
	end

	if(player == target) then
		exports.titan_noti:showBox(player, "Nie możesz skuć samego siebie.")
		return
	end
	
	if getElementData(target, "bwTime") then
		exports.titan_noti:showBox(player, "Nie możesz skuć gracza z BW.")
		return
	end
	
	if isPedInVehicle(player) then
		exports.titan_noti:showBox(player, "Nie możesz skuwać graczy będąc w pojeździe.")
		return
	end
	
	if(not doesPlayerHaveItemType(player, 18)) then
		exports.titan_noti:showBox(player, "Nie posiadasz kajdanek w swoim ekwipunku.")
		return
	end

	if(isElement(getElementData(player, "cuffedBy"))) then
		exports.titan_noti:showBox(player, "Jesteś skuty, nie możesz skuć kogoś innego.")
		return
	end

	if(isElement(getElementData(player, "cuffedPlayer"))) then
		exports.titan_noti:showBox(player, "Skułeś już jakiegoś gracza. Wpisz /rozkuj, aby Go odkuć.")
		return
	end
	local pX, pY, pZ = getElementPosition(player)
	local tX, tY, tZ = getElementPosition(target)

	local dist = getDistanceBetweenPoints3D(pX, pY, pZ, tX, tY, tZ)
	if(dist > 4.0) then
		exports.titan_noti:showBox(player, "Gracz jest za daleko.")
		return
	end

	if(isElement(getElementData(target, "cuffedBy"))) then
		exports.titan_noti:showBox(player, "Ten gracz jest już skuty przez kogoś innego.")
		return
	end

	if(isElement(getElementData(target, "cuffedPlayer"))) then
		exports.titan_noti:showBox(player, "Ten gracz już skuł kogoś innego.")
		return
	end

	if isPedInVehicle(target) then
		exports.titan_noti:showBox(player, "Ten gracz jest w pojeździe.")
		return
	end

	local name1 = exports.titan_chats:getPlayerICName(player)
	local name2 = exports.titan_chats:getPlayerICName(target)

	exports.titan_noti:showBox(target, string.format("Zostałeś skuty przez %s.", name1))
	exports.titan_noti:showBox(player, string.format("Skułeś %s.", name2))

	attachElements(target, player, 0, 1)
	setElementCollisionsEnabled(target, false)

	setElementData(player, "cuffedPlayer", target)
	setElementData(target, "cuffedBy", player)

	toggleAllControls(target, false, true, false)
	triggerClientEvent(target, "closeItemGUI", root)
end
addCommandHandler("skuj", cmdSkuj)

function cmdRozkuj(player)
	if(not exports.titan_login:isLogged(player)) then return end
	
	local target = getElementData(player, "cuffedPlayer")
	if(not isElement(target)) then
		exports.titan_noti:showBox(player, "Nikogo nie zakułeś w kajdanki.")
		setElementData(player, "cuffedPlayer", false)
		return
	end
	if(isElement(target)) then
		setElementData(target, "cuffedBy", false)
		detachElements(target, player)
		toggleAllControls(target, true)
	end
	setElementData(player, "cuffedPlayer", false)
	exports.titan_noti:showBox(player, "Rozkułeś gracza.")
	exports.titan_noti:showBox(target, "Zostałeś rozkuty.")
	setElementCollisionsEnabled(target, true)
	return
end
addCommandHandler("rozkuj", cmdRozkuj)
addCommandHandler("odkuj", cmdRozkuj)

addEventHandler("onPlayerQuit",getRootElement(),function()
cmdRozkuj(source)
end)