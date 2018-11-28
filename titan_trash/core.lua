DustbinsFunc = {}
DustbinsData = {}
AccessDeniedDustbinsItemType = {
[1] = true,
[2] = true,
[4] = true,
[5] = true,
[8] = true,
[10] = true,
[17] = true,
[18] = true,
[29] = true,
}

function DustbinsFunc.load()
	DustbinsData = {}
	local time = getTickCount()
	local loaded = 0
	local query = exports.titan_db:query("SELECT * FROM _dustbins")
	for k, v in ipairs(query) do
		local objectInfo = exports.titan_objects:getObjectInfo(v.objectID)
		if objectInfo then
			if isElement(objectInfo.object) then
				objectInfo.object:setData("isTrash", true)
				objectInfo.object:setData("trashID", v.ID)
				objectInfo.object:setData("trashVolume",{v.volume, v.Maxvolume})
			end
			v.object = objectInfo.object
			table.insert(DustbinsData, v)
			loaded = loaded + 1
		end
	end
	outputDebugString(string.format("[Dustbins] Załadowano śmietników (%d). | %d ms", loaded, getTickCount() - time))
end
Dustbinsload = DustbinsFunc.load
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()), Dustbinsload )



function DustbinsFunc.create(player, name, objectID, volume)
	local time = getTickCount()
	local objectInfo = exports.titan_objects:getObjectInfo(objectID)
	if not objectInfo then return exports.titan_noti:showBox(player, "Nie znaleziono obiektu o podanym ID.") end
	if not tonumber(volume) or volume <= 0 then return  exports.titan_noti:showBox(player, "Wartośc maskymalengo zapełnienia śmietnika musi być liczbą i powyżej 0.") end
	local res, rows, lastID = exports.titan_db:query("INSERT INTO _dustbins SET name = ?, objectID = ?, Maxvolume = ?", tostring(name), tonumber(objectID), tonumber(volume) )
	if tonumber(lastID) then
		local tmpTable = 
		{
			ID = tonumber(lastID),
			name = tostring(name),
			objectID = tonumber(objectID),
			object = objectInfo.object
		}
		objectInfo.object:setData("trashVolume",{0, volume})
		table.insert(DustbinsData, tmpTable)
		outputDebugString(string.format("[Dustbins] Dodano nowy śmietnik. | %d ms", getTickCount() - time))
		return lastID
	end
end
DustbinsCreate = DustbinsFunc.create

function DustbinsFunc.getInfo(trashID)
	for k, v in ipairs(DustbinsData) do
		if v.ID == trashID then 
			return k, v 
		end
	end
	return false
end

function DustbinsFunc.remove(trashID)
	local time = getTickCount()
	local trashKey, trashInfo = DustbinsFunc.getInfo(trashID)
	if not trashKey then return false end
	table.remove(DustbinsData, trashKey)
	local objectInfo = exports.titan_objects:getObjectInfo(trashInfo.objectID)
	if objectInfo then
		objectInfo.object:removeData("isTrash")
		objectInfo.object:removeData("trashID")
	end
	exports.titan_db:query_free("DELETE FROM _dustbins WHERE ID = ?", trashID)
	outputDebugString(string.format("[Dustbins] Usunięto przystanek. | %d ms", getTickCount() - time))
end
DustbinsRemove = DustbinsFunc.remove

function DustbinsFunc.getPlayerItem(player, UID)
	local item = exports.titan_items:getPlayerItems(player)
	if item == false then return false end
	for k, v in ipairs(item) do
		if v.ID == tonumber(UID) then
			if AccessDeniedDustbinsItemType[tonumber(v.type)] then return "stop", nil end
			return true, v.name
		end
	end
	return false
end

function DustbinsFunc.throw(player, CommandName, UID)
	for i,v in ipairs(DustbinsData) do
		if isElement(v.object) and getDistanceBetweenPoints3D( Vector3( player:getPosition() ), Vector3( v.object:getPosition() ) ) < 2 then
				if not tonumber(UID) then
					return exports.titan_noti:showBox(player,"[TIP] /"..CommandName.." [UID przedmiotu]")
				end
				local toggle, name = DustbinsFunc.getPlayerItem(player, UID) 
				if not toggle then
					return exports.titan_noti:showBox(player,"Nie posiadasz przedmiotu o podanym UID.")
				elseif toggle == "stop" then
					return  exports.titan_noti:showBox(player,"Tego przedmiotu nie możesz wyrzućić do śmietnika.")
				end


				local trashVolume = v.object:getData("trashVolume")
				if tonumber(trashVolume[1]) >= tonumber(trashVolume[2]) then
					return exports.titan_noti:showBox(player,"Śmietnik jest zapełniony")
				end
				trashVolume[1] = trashVolume[1]+1
				exports.titan_chats:sendPlayerLocalMeRadius(player,"wyrzuca do kosza "..string.lower(name)..".", 10.0)
				exports.titan_items:removeItem(tonumber(UID), false)
				triggerEvent( "updatePlayerEquip", player, player )
				v.object:setData("trashVolume",trashVolume)
				exports.titan_db:query_free("UPDATE _dustbins SET volume=volume+1 WHERE ID = ?", v.object:getData("trashID") )
				exports.titan_db:query_free("UPDATE _items SET ownerType = '5', destroyed = 0, owner = '?' WHERE ID = ?", v.object:getData("trashID"), tonumber(UID) )
			return	true
		end
	end
	return  exports.titan_noti:showBox(player,"Nie jesteś w pobliżu żadnego śmietnika!")
end


DustbinsThrow = DustbinsFunc.throw
addCommandHandler( "wyrzuc", DustbinsThrow )