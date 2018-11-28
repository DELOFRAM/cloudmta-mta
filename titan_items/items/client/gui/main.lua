----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

Settings = {}
Settings.var = {}
Settings.var.cutoff = 0.1
Settings.var.power = 1.88
Settings.var.bloom = 1.0
local sW, sH = guiGetScreenSize()
myScreenSource = dxCreateScreenSource(sW, sH)
blurHShader,tecName = dxCreateShader("items/client/gui/files/blurH.fx")
blurVShader,tecName = dxCreateShader("items/client/gui/files/blurV.fx")

local renderData = {}
local toggleItemGUI = false

function generateRenderData()
	renderData = {mainbg = {}, equipbg = {}, blocks = {}, checkedType = 0, checked = 0, selectedType = 0, selected = 0}
	renderData.mainbg.X = sW / 2 - 302
	renderData.mainbg.Y = sH / 2 - 174
	renderData.mainbg.W = 604
	renderData.mainbg.H = 348
	local staticI = 1
	local count = 1
	for i = 1, 35 do
		renderData.blocks[i] = {renderData.mainbg.X + 13 + 6 + (55 * (count - 1)), renderData.mainbg.Y + 56 + (54 * (staticI - 1))}
		renderData.blocks[i].guiElem = guiCreateLabel(renderData.blocks[i][1], renderData.blocks[i][2], 49, 48, "", false)
		setElementData(renderData.blocks[i].guiElem, "equipType", 1)
		setElementData(renderData.blocks[i].guiElem, "equipID", i)
		count = count + 1
		if count == 8 then
			staticI = staticI + 1
			count = 1
		end
	end
	local staticI = 1
	local count = 1
	for i = 1, 15 do
		renderData.blocks[i + 35] = {renderData.mainbg.X + 423 + (55 * (count - 1)), renderData.mainbg.Y + 65 + (54 * (staticI - 1))}
		renderData.blocks[i + 35].guiElem = guiCreateLabel(renderData.blocks[i + 35][1], renderData.blocks[i + 35][2], 49, 48, "", false)
		setElementData(renderData.blocks[i + 35].guiElem, "equipType", 2)
		setElementData(renderData.blocks[i + 35].guiElem, "equipID", i + 35)
		count = count + 1
		if count == 4 then
			staticI = staticI + 1
			count = 1
		end
	end
	renderData.font = dxCreateFont("items/client/gui/files/font.otf", 12)
end
function openItemGUI(data, groundItems)
	if getElementData(localPlayer, "vehGUI") then return exports.titan_noti:showBox("Nie możesz włączyć GUI przedmiotów mając włączone GUI pojazdów.") end
	if getElementData(localPlayer, "cuffedBy") then return exports.titan_noti:showBox("Jesteś aktualnie skuty. Nie możesz otworzyć ekwipunku!") end
	generateRenderData()
	renderData.items = {}
	for k, v in pairs(data) do
		renderData.items[v.slotID] = v
	end
	local slotID = 1
	if type(groundItems) == "table" then
		for k, v in pairs(groundItems) do
			renderData.items[slotID + 35] = v
			slotID = slotID + 1
		end
	end
	synchronizeItems()
	exports.titan_cursor:showCustomCursor("itemsGuiMain")
	addEventHandler("onClientRender", root, renderEquip)
	addEventHandler("onClientClick", root, mouseClick)
	setElementData(localPlayer, "itemsGUI", true)
end
addEvent("openItemGUI", true)
addEventHandler("openItemGUI", root, openItemGUI)

function updatePlayerItems(data, nearest)
	if(type(renderData.items) == "table") then
		renderData.items = {}
		for k, v in pairs(data) do
			renderData.items[v.slotID] = v
		end
		local slotID = 1
		for k, v in pairs(nearest) do
			renderData.items[slotID + 35] = v
			slotID = slotID + 1
		end
	end
	synchronizeItems()
end
addEvent("updatePlayerItems", true)
addEventHandler("updatePlayerItems", root, updatePlayerItems)

function closeItemGUI()
	if(isElement(renderData.font)) then destroyElement(renderData.font) end
	removeEventHandler("onClientRender", root, renderEquip)
	removeEventHandler("onClientClick", root, mouseClick)
	exports.titan_cursor:hideCustomCursor("itemsGuiMain")
	if(type(renderData.blocks) == "table") then
		for k, v in pairs(renderData.blocks) do
			if(isElement(v.guiElem)) then destroyElement(v.guiElem) end
		end
	end
	renderData = {}
	setElementData(localPlayer, "itemsGUI", false)
end
addEvent("closeItemGUI", true)
addEventHandler("closeItemGUI", root, closeItemGUI)

function synchronizeItems()
	toggleItemGUI = false
end
addEvent("synchronizeItems", true)
addEventHandler("synchronizeItems", root, synchronizeItems)

------------
-- EVENTY --
------------

addEventHandler("onClientMouseLeave", resourceRoot, 
function()
	renderData.checked = 0
	renderData.checkedType = 0
end)
	
addEventHandler("onClientMouseEnter", resourceRoot, 
function()
	local typ = getElementData(source, "equipType")
	if(tonumber(typ)) then
		local ID = getElementData(source, "equipID")
		if(tonumber(ID)) then
			renderData.checked = tonumber(ID)
			renderData.checkedType = tonumber(typ)
		end
	end
end)

function renderEquip()
	--[[ BLUR ]]--
	RTPool.frameStart()
	dxUpdateScreenSource(myScreenSource)
	local current = myScreenSource

	current = applyDownsample(current)
	current = applyGBlurH(current, Settings.var.bloom)
	current = applyGBlurV(current, Settings.var.bloom)
	dxSetRenderTarget()
	dxDrawImage(0, -20, sW, sH + 20, current, 0,0,0, tocolor(255, 255, 255, 255))
	--[[ BLUR ]]--
	dxDrawRectangle(0, 0, sW, sH, tocolor(0, 0, 0, 150), false)
	
	-------------
	-- DISPLAY --
	-------------
	dxDrawImage(renderData.mainbg.X, renderData.mainbg.Y, renderData.mainbg.W, renderData.mainbg.H, "items/client/gui/files/mainbg.png")
	dxDrawImage(renderData.mainbg.X, renderData.mainbg.Y, renderData.mainbg.W, renderData.mainbg.H, "items/client/gui/files/itemsbg.png")
	if isPedInVehicle(localPlayer) then
		dxDrawImage(renderData.mainbg.X, renderData.mainbg.Y, renderData.mainbg.W, renderData.mainbg.H, "items/client/gui/files/vehbg.png")
	else
		dxDrawImage(renderData.mainbg.X, renderData.mainbg.Y, renderData.mainbg.W, renderData.mainbg.H, "items/client/gui/files/nearestbg.png")
	end

	for i = 1, #renderData.blocks do
		local alpha = 200
		local checked = renderData.checked == i and true or false
		if(checked) then alpha = 255 end
		dxDrawImage(renderData.blocks[i][1], renderData.blocks[i][2], 49, 48, "items/client/gui/files/iconbg.png", 0, 0, 0, tocolor(255, 255, 255, alpha))

		if(type(renderData.items[i]) == "table") then
			local r, g, b = 255, 255, 255
			if(renderData.items[i].used == 1) then r, g, b = 96, 118, 45 end
			local icon = "items/client/gui/files/icons/0.png"
			if renderData.items[i].type == 1 or renderData.items[i].type == 14 then
				if fileExists("items/client/gui/files/icons/guns/"..renderData.items[i].val1..".png") then
					icon = "items/client/gui/files/icons/guns/"..renderData.items[i].val1..".png"
				else
					icon = "items/client/gui/files/icons/1.png"
				end
			else
				if fileExists("items/client/gui/files/icons/"..renderData.items[i].type..".png") then
					icon = "items/client/gui/files/icons/"..renderData.items[i].type..".png"
				end
			end
			--local icon = renderData.items[i].type == 1 and fileExists("items/client/gui/files/icons/guns"..renderData.items[i].val1..".png") and "items/client/gui/files/icons/guns"..renderData.items[i].val1..".png" or "items/client/gui/files/icons/0.png"  or fileExists("items/client/gui/files/icons/"..renderData.items[i].type..".png") and "items/client/gui/files/icons/"..renderData.items[i].type..".png" or "items/client/gui/files/icons/0.png"
			dxDrawImage(renderData.blocks[i][1], renderData.blocks[i][2], 49, 48, icon, 0, 0, 0, tocolor(r, g, b, alpha))	
		end
	end

	-------------
	-- PREVIEW --
	-------------

	if(renderData.checkedType == 1 or renderData.checkedType == 2) then
		local index = renderData.checked
			if(type(renderData.items[index]) == "table" and index ~= renderData.selected) then
				if(isCursorShowing()) then
					local cX, cY = getCursorPosition()
					cX, cY = cX * sW, cY * sH
					if getElementData(localPlayer, "adminDuty") and getElementData(localPlayer, "adminLevel") > 0 then
						height = 130
					else
						height = 90
					end


					dxDrawImage(cX, cY, 250, height, "items/client/gui/files/preview.png")
					local r, g, b = 255, 255, 255
					if(renderData.items[index].used == 1) then r, g, b = 96, 118, 45 end
					dxDrawText(string.format("%s", tostring(renderData.items[index].name) ), cX + 10, cY + 5, 0, 0, tocolor(r, g, b, 220), 1.0, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
					dxDrawText(string.format("UID: %s", tostring(renderData.items[index].ID) ), cX + 15, cY + 30, 0, 0, tocolor(255, 255, 255, 220), 0.7, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
					dxDrawText(string.format("Typ: %s", getItemTypeName(renderData.items[index].type)), cX + 15, cY + 45, 0, 0, tocolor(255, 255, 255, 220), 0.7, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
					if renderData.items[index].volume then
						dxDrawText(string.format("Objętość: %dm³", tostring(renderData.items[index].volume) ), cX + 15, cY + 60, 0, 0, tocolor(255, 255, 255, 220), 0.7, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
						if getElementData(localPlayer, "adminDuty") and getElementData(localPlayer, "adminLevel") > 0 and (not disableInfo(renderData.items[index].type)) then
							dxDrawText(string.format("Wartość I: %s", tostring(renderData.items[index].val1)), cX + 15, cY + 75, 0, 0, tocolor(255, 255, 255, 220), 0.7, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
							dxDrawText(string.format("Wartość II: %d", tostring(renderData.items[index].val2) ), cX + 15, cY + 90, 0, 0, tocolor(255, 255, 255, 220), 0.7, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
							dxDrawText(string.format("Wartość III: %s", tostring(renderData.items[index].val3) ), cX + 15, cY + 106, 0, 0, tocolor(255, 255, 255, 220), 0.7, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
						end
					end
				end
			end
	end

	if(renderData.selectedType > 0 and renderData.selected > 0) then
		local index = getItemIndex(renderData.selectedType, renderData.selected)
		if(type(renderData.items[index]) == "table") then
			local cX, cY = getCursorPosition()
			cX, cY = cX * sW, cY * sH
			local r, g, b = 255, 255, 255
			if(renderData.items[index].used == 1) then r, g, b = 96, 118, 45 end
			local icon = "items/client/gui/files/icons/0.png"
			if renderData.items[index].type == 1 or renderData.items[index].type == 14 then
				if fileExists("items/client/gui/files/icons/guns/"..renderData.items[index].val1..".png") then
					icon = "items/client/gui/files/icons/guns/"..renderData.items[index].val1..".png"
				else
					icon = "items/client/gui/files/icons/1.png"
				end
			else
				if fileExists("items/client/gui/files/icons/"..renderData.items[index].type..".png") then
					icon = "items/client/gui/files/icons/"..renderData.items[index].type..".png"
				end
			end
			dxDrawImage(cX - 24.5, cY - 24, 49, 48, icon, 0, 0, 0, tocolor(r, g, b, 100))
		end
	end
	if(toggleItemGUI) then
		dxDrawText("Synchronizowanie...", renderData.mainbg.X + 20, renderData.mainbg.Y + 15, 0, 0, tocolor(255, 255, 255, 100), 0.6, renderData.font, "left", "top", false, false, false, false, true, 0, 0, 0)
	end
end

function mouseClick(button, state)
	if(button == "left") then
		if(state == "down") then
			if(not isCursorGet(renderData.mainbg.X, renderData.mainbg.Y, renderData.mainbg.X + renderData.mainbg.W, renderData.mainbg.Y + renderData.mainbg.H)) then
				setElementData(localPlayer, "itemGUIOpened", false)
				closeItemGUI()
				return
			end
			if(toggleItemGUI) then return end
			if(renderData.checkedType ~= 0) then
				local index = getItemIndex(renderData.checkedType, renderData.checked)
				if(type(renderData.items[index]) == "table") then
					renderData.selectedType = renderData.checkedType
					renderData.selected = renderData.checked
				end
			end
		elseif(state == "up") then	
			if(toggleItemGUI) then return end
			--------------------
			-- SWÓJ PRZEDMIOT --
			--------------------
			if(renderData.selectedType == 1) then
				----------------------------
				-- PRZENIÓSŁ NA INNY SLOT --
				----------------------------
				if(renderData.checkedType == 1) then
					if(renderData.selected == renderData.checked) then
						renderData.selectedType = 0
						renderData.selected = 0
						return
					end
					local checkedIndex = getItemIndex(1, renderData.checked)
					if(type(renderData.items[checkedIndex]) == "table") then
						
						local checkedItem = renderData.items[checkedIndex]
						local selectedIndex = getItemIndex(1, renderData.selected)
						if(not tonumber(selectedIndex)) then return end
						local selectedItem = renderData.items[selectedIndex]
						-----------------------------------------
						-- JEŚLI NA SLOCIE JEST INNY PRZEDMIOT --
						-----------------------------------------
						-------------
						-- BOOMBOX --
						-------------
						if(checkedItem.type == 19) then
							if(selectedItem.type == 12) then
								toggleItemGUI = true
								renderData.selectedType = 0
								renderData.selected = 0
								triggerServerEvent("guiFunc.loadBoombox", localPlayer, localPlayer, checkedItem.ID, selectedItem.ID)
								return
							end
						end
						--------------
						-- AMUNICJA --
						--------------
						if checkedItem.type == 1 then
							if selectedItem.type == 2 then
								if tonumber(checkedItem.val1) ~= tonumber(selectedItem.val1) then
									exports.titan_noti:showBox("Amunicja nie pasuje do tej broni.")
									renderData.selectedType = 0
									renderData.selected = 0
									return
								end
								toggleItemGUI = true
								renderData.selectedType = 0
								renderData.selected = 0
								triggerServerEvent("guiFunc.loadWeapon", localPlayer, localPlayer, checkedItem.ID, selectedItem.ID)
								return
							end
						end
						exports.titan_noti:showBox("Ten slot jest zajęty przez inny przedmiot.")
						renderData.selectedType = 0
						renderData.selected = 0
						return
					end
					local selectedIndex = getItemIndex(1, renderData.selected)
					if(not tonumber(selectedIndex)) then return end
					if(not tonumber(renderData.items[selectedIndex].ID)) then return end
					toggleItemGUI = true
					triggerServerEvent("guiFunc.moveItemInEquip", localPlayer, localPlayer, renderData.items[selectedIndex].ID, checkedIndex)
					renderData.selectedType = 0
					renderData.selected = 0
					return
				---------------------
				-- POZA SWÓJ EQUIP --
				---------------------
				elseif renderData.checkedType == 2 then
					local checkedItem = renderData.items[checkedIndex]
					local selectedIndex = getItemIndex(1, renderData.selected)
					if(not tonumber(selectedIndex)) then return end
					local selectedItem = renderData.items[selectedIndex]
					if selectedItem.used == 1 then
						exports.titan_noti:showBox("Przedmiot jest używany.")
						renderData.selectedType = 0
						renderData.selected = 0
						return
					end
					triggerServerEvent("guiFunc.throwItem", localPlayer, localPlayer, renderData.items[selectedIndex].ID)
					toggleItemGUI = true
					renderData.selectedType = 0
					renderData.selected = 0
					return
				end
			------------------------
			-- NIE SWÓJ PRZEDMIOT --
			------------------------
			elseif renderData.selectedType == 2 then
				-------------------
				-- DO SWOJEGO EQ --
				-------------------
				if renderData.checkedType == 1 then
					local checkedIndex = getItemIndex(1, renderData.checked)
					local checkedItem = renderData.items[checkedIndex]
					local selectedIndex = getItemIndex(2, renderData.selected)
					if(not tonumber(selectedIndex)) then return end
					local selectedItem = renderData.items[selectedIndex]
					if type(renderData.items[checkedIndex]) == "table" then
						exports.titan_noti:showBox("Ten slot jest zajęty przez inny przedmiot.")
						renderData.selectedType = 0
						renderData.selected = 0
						return
					end
					toggleItemGUI = true
					renderData.selectedType = 0
					renderData.selected = 0
					triggerServerEvent("guiFunc.pickItem", localPlayer, localPlayer, renderData.items[selectedIndex].ID, checkedIndex)
					return
				end
			end
			-----------
			-- RESET --
			-----------
			renderData.selectedType = 0
			renderData.selected = 0
		end
	elseif(button == "right") then
		if(toggleItemGUI) then return end
		if(state == "down") then
			if(renderData.selectedType ~= 0 or renderData.selected ~= 0) then return end
			if(renderData.checkedType == 1) then
				local index = getItemIndex(renderData.checkedType, renderData.checked)
				if(type(renderData.items[index]) == "table") then
					toggleItemGUI = true
					triggerServerEvent("guiFunc.useItem", localPlayer, localPlayer, renderData.items[index].ID)
				end
			end
		end
	end
end

-------------
-- FUNKCJE --
-------------

function getItemTypeName(itemType)
	if(itemType == 1) then return "Broń"
	elseif(itemType == 2) then return "Amunicja"
	elseif(itemType == 3) then return "Ubranie"
	elseif(itemType == 4) then return "Megafon"
	elseif(itemType == 5) then return "Kamizelka kuloodporna"
	elseif(itemType == 6) then return "Jedzenie"
	elseif(itemType == 7) then return "Ciało"
	elseif(itemType == 8) then return "Telefon"
	elseif(itemType == 9) then return "Rękawiczki"
	elseif(itemType == 10) then return "Klucze"
	elseif(itemType == 11) then return "Karta bankomatowa"
	elseif(itemType == 12) then return "Płyta CD"
	elseif(itemType == 13) then return "Narkotyki"
	elseif(itemType == 14) then return "Paralizator"
	elseif(itemType == 15) then return "Obiekt przyczepialny"
	elseif(itemType == 16) then return "Maska"
	elseif(itemType == 17) then return "Prawo jazdy"
	elseif(itemType == 18) then return "Kajdanki"
	elseif(itemType == 19) then return "Boombox"
	elseif(itemType == 20) then return "Syrena policyjna"
	elseif(itemType == 21) then return "Alkohol"
	elseif(itemType == 22) then return "Kostka do gry"
	elseif(itemType == 23) then return "Częśc Tuningowa"	
	elseif(itemType == 24) then return "Wyważacz drzwi"
	elseif(itemType == 25) then return "Pieniądzę"
	elseif(itemType == 26) then return "Narzędzie diagnostyczne"		
	elseif itemType == 27 then return "Karnet na siłownię"
	elseif itemType == 28 then return "Część tuningowa"
	elseif itemType == 29 then return "Część do pojazdu"
	end
	return "Nieznany"
end

function isCursorGet(minX, minY, maxX, maxY)
	local cX, cY = getCursorPosition()
	if(not cX) then return false end
	cX, cY = cX * sW, cY * sH
	if(cX > minX and cX < maxX and cY > minY and cY < maxY) then return true end
	return false
end

function getItemIndex(typ, number)
	local sum = 0
	if(typ == 2) then sum = 0 end
	return sum + number
end

function disableInfo(type)
	local disabled = {[12] = true, [20] = true, [19] = true, [18] = true, [4] = true, [22] = true, [17] = true, [7] = true}
	if(disabled[type]) then return true end
	return false
end

--- Tutaj sobie będzie blur

------------------------------
--Apply the different stages--
------------------------------
function applyDownsample( Src, amount )
	amount = amount or 2
	local mx,my = dxGetMaterialSize( Src )
	mx = mx / amount
	my = my / amount
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT )
	dxDrawImage( 0, 0, mx, my, Src )
	return newRT
end

function applyGBlurH( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurHShader, "tex0", Src )
	dxSetShaderValue( blurHShader, "tex0size", mx,my )
	dxSetShaderValue( blurHShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx, my, blurHShader )
	return newRT
end

function applyGBlurV( Src, bloom )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( blurVShader, "tex0", Src )
	dxSetShaderValue( blurVShader, "tex0size", mx,my )
	dxSetShaderValue( blurVShader, "bloom", bloom )
	dxDrawImage( 0, 0, mx,my, blurVShader )
	return newRT
end

function applyBrightPass( Src, cutoff, power )
	local mx,my = dxGetMaterialSize( Src )
	local newRT = RTPool.GetUnused(mx,my)
	dxSetRenderTarget( newRT, true ) 
	dxSetShaderValue( brightPassShader, "tex0", Src )
	dxSetShaderValue( brightPassShader, "cutoff", cutoff )
	dxSetShaderValue( brightPassShader, "power", power )
	dxDrawImage( 0, 0, mx,my, brightPassShader )
	return newRT
end


--------------------------
--Pool of render targets--
--------------------------
RTPool = {}
RTPool.list = {}

function RTPool.frameStart()
	for rt,info in pairs(RTPool.list) do
		info.bInUse = false
	end
end

function RTPool.GetUnused( mx, my )
	-- Find unused existing
	for rt,info in pairs(RTPool.list) do
		if not info.bInUse and info.mx == mx and info.my == my then
			info.bInUse = true
			return rt
		end
	end
	-- Add new
	local rt = dxCreateRenderTarget( mx, my )
	if rt then
		RTPool.list[rt] = { bInUse = true, mx = mx, my = my }
	end
	return rt
end