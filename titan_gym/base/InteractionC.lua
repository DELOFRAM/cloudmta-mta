Interaction = {}
Interaction.use = false
Interaction.func = {}

function Interaction.func.TogglePlayerEquipment(player)
	player = localPlayer
	local pos = player:getPosition()
	local rot = math.rad( 360-getPedRotation(player) )
	local x, y, z = pos.x + 1 * math.sin(rot), pos.y + 1 * math.cos(rot), pos.z
	local hit, x, y, z, Element = processLineOfSight ( pos.x, pos.y, pos.z, x, y, z, false, false, false, true)
	if hit then
		if getElementModel(Element) == 1985 and Interaction.use == false then
			-- panchBag
			Interaction.use = true
			startTraningpanchBag(Element)
		elseif getElementModel(Element) == 2627 and Interaction.use == false then
			-- Treadmil
			Interaction.use = true
			startTraningTreadmill(Element)
		elseif getElementModel(Element) == 2630 and Interaction.use == false then
			-- bike
			Interaction.use = true
			startTraningbike(Element)
		end
	end
end
bindKey("enter","down",Interaction.func.TogglePlayerEquipment)