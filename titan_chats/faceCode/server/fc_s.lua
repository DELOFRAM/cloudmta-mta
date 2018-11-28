-- faceCodes created by Kubas
local faceCodes = {}

local function onResStart()
	for k, v in ipairs(getElementsByType("player")) do
		if(exports.titan_login:isLogged(v)) then
			loadPlayerFaceCode(v)
		end
	end
end
--addEventHandler("onResourceStart", resourceRoot, onResStart)

function loadPlayerFaceCode(player)
	faceCodes[player] = {}
	local query = exports.titan_db:query("SELECT faceCode, name FROM _facecodes WHERE charID = ?", getElementData(player, "charID")))
	if(#query > 0) then
		for k, v in ipairs(query) do
			faceCodes[player][string.upper(tostring(v.faceCode))] = v.name
		end
		exports.titan_hud:giveClientFaceCodes(player, faceCodes[player])
	end
	faceCodes[player][tostring(getElementData(player, "faceCode"))] = string.format("%s %s", getElementData(player, "name"), getElementData(player, "lastname"))
	outputDebugString(string.format("[TE - FACECODE] Załadowano %d zapisanych faceCode gracza %s %s.", #query, getElementData(player, "name"), getElementData(player, "lastname")))
end

function getPlayerSavedNameFromFaceCode(player, faceCode)
	if(type(faceCodes[player]) == "table") then
		if(faceCodes[player][faceCode]) then
			return faceCodes[player][faceCode]
		end
		return faceCode
	else
		return faceCode
	end
end

local function onQuit()
	if(isElement(source) and exports.titan_login:isLogged(source)) then
		if(type(faceCodes[source]) == "table") then
			faceCodes[source] = nil
		end
	end
end
--addEventHandler("onPlayerQuit", root, onQuit)

function cmdAddNick(player, command, val1, ...)
	if(not exports.titan_login:isLogged(player)) then return end
	local val2 = table.concat({...}, " ")
	if(not val1 or string.len(val2) < 3) then
		exports.titan_noti:showBox(player, "TIP: /addnick [UID twarzy] [Nadany nickname]")
		return
	end

	if(string.len(val1) ~= 6) then
		exports.titan_noti:showBox(player, "UID twarzy musi mieć 6 znaków!")
		return
	end

	if(string.len(val2) > 30) then
		exports.titan_noti:showBox(player, "Maksymalna długość nickname'u wynosi 30 znaków!")
		return
	end

	val1 = string.upper(val1)

	if(type(faceCodes[player]) ~= "table") then faceCodes[player] = {} end

	local res, nr = exports.titan_db:query("SELECT faceCode FROM _characters WHERE faceCode = ?", string.upper(val1))
	if(nr == 0) then
		faceCodes[player][val1] = nil
		exports.titan_noti:showBox(player, "Nie istnieje taki identyfikator twarzy!")
		return
	end

	faceCodes[player][val1] = val2
	local rows, numrows = exports.titan_db:query("SELECT faceCode FROM _facecodes WHERE charID = ? AND faceCode = ?", getElementData(player, "charID"), string.upper(val1))
	if(numrows > 0) then
		exports.titan_db:query_free("UPDATE _facecodes SET name = ? WHERE charID = ? AND faceCode = ?", val2, getElementData(player, "charID"), string.upper(val1))
	else
		exports.titan_db:query_free("INSERT INTO _facecodes SET name = ?, faceCode = ?, charID = ?", val2, string.upper(val1), getElementData(player, "charID"))
	end
	exports.titan_hud:giveClientFaceCodes(player, faceCodes[player])
	exports.titan_noti:showBox(player, string.format("Pomyślnie dodano nick do zapisanych."))
end
--addCommandHandler("addnick", cmdAddNick)