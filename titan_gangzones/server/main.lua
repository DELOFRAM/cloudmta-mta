----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local gangZonesFunc = {}
local gangZonesData = {}
local gangZonesIndex = {}

function gangZonesFunc.load()
	local time = getTickCount()
	local query = exports.titan_db:query("SELECT * FROM `_gangzones`")
	local index = 1
	for k, v in ipairs(query) do
		v.radararea = createRadarArea(v.x, v.y, v.w, v.h)
		if isElement(v.radararea) then
			setRadarAreaColor(v.radararea, math.random(10, 255), math.random(10, 255), math.random(10, 255), 150)
			v.radararea:setData("data", v)
				
			v.radararea:setData("sectorID", v.ID)
			v.radararea:setData("sectorName", v.name)
			v.radararea:setData("sectorPos", {v.x, v.y, v.w, v.h})
			v.radararea:setData("sectorScores", fromJSON(v.scores))
			v.radararea:setData("sectorOwner", v.owner)

			setElementVisibleTo(v.radararea, root, false)
		end
		gangZonesData[index] = v
		gangZonesIndex[v.ID] = index
		index = index + 1
	end
	outputDebugString(string.format("[GANGZONES] Załadowano strefy gangów (%d). | %d ms", #query, getTickCount() - time))
end
addEventHandler("onResourceStart", resourceRoot, gangZonesFunc.load)

function gangZonesFunc.deleteGangzone(gangzoneID)
	local index = gangZonesIndex[gangzoneID]
	if not tonumber(index) then return end
	if type(gangZonesData[index]) ~= "table" then return end
	exports.titan_db:query_free("DELETE FROM `_gangzones` WHERE `ID` = ?", gangzoneID)
	if isElement(gangZonesData[index].radararea) then destroyElement(gangZonesData[index].radararea) end
	gangZonesData[index] = nil
	gangZonesIndex[gangzoneID] = nil
	triggerClientEvent(source, "createFunc.refreshList", source, false)
end
addEvent("gangZonesFunc.deleteGangzone", true)
addEventHandler("gangZonesFunc.deleteGangzone", root, gangZonesFunc.deleteGangzone)

function gangZonesFunc.getIndex()
	local i = 1
	while true do
		if type(gangZonesData[i]) ~= "table" then return i end
		i = i + 1
	end
end

function gangZonesFunc.create(x, y, w, h, name)
	local index = gangZonesFunc.getIndex()
	local res, row, lastID = exports.titan_db:query("INSERT INTO _gangzones SET x = ?, y = ?, w = ?, h = ?, name = ?, owner = '0', scores = ?", x, y, w, h, name, '[{ "neutral": 151 }]')
	if tonumber(lastID) then
		gangZonesIndex[lastID] = index
		gangZonesData[index] = 
		{
			ID = lastID,
			x = x,
			y = y,
			w = w,
			h = h,
			name = name,
			scores = {["neutral"] = 151},
			owner = 0,
			radararea = createRadarArea(x, y, w, h)
		}
		if isElement(gangZonesData[index].radararea) then
			setRadarAreaColor(gangZonesData[index].radararea, math.random(10, 255), math.random(10, 255), math.random(10, 255), 150)
			gangZonesData[index].radararea:setData("data", gangZonesData[index])
			
			gangZonesData[index].radararea:setData("sectorID", lastID)
			gangZonesData[index].radararea:setData("sectorName", name)
			gangZonesData[index].radararea:setData("sectorPos", {x, y, w, h})
			gangZonesData[index].radararea:setData("sectorScores", {["neutral"] = 151})
			gangZonesData[index].radararea:setData("sectorOwner", 0)
		end
		if isElement(source) then
			triggerClientEvent(source, "createFunc.refreshList", source, true)
		end
	end
end
addEvent("gangZonesFunc.create", true)
addEventHandler("gangZonesFunc.create", root, gangZonesFunc.create)