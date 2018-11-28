function RandomPosittion(x,y,z)
position_old = {x,y,z}
position = {}
for i=1,3 do
local isAdd = math.random(0,1)
	if isAdd == 1 then
		position[i] = position_old[i]+math.random(2.5,3.5)
	else
		position[i] = position_old[i]-math.random(2.5,3.5)
		end
	end
	return position[1],position[2]
end

function isElementWithinColShaper(Element,shape)
local data = getElementData(shape,"data:fire")
	if isElementWithinColShape(Element,shape) and getElementDimension( Element ) == data[6] and getElementInterior( Element ) == data[7] then
		return true
	else
		return false
	end
end

function takeElementOxygen(Element ,shape)
if isElementWithinColShaper( Element, shape ) then
	setPedOxygenLevel( Element, getPedOxygenLevel( Element ) - 1 )
	setTimer(takeElementOxygen, 1000, 1 , Element, shape)
	outputChatBox("Take oxygen")
	end
end

function takeElementHealth(Element ,shape)
if isElementWithinColShaper( Element, shape ) then
	setElementHealth( Element, getElementHealth( Element ) - math.random(25,35) )
	setTimer(takeElementHealth,1000, 1 , Element, shape)
	end
end