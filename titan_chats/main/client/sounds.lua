----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:45:54
-- Ostatnio zmodyfikowano: 2016-01-09 15:45:56
----------------------------------------------------

function playWhisperAudio()
	local sound = playSound("main/client/pwSound.mp3", false)
	setSoundVolume(sound, 0.5)
end
addEvent("playWhisperAudio", true)
addEventHandler("playWhisperAudio", root, playWhisperAudio)

function playWhisperAudio2()
	playSound("main/client/pwSound2.mp3", false)
end
addEvent("playWhisperAudio2", true)
addEventHandler("playWhisperAudio2", root, playWhisperAudio2)