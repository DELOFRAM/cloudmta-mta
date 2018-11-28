bike = {}
bike.point = {1,2}
bike.Timer = getTickCount(  )
bike.AnimationTimer = getTickCount(  )
bike.status = {}
bike.Activestatus = "still"
bike.select = 1
bike.AnimationSecond = 0
bike.Processing = 0
bike.Fatigue = 0
bike.status["slow"] = "gym_bike_slow"
bike.status["still"] = "gym_bike_still"
bike.status["getoff"] = "gym_bike_getoff"
bike.status["geton"] = "gym_bike_geton"
bike.status.switching = {"still","slow"}
bike.Object = false
--bike.Object = createObject(2630,  Vector3(  {x = 2185.521, y = -1727.776, z = 12.37} ) , 0, 0, 30 )

function bikeTraningKey(button)
	if bike.Activestatus ~= "getoff" and bike.Activestatus ~= "geton"  and  not isConsoleActive() and not isMainMenuActive() and not isChatBoxInputActive() and not isTransferBoxActive() then
		if button == "space" then
			bike.Activestatus = "getoff"
			bike.AnimationTimer = getTickCount(  )
			bike.AnimationSecond = 1.5
			getLocalPlayer(  ):setAnimation('gymnasium', bike.status[bike.Activestatus] )
		elseif button == "mouse_wheel_up" then
			if bike.select < #bike.status.switching then
				bike.select = bike.select+1
				bike.Activestatus = bike.status.switching[bike.select]
				getLocalPlayer(  ):setAnimation('gymnasium', bike.status[bike.Activestatus] )
			end
		elseif button == "mouse_wheel_down" then
			if bike.select > 1 then
				bike.select = bike.select-1
				bike.Activestatus = bike.status.switching[bike.select]
				getLocalPlayer(  ):setAnimation('gymnasium', bike.status[bike.Activestatus] )
			end

		end
	end
end

function bikeTraning()
	if getTickCount(  )-bike.Timer > 1000 then
		local proces = showBarBike()
		if proces[1] == proces[2] then
			bike.Processing = 0
			point = math.random(bike.point[1], bike.point[2])
			-- przydzielanie punktow trzeba zrobic gdzies
		end

		local block, anim = getLocalPlayer(  ):getAnimation()
		if bike.Fatigue >= 217 and not(bike.Activestatus == "getoff") then
			bike.Activestatus = "getoff"
			bike.AnimationSecond = 1.5
			bike.AnimationTimer = getTickCount(  )
			getLocalPlayer(  ):setAnimation('gymnasium', bike.status[bike.Activestatus] )
		end

		if getTickCount(  )-bike.AnimationTimer > bike.AnimationSecond*1000  and bike.Activestatus == "getoff" then
			bikeStopTraning()
		end

		if block == "gymnasium" and anim  == bike.status["still"] then
			bike.Fatigue = bike.Fatigue-0.09
		elseif block == "gymnasium" and anim  == bike.status["slow"] then
			bike.Fatigue = bike.Fatigue+0.1
			bike.Processing = bike.Processing+0.01
		elseif block == false then
			getLocalPlayer(  ):setAnimation('gymnasium', bike.status[bike.Activestatus] )
		end
	end
end

function bikeStopTraning()
	getLocalPlayer(  ):setFrozen(false)
	getLocalPlayer(  ):setAnimation(false)
	getLocalPlayer(  ):detach(bike.object)
	removeEventHandler ( "onClientRender", root, bikeTraning )
	removeEventHandler( "onClientKey", root, bikeTraningKey)
	setElementCollisionsEnabled(bike.object, true)
	bike.Activestatus = "still"
	Interaction.use = false
end


function startTraningbike(object)
	setElementCollisionsEnabled(object, false )
	local pos = getXYInFrontOfPlayer(object, 0.45)
	local rot = object:getRotation()
	pos.z = pos.z+1
	rot.z = rot.z-180
	getLocalPlayer(  ):setRotation(rot)
	getLocalPlayer(  ):attach(object, 0, 0.5, 1)
	getLocalPlayer(  ):setAnimation('gymnasium', bike.status["still"] )
	getLocalPlayer(  ):setFrozen(true)
	bike.object = object
	addEventHandler( "onClientKey", root, bikeTraningKey)
	addEventHandler ( "onClientRender", root, bikeTraning )
end