----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

-- Custom Sound Streamer by Kubas
-- Version 1.0

soundStreamerFunc = {}
soundStreamer = {}
streamedSounds = {}
--[[
-
- element sound 		@-- playSound, jeśli streamowalny
- Vector3 pos 			@-- pozycja dźwięku
- string effect 		@-- nałożony efekt
- string file			@-- file/url
- float streamDistance 	@-- zasięg streamowania
- float hearDistance 	@-- zasięg słyszenia
- float volume			@-- głośność dźwięku (0.0 - 1.0)
- element parent 		@-- parent dźwięku
- int looped 			@-- czy dźwięk jest zloopowany
- int interior			@-- interior
- int dimension 		@-- virtualworld
- 
]]

function findRotation( x1, y1, x2, y2 ) 
    local t = -math.deg( math.atan2( x2 - x1, y2 - y1 ) )
    return t < 0 and t + 360 or t
end

function soundStreamerFunc.getFreeSoundStreamerID()
	local i = 1
	while true do
		if type(soundStreamer[i]) ~= "table" then return i end
		i = i + 1
	end
end

function soundStreamerFunc.create3DSound(data, loop, vPos, eff, streamDist, hearDist, vol, par, int, dim, length)
	local index = soundStreamerFunc.getFreeSoundStreamerID()
	if isElement(par) then
		vPos = par:getPosition()
	end
	soundStreamer[index] =
	{
		sound = nil,
		pos = vPos,
		effect = eff,
		file = data,
		streamDistance = streamDist,
		hearDistance = hearDist,
		volume = vol,
		parent = par,
		looped = loop,
		interior = int,
		dimension = dim,
		isAudioCreated = false
	}
	if length then
		soundStreamer[index].stopTimer = setTimer(soundStreamerFunc.destroy3DSound, length, 1, index)
	end
	outputDebugString(string.format("[SOUNDS][DEBUG] Dźwięk o ID %d został stworzony.", index))
	soundStreamerFunc.streamPosition()
	return index
end

function soundStreamerFunc.destroy3DSound(index)
	if type(soundStreamer[index]) == "table" then
		if streamedSounds[index] then streamedSounds[index] = nil end
		if isTimer(soundStreamer[index].stopTimer) then killTimer(soundStreamer[index].stopTimer) end
		if isElement(soundStreamer[index].sound) then destroyElement(soundStreamer[index].sound) end
		soundStreamer[index] = nil
		--outputDebugString(string.format("[SOUNDS][DEBUG] Dźwięk o ID %d został usunięty.", index))
		return true
	end
	return false
end

function soundStreamerFunc.streamPosition()
	local playerPos = localPlayer:getPosition()
	local dimension = localPlayer:getDimension()
	local interior = localPlayer:getInterior()
	for k, v in pairs(soundStreamer) do
		if v and type(v) == "table" then
			local interiorAndDimension = false
			if isElement(v.parent) then
				if v.parent:getInterior() == interior and v.parent:getDimension() == dimension then interiorAndDimension = true end
			else
				if v.interior == interior and v.dimension == dimension then interiorAndDimension = true end
			end
			if getDistanceBetweenPoints3D(playerPos, v.pos) > v.streamDistance or not interiorAndDimension then
				if streamedSounds[k] then
					streamedSounds[k] = nil
					--outputDebugString(string.format("[SOUNDS][DEBUG] Dźwięk o ID %d został odstreamowany.", k))
					if isElement(v.sound) then destroyElement(v.sound) end
				end
			else
				if not streamedSounds[k] then
					streamedSounds[k] = true
					--outputDebugString(string.format("[SOUNDS][DEBUG] Dźwięk o ID %d został zestreamowany.", k))
				end
			end
		end
	end
end
setTimer(soundStreamerFunc.streamPosition, 500, 0)
--addEventHandler("onClientRender", root, soundStreamerFunc.streamPosition)

function soundStreamerFunc.streamSound()
	local playerPos = localPlayer:getPosition()
	local playerRot = localPlayer:getRotation()
	for k, v in pairs(streamedSounds) do
		if k and v then
			if type(soundStreamer[k]) == "table" and soundStreamer[k].file then
				if not isElement(soundStreamer[k].sound) then
					if not soundStreamer[k].isAudioCreated then
						if not soundStreamer[k].file then return end
						soundStreamer[k].sound = playSound(soundStreamer[k].file, soundStreamer[k].looped)
						if isElement(soundStreamer[k].sound) then
							soundStreamer[k].isAudioCreated = true
							if type(soundStreamer[k].effect) == "table" then
								for i = 1, #soundStreamer[k].effect do
									setSoundEffectEnabled(soundStreamer[k].sound, soundStreamer[k].effect[i], true)
								end
							end
							if not soundStreamer[k].parent then
								setElementInterior(soundStreamer[k].sound, soundStreamer[k].interior)
								setElementDimension(soundStreamer[k].sound, soundStreamer[k].dimension)
							end
							local distance = getDistanceBetweenPoints3D(playerPos, soundStreamer[k].pos)
							local progress = (soundStreamer[k].hearDistance - distance) / soundStreamer[k].hearDistance
							if progress < 0 then progress = 0 elseif progress > 1 then progress = 1 end
							setSoundVolume(soundStreamer[k].sound, progress * soundStreamer[k].volume)
						end
					else
						soundStreamerFunc.destroy3DSound(k)
					end
				else
					local distance = getDistanceBetweenPoints3D(playerPos, soundStreamer[k].pos)
					local progress = (soundStreamer[k].hearDistance - distance) / soundStreamer[k].hearDistance
					if progress < 0 then progress = 0 elseif progress > 1 then progress = 1 end
					setSoundVolume(soundStreamer[k].sound, progress * soundStreamer[k].volume)
					--[[local rot = findRotation(playerPos.x, playerPos.y, soundStreamer[k].pos.x, soundStreamer[k].pos.y)
					local _rot = rot
					local _r = playerRot.z
					local lewo = false
					if rot > 180 then rot = rot - 180 elseif rot < -180 then rot = rot + 180 end
					if playerRot.z > 180 then playerRot.z = playerRot.z - 180 elseif playerRot.z < -180 then playerRot.z = playerRot.z + 180 end
					local roznica = math.abs(rot - playerRot.z)
					if roznica > 90 then roznica = roznica - (roznica - 90) end
					if _rot >= 0 and _rot < 180 then
						if _r >= 180 and _r < 360 then lewo = true else lewo = false end
					elseif _rot >= 180 and _rot < 360 then
						if _r >= 180 and _r < 360 then lewo = true else lewo = false end
					end
					if (_rot >= 270 and _rot <= 360) or (_rot >= 0 and _rot <= 90) then
						if _r >= 180 and _r < 360 then lewo = true else lewo = false end
					else
						if _r >= 90 and _r < 180 then lewo = true else lewo = false end
						lewo = not lewo
					end
					outputChatBox(string.format("%0.f", roznica))
					outputChatBox(lewo and "lewo" or "prawo")]]

					if soundStreamer[k].parent then
						if isElement(soundStreamer[k].parent) then
							soundStreamer[k].pos = soundStreamer[k].parent:getPosition()
							setElementInterior(soundStreamer[k].sound, soundStreamer[k].parent:getInterior())
							setElementDimension(soundStreamer[k].sound, soundStreamer[k].parent:getDimension())
						else
							soundStreamerFunc.destroy3DSound(k)
						end
					end

				end
			end
		end
	end
end
setTimer(soundStreamerFunc.streamSound, 100, 0)
--addEventHandler("onClientRender", root, soundStreamerFunc.streamSound)
outputDebugString("[SOUNDS] Custom 3D Sound Streamer by Kubas loaded.")

function testReverse(data)
	if data > 0 then
			data = -(360 - data)
		elseif data < 0 then
			data = data + 360
		elseif data == 0 then
			data = 360
		elseif data == 360 then
			data = 0
		end
		return data
end

create3DSound = soundStreamerFunc.create3DSound
destroy3DSound = soundStreamerFunc.destroy3DSound