----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local map = false
local data = {}

local screenW, screenH = guiGetScreenSize()

data.state = false
data.w = 800
data.h = 800
data.x = screenW/2-data.w/2
data.y = screenH/2-data.h/2
function mapTeleport(state)
	if(state) then
		addEventHandler("onClientRender",root,mapRender)
		addEventHandler("onClientClick",root,mapClick)
		exports.titan_cursor:showCustomCursor("adminMapTeleport")
	else
		removeEventHandler("onClientRender",root,mapRender)
		removeEventHandler("onClientClick",root,mapClick)
		exports.titan_cursor:hideCustomCursor("adminMapTeleport")
	end
	map = state
end

function mapRender()
	dxDrawImage(data.x,data.y,data.w,data.h,"client/map.jpg")
end

function mapClick(button,state,ax,ay)
	if button=="left" and state=="down" then
		local x = ax - data.x
		local y = ay - data.y
		
		if x>=0 and x<=data.w and y>=0 and y <= data.h then
			local p = 2998
			
			x = -p+((x/data.w)*(p*2))
			y = p-((y/data.h)*(p*2))
			local z = getGroundPosition(x,y,10000)
			setElementPosition(getLocalPlayer(),x,y,z+1)
			setElementFrozen(getLocalPlayer(),true)
			setTimer(function(x,y,z)
				z = getGroundPosition(x,y,z+1000)
				setElementFrozen(getLocalPlayer(),false)
				setElementPosition(getLocalPlayer(),x,y,z+1)
			end,3000,1,x,y,z)
			mapTeleport(false)
		end
	end
end

addCommandHandler("tele", function()
	if getElementData(localPlayer, "adminDuty") then
	mapTeleport(not map)
	end
end)