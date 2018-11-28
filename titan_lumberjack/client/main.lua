----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Irons (modyfikacje by Kubas)
----------------------------------------------------

function playTreeSound ( x,y,z ) -- Włączamy dzwiek drzewa
  local s = playSound3D("drzewo.mp3",x,y,z,false)
  setSoundMaxDistance(s,25)
  setSoundVolume(s,10)
end
addEvent( "playTreeSound", true )
addEventHandler( "playTreeSound", localPlayer, playTreeSound )

function srodkuj(center_window) -- funkcja z wiki do srodkowania okna
	local screenW, screenH = guiGetScreenSize()
	local windowW, windowH = guiGetSize(center_window, false)
	local x, y = (screenW - windowW) /2,(screenH - windowH) /2
	return guiSetPosition(center_window, x, y, false)
end

function createDrwalWindow() -- tworzenie okna drwala
if drwal_window and isElement(drwal_window) then destroyElement(drwal_window) end
	drwal_window = guiCreateWindow(0,0, 0.26, 0.17, "Praca Dorywcza", true)
	guiWindowSetSizable(drwal_window, false)

	drwal_anuluj = guiCreateButton(0.04, 0.53, 0.38, 0.30, "Anuluj", true, drwal_window)
	drwal_start = guiCreateButton(0.59, 0.53, 0.38, 0.30, "Rozpocznij", true, drwal_window)
	drwal_label = guiCreateLabel(0.11, 0.31, 0.78, 0.13, "Czy chcesz rozpocząć pracę drwala?", true, drwal_window)
	guiSetFont(drwal_label, "default-bold-small")   
	srodkuj(drwal_window)		
	showCursor(true)
end

local drwalTable =
{
	{
		-418.33,
		-1759.61,
		6.22,
		strefa = 
		{
			-418.33,
			-1759.61,
			6.22
		},
		ws = 55
	}
}

local addFunc = {}

function addFunc.markerHit(hitElement, matchingDimension)
	if md then
		if hitElement == localPlayer then
			if localPlayer:getData("drwalJobStatus") then
				createDrwalWindow()

				guiSetText(drwal_label, "Czy chcesz zakończyć pracę drwala?")
				guiSetText(drwal_start, "Zakończ")
			else
				createDrwalWindow()
			end

			addEventHandler("onClientGUIClick", drwal_anuluj, function()
				if isElement(drwal_window) then
					destroyElement(drwal_window)
				end
				exports.titan_cursor:hideCustomCursor("lumberjack")
			end, false)

			addEventHandler("onClientGUIClick", drwal_start, function()
				if localPlayer("drwalJobStatus") then
					triggerServerEvent("triggerStartingDrwalJob", localPlayer, false)
					localPlayer:setData("drwalJobStatus", false)

					exports.titan_noti:showBox("Zakończyłeś pracę drwala.")

					if isElement(drwal_window) then
						destroyElement(drwal_window)
					end
					exports.titan_cursor:hideCustomCursor("lumberjack")
				else
					triggerServerEvent("triggerStartingDrwalJob", localPlayer, true)
					localPlayer:setData("drwalJobStatus", true)
					exports.titan_noti:showBox("Rozpocząłeś pracę drwala.")
					if isElement(drwal_window) then
						destroyElement(drwal_window)
					end
					exports.titan_cursor:hideCustomCursor("lumberjack")
				end
			end, false)
		end
	end
end

function addFunc.colshapeLeave(hitElement, matchingDimension)
	if matchingDimension then
		if hitElement == localPlayer then
			if localPlayer:getData("drwalJobStatus") then
				triggerServerEvent("triggerStartingDrwalJob", localPlayer, false)
				localPlayer:setData("drwalJobStatus", false)

				exports.titan_noti:showBox("Wyszedłeś ze strefy przeznaczonej na pracę. Praca drwala została anulowana.")
			end
		end
	end
end

function onResStart()
	for k, v in ipairs(drwalTable) do
		local markerJob = createMarker(v[1], v[2], v[3] - 1.0, "cylinder", 1.5, 119, 140, 56, 100)
		local x, y, z = unpack(v.strefa)
		local colSphere = createColSphere(x, y, z, v.ws)

		colSphere:setParent(markerJob)

		addEventHandler("onClientMarkerHit", markerJob, addFunc.markerHit)
		addEventHandler("onClientColShapeLeave", colSphere, addFunc.colshapeLeave)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)
	
function stopPilaDamage (attacker, weaponID) -- usuwamy obrazenia pily
	if attacker:getData("drwalJobStatus") then
		if weaponID == 9 then
			return cancelEvent()
		end
	end
end
addEventHandler ( "onClientPlayerDamage", getLocalPlayer(), stopPilaDamage )



-- SYF SYF SYF


-- SYFU CIĄG DALSZY
--[[function onResStart()
	for i, v in ipairs(drwalTable) do --tworzymy markery i strefy
		local drwalJobStart = createMarker(v[1],v[2],v[3]-1,"cylinder",1.5,119,140,56,150)
		local cs = createColSphere(v.strefa[1],v.strefa[2],v.strefa[3],v.ws)
		addEventHandler("onClientMarkerHit",drwalJobStart,
			function(he,md) -- event wywoływany gdy gracz wejdzie w markerr
				if not md then return end
				if he ~= getLocalPlayer() then return end
				local drwalJobStatus = getElementData(he,"drwalJobStatus") -- pobieramy czy gracz pracuje
				if drwalJobStatus then
					createDrwalWindow()
					guiSetText(drwal_label,"Czy chcesz zakończyć pracę drwala?")
					guiSetText(drwal_start,"Zakończ") -- jak pracuje to ustawiamy mozliwosc zakonczenia
				else
					createDrwalWindow() --tworzymy okno drwala

				end
				
				addEventHandler("onClientGUIClick",drwal_anuluj,
				function()
					destroyElement(drwal_window)
					showCursor(false)
				end,false)

				addEventHandler("onClientGUIClick",drwal_start,
					function()
						if getElementData(localPlayer,"drwalJobStatus") then
							--trigger
							triggerServerEvent ( "triggerStartingDrwalJob", resourceRoot, false ) -- triggerujemy do s-side
							setElementData(localPlayer,"drwalJobStatus",false)
							exports.titan_noti:showBox("Zakończyłeś pracę drwala!")
							destroyElement(drwal_window)
							showCursor(false) -- wylaczamy kursor
						else
							--trigger
							triggerServerEvent ( "triggerStartingDrwalJob", resourceRoot, true ) -- trigger [...]
							setElementData(localPlayer,"drwalJobStatus",true)
							exports.titan_noti:showBox("Rozpocząłeś pracę drwala!")
							destroyElement(drwal_window) -- niszczymy okno drwala
							showCursor(false) -- wylaczamy kursorr
						end
				end,false)
			end)	
		
		addEventHandler("onClientColShapeLeave",cs,
			function(he,md) -- gdy gracz wyjdzie ze strefy pracy to konczymy jego prace
	 			if not md then return end
				if he ~= getLocalPlayer() then return end
				if getElementData(he,"drwalJobStatus") then
					triggerServerEvent ( "triggerStartingDrwalJob", resourceRoot, false ) -- trigger do sside
					setElementData(he,"drwalJobStatus",false)
		 			exports.titan_noti:showBox("Zakończyłeś pracę drwala!")
		 		end
		 end)
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)]]



--- SCALE HP
-- local screenW, screenH = guiGetScreenSize()
-- local baseX = 1920
-- local zoom = 1.0
-- local minZoom = 2
-- if screenW < baseX then
-- 	zoom = math.min(minZoom, baseX/screenW)
-- end


-- function renderHealth()
-- local camX, camY, camZ = getCameraMatrix()
-- 	for i,v in ipairs( getElementsByType( "object", resourceRoot, true )  ) do
-- 		if( isElement(v) ) then
-- 			local HP = getElementData(v,"drzewo:hp")
-- 			if HP then
-- 				local valX, valY, valZ = getElementPosition(v)
-- 				local distance = getDistanceBetweenPoints3D(camX, camY, camZ, valX, valY, valZ)
-- 				local progress = distance / 40
-- 				if(progress < 1) then
-- 					if not processLineOfSight(camX, camY, camZ, valX, valY, valZ, true, true, true, false, false, false, false, false, v) then
-- 					local screenW, screenH = getScreenFromWorldPosition (valX, valY, valZ, 0.06, false)
-- 						if(screenW and screenH) then
-- 						local sizeX, sizeY = 200/zoom, 20/zoom
-- 						local HP = HP/100
-- 						outputChatBox(HP)
-- 						dxDrawRectangle(screenW - sizeX / 2 - 4, screenH - sizeY / 2 - 4, sizeX + 8, sizeY + 8, tocolor(0, 0, 0, 150))
--   						dxDrawRectangle(screenW - sizeX / 2, screenH - sizeY / 2, sizeX, sizeY, tocolor(0, 0, 172, 50))
--  						dxDrawRectangle(screenW - sizeX / 2, screenH - sizeY / 2, sizeX - (sizeX * HP), sizeY, tocolor(0, 0, 172, 200))
-- 						end
-- 					end
-- 				end
-- 			end
-- 		end
-- 	end
-- end
-- addEventHandler("onClientRender", root, renderHealth)


--[[
local oddajTartak = createMarker(2463.63, -1660.05, 13.31-1,"cylinder",3,255,255,255,150)

addEventHandler("onClientVehicleEnter",getRootElement(),function(plr,seat)
if plr ~= getLocalPlayer() then return end
if seat == 0 then
outputChatBox("nw")
if getElementData(source,"ladunek") and getElementData(source,"ladunek")==3 then
blip = createBlip(Vector3(getElementPosition(oddajTartak)),41)
end
end
end)

addEventHandler("onClientVehicleExit",getRootElement(),function(plr,seat)
if plr ~= getLocalPlayer() then return end
if seat == 0 then
if blip and isElement(blip) then
destroyElement(blip)
end
end
end)
--]]

--[[local drwalTable = {  --- tabela z drwalami, pierwsze 3 x,y,z to pozycja markeru, strefa to strefa w której mozemy pracowac jesli za nia wyjdziemy to koniec pracy, ws to wielkosc strefy
--x,y,z, strefa=x,y,z , ws=x
{ -418.33, -1759.61, 6.22 ,strefa={-418.33, -1759.61, 6.22},ws=55},
}]] -- SYF SYF SYF