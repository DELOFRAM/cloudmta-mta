function getPlayerID(Element)
	if isElement( Element ) then
		if getElementData(Element,"playerID") then
			return getElementData(Element,"playerID")
		else
			return false
		end
	end
end

function getPlayerCharacterNameAndID(Element)
if getElementData(Element,"loggedIn") == 1 then
local name = getElementData(Element,"name")
local surname = getElementData( Element, "lastname" )
		if name and surname then
			return name.." "..surname.." ("..getPlayerID(Element)..")"
		else
			return false
		end
else
	return false
	end
end
function getPlayerCharacterName(Element)
if getElementData(Element,"loggedIn") == 1 then
local name = getElementData(Element,"name")
local surname = getElementData( Element, "lastname" )
		if name and surname then
			return name.." "..surname
		else
			return false
		end
else
	return false
	end
end


function getPlayerFromPartialName(Playeri,name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    local target = false
    if name then
        for _, player in ipairs(getElementsByType("player")) do
        	if getElementData(player,"loggedIn") == 1 then
				local name = getElementData(player,"name")
				local surname = getElementData( player, "lastname" )
        		local string = name.." "..surname
           	 	local name_ = string:lower()
            	if name_:find(name, 1, true) or getElementData(player,"id") == tonumber(name) then
                	if target then
                		outputChatBoxOOC("Znaleziono wiecej niz jednego gracza o pasującym ID lub nicku podaj więcej danych!", Playeri,255,0,0)
                		return nil
                	else
                		target = player
                	end
            	end
            end
        end
    end
    return target
end

function stringToTable(string)
local sizeTable = {}
	for i=1,string.len(string) do
		sizeTable[i] = string:sub(i,i)
	end
	return sizeTable
end

function TableToString(table)
	if #table > 0 then
		for i,v in ipairs(table) do
			if i == 1 then
				string = v
			else
				string = string..v
			end
		end
		return string
	end
end


function findTableAction(string)
local isStar = 0
local string = stringToTable(string)
local savePoint = i
	for i,v in ipairs(string) do
		if v == "*" then
			isStar = isStar+1
		end
		if isStar == 1 then
			savePoint = i
		end
		if isStar == 4 then
		   string[savePoint] = "#9900FF"..string[savePoint]
		   string[i] = string[i].."#FFFFFF"
		   isStar = 0
		end
	end
	local string = TableToString(string)
	return string
end

function outputChatBoxOOC(text,visibleTo,r,g,b,color)
local r,g,b = r or 250, g or 250, b or 250
local color = color or true
local visibleTo = visibleTo or root
--outputChatBox("(("..text.."))",visibleTo,r,g,b,color)
triggerClientEvent( visibleTo, "SAMP:outputChatBoxOOC", visibleTo, text, r,g,b, true  )
end



function outputChatBoxPrivate(sendElement,text,visibleTo,r,g,b,color)
if getElementData(sendElement,"loggedIn") == 1 and isElement(sendElement) and isElement(visibleTo) then
	local r,g,b = r or 254, g or 170, b or 4
	local color = color or true
	local visibleTo = visibleTo or nil
	outputChatBoxOOC(visibleTo,r,g,b,color)
	end
end


function outputChatBoxIC(sendElement,text,type,visibleTo,r,g,b,color)
if getElementData(sendElement,"loggedIn") == 1 and isElement(sendElement) then
	
	local Name = getPlayerCharacterName(sendElement)

	if not(Name == false) then
		local r,g,b = r or 231, g or 217, b or 176
		local color = color or true
		local visibleTo = visibleTo or root
			local string = text
			if type == "say" or type == 0 then
				string = Name.." "..text
				outputChatBox(string,visibleTo,r,g,b,color)
			elseif type == "me" or type == 1  then
				string = "* "..Name.." "..text
				r,g,b = 153,0,255
				outputChatBox(string,visibleTo,153,0,255,color)
			elseif type == "do" or type == 2 then
				string = "* "..text.." ".."(("..Name.."))"
				r,g,b = 153,0,255
				outputChatBox(string,visibleTo,153,0,255,color)			
			else
				outputChatBox(string,visibleTo,r,g,b,color)		
			end
			
			triggerClientEvent( visibleTo,"SAMP:outputChatBoxIC", visibleTo, string, r,g,b, true  )
		end
	end
end	



function nearByPlayerInColShape(sendElement,text,type,visibleTo,r,g,b,color,radius,ooc)
if isElement( sendElement ) and not( isElement(visibleTo) ) then
		local text = findTableAction(text)
		local x,y,z = getElementPosition(sendElement)
		local chat = createColSphere( x, y, z, radius )
		local players = getElementsWithinColShape( chat, "player" )
		destroyElement( chat )
		for index, nearbyPlayer in ipairs( players ) do
			local px,py,pz = getElementPosition(nearbyPlayer)
			local distance = getDistanceBetweenPoints3D( x,y,z, px,py,pz )
			local r,g,b = r or 255, g or 255, b or 255
			--local r,g,b = r+(distance/8.1),g+(distance/8.1),b+(distance/8.1)
			if ooc then
				outputChatBoxOOC(text,nearbyPlayer,r,g,b,color)
				return
			end
            outputChatBoxIC( sendElement,text,type,nearbyPlayer,r,g,b,color)			
        end
	end
end

function onPlayerChatIC(message,type)
cancelEvent(  )
	if type == 0 then
		if string.len(message) > 0 then
		nearByPlayerInColShape(source,"mówi: "..message,0,false,false,false,false,false,20)
		end
	elseif type == 1 then
		if string.len(message) > 0 then
		nearByPlayerInColShape(source,message,1,false,false,false,false,false,20)
		end	
	end
end
addEvent( "outputChatBoxIC:nearbyPlayer", true )
addEventHandler( "outputChatBoxIC:nearbyPlayer", root, onPlayerChatIC )
addEventHandler( "onPlayerChat", root, onPlayerChatIC )


function CommandHandlerOOCPlayer(Player,CommandName, ...)
local string = table.concat({...}," ")
	if string.len(string) > 0 then
		nearByPlayerInColShape(Player,getPlayerCharacterName(Player)..": "..string, 0,false,false,false,false,false,35,true)
	end
end
addCommandHandler( "b", CommandHandlerOOCPlayer )

-- function CommandHandlerShoutPlayer(Player,CommandName, ...)
-- local string = table.concat({...}," ")
-- 	if string.len(string) > 0 then
-- 		nearByPlayerInColShape(Player,"krzyczy: "..string,0,false,false,false,false,false,35)
-- 	end
-- end
-- addCommandHandler( "k", CommandHandlerShoutPlayer )

-- function CommandHandlerWhisperPlayer(Player,CommandName, ...)
-- local string = table.concat({...}," ")
-- 	if string.len(string) > 0 then
-- 		nearByPlayerInColShape(Player,"szepcze: "..string,0,false,false,false,false,false,5)
-- 	end
-- end
-- addCommandHandler( "s", CommandHandlerWhisperPlayer )
-- addCommandHandler( "c", CommandHandlerWhisperPlayer )

-- function CommandHandlerDoPlayer(Player,CommandName, ...)
-- local string = table.concat({...}," ")
-- 	if string.len(string) > 0 then
-- 		nearByPlayerInColShape(Player,string,2,false,false,false,false,false,20)
-- 	end
-- end
-- addCommandHandler( "do", CommandHandlerDoPlayer )


function CommandHandlerPrivateMessage(Player,CommandName, PlayerPartialName, ...)
local string = table.concat({...}," ")
if not(string) or string.len(string) < 0 or not(PlayerPartialName) then 
outputChatBoxOOC("Błąd składni: /"..CommandName.." [Nick/ID] [treść]",Player,255,0,0)
	return 
end
	if string.len(string) > 0 then
		local target = getPlayerFromPartialName(Player,PlayerPartialName)
		if target then
			outputChatBoxPrivate(Player,string,target)
		else
			outputChatBoxOOC("Nie znaleziono gracza o takim nicku lub ID!",Player,255,0,0)
		end
	end
end
addCommandHandler( "w", CommandHandlerPrivateMessage )
addCommandHandler( "pw", CommandHandlerPrivateMessage )
addCommandHandler( "pm", CommandHandlerPrivateMessage )

function onClientChatMessageBlocked()
outputChatBoxOOC("Wiadomości prywatne konsolowe zostały wyłączone!", source,255,0,0)
cancelEvent()
end
addEventHandler("onClientChatMessage", root, onClientChatMessageBlocked)