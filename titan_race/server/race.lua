local Class = {}
Class.Race = {}
Class.Race.index = {}
Class.Race.func = {}
Class.Race.list = {}
Class.Race.hosting = {}
Class.Race.Timers = {}

function Class.Race.func.Commands(player, CommandName, ...)
	local arg = {...}
	local key = string.lower(tostring(arg[1]))
		if not(key) or (key ~= "stworz" and key ~= "dolacz" and key ~= "zapros" and key ~= "wyrzuc" and key ~= "edytuj" and key ~= "rozpocznij" and key ~= "opusc") then
		exports.titan_noti:showBox(player,"TIP: /"..CommandName.." [stworz, edytuj, rozpocznij, zapros, dolacz, opusc]")
		return
		elseif key == "stworz" then
		if getElementData(player,"Race:ID") then return exports.titan_noti:showBox(player,"Nie możesz organizować wyścigu ponieważ już do jakiegoś należysz!") end
		local name = table.concat(arg, " ", 2)
		if string.len(name) > 0 and name ~= "nil" then
			Class.Race.func.hosting(player, name)
			return
		else
			exports.titan_noti:showBox(player,"TIP: /"..CommandName.." stworz [Nazwa]")
			return
		end

		elseif key == "edytuj" then
			if Class.Race.hosting[player] == nil then return exports.titan_noti:showBox(player,"Nie jesteś organizatorem wyścigu!") end
			local index = Class.Race.hosting[player].ID
			if #Class.Race.list[index].checkpoints == 0 then return exports.titan_noti:showBox(player,"Nie można edytować trasy w trakcie jej tworzenia!") end
			local name = Class.Race.hosting[player].name
			triggerClientEvent( player, "Race:unsync", player )
			triggerClientEvent( player, "Race:bulding", player, index, name, "Edycja", Class.Race.list[index].checkpoints )
		elseif key == "zapros" then
			local ID = arg[2]
			if ID == nil then
				exports.titan_noti:showBox(player,"TIP: /"..CommandName.." zapros [ID Gracza]")
				return
			end
			ID = tonumber(ID)
			local target = serachPlayerID(player,ID)
			if target then
				if Class.Race.hosting[player] == nil then return exports.titan_noti:showBox(player,"Nie jesteś organizatorem wyścigu!") end
				if getElementData(target,"Race:ID") then return exports.titan_noti:showBox(player,"Gracz należy już do jakiegoś wyścigu!") end
				if getElementData(target,"offer:Race:ID") then return exports.titan_noti:showBox(player,"Gracz otrzymał już ofertę dołączenia do jakiegoś wyścigu musisz poczekać!") end
				exports.titan_noti:showBox(target,"Otrzymałeś ofertę dołączenia do wyścigu  aby dołączyć wpisz /"..CommandName.." dolacz")
				setElementData(target,"offer:Race:ID", getElementData(player,"Race:ID") )
				Class.Race.Timers[target] = setTimer ( function(player)
					exports.titan_noti:showBox(player,"Oferta dołączenia do wyścigu została anulowana")
					setElementData(player,"offer:Race:ID",false )
				end, 5000, 1,target )
			end
		elseif key == "dolacz" then
			if getElementData(player,"Race:ID") then return exports.titan_noti:showBox(player,"Należysz już do jakiegos wyścigu!") end
			if not getElementData(player,"offer:Race:ID") then return exports.titan_noti:showBox(player,"Nie otrzymałeś żadnej oferty dołączenia do wyścigu.") end
			local index = getElementData(player,"offer:Race:ID")
			Class.Race.func.JoinPlayer(player, index)
			setElementData(player,"offer:Race:ID",false)

		elseif key == "opusc" then
			if not getElementData(player,"Race:ID") then return exports.titan_noti:showBox(player,"Nie należysz do żadnego wyścigu!") end
			Class.Race.func.QuitPlayer(player, getElementData(player,"Race:ID"))
			setElementData(player,"Race:ID",false)
		elseif key == "rozpocznij" then
			if Class.Race.hosting[player] ~= nil then
				local index = Class.Race.hosting[player].ID
				if #Class.Race.list[index].checkpoints < 2 then return exports.titan_noti:showBox(player,"Trasa wyścigu musi zawierać minimum dwa punkty!") end
				Class.Race.func.changeStatus(Class.Race.hosting[player])
				Class.Race.list[index].finished = {}
				return
			else
				exports.titan_noti:showBox(player,"Nie jesteś organizatorem wyścigu!")
				return
		end
	end
end
addCommandHandler("wyscig", Class.Race.func.Commands )


function Class.Race.func.changeStatus(data)
	local index = data.ID
	local toggle = false
	Class.Race.list[index].status = true

	for i,v in ipairs(Class.Race.list[index].participants) do
		if not getPedOccupiedVehicle( v ) then
			toggle = true
		end
	end

	if toggle == false then
		for i,v in ipairs(Class.Race.list[index].participants) do
			triggerClientEvent(v,"Race:sync",v ,data )
		end
	end

	if toggle then
		return exports.titan_noti:showBox(Class.Race.list[index].organisator,"Aby rozpocząć wyścig wszyscy uczestnicy muszą znajdować się w pojazdach")
	end

end


function Class.Race.func.hosting(player, name)
	if Class.Race.hosting[player] ~= nil then
		exports.titan_noti:showBox(player,"Już jesteś organizatorem jednego z wyścigów.")
		return
	end

	local index = findFreeIndexTable(Class.Race.index)
	Class.Race.list[index] = {
		ID = index,
		name = name,
		organisator = player,
		participants = {},
		finished = {},
		checkpoints = {},
		status = false,
	}
	Class.Race.hosting[player] = Class.Race.list[index]
	table.insert(Class.Race.list[index].participants,player)
	table.insert(Class.Race.index, index)
	setElementData(player,"Race:ID", index)
	exports.titan_noti:showBox(player,"Stworzno Wyścig "..name.." (UID:"..index..")")
	triggerClientEvent( player, "Race:bulding", player, index, name, "Tworzenie" )
end

function Class.Race.func.cancelHosting(player, index)
	if Class.Race.hosting[player] then
		Class.Race.hosting[player] = false
		Class.Race.list[index] = false
		table.remove(Class.Race.index, index)
	end
end
addEvent( "Race:cancelHosting", true ) 
addEventHandler( "Race:cancelHosting", getRootElement(  ), Class.Race.func.cancelHosting)


function Class.Race.func.setRaceCheckpoint(index,tab)
	Class.Race.list[index].checkpoints = tab
	for i,v in ipairs(Class.Race.list[index].participants) do
		triggerClientEvent(v,"Race:sync",v ,Class.Race.list[index] )
	end

end
addEvent( "Race:setCheckpoint", true ) 
addEventHandler( "Race:setCheckpoint", getRootElement(  ), Class.Race.func.setRaceCheckpoint)

function Class.Race.func.JoinPlayer(player, index)
	if Class.Race.list[index] ~= nil then
		exports.titan_noti:showBox(Class.Race.list[index].organisator, exports.titan_chats:getPlayerICName(v[1]).." dołączył do wyścigu." )
		triggerClientEvent(player,"Race:sync", player, Class.Race.list[index] )
		setElementData(player,"Race:ID", index)
		exports.titan_noti:showBox(player,"Pomyslnie dołączyłeś do wyścigu")
		table.insert(Class.Race.list[index].participants, player)
	end
end
addEvent( "Race:onPlayerJoin", true )
addEventHandler( "Race:onPlayerJoin", getRootElement(  ), Class.Race.func.JoinPlayer)


function Class.Race.func.QuitPlayer(player, index)
	if Class.Race.list[index] ~= nil then
		if #Class.Race.list[index].participants > 0 then
			for i,v in ipairs(Class.Race.list[index].participants) do
				if v == player then
					if v == Class.Race.list[index].organisator then
						for i,v in ipairs(Class.Race.list[index].participants) do
							triggerClientEvent(v, "Race:unsync", v)
							if v ~= Class.Race.list[index].organisator then
								exports.titan_noti:showBox(v,"zostałeś wyrzucony z wyścigu ponieważ organizator opuscił wyścig." )
								Class.Race.list[index].participants = false
							end
						end
						exports.titan_noti:showBox(v, "opuściłeś wyścig." )
						triggerClientEvent(v,"Race:stopbulding",v)
						Class.Race.hosting[v] = nil
						Class.Race.list[index] = false
						return
					end
	
					exports.titan_noti:showBox(Class.Race.list[index].organisator, exports.titan_chats:getPlayerICName(v).." wyszedł z wyśćigu." )
					v = false
					return
				end
			end
		end
		if #Class.Race.list[index].participants == 0 then
			triggerClientEvent(Class.Race.list[index].organisator,"Race:stopbulding",Class.Race.list[index].organisator)
			Class.Race.list[index] = false
			Class.Race.hosting[Class.Race.list[index].organisator] = nil
		end
	end
end
addEvent( "Race:onPlayerQuit", true )
addEventHandler( "Race:onPlayerQuit", getRootElement(  ), Class.Race.func.QuitPlayer)

function Class.Race.func.finishRace(index, player, time)
	if Class.Race.list[index] ~= nil then
		for i,v in ipairs(Class.Race.list[index].participants) do
			if v == player then
				table.insert(Class.Race.list[index].finished,{player,time})
			end
		end
		local hours = math.floor(time / 3600)
		local minutes = math.floor(time/ 60) - (hours * 60)
		local seconds = math.floor(time - (minutes * 60) - (hours * 3600))
		exports.titan_noti:showBox(player,"Ukończyłeś wyścig jako "..#Class.Race.list[index].finished.." na "..#Class.Race.list[index].participants.." w czasie "..hours..":"..minutes..":"..seconds)
	end

	if #Class.Race.list[index].finished == #Class.Race.list[index].participants then
		Class.Race.list[index].status = false
		for i,v in ipairs(Class.Race.list[index].finished) do
			local hours = math.floor(v[2] / 3600)
			local minutes = math.floor(v[2]/ 60) - (hours * 60)
			local seconds = math.floor(v[2] - (minutes * 60) - (hours * 3600))
			outputChatBox(i..". "..exports.titan_chats:getPlayerICName(v[1]).." | "..hours..":"..minutes..":"..seconds,Class.Race.list[index].organisator,255,255,255)
			triggerClientEvent(v[1], "Race:sync", v[1], Class.Race.list[index])
		end
		Class.Race.list[index].finished = {}
	end
end
addEvent( "Race:finishRace", true )
addEventHandler( "Race:finishRace", getRootElement(  ), Class.Race.func.finishRace)