addCommandHandler( "af", function(Player, CommandName, Key, ... )
local admin = getElementData(Player,"adminLevel")
if admin < 3 then exports.titan_noti:showBox(Player,"Nie posiadasz uprawnień do użycia tej komendy." ) return end 
local arguments = split (table.concat({...}, " "), " ")
local arg = {}
for i,v in ipairs(arguments) do
	arg[i] = v
end
	if Key == "stworz" then
		return createFireCommand(Player, CommandName, Key, arg[1], arg[2], arg[3], arg[4])
	elseif Key == "usun" then
		return deleteFireCommand(Player, CommandName, Key, arg[1], arg[2])
	else
		return exports.titan_noti:showBox(Player,"Błąd składni: /"..CommandName.." [stworz, usun]" )
	end
end)

-- addCommandHandler("veh.water",function(player, CommandName, Value)
-- 	if getPedOccupiedVehicle( player ) then
-- 		local veh = getPedOccupiedVehicle( player )
-- 		local Value = tonumber(Value)
-- 		setElementData(veh,"water",{Value,Value})
-- 		outputChatBox("Ustaliłeś poziom wody w pojeździe na: "..Value)
-- 	end
-- end)



function createFireCommand(Player, CommandName, Key, amount, Type, Health, time)
	if not(amount) or not(Type) then
		return exports.titan_noti:showBox(Player,"Błąd składni: /"..CommandName.." "..Key.." [ilość] [Type] [Ilość HP] [Czas]" )
	end
	Health = Health or 0
	time = time or 0.1

	if Fire_Type[tonumber(Type)] then
		local type = Fire_Type[tonumber(Type)]
		local x, y, z = getElementPosition( Player )
		local interior, dimension = getElementInterior( Player ), getElementDimension( Player )
		local hp = math.random(type[2][1]+Health, type[2][2]+Health)
		triggerEvent( "createFire", Player, x, y, z, interior, dimension, tonumber(amount), type[4], type[1]+Health, hp, time, type[3] )
	else
		return exports.titan_noti:showBox(Player,"Błąd ten typ ognia jest niedostępny!")
	end
end

function deleteFireCommand(Player, CommandName, Key, UID, ID)
local UID = tonumber(UID)
local ID = tonumber(ID)
	if not(UID) then
		return exports.titan_noti:showBox(Player,"/"..CommandName.." "..Key.." [UID GRUPY] [ID OGNIA]")
	end

	if UID and not(ID) and not(Fire[UID]) or #Fire[UID] <= 0 then
		return exports.titan_noti:showBox(Player,"Nie znaleziono grupy ognia o podanym UID.")
	elseif UID and not(ID) and #Fire[UID] > 0 then
		destroyFire(Fire[UID],UID)
		return exports.titan_noti:showBox(Player,"Pomyślnie usunięto grupę o UID: "..UID)
	elseif UID and ID and not(Fire[UID][ID]) then
		return exports.titan_noti:showBox(Player,"Nie znaleziono ognia o ID: "..ID.." w grupie o UID:"..UID)
	elseif UID and ID and Fire[UID][ID] then
		destroyFire(Fire[UID][ID])
		return exports.titan_noti:showBox(Player,"Pomyślnie usunięto ogień o ID: "..ID.." w grupie o UID: "..UID)
	end
end