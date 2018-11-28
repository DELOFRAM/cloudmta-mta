local ScreenW,ScreenH = guiGetScreenSize(  )

chatbox = {}
chatbox.IC = {}
chatbox.OOC = {}
chatbox.Say = {}


chatbox.IC.Page = 1
chatbox.IC.X = (13/1024)*ScreenW
chatbox.IC.Y = (11/768)*ScreenH
chatbox.IC.Width = (23 / 1024)*ScreenH
chatbox.IC.Heigh = (185/768)*ScreenH
chatbox.IC.font = "default-bold"
chatbox.IC.scale = (0.75/1024)*ScreenW
chatbox.IC.Format_Width = (768/1024)*ScreenH
chatbox.IC.History = {}


chatbox.OOC.X = 20
chatbox.OOC.Y = chatbox.IC.Heigh+80
chatbox.OOC.Width = ((702/1.2)/1024)*ScreenH
chatbox.OOC.Heigh = ((316/1.6)/768)*ScreenH
chatbox.OOC.font = "default-bold"
chatbox.OOC.scale = (0.75/1024)*ScreenW
chatbox.OOC.History = {}

chatbox.Say = {}
chatbox.Say.Table = chatbox.IC.History
chatbox.Say.Show = true
chatbox.Say.Show_Carret = true
chatbox.Say.X = chatbox.IC.X+chatbox.IC.Width+10
chatbox.Say.Y = chatbox.IC.Y+chatbox.IC.Heigh+8
chatbox.Say.Width = chatbox.IC.Format_Width
chatbox.Say.Heigh = 35
chatbox.Say.font = "default-bold"
chatbox.Say.Title = "IC:"
chatbox.Say.Box = {}
chatbox.Say.Position = 0
chatbox.Say.scale = (0.75/1024)*ScreenW

function SendMessage(text)
if text then
	if (string.len(text)<1) then return end
		if (string.sub(text,1,1)=="/") then
		local cmd,args=splitCommand(text)
		if (string.lower(cmd)=="me") then
		triggerServerEvent("outputChatBoxIC:nearbyPlayer", localPlayer, args, 1)
		else
			triggerServerEvent("doExecuteCommandHandler", resourceRoot, cmd, localPlayer, args)	
			end
		return;
		end

		if chatbox.Say.Table == chatbox.IC.History then
			triggerServerEvent("outputChatBoxIC:nearbyPlayer", localPlayer, text, 0)
		elseif chatbox.Say.Table == chatbox.OOC.History then
			triggerServerEvent("doExecuteCommandHandler", resourceRoot,'b', localPlayer, text)	
		end
	end
end

for i,v in ipairs(getElementsByType("player")) do
	setElementData(v,"loggedIn",1)
	setElementData(v,"name","Richard")
	setElementData(v,"lastname","Lauther")
end

function RenderingChat()
if getElementData(getLocalPlayer(  ),"loggedIn") == 1 then

local Height_font = dxGetFontHeight( 1.15, "default-bold" )

if getElementData(getLocalPlayer(  ),"SAMP:chat") then
	dxDrawImage(chatbox.IC.X,chatbox.IC.Y,chatbox.IC.Width,chatbox.IC.Heigh,"files/scroll_base.png")
	local now = chatbox.IC.Y+21
	local ct = (chatbox.IC.Heigh/chatbox.IC.Page*0.100)
	local scroll = chatbox.IC.Heigh*0.100
	local now = now+scroll-ct
	local chatbox_y = math.min( math.max(  (now or chatbox.IC.Y+21) , chatbox.IC.Y+21) , chatbox.IC.Y+chatbox.IC.Heigh-46)
	dxDrawImage(chatbox.IC.X-1,chatbox_y,24,24,"files/scroll_icon.png")
	local Height = 0
	--outputDebugString(chatbox.IC.Page)


	for i=chatbox.IC.Page,chatbox.IC.Page+11 do
		if i >= chatbox.IC.Page and i <= chatbox.IC.Page+11 then
				local v = chatbox.IC.History[i]
				if v then
					if string.len(v[1]) > 89 then
					local i = 0
					local text = ""
					local old = Height
						for word in string.gmatch(v[1], ".") do
							if i == 90 then
								text = text.."\n"..word
								Height = Height+Height_font+1
								Height = Height*2
								i = 0
							else
								text = text..word
								i = i+1
							end
						end
						dxDrawBorderedText(text ,chatbox.IC.X+chatbox.IC.Width+10, chatbox.IC.Y+old, chatbox.IC.Format_Width, Height,tocolor(v[2],v[3],v[4],255), 1.15,"default-bold","left","top",false,false,false, v[5],1 )
					else
						dxDrawBorderedText(v[1] ,chatbox.IC.X+chatbox.IC.Width+10, chatbox.IC.Y+Height, chatbox.IC.Format_Width, Height,tocolor(v[2],v[3],v[4],255), 1.15,"default-bold","left","top",false,false,false, v[5],1 )
						Height = Height+Height_font+1
					end
			end
		end
	end
end

--- OOC --->
	dxDrawImage(chatbox.OOC.X,chatbox.OOC.Y,chatbox.OOC.Width,chatbox.OOC.Heigh,"files/window_ooc.png")
	local Height = 25
	for i=#chatbox.OOC.History-10,#chatbox.OOC.History do
	local v = chatbox.OOC.History[i]
		if v then
			dxDrawBorderedText(v[1],chatbox.OOC.X+10, chatbox.OOC.Y+Height, chatbox.IC.Format_Width, Height,tocolor(v[2],v[3],v[4],255), 1.15,"default-bold","left","top",false,false,false, v[5],1 )
			Height = Height+Height_font+1
		end	
	end

end

end
addEventHandler("onClientRender", root, RenderingChat)



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

function dxDrawBorderedText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak,postGUI, colorCoded, size, color_border)
if text then
local size = size or 1
local color_border = color_border or tocolor(0, 0, 0, 255)
    for oX = -size, size do
        for oY = -size, size do
               	dxDrawText(text:gsub("#%x%x%x%x%x%x",""), left + oX, top + oY, right + oX, bottom + oY, color_border, scale, font, alignX, alignY, clip, wordBreak,postGUI)
        	end
    	end
   	 	dxDrawText(text, left, top, right, bottom, color, scale, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded)
	end
end



function ChatBoxPageModeModifityMax()
if #chatbox.IC.History < 12 then
	chatbox.IC.Page = 1
	return
else
	chatbox.IC.Page = math.ceil(#chatbox.IC.History/12)
	end
end

function ChatBoxPageModeModifity()
	outputChatBox(chatbox.IC.Page)
if chatbox.IC.Page < #chatbox.IC.History-12 then
	chatbox.IC.Page = chatbox.IC.Page+1
	end
end
bindKey("pgup","up",ChatBoxPageModeModifity)

function ChatBoxPageModeModifity()
if chatbox.IC.Page > 1 then
	chatbox.IC.Page = chatbox.IC.Page-1
	end
end
bindKey("pgdn","up",ChatBoxPageModeModifity)

function getPlayerNameIC(Element)
if getElementData(Element,"character:data") then
	return getElementData(Element,"character:data").Name.." "..getElementData(Element,"character:data").Surname
	else
	return getPlayerName(Element)
	end
end


function Client_outputChatBoxIC(text,r,g,b,colorCoded)
if string.len(text) > 0 then
local r = r or 231
local g = g or 217
local b = b or 176
local n = 0
local p = 0
local colorCoded = colorCoded or false
	table.insert(chatbox.IC.History,{text,r,g,b,colorCoded})
	ChatBoxPageModeModifityMax()
	end
end
addEvent( "SAMP:outputChatBoxIC", true )
addEventHandler( "SAMP:outputChatBoxIC", localPlayer, Client_outputChatBoxIC )

function Client_outputChatBoxOOC(text,r,g,b,colorCoded)
if string.len(text) > 0 then
local r = r or 231
local g = g or 217
local b = b or 176
local colorCoded = colorCoded or false
	table.insert(chatbox.OOC.History,{text,r,g,b,colorCoded})
	end
end
addEvent( "SAMP:outputChatBoxOOC", true )
addEventHandler( "SAMP:outputChatBoxOOC", localPlayer, Client_outputChatBoxOOC )


--- SAMP COMMAND ---
function CommandHandlerSwitchSAMP()
local Chat = getElementData(getLocalPlayer(  ),"SAMP:chat")
	if Chat == false then
		showChat(false)
	else
		showChat(true)
	end

setElementData(getLocalPlayer(  ),"SAMP:chat",not Chat)
end
addCommandHandler( "SAMP", CommandHandlerSwitchSAMP )




---- PSUEDO SYSTEM PRZEDMIOTOW ---

-- Przedmioty = {}

-- function createItem(UID, Name, ownerType, owner, type, v1, v2, v3, x, y, z, vw, favorite, weight, used, last_used, created)
-- 	if UID and type then
-- 	if not(Name) then Name = serachItemName(type) end
-- 	if v1 and v2 and v3 and vw then
-- 	createItemOnGround(UID,Name,ownerType,v1,v2,v3,x,y,z)
-- 	return
-- 	end

-- 	end
-- end
