----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local cursorData = {}

function showCustomCursor(cursorString)
	local key = getCursorStringKey(cursorString)
	if not key then
		table.insert(cursorData, cursorString)
	end
	if not isCursorShowing() then
		showCursor(true)
	end
end
addEvent("showCustomCursor", true)
addEventHandler("showCustomCursor", root, showCustomCursor)

function hideCustomCursor(cursorString)
	local key = getCursorStringKey(cursorString)
	if key then
		table.remove(cursorData, key)
	end
	if #cursorData <= 0 then
		if isCursorShowing() then
			showCursor(false)
		end
	end
end
addEvent("hideCustomCursor", true)
addEventHandler("hideCustomCursor", root, hideCustomCursor)

function getCursorStringKey(cursorString)
	for k, v in ipairs(cursorData) do
		if v == cursorString then return k end
	end
	return false
end