----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local renderedPlayers = {}
function onElementStreamIn()
	if(getElementType(source) == "player" or getElementType(source) == "ped") then
		if(not renderedPlayers[source]) then
			renderedPlayers[source] = true
		end
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)
--localPlayer:setData("previewDesc", true)

local function onResStart()
	for k, v in ipairs(getElementsByType("player")) do
		if(isElementStreamedIn(v)) then
			renderedPlayers[v] = true
		end
	end
	for k, v in ipairs(getElementsByType("ped")) do
		if(isElementStreamedIn(v)) then
			renderedPlayers[v] = true
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)

function onElementStreamOut()
	if(getElementType(source) == "player" or getElementType(source) == "ped") then
		if(renderedPlayers[source]) then
			renderedPlayers[source] = false
		end
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

local faceCodes = {}

function getNickFromFaceCode(faceCode)
	for k, v in pairs(faceCodes) do
		if(string.upper(tostring(k)) == string.upper(tostring(faceCode))) then
			return tostring(v)
		end
	end
	return false
end

local font = dxCreateFont("playerNames/font/MyriadPro-Bold.otf", 20)
local MAXDIST = 20
local sW, sH = guiGetScreenSize()
local iconSize = 48
function renderNicknames()

	--------------------
	-- RENDER OBRAŻEŃ --
	--------------------

	if getElementData(localPlayer, "damageColorNick") then
		local time = getElementData(localPlayer, "damageColorNickTime")
		if(tonumber(time)) then
			local progress = (getTickCount() - time) / 1000
			if(progress > 0 and progress < 1) then
				local alpha = interpolateBetween(255, 0, 0, 0, 0, 0, progress, "Linear")
				dxDrawImage(0, 0, sW, sH, "playerNames/client/dmg.png", 0, 0, 0, tocolor(255, 255, 255, alpha))
				
			end
		end
	end
	if localPlayer:getData("hide:playerNames") then return end
	local camX, camY, camZ = getCameraMatrix()
	for v in pairs(renderedPlayers) do
		if(isElement(v)) then
		    if v ~= localPlayer or (v == localPlayer and getElementData(v, "previewDesc") ) then
				if(getElementData(v, "loggedIn") == 1 or getElementType(v) == "ped") then
					if not v:getData("specData") then
						local valX, valY, valZ = getPedBonePosition(v, 8)
						local distance = getDistanceBetweenPoints3D(camX, camY, camZ, valX, valY, valZ)
						local progress = distance / MAXDIST

						-- BEGIN darkWindows --
							local visible = true
							if isPedInVehicle(v) then
								local veh = getPedOccupiedVehicle(v)
								if isElement(veh) and veh:getData("vehDarkWindows") == 1 then
									if isPedInVehicle(localPlayer) then
										local veh2 = getPedOccupiedVehicle(localPlayer)
										if isElement(veh2) then
											if veh == veh2 then visible = true else visible = false end
										end
									else visible = false end
								end
							end
						-- darkWindows END --

						if progress < 1 and visible and v:getAlpha() > 0 then
							if not processLineOfSight(camX, camY, camZ, valX, valY, valZ, true, true, false, true, true, false, false, false, isPedInVehicle(v) and getPedOccupiedVehicle(v) or v) then
								local screenW, screenH = getScreenFromWorldPosition (valX, valY, valZ + 0.3, 10, false)
								if(screenW and screenH) then

									local r, g, b = 255, 255, 255

									local _screenW = screenW
									local nickname = v:getType() == "ped" and (v:getData("name") or "PED") or not v:getData("mask") and v:getData("name").." "..v:getData("lastname") or "Nieznajomy "..v:getData("shortDNA")
									local admin = getElementData(v, "adminDuty")
									local newPlayer = v:getData("isNewPlayer")
									local adminName = ""
									local adminColor = ""
									local screenW3, screenH3
									if admin then
										nickname = getElementData(v, "globalName")
										adminColor = exports.titan_misc:getAdminRank(v:getData("adminLevel"))
										adminName = adminColor.name
										adminColor = "#"..adminColor.color
									end

									

									local alpha, scale, scaleBig = interpolateBetween(200, 0.7, 0.6, 0, 0.5, 0.4, progress, "Linear")
									local scale2 = scale / 1.5

									local stany = v:getType() == "ped" and "" or string.format("ID: %s", v:getData("mask") and not localPlayer:getData("adminDuty") and "?" or v:getData("playerID"))
									



									local armor = getPedArmor(v)
									if armor > 0 then
										stany = string.format("%s, kamizelka", stany)
									end
									if v:getData("gloves") then
										stany = string.format("%s, rękawiczki", stany)
									end
									--if v:getData("belts") then
									--	stany = string.format("%s, pasy", stany)
									--end
									if v:getData("arestTime") and v:getData("arrestTime") > 0 then
										stany = string.format("%s, areszt", stany)
									end
									if tonumber(v:getData("ajTime")) and v:getData("ajTime") > 0 then
										stany = string.format("%s, AdminJail", stany)
									end
									if v:getData("bwTime") and v:getData("bwTime") > 0 then
										r, g, b = 160, 160, 160
										if v:getData("damageType") == 2 then stany = string.format("%s, nieprzytomny", stany)
										elseif v:getData("damageType") == 3 then stany = string.format("%s, nieprzytomny", stany)
										else stany = string.format("%s, oszołomiony", stany) end
									else
										if v:getData("damageType") == 3 then stany = string.format("%s, ranny", stany) end
									end

									if getElementData(v, "groupDutyID") and getElementData(v, "groupDutyTagOn") then
										local dutyColor = getElementData(v, "groupDutyColor")
										local dutyTag = getElementData(v, "GroupDutyTag")
										if dutyColor and dutyTag then
											dutyColor = rgbToHex({r = dutyColor[1], g = dutyColor[2], b = dutyColor[3]})
											stany = string.format("%s, #%s %s#FFFFFF", stany, dutyColor, dutyTag)
										end
									end
									
									if tonumber(getElementData(v, "hungryLevel")) and getElementData(v, "hungryLevel") <= 5 then
										stany = string.format("%s, wygłodzony", stany)
									end

									local fontWidth = dxGetTextWidth(nickname, scale, font)
									local fontWidth2 = dxGetTextWidth(string.gsub(string.format("(%s)", stany),"#%x%x%x%x%x%x",""), scale2, font)
									local fontHeight = dxGetFontHeight(scale, font)
									screenW = screenW - (fontWidth / 2)
									screenH = screenH - 30

									local screenW2 = _screenW - (fontWidth2 / 2)
									local screenH2 = screenH + fontHeight - 3

									if(getElementData(v, "damageColorNick")) then
										r, g, b = 255, 0, 0
									end

									if admin then
										local fontWidth3 = dxGetTextWidth(adminName, scale2, font)
										screenW3 = _screenW - (fontWidth3 / 2)
										screenH3 = screenH - fontHeight + 10
									end

									dxDrawText(nickname, screenW + 1, screenH + 1, 0, 0, tocolor(0, 0, 0, alpha), scale, font, "left", "top", false, true, false, true, true)
									dxDrawText(nickname, screenW, screenH, 0, 0, tocolor(r, g, b, alpha), scale, font, "left", "top", false, true, false, true, true)
									
									if newPlayer then
										if not newPlayerTimer then
											newPlayerTimer = getTickCount(  )
										end
										local status = "Oczekuje pomocy"
										local Time = getTickCount(  )-newPlayerTimer
										if Time > 1000 then
											newPlayerTimer = getTickCount(  )
										end	
										local progress = interpolateBetween(0, 0, 0, 0.1, 0 ,0, Time/1000, "Linear")
										local scale3 = scale2+progress
										local fontWidth3 = dxGetTextWidth(status, scale3, font)
										local r,g,b = 0,100,0
										screenW4 = _screenW - (fontWidth3 / 2)
										screenH4 = screenH + fontHeight + 15			
										dxDrawText(status, screenW4 + 1, screenH4 + 1, 0, 0, tocolor(0, 0, 0, alpha), scale3, font, "left", "top", false, true, false, true, true)
										dxDrawText(status, screenW4, screenH4, 0, 0, tocolor(r, g, b, alpha), scale3, font, "left", "top", false, true, false, true, true)
									end


									if v:getType() ~= "ped" then
										dxDrawText(string.format("(%s)", string.gsub(stany,"#%x%x%x%x%x%x","")), screenW2 + 1, screenH2 + 1, 0 ,0, tocolor(0, 0, 0, alpha), scale2, font, "left", "top", false, true, false, false, true)
										dxDrawText(string.format("(%s)", stany), screenW2, screenH2, 0 ,0, tocolor(255, 255, 255, alpha), scale2, font, "left", "top", false, true, false, true, true)
									end

									if admin then
										dxDrawText(adminName, screenW3 + 1, screenH3 + 1, 0 ,0, tocolor(0, 0, 0, alpha), scale2, font, "left", "top", false, true, false, true, true)
										dxDrawText(adminColor..adminName, screenW3, screenH3, 0 ,0, tocolor(255, 255, 255, alpha), scale2, font, "left", "top", false, true, false, true, true)
									end

									local imgTable = {}
									if v:getData("isAFK") then table.insert(imgTable, "playerNames/client/afk.png") end
									if v:getData("isPW") then table.insert(imgTable, "playerNames/client/pw.png") end
									if v:getData("chatTyping") then table.insert(imgTable, "playerNames/client/chatTyping.png") end
									if v:getData("phoneState") then table.insert(imgTable, "playerNames/client/phone.png") end
									if v:getData("belts") then table.insert(imgTable, "playerNames/client/belts.png") end
									if isElement(v:getData("cuffedBy")) then table.insert(imgTable, "playerNames/client/cuff.png") end

									local tempSize = iconSize * scaleBig
									local targetWidth = iconSize * #imgTable
									local imgTable2 = {}
									for k, v in ipairs(imgTable) do
										local width = iconSize * (k - 1)
										if k > 1 then width = width + 8 end
										dxDrawImage(_screenW + width * scaleBig - (targetWidth * scaleBig) / 2, screenH - tempSize - (admin and 25 * scaleBig or 0 * scaleBig), tempSize, tempSize, v, 0, 0, 0, tocolor(255, 255, 255, alpha))
									end

									--dxDrawText("(( Głos z radia: )) 046228 do 10-1, poszukiwany czarny Glendale, ostatnie 10-20 Idlewood, over.", _screenW - 20, screenH - tempSize - (admin and 25 * scaleBig or 0 * scaleBig) - (tempSize * 0.7), _screenW + 20, 0, tocolor(255, 255, 255, alpha), scale2, font, "center", "top", false, true, false, true, true)
								end
							end
						end
					end
				end
			end
		else
			renderedPlayers[v] = false
		end
	end
end
addEventHandler("onClientRender", root, renderNicknames)

function loadFaceCodesClient(data)
	for k, v in pairs(data) do
		faceCodes[k] = v
	end
end
addEvent("loadFaceCodesClient", true)
addEventHandler("loadFaceCodesClient", root, loadFaceCodesClient)

function loadFaceCodeClient(faceCode, name)
	faceCodes[faceCode] = name
end
addEvent("loadFaceCodeClient", true)
addEventHandler("loadFaceCodeClient", root, loadFaceCodeClient)

local damageTimer = false

function giveDamage(attacker, weapon, bodypart)
	if(getElementData(localPlayer, "bwTime") and getElementData(localPlayer, "bwTime") > 0) then return end

	if not isTimer(damageTimer) then
		setElementData(localPlayer, "damageColorNick", true)
		setElementData(localPlayer, "damageColorNickTime", getTickCount())
		damageTimer = setTimer(function() setElementData(localPlayer, "damageColorNick", false) end, 500, 1)
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, giveDamage)

function colorPlayer()
	setElementData(localPlayer, "damageColorNickTime", getTickCount())
end
addEvent("colorPlayer", true)
addEventHandler("colorPlayer", root, colorPlayer)

function decToHex(IN)
	if IN == 0 then return "00" end
	local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
	while IN>0 do
    	I=I+1
    	IN,D=math.floor(IN/B),math.fmod(IN,B)+1
    	OUT=string.sub(K,D,D)..OUT
	end
	if string.len(OUT) < 2 then
		if OUT == "A" then OUT = 10 
		elseif OUT == "B" then OUT = 11 
		elseif OUT == "C" then OUT = 12 
		elseif OUT == "D" then OUT = 13 
		elseif OUT == "E" then OUT = 14 
		elseif OUT == "F" then OUT = 15 end
		if tonumber(OUT) then OUT = string.format("%0.2d", OUT) end
	end
	return OUT
end

function rgbToHex(c)
	local output = decToHex(c["r"]) .. decToHex(c["g"]) .. decToHex(c["b"]);
	return output
end