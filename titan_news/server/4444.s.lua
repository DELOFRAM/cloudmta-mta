----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function getKeyFromValue(val1, val2)
	for k,v in pairs(getElementsByType("zgloszenieLSN")) do
		if tostring(getElementData(v, "data.time")) == tostring(val1) and tostring(getElementData(v, "data.phone")) == tostring(val2) then return k end
	end
	return false
end

addEvent("addCall.s", true)
addEvent("addBlip.s", true)
addEvent("reloadGUI.s", true)
addEvent("removeCall.s", true)
addEvent("removeBlip.s", true)
addEvent("showGUI.s", true)


			

addEventHandler("addCall.s", root, function(name, phone, time, zone, text, x, y, z)
local wpis = createElement("zgloszenieLSN")
setElementData(wpis, "data.name", name)
setElementData(wpis, "data.phone", phone)
setElementData(wpis, "data.time", time)
setElementData(wpis, "data.zone", zone)
setElementData(wpis, "data.text", text)
setElementData(wpis, "data.x", x)
setElementData(wpis, "data.y", y)
setElementData(wpis, "data.z", z)
	for _,p in ipairs(getElementsByType("player")) do
		if not exports.titan_login:isLogged(p) then else
			if not exports.titan_orgs:getPlayerDuty(p) then else
			local groupInfo = exports.titan_orgs:getGroupInfo(exports.titan_orgs:getPlayerDuty(p))
				if not groupInfo then else
					if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "bdiall") then else
					exports.titan_noti:showBox(p, "Pojawiło się nowe zgłoszenie od cywila! Wpisz /4444 aby je sprawdzić!")
					end
				end
			end
		end
	end

	for k,v in pairs(getElementsByType("player")) do
		if getElementData(v, "LSNGUI") == true then
		triggerClientEvent(v, "reloadGUI.c", v)
		end
	end
end)

addEventHandler("removeCall.s", root, function(val1, val2)
local k = getKeyFromValue(val1, val2)
destroyElement(getElementsByType("zgloszenieLSN")[k])

	for k,v in pairs(getElementsByType("player")) do
		if getElementData(v, "LSNGUI") == true then
		triggerClientEvent(v, "reloadGUI.c", v)
		end
	end
end)

addEventHandler("reloadGUI.s", root, function()
	for k,v in pairs(getElementsByType("player")) do
		if getElementData(v, "LSNGUI") == true then
		triggerClientEvent(v, "reloadGUI.c", v)
		end
	end
end)

addEventHandler("showGUI.s", root, function()
triggerClientEvent(source, "showGUI.c", source)
end)

addEventHandler("addBlip.s", root, function(x, y, z, id)
local blip = createBlip(x, y, z, 0, 4, 255, 0, 0, 255, 0, 99999, client)
setElementData(blip, "zgloszenieID", id)
end)

addEventHandler("removeBlip.s", root, function(id)
	for k,v in ipairs(getElementsByType("blip")) do
		if getElementData(v, "zgloszenieID") == id then
		destroyElement(v)
		end
	end
end)

addCommandHandler("4444", function(plr)
	if not exports.titan_login:isLogged(plr) then else
		if not exports.titan_orgs:getPlayerDuty(plr) then
		exports.titan_noti:showBox(plr, "Nie jesteś na duty żadnej grupy!")
		else
		local groupInfo = exports.titan_orgs:getGroupInfo(exports.titan_orgs:getPlayerDuty(plr))
			if not groupInfo then else
				if not exports.titan_orgs:doesGroupHavePerm(groupInfo.ID, "bdiall") then
				exports.titan_noti:showBox(plr, "Twoja grupa nie ma uprawnień do tej komendy!")
				else
				triggerClientEvent(plr, "show4444GUI.c", plr)
				end
			end
		end
	end
end)