function toggleHDRShader(player, state)
	triggerClientEvent(player, "switchContrast", resourceRoot, state)
end