----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

GAME_TYPE = "CloudMTA Titan Engine"

setDevelopmentMode(false)
setAmbientSoundEnabled("general", false)
setAmbientSoundEnabled("gunfire", false)
setPedTargetingMarkerEnabled(false)
setBirdsEnabled(false)
setBlurLevel(0)
setOcclusionsEnabled(false)
guiSetInputMode("no_binds_when_editing")
local sW, sH = guiGetScreenSize()
function renderServerInfo()
	local duties = {}
	if localPlayer:getData("premium") then 
		table.insert(duties, {name = "Konto Premium", color = {255, 215, 0}}) 
	end 
	if localPlayer:getData("adminDuty") then
		--table.insert(duties, {name = "Duty administratora", color = {255, 0, 0}})
		local rankData = exports.titan_misc:getAdminRank(localPlayer:getData("adminLevel"))
		local r, g, b = hex2rgb(rankData.color)
		table.insert(duties, {name = "Admin Duty", color = {r, g, b}})
	end
	if localPlayer:getData("groupDutyID") then
		local dutyColor = getElementData(localPlayer, "groupDutyColor")
		local dutyTag = getElementData(localPlayer, "GroupDutyTag")
		if dutyColor and dutyTag then
			table.insert(duties, {name = "Duty "..dutyTag, color = {dutyColor[1], dutyColor[2], dutyColor[3]}})
		end
	end
		if localPlayer:getData("playerSphere:ID") then
		table.insert(duties, {name = "ID strefy: "..localPlayer:getData("playerSphere:ID"), color = {255, 255, 255}})
	end
	for k, v in ipairs(duties) do
		if k < 4 then
			--dxDrawText(v.name, renderData.adminX, renderData.adminY + addHeight + (k - 1) * 15, 0, 0, tocolor(v.color[1], v.color[2], v.color[3], 200), 1.0, "default-bold", "left", "top", false, false, false, false, false, 0, 0, 0)
			dxDrawText(v.name, 0, sH - 43 - (k - 1) * 15, sW - 3, 0, tocolor(v.color[1], v.color[2], v.color[3], 150), 1.0, "default-bold", "right", "top", false, false, false, false, false, 0, 0, 0)
		end
	end
	dxDrawText(GAME_TYPE, 0, sH - 28, sW - 3, 0, tocolor(255, 255, 255, 120), 1.0, "default", "right", "top", false, false, true) 
end
addEventHandler("onClientRender", root, renderServerInfo)

function onStart()
	triggerServerEvent("gType", localPlayer)
end
addEventHandler("onClientResourceStart", resourceRoot, onStart)

function gType_c(data)
	GAME_TYPE = data
end
addEvent("gType_c", true)
addEventHandler("gType_c", root, gType_c)

function getAdminRank(rankID)
	local tempTable =
	{
		[1] =
		{
			color = "3689FF",
			name = "Supporter"
		},
		[2] =
		{
			color = "CC6600",
			name = "Moderator"
		},
		[3] =
		{
			color = "6A4590",
			name = "Developer"
		},
		[4] =
		{
			color = "611616",
			name = "Administrator Techniczny"
		},
		[5] = 
		{
			color = "1F8B4C",
			name = "Administrator Rozgrywki"
		},
		[6] = 
		{
			color = "DC0000",
			name = "Główny Administrator"
		},
		[7] =
		{
			color = "11F2F2",
			name = "Beta Tester"
		}
	}
	if type(tempTable[rankID]) ~= "table" then return {color = "FFFFFF", name = "Niepoprawna Ranga"} end
	return tempTable[rankID]
end

function hex2rgb(hex)
	hex = hex:gsub("#","")
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6))
end