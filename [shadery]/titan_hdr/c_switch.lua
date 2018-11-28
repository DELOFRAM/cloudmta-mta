--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------

--------------------------------
-- Command handler
--		Toggle via command
--------------------------------
addCommandHandler( "contrast",
	function()
		triggerEvent( "switchContrast", resourceRoot, not bEffectEnabled )
	end
)


--------------------------------
-- Switch effect on or off
--------------------------------
function switchContrast( bOn )
	if bOn then
		enableContrast()
	else
		disableContrast()
	end
end
addEvent( "switchContrast", true )
addEventHandler( "switchContrast", resourceRoot, switchContrast )


