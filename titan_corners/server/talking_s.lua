function findAmountInString(text)
local amount = false
for word in string.gmatch(text, "%d+") do
    if tonumber(word) then
    	local word = word:gsub("$","")
        if string.sub(text, string.find(text,word,1)+string.len(word)+1 , string.find(text,word,1)+string.len(word)+1) == "$" or string.sub(text, string.find(text,word,1)-1  ) == "$" then
            	amount = word
            end
        end
    end
    return amount
end


function talkWithNPC(message, type)
	if type == 0 then
		--outputChatBox(message)
		local amount = findAmountInString(message)
		amount = 19
		--outputChatBox(tostring(amount))
		if tonumber(amount) then
			local id = source:getData("Cornner:id")
			if Cornner.data[id] then
				if isElement( Cornner.data[id].ped ) then
					if Cornner.data[id].ped:getData("money") >= tonumber(amount) then
						talk(Cornner.data[id].ped, "Dzięki, masz tu swoją dolę, ja spadam, bo kręca się tutaj gliny")
						exports.titan_items:removeItem( Cornner.data[id].Transaction[1], true)
						triggerEvent( "updatePlayerEquip", source, source )
						givePlayerMoney(source,amount)
						triggerClientEvent( "AI:create", source, id, Cornner.data[id].ped, Cornner.data[id].marker, "walkAwayFromTarget" )
						--removeEventHandler( "onPlayerChat", source, talkWithNPC)
						Cornner.data[id].amount = Cornner.data[id].amount+1
						exports.titan_db:query("UPDATE _corners SET amount = ? WHERE ID=?",Cornner.data[id].amount, id)
					else
						talk(Cornner.data[id].ped, "Ey, trochę za dużo, może zejdziesz trochę z ceny do "..Cornner.data[id].ped:getData("money").." dolarów?")
						local waiting = Cornner.data[id].ped:getData("wait") or 0
						Cornner.data[id].ped:setData("wait",waiting + 1)
					end
				end
			end

		else
			local id = source:getData("Cornner:id")
			if Cornner.data[id] then
				if isElement( Cornner.data[id].ped ) then
					local waiting = Cornner.data[id].ped:getData("wait") or 0
					if waiting > 3 then
						--removeEventHandler( "onPlayerChat", source, talkWithNPC)
						triggerClientEvent( "AI:create", source, id, Cornner.data[id].ped, Cornner.data[id].marker, "walkAwayFromTarget" )
					end
					local gender = Cornner.data[id].ped:getData("gender")
					local text = config.message["question"][gender][ math.random(1, #config.message["question"]) ]
					talk(Cornner.data[id].ped,text)
					Cornner.data[id].ped:setData("wait",waiting+1)
				end
			end
		end
	end
end
