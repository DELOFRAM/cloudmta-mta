QuizzesData = {}

function LoadQuizzes()
	local query = exports.titan_db:query("SELECT * FROM _quizzes")
	for i,v in ipairs(query) do
		CreateQuizzes(v.ID, v)
	end
end

function CreateQuizzes(index, data)
	QuizzesData[tonumber(index)] = data
end

function getQuizzes(index)
	return QuizzesData[index]
end

function finishQuizzes(player, finishedAction, complete)
	if complete then
		if finishedAction == 0 then
			local member = getElementData(player,"memberID")
			exports.titan_db:query_free("UPDATE ipb_members SET game_newPlayer = '0' WHERE member_id=?",member)
			triggerClientEvent(player,"turnOffLoginPanel", player, false)
			triggerClientEvent(player, "turnOnSubmitClick", player)
			exports.titan_noti:showBox(target,"Gratulacje zdałes quiz, możesz się teraz zalogować.")
		elseif finishedAction == 1 then
			outputChatBox("Zarejestrowano twoje prawo jazdy!")
		elseif finishedAction == 2 then
			local target = player
			local reason = "Za zdanie quizu z tematyki Role Play"
			local playerName = string.format("%s %s (%s)", tostring(getElementData(target,"name")), tostring(getElementData(target,"lastname")), tostring(getElementData(target, "globalName")))
			exports.titan_noti:showBox(target,"Gratulacje zdałes quiz, dodano tobie 10 cloudPoints.")
			exports.titan_hud:showPenalty("System", playerName, 13, reason, 10)
			exports.titan_misc:addCloudPoints(target, 10)
		end

	else
		if finishedAction == 0 then
			local member = getElementData(player,"memberID")
			exports.titan_db:query_free("UPDATE ipb_members SET game_newPlayer = '3',  WHERE member_id=?",member)
			triggerClientEvent(player,"turnOffLoginPanel", player, false)
			triggerClientEvent(player, "turnOnSubmitClick", player)
			exports.titan_noti:showBox(player,'Niestety nie zdałes quizu, ale spokojnie możesz się zalogować, nad twoim Nickiem będzie wyświetalny status "Oczekuje pomocy".')
		elseif finishedAction == 2 then
			local target = player
			local reason = "Nie zdanie quizu z tematyki Role Play"
			local playerName = string.format("%s %s (%s)", tostring(getElementData(target,"name")), tostring(getElementData(target,"lastname")), tostring(getElementData(target, "globalName")))
			exports.titan_noti:showBox(target,"Niesety nie zdałeś Quizu, zabrano tobie 10 cloudPoints.")
			exports.titan_hud:showPenalty("System", playerName, 13, reason, -10)
			exports.titan_misc:addCloudPoints(target, -10)
		elseif finishedAction == 3 then
			local target = player
			local playerName = string.format("%s %s (%s)", tostring(getElementData(target,"name")), tostring(getElementData(target,"lastname")), tostring(getElementData(target, "globalName")))
			local time = 250
			local reason = "Nie zdanie karnego quizu z tematyki Role Play!"
			reason = exports.titan_chats:addStop(exports.titan_chats:firstToUpper(reason))
			exports.titan_hud:showPenalty("System", playerName, 5, reason, time)
			outputChatBox("**Zostałeś umieszczony w Admin Jailu za nie zdanie Quizu**", target, 255, 0, 0)
			if isPedInVehicle(target) then
				removePedFromVehicle(target)
			end
			setElementPosition(target, 1174.3706,-1180.3267,87.0350)
			setElementDimension(target, math.random(5000, 10000))
			setElementData(target, "ajTime", time * 60)
			setElementData(target, "inAJ", true)
		end


	end
end
addEvent("Quizzes.finishedForPlayer", true)
addEventHandler("Quizzes.finishedForPlayer", root, finishQuizzes)

function onStart() 
	LoadQuizzes()
end
addEventHandler("onResourceStart", resourceRoot, onStart)

function selectForPlayerQuizzes(index)
	local data = getQuizzes(index)
	triggerClientEvent(source,"Quizzes.startForPlayer", source, data )
end
addEvent("Quizzes.selectForPlayer", true)
addEventHandler("Quizzes.selectForPlayer", root, selectForPlayerQuizzes)