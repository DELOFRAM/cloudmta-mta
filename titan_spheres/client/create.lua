----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local createFunc = {}
local createData = {}

function createFunc.resetData()
	createData = 
	{
		state = false,
		checkpoints = {}
	}
end
addEventHandler("onClientResourceStart", resourceRoot, createFunc.resetData)

function createFunc.renderSphere()
	if not createData.state then
		removeEventHandler("onClientRender", root, createFunc.renderSphere)
		return
	end

	if #createData.checkpoints >= 1 then
		for k, v in ipairs(createData.checkpoints) do
			local color = k == #createData.checkpoints and tocolor(0, 0, 0, 255) or tocolor(255, 255, 255, 255)
			dxDrawLine3D(v.x - 0.5, v.y, v.z, v.x + 0.5, v.y, v.z, tocolor(255, 0, 0, 255), 1.0)
			dxDrawLine3D(v.x, v.y - 0.5, v.z, v.x, v.y + 0.5, v.z, tocolor(0, 255, 0, 255), 1.0)
			dxDrawLine3D(v.x, v.y - 0.5, v.z, v.x, v.y, v.z - 1, color, 1.0)
			dxDrawLine3D(v.x, v.y - 0.5, v.z, v.x, v.y, v.z + 1, color, 1.0)
			dxDrawLine3D(v.x, v.y + 0.5, v.z, v.x, v.y, v.z - 1, color, 1.0)
			dxDrawLine3D(v.x, v.y + 0.5, v.z, v.x, v.y, v.z + 1, color, 1.0)
			dxDrawLine3D(v.x - 0.5, v.y, v.z, v.x, v.y, v.z - 1, color, 1.0)
			dxDrawLine3D(v.x - 0.5, v.y, v.z, v.x, v.y, v.z + 1, color, 1.0)
			dxDrawLine3D(v.x + 0.5, v.y, v.z, v.x, v.y, v.z - 1, color, 1.0)
			dxDrawLine3D(v.x + 0.5, v.y, v.z, v.x, v.y, v.z + 1, color, 1.0)
			dxDrawLine3D(v.x, v.y, v.z - 1, v.x, v.y, v.z + 1, tocolor(0, 0, 255, 255), 1.0)
			
			if k == #createData.checkpoints and #createData.checkpoints == 1 then
				--local playerPos = localPlayer:getPosition()
				dxDrawLine3D(v, localPlayer:getPosition())
			elseif k == #createData.checkpoints then
				dxDrawLine3D(v, createData.checkpoints[1])
				local index = k - 1
				if index > 0 then
					dxDrawLine3D(createData.checkpoints[index], v)
				end
			else
				local index = k - 1
				if index > 0 then
					dxDrawLine3D(createData.checkpoints[index], v)
				end
			end
		end
	end
end

function createFunc.cmd()
	if createData.state then
		removeEventHandler("onClientRender", root, createFunc.renderSphere)
		removeEventHandler("onClientKey", root, createFunc.keyEvent)
		createFunc.resetData()
	else
		createData.state = true
		addEventHandler("onClientKey", root, createFunc.keyEvent)
		addEventHandler("onClientRender", root, createFunc.renderSphere)

	end
end
addCommandHandler("cpshere", createFunc.cmd, false, false)

function createFunc.keyEvent(button, press)
	if createData.state and press then
		if button == "enter" then
			cancelEvent()
			if not getElementData(localPlayer, "playerSphere:ID") then
				exports.titan_noti:showBox("Checkpoint strefy został dodany.")
				table.insert(createData.checkpoints, localPlayer:getPosition())
			else
				exports.titan_noti:showBox("Nie możesz postawić pickupa strefy na innej strefie.")
			end
		end

		if button == "backspace" then
			local tempTable = {}
			for k, v in ipairs(createData.checkpoints) do
				table.insert(tempTable, v.x)
				table.insert(tempTable, v.y)
			end
			--outputConsole(toJSON(tempTable))
			triggerServerEvent("spheresFunc.addNewSphere", localPlayer, "Sfera stworzona przez gracza", tempTable)
			--createColPolygon(createData.checkpoints[1].x, createData.checkpoints[1].y, unpack(tempTable))
			removeEventHandler("onClientRender", root, createFunc.renderSphere)
			removeEventHandler("onClientKey", root, createFunc.keyEvent)
			createFunc.resetData()
		end
	end
end