local StreamDistance = 5
local Memory = {}

function setMemoryObject(object)
	local x,y,z = getElementPosition( object )
	local rx,ry,rz = getElementRotation( object )
	local int = getElementInterior( object )
	local dim = getElementDimension( object )
	local model = getElementModel(object)
	local brekable = isObjectBreakable( object )
	local double = isElementDoubleSided( object )
	local scale = getObjectScale( object )
	table.insert(Memory,{x=x,y=y,z=z,rx=rx,ry=ry,rz=rz,int=int,dim=dim,model=model,brekable=brekable,double=double,scale=scale,stream=false})
end

-- local function onResStart()
-- 	for k, v in ipairs(getElementsByType("object")) do
-- 		setMemoryObject(v)
-- 		destroyElement( v )
-- 	end
-- end
-- addEventHandler("onClientResourceStart", resourceRoot, onResStart)



function onElementStreamFrame()
local camX, camY, camZ = getCameraMatrix()
	for i,v in ipairs(Memory) do
	if v.x and v.y and v.z then
		local distance = getDistanceBetweenPoints3D(camX, camY, camZ, v.x, v.y, v.z)
			if distance < StreamDistance then
				if not isElement(v.object) and not v.stream then
					v.object = createObject(v.model, v.x, v.y, v.z, v.rx, v.ry, v.rz)
					v.object:setDimension(v.dim)
					v.object:setInterior(v.int)
					setElementDoubleSided( v.object, v.double )
					setObjectBreakable( v.object, v.brekable )
					setObjectScale( v.object, v.scale )
					v.stream = true
					outputChatBox(tostring(i))
				end
			elseif distance > StreamDistance and v.stream == true and isElement(v.object) then
				destroyElement( v.object )
				v.stream = false
			end
		end
	end
end
addEventHandler("onClientRender", root, onElementStreamFrame)