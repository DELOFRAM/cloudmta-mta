AI = {}
AI.data = {}
AI._index = AI;

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end

function AI:New(data, ...)
	local obj = setmetatable({}, {__index = self});
	if obj.Constructor then
		obj:Constructor(data, ...);
	end
	return obj;
end

function AI:Constructor(data)
	self.ID = data.ID
	self.player = data.Player
	self.NPC = data.NPC
	self.target = data.target
	self.type = data.type
	self.func = function()  self:Processing() end
	addEventHandler ( "onClientRender", root, self.func )
end

function AI:getData()
	return self
end


function AI:checkClimbing()
	local pos = self.NPC:getPosition()
	local rot = math.rad( 360-getPedRotation(self.NPC) )
	local x = pos.x + 1 * math.sin(rot)
	local y = pos.y + 1 * math.cos(rot)
	local line = isLineOfSightClear(x, y, pos.z, pos.x, pos.y, pos.z, true, true, false, true )
	--  // DEBUG LINE CLIMBING dxDrawLine3D( x, y, pos.z, pos.x, pos.y, pos.z )
	if not line then
		setPedControlState( self.NPC,"forwards", false);
		setPedControlState( self.NPC,"walk", false);
		setPedControlState( self.NPC, "sprint", false );
		setPedControlState( self.NPC, "jump", true );
	else
		setPedControlState( self.NPC, "jump", false );
	end
end

function AI:fixRotaitonWithPlayer(pos, pos2)
	local rotZ = findRotation(pos.x, pos.y, pos2.x, pos2.y)
	local WrotZ = findRotation(pos2.x, pos2.y, pos.x, pos.y)
	local rotZ = rotZ-180
	if not(rotZ == WrotZ) then
		setPedRotation(self.NPC, rotZ+180)
	end
end


function AI:deleteProcessingNPC()
	if AI.data[self.ID] then
		local data = self:getData()
		removeEventHandler ( "onClientRender", root, data.func )
		AI.data[self.ID] = nil
		self = nil
	end
end


function AI:trigger()
	if self.event == "Transaction:start" then
		if self.target == localPlayer then
			triggerServerEvent(self.event, self.player, self.ID, self.NPC )
		end
	else
		triggerServerEvent(self.event, self.player, self.ID, self.NPC )
	end
end

function AI:Processing()
if not( isElement(self.target) ) or not( isElement(self.NPC) ) then
	self:deleteProcessingNPC()
end
	if self.target and self.type == "walkToTarget" then
		self.distance = getDistanceBetweenPoints3D( Vector3( self.target:getPosition() ), Vector3( self.NPC:getPosition()  ) )
		self:fixRotaitonWithPlayer(self.NPC:getPosition(), self.target:getPosition())
		self:checkClimbing()
			if self.distance < 2  then
				setPedControlState( self.NPC, "walk", false );
				setPedControlState( self.NPC, "sprint", false );
				setPedControlState( self.NPC,"forwards", false);
				self.event = "Transaction:start"
				self:trigger()
				self:deleteProcessingNPC()
			else
				setPedControlState( self.NPC, "walk", true );
				setPedControlState( self.NPC, "sprint", false );
				setPedControlState( self.NPC,"forwards", true);
		end

	elseif self.target and self.type == "walkAwayFromTarget" then
		self.distance = getDistanceBetweenPoints3D( Vector3( self.target:getPosition() ), Vector3( self.NPC:getPosition()  ) )
		self:fixRotaitonWithPlayer(self.target:getPosition(), self.NPC:getPosition())
		self:checkClimbing()
			if self.distance > 10  then
				setPedControlState( self.NPC, "walk", false );
				setPedControlState( self.NPC, "sprint", false );
				setPedControlState( self.NPC,"forwards", false);
				self.event = "Transaction:cancel"
				self:trigger()
				self:deleteProcessingNPC()
			else
				setPedControlState( self.NPC, "walk", true );
				setPedControlState( self.NPC, "sprint", false );
				setPedControlState( self.NPC,"forwards", true);
		end	

	end
end

function createProcessingNPC(id, element, target, type)
	AI.data[id] = AI:New({ID=id, Player=getLocalPlayer(  ), NPC=element, target=target, type=type})
end
addEvent( "AI:create", true ) 
addEventHandler( "AI:create", getRootElement(  ), createProcessingNPC)


function findAmountInString(text)
for word in string.gmatch(text, "%d+") do
    if tonumber(word) then
    	if string.sub(text, string.find(text,word,1)+string.len(word)+1 , string.find(text,word,1)+string.len(word)+1) == "$" or string.sub(text, string.find(text,word,1)-1  ) == "$" then
    		amount = word
        	end
    	end
	end
end
