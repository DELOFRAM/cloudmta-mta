----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local magazineGUI = {}
local pVeh = nil

function createCourierMagazineGUI(packages, playerVehicle)
	if isElement(magazineGUI.okno) then destroyElement(magazineGUI.okno) end
	local sW, sH = guiGetScreenSize()

	magazineGUI.okno = guiCreateWindow(sW / 2 - 398 / 2, sH / 2 - 145 / 2, 398, 145, "Potwierdzenie odbioru przesyłki z magazynu", false)
	guiWindowSetSizable(magazineGUI.okno, false)

	magazineGUI.label = guiCreateLabel(10, 24, 378, 43, "Do pojazdu możesz załadować jeszcze "..packages.." paczek.", false, magazineGUI.okno)
	guiLabelSetHorizontalAlign(magazineGUI.label, "center", true)
	guiLabelSetVerticalAlign(magazineGUI.label, "center")
	magazineGUI.buttonLoad = guiCreateButton(10, 77, 239, 58, "Weź paczkę", false, magazineGUI.okno)
	magazineGUI.buttonCancel = guiCreateButton(259, 100, 129, 35, "Anuluj", false, magazineGUI.okno)

	exports.titan_cursor:showCustomCursor("courier/magazineGUI")

	addEventHandler("onClientGUIClick", magazineGUI.buttonCancel, cancelCourierMagazineGUI, false)
	addEventHandler("onClientGUIClick", magazineGUI.buttonLoad, acceptCourierMagazineGUI, false)

	pVeh = playerVehicle
end
addEvent("createCourierMagazineGUI", true)
addEventHandler("createCourierMagazineGUI", root, createCourierMagazineGUI)

function acceptCourierMagazineGUI()
	local x0, y0, z0, x1, y1, z1 = getElementBoundingBox(pVeh)
	local data = {x0, y0, z0, x1, y1, z1}
	triggerServerEvent("courierData.takePackage", localPlayer, localPlayer, data)
	cancelCourierMagazineGUI()
end

function cancelCourierMagazineGUI()
	if isElement(magazineGUI.okno) then destroyElement(magazineGUI.okno) end
	exports.titan_cursor:hideCustomCursor("courier/magazineGUI")
	pVeh = nil
end