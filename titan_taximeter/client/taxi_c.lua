----------------------------------------------------
-- CloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Value
-- Stworzono:   2016-07-24 20:47:22
-- Ostatnio zmodyfikowano: 2016-07-25 11:54:22
----------------------------------------------------


local distance, bg, stawka, timer
local lu=getTickCount()
 
local function addDistance(veh)
    if (getTickCount()-lu>250) then
    lu=getTickCount()
    local vx,vy,vz=getElementVelocity(veh)
    local spd=((vx^2 + vy^2 + vz^2)^(0.5)/10)
    local driver = getVehicleOccupant(veh)
    if (spd>0) then
        distance = distance+(spd)
        setElementData(driver, "taxi:dist", distance)
        setElementData(localPlayer, "taxi:dist", distance)
        updateTaxometr()
    end
    end
end
 
function updateDistance()
    local v=getPedOccupiedVehicle(localPlayer)
    local isTaxometr = getElementData(localPlayer, "taxi:is") or false
    if (not v) then return end
    if (not isTaxometr) then return end
    if (not getVehicleEngineState(v)) then return end
    if (getVehicleController(v)~=localPlayer) then return end
    addDistance(v)
end
 
function render()
    if not isPedInVehicle(localPlayer) then return end
    local veh = getPedOccupiedVehicle(localPlayer)
    local driver = getVehicleOccupant(veh, 0)
    if not driver then return end
    local dist = getElementData(driver, "taxi:dist") or 0
    dxDrawText(math.floor(dist), 0, 0)
    updateTaxometr()
end

function getCurrentDate()
	local time = getRealTime() -- Czas z Reala (sklepu KAPPA)
    local hour, minutes = getTime() -- Czas z gry
	local day, month
	if hour < 9 then
		hour = "0"..hour
	end
	if minutes < 10 then
		minutes = "0"..minutes
	end
	if (time.month+1) < 10 then
		day = "0"..(time.month)
	else
		day = time.month
	end
	if (time.monthday) < 10 then
		month = "0"..time.monthday
	else
		month = time.monthday
	end
	return day.."/"..(month+1).."/"..(1900+time.year).." "..hour..":"..minutes
end

function createTaxometr(veh)
    local sw,sh = guiGetScreenSize()
   
   -- local veh = getPedOccupiedVehicle(localPlayer) or false
    local driver =  localPlayer
	local nickname = getElementData(driver, "name").. " "..getElementData(driver, "lastname")
   
	local lenght = nickname:len()
	if lenght >= 30 then
		nickname = string.sub(nickname, 0, 27)
		lenght = nickname:len()
		nickname = nickname.."..."
	end
    local size1 = math.floor((20/1600)*sw)
    local size2 = math.floor((30/1600)*sw)
    local font1 = guiCreateFont("client/files/myriardpro.OTF", size1)
    local font3 = guiCreateFont("client/files/myriardpro.OTF", size1-(lenght/2.4))
    local font2 = guiCreateFont("client/files/myriardpro.OTF", size2)
   
    distance = getElementData(localPlayer, "taxi:distance") or 0 -- Przejechany dystans
    stawka = 3 -- Hajsy za kilometr
   
    bg = guiCreateStaticImage(0.38, 0.825, 0.29, 0.2, "/client/files/bg.png", true)
    driver_costpkm = guiCreateLabel(0.09, 0.03, 1, 1, "$"..stawka.."/km", true, bg)
    driver_name = guiCreateLabel(0.09, 0.17+(lenght/1000), 1, 1, nickname, true, bg)
    driver_date = guiCreateLabel(0.03, 0.35, 1, 1, getCurrentDate(), true, bg)
    driver_distance = guiCreateLabel(0.55, 0.05, 1, 1, math.floor(distance).."km", true, bg)
    driver_money = guiCreateLabel(0.55, 0.28, 1, 1, "$"..(math.floor(distance)*stawka), true, bg)
   
    guiSetFont(driver_costpkm, font1)
    guiSetFont(driver_name, font1)
    guiSetFont(driver_name, font3)
    guiSetFont(driver_date, font1)
    guiSetFont(driver_distance, font2)
    guiSetFont(driver_money, font2)
   
    addEventHandler("onClientRender", getRootElement(), updateDistance)
	addEventHandler("onClientRender", getRootElement(), render)
end
addEvent("createTaxometr", true)
addEventHandler("createTaxometr", getRootElement(), createTaxometr)
 
function updateTaxometr()
    local veh = getPedOccupiedVehicle(localPlayer)
    local driver = getVehicleOccupant(veh)
    local target = getElementData(driver, "taxi:target")
    local dist = getElementData(driver, "taxi:dist") or "ERROR"
    if not veh or not driver or not target or not dist then return end
	local nickname = getElementData(driver, "name").. " "..getElementData(driver, "lastname")
   
	local lenght = nickname:len()
	if lenght >= 30 then
		nickname = string.sub(nickname, 0, 27)
		lenght = nickname:len()
		nickname = nickname.."..."
	end
    guiSetText(driver_costpkm, "$"..stawka.."/km")
    guiSetText(driver_name, nickname)
    guiSetText(driver_distance, math.floor(dist).."km")
    guiSetText(driver_money, "$"..(math.floor(dist)*stawka))
    guiSetText(driver_date, getCurrentDate())
end
 
function destroyTaxometr(plr, seat)
    if not getElementData(plr, "taxi:is") then return end
    if seat == 0 then
        local target = getElementData(plr, "taxi:target")
        local hajsik = (math.floor(getElementData(plr, "taxi:dist") or 0)*(stawka or 3))
        setElementData(target, "taxi:is", false)
        setElementData(plr, "taxi:is", false)
       -- triggerServerEvent("taxiEnd", plr, plr, target, hajsik)
        if plr == localPlayer then
            --outputChatBox("YOLO")
        end
        local forDriver = math.floor(hajsik*0.25) -- Kierowca dostaje 25% pieniędzy za przejazd
        local forCorp = math.floor(hajsik-forDriver) -- Firma dostaje 75% pieniędzy za przejazd
        if plr == localPlayer then
            --exports.titan_noti:showBox("Przejazd zakończony! Firma otrzymuje $"..forCorp)
            triggerServerEvent("taxiEnd", plr, plr, target, hajsik)
        end
         if isElement(bg) then
            destroyElement(bg)
            removeEventHandler("onClientRender", getRootElement(), updateDistance)
            removeEventHandler("onClientRender", getRootElement(), render)
        end
    else
        local driver = getVehicleOccupant(source, 0)
        local target = getElementData(driver, "taxi:target")
        if target ~= plr then return end
        local hajsik = (math.floor(getElementData(driver, "taxi:dist") or 0)*stawka)
        setElementData(plr, "taxi:is", false)
        setElementData(driver, "taxi:is", false)
        --triggerServerEvent("taxiEnd", driver, driver, target, hajsik)
        if driver == localPlayer then
            triggerServerEvent("taxiEnd", driver, driver, target, hajsik)
        end
         if isElement(bg) then
            destroyElement(bg)
            removeEventHandler("onClientRender", getRootElement(), updateDistance)
            removeEventHandler("onClientRender", getRootElement(), render)
        end
    end
    return
end
addEventHandler("onClientVehicleExit", getRootElement(), destroyTaxometr)

function playerExit()
	if not getElementData(source, "taxi:is") then return end
	local seat = getPedOccupiedVehicleSeat(source)
	if seat == 0 then -- Wyszedł kierowca
		local target = getElementData(source, "taxi:target")
		local dist = math.floor(getElementData(source, "taxi:dist") or 0)
		local hajsik = (dist*stawka)
		setElementData(source, "taxi:is", false)
		setElementData(target, "taxi:is", false)
		triggerServerEvent("taxiEnd", source, source, target, hajsik)
		 if isElement(bg) then
			destroyElement(bg)
			removeEventHandler("onClientRender", getRootElement(), updateDistance) 
			removeEventHandler("onClientRender", getRootElement(), render)
		end
	else
		local veh = getPedOccupiedVehicle(source)
		local driver = getVehicleOccupant(veh, 0)
		local target = getElementData(driver, "taxi:target")
		if target ~= source then return end
		local dist = math.floor(getElementData(driver, "taxi:dist") or 0)
		local hajsik = (dist*stawka)
		setElementData(driver, "taxi:is", false)
		setElementData(target, "taxi:is", false)
		triggerServerEvent("taxiEnd", source, driver, target, hajsik)
		 if isElement(bg) then
			destroyElement(bg)
			removeEventHandler("onClientRender", getRootElement(), updateDistance) 
			removeEventHandler("onClientRender", getRootElement(), render)
		end
	end
end
addEventHandler("onClientPlayerQuit", getRootElement(), playerExit)

addEventHandler("onClientResourceStart", resourceRoot, function ()
	for i,v in ipairs(getElementsByType("player")) do
		setElementData(v, "taxi:is", false)
	end
end)