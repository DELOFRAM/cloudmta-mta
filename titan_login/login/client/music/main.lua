----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

-- Start music
local startMusic = false
local startMusicFading = false
local startMusicVolume = 0.5

function soundMusic()
	local progress = (getTickCount() - startMusicFading) / 2000
	volume = interpolateBetween(startMusicVolume, 0, 0, 0, 0, 0, progress, "Linear")
	setSoundVolume(startMusic, volume)
	if(progress >= 1) then
		destroyElement(startMusic)
		startMusic = false
		startMusicFading = false
		removeEventHandler("onClientRender", root, soundMusic)
	end
end

function playStartMusic()
	if(isElement(startMusic)) then
		destroyElement(startMusic)
	end
	startMusic = playSound("login/client/music/startMusic5.mp3", true)
	setSoundVolume(startMusic, startMusicVolume)
end

function stopStartMusic()
	if(not startMusic) then return end
	if(startMusicFading ~= false) then return end
	startMusicFading = getTickCount()
	addEventHandler("onClientRender", root, soundMusic)
end