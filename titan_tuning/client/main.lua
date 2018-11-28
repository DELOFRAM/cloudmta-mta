local sW, sH = guiGetScreenSize()
func = {}
data = {}
renderData = {}

function func.finish(sucess)
	if sucess and renderData.type == "set" then
		triggerServerEvent( "setVehicleComponentMain", getLocalPlayer(  ), getLocalPlayer(  ), true )
	elseif sucess and renderData.type == "remove" then
		triggerServerEvent( "removeVehicleComponentMain", getLocalPlayer(  ), getLocalPlayer(  ), true )
	elseif not sucess and renderData.type == "set" then
		triggerServerEvent( "setVehicleComponentMain", getLocalPlayer(  ), getLocalPlayer(  ), false )
	elseif not sucess and renderData.type == "remove" then
		triggerServerEvent( "removeVehicleComponentMain", getLocalPlayer(  ), getLocalPlayer(  ), false )	
	end
end

function func.renderBar()
	time = (getTickCount(  )-renderData.start)/(renderData.time*1000)
	local progress = interpolateBetween(0, 0, 0, 100, 0, 0, time, "Linear") 	
	local width = interpolateBetween(0, 0, 0, 303, 0, 0, time, "Linear") 	
	dxDrawImageSection(sW / 2 - 151, 128, width, 8, 0, 0, 303 * progress, 8, "client/files/status.png", 0, 0, 0, tocolor(255, 255, 255, 255))
	dxDrawImage(sW / 2 - 160, 120, 320, 24, "client/files/status_obrys.png")
	if progress == 100 then
		func.finish(true)
		removeEventHandler("onClientRender", root, func.renderBar)
	elseif not isElement(renderData.data.vehicle) or not isElement(renderData.data.target) then
		func.finish(false)
		removeEventHandler("onClientRender", root, func.renderBar)
	end
end

function func.ProgressComponentVehicle(player, data, time, type)
	renderData.data = data
	renderData.time = time
	renderData.start = getTickCount(  )
	renderData.type = type
	addEventHandler("onClientRender", root, func.renderBar)
end
addEvent("ProgressEventComponent", true)
addEventHandler("ProgressEventComponent", root, func.ProgressComponentVehicle)
