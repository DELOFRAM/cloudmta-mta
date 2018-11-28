----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Irons (modyfikacje by Kubas)
----------------------------------------------------

--[[
*TODO:

- Optymalizacja kodu
- Formatowanie kodu // ZROBIONE
- Włączenie możliwości TYLKO chodzenia przy niesieniu drewna
- Blokada bicia podczas niesienia drewna (prawdopodobnie inny skrypt blokuje)
- Edycja magazynow

]]


--[[
Modele drzew: 615
Zniszczone modele drzew: 845,
Modele drewna: 1463
--]]

local modeleDrzew = {615} -- modele drzew stojących
local zniszczoneModeleDrzew = {845} -- modele drzew leżących
local modeleDrewna = {1463} -- modele drewna do niesienia

local pojazdyPickupy =
{ -- do pozniejszej edycji
	[478] =
	{
		fp = {-0.550, -1.960, 0.3},
		sp = {0.444, -1.371, 0.3}
	}
}

local magazyny =
{              ---- magazyny na drewno, potem edycja kodu
	{-416.97, -1750.95, 6.77}
}

local kordynaty = 
{ -- kordy drzewek
	{-405.07, -1747.78, 7.66},
	{-395.41, -1757.65, 6.73},
	{-390.09, -1768.90, 5.23},
	{-409.59, -1773.28, 4.22},
	{-434.04, -1765.66, 5.53},
	{-431.27, -1752.40, 6.84},
	{-428.36, -1735.22, 7.76},
	{-416.84, -1716.41, 10.76},
	{-417.83, -1742.18, 7.55}
}

function zasadzDrzewo() -- sadzimy drzewka
 --local drzewoRandom = math.random(1,#kordynaty)
 --local wybrane = kordynaty[drzewoRandom]
	for i,v in ipairs(kordynaty) do
		local cs = createColSphere(Vector3(v),3)
		local el = getElementsWithinColShape(cs)
		destroyElement(cs)
		if #el == 0 then
			local randomModel = math.random(1,#modeleDrzew)
			outputDebugString("Utworzono drzewo na kordach "..tostring(Vector3(v))..", id "..modeleDrzew[randomModel].."") -- USUNAC
			local drzewo = createObject(modeleDrzew[randomModel],v[1],v[2],v[3]-1)
			setElementData(drzewo,"drzewo:hp",100)
			setElementData(drzewo,"previewDesc","jakiś test")
		else
			outputDebugString("Błąd przy tworzeniu drzewa - brak wolnego miejsca") -- USUNAC
	 	end
	end
end
addCommandHandler("createDrzewo",zasadzDrzewo)

setTimer(zasadzDrzewo,25*60000,0) -- timer

function powalDrzewo(drzewo) -- powalamy drzewo na ziemie
	local x,y,z = getElementPosition(drzewo)
	local cs = createColSphere(x,y,z,15)
	local plrs = getElementsWithinColShape(cs,"player")
	destroyElement(cs)
	for i,v in ipairs(plrs) do
		triggerClientEvent ( v, "playTreeSound", v, x,y,z ) -- trigger do odtwarzania dzwieku drzewa
	end
	setElementCollisionsEnabled(drzewo,false) -- wylaczamy kolizje drzewa aby nie bylo bugow
	moveObject(drzewo,8000,Vector3(getElementPosition(drzewo)),0,85,0,"OutBounce") -- powalamy drzewo
	setTimer(function()
		local x1,y1,z1 = getElementPosition(drzewo)
		local rx,ry,rz = getElementRotation(drzewo)
		local m = getElementModel(drzewo)
		-- outputChatBox(rx)
		-- outputChatBox(ry)
		-- outputChatBox(rz)
		destroyElement(drzewo)
		local drzewoNew = createObject(846,x1,y1,z1+0.6,0,0,ry+180)	
		setElementData(drzewoNew,"drzewo:fallen",true)
		--setElementModel(drzewo,846) 
		--setElementRotation(drzewo,rz,ry,0)
	end,8000,1)
end

function potnijDrzewo(drzewo,plr) -- tniemy drzewo
	local x1,y1,z1 = getElementPosition(drzewo)
	local rx,ry,rz = getElementRotation(drzewo)
	destroyElement(drzewo)
	exports.titan_noti:showBox(plr,"Aby podnieść drewno, podejdź do niego i naciśnij 1")
	for i=0,2 do
		local dr = createObject(1463,x1+math.random(1,6),y1+math.random(1,5),z1-0.3)
		setElementData(dr,"drzewo:pociete",true)
		setElementCollisionsEnabled(dr,false)
	end
end

function takeHpDrzewo(plr) -- zabieramy HP drzewu
	if getPedWeapon(plr) == 9 then
		local x,y,z=getElementPosition(plr)
		local _,_,rz=getElementRotation(plr)
		local rrz=math.rad(rz+180)
		local x= x - (2*math.sin(-rrz))
		local y= y - (2*math.cos(-rrz))
		local strefa2 = createColSphere(x,y,z,2)
		local trs = getElementsWithinColShape(strefa2,"object")
		destroyElement(strefa2)
		if #trs == 1 then
			tree = trs[1]
			if getElementData(tree,"drzewo:fallen") then
				setElementFrozen(plr,true)
				--setElementData(plr,"drzewo:cuttingState",25)
				toggleAllControls(plr,false,true,false)
				unbindKey(plr,"fire","down",takeHpDrzewo)  
				setPedAnimation ( plr, "CHAINSAW", "CSAW_G", 5000, true, false )
			 	exports.titan_noti:showBox(plr,"Tniesz drzewo")
				setTimer(function()
					setElementFrozen(plr,false)
					toggleAllControls(plr,true,true,true)
					bindKey(plr,"fire","down",takeHpDrzewo)
					potnijDrzewo(tree,plr)
					setPedAnimation ( plr, "ped", "Idle_Gang1", 50,false, false )
				end,5000,1)
				return
			end
			if getElementData(tree,"drzewo:hp") then
				--if plr then
					--powalDrzewo(tree)
					--return
				--end
				setElementData(tree,"drzewo:hp",getElementData(tree,"drzewo:hp")-5)
				--outputDebugString(getElementData(tree,"drzewo:hp"))
				setElementFrozen(plr,true)
				toggleAllControls(plr,false,true,false)
				unbindKey(plr,"fire","down",takeHpDrzewo)
				setTimer(function()
					setElementFrozen(plr,false)
					toggleAllControls(plr,true,true,true)
					bindKey(plr,"fire","down",takeHpDrzewo)
					if tree and isElement(tree) then
						outputChatBox( getElementData(tree,"drzewo:hp") )
						if getElementData(tree,"drzewo:hp") and getElementData(tree,"drzewo:hp") <= 0 then
							powalDrzewo(tree)
							removeElementData(tree,"drzewo:hp")
							return
						end
					end
				end,500,1)
			end
		end
	end
end
		
addEventHandler("onResourceStart",resourceRoot,
	function()
--for k,plr in ipairs(getElementsByType("player")) do
--bindKey(plr,"fire","down",takeHpDrzewo)
--bindKey(plr,"fire","down",podniesPaczke)
--end
		for i=1,#kordynaty do
			zasadzDrzewo()
		end
	end) 

function chgWalk(plr)
	setControlState(plr,"walk",true)
end

function chgWalkAlt(plr)
	setControlState(plr,"walk",true)
end

--TO MOŻNA PRZENIEŚĆ DO CLIENTA ALE NIE TRZEBA
function podniesPaczke(plr) -- podnosimy drewno 
	if getElementData(plr,"securityPaczka") then
		exports.titan_noti:showBox(plr,"Odczekaj chwile")
		return
	end
	--toggleControl(plr,"fire",false)
	local x,y,z=getElementPosition(plr)
	local strefa=createColSphere(x,y,z-0.5,2)
	local obiekty=getElementsWithinColShape(strefa,"object")
	destroyElement(strefa)
	--outputDebugString(#obiekty)
	local obj = obiekty[1]
	if #obiekty==0 then return end
	if #obiekty > 1 then
		objs = math.random(1,#obiekty)
		obj = obiekty[objs]
	end
	if getElementModel(obj)~=1463 then return end
	if getElementData(plr,"niesie") then
		exports.titan_noti:showBox(plr," Już niesiesz drewno! ")
		return
	end
	--if getElementData(obj,"paczkaOwner") ~= plr then return end
	toggleControl(plr,"fire",false)
	toggleControl(plr,"aim_weapon",false)
	toggleControl(plr,"jump",false)
	toggleControl(plr,"crouch",false)
	toggleControl(plr,"sprint",false)
	setElementData(plr,"niesie",obj)
	toggleControl(plr,"enter_exit",false)
	setPedAnimation ( plr, "CARRY", "crry_prtial", 1000,true,true,false)
	exports.titan_noti:showBox(plr,"Teraz zanieś drewno do magazynu ")
	unbindKey(plr,"1","down",podniesPaczke)
	bindKey(plr,"1","down",upuscPaczke)
	attachElements(obj,plr,0,0.5,0.5) -- Zamienic na exports.bone_attach czy coś
	setObjectScale(obj,0.5)
	bindKey(plr,"forwards","down",chgWalk)
	bindKey(plr,"walk","down",chgWalkAlt)
end

function upuscPaczke(plr) -- upuszczamy drewno
	if getElementData(plr,"niesie") then
		local paczki = getElementData(plr,"niesie")
		--outputChatBox(" a")
		if paczki then
			--outputChatBox("e")
			detachElements(paczki,plr)
			local x,y,z = getElementPosition(plr)
			setElementPosition(paczki,x,y,z-0.6)
			setObjectScale(paczki,1)
			if isElement(plr) then
				toggleControl(plr,"aim_weapon",true)
				toggleControl(plr,"jump",true)
				toggleControl(plr,"crouch",true)
				toggleControl(plr,"sprint",true)
				toggleControl(plr,"enter_exit",true)
				setElementData(plr,"securityPaczka",true)
			end
			setTimer(function()
				if isElement(plr) then
					toggleControl(plr,"fire",true)
					setElementData(plr,"securityPaczka",false)
				end
			end,2500,1)
			if isElement(plr) then
				setPedAnimation(plr,false)
				setPedAnimation(plr,nil)
				unbindKey(plr,"1","down",upuscPaczke)
				removeElementData(plr,"niesie")
				bindKey(plr,"1","down",podniesPaczke)
				unbindKey(plr,"forwards","down",chgWalk)
				unbindKey(plr,"walk","down",chgWalkAlt)
			end
--[[                --- NIE DOTYKAĆ
		local x1,y1,z1=getElementPosition(plr)
		local _,_,rz1=getElementRotation(plr)
		local rrz1=math.rad(rz1+180)
		local x1= x1 - (2*math.sin(-rrz1))
		local y1= y1 - (2*math.cos(-rrz1))
		local strefa2 = createColSphere(x1,y1,z1,2)
		local vehicles = getElementsWithinColShape(strefa2,"vehicle")
		destroyElement(strefa2)
		--outputChatBox(#vehicles)
		if #vehicles ~= 1 then return end
		--if getElementData(vehicles[1],"pojazd:gracz") and getElementData(vehicles[1],"pojazd:gracz") == plr then
		local x2,y2,z2=getElementPosition(vehicles[1])
		local _,_,rz=getElementRotation(vehicles[1])
		local rrz=math.rad(rz+180)
		local x2= x2 + (2*math.sin(-rrz))
		local y2= y2 + (2*math.cos(-rrz))
		local strefa3=createColSphere(x2,y2,z2,2)
			--	destroyElement(strefa2)
				if not isElementWithinColShape(plr,strefa3) then 
				destroyElement(strefa3)
				return end
		destroyElement(strefa3)
		local mm = getElementModel(vehicles[1])
		if pojazdyPickupy[mm] then
		if getElementData(vehicles[1],"ladunek") and getElementData(vehicles[1],"ladunek")>=4 then
		exports.titan_noti:showBox(plr,"W tym pojeździe jest maksymalna ilość drewna!")
		return end
		destroyElement(paczki)
		local ladunek = getElementData(vehicles[1],"ladunek") or 1
		setElementData(vehicles[1],"ladunek",ladunek+1)
		outputChatBox(ladunek)
		--if tonumber(ladunek)>2 then
		local t = pojazdyPickupy[mm]
		
				local d1 = t.fp
		local veh = vehicles[1]
		local d2 = t.sp
				local pscar = Vector3(getElementPosition(veh))
		if tonumber(ladunek)==1 then
				local p1 = createObject(1463,pscar)
				setElementCollisionsEnabled(p1,false)
		setObjectScale(p1,0.5)
				attachElements(p1,veh,d1[1],d1[2],d1[3]-0.2)
		elseif tonumber(ladunek)==2 then
				local p2 = createObject(1463,pscar)
				setElementCollisionsEnabled(p2,false)
		setObjectScale(p2,0.5)
				attachElements(p2,veh,d2[1],d2[2],d2[3]-0.2)  
		elseif tonumber(ladunek)==3 then
		local p3 = createObject(1463,pscar)
				setElementCollisionsEnabled(p3,false)
		setObjectScale(p3,0.5)
				attachElements(p3,veh,-0.550,d2[2]+0.6,d2[3]-0.2)
		exports.titan_noti:showBox(plr," Teraz udaj się do tartaku aby rozładować drewno ")
		end
		else
		local ld = getElementData(vehicles[1],"ladunek")
		if tonumber(ld) == 1 then
		exports.titan_noti:showBox(plr," Załadowałeś drewno do pojazdu ")
		end
		end
		--]]
		end
	end
end

addEventHandler("onPlayerQuit",getRootElement(),function() -- a jak gracz wyjdzie to upuszczamy paczke
	upuscPaczke(source)
end)

--[[ -- Mozna usunac czy cos

--testowe auto
local veh = createVehicle(478,2487.49, -1657.33, 13.34, 359.0, 0.2, 117.2)
setVehicleVariant(veh,4,4)
setElementData(veh,"pracaDrwal",true)
setElementData(veh,"vehDistance",666)
setElementData(veh,"vehMaxfuel",50)
setElementData(veh,"vehFuel",50)

--]]


for i,v in ipairs(magazyny) do
	local magazyn = createMarker(v[1],v[2],v[3]-1,"cylinder",2,119,140,56,150)
	addEventHandler("onMarkerHit",magazyn,
	function(he,md)
		if not md then return end
		if getElementInterior(he) ~= 0 then return end
		local drewno = getElementData(he,"niesie")
		if drewno and isElement(drewno) and getElementModel(drewno) == 1463 then
			detachElements(drewno,he)
			destroyElement(drewno)
			removeElementData(he,"niesie")
			setPedAnimation(he)
			setPedAnimation ( he, "ped", "Idle_Gang1", 50,false, false )
			setPedAnimation(he)
			local zplc = math.random(1,5)
			exports.titan_noti:showBox(he,"Dostarczyłeś drewno do magazynu i otrzymałeś "..zplc.."$")
			givePlayerMoney(he,zplc)
			--[POLECENIE DO MYSQL ODNOŚNIE KURIERA I DODAWANIA ZLECENIA]
			bindKey(he,"1","down",podniesPaczke)
			unbindKey(he,"forwards","down",chgWalk)
			unbindKey(he,"walk","down",chgWalkAlt)
			toggleControl(he,"aim_weapon",true)
			toggleControl(he,"jump",true)
			toggleControl(he,"crouch",true)
			toggleControl(he,"sprint",true)
			toggleControl(he,"enter_exit",true)
			toggleControl(he,"fire",true)
		else
			exports.titan_noti:showBox(he,"Aby oddać drewno musisz je nieść!")
		end
	end)
end

function triggerStartingDrwalJob ( state ) -- trigger od clienta
	if state then
		giveWeapon(client,9,1)
		bindKey(client,"fire","down",takeHpDrzewo)
		bindKey(client,"1","down",podniesPaczke)
	else
		takeWeapon(client,9) 
		unbindKey(client,"fire","down",takeHpDrzewo)
		unbindKey(client,"1","down",podniesPaczke)
	end
end
addEvent( "triggerStartingDrwalJob", true )
addEventHandler( "triggerStartingDrwalJob", resourceRoot, triggerStartingDrwalJob )