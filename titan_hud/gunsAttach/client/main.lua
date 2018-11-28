----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local streamedClients 	= {}
local weaponObjects = {}
streamedClients[localPlayer] = true
function getWeaponModel(weaponid)
	if(weaponid == 1) then return 331 end --kastet
	if(weaponid == 2) then return 333 end --kij golfowy
	if(weaponid == 3) then return 334 end --pałka policyjna
	if(weaponid == 4) then return 335 end --nóz
	if(weaponid == 5) then return 336 end --kij do baseballa
	if(weaponid == 6) then return 337 end --łopata
	if(weaponid == 7) then return 338 end --kij bilardowy
	if(weaponid == 8) then return 339 end --katana
	if(weaponid == 9) then return 341 end --piła
	if(weaponid >= 22 and weaponid <= 29) then return tonumber(weaponid) + 324 end
	if(weaponid == 30 or weaponid == 31) then return tonumber(weaponid) + 325 end
	if(weaponid == 32) then return 372 end
	if(weaponid >= 33 and weaponid <= 45) then return tonumber(weaponid) + 324 end
	if(weaponid == 16) then return 342 end --granat
	if(weaponid == 17) then return 343 end --gaz łzawiący
	if(weaponid == 18) then return 344 end --koktajl
	if(weaponid == 10) then return 321 end --dildo
	if(weaponid == 11) then return 322 end --dildo
	if(weaponid == 12) then return 323 end --wibrator
	if(weaponid == 14) then return 325 end --kwiatki
	if(weaponid == 15) then return 326 end --laska
	return false
end

function mainFunc()
	setTimer(checkWeapons, 100, 0)
	weaponObjects[localPlayer] = {}
end
addEventHandler("onClientResourceStart", resourceRoot, mainFunc)

function rebuildPlayerData()
	--[[local tmpTable = {}
	for i = 1, 11 do
		local pedWeapon = getPedWeapon(localPlayer, i)
		if(pedWeapon == 0) then
			tmpTable[i] = 0 
		else
			if(getPedTotalAmmo(localPlayer, i) <= 0) then tmpTable[i] = 0 else
				tmpTable[i] = pedWeapon 
			end
		end
	end
	if getElementData(localPlayer, "weaponsAttach") ~= tmpTable then
		setElementData(localPlayer, "weaponsAttach", tmpTable)
	end]]
	for k, v in ipairs(getElementsByType("player")) do
		local weaponTable = {}
		for i = 1, 11 do
			local pedWeapon = getPedWeapon(v, i)
			if pedWeapon == 0 then 
				weaponTable[i] = 0
			else
				if getPedTotalAmmo(v, i) and getPedTotalAmmo(v, i) <= 0 then
					weaponTable[i] = 0
				else
					weaponTable[i] = pedWeapon
				end
			end
		end
		setElementData(v, "weaponsAttach", weaponTable, false)
	end

end
--setTimer(rebuildPlayerData, 1000, 0)

function onElementStreamIn()
	if(getElementType(source) == "player") then
		streamedClients[source] = true
		weaponObjects[source] = {}
	end
end
addEventHandler("onClientElementStreamIn", root, onElementStreamIn)

function onElementStreamOut()
	if(getElementType(source) == "player") then
		if(type(weaponObjects[source]) == "table") then
			for k, v in pairs(weaponObjects[source]) do
				if(isElement(v)) then
					destroyElement(v)
				end
			end
			weaponObjects[source] = nil
		end
		streamedClients[source] = nil
	end
end
addEventHandler("onClientElementStreamOut", root, onElementStreamOut)

function checkWeapons()
	rebuildPlayerData()
	for player in pairs(streamedClients) do
		if(not isElement(player)) then
			if(type(weaponObjects[player]) == "table") then
				for k, v in pairs(weaponObjects[player]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				weaponObjects[player] = nil
			end
			streamedClients[player] = nil
			return
		end
		local weaponsData = getElementData(player, "weaponsAttach")
		local currentWeapon = getPedWeapon(player)
		if(type(weaponsData) == "table") then
			for i = 1, 11 do
				if(tonumber(weaponsData[i]) and tonumber(weaponsData[i]) > 0) then
					if(isElement(weaponObjects[player][i])) then
						if(weaponsData[i] == currentWeapon) then
							destroyElement(weaponObjects[player][i])
						end
					else
						if(not isElement(weaponObjects[player][i]) and weaponsData[i] ~= currentWeapon) then
							local x, y, z = getElementPosition(player)
							local weaponModel = weaponsData[i]
							weaponObjects[player][i] = createObject(getWeaponModel(weaponModel), x, y, z)
							setElementData(weaponObjects[player][i], "player", player)
							setElementDimension(weaponObjects[player][i], getElementDimension(player))
							setElementInterior(weaponObjects[player][i], getElementInterior(player))
							setElementCollisionsEnabled(weaponObjects[player][i], false)
							if(getSlotFromWeapon(weaponModel) == 2) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 14, 0.1, 0, -0.05, 0, -90, 90, 0)
							elseif(getSlotFromWeapon(weaponModel) == 5 or getSlotFromWeapon(weaponModel) == 3) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 3, 0.19, -0.1, -0.15, 0, -90, 0)
							elseif(getSlotFromWeapon(weaponModel) == 6) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 3, -0.18, -0.05, -0.3, -5, -90, 180)
							elseif(getSlotFromWeapon(weaponModel) == 4) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 13, -0.1, 0, 0.05, 0, -90, 90, 0)
							elseif(getSlotFromWeapon(weaponModel) == 7) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 3, -0.1, 0, 0.05, 0, -90, 90, 0)
							elseif(getSlotFromWeapon(weaponModel) == 1) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 14, 0.13, -0.15, -0.1, 0, 0, 90, 0)
							elseif(getSlotFromWeapon(weaponModel) == 9) then
								exports.titan_boneAttach:attachElementToBone(weaponObjects[player][i], player, 14, 0.13, -0.15, -0.1, 0, 0, 90, 0)
							end
						else
							if(isElement(weaponObjects[player][i])) then
								setElementDimension(weaponObjects[player][i], getElementDimension(player))
								setElementInterior(weaponObjects[player][i], getElementInterior(player))
							end
						end
					end
				else
					if(type(weaponObjects[player]) == "table") then
						if(isElement(weaponObjects[player][i])) then
							destroyElement(weaponObjects[player][i])

							for k, v in ipairs(getElementsByType("object", resourceRoot)) do
								if(getElementData(v, "player") == player) then
									destroyElement(v)
								end
							end
						end
					end
				end
			end
		else
			if(type(weaponObjects[player]) == "table") then
				for k, v in pairs(weaponObjects[player]) do
					if(isElement(v)) then
						destroyElement(v)
					end
				end
				weaponObjects[player] = nil
			end
		end
	end
end
