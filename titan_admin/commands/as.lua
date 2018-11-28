----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local spheresFunc = {}

function cmdAs(player, command, ...)
	if not doesAdminHavePerm(player, "spheres") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local args = {...}
	local typ = string.lower(tostring(args[1]))

	if typ == "edytuj" then
		local ID = args[2]
		if not tonumber(ID) then return exports.titan_noti:showBox(player, "TIP: /as edytuj [ID strefy]") end
		ID = tonumber(ID)

		local sphereInfo = exports.titan_spheres:getSphereInfo(ID)
		if not sphereInfo then return exports.titan_noti:showBox(player, "Nie znaleziono strefy o podanym ID.") end
		triggerClientEvent(player, "sphereGUIFunc.createWindows", resourceRoot, sphereInfo)
	elseif typ == "usun" then
		local ID = args[2]
		if not tonumber(ID) then return exports.titan_noti:showBox(player, "TIP: /as usun [ID strefy]") end
		ID = tonumber(ID)

		local sphereInfo = exports.titan_spheres:getSphereInfo(ID)
		if not sphereInfo then return exports.titan_noti:showBox(player, "Nie znaleziono strefy o podanym ID.") end
		if exports.titan_spheres:removeSphere(sphereInfo.ID) then
			exports.titan_noti:showBox(player, "Strefa została usunięta pomyślnie.")
		else
			exports.titan_noti:showBox(player, "Wystapił bład podczas usuwania strefy.")
		end
	elseif typ == "obiekty" then
		local ID = args[2]
		local objects = args[3]
		if not tonumber(ID) or not tonumber(objects) then return exports.titan_noti:showBox(player, "TIP: /as obiekty [ID strefy] [Ilość obiektów]") end
		ID = tonumber(ID)
		objects = tonumber(objects)

		if objects < 0 or objects > 200 then return exports.titan_noti:showBox(player, "Obiekty musza mieścić się w przedziale [0 - 200].")  end
		local sphereInfo = exports.titan_spheres:getSphereInfo(ID)
		if not sphereInfo then return exports.titan_noti:showBox(player, "Nie znaleziono strefy o podanym ID.") end
		
		if exports.titan_spheres:changeSphereObjectsLimit(sphereInfo.ID, objects) then
			exports.titan_noti:showBox(player, "Pomyślnie zmieniono ilość obiektów na strefie.")
		else
			exports.titan_noti:showBox(player, "Wystapił bład w momencie zmiany ilości obiektów na strefie.")
		end
	elseif typ == "interior" then
		local ID = args[2]
		local intID = args[3]
		if not tonumber(ID) or not tonumber(intID) then return exports.titan_noti:showBox(player, "TIP: /as interior [ID strefy] [ID interioru]") end
		ID = tonumber(ID)
		intID = tonumber(intID)

		local sphereInfo = exports.titan_spheres:getSphereInfo(ID)
		if not sphereInfo then return exports.titan_noti:showBox(player, "Nie znaleziono strefy o podanym ID.") end

		local intInfo = exports.titan_doors:getDoorInfo(intID)
		if not intInfo then
			return exports.titan_noti:showBox(player, "Interior o takim ID nie istnieje.")
		end
		if exports.titan_spheres:changeSphereInterior(sphereInfo.ID, intID) then
			return exports.titan_noti:showBox(player, "Pomyślnie zmieniono ID interioru przypisanego do strefy.")
		else
			return exports.titan_noti:showBox(player, "Wystapił bład w momencie przypisania ID interioru strefy.")
		end
	else
		exports.titan_noti:showBox(player, "TIP: /as [stworz, edytuj, usun, obiekty, interior]")
	end

end
addCommandHandler("as", cmdAs, false, false)

function spheresFunc.addSphereMember(sphereID, ownerType, owner)
	if not doesAdminHavePerm(source, "spheres") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local sphereInfo = exports.titan_spheres:getSphereInfo(sphereID)
	if not sphereInfo then return exports.titan_noti:showBox(source, "Nie znaleziono strefy o podanym ID.") end

	for k, v in ipairs(sphereInfo.members) do
		if v.ownerType == ownerType and v.owner == owner then
			exports.titan_noti:showBox(source, "Uprawnienie już istnieje.")
			triggerClientEvent(source, "sphereGUIFunc.reloadPerms", resourceRoot, sphereInfo.members)
			triggerClientEvent(source, "sphereGUIFunc.turnOnGuiElement", resourceRoot, "editorWindow", "buttonAdd")
			return
		end
	end

	local tempTable = 
	{
		ownerType = ownerType,
		owner = owner
	}
	if exports.titan_spheres:addSphereMember(sphereID, tempTable) then
		exports.titan_noti:showBox(source, "Pomyślnie dodano nowe uprawnienie.")
		local sphereInfo = exports.titan_spheres:getSphereInfo(sphereID)
		if sphereInfo then
			triggerClientEvent(source, "sphereGUIFunc.reloadPerms", resourceRoot, sphereInfo.members)
		end
	else
		exports.titan_noti:showBox(source, "Wystapił bład w trakcie dodawania uprawnienia.")
	end
	triggerClientEvent(source, "sphereGUIFunc.turnOnGuiElement", resourceRoot, "editorWindow", "buttonAdd")
end
addEvent("spheresFunc.addSphereMember", true)
addEventHandler("spheresFunc.addSphereMember", root, spheresFunc.addSphereMember)

function spheresFunc.deleteSphereMember(sphereID, ownerType, owner)
	if not doesAdminHavePerm(source, "spheres") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local sphereInfo = exports.titan_spheres:getSphereInfo(sphereID)
	if not sphereInfo then return exports.titan_noti:showBox(source, "Nie znaleziono strefy o podanym ID.") end
	local exists = false
	for k, v in ipairs(sphereInfo.members) do
		if v.ownerType == ownerType and v.owner then
			exists = true
			break
		end
	end
	if not exists then
		exports.titan_noti:showBox(source, "Uprawnienie nie istnieje.")
		triggerClientEvent(source, "sphereGUIFunc.reloadPerms", resourceRoot, sphereInfo.members)
		triggerClientEvent(source, "sphereGUIFunc.turnOnGuiElement", resourceRoot, "mainWindow", "buttonDeletePerms")
		return
	end
	if exports.titan_spheres:removeSphereMember(sphereID, ownerType, owner) then
		exports.titan_noti:showBox(source, "Pomyślnie usunięto uprawnienie.")
	else
		exports.titan_noti:showBox(source, "Wystapił bład podczas usuwania uprawnienia.")
	end
	triggerClientEvent(source, "sphereGUIFunc.turnOnGuiElement", resourceRoot, "mainWindow", "buttonDeletePerms")
	local sphereInfo = exports.titan_spheres:getSphereInfo(sphereID)
	if sphereInfo then
		triggerClientEvent(source, "sphereGUIFunc.reloadPerms", resourceRoot, sphereInfo.members)
	end
	return
end
addEvent("spheresFunc.deleteSphereMember", true)
addEventHandler("spheresFunc.deleteSphereMember", root, spheresFunc.deleteSphereMember)

function spheresFunc.saveInfo(sphereID, name, flags)
	if not doesAdminHavePerm(source, "spheres") then return exports.titan_noti:showBox(source, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local sphereInfo = exports.titan_spheres:getSphereInfo(sphereID)
	if not sphereInfo then return exports.titan_noti:showBox(source, "Nie znaleziono strefy o podanym ID.") end

	if exports.titan_spheres:setSphereData(sphereInfo.ID, name, flags) then
		exports.titan_noti:showBox(source, "Ustawienia strefy zostały zapisane pomyślnie.")
	else
		exports.titan_noti:showBox(source, "Wystapil bład podczas zapisywania ustawien strefy.")
	end
	--outputConsole(toJSON(flags))
end
addEvent("spheresFunc.saveInfo", true)
addEventHandler("spheresFunc.saveInfo", root, spheresFunc.saveInfo)