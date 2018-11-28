function changeFlyMode(player, force)
exports.titan_fly:toggleAirBrake(player, force or false)
end
addCommandHandler( "afly", function(player)
	if not exports.titan_admin:doesAdminHavePerm(player, "superman") then return exports.titan_noti:showBox(player, "Nie posiadasz uprawnień do użycia tej komendy.") end
	if not getElementData(player, "adminFly") then
		bindKey(player, "0", "down", changeFlyMode)
		exports.titan_noti:showBox(player, "Włączyłeś tryb latania. Aby aktywować latanie wciśnij ALT + 0. Klawiszologia została wyświetlona w konsoli.")
		outputConsole("Klawiszologia:", player)
		outputConsole("W - Przód", player)
		outputConsole("S - Tył", player)
		outputConsole("A - Lewo", player)
		outputConsole("D - Prawo", player)				
		outputConsole("Space - Podwyższenie", player)
		outputConsole("Shift - Obniżenie", player)
		outputConsole("Alt - Spowolnij", player)
		outputConsole("Ctrl - Przyśpiesz", player)	
		outputConsole("Alt + 0 - Włączenie/Wyłączenie", player)	
		setElementData(player, "adminFly", true)
	else
		unbindKey(player, "0", "down", changeFlyMode)
		exports.titan_noti:showBox(player, "Wyłączyłeś tryb latania.")
		changeFlyMode(player, true)
		removeElementData(player, "adminFly")
	end
end)