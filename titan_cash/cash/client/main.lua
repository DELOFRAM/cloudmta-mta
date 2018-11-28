----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local chooseGui = {}
local bankGui = {}
local groupsGui = {}

local sW, sH = guiGetScreenSize()

function chooseGui.create(data)
	if isElement(chooseGui.window) then destroyElement(chooseGui.window) end

	--triggerServerEvent("getGroupsDetails", localPlayer)

	chooseGui.window = guiCreateWindow(sW / 2 - 353 / 2, sH / 2 - 354 / 2, 353, 354, "Którym kontem chcesz zarządzać?", false)
	guiWindowSetSizable(chooseGui.window, false)
	chooseGui.list = guiCreateGridList(10, 26, 333, 200, false, chooseGui.window)
	chooseGui.buttonCancel = guiCreateButton(10, 301, 333, 43, "Zamknij", false, chooseGui.window)

	guiCreateLabel(10, 236, 143, 20, "Kod PIN", false, chooseGui.window)
    chooseGui.PIN = guiCreateEdit(10, 256, 52, 29, "", false, chooseGui.window)

	guiGridListAddColumn(chooseGui.list, "Nazwa konta", 0.4)
	guiGridListAddColumn(chooseGui.list, "Numer konta", 0.3)
	guiGridListAddColumn(chooseGui.list, "Bilans", 0.2)

	exports.titan_cursor:showCustomCursor("cashClientMain")
	addEventHandler("onClientGUIClick", chooseGui.buttonCancel, chooseGui.destroy, false)

	local row_prywatne = guiGridListAddRow(chooseGui.list)
 	guiGridListSetItemText (chooseGui.list, row_prywatne, 1, "Konta prywatne", true, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(chooseGui.list)
		guiGridListSetItemText(chooseGui.list, row, 1, v.name, false, false)
		guiGridListSetItemText(chooseGui.list, row, 2, v.accountID, false, false)
		guiGridListSetItemText(chooseGui.list, row, 3, "$"..v.balance, false, false)

		guiGridListSetItemData(chooseGui.list, row, 1, v.ID)
	end

	--local row_frakcyjne = guiGridListAddRow(chooseGui.list)
 	--guiGridListSetItemText (chooseGui.list, row_frakcyjne, 1, "Konta firmowe", true, false)

 	--setTimer(function ()
 	--	for k,v in pairs(groupsGui) do
 	--		local row = guiGridListAddRow(chooseGui.list)
 	--		guiGridListSetItemText(chooseGui.list, row, 1, v.name, false, false)
 	--		guiGridListSetItemText(chooseGui.list, row, 2, v.ID, false, false)
 	--		guiGridListSetItemText(chooseGui.list, row, 3, "$"..v.cash, false, false)
 	--		guiGridListSetItemData(chooseGui.list, row, 1, v, false, false)
 	--		guiGridListSetItemData(chooseGui.list, row, 2, "frakcyjne", false, false)
 	--	end
 	--end, 100, 1)
 	
	addEventHandler("onClientGUIDoubleClick", chooseGui.list, chooseGui.chooseAccount, false)
end
addEvent("chooseGui.create", true)
addEventHandler("chooseGui.create", root, chooseGui.create)

function chooseGui.destroy()
	if isElement(chooseGui.window) then destroyElement(chooseGui.window) end
	exports.titan_cursor:hideCustomCursor("cashClientMain")
end

function chooseGui.chooseAccount()
	local row = guiGridListGetSelectedItem(chooseGui.list)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(chooseGui.list, row, 1)
	if not data then return end
	local isFrakcyjne = guiGridListGetItemData(chooseGui.list, row, 2)
	local faction 
	if not isFrakcyjne or isFrakcyjne ~= "frakcyjne" then
		faction = 0
	else
		faction = data.ID
		triggerServerEvent("playerEvents.playerChooseAccount", localPlayer, data, PIN, faction)
		return
	end
	local PIN = guiGetText(chooseGui.PIN)
	if not PIN or string.len(PIN) == 0 then return exports.titan_noti:showBox("Wprowadź PIN do konta bankowego.") end
	if not tonumber(PIN) then return exports.titan_noti:showBox("Kod PIN musi składać się tylko z cyfr.") end
	if string.len(PIN) ~= 4 then return exports.titan_noti:showBox("PIN do konta bankowego musi składać się z 4 cyfr.") end
	triggerServerEvent("playerEvents.playerChooseAccount", localPlayer, data, PIN, faction)
	chooseGui.destroy()
end

function bankGui.create(data)
	if isElement(bankGui.window) then destroyElement(bankGui.window) end
	bankGui.data = data
	bankGui.window = guiCreateWindow(461, 126, 536, 407, "Zarządzanie kontem bankowym", false)
	guiWindowSetSizable(bankGui.window, false)
	centerWindow(bankGui.window)

	--LABELE
	guiCreateLabel(10, 149, 75, 19, "Wpłać środki", false, bankGui.window)
	guiCreateLabel(10, 236, 75, 19, "Wartość", false, bankGui.window)
	guiCreateLabel(10, 295, 75, 19, "Tytuł", false, bankGui.window)
	guiCreateLabel(274, 149, 75, 19, "Wypłać środki", false, bankGui.window)
	guiCreateLabel(441, 236, 94, 18, "Nr. rachunku", false, bankGui.window)
	local label = guiCreateLabel(10, 215, 516, 15, "Przelej środki", false, bankGui.window)
	local label2 = guiCreateLabel(10, 200, 516, 15, "________________________________________________", false, bankGui.window)
	local label3 = guiCreateLabel(10, 220, 516, 15, "________________________________________________", false, bankGui.window)
	guiLabelSetHorizontalAlign(label, "center", false)
	guiLabelSetHorizontalAlign(label2, "center", false)
	guiLabelSetHorizontalAlign(label3, "center", false)
	guiSetFont(label, "default-bold-small")
	-- /LABELE

	bankGui.accountName = guiCreateEdit(10, 28, 412, 31, data.name, false, bankGui.window)
	bankGui.accountNameButton = guiCreateButton(432, 29, 94, 30, "Zmień nazwę", false, bankGui.window)

	bankGui.accountID = guiCreateEdit(10, 69, 412, 30, "Numer konta: "..data.accountID, false, bankGui.window)
	bankGui.accountIDButton = guiCreateButton(432, 69, 94, 30, "Kopiuj", false, bankGui.window)
	guiSetEnabled(bankGui.accountID, false)

	bankGui.accountBalance = guiCreateEdit(10, 109, 412, 30, "Środki: $"..data.balance, false, bankGui.window)
	guiSetEnabled(bankGui.accountBalance, false)

	bankGui.cashWplac = guiCreateEdit(10, 168, 85, 30, "", false, bankGui.window)
	bankGui.cashWplacButton = guiCreateButton(103, 168, 94, 30, "Wpłać", false, bankGui.window)

	bankGui.cashWyplac = guiCreateEdit(274, 168, 85, 30, "", false, bankGui.window)
	bankGui.cashWyplacButton = guiCreateButton(369, 168, 94, 30, "Wypłać", false, bankGui.window)
	
	bankGui.paymentWplac = guiCreateEdit(10, 255, 85, 30, "", false, bankGui.window)
	bankGui.paymentTitle = guiCreateEdit(10, 314, 516, 31, "", false, bankGui.window)
	bankGui.paymentAccountID = guiCreateEdit(441, 254, 85, 30, "", false, bankGui.window)
	
	bankGui.paymentAccept = guiCreateButton(10, 355, 108, 31, "Zrealizuj przelew", false, bankGui.window)
	bankGui.closeAccount = guiCreateButton(288, 369, 109, 28, "Zamknij konto", false, bankGui.window)
	bankGui.cancel = guiCreateButton(417, 369, 109, 28, "Wyjdź", false, bankGui.window)

	exports.titan_cursor:showCustomCursor("cashClientMain2")

	addEventHandler("onClientGUIClick", bankGui.cancel, bankGui.destroy, false)
	addEventHandler("onClientGUIClick", bankGui.accountNameButton, bankGui.buttonAccountName, false)
	addEventHandler("onClientGUIClick", bankGui.accountIDButton, bankGui.buttonCopyAccountID, false)
	addEventHandler("onClientGUIClick", bankGui.cashWplacButton, bankGui.buttonCashWplac, false)
	addEventHandler("onClientGUIClick", bankGui.cashWyplacButton, bankGui.buttonCashWyplac, false)
	addEventHandler("onClientGUIClick", bankGui.paymentAccept, bankGui.buttonPaymentAccept, false)
end
addEvent("bankGui.create", true)
addEventHandler("bankGui.create", root, bankGui.create)

function bankGui.destroy()
	if isElement(bankGui.window) then destroyElement(bankGui.window) end
	exports.titan_cursor:hideCustomCursor("cashClientMain2")
end
addEvent("bankGui.destroy", true)
addEventHandler("bankGui.destroy", root, bankGui.destroy)

function bankGui.buttonAccountName()
	local accountName = guiGetText(bankGui.accountName)
	if string.len(accountName) <= 0 or string.len(accountName) > 255 then return exports.titan_noti:showBox("Nazwa musi mieścić się w przedziale 1 - 255 znaków.") end
	guiSetEnabled(bankGui.accountNameButton, false)
	triggerServerEvent("playerEvents.changeAccountName", localPlayer, bankGui.data.ID, accountName)
end

function bankGui.buttonCopyAccountID()
	setClipboard(bankGui.data.accountID)
	return exports.titan_noti:showBox("Numer konta został skopiowany do schowka.")
end

function bankGui.buttonCashWplac()
	local cash = guiGetText(bankGui.cashWplac)
	if not tonumber(cash) then return exports.titan_noti:showBox("Podana kwota musi być liczbą.") end
	cash = tonumber(cash)
	if cash <= 0 then return exports.titan_noti:showBox("Kwota wpłacana musi być większa od 0.") end
	guiSetEnabled(bankGui.cashWplacButton, false)
	triggerServerEvent("playerEvents.cashWplac", localPlayer, bankGui.data.ID, cash)
end

function bankGui.buttonCashWyplac()
	local cash = guiGetText(bankGui.cashWyplac)
	if not tonumber(cash) then return exports.titan_noti:showBox("Podana kwota musi być liczbą.") end
	cash = tonumber(cash)
	if cash <= 0 then return exports.titan_noti:showBox("Kwota wypłacana musi być większa od 0.") end
	guiSetEnabled(bankGui.cashWyplacButton, false)
	triggerServerEvent("playerEvents.cashWyplac", localPlayer, bankGui.data.ID, cash)
end

function bankGui.buttonPaymentAccept()
	local accountID = guiGetText(bankGui.paymentAccountID)
	local title = guiGetText(bankGui.paymentTitle)
	local cash = guiGetText(bankGui.paymentWplac)
	if not accountID or not tonumber(accountID) or string.len(accountID) ~= 8 then return exports.titan_noti:showBox("Numer konta musi składać się z ośmiu cyfr.") end
	accountID = tonumber(accountID)
	if not tonumber(cash) then return exports.titan_noti:showBox("Podana kwota musi być liczbą.") end
	cash = tonumber(cash)
	if cash <= 0 then return exports.titan_noti:showBox("Kwota wypłacana musi być większa od 0.") end
	if string.len(title) <= 0 or string.len(title) > 255 then return exports.titan_noti:showBox("Tytuł przelewu musi mieścić się w przedziale 1 - 255 znaków.") end
	title = tostring(title)
	if localPlayer:getData("onlineTime") < 18000 then
		return exports.titan_noti:showBox("Przelewy możesz wykonywać dopiero po przegraniu 5h na postaci.")
	end
	guiSetEnabled(bankGui.paymentAccept, false)
	triggerServerEvent("playerEvents.transferCash", localPlayer, bankGui.data.ID, accountID, title, cash)
end

function bankGui.setInfo(name, text)
	if isElement(bankGui[name]) then
		guiSetText(bankGui[name], text)
	end
end
addEvent("bankGui.setInfo", true)
addEventHandler("bankGui.setInfo", root, bankGui.setInfo)

function bankGui.toggleOn(buttonName)
	if isElement(bankGui[buttonName]) then
		guiSetEnabled(bankGui[buttonName], true)
	end
end
addEvent("bankGui.toggleOn", true)
addEventHandler("bankGui.toggleOn", root, bankGui.toggleOn)

function setGroupsDetails(groups)
	groupsGui = groups
end
addEvent("setGroupsDetails", true)
addEventHandler("setGroupsDetails", getRootElement(), setGroupsDetails)

function chooseGui.createCard(data)
	if isElement(chooseGui.window) then destroyElement(chooseGui.window) end

	triggerServerEvent("getGroupsDetails", localPlayer)

	chooseGui.window = guiCreateWindow(sW / 2 - 353 / 2, sH / 2 - 354 / 2, 353, 354, "Do którego konta chcesz dorobić kartę bankomatowa?", false)
	guiWindowSetSizable(chooseGui.window, false)
	chooseGui.list = guiCreateGridList(10, 26, 333, 200, false, chooseGui.window)
	chooseGui.buttonCancel = guiCreateButton(10, 301, 333, 43, "Zamknij", false, chooseGui.window)

	guiGridListAddColumn(chooseGui.list, "Nazwa konta", 0.5)
	guiGridListAddColumn(chooseGui.list, "Numer konta", 0.4)

	exports.titan_cursor:showCustomCursor("cashClientMain")
	addEventHandler("onClientGUIClick", chooseGui.buttonCancel, chooseGui.destroy, false)

	local row_prywatne = guiGridListAddRow(chooseGui.list)
 	guiGridListSetItemText (chooseGui.list, row_prywatne, 1, "Konta prywatne", true, false)

	for k, v in ipairs(data) do
		local row = guiGridListAddRow(chooseGui.list)
		guiGridListSetItemText(chooseGui.list, row, 1, v.name, false, false)
		guiGridListSetItemText(chooseGui.list, row, 2, v.accountID, false, false)

		guiGridListSetItemData(chooseGui.list, row, 1, v.ID)
	end 	
	addEventHandler("onClientGUIDoubleClick", chooseGui.list, chooseGui.chooseCard, false)
end
addEvent("chooseGui.createCard", true)
addEventHandler("chooseGui.createCard", root, chooseGui.createCard)

function chooseGui.chooseCard()
	local row = guiGridListGetSelectedItem(chooseGui.list)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(chooseGui.list, row, 1)
	if not data then return end
	triggerServerEvent("createPlayerATMCard", localPlayer, localPlayer, data)
	chooseGui.destroy()
end



-- value - konta grupowe
function bankGui.create2(name, id, cash)
	if isElement(bankGui.window) then destroyElement(bankGui.window) end
	if isElement(chooseGui.window) then destroyElement(chooseGui.window) end
	exports.titan_cursor:hideCustomCursor("cashClientMain")
	bankGui.data = data
	bankGui.window = guiCreateWindow(461, 126, 536, 407, "Zarządzanie kontem grupowym", false)
	guiWindowSetSizable(bankGui.window, false)

	centerWindow(bankGui.window)

	--LABELE
	guiCreateLabel(10, 149, 75, 19, "Wpłać środki", false, bankGui.window)
	guiCreateLabel(10, 236, 75, 19, "Wartość", false, bankGui.window)
	guiCreateLabel(10, 295, 75, 19, "Tytuł", false, bankGui.window)
	guiCreateLabel(274, 149, 75, 19, "Wypłać środki", false, bankGui.window)
	guiCreateLabel(441, 236, 94, 18, "Nr. rachunku", false, bankGui.window)
	local label = guiCreateLabel(10, 215, 516, 15, "Przelej środki", false, bankGui.window)
	local label2 = guiCreateLabel(10, 200, 516, 15, "________________________________________________", false, bankGui.window)
	local label3 = guiCreateLabel(10, 220, 516, 15, "________________________________________________", false, bankGui.window)
	guiLabelSetHorizontalAlign(label, "center", false)
	guiLabelSetHorizontalAlign(label2, "center", false)
	guiLabelSetHorizontalAlign(label3, "center", false)
	guiSetFont(label, "default-bold-small")
	-- /LABELE

	bankGui.accountName = guiCreateEdit(10, 28, 412, 31, name, false, bankGui.window)
	--bankGui.accountNameButton = guiCreateButton(432, 29, 94, 30, "Zmień nazwę", false, bankGui.window)
	guiSetEnabled(bankGui.accountName, false)

	bankGui.accountID = guiCreateEdit(10, 69, 412, 30, "Numer konta: "..id, false, bankGui.window)
	bankGui.accountIDButton = guiCreateButton(432, 69, 94, 30, "Kopiuj", false, bankGui.window)
	guiSetEnabled(bankGui.accountID, false)

	bankGui.accountBalance = guiCreateEdit(10, 109, 412, 30, "Środki: $"..cash, false, bankGui.window)
	guiSetEnabled(bankGui.accountBalance, false)

	bankGui.cashWplac = guiCreateEdit(10, 168, 85, 30, "", false, bankGui.window)
	bankGui.cashWplacButton = guiCreateButton(103, 168, 94, 30, "Wpłać", false, bankGui.window)

	bankGui.cashWyplac = guiCreateEdit(274, 168, 85, 30, "", false, bankGui.window)
	bankGui.cashWyplacButton = guiCreateButton(369, 168, 94, 30, "Wypłać", false, bankGui.window)
	
	bankGui.paymentWplac = guiCreateEdit(10, 255, 85, 30, "", false, bankGui.window)
	bankGui.paymentTitle = guiCreateEdit(10, 314, 516, 31, "Przelewy czasowo niedostępne", false, bankGui.window)
	bankGui.paymentAccountID = guiCreateEdit(441, 254, 85, 30, "", false, bankGui.window)
	guiSetEnabled(bankGui.paymentTitle, false)
	
	bankGui.paymentAccept = guiCreateButton(10, 355, 108, 31, "Zrealizuj przelew", false, bankGui.window)
	--bankGui.closeAccount = guiCreateButton(288, 369, 109, 28, "Zamknij konto", false, bankGui.window)
	bankGui.cancel = guiCreateButton(417, 369, 109, 28, "Wyjdź", false, bankGui.window)

	exports.titan_cursor:showCustomCursor("cashClientMain2")

	addEventHandler("onClientGUIClick", bankGui.cancel, bankGui.destroy, false)
	--addEventHandler("onClientGUIClick", bankGui.accountNameButton, bankGui.buttonAccountName, false)
	addEventHandler("onClientGUIClick", bankGui.accountIDButton, bankGui.buttonCopyAccountID, false)
	addEventHandler("onClientGUIClick", bankGui.cashWplacButton, wplacGroup, false)
	addEventHandler("onClientGUIClick", bankGui.cashWyplacButton, wyplacGroup, false)
	addEventHandler("onClientGUIClick", bankGui.paymentAccept, przelewGroup, false)
end
addEvent("bankGui.create2", true)
addEventHandler("bankGui.create2", root, bankGui.create2)

function wplacGroup()
	local accountID = getElementData(localPlayer, "accountID")
	local accountMoney = getElementData(localPlayer, "accountMoney")
	local money = guiGetText(bankGui.cashWplac)
	if money:len() < 1 then	exports.titan_noti:showBox("Proszę wpisać kwotę") return end
	if not tonumber(money) then exports.titan_noti:showBox("Kwota nie jest liczbą") return end
	if tonumber(money) < 1 then exports.titan_noti:showBox("Kwota musi być większa od zera") return end
	if getElementData(localPlayer, "money") < tonumber(money) then exports.titan_noti:showBox("Nie posiadasz takiej kwoty") return end
	triggerServerEvent("wplacGroup", localPlayer, accountID, money)
	destroyElement(chooseGui.window)
	exports.titan_cursor:hideCustomCursor("cashClientMain")
end

function wyplacGroup()
	local accountID = getElementData(localPlayer, "accountID")
	local accountMoney = getElementData(localPlayer, "accountMoney")
	local money = guiGetText(bankGui.cashWyplac)
	if money:len() < 1 then	exports.titan_noti:showBox("Proszę wpisać kwotę") return end
	if not tonumber(money) then exports.titan_noti:showBox("Kwota nie jest liczbą") return end
	if tonumber(money) < 1 then exports.titan_noti:showBox("Kwota musi być większa od zera") return end
	if accountMoney < tonumber(money) then exports.titan_noti:showBox("Na koncie nie ma takiej kwoty") return end
	triggerServerEvent("wyplacGroup", localPlayer, accountID, money)
	destroyElement(chooseGui.window)
	exports.titan_cursor:hideCustomCursor("cashClientMain")
end

function przelewGroup()
	exports.titan_noti:showBox("Przelew tymczasowo niedostępny")
end

function centerWindow (center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    return guiSetPosition(center_window, x, y, false)
end