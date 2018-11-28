----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local lastAction = getTickCount()
local sW, sH = guiGetScreenSize()
addEventHandler ("onClientRender",root,
	function ()
		if getTickCount() - lastAction >= 1000 * 30 then
			if getElementData(localPlayer,"isAFK") == false then
				local hp = getElementHealth(localPlayer)
				if hp > 0 then
					setElementData(localPlayer, "isAFK", true)
				end
			end
		end
		if isChatBoxInputActive() or isConsoleActive() or (localPlayer:getData("sampChat") and localPlayer:getData("sampChat:inputEnabled")) then
			if not localPlayer:getData("chatTyping") then localPlayer:setData("chatTyping", true) end
		elseif not isChatBoxInputActive() and not isConsoleActive() then
			if localPlayer:getData("chatTyping") then localPlayer:setData("chatTyping", false) end
		end

		if localPlayer:getData("isAFK") and localPlayer:getData("loggedIn") == 1 then
			if not source:getData("busTravel") then
				dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 100))
				dxDrawText("Jesteś AFK", 0, 0, sW, sH, tocolor(255, 255, 255, 255), 2.0, "default-bold", "center", "center")
			end
		end
	end
)

addEventHandler("onClientRestore", root,
	function ()
		lastAction = getTickCount()
		setElementData(localPlayer, "isAFK", false)
	end
)

addEventHandler("onClientMinimize", root,
	function ()
		setElementData(localPlayer, "isAFK", true)
	end
)

addEventHandler("onClientCursorMove", root,
    function ()
		lastAction = getTickCount()
		if getElementData(localPlayer, "isAFK") == true then
			setElementData(localPlayer, "isAFK", false)
		end
    end
)

addEventHandler("onClientKey", root, 
	function ()
		lastAction = getTickCount()
		if getElementData(localPlayer, "isAFK") == true then
			setElementData(localPlayer, "isAFK", false)
		end
	end
)