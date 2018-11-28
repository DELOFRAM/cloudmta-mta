----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

toggleAllControls(true)

local courierAnim =
{
	state = false
}
function courierAnim.toggle(state)
	if state then
		if not courierAnim.state then
			addEventHandler("onClientKey", root, courierAnim.clientKey)
			courierAnim.state = true
			courierAnim.toggleControls(state)
		end
	else
		if courierAnim.state then
			removeEventHandler("onClientKey", root, courierAnim.clientKey)
			courierAnim.state = false
			courierAnim.toggleControls(state)
		end
	end
end
addEvent("courierAnim.toggle", true)
addEventHandler("courierAnim.toggle", root, courierAnim.toggle)

function courierAnim.toggleControls(state)
	toggleAllControls(not state, true, false)
	setControlState("walk", false)
end

function courierAnim.isBoundKey(key, controlName)
	local boundKeys = getBoundKeys(controlName)
	if type(boundKeys) ~= "table" then return false end
	for k, v in pairs(boundKeys) do
		if k == key then return true end
	end
	return false
end

function courierAnim.clientKey(key, state)
	if courierAnim.isBoundKey(key, "forwards") then
		setControlState("walk", true)
		setControlState("forwards", state)
	elseif courierAnim.isBoundKey(key, "backwards") then
		setControlState("walk", true)
		setControlState("backwards", state)
	elseif courierAnim.isBoundKey(key, "left") then
		setControlState("walk", true)
		setControlState("left", state)
	elseif courierAnim.isBoundKey(key, "right") then
		setControlState("walk", true)
		setControlState("right", state)
	elseif courierAnim.isBoundKey(key, "enter_exit") then
		setControlState("enter_exit", true)
	end
end