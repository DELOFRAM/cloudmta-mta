local isdash = false
local myTexture

local vehicles_limit = 0
local vehicles_int = 0

local interiors_limit = 0
local vehicles_int = 0

local dane = {}
dane['groups'] = {}
dane['vehicles'] = {}
dane['interiors'] = {}

local label_group_name = {}
local label_group_rank = {}
local label_group_cash = {}
local label_group_uid = {}
	
local	label_vehicles_model = {}
local	label_vehicles_health = {}
local	label_vehicles_dist = {}
local	label_vehicles_fuel = {}
local	label_vehicles_uid = {}

local label_interiors_name = {}
local	label_interiors_pos = {}

local font = guiCreateFont("files/lato.TTF", 30)
local font_small = guiCreateFont("files/lato.TTF", 16)
local font_vsmall = guiCreateFont("files/lato.TTF", 12)
local font_vvsmall = guiCreateFont("files/lato.TTF", 9)

function formatDate(day, month, year)
	if day < 9 then
		day2 = "0"..day
	else
		day2 = day
	end
	if month < 9 then
		month2 = "0"..month
	else
		month2 = month
	end
	return day2.."-"..month2.."-"..year
end

function createDashboard()
	exports.titan_hud:hideSGamingHUD()
	exports.titan_hud:toggleRadarVisible(false)

	isdash = true
	
	dane['groups'] = {}
	dane['vehicles'] = {}
	dane['interiors'] = {}
	
	triggerServerEvent("getDane", localPlayer)
	
	showCursor(true)
	showChat(false)

	window = guiCreateStaticImage(0.05, 0.05, 0.9, 0.9, "files/background.png", true)
	section_profil = guiCreateStaticImage(0.05, 0.05, 0.9, 0.9, "files/section_profil.png", true)
	
	local onlinetime = math.floor((getElementData(localPlayer, "onlineTime")/60)/60)
	if onlinetime < 1 then -- gracz nie ma jeszcze godziny, pokazujemy mu minuty
		onlinetime = math.floor((getElementData(localPlayer, "onlineTime")/60))
		if onlinetime == 0 then
			onlinetime = onlinetime.." minut"
		elseif onlinetime == 1 then
			onlinetime = onlinetime.. " minuta"
		elseif onlinetime > 1 and onlinetime < 5 then
			onlinetime = onlinetime.. "minuty"
		else
			onlinetime = onlinetime.." minut"
		end
	end
	if onlinetime == 1 then
		onlinetime = onlinetime.." godzina"
	elseif onlinetime > 1 and onlinetime < 5 then
		onlinetime = onlinetime.. " godziny"
	else
		onlinetime = onlinetime.." godzin"
	end
	
	local minutes = math.floor((getElementData(localPlayer, "onlineTime")/60)) - math.floor((getElementData(localPlayer, "onlineTime")/60)/60)*60
	
	local name = getElementData(localPlayer, "name").." "..getElementData(localPlayer, "lastname")
	local name_lenght = name:len()
	
	image_avatar = guiCreateStaticImage(0.075, 0.22, 0.037, 0.17, "files/skins/"..getElementData(localPlayer, 'defaultSkin')..".png", true, section_profil)
	
	label_name = guiCreateLabel(0.13, 0.21, 0.5, 0.2, name, true, section_profil)
	label_uid = guiCreateLabel(0.145+(name_lenght/90), 0.235, 0.5, 0.2, "(UID: "..getElementData(localPlayer, "charID")..")", true, section_profil)
	label_money = guiCreateLabel(0.25, 0.267, 0.5, 0.2, "$"..getElementData(localPlayer, "money"), true, section_profil)
	label_bankmoney = guiCreateLabel(0.25, 0.298, 0.5, 0.2, "$"..getElementData(localPlayer, "accountMoney"), true, section_profil)
	label_onlinetime = guiCreateLabel(0.65, 0.222, 0.5, 0.2, onlinetime.." "..minutes.." minut", true, section_profil)
	label_hp = guiCreateLabel(0.65, 0.255, 0.5, 0.2, math.floor(getElementHealth(localPlayer)).."%", true, section_profil)
	label_birthday = guiCreateLabel(0.65, 0.2875, 0.5, 0.2, formatDate(getElementData(localPlayer, "birthday").day, getElementData(localPlayer, "birthday").month, getElementData(localPlayer, "birthday").year), true, section_profil)
	label_sex = guiCreateLabel(0.65, 0.323, 0.5, 0.2,  (getElementData(localPlayer, "sex") == 1 and "Mężczyzna" or getElementData(localPlayer, "sex") == 2 and "Kobieta" or "Nieznana"), true, section_profil)
	
	label_group_name = {}
	label_group_rank = {}
	label_group_cash = {}
	label_group_uid = {}
	
	label_vehicles_model = {}
	label_vehicles_health = {}
	label_vehicles_dist = {}
	label_vehicles_fuel = {}
	label_vehicle_uid = {}
	
	label_interiors_name = {}
	label_interiors_pos = {}
	
	vehicles_int = 1
	for i=1,6 do
		label_vehicles_model[i] = guiCreateLabel(0.064, 0.65+(i/31), 0.5, 0.2,"", true, section_profil)
		label_vehicles_health[i] = guiCreateLabel(0.17, 0.65+(i/31), 0.03, 0.2, "", true, section_profil)
		guiLabelSetHorizontalAlign(label_vehicles_health[i], "right")
		label_vehicles_dist[i] = guiCreateLabel(0.22, 0.65+(i/31), 0.058, 0.2, "", true, section_profil)
		guiLabelSetHorizontalAlign(label_vehicles_dist[i], "right")
		label_vehicles_fuel[i] = guiCreateLabel(0.292, 0.65+(i/31), 0.015, 0.2, "", true, section_profil)
		guiLabelSetHorizontalAlign(label_vehicles_fuel[i], "right")
		label_vehicles_uid[i] = guiCreateLabel(0.134, 0.657+(i/31), 0.03, 0.2, "123", true, section_profil)
		guiLabelSetHorizontalAlign(label_vehicles_uid[i], "right")
				
		guiSetFont(label_vehicles_model[i], font_small)
		guiSetFont(label_vehicles_health[i], font_small)
		guiSetFont(label_vehicles_dist[i], font_small)
		guiSetFont(label_vehicles_fuel[i], font_small)
		guiSetFont(label_vehicles_uid[i], font_vvsmall)
	end
	
	interiors_int = 1
	for i=1,6 do
		label_interiors_name[i] = guiCreateLabel(0.688, 0.65+(i/31), 0.5, 0.2,"", true, section_profil)
		label_interiors_pos[i] = guiCreateLabel(0.875, 0.65+(i/31), 0.5, 0.2, "", true, section_profil)
				
		guiSetFont(label_interiors_name[i], font_small)
		guiSetFont(label_interiors_pos[i], font_small)
	end
	
	setTimer(function ()
		for i,v in pairs(dane['groups']) do	
			local groupName = tostring(v.groupInfo.name)
			if groupName:len() > 18 then
				groupName = string.sub(groupName, 0, 18)
				groupName = groupName.."..."
			end
		
			label_group_name[i] = guiCreateLabel(0.375, 0.65+(i/30), 0.5, 0.2, groupName, true, section_profil)
			label_group_rank[i] = guiCreateLabel(0.52, 0.65+(i/31), 0.5, 0.2, tostring(v.rankName), true, section_profil)
			label_group_cash[i] = guiCreateLabel(0.6, 0.65+(i/31), 0.5, 0.2, "$"..tostring(v.cash or 0), true, section_profil)
			label_group_uid[i] = guiCreateLabel(0.4, 0.66+(i/31), 0.115, 0.2, "("..v.groupInfo.ID..")", true, section_profil)
			
			guiLabelSetHorizontalAlign(label_group_uid[i], "right")
			
			
			guiSetFont(label_group_name[i], font_small)
			guiSetFont(label_group_rank[i], font_small)
			guiSetFont(label_group_cash[i], font_small)
			guiSetFont(label_group_uid[i], font_vvsmall)
		end
		
		for i,v in pairs(dane['vehicles']) do
			if i > vehicles_limit and i < 7+vehicles_limit then
				local vehName = tostring(v.name)
				if vehName:len() > 10 then
					vehName = string.sub(vehName, 0, 10)
					vehName = vehName.."..."
				end
				guiSetText(label_vehicles_model[vehicles_int], vehName)
				guiSetText(label_vehicles_health[vehicles_int], math.floor(v.hp/10).."%")
				guiSetText(label_vehicles_dist[vehicles_int], math.floor(v.distance).."km")
				guiSetText(label_vehicles_fuel[vehicles_int], math.floor(v.fuel).."l")
				guiSetText(label_vehicles_uid[vehicles_int], "("..v.ID..")")
				vehicles_int = vehicles_int + 1
			end
		end
		
		
		guiSetText(label_interiors_name[1], "Wczytywanie danych...")
		
		button_vehicles_up = guiCreateButton(0.19, 0.882, 0.02, 0.02, "/\\", true, section_profil)
		button_vehicles_down = guiCreateButton(0.19, 0.905, 0.02, 0.02, "\\/", true, section_profil)
		
		addEventHandler("onClientGUIClick", button_vehicles_up, vehicles_up, false)
		addEventHandler("onClientGUIClick", button_vehicles_down, vehicles_down, false)
		
		guiSetAlpha(button_vehicles_up, 0)
		guiSetAlpha(button_vehicles_down, 0)
	end, 100, 1)
	
	
	
	guiSetFont(label_name, font)
	guiSetFont(label_uid, font_vsmall)
	guiSetFont(label_money, font_small)
	guiSetFont(label_bankmoney, font_small)
	guiSetFont(label_onlinetime, font_small)
	guiSetFont(label_hp, font_small)
	guiSetFont(label_birthday, font_small)
	guiSetFont(label_sex, font_small)
end

function destroyDashboard()
	exports.titan_hud:showSGamingHUD()
	exports.titan_hud:toggleRadarVisible(true)
	isdash = false
	destroyElement(window)
	destroyElement(section_profil)
	showCursor(false)
	showChat(true)
	vehicles_limit = 0
end

function vehicles_up()
	if vehicles_limit > 0 then
		vehicles_limit = vehicles_limit - 1
		vehicles_int = 1
		
		for i,v in pairs(dane['vehicles']) do
			if i > vehicles_limit and i < 7+vehicles_limit then
				local vehName = tostring(v.name)
				if vehName:len() > 10 then
					vehName = string.sub(vehName, 0, 10)
					vehName = vehName.."..."
				end
				guiSetText(label_vehicles_model[vehicles_int], vehName)
				guiSetText(label_vehicles_health[vehicles_int], math.floor(v.hp/10).."%")
				guiSetText(label_vehicles_dist[vehicles_int], math.floor(v.distance).."km")
				guiSetText(label_vehicles_fuel[vehicles_int], math.floor(v.fuel).."l")
				guiSetText(label_vehicles_uid[vehicles_int], "("..v.ID..")")
				vehicles_int = vehicles_int + 1
			end
		end
		
	end
end

function vehicles_down()
	if vehicles_limit < #dane['vehicles']-6 then
		vehicles_limit = vehicles_limit + 1
		
		vehicles_int = 1
		
		for i,v in pairs(dane['vehicles']) do
			if i > vehicles_limit and i < 7+vehicles_limit then
				local vehName = tostring(v.name)
				if vehName:len() > 10 then
					vehName = string.sub(vehName, 0, 10)
					vehName = vehName.."..."
				end
				guiSetText(label_vehicles_model[vehicles_int], vehName)
				guiSetText(label_vehicles_health[vehicles_int], math.floor(v.hp/10).."%")
				guiSetText(label_vehicles_dist[vehicles_int], math.floor(v.distance).."km")
				guiSetText(label_vehicles_fuel[vehicles_int], math.floor(v.fuel).."l")
				guiSetText(label_vehicles_uid[vehicles_int], "("..v.ID..")")
				vehicles_int = vehicles_int + 1
			end
		end
		
	end
end

addEvent("setDane", true)
addEventHandler("setDane", getRootElement(), function (groups, vehicles, interiors)
	dane['groups'] = groups
	dane['vehicles'] = vehicles
	dane['interiors'] = interiors
end)

bindKey("F2", "down", function ()
	if isdash then
		destroyDashboard()
	else
		createDashboard()
	end
end)
