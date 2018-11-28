--x,y = guiGetScreenSize()
skinsPolice={280, 281, 282, 283, 288}
gangSkins={108, 109, 110}
police={}
gangsters={}
train={}
veh={}
local dim = getElementData(localPlayer, "memberID")
local x,y,z,nx,ny,nz,ax,ay,az,start,duration, progress
local sm = {}
sm.moov = 0
sm.object1,sm.object2 = nil,nil

local function removeCamHandler()
	if(sm.moov == 1)then
		sm.moov = 0
	end
end
 
local function camRender()
	if (sm.moov == 1) then
		local x1,y1,z1 = getElementPosition(sm.object1)
		local x2,y2,z2 = getElementPosition(sm.object2)
		setCameraMatrix(x1,y1,z1,x2,y2,z2)
	end
end
addEventHandler("onClientPreRender",root,camRender)
 
function smoothMoveCamera(x1,y1,z1,x1t,y1t,z1t,x2,y2,z2,x2t,y2t,z2t,time)
	if x1 ~= false then
		if(sm.moov == 1)then return false end
		sm.object1 = createObject(1337,x1,y1,z1)
		sm.object2 = createObject(1337,x1t,y1t,z1t)
		setElementAlpha(sm.object1,0)
		setElementAlpha(sm.object2,0)
		setObjectScale(sm.object1,0.01)
		setObjectScale(sm.object2,0.01)
		moveObject(sm.object1,time,x2,y2,z2,0,0,0,"InOutQuad")
		moveObject(sm.object2,time,x2t,y2t,z2t,0,0,0,"InOutQuad")
		sm.moov = 1
		setTimer(removeCamHandler,time,1)
		setTimer(destroyElement,time,1,sm.object1)
		setTimer(destroyElement,time,1,sm.object2)
		return true
	else
	sm.moov = 0
	end
end

function move()
local now = getTickCount()
local elapsedTime = now - start
local endTime = start + getDistanceBetweenPoints3D( x, y,z , nx, ny, nz ) * 100
local duration = endTime - start
local progress = elapsedTime / duration

    if progress < 1 then
		if not isElement(veh) then return end
        ax,ay,az = interpolateBetween(x, y, z, nx, ny, nz, progress, "OutElastic")
        setElementPosition(veh, ax, ay, az)
		return
    end
end

function setCutscene(num)
	if num == 1 then
		-------------------
		-- UNITY STATION --
		-------------------
		
		train[1] = createVehicle(538, 1694.7099609375, -1929.8701171875, 13.556393623352)
		train[2] = createVehicle(570, 1694.7099609375, -1929.8701171875, 13.556393623352)
		train[3] = createVehicle(570, 1694.7099609375, -1929.8701171875, 13.556393623352)
		train[4] = createVehicle(570, 1694.7099609375, -1929.8701171875, 13.556393623352)
		train[5] = createVehicle(570, 1694.7099609375, -1929.8701171875, 13.556393623352)
		train[6] = createVehicle(570, 1694.7099609375, -1929.8701171875, 13.556393623352)
		
		for _, v in ipairs(train) do
		setElementCollisionsEnabled(v, false)
		end
		
		attachElements(train[2], train[1], 0, -18.5, 0)
		attachElements(train[3], train[1], 0, -37, 0)
		attachElements(train[4], train[1], 0, -60.3, 0)
		attachElements(train[5], train[1], 0, -80.9, 0)
		attachElements(train[6], train[1], 0, -101.8, 0)
		
		for _, v in ipairs(train) do
		setElementDimension(v, dim)
		end
		
		setTimer(setTrainSpeed, 50, 1, train[1], 5)
		setTimer(setTrainSpeed, 400, 1, train[1], -0.9)
		
		local gracz = createPed(getElementModel(localPlayer), 1767.6923828125, -1951.4560546875, 14.109554290771)
		local tlumacz = createPed(1, 1767.7021484375, -1950.0009765625, 14.109554290771, 180)
		setPedAnimation(gracz, "COP_AMBIENT", "Coplook_loop", -1, true, false, false)
		setPedAnimation(tlumacz, "GANGS", "prtial_gngtlkF", -1, true, false, false)
		setElementDimension(gracz, dim)
		setElementDimension(tlumacz, dim)
		setElementDimension(localPlayer, dim)

		setCameraMatrix(1801.4904785156, -1971.4981689453, 25.029932022095, 1705.3441162109, -1949.7416992188, 8.2210302352905, 0, 70)
		
		setTimer(smoothMoveCamera, 5000, 1, 1801.4904785156, -1971.4981689453, 25.029932022095, 1705.3441162109, -1949.7416992188, 8.2210302352905, 1800.0447998047, -1946.2917480469, 15.701831817627, 1703.3894042969, -1970.8292236328, 8.2426881790161, 6000)
		
		-- text = "Drogi graczu, witaj na serwerze cloudMTA, a ja dzisiaj będę Twoim przewodnikiem.\n\n\nZapewne wiesz, że jest to serwer RolePlay, który głównie polega na odgrywaniu realnego życia, ale jeżeli nie, to pokrótce wytłumaczę Ci działanie tego trybu. Cała rozgrywka toczy się w mieście Los Santos, które na pewno już znasz, ale do niego przejdziemy później. Najważniejsze co musisz robić, to myśleć jak zachowywałaby się Twoja postać w danej sytuacji - raczej na co dzień nikt nie sprintuje bez powodu i atakuje ludzi piąstką, prawda? A więc pamiętaj - zachowujemy się po ludzku, a taka gra przysporzy Ci dobrą opinię wśród graczy, jak i administracji. Po stworzeniu postaci pamiętaj, żeby trzymać się wymyślonego planu na nią, a jeżeli jeszcze go nie posiadasz - to wymyśl go teraz, zanim pozna Cię pół serwera, no dawaj!"
		
		timer = setTimer(setCutscene, 26000, 1, 2)
		
		setTimer(function()
		
		for _, v in ipairs(train) do
		destroyElement(v)
		end
		
		destroyElement(gracz)
		destroyElement(tlumacz)
		end, 27000, 1)
	elseif num == 2 then -- Centrum
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1370.1793212891, -1399.7807617188, 15.661270141602, 1270.2388916016, -1398.7047119141, 12.383779525757, 0, 70)
		smoothMoveCamera(1370.1793212891, -1399.7807617188, 15.661270141602, 1270.2388916016, -1398.7047119141, 12.383779525757, 654.21118164063, -1400.4552001953, 16.838144302368, 554.2119140625, -1400.4255371094, 17.224565505981, 20000)
		
		-- text = "Jesteś pierwszy raz na serwerze, a więc zaczniemy wczuwać się już w realne życie. No już, zaśnij! Przed chwilą wysiadłeś na stacji metra z pełnymi walizkami, znajdujesz się w Los Santos, w mieście, które nigdy nie śpi ale nie o to Ci tutaj najbardziej chodzi. Przyjechałeś tutaj, żeby zarobić jakieś grubsze pieniądze, albo poznać fajnych ludzi. Każdy ma inne cele ale pamiętaj aby skupiać się na nich i spełniać swoje marzenia."
		
		timer = setTimer(setCutscene, 21000, 1, 3)
	elseif num == 3 then
		setElementDimension(localPlayer, dim)
		setCameraMatrix(2457.5869140625, -1453.4793701172, 36.54919052124, 2424.2143554688, -1366.9572753906, -0.87005180120468, 0, 70)
		smoothMoveCamera(2457.5869140625, -1453.4793701172, 36.54919052124, 2424.2143554688, -1366.9572753906, -0.87005180120468, 2477.0024414063, -1415.0975341797, 52.781223297119, 2410.9663085938, -1442.1473388672, -17.272552490234, 4000)
		setTimer(smoothMoveCamera, 4000, 1, 2477.0024414063, -1415.0975341797, 52.781223297119, 2410.9663085938, -1442.1473388672, -17.272552490234, 2452.0356445313, -1406.4317626953, 25.652294158936, 2408.5661621094, -1318.0561523438, 8.3275737762451, 6000)
		setTimer(smoothMoveCamera, 10500, 1, 2452.0356445313, -1406.4317626953, 25.652294158936, 2408.5661621094, -1318.0561523438, 8.3275737762451, 2444.5031738281, -1375.9519042969, 24.883213043213, 2502.0612792969, -1457.4744873047, 18.468542098999, 5000)
		setTimer(smoothMoveCamera, 16000, 1, 2444.5031738281, -1375.9519042969, 24.883213043213, 2502.0612792969, -1457.4744873047, 18.468542098999, 2450.9155273438, -1351.1354980469, 29.232732772827, 2454.7509765625, -1449.6380615234, 12.423830986023, 5000)
		veh[1] = createVehicle(596, 2447.7541503906, -1436.0089111328, 23.551710128784, 359.73107910156, 359.92578125, 323.47326660156)
		veh[2] = createVehicle(596, 2454.796875, -1437.8392333984, 23.548940658569, 359.69323730469, 0.0001220703125, 22.09716796875)
		veh[3] = createVehicle(596, 2446.9050292969, -1372.1009521484, 23.589155197144, 1.2316284179688, 356.78442382813, 138.83630371094)
		veh[4] = createVehicle(596, 2454.73828125, -1372.4196777344, 23.594705581665, 1.10888671875, 2.923828125, 216.7587890625)
		veh[5] = createVehicle(466, 2456.7878417969, -1397.2840576172, 23.600215911865, 359.94885253906, 356.53668212891, 358.12573242188)
		veh[6] = createVehicle(422, 2438.8012695313, -1415.8809814453, 24.003908157349, 359.43212890625, 359.81188964844, 90.204528808594, nil, nil, 1)
		veh[7] = createVehicle(517, 2464.4421386719, -1413.0545654297, 23.604879379272, 359.99884033203, 359.99987792969, 89.181274414063)
		veh[8] = createVehicle(534, 2464.7797851563, -1424.4007568359, 23.474697113037, 0.46881103515625, 0, 90.262756347656)
		veh[9] = createVehicle(536, 2445.2385253906, -1406.7209472656, 23.635000228882, 0.458251953125, 5.7703857421875, 359.62347412109)
		police[1] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2449.0139160156, -1436.8757324219, 23.830417633057, 356.47158813477)
		police[2] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2446.146484375, -1435.0504150391, 23.826150894165, 348.95159912109)
		police[3] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2453.3996582031, -1438.7154541016, 23.828125, 0.85821747779846)
		police[4] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2456.2416992188, -1437.3718261719, 23.828125, 19.971782684326)
		police[5] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2448.1806640625, -1373.0972900391, 23.826532363892, 174.13323974609)
		police[6] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2445.6169433594, -1370.6796875, 24, 178.51992797852)
		police[7] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2453.4155273438, -1373.2241210938, 23.8359375, 190.11337280273)
		police[8] = createPed(skinsPolice[math.random(1, #skinsPolice)], 2456.2639160156, -1371.4908447266, 24, 179.45964050293)
		gangsters[1] = createPed(gangSkins[math.random(1, #gangSkins)], 2456.7492675781, -1394.1560058594, 23.984283447266, 356.92877197266)
		gangsters[2] = createPed(gangSkins[math.random(1, #gangSkins)], 2443.5148925781, -1385.6962890625, 24, 345.33541870117)
		gangsters[3] = createPed(gangSkins[math.random(1, #gangSkins)], 2443.4409179688, -1397.7106933594, 24, 280.47482299805)
		gangsters[4] = createPed(gangSkins[math.random(1, #gangSkins)], 2461.2785644531, -1414.6245117188, 23.75, 96.233123779297)
		gangsters[5] = createPed(gangSkins[math.random(1, #gangSkins)], 2441.8198242188, -1415.6981201172, 23.992227554321, 262.49749755859)
		
		for _, v in ipairs(police) do
		setElementDimension(v, dim)
		end
		
		for _, v in ipairs(gangsters) do
		setElementDimension(v, dim)
		end
		
		for _, v in ipairs(veh) do
		setElementDimension(v, dim)
		end
		
		for _,v in ipairs(police) do
		setPedAnimation(v, "ped", "ARRESTgun", -1, true, false, false, true)
		local timer = setTimer(setPedAnimationProgress, 50, 0, v, "ARRESTgun", 0.5)
		end
		
		for _,v in ipairs(gangsters) do
		setPedAnimation(v, "ped", "handsup", -1, true, false, true, true)
		local timer = setTimer(setPedAnimationProgress, 50, 0, v, "handsup", 0.79)
		end
			
		setVehicleDoorOpenRatio(veh[1], 2, 1)
		setVehicleDoorOpenRatio(veh[1], 3, 1)
		setVehicleDoorOpenRatio(veh[2], 2, 1)
		setVehicleDoorOpenRatio(veh[2], 3, 1)
		setVehicleDoorOpenRatio(veh[3], 2, 1)
		setVehicleDoorOpenRatio(veh[3], 3, 1)
		setVehicleDoorOpenRatio(veh[4], 2, 1)
		setVehicleDoorOpenRatio(veh[4], 3, 1)
		setVehicleDoorOpenRatio(veh[5], 1, 1)
		setVehicleDoorOpenRatio(veh[6], 1, 1)
		setVehicleSirensOn(veh[1], true)
		setVehicleSirensOn(veh[2], true)
		setVehicleSirensOn(veh[3], true)
		setVehicleSirensOn(veh[4], true)
		
		timer = setTimer(setCutscene, 21000, 1, 4)
	elseif num == 4 then -- Urząd
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1422.8430175781, -1697.7585449219, 25.403888702393, 1487.5670166016, -1773.2132568359, 14.568779945374, 0, 70)
		smoothMoveCamera(1422.8430175781, -1697.7585449219, 25.403888702393, 1487.5670166016, -1773.2132568359, 14.568779945374, 1468.8782958984, -1731.1528320313, 19.129278182983, 1468.0593261719, -1831.044921875, 14.556450843811, 5000)
		setTimer(smoothMoveCamera, 5100, 1, 1468.8782958984, -1731.1528320313, 19.129278182983, 1468.0593261719, -1831.044921875, 14.556450843811, 1495.6348876953, -1731.6348876953, 19.129278182983, 1460.5430908203, -1825.1638183594, 14.556450843811, 5000)
		setTimer(smoothMoveCamera, 10200, 1, 1495.6348876953, -1731.6348876953, 19.129278182983, 1460.5430908203, -1825.1638183594, 14.556450843811, 1535.3175048828, -1716.7570800781, 39.628253936768, 1455.6956787109, -1766.9774169922, 5.8896045684814, 5000)
		
		timer = setTimer(setCutscene, 15500, 1, 5)
	elseif num == 5 then -- Komenda LSPD
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1502.462890625, -1693.0491943359, 28.41436958313, 1590.4517822266, -1647.8756103516, 13.673208236694, 0, 70)
		
		timer = setTimer(setCutscene, 5000, 1, 6)
	elseif num == 6 then -- Remiza LSFD
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1073.58203125, -1395.0560302734, 26.808416366577, 1005.0233154297, -1461.8168945313, -2.2206702232361, 0, 70)
		smoothMoveCamera(1073.58203125, -1395.0560302734, 26.808416366577, 1005.0233154297, -1461.8168945313, -2.2206702232361, 947.11016845703, -1392.1496582031, 26.28689956665, 1006.998840332, -1469.8519287109, 6.9037928581238, 5000)
		
		timer = setTimer(setCutscene, 5000, 1, 7)
	elseif num == 7 then -- Los Santos Medical Hospital
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1206.5059814453, -1402.6667480469, 27.853073120117, 1145.7862548828, -1324.6380615234, 12.8653383255, 0, 70)
		smoothMoveCamera(1206.5059814453, -1402.6667480469, 27.853073120117, 1145.7862548828, -1324.6380615234, 12.8653383255, 1220.5329589844, -1270.0170898438, 26.601894378662, 1157.5974121094, -1346.4661865234, 12.650135993958, 5000)
		
		timer = setTimer(setCutscene, 5000, 1, 8)
	elseif num == 8 then -- Los Santos Superior Court
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1852.1362304688, -1507.0755615234, 63.07409286499, 1780.8649902344, -1561.7164306641, 19.087892532349, 0, 70)
		smoothMoveCamera(1852.1362304688, -1507.0755615234, 63.07409286499, 1780.8649902344, -1561.7164306641, 19.087892532349, 1856.6188964844, -1591.7507324219, 58.898113250732, 1769.5791015625, -1565.4489746094, 17.27739906311, 2000)
		setTime(smoothMoveCamera, 2100, 1, 1856.6188964844, -1591.7507324219, 58.898113250732, 1769.5791015625, -1565.4489746094, 17.27739906311, 1736.9254150391, -1624.4007568359, 54.833023071289, 1791.5295410156, -1553.9874267578, 9.44189453125, 2000)
		setTime(smoothMoveCamera, 4200, 1, 1789.2236328125, -1674.7515869141, 81.845077514648, 1785.0496826172, -1586.2253417969, 35.523529052734, 1873.3436279297, -1592.9517822266, 81.845077514648, 1793.3419189453, -1571.9425048828, 25.646053314209, 2000)
		
		timer = setTimer(setCutscene, 4500, 1, 9)
	elseif num == 9 then -- Los Santos Sheriff's Department
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1206.5059814453, -1402.6667480469, 27.853073120117, 1145.7862548828, -1324.6380615234, 12.8653383255, 0, 70)
		smoothMoveCamera(1206.5059814453, -1402.6667480469, 27.853073120117, 1145.7862548828, -1324.6380615234, 12.8653383255, 1220.5329589844, -1270.0170898438, 26.601894378662, 1157.5974121094, -1346.4661865234, 12.650135993958, 5000)
		
		timer = setTimer(setCutscene, 5000, 1, 10)
	elseif num == 10 then -- Los Santos News
		setElementDimension(localPlayer, 0)
		setCameraMatrix(1073.58203125, -1395.0560302734, 26.808416366577, 1005.0233154297, -1461.8168945313, -2.2206702232361, 0, 70)
		smoothMoveCamera(1073.58203125, -1395.0560302734, 26.808416366577, 1005.0233154297, -1461.8168945313, -2.2206702232361, 947.11016845703, -1392.1496582031, 26.28689956665, 1006.998840332, -1469.8519287109, 6.9037928581238, 5000)
		
		timer = setTimer(setCutscene, 5000, 1, -1)
	elseif num == 11 then -- Przylot do Los Santos
		if isElement(sound) then destroyElement(sound) end
		setElementDimension(localPlayer, dim)
		x, y, z, nx, ny, nz, start =  1135.797, -2593.212, 77.062, 1642.805, -2593.341, 13.547, getTickCount()
		veh = createVehicle(577, x, y, z, 0, 0, 270)
		local ped = createPed(getElementModel(localPlayer), 1684.713, -2330.474, 13.547)
		setElementAlpha(localPlayer, 0)
		setElementDimension(ped, dim)
		setElementFrozen(veh, true)
		setElementDimension(veh, dim)
		smoothMoveCamera(1491.622681, -2514.009033, 37.309151, 1424.780640, -2588.354004, 35.078259, 1701.547607, -2559.906006, 31.960051, 1605.116089, -2586.373535, 31.299477, 4000)
		setTimer(smoothMoveCamera, 4000, 1, 1774.224731, -2357.133301, 50.418209, 1694.555542, -2307.845703, 15.438848, 1681.869507, -2293.921875, 14.628276, 1689.240356, -2393.505127, 9.258781, 10000)
		addEventHandler("onClientRender", getRootElement(), move)
		sound = playSound("files/airport.mp3")
		setTimer(destroyElement, 14000, 1, veh)
		setTimer(destroyElement, 14000, 1, sound)
		setTimer(setElementAlpha, 14000, 1, localPlayer, 255)
		timer = setTimer(setCutscene, 14050, 1, -1)
	elseif num == 12 then -- Obrzeża miasta
		if isElement(sound) then destroyElement(sound) end
		gangsters[1] = createPed(gangSkins[math.random(1, #gangSkins)], 2456.7492675781, -1394.1560058594, 23.984283447266, 356.92877197266)
		gangsters[2] = createPed(gangSkins[math.random(1, #gangSkins)], 2443.5148925781, -1385.6962890625, 24, 345.33541870117)
		gangsters[3] = createPed(getElementModel(localPlayer), 0, 0, 0, 270)
		setElementDimension(gangsters[1], dim)
		setElementDimension(gangsters[2], dim)
		setElementDimension(gangsters[3], dim)
		sound = playSound("files/outskirts.mp3")
		setElementDimension(localPlayer, dim)
		veh = createVehicle(414, 2755.875, 175.254, 21.401, 0, 0, 180)
		setElementDimension(veh, dim)
		setElementVelocity(veh, 0, -1.7, 0)
		warpPedIntoVehicle(gangsters[1], veh, 0)
		warpPedIntoVehicle(gangsters[2], veh, 1)
		smoothMoveCamera(2786.802002, 180.781082, 29.398821, 2745.711914, 89.613182, 29.261744, 2776.550781, 21.323591, 40.792206, 2733.512695, -68.789406, 35.559597, 5000)
		setTimer(fadeCamera, 3000, 1, false, 1)
		setTimer(setElementFrozen, 5000, 1, veh, true)
		setTimer(setElementPosition, 5100, 1, veh, 2861.004395, -546.079529, 13.637799)
		setTimer(setElementRotation, 5100, 1, veh, 356.732239, 357.637573, 186.020996)
		setTimer(setElementFrozen, 5100, 1, veh, true)
		setTimer(setElementFrozen, 5200, 1, veh, false)
		setTimer(setCameraMatrix, 5500, 1, 2833.941162, -606.388977, 18.382122, 2869.489014, -513.764343, 5.851151)
		setTimer(fadeCamera, 6000, 1, true, 4)
		setTimer(setElementVelocity, 6100, 1, veh, 0, -0.3, 0)
		setTimer(smoothMoveCamera, 6500, 1, 2833.941162, -606.388977, 18.382122, 2869.489014, -513.764343, 5.851151, 2886.328369, -607.281006, 17.625282, 2812.461670, -543.500061, -4.184993, 8000)
		setTimer(smoothMoveCamera, 14550, 1, 2886.328369, -607.281006, 17.625282, 2812.461670, -543.500061, -4.184993, 2861.264893, -577.354675, 14.752181, 2875.913574, -673.482971, -8.588034, 5000)
		setTimer(function()
		setElementFrozen(veh, true)
		removePedFromVehicle(gangsters[2], veh)
		local x,y,z = getVehicleComponentPosition(veh, "door_rf_dummy", "world")
		setElementPosition(gangsters[2], x-1.3, y, z)
		setElementRotation(gangsters[2], 0, 0, 10)
		setPedAnimation(gangsters[2], "PED", "WALK_gang1")
		end, 16000, 1)
		setTimer(setPedAnimation, 19950, 1, gangsters[2], false)
		setTimer(setPedControlState, 21000, 1, gangsters[2], "enter_passenger", true)
		setTimer(smoothMoveCamera, 20000, 1, 2861.264893, -577.354675, 14.752181, 2875.913574, -673.482971, -8.588034, 2850.268799, -579.377075, 15.190506, 2941.852051, -614.618835, -4.058105, 2000)
		setTimer(setElementPosition, 22500, 1, gangsters[3], 2861.901, -590.825, 11.326)
		setTimer(warpPedIntoVehicle, 22500, 1, gangsters[2], veh, 1)
		setTimer(setPedAnimation, 22700, 1, gangsters[3], "PED", "KO_shot_front", -1, false, false, false, true)
		setTimer(setElementFrozen, 23000, 1, veh, false)
		setTimer(smoothMoveCamera, 22050, 1, 2850.268799, -579.377075, 15.190506, 2941.852051, -614.618835, -4.058105, 2836.488037, -603.186218, 15.870668, 2920.882324, -552.326050, -1.183977, 2000)
		setTimer(setPedControlState, 23500, 1, gangsters[1], "accelerate", true)
		setTimer(smoothMoveCamera, 24100, 1, 2836.488037, -603.186218, 15.870668, 2920.882324, -552.326050, -1.183977, 2874.742676, -612.324158, 15.731138, 2825.742920, -526.497559, 0.472401, 2000)
		setTimer(setPedAnimation, 26000, 1, gangsters[3], "ped", "getup_front", -1, false, true, false, false)
		timer = setTimer(setCutscene, 29000, 1, -1)
	elseif num == 13 then -- DOKI LOS Santos
	--setCameraMatrix(7198.687988, -2395.405273, 17.433893, 7298.619629, -2399.039307, 18.094467)
	elseif num == -1 then
		setCameraTarget(localPlayer)
		setElementDimension(localPlayer, 0)
		removeEventHandler("onClientRender", getRootElement(), move)
		if isElement(sound) then destroyElement(sound) end
		if isTimer(timer) then killTimer(timer) end
	end
end

addCommandHandler("stage", function(com, id)
setCutscene(tonumber(id))
end)

addEvent("setCutscene", true)
addEventHandler("setCutscene", getRootElement(), setCutscene)