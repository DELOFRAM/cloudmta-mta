function setCutscene(player, id)
assert(player, "Nie podano argumentu gracza!")
assert(id, "Nie podano ID cutscenki!")
triggerClientEvent(player, "setCutscene", player, id)
end