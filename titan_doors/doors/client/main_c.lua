----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local function bindKeyToEntryDoor()
	if isChatBoxInputActive() then return end
	if getElementData(localPlayer, "adminFly") and getElementData(localPlayer, "nearestDoorID") then return exports.titan_noti:showBox("Nie możesz poruszać się między interiorami z włączonym Admin Fly'em!") end
	if(not isPedInVehicle(localPlayer)) then
		if(not getElementData(localPlayer, "enteringDoor")) then
			local nearestDoorID = getElementData(localPlayer, "nearestDoorID")
			local nearestDoorType = getElementData(localPlayer, "nearestDoorType")

			if(tonumber(nearestDoorType) and tonumber(nearestDoorID)) then
				triggerServerEvent("playerEntryInDoor", localPlayer, localPlayer, nearestDoorID, nearestDoorType, false)
			end
		end
	else
		if not localPlayer:getData("enteringDoor") then
			local nearestDoorID = getElementData(localPlayer, "nearestDoorID")
			local nearestDoorType = getElementData(localPlayer, "nearestDoorType")
			
			if tonumber(nearestDoorType) and tonumber(nearestDoorID) then
				triggerServerEvent("playerEntryInDoor", localPlayer, localPlayer, nearestDoorID, nearestDoorType, true)
			end
		end
	end
end
bindKey("e", "up", bindKeyToEntryDoor)

local function bindKeyToCloseOpenDoor()
	if isChatBoxInputActive() then return end
	if(not isPedInVehicle(localPlayer)) then
		if(not getElementData(localPlayer, "enteringDoor")) then
			local nearestDoorID = getElementData(localPlayer, "nearestDoorID")
			local nearestDoorType = getElementData(localPlayer, "nearestDoorType")

			if(tonumber(nearestDoorType) and tonumber(nearestDoorID)) then
				if not isChatBoxInputActive() then
					triggerServerEvent("onPlayerTriedToOpenDoor", localPlayer, localPlayer)
				end
			end
		end
	end
end
bindKey("r", "up", bindKeyToCloseOpenDoor)
local sW, sH = guiGetScreenSize()
local font = dxCreateFont("doors/client/files/font.otf", 14)
local renderInfo = 
{
	toggle = false,
	doorName = "",
	doorLocked = false
}
function renderDoorInfo()
	if not getElementData(localPlayer, "nearestDoorID") then return end
	if(renderInfo.toggle) then
		local image = "doors/client/files/doorsOpenBg.png"
		if(renderInfo.doorLocked) then
			image = "doors/client/files/doorsCloseBg.png"
		end
		dxDrawImage(sW / 2 - 233, sH - 300, 466, 265, image)
		dxDrawText(renderInfo.doorName, sW / 2 - 233, sH - 160, sW / 2 + 233, sH - 140, tocolor(255, 255, 255, 255), 1.0, font, "center", "center", false, false,  false, true, false, 0, 0, 0)
	end
end
addEventHandler("onClientRender", root, renderDoorInfo)

function onVehicleStartEnter()
	if renderInfo.toggle then renderInfo.toggle = false return end
end
addEventHandler("onClientVehicleStartEnter", root, onVehicleStartEnter)

function giveDataFromServerAboutDoorInfo(data)
	if(data.toggle == false) then
		renderInfo.toggle = false
	else
		renderInfo = data
	end
end
addEvent("giveDataFromServerAboutDoorInfo", true)
addEventHandler("giveDataFromServerAboutDoorInfo", root, giveDataFromServerAboutDoorInfo)