----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local trainingStartTime = 0
local trainingTime = 60000
local trainingFunc = {}
local trainingObject = nil

function trainingFunc.start(obj)
	addEventHandler("onClientRender", root, trainingFunc.renderTime)
	trainingStartTime = getTickCount()
	trainingObject = obj
end
addEvent("trainingFunc.start", true)
addEventHandler("trainingFunc.start", root, trainingFunc.start)

function trainingFunc.stop()
	removeEventHandler("onClientRender", root, trainingFunc.renderTime)
	exports.titan_hud:setStatus(false)
	exports.titan_hud:setStatusState(0)
end
addEvent("trainingFunc.stop", true)
addEventHandler("trainingFunc.stop", root, trainingFunc.stop)

function trainingFunc.renderTime()
	local progress = (getTickCount() - trainingStartTime) / trainingTime
	exports.titan_hud:setStatus(true)
	exports.titan_hud:setStatusState(progress)
	if progress >= 1 then
		removeEventHandler("onClientRender", root, trainingFunc.renderTime)
		exports.titan_noti:showBox("Trening zakonczony.")
		exports.titan_hud:setStatus(false)
		exports.titan_hud:setStatusState(0)
		triggerServerEvent("gymFunc.treadMillStop", localPlayer)
		return
	end

	if not isElement(trainingObject) or getDistanceBetweenPoints3D(localPlayer:getPosition(), trainingObject:getPosition()) > 3 then
		trainingFunc.stop()
		triggerServerEvent("gymFunc.onWasted", localPlayer)
		return
	end
end