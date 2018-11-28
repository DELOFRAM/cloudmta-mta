local option = "wylacz, oko, kolizja, komponenty"

function cmdADEV(player, command, ...)
	if not exports.titan_admin:isPlayerAdmin(player) then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local arg = {...}
	local helper = getElementData(player,"helper")
	local typ = arg[1]
	if typ == "wlacz" then
		if not(helper) then
			helper = {}
			setElementData(player,"helper",helper)
			triggerClientEvent(player, "toggleDeveloperMode", player, true )
			exports.titan_noti:showBox(player, "Tryb developerski został włączony.")
			return true
		end
	elseif typ == "wylacz" then
		if helper then
			removeElementData(player,"helper",false)
			triggerClientEvent(player, "toggleDeveloperMode", player, false )
			exports.titan_noti:showBox(player, "Tryb developerski został wyłączony.")
			return true
		end
	elseif typ == "oko" then
		if helper.eye then
			helper.eye = false
			helper.textury = false
			triggerClientEvent(player, "toggleEyeMode", player, false )
			exports.titan_noti:showBox(player, "Zawansowany podglad zostal wyłączony.")
		elseif not(helper.eye) then
			helper.eye = true
			triggerClientEvent(player, "toggleEyeMode", player, true )
			exports.titan_noti:showBox(player, "Zawansowany podglad zostal włączony.")	
		end
	elseif typ == "kolizja" then
		if helper.collision then
			helper.collision = false
			triggerClientEvent(player, "toggleCollisionMode", player, false )
			exports.titan_noti:showBox(player, "Podgląd kolizji został wyłączony.")
		elseif not(helper.collision) then
			helper.collision = true
			triggerClientEvent(player, "toggleCollisionMode", player, true )
			exports.titan_noti:showBox(player, "Podgląd kolizji został włączony.")	
		end
	elseif typ == "komponenty" then
		if helper.components then
			if not(helper.eye) then exports.titan_noti:showBox(player, "Najpirew musisz włączyć tryb zawansowanego podglądu.") end
			helper.components = false
			exports.titan_noti:showBox(player, "Podgląd komponentów został wyłączony.")
		elseif not(helper.components) then
			helper.components = true
			exports.titan_noti:showBox(player, "Podgląd komponentów został włączony.")	
		end
	elseif typ == "textury" then
		if not(helper.eye) then exports.titan_noti:showBox(player, "Najpirew musisz włączyć tryb zawansowanego podglądu.") end
		if helper.texture then
			helper.texture = false
			exports.titan_noti:showBox(player, "Podgląd textur został wyłączony.")
		elseif not(helper.texture) then
			helper.texture = true
			exports.titan_noti:showBox(player, "Podgląd textur został włączony.")	
		end
	elseif not(typ == nil) then
		exports.titan_noti:showBox(player, "Wystąpił błąd!")
		return
	end
	setElementData(player,"helper",helper)
	
	if helper and typ == nil then
		exports.titan_noti:showBox(player, string.format("TIP: /adev [%s]", option) )
	elseif not(helper) and typ == nil then
 		exports.titan_noti:showBox(player, "TIP: /adev [wlacz]")
	end


end
addCommandHandler("adev", cmdADEV, false, false)