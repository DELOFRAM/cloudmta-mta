----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:53:02
-- Ostatnio zmodyfikowano: 2016-01-23 23:59:43
----------------------------------------------------

local dbFunc = {}
local dbData = {}
local sW, sH = guiGetScreenSize()

dbFunc.renderPage = 1
dbFunc.renderData = {sW / 2 - 512, 92}
dbFunc.textData = {}

function dbFunc.render()
	dxDrawImage(0, 0, sW, 128, "client/files/bar.png")
	dxDrawImage(sW / 2 - 512, 0, 1024, 128, "client/files/barText.png")
	dxDrawImage(dbFunc.renderData[1], dbFunc.renderData[2], 1024, 640, "client/files/content.png")

	if dbFunc.renderPage == 1 then
		dxDrawImage(dbFunc.renderData[1] + 100, dbFunc.renderData[2] + 35, 376, 164, "client/files/icons/general/searchPerson.png")
		dxDrawImage(dbFunc.renderData[1] + 100, dbFunc.renderData[2] + 199, 376, 164, "client/files/icons/general/searchGun.png")
		dxDrawImage(dbFunc.renderData[1] + 100, dbFunc.renderData[2] + 363, 376, 164, "client/files/icons/general/searchPeople.png")
		dxDrawImage(dbFunc.renderData[1] + 540, dbFunc.renderData[2] + 35, 376, 164, "client/files/icons/general/searchCar.png")
		dxDrawImage(dbFunc.renderData[1] + 540, dbFunc.renderData[2] + 199, 376, 164, "client/files/icons/general/911.png")
		dxDrawImage(dbFunc.renderData[1] + 540, dbFunc.renderData[2] + 363, 376, 164, "client/files/icons/general/searchVehicles.png")
		dxDrawImage(dbFunc.renderData[1] + 400, dbFunc.renderData[2] + 527, 196, 86, "client/files/icons/general/exit.png")
	elseif dbFunc.renderPage == 2 then
		dxDrawImage(dbFunc.renderData[1] + 80, dbFunc.renderData[2] + 50, 197, 17, "client/files/icons/general/back.png")
		dxDrawImage(sW / 2 - 410, dbFunc.renderData[2] + 80, 759, 73, "client/files/searchPerson.png")
		dxDrawText(tostring(table.concat(dbFunc.textData, "")), sW / 2 - 400, dbFunc.renderData[2] + 106, sW / 2 + 330, dbFunc.renderData[2] + 150, tocolor(200, 200, 200, 255), 1.5, "default-bold", "left", "center", true)
	end
end

function dbFunc.cursor(minX, minY, maxX, maxY, isImage)
	if isCursorShowing() then
		local cX, cY = getCursorPosition()
		if cX then
			cX = cX * sW
			cY = cY * sH
			if isImage then
				maxX = minX + maxX
				maxY = minY + maxY
			end
			if cX > minX and cX < maxX and cY > minY and cY < maxY then return true end
			return false
		end
	end
	return false
end

function dbFunc.key(button, press)
	if press then
		if dbFunc.renderPage == 2 then
			local text = {}
			if button == "backspace" then
				if #dbFunc.textData > 0 then
					table.remove(dbFunc.textData, #dbFunc.textData)
				end
				return
			end
			table.insert(dbFunc.textData, button)
		end
	end
end

function dbFunc.click(button, state)
	if button == "left" and state == "up" then
		if dbFunc.renderPage == 1 then
			if dbFunc.cursor(dbFunc.renderData[1] + 100, dbFunc.renderData[2] + 50, 376, 164, true) then -- searchPerson
				dbFunc.renderPage = 2
				dbFunc.textData = {}
				return exports.titan_noti:showBox("searchPerson")
			elseif dbFunc.cursor(dbFunc.renderData[1] + 100, dbFunc.renderData[2] + 214, 376, 164, true) then -- searchGun
				return exports.titan_noti:showBox("searchGun")
			elseif dbFunc.cursor(dbFunc.renderData[1] + 100, dbFunc.renderData[2] + 378, 376, 164, true) then -- searchPeople
				return exports.titan_noti:showBox("searchPeople")
			elseif dbFunc.cursor(dbFunc.renderData[1] + 540, dbFunc.renderData[2] + 50, 376, 164, true) then -- searchCar
				return exports.titan_noti:showBox("searchCar")
			elseif dbFunc.cursor(dbFunc.renderData[1] + 540, dbFunc.renderData[2] + 214, 376, 164, true) then -- 911
				return exports.titan_noti:showBox("911")
			elseif dbFunc.cursor(dbFunc.renderData[1] + 540, dbFunc.renderData[2] + 378, 376, 164, true) then -- searchVehicles
				return exports.titan_noti:showBox("searchVehicles")
			elseif dbFunc.cursor(dbFunc.renderData[1] + 400, dbFunc.renderData[2] + 527, 196, 86, true) then -- exit
				removeEventHandler("onClientRender", root, dbFunc.render)
				removeEventHandler("onClientClick", root, dbFunc.click)
				removeEventHandler("onClientKey", root, dbFunc.key)
				exports.titan_misc:showTitanCursor()
				if isElement(window) then destroyElement(window) end
				return
			end
		elseif dbFunc.renderPage == 2 then
			if dbFunc.cursor(dbFunc.renderData[1] + 80, dbFunc.renderData[2] + 50, 197, 17, true) then -- back
				dbFunc.renderPage = 1
				return exports.titan_noti:showBox("back")
			elseif dbFunc.cursor(sW / 2 - 410, dbFunc.renderData[2] + 90, 759, 63, true) then

			end
		end
	end
end


function cmdKartoteka()
	dbFunc.renderPage = 1
	addEventHandler("onClientRender", root, dbFunc.render)
	addEventHandler("onClientClick", root, dbFunc.click)
	addEventHandler("onClientKey", root, dbFunc.key)
	window = createElement("titan-gui")
	exports.titan_misc:showTitanCursor(true)
end
addCommandHandler("kartoteka", cmdKartoteka)