----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:44:23
-- Ostatnio zmodyfikowano: 2016-01-09 15:44:26
----------------------------------------------------

local sW, sH = guiGetScreenSize()
local renderData = {}
local font = dxCreateFont("client/font/font.ttf", 30)

renderData.boxX 	= sW / 2 - 200
renderData.boxY 	= sH - 250
renderData.boxW 	= 400
renderData.boxH 	= 50

renderData.box2X 	= renderData.boxX
renderData.box2Y 	= renderData.boxY + renderData.boxH + 5
renderData.box2W	= renderData.boxW
renderData.box2H	= renderData.boxH

renderData.textX 	= renderData.boxX
renderData.textY 	= renderData.boxY
renderData.textW 	= renderData.textX + renderData.boxW
renderData.textH 	= renderData.textY + renderData.boxH / 2 + 5

renderData.text2X 	= renderData.box2X
renderData.text2Y 	= renderData.box2Y
renderData.text2W 	= renderData.text2X + renderData.box2W
renderData.text2H 	= renderData.text2Y + renderData.box2H

renderData.bwText 	= "Twoja postać otrzymała obrażenia, przez które nie jest w stanie chwilowo podnieść się z ziemi. Aby poprawić stan zdrowia, zjedz coś lub udaj się do szpitala." -- oszołomiony

function getPointFromDistanceRotation(x, y, dist, angle)

	local a = math.rad(90 - angle);

	local dx = math.cos(a) * dist;
	local dy = math.sin(a) * dist;

	return x+dx, y+dy;
end

function renderBWTime()
	if(getElementData(localPlayer, "loggedIn") ~= 1) then return end

	local bwTime = getElementData(localPlayer, "bwTime")
	if(not bwTime or tonumber(bwTime) and tonumber(bwTime) <= 0) then return end
	
	if getElementData(localPlayer, "damageType") == 1 then renderData.bwText 	= "Twoja postać otrzymała obrażenia, przez które nie jest w stanie chwilowo podnieść się z ziemi. Aby poprawić stan zdrowia, zjedz coś lub udaj się do szpitala." end -- oszołomiony
	if getElementData(localPlayer, "damageType") == 2 then renderData.bwText 	= "Twoja postać otrzymała obrażenia, które spowodowały utratę przytomności. Aby poprawić stan zdrowia, zjedz coś lub udaj się do szpitala." end -- nieprzytomny
	if getElementData(localPlayer, "damageType") == 3 then renderData.bwText 	= "Twoja postać została ciężko ranna. Aby odzyskać siły, musisz odwiedzić pobliską placówkę Los Santos Medical Center." end -- ranny
	
	local minutes = math.floor(bwTime / 60)
	local seconds = math.floor(bwTime - (minutes * 60))

	dxDrawRectangle(0, 0, sW, sH, tocolor(255, 0, 0, 80))
	dxDrawRectangle(renderData.boxX, renderData.boxY, renderData.boxW, renderData.boxH, tocolor(0, 0, 0, 150))
	dxDrawText(string.format("Pozostało %0.2d:%0.2d do końca BW", minutes, seconds), renderData.textX, renderData.textY, renderData.textW, renderData.textH, tocolor(255, 255, 255, 255), 0.5, font, "center", "center")
	dxDrawText("Wpisz /asmierc aby zaakceptować śmierć", renderData.textX, renderData.textH, renderData.textW, renderData.textY + renderData.boxH, tocolor(255, 255, 255, 150), 0.3, font, "center", "center")
	dxDrawRectangle(renderData.box2X, renderData.box2Y + 5, renderData.box2W, renderData.box2H, tocolor(0, 0, 0, 150))
	dxDrawText(renderData.bwText, renderData.text2X, renderData.text2Y, renderData.text2W, renderData.text2H + 7, tocolor(255, 255, 255, 255), 0.289, font, "center", "center", false, true)
	local pX, pY, pZ = getElementPosition(localPlayer)
	local camX, camY = getPointFromDistanceRotation(pX, pY, 5, 20)
	setCameraMatrix(camX, camY, pZ + 5, pX, pY, pZ)
end
addEventHandler("onClientRender", root, renderBWTime)

function renderAJTime()
	if(getElementData(localPlayer, "loggedIn") ~= 1) then return end
	if not getElementData(localPlayer, "ajTime") or not getElementData(localPlayer, "inAJ") then return end
	local ajTime = getElementData(localPlayer, "ajTime")
	local hours = math.floor(ajTime / 3600)
	local minutes = math.floor(ajTime / 60) - (hours * 60)
	local seconds = math.floor(ajTime - (minutes * 60) - (hours * 3600))
	dxDrawRectangle(renderData.box2X, renderData.box2Y, renderData.box2W, renderData.box2H, tocolor(0, 0, 0, 150))
	dxDrawText(string.format("Pozostało %0.2d:%0.2d:%0.2d do końca AJ", hours, minutes, seconds), renderData.text2X, renderData.text2Y, renderData.text2W, renderData.text2H, tocolor(255, 255, 255, 255), 0.5, font, "center", "center")

end
addEventHandler("onClientRender", root, renderAJTime)

function checkPlayerBW()
	if(getElementData(localPlayer, "loggedIn") == 1) then
		local bwTime = getElementData(localPlayer, "bwTime")
		if(not bwTime or not tonumber(bwTime)) then return end
		if(bwTime > 0) then
			if(getElementHealth(localPlayer) ~= 1) then
				setElementHealth(localPlayer, 1)
				triggerServerEvent("setPlayerBW", localPlayer, localPlayer, localPlayer)
			end
			toggleAllControls(false, true, false)
			if(not bwTime) then return end
			bwTime = bwTime - 1
			setElementData(localPlayer, "bwTime", bwTime)
			local block, anim = getPedAnimation(localPlayer)
			if(block ~= "PED" and anim ~= "KO_shot_front") then
				if not isPedInVehicle(localPlayer) then
					setPedAnimation(localPlayer, "PED", "KO_shot_front", -1, false, true, false, true)
				end
			end
		else
			turnBWOff()
		end
	end
end
setTimer(checkPlayerBW, 1000, 0)

function onDam(attacker)
	if(tonumber(getElementData(localPlayer, "bwTime")) and getElementData(localPlayer, "bwTime") > 0) then cancelEvent() end
	
	if attacker and getPedOccupiedVehicle(localPlayer) ~= false then 
		if getPedOccupiedVehicle(localPlayer) == getPedOccupiedVehicle(attacker) then cancelEvent() end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDam)

function turnBWOff()
	localPlayer:setData("CKReason", false)
	setElementData(localPlayer, "bwTime", false)
	triggerServerEvent("triggerPlayerSpawn", localPlayer, localPlayer)	
end
addEvent("turnBWOff", true)
addEventHandler("turnBWOff", root, turnBWOff)

local deathGUI = {}

function deathGUI.create()
	local sW, sH = guiGetScreenSize()
	if isElement(deathGUI.okno) then destroyElement(deathGUI.okno) end
	deathGUI.okno = guiCreateWindow(sW / 2 - 378 / 2, sH / 2 - 150 / 2, 378, 150, "Potwierdzenie śmierci", false)
	guiWindowSetSizable(deathGUI.okno, false)
	deathGUI.label = guiCreateLabel(10, 30, 358, 58, "Czy rzeczywiście chcesz uśmiercić swoją postać?\nRobiąc to Twoja postać zostanie zablokowana i przez to niemożliwe będzie granie nią. Twoje wszystkie przedmioty zostaną wyrzucone w miejscu Twojej śmierci.", false, deathGUI.okno)
	guiSetFont(deathGUI.label, "default-bold-small")
	guiLabelSetHorizontalAlign(deathGUI.label, "center", true)
	deathGUI.tak = guiCreateButton(10, 110, 155, 30, "Tak", false, deathGUI.okno)
	deathGUI.nie = guiCreateButton(203, 110, 155, 30, "Nie", false, deathGUI.okno)
	exports.titan_cursor:showCustomCursor("bwBW")

	addEventHandler("onClientGUIClick", deathGUI.nie, deathGUI.delete, false)
end
addEvent("deathGUI.create", true)
addEventHandler("deathGUI.create", root, deathGUI.create)

function deathGUI.delete()
	if isElement(deathGUI.okno) then destroyElement(deathGUI.okno) end
	if isElement(window) then destroyElement(window) end
	exports.titan_cursor:hideCustomCursor("bwBW")
end

function onStreamIn()
	if(getElementType(source) == "player" or getElementType(source) == "ped") then
		local bwTime = getElementData(source, "bwTime")
		if tonumber(bwTime) and tonumber(bwTime) > 0 then
			if isPedInVehicle(source) then
				setPedAnimation(source, "PED", "CAR_dead_LHS", -1, false, true, false, true)
			else
				setPedAnimation(source, "PED", "KO_shot_front", -1, false, true, false, true)
			end
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onStreamIn)