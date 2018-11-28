----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

startTime = getTickCount()

function showGUI()
	if isElement(window) then destroyElement(window) end
	window = guiCreateWindow(635/1680, 428/1050, 411/1680, 195/1050, "Potwierdzenie hospitalizacji", false)
	guiWindowSetMovable(window, false)
	guiWindowSetSizable(window, false)
	label = guiCreateLabel(10/1680, 23/1050, 391/1680, 78/1050, "Czy chcesz rozpocząć proces hospitalizacji? Kosztuje on $100 i trwa 10 minut. Uzupełnia cały pasek zdrowia, nie można go przerwać.", false, window)
	guiSetFont(label, "default-bold-small")
	guiLabelSetHorizontalAlign(label, "left", true)
	but1 = guiCreateButton(16/1680, 132/1050, 186/1680, 53/1050, "Kontynnuj", false, window)
	but2 = guiCreateButton(215/1680, 132/1050, 186/1680, 53/1050, "Anuluj", false, window) 
	exports.titan_cursor:showCustomCursor("hospital")
end
addEvent("showGUI", true)
addEventHandler("showGUI", root, showGUI)

addEventHandler("onClientGUIClick", root, function()
	if source == but1 then
		destroyElement(window)
		exports.titan_cursor:hideCustomCursor("hospital")
		exports.titan_noti:showBox("Proces hospitalizacji właśnie się rozpoczął, zostałeś przeniesiony do gabinetu lekarskiego.")
		start = getTickCount()
		addEventHandler("onClientRender", root, render)
		setTimer(function()
			triggerServerEvent("healPlayer", localPlayer)
			exports.titan_noti:showBox("Zakończono proces hospitalizacji. Z Twojego portfela pobrano $100.")
			end, 10000, 1)
	elseif source == but2 then
		destroyElement(window)
		exports.titan_cursor:hideCustomCursor("hospital")
	end
end)

function render()
	
end