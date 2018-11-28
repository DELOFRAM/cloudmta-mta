----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local boomboxGUIMenu = {}
local CDGUIMenu = {}
function createBoomboxGUIMenu(data)
	local sW, sH = guiGetScreenSize()
	if(isElement(boomboxGUIMenu.okno)) then destroyElement(boomboxGUIMenu.okno) end
	boomboxGUIMenu = {}
	localPlayer:setData("additionalItemsMenuActive", true)
	boomboxGUIMenu.okno = guiCreateWindow(sW / 2 - 141 / 2, sH / 2 - 290 / 2, 141, 290, "Boombox", false)
	guiWindowSetSizable(boomboxGUIMenu.okno, false)
	boomboxGUIMenu.hand = guiCreateButton(10, 97, 121, 51, "Weź do ręki", false, boomboxGUIMenu.okno)
	boomboxGUIMenu.toggle = guiCreateButton(10, 36, 121, 51, "Wyłącz", false, boomboxGUIMenu.okno)
	boomboxGUIMenu.ground = guiCreateButton(10, 158, 121, 51, "Połóż na ziemi", false, boomboxGUIMenu.okno)
	boomboxGUIMenu.cancel = guiCreateButton(10, 219, 121, 51, "Anuluj", false, boomboxGUIMenu.okno)
	addEventHandler("onClientGUIClick", boomboxGUIMenu.cancel, cancelBoomboxGUIMenu, false)
	addEventHandler("onClientGUIClick", boomboxGUIMenu.hand, handBoomboxGUIMenu, false)
	addEventHandler("onClientGUIClick", boomboxGUIMenu.toggle, toggleBoomboxGUIMenu, false)
	addEventHandler("onClientGUIClick", boomboxGUIMenu.ground, groundBoomboxGUIMenu, false)
	boomboxGUIMenu.itemID = data.itemID
	local onGroundEnabled = true
	local inHandEnabled = true
	if(data.onGround or data.inHand) then onGroundEnabled = false inHandEnabled = false end
	guiSetEnabled(boomboxGUIMenu.toggle, data.turnOn)
	guiSetEnabled(boomboxGUIMenu.ground, onGroundEnabled)
	guiSetEnabled(boomboxGUIMenu.hand, inHandEnabled)
	exports.titan_cursor:showCustomCursor("itemsClientBoombox1")
end
addEvent("createBoomboxGUIMenu", true)
addEventHandler("createBoomboxGUIMenu", root, createBoomboxGUIMenu)

function createCDGUIMenu(ID)
	local sW, sH = guiGetScreenSize()
	if(isElement(CDGUIMenu.okno)) then destroyElement(CDGUIMenu.okno) end
	CDGUIMenu = {}
	localPlayer:setData("additionalItemsMenuActive", true)
	CDGUIMenu.okno = guiCreateWindow(sW / 2 - 509 / 2, sH / 2 - 127 / 2, 509, 127, "Wprowadź URL do pliku pls, mp3 lub m3u", false)
	guiWindowSetSizable(CDGUIMenu.okno, false)
	CDGUIMenu.edit = guiCreateEdit(10, 30, 487, 33, "", false, CDGUIMenu.okno)
	CDGUIMenu.save = guiCreateButton(130, 73, 109, 38, "Zapisz", false, CDGUIMenu.okno)
	CDGUIMenu.cancel = guiCreateButton(260, 73, 109, 38, "Anuluj", false, CDGUIMenu.okno)
	CDGUIMenu.ID = ID
	addEventHandler("onClientGUIClick", CDGUIMenu.cancel, cancelCDGUIMenu, false)
	addEventHandler("onClientGUIClick", CDGUIMenu.save, saveCDGuiMenu, false)
	exports.titan_cursor:showCustomCursor("itemsClientBoombox2")
end
addEvent("createCDGUIMenu", true)
addEventHandler("createCDGUIMenu", root, createCDGUIMenu)

function cancelBoomboxGUIMenu()
	if(isElement(boomboxGUIMenu.okno)) then destroyElement(boomboxGUIMenu.okno) end
	boomboxGUIMenu = {}
	exports.titan_cursor:hideCustomCursor("itemsClientBoombox1")
	localPlayer:setData("additionalItemsMenuActive", false)
end

function cancelCDGUIMenu()
	if(isElement(CDGUIMenu.okno)) then destroyElement(CDGUIMenu.okno) end
	CDGUIMenu = {}
	exports.titan_cursor:hideCustomCursor("itemsClientBoombox2")
	localPlayer:setData("additionalItemsMenuActive", false)
end
addEvent("cancelCDGUIMenu", true)
addEventHandler("cancelCDGUIMenu", root, cancelCDGUIMenu)

function truncateCDGUIMenu()
	if(isElement(CDGUIMenu.okno)) then
		guiSetText(CDGUIMenu.edit, "")
		guiSetEnabled(CDGUIMenu.save, true)
		guiSetEnabled(CDGUIMenu.edit, true)
		guiSetText(CDGUIMenu.save, "Zapisz")
	end
end
addEvent("truncateCDGUIMenu", true)
addEventHandler("truncateCDGUIMenu", root, truncateCDGUIMenu)

function onVerifySuccessful()
	if(isElement(CDGUIMenu.okno)) then
		if(tonumber(CDGUIMenu.ID)) then
			local text = tostring(guiGetText(CDGUIMenu.edit))
			triggerServerEvent("savePlayerCDLink", localPlayer, localPlayer, tonumber(CDGUIMenu.ID), text)
			cancelCDGUIMenu()
		end
	end
end
addEvent("onVerifySuccessful", true)
addEventHandler("onVerifySuccessful", root, onVerifySuccessful)

function saveCDGuiMenu()
	local text = tostring(guiGetText(CDGUIMenu.edit))
	if(string.len(text) < 4) then
		exports.titan_noti:showBox("Wprowadź link.")
		return
	end
	
	if string.find(text, "m3u", -3) or string.find(text, "pls", -3) or string.find(text, "mp3", -3) then
		guiSetEnabled(CDGUIMenu.save, false)
		guiSetEnabled(CDGUIMenu.edit, false)
		guiSetText(CDGUIMenu.save, "Weryfikuję...")
		triggerServerEvent("verifyCDUrl", localPlayer, localPlayer, text)
	else
		exports.titan_noti:showBox("Wprowadź link z końcówką pls, m3u lub mp3!")
		return
	end
end

function toggleBoomboxGUIMenu() -- 1
	if(not tonumber(boomboxGUIMenu.itemID)) then return end
	boomboxGUIMenu.itemID = tonumber(boomboxGUIMenu.itemID)
	triggerServerEvent("onClientBoomboxTrigger", localPlayer, localPlayer, boomboxGUIMenu.itemID, 1)
	cancelBoomboxGUIMenu()
end

function handBoomboxGUIMenu() -- 2
	if(not tonumber(boomboxGUIMenu.itemID)) then return end
	boomboxGUIMenu.itemID = tonumber(boomboxGUIMenu.itemID)
	triggerServerEvent("onClientBoomboxTrigger", localPlayer, localPlayer, boomboxGUIMenu.itemID, 2)
	cancelBoomboxGUIMenu()
end

function groundBoomboxGUIMenu() --3
	if(not tonumber(boomboxGUIMenu.itemID)) then return end
	boomboxGUIMenu.itemID = tonumber(boomboxGUIMenu.itemID)
	triggerServerEvent("onClientBoomboxTrigger", localPlayer, localPlayer, boomboxGUIMenu.itemID, 3)
	cancelBoomboxGUIMenu()
end

-------------
-- DŹWIĘKI --
-------------

function setMusicToElementModel(object, url)
	if(getElementData(localPlayer, "loggedIn") == 1) then
		local sound = exports.titan_sounds:create3DSound(url, true, nil, nil, 100, 20, 0.5, object, nil, nil)
	end
end
addEvent("setMusicToElementModel", true)
addEventHandler("setMusicToElementModel", root, setMusicToElementModel)