----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

--[[
|-------------|
|-- FUNKCJE --|
|-------------|
]]--

function playerEntryInDoor(player, doorID, entryType, isVeh)
	if not isVeh then
		if(exports.titan_login:isLogged(player)) then
			if(not getElementData(player, "enteringDoor")) then
				if getElementData(player, "arrestTime") > 0 then
					exports.titan_noti:showBox(player, "Będąc aresztowanym nie możesz opuszczać budynku.")
					return
				end
				if exports.titan_bw:doesPlayerHaveBW(player) then
					return exports.titan_noti:showBox(player, "Nie możesz przechodzić przez drzwi w czasie BW.")
				end
				local pickupInfo = getPickupInfo(doorID)
				if(not pickupInfo) then return false end
				if(pickupInfo.locked == 1) then 
					exports.titan_noti:showBox(player, "Drzwi są zamknięte.")
					return
				end
				if(entryType == 1) then
					local pX, pY, pZ = getElementPosition(player)
					if(getDistanceBetweenPoints3D(pX, pY, pZ, pickupInfo.outX, pickupInfo.outY, pickupInfo.outZ) < 2) then
						local newX, newY, newZ, newAngle = pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ, pickupInfo.inAngle
						local newDim, newInt = pickupInfo.inDim, pickupInfo.inInt

						if(newX == 0 and newY == 0 and newZ == 0) then
							exports.titan_noti:showBox(player, "Drzwi nie mają przypisanego wejścia.")
							return
						end

						setElementData(player, "enteringDoor", true)
						fadeCamera(player, false)
						exports.titan_hud:toggleRadarVisible(player, false)

						setTimer(
							function(player, newX, newY, newZ, newDim, newInt, newAngle)
								setElementPosition(player, newX, newY, newZ)
								setElementRotation(player, 0, 0, newAngle)
								setElementDimension(player, newDim)
								setElementInterior(player, newInt)
								setElementFrozen(player, true)

								local cuffedPlayer = getElementData(player, "cuffedPlayer")
								if(isElement(cuffedPlayer)) then
									setElementDimension(cuffedPlayer, newDim)
									setElementInterior(cuffedPlayer, newInt)
									detachElements(cuffedPlayer, player)
									attachElements(cuffedPlayer, player, 0, 1)
									--setPlayerHudComponentVisible(cuffedPlayer, "radar", false)
									exports.titan_hud:toggleRadarVisible(cuffedPlayer, false)
								end
								
								setTimer(
									function(player)
										--setPlayerHudComponentVisible(player, "radar", false)
										fadeCamera(player, true)
										setCameraTarget(player, player)
										setElementData(player, "nearestDoorID", doorID)
										setElementData(player, "nearestDoorType", 2)
										setTimer(setElementData, 1000, 1, player, "enteringDoor", false)
										setTimer(setElementFrozen, 500, 1, player, false)
									end, 500, 1, player)

							end, 1000, 1, player, newX, newY, newZ, newDim, newInt, newAngle)
					end

				elseif(entryType == 2) then
					local pX, pY, pZ = getElementPosition(player)
					if(getDistanceBetweenPoints3D(pX, pY, pZ, pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ) < 2) then
						local newX, newY, newZ, newAngle = pickupInfo.outX, pickupInfo.outY, pickupInfo.outZ, pickupInfo.outAngle
						local newDim, newInt = pickupInfo.outDim, pickupInfo.outInt

						if(newX == 0 and newY == 0 and newZ == 0) then
							exports.titan_noti:showBox(player, "Drzwi nie mają przypisanego wyjścia.")
							return
						end

						setElementData(player, "enteringDoor", true)
						fadeCamera(player, false)

						setTimer(
							function(player, newX, newY, newZ, newDim, newInt, newAngle)
								setElementPosition(player, newX, newY, newZ)
								setElementRotation(player, 0, 0, newAngle)
								setElementDimension(player, newDim)
								setElementInterior(player, newInt)
								setElementFrozen(player, true)

								local cuffedPlayer = getElementData(player, "cuffedPlayer")
								if(isElement(cuffedPlayer)) then
									setElementDimension(cuffedPlayer, newDim)
									setElementInterior(cuffedPlayer, newInt)
									detachElements(cuffedPlayer, player)
									attachElements(cuffedPlayer, player, 0, 1)
									--setPlayerHudComponentVisible(cuffedPlayer, "radar", true)
									exports.titan_hud:toggleRadarVisible(cuffedPlayer, true)
								end
								

								setTimer(
									function(player)
										--setPlayerHudComponentVisible(player, "radar", true)
										exports.titan_hud:toggleRadarVisible(player, true)
										fadeCamera(player, true)
										setElementData(player, "enteringDoor", false)
										setCameraTarget(player, player)
										setElementData(player, "nearestDoorID", doorID)
										setElementData(player, "nearestDoorType", 1)
										triggerClientEvent(player, "giveDataFromServerAboutDoorInfo", player, {toggle = true, doorName = pickupInfo.name, doorLocked = pickupInfo.locked == 1 and true or false})
										setTimer(setElementFrozen, 500, 1, player, false)
									end, 500, 1, player)

							end, 1000, 1, player, newX, newY, newZ, newDim, newInt, newAngle)
					end
				end
			end
		end
	else
		-- JEŚLI W POJEŹDZIE
		if exports.titan_login:isLogged(player) then
			if not player:getData("enteringDoor") then
				local pickupInfo = getPickupInfo(doorID)
				if pickupInfo then
					if pickupInfo.vehpass ~= 1 then return end
					if pickupInfo.locked == 1 then
						return exports.titan_noti:showBox(player, "Drzwi są zamknięte.")
					end
					local veh = getPedOccupiedVehicle(player)
					if isElement(veh) then
						if entryType == 1 then
							local vX, vY, vZ = getElementPosition(veh)
							--outputChatBox(getDistanceBetweenPoints3D(vX, vY, vZ, pickupInfo.outX, pickupInfo.outY, pickupInfo.outZ))
							if(getDistanceBetweenPoints3D(vX, vY, vZ, pickupInfo.outX, pickupInfo.outY, pickupInfo.outZ) < 3) then
								local newX, newY, newZ, newAngle = pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ, pickupInfo.inAngle
								local newDim, newInt = pickupInfo.inDim, pickupInfo.inInt
								if(newX == 0 and newY == 0 and newZ == 0) then
									return exports.titan_noti:showBox(player, "Drzwi nie mają przypisanego wejścia.")
								end
								veh:setPosition(newX, newY, newZ)
								veh:setRotation(0, 0, newAngle)
								veh:setDimension(newDim)
								veh:setInterior(newInt)
								veh:setFrozen(true)
								player:setData("nearestDoorID", doorID)
								setElementData(player, "currentDoorID", doorID)
								player:setData("nearestDoorType", 2)
								local occupants = getVehicleOccupants(veh)
								for k, v in pairs(occupants) do
									if isElement(v) and exports.titan_login:isLogged(v) then
										v:setInterior(newInt)
										v:setDimension(newDim)
									end
								end
								setTimer(setElementFrozen, 2000, 1, veh, false)	
							end
						elseif entryType == 2 then
							local vX, vY, vZ = getElementPosition(veh)
							if(getDistanceBetweenPoints3D(vX, vY, vZ, pickupInfo.inX, pickupInfo.inY, pickupInfo.inZ) < 3) then
								local newX, newY, newZ, newAngle = pickupInfo.outX, pickupInfo.outY, pickupInfo.outZ, pickupInfo.outAngle
								local newDim, newInt = pickupInfo.outDim, pickupInfo.outInt
								if(newX == 0 and newY == 0 and newZ == 0) then
									return exports.titan_noti:showBox(player, "Drzwi nie mają przypisanego wyjścia.")
								end
								veh:setPosition(newX, newY, newZ)
								veh:setRotation(0, 0, newAngle)
								veh:setDimension(newDim)
								veh:setInterior(newInt)
								veh:setFrozen(true)
								player:setData("nearestDoorID", doorID)
								setElementData(player, "currentDoorID", doorID)
								player:setData("nearestDoorType", 2)
								local occupants = getVehicleOccupants(veh)
								for k, v in pairs(occupants) do
									if isElement(v) and exports.titan_login:isLogged(v) then
										v:setInterior(newInt)
										v:setDimension(newDim)
									end
								end
								setTimer(setElementFrozen, 2000, 1, veh, false)
							end
						end
					end
				end
			end
		end
	end
	if getElementDimension(player) == 0 then 
		setElementData(player, "currentDoorID", 0)
	else
		setElementData(player, "currentDoorID", doorID)
	end
end
addEvent("playerEntryInDoor", true)
addEventHandler("playerEntryInDoor", root, playerEntryInDoor)

--[[
|------------|
|-- EVENTY --|
|------------|
]]--

local function loadPickups()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _doorspickup")
	if(#query > 0) then
		for i = 1, #query do
			local val = query[i]
			pickupIndex[val.ID] = i
			pickupData[i] = val

			pickupData[i].outPickup = createPickup(val.outX, val.outY, val.outZ, 3, val.outModel, 0)
			if(isElement(pickupData[i].outPickup)) then
				setElementDimension(pickupData[i].outPickup, val.outDim)
				setElementInterior(pickupData[i].outPickup, val.outInt)
			end

			pickupData[i].inPickup = createPickup(val.inX, val.inY, val.inZ, 3, val.inModel, 0)
			if(isElement(pickupData[i].inPickup)) then
				setElementDimension(pickupData[i].inPickup, val.inDim)
				setElementInterior(pickupData[i].inPickup, val.inInt)
			end

			pickupData[i].outSphere = createColSphere(val.outX, val.outY, val.outZ, COLSPHERE_RADIUS)
			if(isElement(pickupData[i].outSphere)) then
				setElementDimension(pickupData[i].outSphere, val.outDim)
				setElementInterior(pickupData[i].outSphere, val.outInt)

				setElementData(pickupData[i].outSphere, "pickupID", val.ID)
				setElementData(pickupData[i].outSphere, "doorType", 1)
			end

			pickupData[i].inSphere = createColSphere(val.inX, val.inY, val.inZ, COLSPHERE_RADIUS)
			if(isElement(pickupData[i].inSphere)) then
				setElementDimension(pickupData[i].inSphere, val.inDim)
				setElementInterior(pickupData[i].inSphere, val.inInt)

				setElementData(pickupData[i].inSphere, "pickupID", val.ID)
				setElementData(pickupData[i].inSphere, "doorType", 2)
			end
		end
	end
	outputDebugString(string.format("[DOORS] Załadowano pickupy (%d). | %d ms", #query, getTickCount() - time))
end

local function loadDoors()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM _doors")
	if(#query > 0) then
		for i = 1, #query do
			local val = query[i]
			--doorsIndex[val.ID] = i
			--doorsDimension[val.dimension] = i
			doorsData[i] = val
		end
	end
	outputDebugString(string.format("[DOORS] Załadowano drzwi (%d). | %d ms", #query, getTickCount() - time))
end

local function onPlayerHitSphere(hitElement, dimension)
	if dimension then
		if isElement(hitElement) then
			if hitElement:getType() == "player" and exports.titan_login:isLogged(hitElement) and not isPedInVehicle(hitElement) then
				if hitElement:getInterior() == source:getInterior() then
					local doorType = source:getData("doorType")
					local pickupID = source:getData("pickupID")
					if tonumber(pickupID) and tonumber(doorType) then
						local pickupInfo = getPickupInfo(pickupID)
						if pickupInfo then
							if doorType == 1 then
								triggerClientEvent(hitElement, "giveDataFromServerAboutDoorInfo", hitElement, {toggle = true, doorName = pickupInfo.name, doorLocked = pickupInfo.locked == 1 and true or false})
							end
							--outputChatBox(string.format("DEBUG: [UID: %d] %s (%s).", pickupInfo.ID, pickupInfo.name, doorType == 1 and "out" or "in"), hitElement)
							hitElement:setData("nearestDoorID", pickupInfo.ID)
							hitElement:setData("nearestDoorType", doorType)
						end
					end
				end
			else
				if hitElement:getType() == "vehicle" then
					local player = getVehicleOccupant(hitElement)
					if isElement(player) then
						if exports.titan_login:isLogged(player) then
							if hitElement:getInterior() == source:getInterior() then
								local doorType = source:getData("doorType")
								local pickupID = source:getData("pickupID")
								if tonumber(pickupID) and tonumber(doorType) then
									local pickupInfo = getPickupInfo(pickupID)
									if pickupInfo then
										if doorType == 1 then
											triggerClientEvent(player, "giveDataFromServerAboutDoorInfo", player, {toggle = true, doorName = pickupInfo.name, doorLocked = pickupInfo.locked == 1 and true or false})
										end
										--outputChatBox(string.format("DEBUG: [UID: %d] %s (%s) VEH.", pickupInfo.ID, pickupInfo.name, doorType == 1 and "out" or "in"), player)
										player:setData("nearestDoorID", pickupInfo.ID)
										player:setData("nearestDoorType", doorType)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onColShapeHit", root, onPlayerHitSphere)

local function onPlayerLeaveSphere(hitElement, dimension)
	if dimension then
		if isElement(hitElement) then
			if hitElement:getType() == "player" and exports.titan_login:isLogged(hitElement) and not isPedInVehicle(hitElement) then
				if hitElement:getInterior() == source:getInterior() then
					local doorType = source:getData("doorType")
					local pickupID = source:getData("pickupID")
					if tonumber(pickupID) and tonumber(doorType) then
						local pickupInfo = getPickupInfo(pickupID)
						if pickupInfo then
							triggerClientEvent(hitElement, "giveDataFromServerAboutDoorInfo", hitElement, {toggle = false})
							hitElement:removeData("nearestDoorID")
							hitElement:removeData("nearestDoorType")
						end
					end
				end
			else
				if hitElement:getType() == "vehicle" then
					local player = getVehicleOccupant(hitElement)
					if isElement(player) then
						if exports.titan_login:isLogged(player) then
							if hitElement:getInterior() == source:getInterior() then
								local doorType = source:getData("doorType")
								local pickupID = source:getData("pickupID")
								if tonumber(pickupID) and tonumber(doorType) then
									local pickupInfo = getPickupInfo(pickupID)
									if pickupInfo then
										triggerClientEvent(player, "giveDataFromServerAboutDoorInfo", player, {toggle = false})
										player:removeData("nearestDoorID")
										player:removeData("nearestDoorType")
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onColShapeLeave", root, onPlayerLeaveSphere)


--------------------
-- EVENTY DLA GUI --
--------------------

function onPlayerChooseClosetItem(player, itemID)
	if(not exports.titan_login:isLogged(player)) then return end
	local dimension = getElementDimension(player)
	if(dimension == 0) then return end
	local doorInfo = getDoorInfoFromDimension(dimension)
	if(not doorInfo) then
		exports.titan_noti:showBox(player, "Na tym virtualworldzie nie ma stworzonego interioru.")
		return
	end
	local itemInfo = exports.titan_items:getItemInfo(itemID)
	if(not itemInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu.")
		return
	end
	if(itemInfo.ownerType ~= 4 or itemInfo.owner ~= doorInfo.ID) then
		exports.titan_noti:showBox(player, "Przedmiot nie znajduje się w schowku.")
		return
	end

	local itemSlot = exports.titan_items:getPlayerFreeSlotID(player)
	if(not itemSlot) then
		exports.titan_noti:showBox(player, "Nie posiadasz miejsca w ekwipunku.")
		return
	end

	exports.titan_items:changeItemOwner(itemInfo.ID, 1, getElementData(player, "charID"))
	exports.titan_items:changeItemSlot(itemInfo.ID, itemSlot)
	exports.titan_chats:sendPlayerLocalMeRadius(player, "wyciągnął przedmiot ze schowka.", 10.0)
	exports.titan_noti:showBox(player, string.format("Wyciągnąłeś ze schowka przedmiot \"%s\".", itemInfo.name))
	return true
end
addEvent("onPlayerChooseClosetItem", true)
addEventHandler("onPlayerChooseClosetItem", root, onPlayerChooseClosetItem)

function onPlayerChooseMagazineItemPull(player, itemID)
	if(not exports.titan_login:isLogged(player)) then return end
	local dimension = getElementDimension(player)
	if(dimension == 0) then return end
	local doorInfo = getDoorInfoFromDimension(dimension)
	if(not doorInfo) then
		exports.titan_noti:showBox(player, "Na tym virtualworldzie nie ma stworzonego interioru.")
		return
	end
	local itemInfo = getMagazineItem(doorInfo.ID, itemID)
	if(not itemInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono takiego przedmiotu w magazynie.")
		return
	end
	if(giveMagazineItem(player, doorInfo.ID, itemID)) then
		exports.titan_chats:sendPlayerLocalMeRadius(player, "wyciągnął przedmiot z magazynu.", 10.0)
		exports.titan_noti:showBox(player, string.format("Wyciągnąłeś z magazynu przedmiot \"%s\".", itemInfo.name))
	else
		exports.titan_noti:showBox(player, "Coś poszło nie tak.")
	end
end
addEvent("onPlayerChooseMagazineItemPull", true)
addEventHandler("onPlayerChooseMagazineItemPull", root, onPlayerChooseMagazineItemPull)

------------------
-- EVENTY SKLEP --
------------------

function onClientBuyItem(player, itemID)
	if(not exports.titan_login:isLogged(player)) then return false end
	triggerClientEvent(player, "removeBlockBuyGUI", player)

	local dim = getElementDimension(player)
	if(dim == 0) then return end
	local doorInfo = getDoorInfoFromDimension(dim)
	if(not doorInfo) then return end

	local pInfo = getIntProductInfo(itemID)
	if(not pInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono podanego przedmiotu.")
		return
	end

	if(pInfo.shopID ~= doorInfo.ID) then
		exports.titan_noti:showBox(player, "Tego przedmiotu nie można kupić w tym sklepie.")
		return
	end

	local playerCash = exports.titan_cash:getPlayerCash(player)
	if(not playerCash or playerCash < pInfo.price) then
		exports.titan_noti:showBox(player, "Nie masz tyle pieniędzy.")
		return
	end

	local itemSlot = exports.titan_items:getPlayerFreeSlotID(player)
	if(not itemSlot) then
		exports.titan_noti:showBox(player, "Nie posiadasz miejsca w ekwipunku.")
		return
	end

	local isPhone = false

	if(pInfo.itemVal3 == "gun-generate") then
		pInfo.itemVal3 = exports.titan_misc:generateGunID()
	elseif(pInfo.itemVal3 == "phone-generate") then
		isPhone = true
		pInfo.itemVal1 = exports.titan_misc:generatePhoneNumber()
		pInfo.itemVal3 = ""
	end

	triggerClientEvent(player, "turnBuySoundOn", player)
	exports.titan_noti:showBox(player, string.format("Kupiłeś przedmiot %s za $%d.", pInfo.itemName, pInfo.price))
	if exports.titan_cash:takePlayerCash(player, pInfo.price) then
		local tax = exports.titan_orgs:getGovTax("taxGiveItem")
		if not tax then tax = 0 end
		local taxPrice = math.ceil(pInfo.price * (tax / 100))
		if taxPrice < 0 then taxPrice = 0 end
		if taxPrice > 0 then
			exports.titan_orgs:giveGovermentMoney(taxPrice, "Podatek ze sprzedaży w sklepie 24/7")
		end
		local success, itemID = exports.titan_items:itemCreate(1, getElementData(player, "charID"), pInfo.itemName, pInfo.itemType, itemSlot, pInfo.itemVolume, pInfo.itemVal1, pInfo.itemVal2, pInfo.itemVal3)
		if isPhone and success then
			exports.titan_db:query("INSERT INTO _phone_contacts SET phoneID = ?, number = 911, name = ?", itemID, "Numer Alarmowy")
		end
	end
	triggerEvent("guiFunc.updatePlayerEquip", player, player)
end
addEvent("onClientBuyItem", true)
addEventHandler("onClientBuyItem", root, onClientBuyItem)

function clientBuyClothes(player, itemID)
	if(not exports.titan_login:isLogged(player)) then return false end
	local dim = getElementDimension(player)
	if(dim == 0) then return end
	local doorInfo = getDoorInfoFromDimension(dim)
	if(not doorInfo) then return end

	local pInfo = getIntClothInfo(itemID)
	if(not pInfo) then
		exports.titan_noti:showBox(player, "Nie znaleziono podanego przedmiotu.")
		return
	end

	if(pInfo.shopID ~= doorInfo.ID) then
		exports.titan_noti:showBox(player, "Tego przedmiotu nie można kupić w tym sklepie.")
		return
	end

	local playerCash = exports.titan_cash:getPlayerCash(player)
	if(not playerCash or playerCash < pInfo.price) then
		exports.titan_noti:showBox(player, "Nie masz tyle pieniędzy.")
		return
	end

	local itemSlot = exports.titan_items:getPlayerFreeSlotID(player)
	if(not itemSlot) then
		exports.titan_noti:showBox(player, "Nie posiadasz miejsca w ekwipunku.")
		return
	end

	triggerClientEvent(player, "turnBuySoundOn", player)
	exports.titan_noti:showBox(player, string.format("Kupiłeś ubranie %s za $%d.", pInfo.skinName, pInfo.price))
	exports.titan_cash:takePlayerCash(player, pInfo.price)

	exports.titan_items:itemCreate(1, getElementData(player, "charID"), string.format("Ubranie (ID: %d)", pInfo.skinID), 3, itemSlot, 2, pInfo.skinID, 0, 0)
	triggerEvent("guiFunc.updatePlayerEquip", player, player)
end
addEvent("clientBuyClothes", true)
addEventHandler("clientBuyClothes", root, clientBuyClothes)

local function onStart()
	loadPickups()
	loadDoors()
end
addEventHandler("onResourceStart", resourceRoot, onStart)