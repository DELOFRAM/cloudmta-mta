----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local window
local wyniki = {}
function createGUI()
	window = guiCreateWindow(0.4, 0.25, 0.2, 0.45, "Wyniki wyszukiwania", true)
	grid = guiCreateGridList(0, 0.05, 1, 0.85, true, window)
	col1 = guiGridListAddColumn(grid, "ID", 0.1)
	col2 = guiGridListAddColumn(grid, "Nazwa", 0.8)
	button = guiCreateButton(0, 0.91, 1, 0.14, "Zamknij", true, window)
	
	for i,v in ipairs(wyniki) do
		local row = guiGridListAddRow(grid)
		guiGridListSetItemText(grid, row, col1, v[1], false, false)
		guiGridListSetItemText(grid, row, col2, v[2], false, false)
	end
	
	addEventHandler("onClientGUIClick", button, destroyGUI)
	
	guiWindowSetSizable(window, false)
	showCursor(true)
end

function destroyGUI()
	removeEventHandler("onClientGUIClick", button, destroyGUI)
	destroyElement(window)
	showCursor(false)
end


addCommandHandler("id", function (cmd, ...)
	wyniki = {} -- czyścimy tabelke :D
	local search = table.concat({...}, " "):lower()
	if search:len() < 1 then
		exports.titan_noti:showBox("TIP: /"..cmd.." [Nazwa gracza]")
		return
	end
	for i,v in ipairs(getElementsByType("player")) do
		if tonumber(v:getData("loggedIn")) and v:getData("loggedIn") == 1 then
			local name = getElementData(v, "name").." "..getElementData(v, "lastname")
			if string.find(name:lower(), search) then
				local id = getElementData(v, "playerID") or 0
				table.insert(wyniki, {id, name})
			end
		end
	end
	if #wyniki < 1 then
		exports.titan_noti:showBox("Nie odnaleziono żadnego gracza")
	else
		createGUI()
	end
end)
