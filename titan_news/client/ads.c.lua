function showAdGUI(minutes, reporter)
	if not guiGetVisible(ads.window) then
		guiSetVisible(ads.window, true)
		exports.titan_cursor:showCustomCursor("newsClientAds")
		setElementData(localPlayer, "reporter", reporter)
		setElementData(localPlayer, "minutes", minutes)
		guiSetInputMode("no_binds_when_editing")
	else
		if #guiGetText(ads.memo):gsub("\s", ""):gsub("#%x%x%x%x%x%x", ""):gsub("\n", "") == 0 then return exports.titan_noti:showBox("Nie możesz wysłać pustej reklamy!") end
		guiSetVisible(ads.window, false)
		exports.titan_cursor:hideCustomCursor("newsClientAds")
		triggerServerEvent("addAd", localPlayer, getElementData(localPlayer, "minutes"), getElementData(getElementData(localPlayer, "reporter"), "name").." "..getElementData(getElementData(localPlayer, "reporter"), "lastname"), guiGetText(ads.memo):gsub("\n", " "))
		setElementData(localPlayer, "reporter", nil)
		setElementData(localPlayer, "minutes", nil)
		guiSetText(ads.memo, "")
	end
end

addEventHandler("onClientGUIClick", root, function()
	if source == ads.button then
	showAdGUI()
	end
end)
addEvent("showAdGUI", true)
addEventHandler("showAdGUI", getRootElement(), showAdGUI)