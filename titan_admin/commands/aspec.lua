----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:22
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:24
----------------------------------------------------

function searchPlayerFromID(id)
	for i,v in ipairs( getElementsByType("player") ) do
		if v:getData("playerID") == id and exports.titan_login:isLogged(v) then
			return v
		end
	end
	 return false
end

function sortingIDTable()
	tempTable = {}
	for i,v in ipairs( getElementsByType("player") ) do
		local id = v:getData("playerID")
		if id and exports.titan_login:isLogged(v) then
			table.insert(tempTable,id)
		end
	end
	table.sort(tempTable, function(a,b) return a < b end)
	return tempTable
end

function switchSpectatorPlayer(player, key, state, arg)
	player:detach()
	local specData = player:getData("specData")
	local id = specData.index + arg
	local table = sortingIDTable()
		if #table < id then
			id = table[1]
		elseif id <= 0 then
			id = table[#table]
		end
		local target = searchPlayerFromID(table[id])
	if target then
		setPlayerSpec(player,target)
	end
end


function setPlayerSpec(player, target)
	local x, y, z = getElementPosition(player)
	local int, dim = player:getInterior(), player:getDimension()
	local id = target:getData("playerID")
	player:setData("specData",{pos={x,y,z,int,dim},index=id}  )
	player:setPosition( Vector3( target:getPosition() )  )
	player:setInterior( target:getInterior() )
	player:setDimension( target:getDimension() )
	player:setAlpha(0)
	player:setCollisionsEnabled(false)
	player:attach(target)
	toggleAllControls(player, false, false, false)
	player:setCameraTarget(target)
end


function cmdAspec(player, commands, ID)
	if not doesAdminHavePerm(player, "spec") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local specData = player:getData("specData")
	if specData then
		player:detach()
		player:setPosition(specData.pos[1], specData.pos[2], specData.pos[3])
		player:setDimension(specData.pos[4])
		player:setInterior(specData.pos[5])
		player:setCollisionsEnabled(true)
		player:setAlpha(255)
		player:setCameraTarget(player)
		toggleAllControls(player, true, true, false)
		unbindKey(player, "arrow_l", "down", switchSpectatorPlayer, 1)
		unbindKey(player, "arrow_r", "down", switchSpectatorPlayer, -1)
		player:removeData("specData")
	else
		if not tonumber(ID) then
			exports.titan_noti:showBox(player, "/aspec [ID gracza]")  
			return
		end

		local target = searchPlayerFromID( tonumber(ID) )
		
		if target == player then
			exports.titan_noti:showBox(player, "Błąd: Nie możesz podglądać samego siebie!") 
		elseif target then
			setPlayerSpec(player, target)
			bindKey (player, "arrow_l", "down", switchSpectatorPlayer, -1 )
			bindKey (player, "arrow_r", "down", switchSpectatorPlayer, 1 )
		else
			exports.titan_noti:showBox(player,"Nie znaleziono gracza o podanym ID")
		end

	end
end
addCommandHandler("aspec", cmdAspec, false, false)