addCommandHandler("ainv", function(player)
if not isPlayerAdmin(player) then return end
if not doesAdminHavePerm(player, "ninja") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
if not getElementData(player, "ninja") then setElementAlpha(player, 0) else setElementAlpha(player, 255) end
setElementData(player, "ninja", not getElementData(player, "ninja"))
end)	