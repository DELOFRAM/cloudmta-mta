function onPicker(id, hex, r, g, b)
	if id.name == "vehColor" then
		exports.titan_admin:assignColor(id, hex, r, g, b)
	elseif id.name == "groupColor" then
		exports.titan_admin:assignColor(id, hex, r, g, b)
	end
end
addEventHandler("onColorPickerOK", root, onPicker)