----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local reportData = {}
local reportFunc = {}

function reportFunc.onStart()
	exports.titan_hud:updateHUDReportsState(false)
end
addEventHandler("onResourceStart", resourceRoot, reportFunc.onStart)

function reportFunc.addReport(player, targetID, category, desc)
	local targetName
	if targetID and tonumber(targetID) and isElement(getElementByID("pid"..targetID)) then
		local targetElement = getElementByID("pid"..targetID)
		targetName = string.format("[%d] %s %s", targetElement:getData("playerID"), targetElement:getData("name"), targetElement:getData("lastname"))
	else
		targetID = 0
	end

	local tmpTable = 
	{
		id = reportFunc.getNewID(),
		sender = player,
		targetID = targetID,
		cat = category,
		desc = desc,
		admin = 0,
		date = getRealTime().timestamp,
		senderName = string.format("[%d] %s %s", player:getData("playerID"), player:getData("name"), player:getData("lastname")),
		targetName = targetName and targetName or "n/d" 
	}
	table.insert(reportData, tmpTable)
	exports.titan_hud:updateHUDReportsState(true)
	reportFunc.infoToAdmin()
end
addEvent("addReport", true)
addEventHandler("addReport", root, reportFunc.addReport)

function onPlayerJoinToServer(player)
	if #reportData > 0 then
		exports.titan_hud:updateHUDReportsState(true, player)
	end
end

function reportFunc.infoToAdmin()
	for k, v in ipairs(getElementsByType("player")) do
		if exports.titan_login:isLogged(v) then
			if exports.titan_admin:isPlayerAdmin(v) and exports.titan_admin:doesPlayerHaveAdminDuty(v) then
				exports.titan_chats:addPlayerOOCMessage(v, "* Ktoś wysłał raport. Aby poznać więcej informacji użyj komendy /areport.", 200, 20, 20)
			end
		end
	end
end

function reportFunc.cmdAreport(player)
	if isElement(player) and exports.titan_login:isLogged(player) then
		if not exports.titan_admin:doesPlayerHaveAdminDuty(player) then return exports.titan_noti:showBox(player, "Nie jesteś na duty administratora.") end
		if #reportData <= 0 then
			exports.titan_noti:showBox(player, "Brak nieodebranych raportów.")
			return
		end
		triggerClientEvent(player, "adminReport.create", player, reportData)
	end
end
addCommandHandler("areport", reportFunc.cmdAreport, false, false)

function reportFunc.getNewID()
	local i = 1
	if #reportData <= 0 then return i end
	while true do
		for k, v in ipairs(reportData) do
			if v.id ~= i then return i end
		end
		i = i + 1
	end
end

function reportFunc.getKeyFromID(ID)
	for k, v in ipairs(reportData) do
		if v.id == ID then return k end
	end
	return false
end

function reportFunc.adminClaimReport(reportID)
	local key = reportFunc.getKeyFromID(reportID)
	if key then
		local rData = reportData[key]
		for k, v in ipairs(getElementsByType("player")) do
			if exports.titan_login:isLogged(v) then
				if exports.titan_admin:isPlayerAdmin(v) then
					exports.titan_chats:addPlayerOOCMessage(v, string.format("* Zgłoszenie od gracza %s zostało przyjęte przez admina %s.", rData.senderName, source:getData("globalName")), 200, 20, 20)
				end
			end
		end
		
		if isElement(rData.sender) == true then
			exports.titan_noti:showBox(rData.sender, string.format("Twoje zgłoszenie zostało odebrane przez %s", source:getData("globalName")))
		end

		outputConsole("|___Szczegóły zgłoszenia___|", source)
		outputConsole("Zgłaszają")

		table.remove(reportData, key)
		if #reportData > 0 then
			exports.titan_hud:updateHUDReportsState(true)
		else
			exports.titan_hud:updateHUDReportsState(false)
		end
	end
end
addEvent("reportFunc.adminClaimReport", true)
addEventHandler("reportFunc.adminClaimReport", root, reportFunc.adminClaimReport)