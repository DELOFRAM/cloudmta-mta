local ScreenW,ScreenH = guiGetScreenSize(  )
chatbox = {}
chatbox.IC = {}
chatbox.OOC = {}
chatbox.Say = {}
chatbox.IC.Page = 1
chatbox.IC.X = 0
chatbox.IC.Y = 0
chatbox.IC.Width = (23 / 1024)*ScreenH
chatbox.IC.Heigh = (185/768)*ScreenH
chatbox.IC.font = "default-bold"
chatbox.IC.scale = (0.75/1024)*ScreenW
chatbox.IC.Format_Width = (768/1024)*ScreenH
chatbox.IC.History = {}
chatbox.OOC.X = 0
chatbox.OOC.Y = 0
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
Editbox = {}
Editbox.__index = Editbox

local fontsize = 1.0
local fonttype = "default-bold"

local x,y = guiGetScreenSize()
 
function isCursorOnElement(x,y,w,h)
	if isCursorShowing() then
	local mx,my = getCursorPosition()
	local fullx,fully = guiGetScreenSize()
	cursorx,cursory = mx*fullx,my*fully
		if cursorx > x and cursorx < x + w and cursory > y and cursory < y + h then
			return true
		else
			return false
		end
	end
end

function Editbox:New( x, y, w, h )
	local data = {};
	data.x = x;
	data.y = y;
	data.w = w;
	data.h = h;
	data.activ = true
	data.alpha = 0
	data.text = ""
	data.Page = 0
	data.replace = 0
	self.textactiv = true
	data.History = {}
	data.limit = 128
	data.clickFunc = function(_, state ) data:onClick( _, state) end
	data.renderFunc = function() data:onRender() end;
	data.characterFunc = function( character, press ) data:onCharacter( character, press ) end
	
	addEventHandler("onClientKey", root, data.characterFunc)
	addEventHandler("onClientClick", root, data.clickFunc)
	addEventHandler("onClientRender", root, data.renderFunc)
	setmetatable( data, self )
	return data;
end

function Editbox:onClick( _, state )
	if not( self.activ ) then
		return;
	end
	if ( state == "down" ) then
		if isCursorOnElement( self.x, self.y, self.w, self.h ) then
			self.textactiv = true
		else
			self.textactiv = false
		end
	end
end

function Editbox:getCharacterKey(key)
	if(getKeyState("ralt") and (not getKeyState("lshift") and not getKeyState("rshift"))) then
		if(key == "e") then key = "ę" end
		if(key == "o") then key = "ó" end
		if(key == "a") then key = "ą" end
		if(key == "s") then key = "ś" end
		if(key == "l") then key = "ł" end
		if(key == "z") then key = "ż" end
		if(key == "x") then key = "ź" end
		if(key == "c") then key = "ć" end
		if(key == "n") then key = "ń" end
	end
	if getKeyState( "lctrl" ) then 
		return
	elseif getKeyState( "capslock" ) then 
		self.upperCase = not self.upperCase  
		return false, false
	end
	if(getKeyState("lshift") or getKeyState("rshift")) then
		if(getKeyState("ralt")) then
			if(key == "e") then key = "Ę"
			elseif(key == "o") then key = "Ó"
			elseif(key == "a") then key = "Ą"
			elseif(key == "s") then key = "Ś"
			elseif(key == "l") then key = "Ł"
			elseif(key == "z") then key = "Ż"
			elseif(key == "x") then key = "Ź"
			elseif(key == "c") then key = "Ć"
			elseif(key == "n") then key = "Ń"
			else key = string.upper(key) end
		else
			if key == "1" then key = "!" end
			if key == "2" then key = "@" end
			if key == "3" then key = "#" end
			if key == "4" then key = "$" end
			if key == "5" then key = "%" end
			if key == "6" then key = "^" end
			if key == "7" then key = "&" end
			if key == "8" then key = "*" end
			if key == "9" then key = "(" end
			if key == "0" then key = ")" end
			if key == ";" then key = ":" end
			if key == "'" then key = "\"" end
			if key == "/" then key = "?" end
			if key == "," then key = "<" end
			if key == "." then key = ">" end
			key = string.upper(key)
		end
	end
	if key == "backspace" or key == "enter" or key == "arrow_l" or key == "arrow_r" or key == "arrow_u" or key == "arrow_d" then
		return false,false
	end

	if self.upperCase then
		key = string.upper(key)
	end	
 
	return true,key
end


function replace_char3(pos, str, r)
    return table.concat{str:sub(1,pos-1), r, str:sub(pos+1)}
end

function isEnableKey( character ) 
	local value = false;
	for index, key in ipairs( enableKeys ) do 
		if ( character == key ) then
			value = true;
		end
	end
	if SpeciaKeys[character] then
		value = true
	end

	return value;
end

function Editbox:onCharacter( character, press )
	if not ( self.textactiv ) then
		return;
	end
	cancelEvent()
	if ( press ) then
		if isEnableKey( character ) and not isChatBoxInputActive() and not isConsoleActive() and not isMainMenuActive() then
			if ( character == "space" ) and ( dxGetTextWidth( self.text, fontsize, fonttype ) <= (self.w-7) ) then
				self.text = self.text.." "
				self.replace = self.replace+1
				return;
			end

			if (character == "arrow_l") then
				if self.replace >= 1 then
				self.replace = self.replace-1
				end
				return;
			end 


			if (character == "arrow_r") then
				if #self.text-2 > self.replace-2 then
				self.replace = self.replace+1
				end
				return;
			end 



			if (character == "arrow_u") then
				if #self.History+1 > self.Page then
				self.Page = self.Page+1
				self.text = self.History[self.Page] or ""
				end
				return;
			end 

			if (character == "arrow_d") then
				if self.Page > 0 then
				self.Page = self.Page-1
				self.text = self.History[self.Page] or ""
				end
				return;
			end 


			if (character == "escape") then
				self.text = ""
				self.Page = 0
				self.replace = 0
				EditBoxShowIC()
				return;
			end

			if (character == "enter") then
				local text = self.text
				self.Page = 0
				self.replace = 0
				table.insert(self.History,text)
				SendMessage(text)
				EditBoxShowIC()
				self.text = ""
				return;
			end

			local input, key = self:getCharacterKey(character)

				if not(input == false) and not(self.limit < string.len(self.text) ) then
					self.text = string.sub(self.text,1,self.replace).. key ..string.sub(self.text, self.replace+1 ,string.len(self.text) )
					self.replace = self.replace+1
				elseif character == "backspace" and input == false and ( #self.text > 0 ) and not isChatBoxInputActive() and not isConsoleActive() and not isMainMenuActive() then
					sub = string.sub(self.text, 1, #self.text - 1)
					self.text = sub
					self.replace = self.replace-1
			end
		end
	end
end




local value = 0
function Editbox:onRender()
	if not ( self.activ ) then
		return;
	end
	dxDrawImage(self.x, self.y, chatbox.Say.Width + 290, chatbox.Say.Heigh,"files/EditBox.png",0,0,0,tocolor(255,255,255,75))
	local X = self.x+9
	local Y = self.y
	dxDrawBorderedText(chatbox.Say.Title, X, self.y+(self.h/2)-7, self.w, self.y+(self.h/2)-5,tocolor(255,255,255,255),1.15, "default-bold","left","top",false,false,false,false,1,tocolor(75,75,75,255) )
	value = value + 10
	local WIDTH = dxGetTextWidth( chatbox.Say.Title, 1.15, "default-bold" )
	local X = self.x+WIDTH+15


	if dxGetTextWidth( self.text, 1 ) <= self.w then

		dxDrawRectangle(X+dxGetTextWidth( string.sub(self.text,1,self.replace), fontsize, fonttype ), Y+1, 1, self.h-2, tocolor(255, 255, 255, self.alpha+value), true)
	end



	if (#self.text) > 0 then
		dxDrawText( self.text, X, self.y+(self.h/2)-6, self.w, self.y+(self.h/2)-6, tocolor ( 255, 255, 255, 255 ), 1, "default-bold")
	end
end

function splitCommand(cmd)
  cmd=string.sub(cmd,2)
  local spacja=string.find(cmd, " ")
  if not spacja then return cmd,nil end
  return string.sub(cmd,1,spacja-1),string.sub(cmd,spacja+1)
end


function dxSetVisible( element, state ) 
	if ( element ) then
		element.activ = state; 
	else
		return outputDebugString("Failed setVisible dxElement!");
	end
end


function dxGetVisible( element )
	if ( element ) then
		return(element.activ);
	else
		return outputDebugString("Failed getVisible dxElement!");
	end
end
function dxGetText( element )
	if ( element ) then 
		return element.text;
	else
		return outputDebugString("Failed dxGetText");
	end
end

Edit = Editbox:New(chatbox.Say.X, chatbox.Say.Y, chatbox.Say.Width, chatbox.Say.Heigh)
Editbox.textactiv = not Editbox.textactiv
dxSetVisible(Edit, false )

function EditBoxShowIC()
local visible = dxGetVisible(Edit)
if not(visible) and getElementData(getLocalPlayer(  ),"SAMP:chat") == false then return end
dxSetVisible(Edit, not visible )
Editbox.textactiv = not Editbox.textactiv
chatbox.Say.Title = "IC:"
chatbox.Say.Table = chatbox.IC.History
	if visible == false then
		toggleAllControls( false )
		guiSetInputMode( "no_binds_when_editing" )
		unbindKey("t","down",EditBoxShowIC)
		unbindKey("b","down",EditBoxShowOOC)
	elseif visible == true then
		toggleAllControls( true )
		guiSetInputMode( "allow_binds" )
		bindKey("t","down",EditBoxShowIC)
		bindKey("b","down",EditBoxShowOOC)
	end
end
bindKey("t","down",EditBoxShowIC)


function EditBoxShowOOC()
local visible = dxGetVisible(Edit)
if not(visible) and getElementData(getLocalPlayer(  ),"SAMP:chat") == false then return end
dxSetVisible(Edit, not visible )
Editbox.textactiv = not Editbox.textactiv
chatbox.Say.Title = "OOC:"
chatbox.Say.Table = chatbox.OOC.History
	if visible == false then
		toggleAllControls( false )
		guiSetInputMode( "no_binds_when_editing" )
		unbindKey("t","down",EditBoxShowIC)
		unbindKey("b","down",EditBoxShowOOC)
	elseif visible == true then
		toggleAllControls( true )
		guiSetInputMode( "allow_binds" )
		bindKey("t","down",EditBoxShowIC)
		bindKey("b","down",EditBoxShowOOC)
	end
end
bindKey("b","down",EditBoxShowOOC)


enableKeys = {'(',')','#','*','/','arrow_l','arrow_r','arrow_u','arrow_d','backspace','enter','escape','space','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',':',';','<','=','>','?','@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','{','|','}','~','[','/',']','^','§','0','1','2','3','4','5','6','7','8','9','Ç','ü','é','â','ä','à','å','ç','ê','ë','è','ô','ö','ò','û','ù','ÿ','Ö','Ü','¢','£','¥','₧','ƒ','á','í','ó','ú','ñ','Ñ','ª','º',"ą","ę","ć","ż","ź","ł","ó","ń","ś",}
SpeciaKeys = {
['1'] = '!',	
['2'] = '@',
['3'] = '#',
['4'] = '$',
['5'] = '%',
['6'] = '^',
['7'] = '&',
['8'] = '*',
['9'] = '(',
['0'] = ')'
}