function cmdAo(player, command, ...)
	if not doesAdminHavePerm(player, "objects") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local legend = "owner"
	local arg = {...}
	local arg1 = arg[1]
	arg1 = string.lower(tostring(arg1))
	if(arg1 == "owner") then
		local objID = arg[2]
		local ownerType = arg[3]
		local owner = arg[4]
		if not tonumber(objID) or not tonumber(ownerType) or not tonumber(owner) then return exports.titan_noti:showBox(player, "TIP: /ao owner [ID obiektu] [ownerType] [owner]") end
		objID = tonumber(objID)
		ownerType = tonumber(ownerType)
		owner = tonumber(owner)

		if ownerType ~= 1 and ownerType ~= 2 then return exports.titan_noti:showBox(player, "Podano nieprawidłową wartość argumentu ownerType.") end
		local objectInfo = exports.titan_objects:getObjectInfo(objID)
		if not objectInfo then return exports.titan_noti:showBox(player, "Taki obiekt nie istnieje.") end
		if isElement(objectInfo.object) and objectInfo.object:getDimension() ~= 0 then return exports.titan_noti:showBox(player, "Obiekt nie znajduje się na virtualworldzie 0. Zmiana właściciela nie jest potrzebna.") end
		exports.titan_objects:changeObjectOwner(objID, ownerType, owner)
		exports.titan_noti:showBox(player, "Pomyślnie zmieniono właściciela obiektu.")
	else
		exports.titan_noti:showBox(player, "TIP: /ao ["..legend.."]")
		return
	end
end
addCommandHandler("ao", cmdAo, false, false)