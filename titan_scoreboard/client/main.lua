----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-13 18:53:20
-- Ostatnio zmodyfikowano: 2016-01-19 22:17:59
----------------------------------------------------

local scoreFunc = {}

scoreFunc.playerPings = {}
scoreFunc.timer = nil


local sW, sH = guiGetScreenSize()
scoreFunc.font = dxCreateFont("client/files/MyriadPro-Regular.otf", 10, false)
scoreFunc.page = 1

scoreFunc.onPage = 20

scoreFunc.renderData = {sW / 2 - 384, sH / 2 - 320, 768, 640}

function scoreFunc.sort(op1, op2)
	if isElement(op1[1]) and isElement(op2[1]) then
		return op1[1]:getData("playerID") < op2[1]:getData("playerID")
	end
end

function scoreFunc.render()
	dxDrawImage(scoreFunc.renderData[1], scoreFunc.renderData[2], scoreFunc.renderData[3], scoreFunc.renderData[4], "client/files/main.png")

	local allPlayers = {}
	--table.insert(allPlayers, localPlayer)
	for k, v in ipairs(getElementsByType("player")) do
		if v ~= localPlayer then
			table.insert(allPlayers, {v, false})
		end
	end
	table.sort(allPlayers, scoreFunc.sort)
	local _allPlayers = allPlayers
	allPlayers = {}
	table.insert(allPlayers, {localPlayer, true})
	for i = 1, #_allPlayers do
		allPlayers[i + 1] = _allPlayers[i]
	end
	_allPlayers = nil

	local i = 1
	for k, v in ipairs(allPlayers) do
		if k >= (scoreFunc.page - 1) * scoreFunc.onPage and k < scoreFunc.page * scoreFunc.onPage then
			local isMe = v[2]
			v = v[1]
			local color = tocolor(215, 215, 215, 200)
			if v:getData("premium") then
				color = tocolor(255, 215, 0)
			end
			if isMe then
				color = tocolor(119, 140, 56, 200)
			end
			dxDrawText(v:getData("playerID") or "?", scoreFunc.renderData[1] + 110, scoreFunc.renderData[2] + 150 + (i - 1) * 20, scoreFunc.renderData[1] + 140, scoreFunc.renderData[2] + 165 + (i - 1) * 20, color, 1.0, scoreFunc.font, "center", "center")
			if v:getData("loggedIn") == 1 then
				dxDrawText(v:getData("name").." "..v:getData("lastname"), scoreFunc.renderData[1] + 140, scoreFunc.renderData[2] + 150 + (i - 1) * 20, scoreFunc.renderData[1] + 430, scoreFunc.renderData[2] + 165 + (i - 1) * 20, color, 1.0, scoreFunc.font, "center", "center")
			elseif v:getData("loggedIn") == 2 then
				dxDrawText(v:getData("globalName").." (wybiera postać)", scoreFunc.renderData[1] + 140, scoreFunc.renderData[2] + 150 + (i - 1) * 20, scoreFunc.renderData[1] + 430, scoreFunc.renderData[2] + 165 + (i - 1) * 20, color, 1.0, scoreFunc.font, "center", "center")
			else
				dxDrawText("(niezalogowany)", scoreFunc.renderData[1] + 140, scoreFunc.renderData[2] + 150 + (i - 1) * 20, scoreFunc.renderData[1] + 430, scoreFunc.renderData[2] + 165 + (i - 1) * 20, color, 1.0, scoreFunc.font, "center", "center")
			end
			dxDrawText(v:getData("cloudPoints") or "?", scoreFunc.renderData[1] + 430, scoreFunc.renderData[2] + 150 + (i - 1) * 20, scoreFunc.renderData[1] + 520, scoreFunc.renderData[2] + 165 + (i - 1) * 20, color, 1.0, scoreFunc.font, "center", "center")
			dxDrawText(scoreFunc.playerPings[v] or "--", scoreFunc.renderData[1] + 520, scoreFunc.renderData[2] + 150 + (i - 1) * 20, scoreFunc.renderData[1] + 605, scoreFunc.renderData[2] + 165 + (i - 1) * 20, color, 1.0, scoreFunc.font, "right", "center")
 
			i = i + 1
		end
	end
	--dxDrawRectangle(scoreFunc.renderData[1] + 590, scoreFunc.renderData[2] + 65, 100, 15)
	dxDrawText(#allPlayers, scoreFunc.renderData[1] + 150, scoreFunc.renderData[2] + 68, scoreFunc.renderData[1], scoreFunc.renderData[2] + 80, tocolor(215, 215, 215, 255), 0.9, scoreFunc.font, "left", "center")
	dxDrawText("strona "..scoreFunc.page.." z "..math.floor(#allPlayers / scoreFunc.onPage) + 1, scoreFunc.renderData[1] + 590, scoreFunc.renderData[2] + 68, scoreFunc.renderData[1] + 690, scoreFunc.renderData[2] + 80, tocolor(215, 215, 215, 255), 0.9, scoreFunc.font, "right", "center")
end

function getPlayersPing()
	scoreFunc.playerPings = {}
	for k, v in ipairs(getElementsByType("player")) do
		scoreFunc.playerPings[v] = getPlayerPing(v)
	end
end


function scoreFunc.bindKey(key, state)
	if localPlayer:getData("loggedIn") ~= 1 then return end
	if state == "down" then
		getPlayersPing()
		toggleControl("fire", false)
		toggleControl("aim_weapon", false)
		setControlState("aim_weapon", false)
		setControlState("fire", false)
		addEventHandler("onClientRender", root, scoreFunc.render)
		addEventHandler("onClientKey", root, scoreFunc.scrollList)
		setElementData(localPlayer, "scoreboard", true)
		scoreFunc.timer = setTimer(getPlayersPing, 2000, 0)
	else
		toggleControl("fire", true)
		toggleControl("aim_weapon", true)
		removeEventHandler("onClientRender", root, scoreFunc.render)
		removeEventHandler("onClientKey", root, scoreFunc.scrollList)
		setElementData(localPlayer, "scoreboard", false)
		scoreFunc.playerPings = {}
 		if isTimer(scoreFunc.timer) then killTimer(scoreFunc.timer) end
	end	
end
bindKey("tab", "both", scoreFunc.bindKey)

function scoreFunc.scrollList(button, press)
	if press then
		if button == "mouse_wheel_up" then
			scoreFunc.page = scoreFunc.page - 1
			if scoreFunc.page < 1 then scoreFunc.page = 1 end
		end
		if button == "mouse_wheel_down" then
			local players = #getElementsByType("player")
			if players >= scoreFunc.page * scoreFunc.onPage then
				scoreFunc.page = scoreFunc.page + 1
			end
		end
	end
end