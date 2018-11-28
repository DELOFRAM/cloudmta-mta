----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function synchronizeTires(veh, tire1, tire2, tire3, tire4)
	setVehicleWheelStates(veh, tire1, tire2, tire3, tire4)
end
addEvent("synchronizeTires", true)
addEventHandler("synchronizeTires", root, synchronizeTires)

wheelchains = {}
function createKolczatka(player, x, y, z, rz)
   
 
	--local playerDuty = exports.titan_orgs:getPlayerDuty(player)
	-- if not exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "kolczatka") then
	 --    exports.titan_noti:showBox(player, "Grupa, na której służbie jesteś nie posiada dostępu do zakładania blokad.")
	 --    return
	-- end

	if isElement(player:getData("cuffedBy")) then
		return exports.titan_noti:showBox(player, "Nie możesz stworzyć kolczatki będac skutym.")
	end
   
	if exports.titan_login:isLogged(player) then -- czy gracz jest zalogowany
		local playerDuty = exports.titan_orgs:getPlayerDuty(player)
		local groupID = getElementData(player, "groupDutyID")
		if not wheelchains[groupID] then wheelchains[groupID] = {} end
   
 
		if playerDuty and exports.titan_orgs:isGroup(playerDuty) then -- czy gracz ma grupe oraz duty
	   
			if exports.titan_orgs:doesGroupHavePerm(playerDuty, "kolczatka") or exports.titan_orgs:doesPlayerHavePerm(player, playerDuty, "kolczatka") then -- czy grupa lub gracz ma permy do tego
				local i
				if #wheelchains[groupID] < 1 then
					wheelchains[groupID][1] = {}
					i = 1
				else
					for i2=1,#wheelchains[groupID] do
						if not wheelchains[groupID][i2] then
							wheelchains[groupID][i2] = {}
							i = i2
							return
						end
					end
					i = #wheelchains[groupID]+1
					wheelchains[groupID][i] = {}
				end
   
				wheelchains[groupID][i].object = createObject(2892, x, y, z, 0, 0, rz)
				setElementData(wheelchains[groupID][i].object, "isKolczatka", true)
 
				wheelchains[groupID][i].elem = createElement("kolczatka")
				setElementData(wheelchains[groupID][i].elem, "object", wheelchains[groupID][i].object)
				setElementData(wheelchains[groupID][i].elem, "owner", player)
				setElementParent(wheelchains[groupID][i].object, wheelchains[groupID][i].elem)
				setElementParent(wheelchains[groupID][i].elem, player)
   
				if #wheelchains[groupID] and #wheelchains[groupID] == 6 then
					exports.titan_noti:showBox(player, "Limit kolczatek wyczerpał się - poprzednia kolczatka została usunięta.")
				else
					exports.titan_noti:showBox(player, "Stworzono kolczatkę")
				end
 
				if #wheelchains[groupID] and #wheelchains[groupID] == 6 then
					local wheelchain = wheelchains[groupID][1]
					destroyElement(wheelchain.object)
					destroyElement(wheelchain.elem)
					table.remove(wheelchains[groupID], 1)
				end
			   
			else   
				exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do korzystania z kolczatek.")
			end -- koniec: czy gracz lub grupa ma permy do tego
		   
		else
			exports.titan_noti:showBox(player, "Nie jesteś na służbie żadnej grupy.")
		end -- koniec: czy gracz ma grupe oraz duty
   
	end -- koniec: czy gracz jest zalogowany
end
addEvent("createKolczatka", true)
addEventHandler("createKolczatka", root, createKolczatka)

function destroyKolczatka(obj)
	local player = source
	if exports.titan_login:isLogged(player) then
		if isElement(player:getData("cuffedBy")) then
			return exports.titan_noti:showBox(player, "Nie możesz usunać kolczatki będac skutym.")
		end
		local groupID = getElementData(player, "groupDutyID")
		for k,v in ipairs(getElementsByType("kolczatka")) do
			if v == obj then
				local row
				for i,v in ipairs(wheelchains[groupID]) do
					if v.elem == obj then
						row = i
					end
				end
			destroyElement(getElementData(v, "object"))
			table.remove(wheelchains[groupID], row)
			destroyElement(v)
			end
		end
	end
end
addEvent("destroyKolczatka", true)
addEventHandler("destroyKolczatka", root, destroyKolczatka)


