----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

addEvent("addAd", true)

function addAd(minutes, reporter, text)
	if text:gsub(" ", "") == "" then return outputDebugString("[TITAN NEWS] Nie wysyłam pustego tekstu do bazy") end
	if not exports.titan_db:query_free("INSERT INTO _ads (text, time, reporter) VALUES (?, ?, ?)", text, minutes, reporter) then
	exports.titan_noti:showBox(client, "Nie udało się wykonać zapytania do bazy danych! Skontaktuj się z Administratorem Technicznym i przekaż mu wydruk z konsoli!")
	outputConsole("---------- INFORMACJA DLA TECHNICZNEGO ----------", client)
	outputConsole("-- _news\server\ads.s.lua:5 query_free", client)
	outputConsole("---------- INFORMACJA DLA TECHNICZNEGO ----------", client)
	else
	exports.titan_noti:showBox(client, "Pomyślnie dodano reklamę do bazy, oczekuj na pojawienie się jej na pasku!")
	showAd()
	end
end
addEventHandler("addAd", getRootElement(), addAd)