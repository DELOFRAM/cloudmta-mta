----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local courierMarker
local marker = {-541, -546, 24.5}
local function onStartResource()
	exports.titan_db:query_free("UPDATE _delivers SET deliverID = '0'")
	courierMarker = createMarker(marker[1], marker[2], marker[3], "cylinder", 2.0, 255, 0, 0, 100, root)
end
--addEventHandler("onResourceStart", resourceRoot, onStartResource)

--[[function cmdPaczka(player, command, arg1)
	if(string.lower(tostring(arg1)) == "anuluj") then
		local deliverID = getElementData(player, "courierPackID")
		if(not tonumber(deliverID)) then
			exports.titan_noti:showBox(player, "Nie świadczysz usług logistycznych w tym momencie.")
			return
		end
		exports.titan_db:query_free("UPDATE _delivers SET deliverID = '0' WHERE ID = ?", deliverID)
		setElementData(player, "courierPackID", false)
		exports.titan_noti:showBox(player, "Pomyślnie anulowano dowóz paczki.")

		local tmpTable = getElementData(player, "courierTable")
		if(type(tmpTable) == "table") then
			for k, v in ipairs(tmpTable[1]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
			for k, v in ipairs(tmpTable[2]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
		end
		setElementData(player, "courierTable", false)
		return
	end

	if(isElementWithinMarker(player, courierMarker)) then
		local courierID = getElementData(player, "courierPackID")
		if(tonumber(courierID)) then
			exports.titan_noti:showBox(player, "Aktualnie przewozisz już paczkę. Aby anulować, wpisz /paczka anuluj.")
			return
		end
		local data = getAvailableDelivers()
		if(not data) then
			exports.titan_noti:showBox(player, "Aktualnie nie ma dostępnych żadnych przesyłek.")
			return
		end
		triggerClientEvent(player, "createDeliverGUI", player, data)
	else
		local saveBlip = getElementData(player, "courierBlip")
		if(isElement(saveBlip)) then
			exports.titan_noti:showBox(player, "Namierzanie zostało usunięte.")
			destroyElement(saveBlip)
			setElementData(player, "courierBlip", false)
			return
		else
			exports.titan_noti:showBox(player, "Na mapie oznaczono miejsce załadunku.")
			local blip = createBlip(marker[1], marker[2], marker[3], 0, 2, 255, 0, 0, 255, 0, 99999.0, player)
			setElementData(player, "courierBlip", blip)
			return
		end
	end
end
addCommandHandler("paczka", cmdPaczka, false, false)]]


------------
-- EVENTY --
------------

local function onHitMarker(hitElement, dim)
	if(source ~= courierMarker) then
		local forPlayer = getElementData(source, "forPlayer")
		if(isElement(forPlayer)) then
			if(hitElement == forPlayer) then
				local tmpTable = getElementData(hitElement, "courierTable")
				if(type(tmpTable) == "table") then
					for k, v in ipairs(tmpTable[1]) do
						if(isElement(v)) then
							destroyElement(v)
						end
					end
					for k, v in ipairs(tmpTable[2]) do
						if(isElement(v)) then
							destroyElement(v)
						end
					end
				end
				setElementData(hitElement, "courierTable", false)
				local deliverID = getElementData(hitElement, "courierPackID")
				local query = exports.titan_db:query("SELECT * FROM _delivers WHERE ID = ? LIMIT 1", deliverID)
				if(#query > 0) then
					query = query[1]
					query.data = fromJSON(tostring(query.data))
					exports.titan_db:query_free("INSERT INTO _deposite SET intID = ?, name = ?, stock = ?, itemType = ?, itemVal1 = ?, itemVal2 = ?, itemVal3 = ?, itemVolume = ?", query.intID, query.data.itemName, query.pieces, query.data.itemType, query.data.itemVal1, query.data.itemVal2, query.data.itemVal3, query.data.itemVolume)
					exports.titan_db:query_free("DELETE FROM _delivers WHERE ID = ?", query.ID)
				end
				setElementData(hitElement, "courierPackID", false)

				exports.titan_noti:showBox(hitElement, "Paczka została dostarczona.")
				return
			end
		end
	else
		if(dim) then
			if(getElementType(hitElement) == "player" and exports.titan_login:isLogged(hitElement)) then
				local saveBlip = getElementData(hitElement, "courierBlip")
				if(isElement(saveBlip)) then
					exports.titan_noti:showBox(hitElement, "Namierzanie zostało usunięte.")
					destroyElement(saveBlip)
					setElementData(hitElement, "courierBlip", false)
				end
			end
		end
	end
end
--addEventHandler("onMarkerHit", resourceRoot, onHitMarker)

function onClientChooseDeliver(player, deliverID)
	if(not tonumber(deliverID)) then return end
	local query = exports.titan_db:query("SELECT * FROM _delivers WHERE ID = ? LIMIT 1", deliverID)
	if(#query <= 0) then
		exports.titan_noti:showBox(player, "Nie znaleziono podanej przesyłki.")
		return
	end
	query = query[1]
	if(query.deliverID ~= 0) then
		exports.titan_noti:showBox(player, "Inny kurier zabrał już tę paczkę.")
		return
	end

	local doors = exports.titan_doors:getEntryPickups(query.intID)
	if(not doors) then
		exports.titan_noti:showBox(player, "Grupa nie posiada żadnych drzwi, które posiadałyby wyjście na virtualworldzie 0. Zgłoś to jak najszybciej.")
		return
	end	

	setElementData(player, "courierPackID", query.ID)
	exports.titan_db:query_free("UPDATE _delivers SET deliverID = ? WHERE ID = ?", getElementData(player, "charID"), query.ID)
	exports.titan_noti:showBox(player, "Pomyślnie wzięto paczkę. Na mapie zaznaczono miejsca, gdzie można je zostawić.")

	local tmpTable = {[1] = {}, [2] = {}}
	for k, v in ipairs(doors) do
		local marker = createMarker(v.outX, v.outY, v.outZ - 1, "cylinder", 2.0, 255, 0, 0, 100, player)
		if(isElement(marker)) then
			setElementData(marker, "isCourierMarker", true)
			setElementData(marker, "forPlayer", player)
			table.insert(tmpTable[1], marker)
		end

		local blip = createBlip(v.outX, v.outY, v.outZ - 1, 0, 2, 255, 0, 0, 255, 0, 99999.0, player)
		if(isElement(blip)) then
			table.insert(tmpTable[2], blip)
		end
	end
	setElementData(player, "courierTable", tmpTable)
	return
end
addEvent("onClientChooseDeliver", true)
addEventHandler("onClientChooseDeliver", root, onClientChooseDeliver)