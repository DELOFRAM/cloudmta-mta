----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
-- Stworzono:   2016-01-09 15:43:25
-- Ostatnio zmodyfikowano: 2016-01-09 15:43:27
----------------------------------------------------

function editGroup_save(groupID, name, tag, colorR, colorG, colorB, perms)
	exports.titan_orgs:saveGroupEdit(groupID, name, tag, colorR, colorG, colorB, perms)
	exports.titan_noti:showBox(source, "Pomyślnie zapisano ustawienia grupy.")
	return
end
addEvent("groupEdit.save", true)
addEventHandler("groupEdit.save", root, editGroup_save)