local distance, bg, stawka, timer
local lu=getTickCount()
local font1 = guiCreateFont("files/myriardpro.OTF", 20)
local font2 = guiCreateFont("files/myriardpro.OTF", 30)

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
	--outputChatBox("a")
end

function render()
	if not isPedInVehicle(localPlayer) then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	local driver = getVehicleOccupant(veh, 0) 
	local dist = getElementData(driver, "taxi:dist") or 0
	dxDrawText(math.floor(dist), 0, 0)
	updateTaxometr()
end

--[[function updateDistance()
	if isPedInVehicle(localPlayer) and getVehicleOccupant(getPedOccupiedVehicle(localPlayer)) == localPlayer then
		local veh = getPedOccupiedVehicle(localPlayer)
		if not ox or not oy or not oz then ox, oy, oz = getElementPosition(veh) end
		if not distance then distance = 0 end
		local vx, vy, vz = getElementPosition(veh)
		local dist = getDistanceBetweenPoints3D(ox, oy, oz, vx, vy, vz)
		setElementData(veh, "distance", getElementData(veh, "distance") or 0 + dist)
		ox, oy, oz = vx, vy, vz
	end
end]]


function createTaxometr(veh)
	local time = getRealTime() -- Czas z Reala (sklepu KAPPA)
	local hour, minutes = getTime() -- Czas z gry
	local veh = getPedOccupiedVehicle(localPlayer)
	local driver = getVehicleOccupant(veh)
	
	outputChatBox("Oferta została zaakceptowana!")
	
	distance = getElementData(localPlayer, "taxi:distance") or 0 -- Przejechany dystans
	stawka = 3 -- Hajsy za kilometr
	
	bg = guiCreateStaticImage(0.38, 0.825, 0.29, 0.2, "files/bg.png", true)
	driver_costpkm = guiCreateLabel(0.09, 0.03, 0.4, 0.1, "$"..stawka.."/km", true, bg)
	driver_name = guiCreateLabel(0.09, 0.17, 0.4, 0.5, getElementData(driver, "name").. " "..getElementData(driver, "lastname"), true, bg)
	driver_date = guiCreateLabel(0.03, 0.35, 0.4, 0.1, time.monthday.."/"..(time.month+1).."/"..(1900+time.year).." "..hour..":"..minutes, true, bg)
	driver_distance = guiCreateLabel(0.55, 0.05, 0.4, 0.15, math.floor(distance).."km", true, bg)
	driver_money = guiCreateLabel(0.55, 0.28, 0.4, 0.15, "$"..(math.floor(distance)*stawka), true, bg)
	
	guiSetFont(driver_costpkm, font1)
	guiSetFont(driver_name, font1)
	guiSetFont(driver_date, font1)
	guiSetFont(driver_distance, font2)
	guiSetFont(driver_money, font2)
	
	addEventHandler("onClientRender", getRootElement(), updateDistance)	
	addEventHandler("onClientRender", getRootElement(), render)
	--[[timer = setTimer(function ()
		updateDistance()
	end, 100, 0)]]
end
addEvent("createTaxometr", true)
addEventHandler("createTaxometr", getRootElement(), createTaxometr)

function updateTaxometr()
	local veh = getPedOccupiedVehicle(localPlayer)
	local driver = getVehicleOccupant(veh)
	local target = getElementData(driver, "taxi:target")
	local dist = getElementData(driver, "taxi:dist") or "ERROR"
	guiSetText(driver_costpkm, "$"..stawka.."/km")
	guiSetText(driver_name, getElementData(driver, "name").. " "..getElementData(driver, "lastname"))
	guiSetText(driver_distance, math.floor(dist).."km")
	guiSetText(driver_money, "$"..(math.floor(dist)*stawka))
end

function destroyTaxometr(plr)
	if not isElement(bg) then return end
	destroyElement(bg)
	removeEventHandler("onClientRender", getRootElement(), updateDistance)	
	removeEventHandler("onClientRender", getRootElement(), render)
	if not getElementData(plr, "taxi:is") then return end
	--local veh = getPedOccupiedVehicle(localPlayer)
	local driver = getVehicleOccupant(source, 0) 
	local hajsik = (math.floor(getElementData(driver, "taxi:dist") or 0)*stawka)
	outputChatBox("$"..hajsik)
end
addEventHandler("onClientVehicleExit", getRootElement(), destroyTaxometr)