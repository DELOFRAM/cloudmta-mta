-- 1 - meżczyzna , 0 - kobieta
local TimerAnimation = {}

function getXYInFrontOfPlayer(pos, angle, distance)
	pos.x = pos.x + math.sin(math.rad(-angle)) * distance
	pos.y = pos.y + math.cos(math.rad(-angle)) * distance
	return pos
end

function getPlayerDrug(player)
	local tempTable = false
	local playerItems = exports.titan_items:getPlayerItems(player)
	if playerItems == false then return false end
	for i,v in ipairs(playerItems) do
		if  tonumber(v.type) == 13 then
			if not(tempTable) then
				tempTable = {}
				table.insert(tempTable,{v.ID,v.name})
			else
				table.insert(tempTable,{v.ID,v.name})
			end
		end
	end
	if not(tempTable) then
		return false
	else
		return tempTable
	end
end

function generationEvidence()
	local rand = math.random(1,2)
	local name = config.gender[rand].name[ math.random(1, #config.gender[rand].name[1] ) ]
	local lastname = config.lastname[ math.random(1, #config.lastname) ]
	local skin = config.gender[rand].skin[ math.random(1,#config.gender[rand].skin) ]
	return rand, name, lastname, skin
end

local function outputChatBoxSplitted(text, target, c1,c2,c3, ca)
  if (string.len(text)<128) then
    outputChatBox(text, target, c1,c2,c3,ca)
	return
  end
  local t=""
  for i,v in string.gmatch(text,"(.)") do
	  if (string.len(t)>0 and string.len(t)+string.len(i)>=128) then
			outputChatBox(t, target, c1,c2,c3,ca)
			t=" "
	  end
	  t=t..i
  end
  if (string.len(t)>0 and t~=" ") then
		outputChatBox(t, target, c1,c2,c3,ca)
  end
end

function talk(Element, text)
local zone = ColShape.Sphere( Vector3( Element:getPosition() ) , 10.0)
local players = getElementsWithinColShape(zone, "player")
for i,v in ipairs(players) do
	if ( getElementInterior(v) == getElementInterior(zone) and getElementDimension(v) == getElementDimension(zone) ) then
		if (getDistanceBetweenPoints3D(Element:getPosition(), v:getPosition()) <= 10) then
			local name = Element:getData("name")
			if name then
				local id = Element:getData("id")
				exports.titan_chats:sendPlayerChatMessage(v, string.format("%s mówi: %s", name:gsub("_", " "), text), 255, 255, 255, false)
				-- outputChatBoxSplitted( name:gsub("_"," ") .. " mówi: " .. text, v, 255, 255, 255, true)
				local talkingAnimation = {"A","B","C","D","E","F","G","H"}
				Element:setAnimation( "GANGS", "prtial_gngtlk"..talkingAnimation[ math.random(1,#talkingAnimation)  ], 1, false, true, false )
				if isTimer( TimerAnimation[id]) then killTimer( TimerAnimation[id] ) end
				TimerAnimation[id] = setTimer(setPedAnimation, string.len(text)*500, 1, Element, false)
				end
			end
		end
	end
end

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function generationNewNPC(id)
local drug = getPlayerDrug(Cornner.data[id].player)
if not drug then
	return exports.titan_noti:showBox(Cornner.data[id].player,"Nie posiadasz już więcej narkotyków.")
end
-- outputChatBox("[CALL] generationNewNPC")

-- if Cornner.data[id].maxLimit <= Cornner.data[id].amount then
-- 	exports.titan_noti:showBox(Cornner.data[id].player,"Przekroczyłeś limit handlu na tej dzielnice!")
-- 	return
-- end

	Cornner.data[id].drug = drug

	local px, py, pz = getElementPosition(Cornner.data[id].player)
	local gender, name, lastname, skin = generationEvidence()
	local pos = getXYInFrontOfPlayer(Cornner.data[id].marker:getPosition(), Cornner.data[id].angle, 5)
	local level = config.level[Cornner.data[id].level]
	local money = math.random(level[1],level[2])
	local rot = findRotation(px, py, pos.x, pos.y)
	pos.z = pos.z + 1
	Cornner.data[id].ped = createPed(skin, pos)
	setElementRotation(Cornner.data[id].ped, 0, 0, rot)
	Cornner.data[id].ped:setData("gender",gender)
	Cornner.data[id].ped:setData("name",name.." "..lastname)
	Cornner.data[id].ped:setData("id",id)
	Cornner.data[id].ped:setData("money", money )

	triggerClientEvent( "AI:create", Cornner.data[id].player, id, Cornner.data[id].ped, Cornner.data[id].marker, "walkToTarget" )
end

function TransactionWithPlayer(id, Element)
	if Cornner.data[id] and isElement(Element) then
		local gender = Element:getData("gender")
		local tab = Cornner.data[id].drug[math.random(1, #Cornner.data[id].drug )]
		local text = config.message["welcome"][gender][ math.random(1, #config.message["welcome"]) ]
		text = text..", czy masz na sprzedaż "..tab[2].."?"
		Cornner.data[id].Transaction = tab
		talk(Element,text)
		triggerClientEvent(Cornner.data[id].player, "createGUICorners", Cornner.data[id].player)
		-- addEventHandler( "onPlayerChat", source, talkWithNPC)
	end
end
addEvent( "Transaction:start", true ) 
addEventHandler( "Transaction:start", getRootElement(  ), TransactionWithPlayer)

function TransactionWithPlayerCancel(id, Element)
	if Cornner.data[id] and isElement(Element) then
		if isTimer( TimerAnimation[id]) then killTimer( TimerAnimation[id] ) end
		destroyElement( Element )
		setTimer(generationNewNPC, math.random(1,5)*1000, 1, id)
	end
end
addEvent( "Transaction:cancel", true ) 
addEventHandler( "Transaction:cancel", getRootElement(  ), TransactionWithPlayerCancel)

-- GUI

function guiAccept(money)
	local id = source:getData("Cornner:id")
	if Cornner.data[id] then
		if isElement(Cornner.data[id].ped) then
			exports.titan_chats:sendPlayerLocalMessageRadius(source, "Za $"..money.."jest Twoje.", 10.0, "mówi")
			if Cornner.data[id].ped:getData("money") >= money then
				talk(Cornner.data[id].ped, "Świetnie, proszę, Twoje pieniadze. Ja spadam, nigdy mnie nie widziałeś!")
				exports.titan_items:removeItem( Cornner.data[id].Transaction[1], true)
				exports.titan_cash:addPlayerCash(source, money)
				exports.titan_logs:playerLog(source, "cash", string.format("Otrzymano pieniądze od: Corner, Kwota: $%d.", money))
				triggerEvent("updatePlayerEquip", source, source)
				triggerClientEvent("AI:create", source, id, Cornner.data[id].ped, Cornner.data[id].marker, "walkAwayFromTarget")
				Cornner.data[id].amount = Cornner.data[id].amount + 1
				exports.titan_db:query_free("UPDATE _corners SET amount = ? WHERE ID = ?", Cornner.data[id].amount, id)
			else
				local waiting = Cornner.data[id].ped:getData("wait") or 0
				if waiting >= 1 then
					triggerClientEvent( "AI:create", source, id, Cornner.data[id].ped, Cornner.data[id].marker, "walkAwayFromTarget")
					exports.titan_chats:sendPlayerLocalMessageRadius(source, "Nie.", 10.0, "mówi")
					talk(Cornner.data[id].ped, "Chyba się nie dogadamy. Jest jeszcze mnóstwo innych dilerów.")
					local waiting = Cornner.data[id].ped:getData("wait") or 0
					Cornner.data[id].ped:setData("wait",waiting+1)
				else
					talk(Cornner.data[id].ped, "Kurczę, trochę dużo. Może zejdziesz trochę, tak do $"..Cornner.data[id].ped:getData("money").."?")			
					triggerClientEvent(Cornner.data[id].player, "createGUICorners", Cornner.data[id].player)
					Cornner.data[id].ped:setData("wait", waiting + 1)
				end
			end
		end
	end
end
addEvent("guiAccept", true)
addEventHandler("guiAccept", root, guiAccept)

function guiCancel()
	local id = source:getData("Cornner:id")
	if Cornner.data[id] then
		if isElement( Cornner.data[id].ped ) then
			triggerClientEvent( "AI:create", source, id, Cornner.data[id].ped, Cornner.data[id].marker, "walkAwayFromTarget")
			exports.titan_chats:sendPlayerLocalMessageRadius(source, "Nie.", 10.0, "mówi")
			talk(Cornner.data[id].ped, "No trudno, bywaj.")
			local waiting = Cornner.data[id].ped:getData("wait") or 0
			Cornner.data[id].ped:setData("wait",waiting+1)
		end
	end
end
addEvent("guiCancel", true)
addEventHandler("guiCancel", root, guiCancel)