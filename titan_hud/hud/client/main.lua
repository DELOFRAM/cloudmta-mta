----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function table.removeValue(table, val)
  for index, value in ipairs(table) do
    if value == val then
      table.remove(table, index)
        return index
        end
    end
    return false
end

function onResStart()
	setPlayerHudComponentVisible("clock", false)
	setPlayerHudComponentVisible("vehicle_name", false)
	setPlayerHudComponentVisible("area_name", false)
	setPlayerHudComponentVisible("money", false)
	setPlayerHudComponentVisible("ammo", false)
	setPlayerHudComponentVisible("armour", false)
	setPlayerHudComponentVisible("breath", false)
	setPlayerHudComponentVisible("health", false)
	setPlayerHudComponentVisible("weapon", false)
	setPlayerHudComponentVisible("radio", false)
	setPlayerHudComponentVisible("wanted", false)
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)


local sW, sH = guiGetScreenSize()
local renderData = {}

local font1 = dxCreateFont("hud/files/OpenSans-Regular.ttf", 15, true)
local font2 = dxCreateFont("hud/files/OpenSans-Light.ttf", 12, true)
local font3 = dxCreateFont("hud/files/OpenSans-Regular.ttf", 23, true)

local state, animTime, toggle = "none", 0, false

renderData.bgX = sW / 2 - 517 / 2
renderData.bgY = -105
renderData.bgW = 517
renderData.bgH = 200

renderData.gunX = sW / 2 - 90 / 2
renderData.gunY = 5
renderData.gunW = 90
renderData.gunH = 90

renderData.outlineHpX = renderData.bgX + 67
renderData.outlineHpY = renderData.bgH - 45 - 95
renderData.outlineHpW = 140
renderData.outlineHpH = 17

renderData.outlineHunX = renderData.bgX + 67 + 240
renderData.outlineHunY = renderData.bgH - 45 - 95
renderData.outlineHunW = 140
renderData.outlineHunH = 17

renderData.outlineArmorX = renderData.outlineHpX
renderData.outlineArmorY = renderData.outlineHpY + 17 + 1
renderData.outlineArmorW = 140
renderData.outlineArmorH = 17

renderData.outlineOxygenX = renderData.outlineHunX
renderData.outlineOxygenY = renderData.outlineHunY + 17 + 1
renderData.outlineOxygenW = 140
renderData.outlineOxygenH = 17

renderData.hpX = renderData.outlineHpX + 5
renderData.hpY = renderData.outlineHpY + 5
renderData.hpW = 130
renderData.hpH = 7

renderData.hunX = renderData.outlineHunX + 5
renderData.hunY = renderData.outlineHunY + 5
renderData.hunW = 130
renderData.hunH = 7

renderData.armorX = renderData.outlineArmorX + 5
renderData.armorY = renderData.outlineArmorY + 5
renderData.armorW = 130
renderData.armorH = 7

renderData.oxygenX = renderData.outlineOxygenX + 5
renderData.oxygenY = renderData.outlineOxygenY + 5
renderData.oxygenW = 130
renderData.oxygenH = 7

renderData.outlineStatusX = math.floor(sW / 2 - 321 / 2)
renderData.outlineStatusY = renderData.armorY + 15
renderData.outlineStatusW = 321
renderData.outlineStatusH = 24

renderData.statusX = renderData.outlineStatusX + 8
renderData.statusY = renderData.outlineStatusY + 8
renderData.statusW = 303
renderData.statusH = 8

renderData.walletX = renderData.outlineArmorX - 15
renderData.walletY = 54 / 2 - 15
renderData.walletW = 20
renderData.walletH = 20

renderData.walletTextX = renderData.walletX + 30
renderData.walletTextY = renderData.walletY + 3
renderData.walletTextW = sW / 2 - 50
renderData.walletTextH = renderData.walletY + 20

-- renderData.adminX = renderData.IDIconX + renderData.IDIconW + 10
-- renderData.adminY = renderData.IDIconY

renderData.IDIconX = sW / 2 + 70
renderData.IDIconY = 5
renderData.IDIconW = 26
renderData.IDIconH = 26

renderData.IDTextX = (renderData.IDIconX + 13)
renderData.IDTextY = renderData.IDIconY + renderData.IDIconH
renderData.IDTextW = (renderData.IDIconX + 13)
renderData.IDTextH = renderData.IDTextY

renderData.EQIconX = renderData.IDIconX + 55
renderData.EQIconY = 5
renderData.EQIconW = 26
renderData.EQIconH = 26

renderData.EQTextX = (renderData.EQIconX + 13)
renderData.EQTextY = renderData.EQIconY + renderData.EQIconH
renderData.EQTextW = (renderData.EQIconX + 13)
renderData.EQTextH = renderData.EQTextY

renderData.FriendsIconX = renderData.EQIconX + 55
renderData.FriendsIconY = 5
renderData.FriendsIconW = 26
renderData.FriendsIconH = 26

renderData.FriendsTextX = (renderData.FriendsIconX + 13)
renderData.FriendsTextY = renderData.FriendsIconY + renderData.FriendsIconH
renderData.FriendsTextW = (renderData.FriendsIconX + 13)
renderData.FriendsTextH = renderData.FriendsTextY

renderData.legendX = renderData.bgX + 250
renderData.legendY = renderData.bgY + 40
renderData.legendW = 83
renderData.legendH = 50

renderData.iconX = renderData.legendX + 150
renderData.iconY = renderData.bgY + 5
renderData.iconW = 76
renderData.iconH = 90

renderData.cashState = 0
renderData.cashTime = 0
renderData.friendsOnline = 0
renderData.items = 0

renderData.reports = false

renderData.offer = {toggle = false}

renderData.statusOn = false
renderData.statusState = 0

function setStatus(state)
	renderData.statusOn = state
end
addEvent("hud:setStatus", true)
addEventHandler("hud:setStatus", root, setStatus)

function setStatusState(state)
	renderData.statusState = state
end
addEvent("hud:setStatusState", true)
addEventHandler("hud:setStatusState", root, setStatusState)

function renderSGamingHUD()
	local addHeight = 0
	if(state == "starting") then
		local progress = (getTickCount() - animTime) / 1500
		addHeight = math.floor(interpolateBetween(-150, 0, 0, 0, 0, 0, progress, "OutQuad"))

		if(progress > 1) then
			state = "showing"
		end
	elseif(state == "hiding") then
		local progress = (getTickCount() - animTime) / 1500
		addHeight = math.floor(interpolateBetween(0, 0, 0, -150, 0, 0, progress, "InQuad"))
		if(progress > 1) then
			removeEventHandler("onClientRender", root, renderSGamingHUD)
		end
	end

	if(renderData.offer.toggle) then
		if(renderData.offer.state == "starting") then
			local progress = (getTickCount() - renderData.offer.time) / 1500
			addHeight = math.floor(interpolateBetween(0, 0, 0, 105, 0, 0, progress, "InOutQuad"))
			if(progress > 1) then
				renderData.offer.state = "showing"
			end
		elseif(renderData.offer.state == "showing") then
			addHeight = 105
		elseif(renderData.offer.state == "hiding") then
			local progress = (getTickCount() - renderData.offer.time) / 1500
			addHeight = math.floor(interpolateBetween(105, 0, 0, 0, 0, 0, progress, "InOutQuad"))
			if(progress > 1) then
				renderData.offer = {toggle = false}
			end
		end
	end

	if localPlayer:getData("dashboardOn") then return end
	if localPlayer:getData("hide:playerRadar") then return end
	
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- local duties = {}
	-- if localPlayer:getData("adminDuty") then
		-- table.insert(duties, {name = "Duty administratora", color = {255, 0, 0}})
		-- if renderData.reports then
			-- table.insert(duties, {name = "Nowe raporty", color = {200, 10, 10}})
		-- end
	-- end
	-- if localPlayer:getData("groupDutyID") then
		-- local dutyColor = getElementData(localPlayer, "groupDutyColor")
		-- local dutyTag = getElementData(localPlayer, "GroupDutyTag")
		-- if dutyColor and dutyTag then
			-- table.insert(duties, {name = "Duty "..dutyTag, color = {dutyColor[1], dutyColor[2], dutyColor[3]}})
		-- end
	-- end

	dxDrawImage(renderData.bgX, renderData.bgY + addHeight, renderData.bgW, renderData.bgH, "hud/files/allHUDbg.png")
	local weapon = getPedWeapon(localPlayer)
	local sciezka = "hud/files/icons/"..weapon..".png"
	dxDrawImage(renderData.gunX, renderData.gunY + addHeight, renderData.gunW, renderData.gunH, sciezka, 0, 0, 0, tocolor(255, 255, 255, 220))
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- USUNIĘTE NA PROŚBĘ RUBIKA
	-- for k, v in ipairs(duties) do
		-- if k < 4 then
			-- dxDrawText(v.name, renderData.adminX, renderData.adminY + addHeight + (k - 1) * 15, 0, 0, tocolor(v.color[1], v.color[2], v.color[3], 200), 1.0, "default-bold", "left", "top", false, false, false, false, false, 0, 0, 0)
		-- end
	-- end
	if(getSlotFromWeapon(weapon) and getSlotFromWeapon(weapon) > 1) then
		local ammoInClip = getPedAmmoInClip(localPlayer)
		local totalAmmo = getPedTotalAmmo(localPlayer) - ammoInClip
		dxDrawText(string.format("%d / %d", ammoInClip, totalAmmo), renderData.gunX, renderData.gunY + addHeight + renderData.gunH - 25, renderData.gunX + renderData.gunW, renderData.gunY + addHeight + renderData.gunH, tocolor(255, 255, 255, 100), 0.75, font2, "center", "top")
	end
	dxDrawImage(renderData.outlineHpX, renderData.outlineHpY + addHeight, renderData.outlineHpW, renderData.outlineHpH, "hud/files/stan_obrys.png")
	dxDrawImage(renderData.outlineHunX, renderData.outlineHunY + addHeight, renderData.outlineHunW, renderData.outlineHunH, "hud/files/stan_obrys.png")


	local HP = getElementHealth(localPlayer)
	local progress = HP / 100
	if(progress > 1) then progress = 1 end
	dxDrawImageSection(renderData.hpX, renderData.hpY + addHeight, 130 * progress, renderData.hpH, 0, 0, 130 * progress, 7, "hud/files/stan_zycie.png")

	if tonumber(localPlayer:getData("hungryLevel")) then
		local progress = localPlayer:getData("hungryLevel") / 100
		if progress > 1 then progress = 1 elseif progress < 0 then progress = 0 end
		dxDrawImageSection(renderData.hunX, renderData.hunY + addHeight, 130 * progress, renderData.hunH, 0, 0, 130 * progress, 7, "hud/files/stan_glod.png", 0, 0, 0, tocolor(255, 255, 255, 255))

		local armor = getPedArmor(localPlayer)
		if(armor > 0) then
			local progress = armor / 100
			if(progress > 1) then progress = 1 end
			dxDrawImage(renderData.outlineArmorX, renderData.outlineArmorY + addHeight, renderData.outlineArmorW, renderData.outlineArmorH, "hud/files/stan_obrys.png")
			dxDrawImageSection(renderData.armorX, renderData.armorY + addHeight, 130 * progress, renderData.armorH, 0, 0, 130 * progress, 7, "hud/files/stan_pancerz.png", 0, 0, 0, tocolor(255, 255, 255, 255))
		end
	end
	
	if isElementInWater(localPlayer) then
		local oxygen = getPedOxygenLevel(localPlayer)
		local progress = oxygen / 1000
		if progress > 1000 then progress = 1000 elseif progress < 0 then progress = 0 end
		dxDrawImage(renderData.outlineOxygenX, renderData.outlineOxygenY + addHeight, renderData.outlineOxygenW, renderData.outlineOxygenH, "hud/files/stan_obrys.png")
		dxDrawImageSection(renderData.oxygenX, renderData.oxygenY + addHeight, 130 * progress, renderData.oxygenH, 0, 0, 130 * progress, 7, "hud/files/stan_oxygen.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end
	-- hajs; 135, 150, 90 - kolor

	if renderData.statusOn then
		local progress = tonumber(renderData.statusState)
		if progress > 1 then progress = 1 end
		dxDrawImage(renderData.outlineStatusX, renderData.outlineStatusY + addHeight, renderData.outlineStatusW, renderData.outlineStatusH, "hud/files/status_obrys.png")
		dxDrawImageSection(renderData.statusX, renderData.statusY + addHeight, renderData.statusW * progress, renderData.statusH, 0, 0, renderData.statusW * progress, 7, "hud/files/status.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	end

	local playerMoney = getElementData(localPlayer, "money")
	if(not tonumber(playerMoney)) then playerMoney = 0 end

	
	dxDrawImage(renderData.walletX, renderData.walletY + addHeight, renderData.walletW, renderData.walletH, "hud/files/pay_portfel.png")
	local r, g, b = 135, 150, 90
	if(renderData.cashState == 1) then
		local progress = (getTickCount() - renderData.cashTime) / 3000
		r, g, b = interpolateBetween(202, 87, 19, 135, 150, 90, progress, "InBack")
		if(progress > 1) then
			renderData.cashState = 0
			renderData.cashTime = 0
		end
	end
	dxDrawText("$"..giveNumberWithZeros(playerMoney), renderData.walletTextX, renderData.walletTextY + addHeight, renderData.walletTextW, renderData.walletTextH + addHeight, tocolor(r, g, b, 255), 0.8, font1, "left", "center", false, false, false, false, false, 0, 0, 0)

	-- playerUID
	local pUID = getElementData(localPlayer, "playerID")
	if(not tonumber(pUID)) then
		pUID = "BRAK"
	end

	local fontID = dxGetTextWidth(tostring(pUID), 1.0, font2)
	local fontFriends = dxGetTextWidth(tostring(renderData.friendsOnline), 1.0, font2)
	local fontItems = dxGetTextWidth(tostring(renderData.items).."/35", 1.0, font2)

	dxDrawImage(renderData.IDIconX, renderData.IDIconY + addHeight, renderData.IDIconW, renderData.IDIconH, "hud/files/ikona_identyfikator.png")
	dxDrawText(pUID, renderData.IDTextX - fontID / 2, renderData.IDTextY + addHeight, renderData.IDTextW, renderData.IDTextH, tocolor(135, 150, 90, 255), 1.0, font2, "left", "top", false, false, false, false, false, 0, 0, 0)

	dxDrawImage(renderData.FriendsIconX, renderData.FriendsIconY + addHeight, renderData.FriendsIconW, renderData.FriendsIconH, "hud/files/ikona_znajomi.png")
	dxDrawText(renderData.friendsOnline, renderData.FriendsTextX - fontFriends / 2, renderData.FriendsTextY + addHeight, renderData.FriendsTextW, renderData.FriendsTextH, tocolor(135, 150, 90, 255), 1.0, font2, "left", "top", false, false, false, false, false, 0, 0, 0)

	dxDrawImage(renderData.EQIconX, renderData.EQIconY + addHeight, renderData.EQIconW, renderData.EQIconH, "hud/files/ikona_ekwipunek.png")
	dxDrawText(renderData.items.."/35", renderData.EQTextX - fontItems / 2, renderData.EQTextY + addHeight, renderData.EQTextW, renderData.EQTextH, tocolor(135, 150, 90, 255), 1.0, font2, "left", "top", false, false, false, false, false, 0, 0, 0)

	------------
	-- OFERTY --
	------------

	if(renderData.offer.toggle) then
		local posY = renderData.bgY + addHeight

		dxDrawText(string.format("#cacac4Oferta od #ffffff%s #cacac4ID #ffffff%s", renderData.offer.from, tostring(renderData.offer.fromID)), renderData.bgX + 15, posY + 3, 0, 0, tocolor(255, 255, 255, 255), 0.7, font1, "left", "top", false, false, false, true, true)
		--dxDrawText(string.format("#cacac4Oferta od #ffffff%s", renderData.offer.from), renderData.bgX + 15, posY + 3, 0, 0, tocolor(255, 255, 255, 255), 0.7, font1, "left", "top", false, false, false, true, true)
		--dxDrawText(string.format("#cacac4ID #ffffff%s", tostring(renderData.offer.fromID)), renderData.bgX + 15, posY + 20, 0, 0, tocolor(255, 255, 255, 255), 0.5, font1, "left", "top", false, false, false, true, true)
		dxDrawText(renderData.offer.name, renderData.bgX + 15, posY + 40, 0, 0, tocolor(255, 255, 255, 255), 0.6, font3, "left", "top", false, false, false, true, true)

		dxDrawImage(renderData.bgX + 20, posY + 65, 19, 19, "hud/files/money.png")
		dxDrawText(renderData.offer.price == 0 and "za darmo" or "$"..renderData.offer.price, renderData.bgX + 45, posY + 65, 0, 0, tocolor(141, 160, 65, 255), 0.8, font1, "left", "top", false, false, false, false, true)
		
		dxDrawImage(renderData.legendX, renderData.legendY + addHeight, renderData.legendW, renderData.legendH, "hud/files/legend.png")
		if fileExists("hud/files/icon_"..renderData.offer.type..".png") then renderData.path = "hud/files/icon_"..renderData.offer.type..".png" else renderData.path = "hud/files/icon_other.png" end
		dxDrawImage(renderData.iconX, renderData.iconY + addHeight, renderData.iconW, renderData.iconH, renderData.path)
	end
end

function onResStart()
	if(getElementData(localPlayer, "loggedIn")) then
		showSGamingHUD()
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)

function giveNumberWithZeros(number)
	local numberFormat = ""
	if(number >= 0 and number < 1000) then
	--if(number >= 0 and number < 10) then
		--numberFormat = "000.000.00"..number
		-- numberFormat = number
	-- elseif(number >= 10 and number < 100) then
		--numberFormat = "000.000.0"..number
		-- numberFormat = number
	-- elseif(number >= 100 and number < 1000) then
		--numberFormat = "000.000."..number
		numberFormat = number
	elseif(number >= 1000 and number < 10000) then
		--numberFormat = "000.00"..string.sub(tostring(number), 1, 1).."."..string.sub(tostring(number), 2)
		numberFormat = string.sub(tostring(number), 1, 1).."."..string.sub(tostring(number), 2)
	elseif(number >= 10000 and number < 100000) then
		--numberFormat = "000.0"..string.sub(tostring(number), 1, 2).."."..string.sub(tostring(number), 3)
		numberFormat = string.sub(tostring(number), 1, 2).."."..string.sub(tostring(number), 3)
	elseif(number >= 100000 and number < 1000000) then
		--numberFormat = "000."..string.sub(tostring(number), 1, 3).."."..string.sub(tostring(number), 4)
		numberFormat = string.sub(tostring(number), 1, 3).."."..string.sub(tostring(number), 4)
	elseif(number >= 1000000 and number < 10000000) then
		--numberFormat = "00"..string.sub(tostring(number), 1, 1).."."..string.sub(tostring(number), 2, 4).."."..string.sub(tostring(number), 5, 7)
		numberFormat = string.sub(tostring(number), 1, 1).."."..string.sub(tostring(number), 2, 4).."."..string.sub(tostring(number), 5, 7)
	elseif(number >= 10000000 and number < 100000000) then
		--numberFormat = "0"..string.sub(tostring(number), 1, 2).."."..string.sub(tostring(number), 3, 5).."."..string.sub(tostring(number), 6, 8)
		numberFormat = string.sub(tostring(number), 1, 2).."."..string.sub(tostring(number), 3, 5).."."..string.sub(tostring(number), 6, 8)
	elseif(number >= 100000000 and number < 1000000000) then
		--numberFormat = string.sub(tostring(number), 1, 3).."."..string.sub(tostring(number), 4, 6).."."..string.sub(tostring(number), 7, 9)
		numberFormat = string.sub(tostring(number), 1, 3).."."..string.sub(tostring(number), 4, 6).."."..string.sub(tostring(number), 7, 9)
	elseif(number < 0 and number > - 1000) then
		numberFormat = number
	elseif(number <= -1000 and number > -10000) then
		numberFormat = "-"..string.sub(tostring(number), 2, 2).."."..string.sub(tostring(number), 3)
	elseif(number <= -10000 and number > -100000) then
		numberFormat = "-"..string.sub(tostring(number), 2, 3).."."..string.sub(tostring(number), 4)
	elseif(number <= -100000 and number > -1000000) then
		numberFormat = "-"..string.sub(tostring(number), 2, 4).."."..string.sub(tostring(number), 5)
	elseif(number <= -1000000 and number > -10000000) then
		numberFormat = "-"..string.sub(tostring(number), 2, 2).."."..string.sub(tostring(number), 3, 5).."."..string.sub(tostring(number), 6, 8)
	elseif(number <= -10000000 and number > -100000000) then
		numberFormat = "-"..string.sub(tostring(number), 2, 3).."."..string.sub(tostring(number), 4, 6).."."..string.sub(tostring(number), 7, 9)
	elseif(number <= -100000000 and number > -1000000000) then
		numberFormat = "-"..string.sub(tostring(number), 2, 4).."."..string.sub(tostring(number), 5, 7).."."..string.sub(tostring(number), 8, 10)
	elseif number < -1000000000 then
		numberFormat = "-999.999.999"
	elseif number > 1000000000 then
		numberFormat = "+999.999.999"
	end
	return numberFormat
end

function showSGamingHUD()
	if(toggle) then return end
	toggle = true
	animTime = getTickCount()
	state = "starting"
	addEventHandler("onClientRender", root, renderSGamingHUD)
	triggerServerEvent("hud.items.s", localPlayer)
	triggerServerEvent("hud.friends.s", localPlayer)
end
addEvent("showSGamingHUD", true)
addEventHandler("showSGamingHUD", root, showSGamingHUD)

function hideSGamingHUD()
	if(not toggle) then return end
	toggle = false
	animTime = getTickCount()
	state = "hiding"
end
addEvent("hideSGamingHUD", true)
addEventHandler("hideSGamingHUD", root, hideSGamingHUD)

function cashClick()
	renderData.cashTime = getTickCount()
	renderData.cashState = 1
end
addEvent("cashClick", true)
addEventHandler("cashClick", root, cashClick)

------------
-- EVENTY --
------------

function onClientGetOffer(offerType, from, fromID, price, name)
	renderData.offer = 
	{
		toggle = true,
		state = "starting",
		time = getTickCount(),
		from = from,
		fromID = fromID,
		name = name,
		price = price,
		type = offerType
	}
	addEventHandler("onClientKey", root, onKey)
end
addEvent("onClientGetOffer", true)
addEventHandler("onClientGetOffer", root, onClientGetOffer)

function onClientHideOffer()
	if(renderData.offer.toggle) then
		renderData.offer.state = "hiding"
		renderData.offer.time = getTickCount()
		removeEventHandler("onClientKey", root, onKey)
	end
end
addEvent("onClientHideOffer", true)
addEventHandler("onClientHideOffer", root, onClientHideOffer)

function onKey(button, press)
	if(press) then
		if(button == "[") then -- accept
			triggerServerEvent("onClientOffer", localPlayer, localPlayer, true)
			onClientHideOffer()
		elseif(button == "]") then -- decline
			triggerServerEvent("onClientOffer", localPlayer, localPlayer, false)
			onClientHideOffer()
		end
	end
end

function onReportsChange(state)
	renderData.reports = state
end
addEvent("onReportsChange", true)
addEventHandler("onReportsChange", root, onReportsChange)

function getPlayerItems(items)
	renderData.items = items
end
addEvent("hud.items.c", true)
addEventHandler("hud.items.c", root, getPlayerItems)

function getPlayerFriends(friends)
local tmp = {}
	for k,v in ipairs(friends) do
		if v.game_inGame == 1 then
		table.insert(tmp, v)
		else
		table.removeValue(tmp, v)
		end
	end
renderData.friendsOnline = string.format("%d", #tmp)
--renderData.friendsOnline = string.format("%d/%d", #tmp, #friends)
end
addEvent("hud.friends.c", true)
addEventHandler("hud.friends.c", root, getPlayerFriends)