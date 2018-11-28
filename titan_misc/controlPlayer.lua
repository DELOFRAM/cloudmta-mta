--[[addEventHandler("onClientKey", root, function(button, press)
	if (press and button == "w") then
		setControlState("walk",true)
	end	
end)
]]

--- Wrazie próby zbugowania blokady strzelania na scoreboard
addEventHandler("onClientPlayerWeaponFire", root, function()
    if getElementData(localPlayer, "scoreboard") == true then
         setPedWeaponSlot( getLocalPlayer(  ), 0 )
         cancelEvent(  )
    end
end)