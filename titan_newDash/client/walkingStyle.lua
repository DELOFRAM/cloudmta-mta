----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

wsFunc = {}

wsFunc.lock = false
wsFunc.data = {
	--------------
	-- USUNIĘTE --
	--------------
	
	-- [54] = "Chód CJa" -- "MOVE_PLAYER"
	-- [57] = "MOVE_ROCKET", -- Z RPG
	-- [58] = "MOVE_ROCKET_F", -- Z RPG FAT
	-- [59] = "MOVE_ROCKET_M", -- Z RPG MUSCLE
	-- [60] = "MOVE_ARMED", -- uzbrojony normal
	-- [61] = "MOVE_ARMED_F", -- uzbrojony FAT
	-- [62] = "MOVE_ARMED_M", -- uzbrojony MUSCLE
	-- [63] = "MOVE_BBBAT", -- identyczne jak domyślny
	-- [64] = "MOVE_BBBAT_F", -- identyczne jak grubasek
	-- [65] = "MOVE_BBBAT_M", -- identyczne jak mięśniak
	-- [66] = "MOVE_CSAW", -- piła łańcuchowa NORMAL
	-- [67] = "MOVE_CSAW_F", -- piła łańcuchowa FAT
	-- [68] = "MOVE_CSAW_M", -- piła łańcuchowa MUSCLE
	-- [70] = "MOVE_JETPACK" - z jetpackiem
	-- [126] = "MOVE_DRUNKMAN" -- pijak
	-- [138] = "MOVE_SKATE" -- skater
	
	--[0] = "Domyślny", -- "MOVE_DEFAULT"
	[55] = "Grubasek", -- "MOVE_PLAYER_F"
	-- [56] = "Mięśniak", -- "MOVE_PLAYER_M"
	[69] = "Skradanie się", -- "MOVE_SNEAK"
	[121] = "Gangster 1", -- "MOVE_GANG1"
	[122] = "Gangster 2", -- "MOVE_GANG2"
	[118] = "Mężczyzna", -- "MOVE_MAN"
	[119] = "Zgarbiony", -- "MOVE_SHUFFLE"
	[120] = "Starszy mężczyzna 1", -- "MOVE_OLDMAN"
	[123] = "Starszy mężczyzna 2", -- "MOVE_OLDFATMAN"
	[124] = "Tęgi Mężczyzna", --"MOVE_FATMAN"
	[125] = "Jogger", -- "MOVE_JOGGER"
	[127] = "Ślepiec", -- "MOVE_BLINDMAN"
	[128] = "SWAT", -- "MOVE_SWAT"
	[129] = "Kobieta 1", -- "MOVE_WOMAN"
	[132] = "Kobieta 2", -- "MOVE_SEXYWOMAN"
	[130] = "Przemęczony", -- "MOVE_SHOPPING"
	[131] = "Businesswoman", -- "MOVE_BUSYWOMAN"
	[133] = "Kusicielka", -- "MOVE_PRO"
	[134] = "Starsza kobieta 1", -- "MOVE_OLDWOMAN"
	[137] = "Starsza kobieta 2", -- "MOVE_OLDFATWOMAN"
	[135] = "Tęga Kobieta", -- "MOVE_FATWOMAN"
	[136] = "Joggerka" -- "MOVE_JOGWOMAN"
}

function wsFunc.create()
	local sW, sH = guiGetScreenSize()
	wsFunc.destroy()
	wsFunc.window = guiCreateWindow(sW / 2 - 314 / 2, sH / 2 - 315 / 2, 314, 315, "Styl chodzenia", false)
	guiWindowSetSizable(wsFunc.window, false)
	wsFunc.list = guiCreateGridList(10, 24, 294, 238, false, wsFunc.window)
	wsFunc.cancel = guiCreateButton(10, 267, 294, 38, "Zamknij", false, wsFunc.window)
	guiGridListAddColumn(wsFunc.list, "Nazwa stylu", 0.9)

	for k, v in pairs(wsFunc.data) do
		local row = guiGridListAddRow(wsFunc.list)
		guiGridListSetItemText(wsFunc.list, row, 1, v, false, false)
		guiGridListSetItemData(wsFunc.list, row, 1, k)
	end

	addEventHandler("onClientGUIClick", wsFunc.cancel, wsFunc.destroy, false)
	addEventHandler("onClientGUIDoubleClick", wsFunc.list, wsFunc.click, false)
	exports.titan_cursor:showCustomCursor("dashClientWalkingStyle")
end
addEvent("wsFunc.create", true)
addEventHandler("wsFunc.create", root, wsFunc.create)

function wsFunc.destroy()
	if isElement(wsFunc.window) then destroyElement(wsFunc.window) end
	exports.titan_cursor:hideCustomCursor("dashClientWalkingStyle")
	wsFunc.lock = false
end
addEvent("wsFunc.destroy", true)
addEventHandler("wsFunc.destroy", root, wsFunc.destroy)

function wsFunc.click()
	if wsFunc.lock then return end
	local row = guiGridListGetSelectedItem(wsFunc.list)
	if not row or row == -1 then return end

	local data = guiGridListGetItemData(wsFunc.list, row, 1)
	if tonumber(data) then
		wsFunc.lock = true
		triggerServerEvent("dashFunc.changeWalkingStyle", localPlayer, localPlayer, tonumber(data))
	end
end