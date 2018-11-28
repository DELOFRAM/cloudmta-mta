Cornner = {}
Cornner.func = {}
Cornner.data = {}

function Cornner.func.onPlayerHitCornner(hitElement, matchingDimension)
	if matchingDimension then
		if isElement(hitElement) and getElementType(hitElement) == "player" then
			if hitElement:getType() == "player" and exports.titan_login:isLogged(hitElement) and not isPedInVehicle(hitElement) then
				if hitElement:getInterior() == source:getInterior() then
				local id = source:getData("id")
					if Cornner.data[id].player == nil then
						local drug = getPlayerDrug(hitElement)
						if not drug then
							return exports.titan_noti:showBox(hitElement,"Nie posiadasz przy sobie żadnych narkotyków do sprzedaży.")
						end
							Cornner.data[id].drug = drug
						-- if Cornner.data[id].maxLimit > Cornner.data[id].amount then
							local pos = hitElement:getPosition()
							local location = getZoneName (pos)
							Cornner.data[id].player = hitElement
							exports.titan_noti:showBox(hitElement, "Rozpocząłeś handel na dzielnicy "..location..".")
							hitElement:setData("Cornner:id",id)
							generationNewNPC(id)
						-- else
							--exports.titan_noti:showBox(hitElement,"Na tej dzielnicy limit handlu został już przekroczony!")
						-- end
					else
						exports.titan_noti:showBox(hitElement, "Ten cornner jest juz zajęty!")
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit", resourceRoot, Cornner.func.onPlayerHitCornner)


function Cornner.func.onPlayerLeaveCornner(hitElement, matchingDimension)
	if matchingDimension then
		if isElement(hitElement) then
			if hitElement:getType() == "player" and exports.titan_login:isLogged(hitElement) and not isPedInVehicle(hitElement) then
			local id = source:getData("id")
			if Cornner.data[id].player == hitElement then
					local id = source:getData("id")
					if isElement( Cornner.data[id].ped ) then
						destroyElement( Cornner.data[id].ped )
					end
					exports.titan_noti:showBox(hitElement, "Opuściłeś cornner. Twoja ostatnia transakcja zostanie anulowana.")
					Cornner.data[id].player = nil
				end
			end
		end
	end
end
addEventHandler("onMarkerLeave", resourceRoot, Cornner.func.onPlayerLeaveCornner)

function Cornner.func.reload(ID)
	if Cornner.data[ID] then
		Cornner.data[ID] = nil
		destroyElement( Cornner.data[db.ID].marker )
		Cornner.func.create(ID)
		return true
	else
		return false
	end
end

function Cornner.func.load(db)
	if Cornner.data[db.ID] == nil then
		Cornner.data[db.ID] = db
		Cornner.data[db.ID].marker = createMarker(db.x, db.y, db.z, "cylinder", 1.5, 255, 0, 0, 100)
		Cornner.data[db.ID].marker:setData("id",db.ID)
		setElementInterior(Cornner.data[db.ID].marker, db.interior)
		setElementDimension(Cornner.data[db.ID].marker, db.dimension)
		return true
	else
		return false
	end
end

function Cornner.func.destroy(ID)
	if Cornner.data[ID] then
		Cornner.data[ID] = nil
		destroyElement( Cornner.data[db.ID].marker )
		exports.titan_db:query("DELETE * FROM _corners WHERE ID=?",ID)
		return true
	else
		return false
	end
end

addEventHandler("onResourceStart", resourceRoot, function()
	local query = exports.titan_db:query("SELECT * FROM _corners")
	local count = 0
	local time = getTickCount(  )
	if(#query > 0) then
		for i = 1, #query do
			if Cornner.func.load(query[i]) then
				count = count+1
			end
		end
		outputDebugString(string.format("[Cornners] Załadowano cornnery (%d). | %d ms", count, getTickCount() - time))
	end
end)
