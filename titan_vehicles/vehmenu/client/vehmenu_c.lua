----------------------------------------------------
-- CloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Value
-- Stworzono:   2016-07-28 18:14:22
-- Ostatnio zmodyfikowano: 2016-xx-xx xx:xx:xx
----------------------------------------------------

local sw,sh = guiGetScreenSize()
local selected = 1
local veh
local vehlock = 0
local isopen = false
local extras = {
	[555] = {0, 0, 1, 1},
	[439] = {1, 1, 2, 2},
}
local icons = {
	["doors"] = "icon_doors.png", 
	["hood"] = "icon_hood.png", 
	["windows"] = "icon_windows.png", 
	["trunk"] = "icon_trunk.png", 
	["audio"] = "icon_audio.png", 
	["plachta"] = "icon_windows.png",
	["roof"] = "icon_windows.png",
}
local position = {}

local slots = {
	['main'] = {(sw/800)*305, (sh/600)*175, (sw/800)*200, (sh/600)*200},
	-- Pozycje interaktywnych menu
	[1] = {(sw/800)*234, (sh/600)*133, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz pojazd
	[2] = {(sw/800)*376, (sh/600)*133, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz maskę
	[3] = {(sw/800)*234, (sh/600)*215, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz szyby
	[4] = {(sw/800)*376, (sh/600)*215, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz bagażnik
	[5] = {(sw/800)*305, (sh/600)*93, (sw/800)*200, (sh/600)*200}, -- Włącz/wyłącz audio 
	[6] = {(sw/800)*305, (sh/600)*255, (sw/800)*200, (sh/600)*200}, -- Rozłóż/złóż plandekę
}

local slots2 = {
	[1] = {(sw/800)*466, (sh/600)*295, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz pojazd
	[2] = {(sw/800)*750, (sh/600)*295, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz maskę
	[3] = {(sw/800)*466, (sh/600)*462, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz szyby
	[4] = {(sw/800)*750, (sh/600)*462, (sw/800)*200, (sh/600)*200}, -- Zamknij/otwórz bagażnik
	[5] = {(sw/800)*607, (sh/600)*220, (sw/800)*200, (sh/600)*200}, -- Włącz/wyłącz audio 
	[6] = {(sw/800)*607, (sh/600)*543, (sw/800)*200, (sh/600)*200}, -- Rozłóż/złóż plandekę
}

function vehRender()
	local s = 1
	dxDrawImage(slots['main'][1], slots['main'][2], slots['main'][3], slots['main'][4], "vehmenu/client/files/hex_main.png")
	
	for i,v in ipairs(position) do
		if selected == i then
			
			dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], "vehmenu/client/files/hex_empty.png", 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], "vehmenu/client/files/"..icons[v[1]], 0, 0, 0, tocolor(255, 255, 255, 255))
			dxDrawText(v[2], slots2[i][1], slots2[i][2], slots2[i][3], slots2[i][4], tocolor(0, 0, 0, 255), 0.7, "bankgothic", "center", "center")
		else
			dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], "vehmenu/client/files/hex_empty.png", 0, 0, 0, tocolor(255, 255, 255, 155))
			dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], "vehmenu/client/files/"..icons[v[1]], 0, 0, 0, tocolor(255, 255, 255, 155))
			dxDrawText(v[2], slots2[i][1], slots2[i][2], slots2[i][3], slots2[i][4], tocolor(0, 0, 0, 155), 0.7, "bankgothic", "center",  "center")
		end
	end
	--[[for i=1,#position do
		if selected == i then
			if not slots[i] then return end
			dxDrawImage(slots[s][1], slots[s][2], slots[s][3], slots[s][4], "files/"..icons['doors'], 0, 0, 0, tocolor(255, 255, 255, 255))
		else
			dxDrawImage(slots[i][1], slots[i][2], slots[i][3], slots[i][4], "files/"..icons['doors'], 0, 0, 0, tocolor(255, 255, 255, 155))
		end
		s = s + 1
	end]]
end


function createMenu()
	--if getElementData(localPlayer, "vehmenu:block") then return end
	veh = getNearestVehicle()
	position = {}
	--triggerServerEvent("vehlock", localPlayer, veh)
	if isVehicleLocked(veh) then
		table.insert(position, {"doors", "Otwórz\npojazd"})
	else
		table.insert(position, {"doors", "Zamknij\npojazd"})
	end
	if getVehicleDoorOpenRatio(veh, 0) == 1 then
		table.insert(position, {"hood", "Zamknij\nmaskę"})
	else
		table.insert(position, {"hood", "Otwórz\nmaskę"})
	end
	if getElementData(veh, "openWindows")  then
		table.insert(position, {"windows", "Zamknij\nokna"})
	else
		table.insert(position, {"windows", "Otwórz\nokna"})
	end
	if getVehicleDoorOpenRatio(veh, 1) == 1 then
		table.insert(position, {"trunk", "Zamknij\nbagażnik"})
	else
		table.insert(position, {"trunk", "Otwórz\nbagażnik"})
	end
	if isPedInVehicle(localPlayer) and getElementData(veh, "carAudio") then
		if getElementData(veh, "carAudioOn") then
			table.insert(position, {"audio", "Wyłącz\naudio"})
		else
			table.insert(position, {"audio", "Włącz\naudio"})
		end
	end
	if getElementModel(veh) == 505 and not isPedInVehicle(localPlayer) then
		if (getElementData(veh, "plachta") or false) then
			table.insert(position, {"plachta", "Ściągnij\npłachtę"})
		else
			table.insert(position, {"plachta", "Rozłóż\npłachtę"})
		end
	end
	local var1, var2 = getVehicleVariant(veh)
	if extras[getElementModel(veh)] then
		if var1 == extras[getElementModel(veh)][3] and var2 == extras[getElementModel(veh)][4] then
			table.insert(position, {"roof", "Rozłóż\ndach"})
		else
			table.insert(position, {"roof", "Złóż\ndach"})
		end
	end
	if not veh then
		exports.titan_noti:showBox("W pobliżu ciebie nie ma pojazdu")
		return
	end
	local x1, y1, z1 = getElementPosition(veh)
	local x2, y2, z2 = getElementPosition(localPlayer)
	local dist = getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
	if dist > 5 then
		exports.titan_noti:showBox("W pobliżu ciebie nie ma pojazdu")
		return
	end
	addEventHandler("onClientRender", getRootElement(), vehRender)
	showCursor(true)
	isopen = true
	selected = 1
	bindKey("arrow_r", "down", menu_next)
	bindKey("mouse_wheel_up", "down", menu_next)
	bindKey("arrow_l", "down", menu_prev)
	bindKey("mouse_wheel_down", "down", menu_prev)
	bindKey("mouse1", "down", menu_select)
end

function destroyMenu()
	removeEventHandler("onClientRender", getRootElement(), vehRender)
	
	isopen = false
	selected = 1
	unbindKey("arrow_r", "down", menu_next)
	unbindKey("mouse_wheel_up", "down", menu_next)
	unbindKey("arrow_l", "down", menu_prev)
	unbindKey("mouse_wheel_down", "down", menu_prev)
	unbindKey("mouse1", "down", menu_select)
	showCursor(false)
	setElementData(localPlayer, "vehmenu:block", true)
	setTimer(function ()
		setElementData(localPlayer, "vehmenu:block", false)
	end, 2000, 1)
end
addEvent("destroyMenu", true)
addEventHandler("destroyMenu", getRootElement(), destroyMenu)

function blockFire()
	if not isopen then return end
	cancelEvent()
end

function toggleMenu()
	if isopen then
		destroyMenu()
	else
		createMenu()
	end
end
bindKey("x", "down", toggleMenu)
addCommandHandler("vehmenu", toggleMenu)

function menu_next()
	if selected == #position then
		selected = 1
	else
		selected = selected + 1
	end
end

function menu_prev()
	if selected == 1 then
		selected = #position
	else
		selected = selected - 1
	end
end

function menu_select()
	local id = position[selected][1]
	triggerServerEvent("vehSelect", localPlayer, localPlayer, veh, id)
	destroyMenu()
end

function getNearestVehicle( player )
    local x, y, z = getElementPosition( localPlayer )
    local prevDistance
    local nearestVehicle
    for i, v in ipairs( getElementsByType( "vehicle" ) ) do
        local distance = getDistanceBetweenPoints3D( x, y, z, getElementPosition( v ) )
        if distance <= ( prevDistance or distance + 1 ) then
            prevDistance = distance
            nearestVehicle = v
        end
    end
    return nearestVehicle or false
end

function changelock(lock)
	vehlock = lock
end
addEvent("changelock", true)
addEventHandler("changelock", getRootElement(), changelock)

function togglePlachta(veh, state)
	setVehicleComponentVisible(veh, "#plachta", state)
	setElementData(veh, "plachta", state)
end
addEvent("togglePlachta", true)
addEventHandler("togglePlachta", getRootElement(), togglePlachta)

