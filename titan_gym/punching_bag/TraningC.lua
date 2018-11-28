panchBag = {}
panchBag.point = {1,3}
panchBag.Timer = getTickCount(  )
panchBag.AnimationTimer = getTickCount(  )
panchBag.status = {}
panchBag.Activestatus = "b1"
panchBag.select = 1
panchBag.AnimationSecond = 0
panchBag.Processing = 0
panchBag.Fatigue = 0
panchBag.status["idle"] = "FightB_IDLE"
panchBag.status["b1"] = "FightB_1"
panchBag.status["b2"] = "FightB_2"
panchBag.status["b3"] = "FightB_3"
panchBag.status["falloff"] = "FALL_collapse"
panchBag.status.switching = {"idle","b1","b2","b3"}
panchBag.Object = false
-- panchBag.Object = createObject(1985,  Vector3(  {x = 2185.521, y = -1727.776, z = 15.37} ) , 0, 0, 0 )

function panchBagTraningKey(button)
	if panchBag.Activestatus ~= "falloff" and  not isConsoleActive() and not isMainMenuActive() and not isChatBoxInputActive() and not isTransferBoxActive() then
		if button == "space" then
			panchBagStopTraning()
		elseif button == "mouse_wheel_up" then
			if panchBag.select < #panchBag.status.switching then
				panchBag.select = panchBag.select+1
				panchBag.Activestatus = panchBag.status.switching[panchBag.select]
				getLocalPlayer(  ):setAnimation('fight_b', panchBag.status[panchBag.Activestatus] )
			end
		elseif button == "mouse_wheel_down" then
			if panchBag.select > 1 then
				panchBag.select = panchBag.select-1
				panchBag.Activestatus = panchBag.status.switching[panchBag.select]
				getLocalPlayer(  ):setAnimation('fight_b', panchBag.status[panchBag.Activestatus] )
			end

		end
	end
end

function panchBagTraning()
	if getTickCount(  )-panchBag.Timer > 1000 then
		local proces = showBarPunchBag()
		if proces[1] == proces[2] then
			panchBag.Processing = 0
			point = math.random(panchBag.point[1], panchBag.point[2])
			-- przydzielanie punktow trzeba zrobic gdzies
		end	

		local block, anim = getLocalPlayer(  ):getAnimation()
		if panchBag.Fatigue >= 217 and not(panchBag.Activestatus == "falloff") then
			panchBag.Activestatus = "falloff"
			panchBag.AnimationSecond = 0.5
			panchBag.AnimationTimer = getTickCount(  )
			getLocalPlayer(  ):setAnimation('ped', panchBag.status[panchBag.Activestatus] )
		end

		if getTickCount(  )-panchBag.AnimationTimer > panchBag.AnimationSecond*1000  and panchBag.Activestatus == "falloff" then
			panchBagStopTraning()
		end

		if block == "fight_b" and anim  == panchBag.status["idle"] then
			panchBag.Fatigue = panchBag.Fatigue-0.09
		elseif block == "fight_b" and anim  == panchBag.status["b1"] then
			panchBag.Fatigue = panchBag.Fatigue+0.2
			panchBag.Processing = panchBag.Processing+0.1
		elseif block == "fight_b" and anim  == panchBag.status["b2"] then
			panchBag.Fatigue = panchBag.Fatigue+0.3
			panchBag.Processing = panchBag.Processing+0.2
		elseif block == "fight_b" and anim  == panchBag.status["b3"] then
			panchBag.Fatigue = panchBag.Fatigue+0.4
			panchBag.Processing = panchBag.Processing+0.3
		elseif block == false then
			getLocalPlayer(  ):setAnimation('fight_b', panchBag.status[panchBag.Activestatus] )
		end
	end
end

function panchBagStopTraning()
	getLocalPlayer(  ):setFrozen(false)
	getLocalPlayer(  ):setAnimation(false)
	removeEventHandler ( "onClientRender", root, panchBagTraning )
	removeEventHandler( "onClientKey", root, panchBagTraningKey)
	panchBag.Activestatus = "b1"
	Interaction.use = false
end


function startTraningpanchBag(object)
	local pos = getXYInFrontOfPlayer(object, -1)
	local rot = object:getRotation()
	pos.z = pos.z-2
	getLocalPlayer(  ):setPosition(pos)
	getLocalPlayer(  ):setRotation(rot)

	getLocalPlayer(  ):setAnimation('FIGHT_B', panchBag.status[panchBag.Activestatus] )
	getLocalPlayer(  ):setFrozen(true)
	addEventHandler( "onClientKey", root, panchBagTraningKey)
	addEventHandler ( "onClientRender", root, panchBagTraning )
end