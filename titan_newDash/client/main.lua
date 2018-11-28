----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local dashFunc = {}
local dashData = {}
local sW, sH = guiGetScreenSize()
local data = {sW = sW, sH = sH}
Settings = {}
Settings.var = {}
Settings.var.cutoff = 0.1
Settings.var.power = 1.88
Settings.var.bloom = 1.0
myScreenSource = dxCreateScreenSource(sW, sH)
blurHShader,tecName = dxCreateShader("client/images/blurH.fx")
blurVShader,tecName = dxCreateShader("client/images/blurV.fx")

dashData.render = {}
dashData.render.topbar = {0, 0, sW, 256}
dashData.render.main = {sW / 2 - 544, 132, 1088, 640}
dashData.render.icon_achiev = {sW / 2 - 96, 0, 192, 128}
dashData.render.icon_friends = {dashData.render.icon_achiev[1] - 192, dashData.render.icon_achiev[2], 192, 128}
dashData.render.icon_char = {dashData.render.icon_friends[1] - 192, dashData.render.icon_achiev[2], 192, 128}
dashData.render.icon_logs = {dashData.render.icon_achiev[1] + 192, dashData.render.icon_achiev[2], 192, 128}
dashData.render.icon_settings = {dashData.render.icon_logs[1] + 192, dashData.render.icon_achiev[2], 192, 128}

dashData.font = {}
dashData.font["myriad"] = dxCreateFont("client/fonts/OpenSans.ttf", 23, false, "antialiased") or "default-bold"
dashData.font["myriadSmall"] = dxCreateFont("client/fonts/OpenSans.ttf", 10, false, "antialiased") or "default-bold"

dashData.topBarSelected = 1

dashData.friendsData = nil
dashData.friendsLoad = false
dashData.friendsPage = 1

dashData.logsData = nil
dashData.logsLoad = false

dashData.image = {}

dashData.state = "hide"
dashData.stateTime = 0
dashData.animTime = 1000
dashData.file = "client/images/default_large.png"
dashData.settingsPage = 1

dashFunc.settingsData =
{
	[1] =
	{
		title = "Wielkość licznika",
		description = "Ustawienie to pozwoli Ci na wybranie jednego z trzech wielkości licznika dostępnego do wyboru.",
		settingName = "speedometer",
		multiple = true,
		withoutImage = false,
		options =
		{
			[1] = {"Duży", false},
			[2] = {"Średni", false},
			[3] = {"Mały", false},
		}
	},
	[2] =
	{
		title = "Efekt HDR",
		description = "Ustawienie to pozwoli na włączenie efektu HDR (High Dynamic Range) poprawiającego oświetlenie. Włączenie efektu może spowodować spadek wydajności gry.",
		settingName = "hdr",
		multiple = false,
		withoutImage = false,
		options = {"Włączenie/wyłączenie efektu HDR", false}
	},
	[3] =
	{
		title = "Styl chodzenia",
		description = "Ustawienie to pozwoli na dopasowanie stylu chodzenia swojej postaci.",
		settingName = "walkingstyle",
		multiple = false,
		withoutImage = true,
		options = {"Pokaż menu wyboru stylu chodzenia", false}
	},
	[4] =
	{
		title = "Czat OOC",
		description = "Włączenie bądź wyłączenie czatu OOC.",
		settingName = "chatooc",
		multiple = false,
		withoutImage = false,
		options = {"Włączenie/wyłączenie czatu OOC", false}
	},
	[5] =
	{
		title = "Czat SAMP",
		description = "Włączenie bądź wyłączenie naszego customowego czatu SAMP.",
		settingName = "chatsamp",
		multiple = false,
		withoutImage = false,
		options = {"Włączenie/wyłączenie czatu SAMP", false}
	}
}

local achievments =
{
	[1] =
	{
		title = "Osiągnięcie 1",
		desc = "Opis osiągnięcia pierwszego.",
		score = 0,
		state = 1
	},
	[2] =
	{
		title = "Osiągnięcie 2",
		desc = "Opis osiągnięcia drugiego.",
		score = 0,
		state = 0
	},
	[3] =
	{
		title = "Osiągnięcie 3",
		desc = "Opis osiągnięcia trzeciego.",
		score = 0,
		state = 0
	},
	[4] =
	{
		title = "Osiągnięcie 4",
		desc = "Opis osiągnięcia czwartego.",
		score = 0,
		state = 1
	},
	[5] =
	{
		title = "Osiągnięcie 5",
		desc = "Opis osiągnięcia piątego.",
		score = 0,
		state = 0
	},
	[6] =
	{
		title = "Osiągnięcie 6",
		desc = "Opis osiągnięcia szóstego.",
		score = 0,
		state = 0
	},
	[7] =
	{
		title = "Osiągnięcie 7",
		desc = "Opis osiągnięcia siódmego.",
		score = 0,
		state = 0
	}
}

function dashFunc.render()
	--outputConsole(toJSON(dashFunc.settingsData[1].options))
	local alpha = 1
	if dashData.state == "starting" then
		local progress = (getTickCount() - dashData.stateTime) / dashData.animTime
		alpha = interpolateBetween(0, 0, 0, 1, 0, 0, progress, "Linear")
		if progress > 1 then dashData.state = "show" end
	elseif dashData.state == "hiding" then
		local progress = (getTickCount() - dashData.stateTime) / dashData.animTime
		alpha = interpolateBetween(1, 0, 0, 0, 0, 0, progress, "Linear")
		if progress > 1 then
			dashData.state = "hide"
			removeEventHandler("onClientRender", root, dashFunc.render)
			removeEventHandler("onClientClick", root, dashFunc.onClientClick)
			removeEventHandler("onClientKey", root, dashFunc.onClientKey)
			triggerServerEvent("dashFunc.showHUD", localPlayer)
			-- Reset danych: początek --
			dashData.vehicles = nil
			dashData.interiors = nil
			dashData.groups = nil

			dashData.friendsData = nil
			dashData.friendsLoad = false
			dashData.friendsPage = 1

			dashData.logsData = nil
			dashData.logsLoad = false

			if fileExists(dashData.file) then fileDelete(dashData.file) end
			dashData.settingsPage = 1
			dashData.image = {}
			-- Reset danych: koniec --
			return
		end
	end

	--[[ BLUR ]]--
	RTPool.frameStart()
	dxUpdateScreenSource(myScreenSource)
	local current = myScreenSource

	current = applyDownsample(current)
	current = applyGBlurH(current, Settings.var.bloom)
	current = applyGBlurV(current, Settings.var.bloom)
	dxSetRenderTarget()
	dxDrawImage(0, -20, sW, sH + 20, current, 0,0,0, tocolor(255, 255, 255, 255 * alpha))
	--[[ BLUR ]]--
	dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 150 * alpha), false)

	-- NAVI BAR
	dxDrawImage(dashData.render.topbar[1], dashData.render.topbar[2], dashData.render.topbar[3], dashData.render.topbar[4], "client/images/top-bar.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	dxDrawImage(dashData.render.main[1], dashData.render.main[2], dashData.render.main[3], dashData.render.main[4], "client/images/main.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	dxDrawImage(dashData.render.icon_char[1], dashData.render.icon_char[2], dashData.render.icon_char[3], dashData.render.icon_char[4], "client/images/icon-char.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	dxDrawImage(dashData.render.icon_friends[1], dashData.render.icon_friends[2], dashData.render.icon_friends[3], dashData.render.icon_friends[4], "client/images/icon-friends.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	dxDrawImage(dashData.render.icon_achiev[1], dashData.render.icon_achiev[2], dashData.render.icon_achiev[3], dashData.render.icon_achiev[4], "client/images/icon-achievments.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	dxDrawImage(dashData.render.icon_logs[1], dashData.render.icon_logs[2], dashData.render.icon_logs[3], dashData.render.icon_logs[4], "client/images/icon-logs.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	dxDrawImage(dashData.render.icon_settings[1], dashData.render.icon_settings[2], dashData.render.icon_settings[3], dashData.render.icon_settings[4], "client/images/icon-settings.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	-- UID INFO
	dxDrawText(string.format("UID konta: %s", tostring(localPlayer:getData("memberID"))), 5, 5, 5, 5, tocolor(150, 150, 150, 150 * alpha), 0.4, dashData.font["myriad"])
	dxDrawText(string.format("UID postaci: %s", tostring(localPlayer:getData("charID"))), 5, 15, 5, 15, tocolor(150, 150, 150, 150 * alpha), 0.4, dashData.font["myriad"])

	dashFunc.headerRender(alpha)

	-- CONTENT
	if dashData.topBarSelected == 1 then dashFunc.mainRender(alpha)
	elseif dashData.topBarSelected == 2 then dashFunc.friendsRender(alpha)
	elseif dashData.topBarSelected == 3 then dashFunc.achievmentsRender(alpha)
	elseif dashData.topBarSelected == 4 then dashFunc.logsRender(alpha)
	elseif dashData.topBarSelected == 5 then dashFunc.settingsRender(alpha)
	end

end

function dashFunc.headerRender(alpha)
	if isCursorShowing() then
		if dashData.topBarSelected ~= 1 and dashFunc.isCursorGetRectangle(dashData.render.icon_char[1], dashData.render.icon_char[2], dashData.render.icon_char[3], dashData.render.icon_char[4] + 5) then
			dxDrawRectangle(dashData.render.icon_char[1], dashData.render.icon_char[2], dashData.render.icon_char[3], dashData.render.icon_char[4] + 5, tocolor(80, 80, 80, 50 * alpha))
		elseif dashData.topBarSelected ~= 2 and dashFunc.isCursorGetRectangle(dashData.render.icon_friends[1], dashData.render.icon_friends[2], dashData.render.icon_friends[3], dashData.render.icon_friends[4] + 5) then
			dxDrawRectangle(dashData.render.icon_friends[1], dashData.render.icon_friends[2], dashData.render.icon_friends[3], dashData.render.icon_friends[4] + 5, tocolor(80, 80, 80, 50 * alpha))
		elseif dashData.topBarSelected ~= 3 and dashFunc.isCursorGetRectangle(dashData.render.icon_achiev[1], dashData.render.icon_achiev[2], dashData.render.icon_achiev[3], dashData.render.icon_achiev[4] + 5) then
			dxDrawRectangle(dashData.render.icon_achiev[1], dashData.render.icon_achiev[2], dashData.render.icon_achiev[3], dashData.render.icon_achiev[4] + 5, tocolor(80, 80, 80, 50 * alpha))
		elseif dashData.topBarSelected ~= 4 and dashFunc.isCursorGetRectangle(dashData.render.icon_logs[1], dashData.render.icon_logs[2], dashData.render.icon_logs[3], dashData.render.icon_logs[4] + 5) then
			dxDrawRectangle(dashData.render.icon_logs[1], dashData.render.icon_logs[2], dashData.render.icon_logs[3], dashData.render.icon_logs[4] + 5, tocolor(80, 80, 80, 50 * alpha))
		elseif dashData.topBarSelected ~= 5 and dashFunc.isCursorGetRectangle(dashData.render.icon_settings[1], dashData.render.icon_settings[2], dashData.render.icon_settings[3], dashData.render.icon_settings[4] + 5) then
			dxDrawRectangle(dashData.render.icon_settings[1], dashData.render.icon_settings[2], dashData.render.icon_settings[3], dashData.render.icon_settings[4] + 5, tocolor(80, 80, 80, 50 * alpha))
		end
	end
end

function dashFunc.mainRender(alpha)
	dxDrawRectangle(dashData.render.icon_char[1], dashData.render.icon_char[2], dashData.render.icon_char[3], dashData.render.icon_char[4] + 5, tocolor(150, 150, 150, 100 * alpha))
	--dxDrawRectangle(dashData.render.main[1] + 30, dashData.render.main[2] + 10, 140, 140, tocolor(255, 255, 255, 255 * alpha))
	dxDrawImage(dashData.render.main[1] + 30, dashData.render.main[2] + 10, 140, 140, dashData.file, 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
	dxDrawText(string.format("%s %s", tostring(localPlayer:getData("name")), tostring(localPlayer:getData("lastname"))), dashData.render.main[1] + 180, dashData.render.main[2] + 20, 0, 0, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriad"])
	dxDrawText(string.format("Data urodzenia: %s %s %s", getElementData(localPlayer, "birthday").day, getMonthFromNumber(getElementData(localPlayer, "birthday").month), getElementData(localPlayer, "birthday").year), dashData.render.main[1] + 195, dashData.render.main[2] + 70, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])
	dxDrawText(string.format("Płeć: %s", localPlayer:getData("sex") == 1 and "Mężczyzna" or localPlayer:getData("sex") == 2 and "Kobieta" or "Nieznana"), dashData.render.main[1] + 195, dashData.render.main[2] + 90, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])
	dxDrawText(string.format("Portfel: $%s", tostring(localPlayer:getData("money"))), dashData.render.main[1] + 195, dashData.render.main[2] + 110, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])
	dxDrawText(string.format("Bank: %s", localPlayer:getData("accountID") == 0 and "Brak" or "$"..tostring(localPlayer:getData("accountMoney")).." ("..tostring(localPlayer:getData("accountID"))..")"), dashData.render.main[1] + 195, dashData.render.main[2] + 130, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])

	dxDrawText(string.format("%s godzin przegranych", tostring(math.floor(localPlayer:getData("onlineTime") / 3600))), dashData.render.main[1] + 30, dashData.render.main[2] + 160, dashData.render.main[1] + 170, dashData.render.main[2] + 170, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"], "center", "center")

	dxDrawImage(dashData.render.main[1] + 10, dashData.render.main[2] + 180, 512, 4, "client/images/divider.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	dxDrawText("Pojazdy", dashData.render.main[1] + 75, dashData.render.main[2] + 188, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])
	dxDrawImage(dashData.render.main[1] + 70, dashData.render.main[2] + 160, 256, 384, "client/images/char-table.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	if type(dashData.vehicles) ~= "table" then
		dxDrawText("Wczytuję...", dashData.render.main[1] + 80, dashData.render.main[2] + 209, 0, dashData.render.main[2] + 243, tocolor(220, 220, 220, 255 * alpha), 0.4, dashData.font["myriad"], "left", "center")
	else
		if #dashData.vehicles <= 0 then
			dxDrawText("Nie posiadasz żadnych pojazdów.", dashData.render.main[1] + 80, dashData.render.main[2] + 209, 0, dashData.render.main[2] + 243, tocolor(220, 220, 220, 255 * alpha), 0.4, dashData.font["myriad"], "left", "center")
		else
			local i = 0
			for k, v in pairs(dashData.vehicles) do
				i = i + 1
				if i < 9 then
					dxDrawText(string.format("%s (UID: %s)", tostring(v.name), tostring(v.ID)), dashData.render.main[1] + 80, dashData.render.main[2] + 209 + (36 * (i - 1)), dashData.render.main[1] + 330, dashData.render.main[2] + 243 + (36 * (i - 1)), tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriadSmall"], "left", "center", true)
				end
			end
		end
	end
	dxDrawText("Posiadłości", dashData.render.main[1] + 371, dashData.render.main[2] + 188, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])
	dxDrawImage(dashData.render.main[1] + 366, dashData.render.main[2] + 160, 256, 384, "client/images/char-table.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	if type(dashData.interiors) ~= "table" then
		dxDrawText("Wczytuję...", dashData.render.main[1] + 376, dashData.render.main[2] + 209, 0, dashData.render.main[2] + 243, tocolor(220, 220, 220, 255 * alpha), 0.4, dashData.font["myriad"], "left", "center")
	else
		if #dashData.interiors <= 0 then
			dxDrawText("Nie posiadasz żadnych posiadłości.", dashData.render.main[1] + 376, dashData.render.main[2] + 209, 0, dashData.render.main[2] + 243, tocolor(220, 220, 220, 255 * alpha), 0.4, dashData.font["myriad"], "left", "center")
		else
			local i = 0
			for k, v in pairs(dashData.interiors) do
				i = i + 1
				if i < 9 then
					dxDrawText(string.format("%s", tostring(v.name)), dashData.render.main[1] + 376, dashData.render.main[2] + 209 + (36 * (i - 1)), dashData.render.main[1] + 626, dashData.render.main[2] + 243 + (36 * (i - 1)), tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriadSmall"], "left", "top", true)
				end
			end
		end
	end
	dxDrawText("Grupy", dashData.render.main[1] + 667, dashData.render.main[2] + 188, 0, 0, tocolor(220, 220, 220, 255 * alpha), 0.45, dashData.font["myriad"])
	dxDrawImage(dashData.render.main[1] + 662, dashData.render.main[2] + 160, 256, 384, "client/images/char-table.png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))

	if type(dashData.groups) ~= "table" then
		dxDrawText("Wczytuję...", dashData.render.main[1] + 672, dashData.render.main[2] + 209, 0, dashData.render.main[2] + 243, tocolor(220, 220, 220, 255 * alpha), 0.4, dashData.font["myriad"], "left", "center")
	else
		if #dashData.groups <= 0 then
			dxDrawText("Nie posiadasz żadnych grup.", dashData.render.main[1] + 672, dashData.render.main[2] + 209, 0, dashData.render.main[2] + 243, tocolor(220, 220, 220, 255 * alpha), 0.4, dashData.font["myriad"], "left", "center")
		else
			local i = 0
			for k, v in pairs(dashData.groups) do
				i = i + 1
				if i < 9 then
					dxDrawText(string.format("%s (UID: %s)", tostring(v.groupInfo.name), tostring(v.groupInfo.ID)), dashData.render.main[1] + 672, dashData.render.main[2] + 209 + (36 * (i - 1)), dashData.render.main[1] + 922, dashData.render.main[2] + 243 + (36 * (i - 1)), tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriadSmall"], "left", "top", true)
					dxDrawText(string.format("Ranga: %s, Wypłata: $%s", v.rankName, v.cash), dashData.render.main[1] + 672, dashData.render.main[2] + 209 + (36 * (i - 1)) + 14, dashData.render.main[1] + 922, dashData.render.main[2] + 243 + (36 * (i - 1)), tocolor(160, 160, 160, 180 * alpha), 0.85, dashData.font["myriadSmall"], "left", "top", true)
				end
			end
		end
	end
end

function dashFunc.friendsRender(alpha)
	dxDrawRectangle(dashData.render.icon_friends[1], dashData.render.icon_friends[2], dashData.render.icon_friends[3], dashData.render.icon_friends[4] + 5, tocolor(150, 150, 150, 100 * alpha))
	dxDrawText("Twoi znajomi", dashData.render.main[1] + 25, dashData.render.main[2] + 10, 0, 0, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriad"])

	if not dashData.friendsData then
		dxDrawText("Ładowanie informacji o Twoich znajomych...", dashData.render.main[1] + 16.5, dashData.render.main[2] + 50, dashData.render.main[1] + 16.5 + 1056, 0, tocolor(230, 230, 230, 200 * alpha), 1.0, dashData.font["myriadSmall"], "center")
		if not dashData.friendsLoad then
			dashData.friendsLoad = true
			triggerServerEvent("dashFunc.loadFriends", localPlayer)
		end
		return
	end

	dxDrawText(string.format("Strona %d/%d", dashData.friendsPage, math.ceil(#dashData.friendsData / 8)), dashData.render.main[1] + 990, dashData.render.main[2] + 60, 0, 0, tocolor(255, 255, 255, 180 * alpha), 1.0, dashData.font["myriadSmall"])
	local i = 0
	for k, v in ipairs(dashData.friendsData) do
		if k > 8 * (dashData.friendsPage - 1)  and k <= dashData.friendsPage * 8 then
			i = i + 1
			local sX = dashData.render.main[1] + 16.5
			local sY = dashData.render.main[2] + 80 + 50 * (i - 1)
			dxDrawRectangle(sX, sY, 1056, 50, i % 2 == 0 and tocolor(200, 200, 200, 30 * alpha) or tocolor(150, 150, 150, 30 * alpha))
			--dxDrawRectangle(sX + 15, sY + 7.5, 35, 35, tocolor(255, 255, 255, 180 * alpha))
			dxDrawImage(sX + 15, sY + 7.5, 35, 35, dashData.image[tonumber(v.member_id)], 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
			dxDrawText(string.format("%s (UID: %d)", v.members_display_name, v.member_id), sX + 60, sY, sX + 130, sY + 50, tocolor(200, 200, 200, 200 * alpha), 1.0, dashData.font["myriadSmall"], "left", "center")
			dxDrawText(v.game_inGame == 1 and getCharacterNameFromMemberID(v.member_id) or "", sX, sY, sX + 1056, sY + 50, tocolor(220, 220, 220, 200 * alpha), 1.0, dashData.font["myriadSmall"], "center", "center")
			dxDrawImage(sX + 1010, sY + 17, 16, 16, "client/images/online-dot.png", 0, 0, 0, v.game_inGame == 1 and tocolor(0, 255, 0, 150 * alpha) or tocolor(255, 0, 0, 150 * alpha))
		end
	end
end

function dashFunc.achievmentsRender(alpha)
	dxDrawRectangle(dashData.render.icon_achiev[1], dashData.render.icon_achiev[2], dashData.render.icon_achiev[3], dashData.render.icon_achiev[4] + 5, tocolor(150, 150, 150, 100 * alpha))
	dxDrawText("Zakładka tymczasowo wyłaczona!", dashData.render.main[1] + 25, dashData.render.main[2] + 10, 0, 0, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriad"])
	--[[for i, v in ipairs(achievments) do
		local sX = dashData.render.main[1] + 16.5
		local sY = dashData.render.main[2] + 80 + 50 * (i - 1)
		dxDrawRectangle(sX, sY, 1056, 50, i % 2 == 0 and tocolor(200, 200, 200, 30 * alpha) or tocolor(150, 150, 150, 30 * alpha))
		dxDrawImage(sX + 15, sY + 7.5, 39, 35, "client/images/achievments/"..i..".png", 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
		dxDrawText(v.title, sX + 60, sY + 5, sX + 130, sY + 50, tocolor(230, 230, 230, 230 * alpha), 0.5, dashData.font["myriad"], "left", "top")
		dxDrawText(v.desc, sX + 60, sY + 25, sX + 130, sY + 50, tocolor(230, 230, 230, 230 * alpha), 1.0, dashData.font["myriadSmall"], "left", "top")
		dxDrawText(v.score.." CloudPoints", sX + 60, sY, sX + 800, sY + 50, tocolor(230, 230, 230, 230 * alpha), 1.0, dashData.font["myriadSmall"], "right", "center")
		if v.state == 1 then
			dxDrawText("ODBLOKOWANE", sX + 900, sY, sX + 1000, sY + 50, tocolor(19, 171, 54, 150 * alpha), 1.0, dashData.font["myriadSmall"], "center", "center")
		else
			dxDrawText("NIEODBLOKOWANE", sX + 900, sY, sX + 1000, sY + 50, tocolor(150, 150, 150, 150 * alpha), 1.0, dashData.font["myriadSmall"], "center", "center")
		end
	end]]
end

function dashFunc.settingsRender(alpha)
	dxDrawRectangle(dashData.render.icon_settings[1], dashData.render.icon_settings[2], dashData.render.icon_settings[3], dashData.render.icon_settings[4] + 5, tocolor(150, 150, 150, 100 * alpha))
	dxDrawText("Ustawienia", dashData.render.main[1] + 25, dashData.render.main[2] + 10, 0, 0, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriad"])
	dxDrawText(string.format("%d z %d dostępnych (Aby przełączać między ustawieniami używaj klawiszy strzałek lewo i prawo)", dashData.settingsPage, #dashFunc.settingsData), dashData.render.main[1] + 28, dashData.render.main[2] + 45, 0, 0, tocolor(150, 150, 150, 255 * alpha), 1.0, dashData.font["myriadSmall"])

	local heightTemp = dashData.render.main[2] + 90
	local widthTemp = dashData.render.main[1] + 50
	local settingData = dashFunc.settingsData[dashData.settingsPage]

	dxDrawText(settingData.title, 0, heightTemp, sW, 0, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriad"], "center")
	dxDrawText(settingData.description, widthTemp + 10, heightTemp + 40, 0, 0, tocolor(150, 150, 150, 255 * alpha), 1.0, dashData.font["myriadSmall"])

	if type(settingData.options) == "table" then
		if settingData.multiple then
			for k, v in ipairs(settingData.options) do
				dxDrawRectangle(widthTemp + 40, heightTemp + 100 + 70 * (k - 1), dashData.render.main[3] - 190, 64, tocolor(20, 20, 20, 150 * alpha))
				dxDrawImage(widthTemp + 50, heightTemp + 100 + 70 * (k - 1), 64, 64, string.format("client/images/switch_%s.png", v[2] and "on" or "off"), 0, 0, 0, tocolor(255, 255, 255, 255 * alpha))
				dxDrawText(v[1], widthTemp + 150, heightTemp + 100 + 70 * (k - 1), 0, heightTemp + 100 + 64 + 70 * (k - 1), tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriadSmall"], "left", "center")
			end
		else
			dxDrawRectangle(widthTemp + 40, heightTemp + 100, dashData.render.main[3] - 190, 64, tocolor(20, 20, 20, 150 * alpha))
			if not settingData.withoutImage then dxDrawImage(widthTemp + 50, heightTemp + 100, 64, 64, string.format("client/images/switch_%s.png", settingData.options[2] and "on" or "off"), 0, 0, 0, tocolor(255, 255, 255, 255 * alpha)) end
			dxDrawText(settingData.options[1], widthTemp + 150, heightTemp + 100, 0, heightTemp + 100 + 64, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriadSmall"], "left", "center")
		end
	end
end

function dashFunc.logsRender(alpha)
	dxDrawRectangle(dashData.render.icon_logs[1], dashData.render.icon_logs[2], dashData.render.icon_logs[3], dashData.render.icon_logs[4] + 5, tocolor(150, 150, 150, 100 * alpha))
	dxDrawText("Logi logowań", dashData.render.main[1] + 25, dashData.render.main[2] + 10, 0, 0, tocolor(220, 220, 220, 255 * alpha), 1.0, dashData.font["myriad"])
	if not dashData.logsData then
		dxDrawText("Ładowanie informacji o Twoich logach logowań...", dashData.render.main[1] + 16.5, dashData.render.main[2] + 50, dashData.render.main[1] + 16.5 + 1056, 0, tocolor(230, 230, 230, 200 * alpha), 1.0, dashData.font["myriadSmall"], "center")
		if not dashData.logsLoad then
			dashData.logsLoad = true
			triggerServerEvent("dashFunc.loadLogs", localPlayer)
		end
		return
	end
	for i, v in ipairs(dashData.logsData) do
		local sX = dashData.render.main[1] + 16.5
		local sY = dashData.render.main[2] + 80 + 50 * (i - 1)
		local time = getRealTime(v.time)
		dxDrawRectangle(sX, sY, 1056, 50, i % 2 == 0 and tocolor(200, 200, 200, 30 * alpha) or tocolor(150, 150, 150, 30 * alpha))
		dxDrawText("IP: "..v.ip, sX + 30, sY + 5, sX + 130, sY + 50, tocolor(230, 230, 230, 230 * alpha), 1.0, dashData.font["myriadSmall"], "left", "top")
		dxDrawText("Serial: "..v.serial, sX + 30, sY + 25, sX + 130, sY + 50, tocolor(230, 230, 230, 230 * alpha), 1.0, dashData.font["myriadSmall"], "left", "top")
		dxDrawText(string.format("%0.2d:%0.2d", time.hour, time.minute), sX + 600, sY + 5, sX + 800, sY + 50, tocolor(230, 230, 230, 230 * alpha), 1.0, dashData.font["myriadSmall"], "center", "top")
		dxDrawText(string.format("%0.2d.%0.2d.%0.4dr", time.monthday, time.month + 1, time.year + 1900), sX + 600, sY + 25, sX + 800, sY + 50, tocolor(230, 230, 230, 230 * alpha), 1.0, dashData.font["myriadSmall"], "center", "top")
		dxDrawText("SUKCES", sX + 900, sY, sX + 1000, sY + 50, tocolor(19, 171, 54, 150 * alpha), 1.0, dashData.font["myriadSmall"], "center", "center")
	end
end

function dashFunc.onClientClick(button, state)
	if dashData.topBarSelected ~= 1 and dashFunc.isCursorGetRectangle(dashData.render.icon_char[1], dashData.render.icon_char[2], dashData.render.icon_char[3], dashData.render.icon_char[4] + 5) then
		dashData.topBarSelected = 1 return
	elseif dashData.topBarSelected ~= 2 and dashFunc.isCursorGetRectangle(dashData.render.icon_friends[1], dashData.render.icon_friends[2], dashData.render.icon_friends[3], dashData.render.icon_friends[4] + 5) then
		dashData.topBarSelected = 2 return
	elseif dashData.topBarSelected ~= 3 and dashFunc.isCursorGetRectangle(dashData.render.icon_achiev[1], dashData.render.icon_achiev[2], dashData.render.icon_achiev[3], dashData.render.icon_achiev[4] + 5) then
		dashData.topBarSelected = 3 return
	elseif dashData.topBarSelected ~= 4 and dashFunc.isCursorGetRectangle(dashData.render.icon_logs[1], dashData.render.icon_logs[2], dashData.render.icon_logs[3], dashData.render.icon_logs[4] + 5) then
		dashData.topBarSelected = 4 return
	elseif dashData.topBarSelected ~= 5 and dashFunc.isCursorGetRectangle(dashData.render.icon_settings[1], dashData.render.icon_settings[2], dashData.render.icon_settings[3], dashData.render.icon_settings[4] + 5) then
		dashData.topBarSelected = 5 return
	end

	if button == "left" and state == "up" then
		local heightTemp = dashData.render.main[2] + 90
		local widthTemp = dashData.render.main[1] + 50

		if dashData.topBarSelected == 5 then
			if dashData.settingsPage == 1 then -- Wielkość licznika
				local dashSettings = dashFunc.settingsData[1]
				for k, v in ipairs(dashSettings.options) do
					if dashFunc.isCursorGetRectangle(widthTemp + 40, heightTemp + 100 + 70 * (k - 1), dashData.render.main[3] - 190, 64) then
						local xmlFile, xmlNode
						if not fileExists("client/settings.xml") then
							xmlFile = xmlCreateFile("client/settings.xml", "settings")
							xmlNode = xmlCreateChild(xmlFile, dashFunc.settingsData[1].settingName)
						else
							xmlFile = xmlLoadFile("client/settings.xml")
							xmlNode = xmlFindChild(xmlFile, dashFunc.settingsData[1].settingName, 0)
							if not xmlNode then xmlNode = xmlCreateChild(xmlFile, dashFunc.settingsData[1].settingName) end
						end

						xmlNodeSetValue(xmlNode, k)
						exports.titan_hud:setSpeedoSize(k)
						for k1, v1 in ipairs(dashSettings.options) do
							if k1 == k then
								v1[2] = true
							else
								v1[2] = false
							end
						end

						xmlSaveFile(xmlFile)
						xmlUnloadFile(xmlFile)
						--outputDebugString("[DASH] Zapisano pomyślnie ustawienia licznika.")
						--exports.titan_noti:showBox("Ustawienia licznika zapisano pomyślnie.")
						return
					end
				end
			elseif dashData.settingsPage == 2 then -- Efekt HDR
				local dashSettings = dashFunc.settingsData[2]
				if dashFunc.isCursorGetRectangle(widthTemp + 40, heightTemp + 100, dashData.render.main[3] - 190, 64) then
					local choose = not dashSettings.options[2]
					local xmlFile, xmlNode
					if not fileExists("client/settings.xml") then
						xmlFile = xmlCreateFile("client/settings.xml", "settings")
						xmlNode = xmlCreateChild(xmlFile, dashFunc.settingsData[2].settingName)
					else
						xmlFile = xmlLoadFile("client/settings.xml")
						xmlNode = xmlFindChild(xmlFile, dashFunc.settingsData[2].settingName, 0)
						if not xmlNode then xmlNode = xmlCreateChild(xmlFile, dashFunc.settingsData[2].settingName) end
					end

					xmlNodeSetValue(xmlNode, choose and "1" or "0")
					exports.titan_hdr:switchContrast(choose)
					dashSettings.options[2] = choose

					--exports.titan_noti:showBox("Ustawienia dot. efektu HDR zmienione pomyślnie.")

					xmlSaveFile(xmlFile)
					xmlUnloadFile(xmlFile)
					return
				end
			elseif dashData.settingsPage == 3 then -- Wybór stylu chodzenia
				if dashFunc.isCursorGetRectangle(widthTemp + 40, heightTemp + 100, dashData.render.main[3] - 190, 64) then
					dashData.stateTime = getTickCount()
					dashData.state = "hiding"
					exports.titan_cursor:hideCustomCursor("dashClientMain")

					wsFunc.create()
				end
			elseif dashData.settingsPage == 4 then -- Wyłączanie czatu OOC
				if dashFunc.isCursorGetRectangle(widthTemp + 40, heightTemp + 100, dashData.render.main[3] - 190, 64) then
					local choose = not dashFunc.settingsData[4].options[2]
					local xmlFile, xmlNode
					if not fileExists("client/settings.xml") then
						xmlFile = xmlCreateFile("client/settings.xml", "settings")
						xmlNode = xmlCreateChild(xmlFile, dashFunc.settingsData[4].settingName)
					else
						xmlFile = xmlLoadFile("client/settings.xml")
						xmlNode = xmlFindChild(xmlFile, dashFunc.settingsData[4].settingName, 0)
						if not xmlNode then xmlNode = xmlCreateChild(xmlFile, dashFunc.settingsData[4].settingName) end
					end

					xmlNodeSetValue(xmlNode, choose and "1" or "0")
					dashFunc.settingsData[4].options[2] = choose
					setElementData(localPlayer, "hide:OOC", choose and true or false)
				end
			elseif dashData.settingsPage == 5 then -- czat SAMP
				local dashSettings = dashFunc.settingsData[5]
				if dashFunc.isCursorGetRectangle(widthTemp + 40, heightTemp + 100, dashData.render.main[3] - 190, 64) then
					local choose = not dashSettings.options[2]
					local xmlFile, xmlNode
					if not fileExists("client/settings.xml") then
						xmlFile = xmlCreateFile("client/settings.xml", "settings")
						xmlNode = xmlCreateChild(xmlFile, dashSettings.settingName)
					else
						xmlFile = xmlLoadFile("client/settings.xml")
						xmlNode = xmlFindChild(xmlFile, dashSettings.settingName, 0)
						if not xmlNode then xmlNode = xmlCreateChild(xmlFile, dashSettings.settingName) end
					end

					xmlNodeSetValue(xmlNode, choose and "1" or "0")
					exports.titan_sampChat:toggleChat(choose)
					dashSettings.options[2] = choose

					--exports.titan_noti:showBox("Ustawienia dot. efektu HDR zmienione pomyślnie.")

					xmlSaveFile(xmlFile)
					xmlUnloadFile(xmlFile)
					return
				end
			end
		end
	end
end

function dashFunc.onClientKey(key, state)
	if state then
		if dashData.topBarSelected == 2 then
			if key == "d" or key == "arrow_r" then
				dashData.friendsPage = dashData.friendsPage + 1
				if dashData.friendsPage > math.ceil(#dashData.friendsData / 8) then
					dashData.friendsPage = math.ceil(#dashData.friendsData / 8)
				end
			end
			if key == "a" or key == "arrow_l" then
				dashData.friendsPage = dashData.friendsPage - 1
				if dashData.friendsPage < 1 then dashData.friendsPage = 1 end
			end
		elseif dashData.topBarSelected == 5 then
			if key == "d" or key == "arrow_r" then
				dashData.settingsPage = dashData.settingsPage + 1
				if dashData.settingsPage > #dashFunc.settingsData then
					dashData.settingsPage = #dashFunc.settingsData
				end
			end
			if key == "a" or key == "arrow_l" then
				dashData.settingsPage = dashData.settingsPage - 1
				if dashData.settingsPage < 1 then
					dashData.settingsPage = 1
				end
			end
		end
	end
end

function dashFunc.isCursorGetText(X, Y, W, H)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * data.sW, cY * data.sH
	if(cX > X and cX < W and cY > Y and cY < H) then return true end
	return false
end

function dashFunc.isCursorGetRectangle(X, Y, W, H)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * data.sW, cY * data.sH
	W = W + X
	H = H + Y
	if(cX > X and cX < W and cY > Y and cY < H) then return true end
	return false
end

function dashFunc.toggleDashboard()
	if dashData.state == "hide" then

		-- Reset danych: początek --
		dashData.vehicles = nil
		dashData.interiors = nil
		dashData.groups = nil
		dashData.topBarSelected = 1

		dashData.friendsData = nil
		dashData.friendsLoad = false
		dashData.friendsPage = 1

		dashData.logsData = nil
		dashData.logsLoad = false
		-- Reset danych: koniec --

		dashData.state = "starting"
		dashData.stateTime = getTickCount()
		addEventHandler("onClientRender", root, dashFunc.render)
		addEventHandler("onClientClick", root, dashFunc.onClientClick)
		addEventHandler("onClientKey", root, dashFunc.onClientKey)
		triggerServerEvent("dashFunc.hideHUD", localPlayer)
		triggerServerEvent("dashFunc.loadData", localPlayer)
		exports.titan_cursor:showCustomCursor("dashClientMain")

		-- LOAD SETTINGS
		local xmlFile
		if not fileExists("client/settings.xml") then
			xmlFile = xmlCreateFile("client/settings.xml", "settings")
		else
			xmlFile = xmlLoadFile("client/settings.xml")
		end
		local node, value

		node = xmlFindChild(xmlFile, "speedometer", 0)
		if not node then node = xmlCreateChild(xmlFile, "speedometer", 0) end
		value = xmlNodeGetValue(node)
		if not value or string.len(value) == 0 then
			value = "1"
			xmlNodeSetValue(node, "1")
		end
		for k, v in ipairs(dashFunc.settingsData[1].options) do
			if k == tonumber(value) then
				v[2] = true
			else
				v[2] = false
			end
		end

		node = xmlFindChild(xmlFile, "hdr", 0)
		if not node then node = xmlCreateChild(xmlFile, "hdr", 0) end
		value = xmlNodeGetValue(node)
		if not value or string.len(value) == 0 then
			value = "0"
			xmlNodeSetValue(node, "0")
		end
		dashFunc.settingsData[2].options[2] = tonumber(value) == 1 and true or false

		node = xmlFindChild(xmlFile, "chatsamp", 0)
		if not node then node = xmlCreateChild(xmlFile, "chatsamp", 0) end
		value = xmlNodeGetValue(node)
		if not value or string.len(value) == 0 then
			value = "0"
			xmlNodeSetValue(node, "0")
		end
		dashFunc.settingsData[5].options[2] = tonumber(value) == 1 and true or false

		xmlSaveFile(xmlFile)
		xmlUnloadFile(xmlFile)
	elseif dashData.state == "show" then
		dashData.stateTime = getTickCount()
		dashData.state = "hiding"
		exports.titan_cursor:hideCustomCursor("dashClientMain")
	end
end
bindKey("f2", "down", dashFunc.toggleDashboard)

function dashFunc.getData(vehicles, interiors, groups, name, data)
	dashData.vehicles = vehicles
	dashData.interiors = interiors
	dashData.groups = groups
	local name = string.format("temp/%s.png", string.gsub(string.gsub(string.gsub(string.gsub(name, ".png", ""), ".gif", ""), ".jpg", ""), "profile/", ""))
	local tmp = fileCreate(name)
	fileWrite(tmp, dxConvertPixels(data, 'png'))
	fileClose(tmp)
	dashData.file = name
end
addEvent("dashFunc.getData", true)
addEventHandler("dashFunc.getData", root, dashFunc.getData)

function dashFunc.getFriendsData(friends)
	dashData.friendsData = friends
end
addEvent("dashFunc.getFriendsData", true)
addEventHandler("dashFunc.getFriendsData", root, dashFunc.getFriendsData)

function dashFunc.setImageTable(key, imagedata, name)
	if not key or not imagedata then return end
	local name = string.format("temp/%s.png", string.gsub(string.gsub(string.gsub(string.gsub(name, ".png", ""), ".gif", ""), ".jpg", ""), "profile/", ""))
	
	local tmp = fileCreate(name)
	local file = fileWrite(tmp, tostring(dxConvertPixels(imagedata, 'png')))
	if not file then
		dashData.image[key] = "client/images/default_large.png"
	else
		dashData.image[key] = name
	end
	fileClose(tmp)
	--outputDebugString(string.format("%d: %s", key, name))
end
addEvent("dashFunc.setImageTable", true)
addEventHandler("dashFunc.setImageTable", root, dashFunc.setImageTable)

function dashFunc.getLogsData(logs)
	dashData.logsData = logs
end
addEvent("dashFunc.getLogsData", true)
addEventHandler("dashFunc.getLogsData", root, dashFunc.getLogsData)

--- Tutaj sobie będzie blur

------------------------------
--Apply the different stages--
------------------------------
function applyDownsample( Src, amount )
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src )
	return newRT
end

function applyGBlurH( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true )
	dxSetShaderValue( blurHShader, "tex0", Src )
	dxSetShaderValue( blurHShader, "tex0size", mx,my )
	dxSetShaderValue( blurHShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx, my, blurHShader )
	return newRT
end

function applyGBlurV( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true )
	dxSetShaderValue( blurVShader, "tex0", Src )
	dxSetShaderValue( blurVShader, "tex0size", mx,my )
	dxSetShaderValue( blurVShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	return newRT
end

function applyBrightPass( Src, cutoff, power )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true )
	dxSetShaderValue( brightPassShader, "tex0", Src )
	dxSetShaderValue( brightPassShader, "cutoff", cutoff )
	dxSetShaderValue( brightPassShader, "power", power )
	dxDrawImage( 0, 0, mx,my, brightPassShader )
	return newRT
end


--------------------------
--Pool of render targets--
--------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end

function dashFunc.setSettings()
	local xmlFile
	if not fileExists("client/settings.xml") then
		xmlFile = xmlCreateFile("client/settings.xml", "settings")
	else
		xmlFile = xmlLoadFile("client/settings.xml")
	end
	local node, value

	node = xmlFindChild(xmlFile, "speedometer", 0)
	if not node then node = xmlCreateChild(xmlFile, "speedometer", 0) end
	value = xmlNodeGetValue(node)
	if not value or string.len(value) == 0 then
		value = "1"
		xmlNodeSetValue(node, "1")
	end

	exports.titan_hud:setSpeedoSize(tonumber(value))
	outputDebugString(string.format("[DASH] Ustawienia wprowadzone (Licznik: %d)", tonumber(value)))

	node = xmlFindChild(xmlFile, "hdr", 0)
	if not node then node = xmlCreateChild(xmlFile, "hdr", 0) end
	value = xmlNodeGetValue(node)
	if not value or string.len(value) == 0 then
		value = "0"
		xmlNodeSetValue(node, "0")
	end

	exports.titan_hdr:switchContrast(tonumber(value) == 1 and true or false)
	outputDebugString(string.format("[DASH] Ustawienia wprowadzone (HDR: %d)", tonumber(value)))

	node = xmlFindChild(xmlFile, "chatsamp", 0)
	if not node then node = xmlCreateChild(xmlFile, "chatsamp", 0) end
	value = xmlNodeGetValue(node)
	if not value or string.len(value) == 0 then
		value = "0"
		xmlNodeSetValue(node, "0")
	end

	exports.titan_sampChat:toggleChat(tonumber(value) == 1 and true or false)
	outputDebugString(string.format("[DASH] Ustawienia wprowadzone (sampChat: %d)", tonumber(value)))

	xmlSaveFile(xmlFile)
	xmlUnloadFile(xmlFile)
end
addEvent("dashFunc.setSettings", true)
addEventHandler("dashFunc.setSettings", root, dashFunc.setSettings)

function getMonthFromNumber(int)
if int == 1 then return "stycznia" end
if int == 2 then return "lutego" end
if int == 3 then return "marca" end
if int == 4 then return "kwietnia" end
if int == 5 then return "maja" end
if int == 6 then return "czerwca" end
if int == 7 then return "lipca" end
if int == 8 then return "sierpnia" end
if int == 9 then return "września" end
if int == 10 then return "października" end
if int == 11 then return "listopada" end
if int == 12 then return "grudnia" end
end

function getCharacterNameFromMemberID(id)
	if not id then return false end

	for k,v in ipairs(getElementsByType("player")) do
		if getElementData(v, "memberID") == id then
			if not getElementData(v, "lastname") then return getElementData(v, "name") end
			return string.format("%s %s", getElementData(v, "name"), getElementData(v, "lastname"))
		end
	end
	return false
end
