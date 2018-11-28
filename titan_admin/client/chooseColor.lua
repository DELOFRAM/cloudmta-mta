----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function assignColor(id, hex, r, g, b)
	if id.name == "vehColor" then
		if id.vehID > 0 and id.colorInfo > 0 then return triggerServerEvent("changeVehicleColor", localPlayer, id.vehID, id.colorInfo, r, g, b) end
	elseif id.name == "groupColor" then
		if id.groupID > 0 then return triggerServerEvent("changeGroupColor", localPlayer, id.groupID, r, g, b) end
	end
end

function playerChooseVehColor(colorInfo, veh)
	exports.titan_colorpicker:openPicker({name = "vehColor", vehID = veh, colorInfo = colorInfo}, string.format("#%02X%02X%02X", 255, 255, 255), "Wybór koloru pojazdu")
end
addEvent("playerChooseVehColor", true)
addEventHandler("playerChooseVehColor", root, playerChooseVehColor)

function playerChooseGroupColor(groupID)
	exports.titan_colorpicker:openPicker({name = "groupColor", groupID = groupID}, string.format("#%02X%02X%02X", 255, 255, 255), "Wybór koloru grupy")
end
addEvent("playerChooseGroupColor", true)
addEventHandler("playerChooseGroupColor", root, playerChooseGroupColor)