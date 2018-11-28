----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function createLoadObjects(player, doorID)
	triggerClientEvent(player, "convertFunc.create", resourceRoot, doorID)
end

function loadObjects(player, doorID, data)
	local info = exports.titan_doors:getPickupInfo(doorID)
	if(not info) then
		exports.titan_noti:showBox(player, "Nie znaleziono takich drzwi.")
		return
	end

	local intInfo = exports.titan_doors:getDoorInfo(info.parentID)
	if(not intInfo) then
		exports.titan_noti:showBox(player, "Interior do którego drzwi są przypisane nie istnieje.")
		return
	end

	for k, v in pairs(objectData) do
		if v and v.dimension == intInfo.dimension then
			objectEngine.delObject(v.ID)
		end
	end

	--intInfo.dimension
	for k, v in pairs(data) do
		if v.typ == "pickup" and v.checked then
			exports.titan_doors:doorPickupLeaveCreate(doorID, v.x, v.y, v.z, 0, v.int, intInfo.dimension, 1318)
		end
		if v.typ == "model" then
			objCreate(v.model, intInfo.ownerType, intInfo.owner, v.x, v.y, v.z, v.rx, v.ry, v.rz, v.int, intInfo.dimension)
		end
	end
	triggerClientEvent(player, "sConvertFunc.destroy", resourceRoot)
	exports.titan_noti:showBox(player, "Pomyślnie załadowano obiekty.")
end
addEvent("loadObjects", true)
addEventHandler("loadObjects", root, loadObjects)