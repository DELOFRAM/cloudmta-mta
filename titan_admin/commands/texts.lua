----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:42:53
-- Ostatnio zmodyfikowano: 2016-01-09 15:42:59
----------------------------------------------------

function cmdText(player, command, ...)
	if not doesAdminHavePerm(player, "texts") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	local args = {...}
	arg1 = args[1]
	arg1 = string.lower(tostring(arg1))
	if arg1 == "lista" then
		local pX, pY, pZ = getElementPosition(player)
		local texts = {}
		for k, v in ipairs(getElementsByType("3dtext")) do
			local tX, tY, tZ = getElementPosition(v)
			if getDistanceBetweenPoints3D(pX, pY, pZ, tX, tY, tZ) <= 10 then
				table.insert(texts, v)
			end
		end
		if #texts <= 0 then
			exports.titan_noti:showBox(player, "Nie znaleziono żadnych 3DTextów obok Ciebie.")
			return
		end
		triggerClientEvent(player, "createTextGUI", player, texts)
	elseif arg1 == "stworz" then
		local x, y, z = getElementPosition(player)
		local int = getElementInterior(player)
		local vw = getElementDimension(player)

		local r = args[2]
		local g = args[3]
		local b = args[4]
		local text = table.concat({...}, " ", 5)

		if not tonumber(r) or not tonumber(g) or not tonumber(b) or not text or string.len(tostring(text)) < 1 then
			outputChatBox("TIP: /atext stworz [r] [g] [b] [tekst]", player, 200, 200, 200)
			return
		end
		r = tonumber(r)
		g = tonumber(g)
		b = tonumber(b)
		text = tostring(text)
		if r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255 then
			outputChatBox("Podano niepoprawny kolor 3DTextu.", player, 200, 200, 200)
			return
		end
		exports.titan_3dtexts:addNewText(x, y, z, vw, int, r, g, b, text)
		exports.titan_noti:showBox(player, "Tekst został stworzony.")
	else
		outputChatBox("TIP: /atext [lista, stworz]", player, 200, 200, 200)
		return
	end
end
addCommandHandler("atext", cmdText, false, false)

function onClientDeleteText(textID)
	local text = exports.titan_3dtexts:deleteText(textID)
	if not text then
		exports.titan_noti:showBox(source, "Nie znaleziono tekstu.")
		return
	else
		exports.titan_noti:showBox(source, "Tekst został usunięty.")
		return
	end
end
addEvent("onClientDeleteText", true)
addEventHandler("onClientDeleteText", root, onClientDeleteText)