----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local Time = getTickCount(  )
local realRainLevel = 0
local allowChanges
local wasToggled
local isToggled
local celsius = 20
local Weathertable = {}
Weathertable[1] = {}
Weathertable[2] = false

local weather = {
	sunny = {0, 1, 10, 11, 17, 18},
	clouds = {2, 3, 4, 5, 6, 7},
	fog = {9},
	stormy = {8},
	rainy = {16},
	dull = {12, 13, 14, 15}
}

local citys = {
["Los Santos"]	= 1,
["Red County"] = 2,
["Flint County"] = 3,
["Whetstone"] = 4,
["San Fierro"] = 5,
["Tierra Robada"] = 6,
["Bone County"] = 7,
["Las Venturas"] = 8
}

function updateWeather(data)
Weathertable[1] = data
end
addEvent( "updateWeather", true )
addEventHandler( "updateWeather", root, updateWeather )

function updateRainLevel(rainLevel)
if (isToggled) then setRainLevel(0) return end
	realRainLevel = rainLevel
	setRainLevel(realRainLevel)
end

function setWeatherEx(str, rain, level, wave)
	local newWeather = weather[str][1]

	if (newWeather == 8) or (newWeather == 16) then
		local month = getRealTime().month
		if (month == 10) or (month == 11) or (month == 0) then
			newWeather = math.random(12,15)
			--setWeather(newWeather)
			setWeatherBlended ( newWeather )
		else
			setWeatherBlended ( newWeather )
			--setWeather(newWeather)
		end
	else
		setWeatherBlended ( newWeather )
		--setWeather(newWeather)
	end
	
	setRainLevel((rain and rain or 0))
	--setWaterLevel((level and level or 0))
	setWaveHeight((wave and wave or 0.5))
	
	for i,v in ipairs(getElementsByType("player")) do
		updateRainLevel( rain and rain or 0 )
		local _str = str
		local target
		local celsius = tonumber(math.ceil(celsius))
		
		if (str == "clouds") then _str = "cloudy"
		elseif (str == "fog") then _str = "foggy"
		end
		
		if (celsius >= -30) and (celsius <= -21) then
			target = "very freezing"
		elseif (celsius >= -20) and (celsius <= -11) then
			target = "freezing"
		elseif (celsius >= -10) and (celsius <= 0) then
			target = "cold"
		elseif (celsius >= 1) and (celsius <= 15) then
			target = "chilly"
		elseif (celsius >= 16) and (celsius <= 20) then
			target = "somewhat balanced"
		elseif (celsius >= 21) and (celsius <= 24) then
			target = "warm"
		elseif (celsius >= 25) and (celsius <= 30) then
			target = "hot"
		elseif (celsius >= 31) and (celsius <= 36) then
			target = "very hot"
		elseif (celsius >= 37) and (celsius <= 45) then
			target = "dangerously hot"
		end
	end
	outputDebugString("Zmiana ustawien pogody: "..newWeather.." ( "..str.." ) i "..celsius.." stopni celsjusza, predkosc wiatru: "..windvel.." "..string.upper(winddir) )
end

function setWeatherFromRemote(data)
	local weather_, celsius_, windvel_, winddir_, name_ = data[1], data[2], data[3], data[4], data[5]
	if (weather_ == nil) or (celsius_ == nil) then
		outputDebugString("Wystąpił błąd podczas pobierania pogody!", 2)
	else
		celsius = celsius_
		windvel = windvel_
		winddir = winddir_
		outputDebugString("Pogoda API: pobrano pogode z "..name_, 3)
		
		if (weather_ == "sky is clear") or (weather_ == "few clouds") or (weather_ == "scattered clouds") or (weather_ == "broken clouds") or (weather_ == "cold") or (weather_ == "hot") then
			setWeatherEx("sunny")
		elseif (weather_ == "overcast clouds") then
			setWeatherEx("clouds")
		elseif (weather_ == "light rain") then
			setWeatherEx("rainy", 0.8, 0.07)
		elseif (weather_ == "moderate rain") or (weather_ == "hail") then
			setWeatherEx("rainy", 1.0, 0.1, 0.8)
		elseif (weather_ == "heavy intensity rain") then
			setWeatherEx("rainy", 1.2, 0.35, 1.0)
		elseif (weather_ == "very heavy rain") then
			setWeatherEx("rainy", 1.4, 1.0, 1.6)
		elseif (weather_ == "extreme rain") or (weather_ == "tropical storm") then
			setWeatherEx("rainy", 1.6, 2.5, 2.0)
		elseif (weather_ == "freezing rain") or (weather_ == "hurricane") then
			setWeatherEx("rainy", 1.8, 4.0, 2.3)
		elseif (weather_ == "light intensity shower rain") then
			setWeatherEx("rainy", 0.75)
		elseif (weather_ == "shower rain") then
			setWeatherEx("rainy", 0.9)
		elseif (weather_ == "heavy intensity shower rain") then
			setWeatherEx("rainy", 0.8)
		elseif (weather_ == "light intensity drizzle") then
			setWeatherEx("rainy", 0.1)
		elseif (weather_ == "drizzle") then
			setWeatherEx("rainy", 0.2)
		elseif (weather_ == "heavy intensity drizzle") then
			setWeatherEx("rainy", 0.35)
		elseif (weather_ == "drizzle rain") then
			setWeatherEx("rainy", 0.4)
		elseif (weather_ == "heavy intensity drizzle rain") then
			setWeatherEx("rainy", 0.55)
		elseif (weather_ == "shower drizzle") then
			setWeatherEx("rainy", 0.62)
		elseif (weather_ == "thunderstorm with light rain") then
			setWeatherEx("stormy", 0.66, 0.2, 0.8)
		elseif (weather_ == "thunderstorm with rain") then
			setWeatherEx("stormy", 1.0, 0.4, 1.2)
		elseif (weather_ == "thunderstorm with heavy rain") then
			setWeatherEx("stormy", 1.2, 0.75, 1.4)
		elseif (weather_ == "light thunderstorm") or (weather_ == "thunderstorm") or (weather_ == "heavy thunderstorm") or (weather_ == "ragged thunderstorm") then
			setWeatherEx("stormy", 0)
		elseif (weather_ == "thunderstorm with light drizzle") then
			setWeatherEx("stormy", 0.1)
		elseif (weather_ == "thunderstorm with drizzle") then
			setWeatherEx("stormy", 0.2)
		elseif (weather_ == "thunderstorm with heavy drizzle") then
			setWeatherEx("stormy", 0.35)
		elseif (weather_ == "mist") or (weather_ == "smoke") or (weather_ == "fog") then
			setWeatherEx("fog")
		elseif (weather_ == "Sand/Dust Whirls") or (weather_ == "haze") or (weather_ == "tornado") or (weather_ == "windy") then
			setWeatherEx("dull", 0.2, 2.1)
		else
			setWeatherEx("sunny")
		end
		
		if (winddir_ == "SSE") or (winddir_ == "SE") then
			setWindVelocity(windvel_, -windvel_, windvel_)
		elseif (winddir_ == "NNE") or (winddir_ == "NE") then
			setWindVelocity(windvel_, windvel_, windvel_)
		elseif (winddir_ == "NNW") or (winddir_ == "NW") then
			setWindVelocity(-windvel_, windvel_, windvel_)
		elseif (winddir_ == "SSW") or (winddir_ == "SW") then
			setWindVelocity(-windvel_, -windvel_, windvel_)
		elseif (winddir_ == "S") then
			setWindVelocity(0.1, -windvel_, windvel_)
		elseif (winddir_ == "N") then
			setWindVelocity(0.1, windvel_, windvel_)
		elseif (winddir_ == "E") then
			setWindVelocity(windvel_, 0.1, windvel_)
		elseif (winddir_ == "W") then
			setWindVelocity(0.1, windvel_, windvel_)
		else
			setWindVelocity(0.3, 0.3, 0.3)
		end
	end
end

addEventHandler("onClientRender", getRootElement(), function()
	if getElementInterior( localPlayer ) == 0 then
		if type(Weathertable[1]) == "table" and getElementData(localPlayer,"loggedIn") == 1 then
			local x, y, z = getElementPosition( localPlayer )
			local name = citys[getZoneName ( x, y, z, true )]
			local data = Weathertable[1][tonumber(name)]
			local pdata = Weathertable[2]
			if not(pdata) and not(name == "unkown") and not(data == nil) then
				Weathertable[2] = Weathertable[1][tonumber(name)]
				setWeatherFromRemote(data)
			elseif pdata and data and ( not(data[1] == pdata[1]) or not(data[2] == pdata[2]) or not(data[3] == pdata[3]) or not(data[4] == pdata[4]) ) then
				setWeatherFromRemote(data)
				Weathertable[2] = Weathertable[1][tonumber(name)]
			end
		end
	end
end)