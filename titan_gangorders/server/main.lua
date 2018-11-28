----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-11 11:41:34
-- Ostatnio zmodyfikowano: 2016-01-11 14:15:53
----------------------------------------------------

local orderData = {}

function orderData.funcStartResource()
	orderData.ped = createPed(60,  2570.367, -1032.507, 69.584, 170.0, true)
	if isElement(orderData.ped) then
		orderData.ped:setData("gangOrderPed", true)
		orderData.ped:setData("name", "Vincert ciotą jest")
		orderData.ped:setFrozen(true)
	end
end
addEventHandler("onResourceStart", resourceRoot, orderData.funcStartResource)

function orderData.funcBuyProduct(orderID)
	--outputChatBox(tostring(orderID))
	local orderData = exports.titan_db:query("SELECT * FROM _orders WHERE ID = ? LIMIT 1", orderID)
	if #orderData > 0 then
		orderData = orderData[1]
		local money = exports.titan_cash:getPlayerCash(source)
		if money < orderData.price then return exports.titan_noti:showBox(source, "Nie posiadasz wystarczającej ilości gotówki.") end
		local freeSlot = exports.titan_items:getPlayerFreeSlotID(source)
		if not freeSlot then return exports.titan_noti:showBox(source, "Nie posiadasz wolnego slotu w ekwipunku.") end
		local itemData = fromJSON(orderData.data)
		if type(itemData) ~= "table" then return exports.titan_noti:showBox(source, "To zamówienie jest uszkodzone. Zgłoś to administracji.") end
		if itemData.itemVal3 == "gun-generate" then
			itemData.itemVal3 = exports.titan_misc:generateGunID()
		end
		if exports.titan_items:itemCreate(1, source:getData("charID"), itemData.itemName, itemData.itemType, freeSlot, itemData.itemVolume, itemData.itemVal1, itemData.itemVal2, itemData.itemVal3) then
			return exports.titan_noti:showBox(source, "Pomyślnie kupiono przedmiot.")
		else
			return exports.titan_noti:showBox(source, "Wystąpił problem w momencie finalizowania zamówienia.")
		end
	else return exports.titan_noti:showBox(source, "Nie znaleziono takiego zamówienia dla Twojej grupy.") end
end
addEvent("orderData.funcBuyProduct", true)
addEventHandler("orderData.funcBuyProduct", root, orderData.funcBuyProduct)

function orderData.cmdGangKup(player)
	if not exports.titan_login:isLogged(player) then return end
	local playerDuty = exports.titan_orgs:getPlayerDuty(player)
	if not playerDuty then return exports.titan_noti:showBox(player, "Nie jesteś na duty żadnej grupy.") end
	local groupInfo = exports.titan_orgs:getGroupInfo(playerDuty)
	if not groupInfo then return exports.titan_noti:showBox(player, "Grupa na której duty jesteś nie istnieje w systemie.") end
	if not exports.titan_orgs:doesGroupHavePerm(playerDuty, "gangorders") then return exports.titan_noti:showBox(player, "Grupa, na której służbie jesteś nie posiada dostępu do zamawiania przedmiotów przestępczych.") end
	if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "gangorders") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do zamawiania przedmiotów przestępczych.") end
	local cat, orders = exports.titan_orgs:getAvailableOrders(playerDuty)
	if not cat then return exports.titan_noti:showBox(player, "Grupa nie posiada żadnych przedmiotów do zamawiania.") end
	triggerClientEvent(player, "orderData.startGUI", player, cat, orders)
end
addCommandHandler("gangkup", orderData.cmdGangKup, false, false)