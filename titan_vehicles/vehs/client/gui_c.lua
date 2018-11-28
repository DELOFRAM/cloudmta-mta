----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local renderData = {}

function getVehicleFromID(id)
	if not id then return end
	for _, veh in pairs(getElementsByType("vehicle")) do
		if getElementData(veh, "vehID") == id then return veh end
	end
	return false
end

function loadRenderData(data)
	renderData = {bg = {}, arrowu = {}, arrowd = {}, veh1 = {}, bg1 = {}, firstLabel = {}, labely = {[1] = {}}}
	renderData.bg.x = sW / 2 - 206
	renderData.bg.y = sH / 2 - 130
	renderData.bg.w = 412
	renderData.bg.h = 261

	renderData.arrowu.x = renderData.bg.x + renderData.bg.w - 32
	renderData.arrowu.y = renderData.bg.y + renderData.bg.h / 2 - 25
	renderData.arrowu.w = 32
	renderData.arrowu.h = 32

	renderData.arrowd.x = renderData.bg.x + renderData.bg.w - 32
	renderData.arrowd.y = renderData.bg.y + renderData.bg.h / 2 + 10
	renderData.arrowd.w = 32
	renderData.arrowd.h = 32

	renderData.veh1.x = renderData.bg.x + 10
	renderData.veh1.y = renderData.bg.y + 22
	renderData.veh1.w = 117
	renderData.veh1.h = 71

	renderData.bg1.x = renderData.veh1.x + renderData.veh1.w - 19
	renderData.bg1.y = renderData.veh1.y - 16
	renderData.bg1.w = 282
	renderData.bg1.h = 103

	renderData.page = 1

	renderData.font = dxCreateFont("vehs/client/files/font.otf", 13, false)
	if(not renderData.font) then renderData.font = "default-bold" end

	renderData.firstLabel.x = renderData.bg1.x + 205
	renderData.selectedElement = 0
	renderData.vehicles = nil
	renderData.vehicles = data

	for i = 1, 3 do
		renderData.labely[i] = {}
		local varY = ((i - 1) * (renderData.veh1.h + 9))
		local y = renderData.bg1.y + varY + 17
		renderData.labely[i].info = guiCreateLabel(renderData.firstLabel.x, y, 57, 13, "", false) setElementData(renderData.labely[i].info, "typ", "info"..i)
		renderData.labely[i].spawn = guiCreateLabel(renderData.firstLabel.x, y + 13, 57, 13, "", false) setElementData(renderData.labely[i].spawn, "typ", "spawn"..i)
		renderData.labely[i].namierz = guiCreateLabel(renderData.firstLabel.x, y + 26, 57, 13, "", false) setElementData(renderData.labely[i].namierz, "typ", "namierz"..i)
		renderData.labely[i].przypisz = guiCreateLabel(renderData.firstLabel.x, y + 39, 57, 13, "", false) setElementData(renderData.labely[i].przypisz, "typ", "przypisz"..i)
		renderData.labely[i].tuning = guiCreateLabel(renderData.firstLabel.x, y + 52, 57, 13, "", false) setElementData(renderData.labely[i].tuning, "typ", "tuning"..i)
	end
	addEventHandler("onClientMouseLeave", resourceRoot, 
	function()
		renderData.selectedElement = 0
	end)
	addEventHandler("onClientMouseEnter", resourceRoot, 
	function()
		local data = getElementData(source, "typ")
		for i = 1, 3 do
			if (data == string.format("info%d", i)) then renderData.selectedElement = 1 + ((i - 1) * 5) return
			elseif (data == string.format("spawn%d", i)) then renderData.selectedElement = 2 + ((i - 1) * 5) return
			elseif (data == string.format("namierz%d", i)) then renderData.selectedElement = 3 + ((i - 1) * 5) return
			elseif (data == string.format("przypisz%d", i)) then renderData.selectedElement = 4 + ((i - 1) * 5) return
			elseif (data == string.format("tuning%d", i)) then renderData.selectedElement = 5 + ((i - 1) * 5) return
			end
		end
	end)
end

function renderVehiclesGUI()
	dxDrawImage(renderData.bg.x, renderData.bg.y, renderData.bg.w, renderData.bg.h, "vehs/client/files/bg.png")

	for k, v in ipairs(renderData.vehicles) do
		local renderIndex = k - ((renderData.page - 1) * 3)
		if(renderIndex > 0 and renderIndex <= 3) then
			local varY = ((renderIndex - 1) * (renderData.veh1.h + 9))
			dxDrawImage(renderData.veh1.x, renderData.veh1.y + varY, renderData.veh1.w, renderData.veh1.h, "vehs/client/files/vehs/"..v.model..".jpg")
			dxDrawImage(renderData.bg1.x, renderData.bg1.y + varY, renderData.bg1.w, renderData.bg1.h, "vehs/client/files/vehbg.png")
			v.name = string.upper(tostring(v.name))
			dxDrawText(v.name, renderData.bg1.x + 25, renderData.bg1.y + varY + 17, 0, 0, tocolor(157, 195, 82, 255), 0.9, renderData.font)
			dxDrawText("UID: "..v.ID, renderData.bg1.x + 25, renderData.bg1.y + varY + 17 + 15, 0, 0, tocolor(157, 195, 82, 255), 0.5, renderData.font)
			dxDrawText(string.format("Stan: %0.1f%%\nPaliwo: %dl\nPrzebieg: %0.1fkm", v.hp / 10, v.fuel, v.distance), renderData.bg1.x + 35, renderData.bg1.y + varY + 42, 0, 0, tocolor(255, 255, 255, 150), 0.65, renderData.font)
			local r, g, b, scale
			if(renderData.selectedElement == 1 + ((renderIndex - 1) * 5)) then r, g, b = 157, 195, 82 scale = 0.8 else r, g, b = 255, 255, 255 scale = 0.75 end
			dxDrawText("INFO", renderData.bg1.x + 200, renderData.bg1.y + varY + 17, renderData.bg1.x + renderData.bg1.w - 20, 0, tocolor(r, g, b, 200), scale , renderData.font, "right")
			if(renderData.selectedElement == 2 + ((renderIndex - 1) * 5)) then r, g, b = 157, 195, 82 scale = 0.8 else r, g, b = 255, 255, 255 scale = 0.75 end
			dxDrawText(getVehicleFromID(v.ID) and "UNSPAWN" or "SPAWN", renderData.bg1.x + 200, renderData.bg1.y + varY + 17 + 13, renderData.bg1.x + renderData.bg1.w - 20, 0, tocolor(r, g, b, 200), scale , renderData.font, "right")
			if(renderData.selectedElement == 3 + ((renderIndex - 1) * 5)) then r, g, b = 157, 195, 82 scale = 0.8 else r, g, b = 255, 255, 255 scale = 0.75 end
			local locate = getElementData(localPlayer, "locateVeh")
			dxDrawText((type(locate) == "table" and locate[1] == v.ID) and "WYŁĄCZ NAMIERZANIE" or "NAMIERZ", renderData.bg1.x + 200, renderData.bg1.y + varY + 17 + 26, renderData.bg1.x + renderData.bg1.w - 20, 0, tocolor(r, g, b, 200), scale , renderData.font, "right")
			if(renderData.selectedElement == 4 + ((renderIndex - 1) * 5)) then r, g, b = 157, 195, 82 scale = 0.8 else r, g, b = 255, 255, 255 scale = 0.75 end
			dxDrawText("PRZYPISZ", renderData.bg1.x + 200, renderData.bg1.y + varY + 17 + 39, renderData.bg1.x + renderData.bg1.w - 20, 0, tocolor(r, g, b, 200), scale , renderData.font, "right")
			if(renderData.selectedElement == 5 + ((renderIndex - 1) * 5)) then r, g, b = 157, 195, 82 scale = 0.8 else r, g, b = 255, 255, 255 scale = 0.75 end
			dxDrawText("TUNING", renderData.bg1.x + 200, renderData.bg1.y + varY + 17 + 52, renderData.bg1.x + renderData.bg1.w - 20, 0, tocolor(r, g, b, 200), scale , renderData.font, "right")
		end
	end
	if(renderData.page - 1 > 0) then
		dxDrawImage(renderData.arrowu.x, renderData.arrowu.y, renderData.arrowu.w, renderData.arrowu.h, "vehs/client/files/arrow_u.png", 0, 0, 0, tocolor(255, 255, 255, isCursorGet(renderData.arrowu.x, renderData.arrowu.y, renderData.arrowu.x + renderData.arrowu.w, renderData.arrowu.y + renderData.arrowu.h) and 255 or 100))
	end
	if(#renderData.vehicles >= 1 + (renderData.page * 3)) then
		dxDrawImage(renderData.arrowd.x, renderData.arrowd.y, renderData.arrowd.w, renderData.arrowd.h, "vehs/client/files/arrow_d.png", 0, 0, 0, tocolor(255, 255, 255, isCursorGet(renderData.arrowd.x, renderData.arrowd.y, renderData.arrowd.x + renderData.arrowd.w, renderData.arrowd.y + renderData.arrowd.h) and 255 or 100))
	end
end

function clickHandlerGUIVehicles(button, state)
	if(button == "left" and state == "up") then
		if(not isCursorGet(renderData.bg.x, renderData.bg.y, renderData.bg.x + renderData.bg.w, renderData.bg.y + renderData.bg.h)) then
			closePlayerVehiclesGUI()
			return
		end
		if(tonumber(renderData.selectedElement) and renderData.selectedElement ~= 0) then
			local selectedIndex = 0
			if(renderData.selectedElement <= 5 and renderData.selectedElement >= 1) then selectedIndex = 1 end -- INFO
			if(renderData.selectedElement <= 10 and renderData.selectedElement >= 6) then selectedIndex = 2 end -- SPAWN/UNSPAWN
			if(renderData.selectedElement <= 15 and renderData.selectedElement >= 11) then selectedIndex = 3 end -- NAMIERZ
			if(renderData.selectedElement <= 20 and renderData.selectedElement >= 16) then selectedIndex = 4 end -- PRZYPISZ
			if(renderData.selectedElement <= 26 and renderData.selectedElement >= 21) then selectedIndex = 5 end -- TUNING
			local index = selectedIndex + ((renderData.page - 1) * 3)
			if(type(renderData.vehicles[index]) == "table") then
				local option = 0
				if(selectedIndex == 1) then option = renderData.selectedElement
				elseif(selectedIndex == 2) then option = renderData.selectedElement - 5
				elseif(selectedIndex == 3) then option = renderData.selectedElement - 10
				elseif(selectedIndex == 4) then option = renderData.selectedElement - 15
				elseif(selectedIndex == 5) then option = renderData.selectedElement - 20
				end
				if(option ~= 0) then
					local index = selectedIndex + ((renderData.page - 1) * 3)
					if option == 2 then
						if renderData.vehicles[index].spawned == 1 then
							renderData.vehicles[index].spawned = 0
						else
							renderData.vehicles[index].spawned = 1
						end
					end

					if option == 4 then
						local ID = renderData.vehicles[index].ID
						triggerServerEvent( "showPrzypisz", getLocalPlayer(  ),  getLocalPlayer(  ), ID )
						closePlayerVehiclesGUI()
						return
					end


					if option == 5 then
						local ID = renderData.vehicles[index].ID
						triggerServerEvent( "showVehTune", getLocalPlayer(  ),  getLocalPlayer(  ), ID )
						closePlayerVehiclesGUI()
						return
					end

					if(tonumber(index)) then
						if(type(renderData.vehicles[index]) == "table") then
							triggerServerEvent("onPlayerClickOptionVehicleGUI", localPlayer, localPlayer, tonumber(renderData.vehicles[index].ID), tonumber(option))
							--closePlayerVehiclesGUI()
							return
						end
					end
				end
			end
			return
		end
		if(isCursorGet(renderData.arrowu.x, renderData.arrowu.y, renderData.arrowu.x + renderData.arrowu.w, renderData.arrowu.y + renderData.arrowu.h)) then
			renderData.page = renderData.page - 1
			if(renderData.page <= 0) then renderData.page = 1 end
		elseif(isCursorGet(renderData.arrowd.x, renderData.arrowd.y, renderData.arrowd.x + renderData.arrowd.w, renderData.arrowd.y + renderData.arrowd.h)) then		
			if(#renderData.vehicles < 1 + (renderData.page * 3)) then return end
			renderData.page = renderData.page + 1
		end
	end
end

function isCursorGet(minX, minY, maxX, maxY)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * sW, cY * sH
	if(cX > minX and cX < maxX and cY > minY and cY < maxY) then return true end
	return false
end

function closePlayerVehiclesGUI()
	setElementData(localPlayer, "vehGUI", false)
	removeEventHandler("onClientRender", root, renderVehiclesGUI)
	removeEventHandler("onClientClick", root, clickHandlerGUIVehicles)
	exports.titan_cursor:hideCustomCursor("vehiclesClientGui")

	for i = 1, 3 do
		if type(renderData.labely) == "table" then
			if(isElement(renderData.labely[i].info)) then destroyElement(renderData.labely[i].info) end
			if(isElement(renderData.labely[i].spawn)) then destroyElement(renderData.labely[i].spawn) end
			if(isElement(renderData.labely[i].namierz)) then destroyElement(renderData.labely[i].namierz) end
			if(isElement(renderData.labely[i].przypisz)) then destroyElement(renderData.labely[i].przypisz) end
			if(isElement(renderData.labely[i].tuning)) then destroyElement(renderData.labely[i].tuning) end
		end
	end
	if(isElement(renderData.font)) then destroyElement(renderData.font) end
	renderData = {}
end

function createPlayerVehiclesGUI(data, state)
	if not state then closePlayerVehiclesGUI() return end
	if renderData.showing == true then return end
	loadRenderData(data)
	addEventHandler("onClientRender", root, renderVehiclesGUI)
	addEventHandler("onClientClick", root, clickHandlerGUIVehicles)
	exports.titan_cursor:showCustomCursor("vehiclesClientGui")
	renderData.showing = true
	setElementData(localPlayer, "vehGUI", true)
end
addEvent("createPlayerVehiclesGUI", true)
addEventHandler("createPlayerVehiclesGUI", root, createPlayerVehiclesGUI)

-------------------
-- POJAZDY GRUPY --
-------------------
local GUIVeh = {}
local function createGroupVehiclesGUI(data)
	GUIVeh.okno = guiCreateWindow(sW / 2 - 313 / 2, sH / 2 - 381 / 2, 313, 381, "Pojazdy grupy", false)
	guiWindowSetSizable(GUIVeh.okno, false)

	GUIVeh.lista = guiCreateGridList(10, 26, 293, 287, false, GUIVeh.okno)
	guiGridListAddColumn(GUIVeh.lista, "UID", 0.5)
	guiGridListAddColumn(GUIVeh.lista, "Nazwa", 0.5)
	GUIVeh.locate = guiCreateButton(20, 323, 115, 38, "Namierz", false, GUIVeh.okno)
	GUIVeh.cancel = guiCreateButton(178, 323, 115, 38, "Anuluj", false, GUIVeh.okno)
	addEventHandler("onClientGUIClick", GUIVeh.cancel, closeGroupVehiclesGUI, false)
	exports.titan_cursor:showCustomCursor("vehiclesClientGui2")
end
addEvent("createGroupVehiclesGUI", true)
addEventHandler("createGroupVehiclesGUI", root, createGroupVehiclesGUI)

local function closeGroupVehiclesGUI()
	if(isElement(GUIVeh.okno)) then destroyElement(GUIVeh.okno) end
	GUIVeh = {}
	exports.titan_cursor:hideCustomCursor("vehiclesClientGui2")
end