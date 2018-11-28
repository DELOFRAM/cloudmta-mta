----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local guiCorners = {}

function createGUICorners()
	local sW, sH = guiGetScreenSize()
	if isElement(guiCorners.window) then destroyElement(guiCorners.window) end
	guiCorners.window = guiCreateWindow(sW / 2 - 293 / 2, sH / 2 - 201 / 2, 293, 201, "Odpowiedź", false)
	guiWindowSetSizable(guiCorners.window, false)
	guiCorners.label1 = guiCreateLabel(10, 29, 273, 56, "Aby sfinalizować transakcję, musisz podać cenę, jakiej oczekujesz za narkotyk. Następnie musisz nacisnąć przycisk, aby potwierdzić.", false, guiCorners.window)
	guiLabelSetHorizontalAlign(guiCorners.label1, "center", true)
	guiCreateLabel(10, 85, 123, 20, "Cena", false, guiCorners.window)

	guiCorners.price = guiCreateEdit(10, 105, 273, 32, "", false, guiCorners.window)
	guiCorners.submit = guiCreateButton(47, 154, 86, 37, "Zaoferuj", false, guiCorners.window)
	guiCorners.cancel = guiCreateButton(143, 154, 86, 37, "Zrezygnuj", false, guiCorners.window)

	exports.titan_cursor:showCustomCursor("corners/gui")

	addEventHandler("onClientGUIClick", guiCorners.cancel, closeGUICorners, false)
	addEventHandler("onClientGUIClick", guiCorners.submit, acceptGUICorners, false)
end
addEvent("createGUICorners", true)
addEventHandler("createGUICorners", root, createGUICorners)

function closeGUICorners()
	if isElement(guiCorners.window) then destroyElement(guiCorners.window) end
	exports.titan_cursor:hideCustomCursor("corners/gui")
	triggerServerEvent("guiCancel", localPlayer)
end

function acceptGUICorners()
	local money = guiGetText(guiCorners.price)
	if not tonumber(money) or tonumber(money) < 0 or tonumber(money) > 50000 then
		return exports.titan_noti:showBox("Wprowadzono niepoprawna ilosc pieniedzy.")
	end
	money = tonumber(money)
	if isElement(guiCorners.window) then destroyElement(guiCorners.window) end
	exports.titan_cursor:hideCustomCursor("corners/gui")
	triggerServerEvent("guiAccept", localPlayer, money)
end