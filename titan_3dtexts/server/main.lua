----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function loadTextsFromDB()
	local query = exports.titan_db:query("SELECT * FROM _3dtexts")
	for k, v in ipairs(query) do
		local element = createElement("3dtext", "3dtext"..v.ID)
		setElementPosition(element, v.x, v.y, v.z)
		element:setInterior(v.int)
		element:setDimension(v.vw)
		element:setData("ID", v.ID)
		element:setData("text", v.text)
		element:setData("r", v.r)
		element:setData("g", v.g)
		element:setData("b", v.b)
	end
end
addEventHandler("onResourceStart", resourceRoot, loadTextsFromDB)

function addNewText(x, y, z, vw, int, r, g, b, text)
	--local query, rows, lastID = exports.titan_db:query("INSERT INTO _3dtexts SET x = ?, y = ?, z = ?, vw = ?, int = ?, r = ?, g = ?, b = ?, text = ?", x, y, z, vw, int, r, g, b, text)
	local query, rows, lastID = exports.titan_db:query("INSERT INTO `_3dtexts` (`x`, `y`, `z`, `vw`, `int`, `text`, `r`, `g`, `b`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)", x, y, z, vw, int, text, r, g, b)
	local element = createElement("3dtext", "3dtext"..lastID)
	setElementPosition(element, x, y, z)
	element:setInterior(int)
	element:setDimension(vw)
	element:setData("r", r)
	element:setData("g", g)
	element:setData("b", b)
	element:setData("ID", lastID)
	element:setData("text", text)
end

function deleteText(textID)
	local element = getElementByID("3dtext"..textID)
	if not element then return false end
	exports.titan_db:query("DELETE FROM _3dtexts WHERE ID = ?", textID)
	destroyElement(element)
	return true	
end