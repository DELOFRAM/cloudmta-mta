Treadmill = {}
Treadmill.point = {1,3}
Treadmill.Timer = getTickCount(  )
Treadmill.AnimationTimer = getTickCount(  )
Treadmill.AnimationSecond = 0
Treadmill.Point = 0
Treadmill.Count = 0
Treadmill.Distance = 0
Treadmill.Fatigue = 0
Treadmill.Activestatus = "walk"
Treadmill.select = 1
Treadmill.status = {}
Treadmill.status["walk"] = "gym_tread_walk"	
Treadmill.status["sprint"] = "gym_tread_sprint"
Treadmill.status["jog"] = "gym_tread_jog"
Treadmill.status["tired"] = "gym_tread_tired"	
Treadmill.status["falloff"] = "gym_tread_falloff"
Treadmill.status["getoff"] = "gym_tread_getoff"
Treadmill.status["geton"] = "gym_tread_geton"
Treadmill.status["celebrate"] = "gym_tread_geton"
Treadmill.status.switching = {"walk","sprint","jog","tired"}
Treadmill.Object = false
--Treadmill.Object = createObject(2627,  Vector3(  {x = 2185.521, y = -1727.776, z = 12.37} ) , 0, 0, 0 )

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end


function treadmillTraningKey(button)
	if Treadmill.Activestatus ~= "getoff" and Treadmill.Activestatus ~= "falloff" and  not isConsoleActive() and not isMainMenuActive() and not isChatBoxInputActive() and not isTransferBoxActive() then
		if button == "space" and not(Treadmill.Activestatus == "getoff") then
			Treadmill.Activestatus = "getoff"
			Treadmill.AnimationTimer = getTickCount(  )
			Treadmill.AnimationSecond = 3.2
			getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
		elseif button == "mouse_wheel_up" then
			if Treadmill.select < #Treadmill.status.switching then
				Treadmill.select = Treadmill.select+1
				Treadmill.Activestatus = Treadmill.status.switching[Treadmill.select]
				getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
			end
		elseif button == "mouse_wheel_down" then
			if Treadmill.select > 1 then
				Treadmill.select = Treadmill.select-1
				Treadmill.Activestatus = Treadmill.status.switching[Treadmill.select]
				getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
			end

		end
	end
end

function treadmillTraning()
	if getTickCount(  )-Treadmill.Timer > 1000 then
		local proces = showBar()

		if proces[1] == proces[2] then
			Treadmill.Distance = 0
			point = math.random(Treadmill.point[1], Treadmill.point[2])
			-- przydzielanie punktow trzeba zrobic gdzies
		end

		local block, anim = getLocalPlayer(  ):getAnimation()
		if Treadmill.Fatigue >= 217 and Treadmill.Activestatus ~= "falloff" then
			Treadmill.Activestatus = "falloff"
			Treadmill.AnimationSecond = 2
			Treadmill.AnimationTimer = getTickCount(  )
			getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
		end
		if getTickCount(  )-Treadmill.AnimationTimer > Treadmill.AnimationSecond*1000  and (Treadmill.Activestatus == "falloff" or Treadmill.Activestatus == "getoff") then
			stopTraningTreadmill()
		end
		if block == "gymnasium" and anim  == Treadmill.status["walk"] then
			Treadmill.Distance = Treadmill.Distance+0.1
			Treadmill.Fatigue = Treadmill.Fatigue+0.2
			Treadmill.Count = Treadmill.Count+0.1
		elseif block == "gymnasium" and anim == Treadmill.status["sprint"] then
			Treadmill.Distance = Treadmill.Distance+0.3
			Treadmill.Fatigue = Treadmill.Fatigue+0.4
			Treadmill.Count = Treadmill.Count+0.1
		elseif block == "gymnasium" and anim == Treadmill.status["jog"] then
			Treadmill.Distance = Treadmill.Distance+0.2
			Treadmill.Fatigue = Treadmill.Fatigue+0.3
			Treadmill.Count = Treadmill.Count+0.1
		elseif block == "gymnasium" and anim == Treadmill.status["celebrate"] then
			Treadmill.Distance = Treadmill.Distance+0.1
			Treadmill.Fatigue = Treadmill.Fatigue+0.2
			Treadmill.Count = Treadmill.Count+0.1
		elseif block == "gymnasium" and anim == Treadmill.status["tired"] then
			if Treadmill.Fatigue <= 0 then 
				Treadmill.Activestatus = "walk" 
				Treadmill.select = 1
				getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
			end
			Treadmill.Fatigue = Treadmill.Fatigue-0.09
		elseif block == false then
			getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
		end
		if Treadmill.Count >= 100 then
			Treadmill.Count = 0
			Treadmill.Point = Treadmill.Point+1
		end
	end
end

function stopTraningTreadmill()
	getLocalPlayer(  ):setFrozen(false)
	getLocalPlayer(  ):setAnimation(false)
	removeEventHandler ( "onClientRender", root, treadmillTraning )
	removeEventHandler( "onClientKey", root, treadmillTraningKey)
	Treadmill.Activestatus = "walk"
	Interaction.use = false
end

function startTraningTreadmill(object)
	Treadmill.Object = object
	local pos = Treadmill.Object:getPosition()
	local rot = Treadmill.Object:getRotation()
	pos.z = pos.z+0.5
	getLocalPlayer(  ):setPosition(pos)
	getLocalPlayer(  ):setRotation(rot)
	getLocalPlayer(  ):setAnimation('gymnasium', Treadmill.status[Treadmill.Activestatus] )
	getLocalPlayer(  ):setFrozen(true)
	addEventHandler ( "onClientRender", root, treadmillTraning )
	addEventHandler( "onClientKey", root, treadmillTraningKey)
end