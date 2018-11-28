local sw, sh = guiGetScreenSize()
local pickup, progress, window, state, cs
local time = 0.05 -- Czas w minutach
local cost = 1 -- Koszt


addEventHandler("onClientResourceStart", resourceRoot, function ()
	pickup = createPickup(1177.262, -1318.333, 14.055, 3, 1240)
	cs = createColSphere(1177.262, -1318.333, 14.055, 1)
	addEventHandler("onClientColShapeHit", cs, healWindow)
end)

function render()
	dxDrawImageSection(sw/2 - 151, 128, progress, 8, 0, 0, progress, 8,   "orgs/server/hospital/files/status.png" )
	dxDrawImage(sw/2 - 160, 120, 320, 24, "orgs/server/hospital/files/status_obrys.png")
end

function cancelHeal()
	removeEventHandler("onClientGUIClick", button1, startHeal)
	removeEventHandler("onClientGUIClick", button2, cancelHeal)
	destroyElement(window)
	showCursor(false)
end

function startHeal()
	triggerServerEvent("checkDowod", localPlayer, localPlayer)
	removeEventHandler("onClientGUIClick", button1, startHeal)
	removeEventHandler("onClientGUIClick", button2, cancelHeal)
	destroyElement(window)
	showCursor(false)
	local dowod = getElementData(localPlayer, "ssn")
	if not dowod[1] then
		exports.titan_noti:showBox("Potrzebujesz dowodu osobistego aby podjąc się hospitalizacji")
		return
	end
	local money = getElementData(localPlayer, "money") or 0
	if money < cost then
		exports.titan_noti:showBox("Nie stać cię na leczenie.")
		return
	end
	setElementData(localPlayer, "money", money-cost)
	setElementFrozen(localPlayer, true)
	
	exports.titan_noti:showBox("Rozpoczynasz leczenie")
	
	addEventHandler("onClientRender", getRootElement(), render)
	
	progress = 0
	setElementData(localPlayer, "money", money-1)
	setTimer(function ()
		progress = progress + (303/(time*200))
	end, 1000, time*200)
	setTimer(function ()
		setElementHealth(localPlayer, 100)
		hideHeal()
	end, time*200000, 1)
end

function healWindow(hit)
	if hit ~= localPlayer then return end
	window = guiCreateWindow(0.4, 0.4, 0.2, 0.1, "Hospitalizacja", true)
	label = guiCreateLabel(0.02, 0.2, 1, 0.7, "Czy chcesz kontynuować?\nPodczas hospitalizacji zostaniesz przywrócony do pełni zdrowia\nKoszt hospitalizacji: $"..cost, true, window)
	button1 = guiCreateButton(0, 0.68, 0.48, 0.25, "Kontynuuj", true, window)
	button2 = guiCreateButton(0.52, 0.68, 0.48, 0.25, "Anuluj", true, window)
	addEventHandler("onClientGUIClick", button1, startHeal)
	addEventHandler("onClientGUIClick", button2, cancelHeal)
	showCursor(true)
end

function hideHeal()
	removeEventHandler("onClientRender", getRootElement(), render)
	progress = 0
	exports.titan_noti:showBox("Leczenie zostało ukończone")
	setElementFrozen(localPlayer, false)
end

function setBlockOrNot(state)
	block = state
end
addEvent("setBlockOrNot", true)
addEventHandler("setBlockOrNot", getRootElement(), setBlockOrNot)

--[[

Le Matma :D
start: 0
end: 303
time: 0.1m - 20s
coile: 1s
ilerazy: coile*(time*60)

]]
