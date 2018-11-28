----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local function setTimeOnServerStart()
	setMinuteDuration(60000)
	local time = getRealTime()
	setTime(time.hour, time.minute)
	setWeather(10)
end
addEventHandler("onResourceStart", resourceRoot, setTimeOnServerStart)

local weatherAPI = "https://cmta.pl/weather.php"

function updateWeathertFromRemote(data)
	outputDebugString("Pogoda API zaktualizowana.")
	triggerClientEvent(getRootElement(  ), "updateWeather", getRootElement(  ), data )
end

function updateWeather()
	callRemote(weatherAPI, updateWeathertFromRemote)
end

addEventHandler("onResourceStart", resourceRoot, function()
	setTimer(updateWeather, 1000, 1)
	setTimer(updateWeather, 60000*30, 0)
end)

addEventHandler( "onPlayerJoin", getRootElement(  ), function()
	--setTimer(updateWeather, 1000, 1)
end)