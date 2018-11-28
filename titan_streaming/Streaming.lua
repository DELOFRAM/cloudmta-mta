Memory = {} -- Przechowywane dane po stronie serwera

function setMemoryObject(object)
	local x,y,z = getElementPosition( object )
	local rx,ry,rz = getElementRotation( object )
	local int = getElementInterior( object )
	local dim = getElementDimension( object )
	local model = getElementModel(object)
	local scale = getObjectScale( object )
	local resource = getElementID( getElementParent( getElementParent( object ) ) )
	local double = isElementDoubleSided( object )
	local colission = getElementCollisionsEnabled( object )
	table.insert(Memory,{x=x,y=y,z=z,rx=rx,ry=ry,rz=rz,int=int,dim=dim,model=model,double=double,scale=scale,colission=colission,stream=false,resource=resource})
end
addEvent( "setMemoryObject", true )
addEventHandler( "setMemoryObject", root, setMemoryObject)

function syncStreaming(player)
	triggerClientEvent( player,"setMemmoryStreaming:client", player, Memory )
end

function onResStop()
tempTable = {}
	for i,v in ipairs(Memory) do
		if not tempTable[v.resource] and v.resource ~= "dynamic" then
			restartResource( tostring(v.resource) )
			tempTable[v.resource] = true
			outputChatBox(v.resource)
		end
	end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), onResStop)

function onSyncAll()
	for i,v in ipairs(getElementsByType("object")) do
		local resource = getElementID( getElementParent( getElementParent( v ) ) )
		if resource == "titan_models" then
			setMemoryObject(v)
		end
	end

	for i,v in ipairs(getElementsByType("object")) do
		local resource = getElementID( getElementParent( getElementParent( v ) ) )
		if isElement(v) and resource == "titan_models" then
			destroyElement(v)
		end
	end	

	for i,v in ipairs(getElementsByType("player")) do
		syncStreaming(v)
	end
end

function onResStart()
	setTimer(onSyncAll,1000,1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResStart)