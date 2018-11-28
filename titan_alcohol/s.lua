Alcohol = {}

function takeDrunkLevel(player)
	if getElementData(player,"drunkLevel") > 0 and isElement(player) then
		local drunk = getElementData(player,"drunkLevel")
		setElementData(player,"drunkLevel",drunk-1)
	else
		if isTimer( Alcohol[player] ) then killTimer( Alcohol[player] ) end
	end
end

function setDrunkLevel(procent)
	if not(Alcohol) and isElement(source) then
		Alcohol[source] = {}
	end
	if isTimer( Alcohol[source] ) then killTimer( Alcohol[source] ) end
	Alcohol[source] = setTimer(takeDrunkLevel, 5000, 0, source)
	local drunk = getElementData(source,"drunkLevel") or 0
	setElementData(source,"drunkLevel",drunk+procent)
end
addEvent( "setDrunkLevel", false )
addEventHandler( "setDrunkLevel", getRootElement(  ), setDrunkLevel )


function setPedDrunkWalkStyle(player)
	setPedWalkingStyle( player, 126 )
end
addEvent( "setPedDrunkWalkStyle", true )
addEventHandler( "setPedDrunkWalkStyle", getRootElement(  ), setPedDrunkWalkStyle )