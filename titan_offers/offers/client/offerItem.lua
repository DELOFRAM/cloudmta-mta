----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local offerItem = {}
local sW, sH = guiGetScreenSize()
function offerItem.gCreate(data, element)
	offerItem.okno = guiCreateWindow(sW / 2 - 326 / 2, sH / 2 - 341 / 2, 326, 341, "Oferowanie przedmiotu graczowi", false)
	guiWindowSetSizable(offerItem.okno, false)
	offerItem.lista = guiCreateGridList(10, 27, 306, 207, false, offerItem.okno)
	guiGridListAddColumn(offerItem.lista, "ID", 0.45)
	guiGridListAddColumn(offerItem.lista, "Nazwa przedmiotu", 0.45)
	offerItem.cena = guiCreateEdit(20, 256, 294, 22, "", false, offerItem.okno)
	offerItem.button1 = guiCreateButton(10, 292, 152, 39, "Oferuj", false, offerItem.okno)
	offerItem.button2 = guiCreateButton(162, 292, 152, 38, "Anuluj", false, offerItem.okno)
	offerItem.label = guiCreateLabel(10, 240, 109, 16, "Cena", false, offerItem.okno)
	guiSetFont(offerItem.label, "default-bold-small")
	addEventHandler("onClientGUIClick", offerItem.button2, offerItem.gDelete, false)
	addEventHandler("onClientGUIClick", offerItem.button1, offerItem.gOffer, false)
	exports.titan_cursor:showCustomCursor("offersOfferItem")
	offerItem.target = element
	for k, v in ipairs(data) do
		local row = guiGridListAddRow(offerItem.lista)
		guiGridListSetItemText(offerItem.lista, row, 1, v.ID, false, false)
		guiGridListSetItemText(offerItem.lista, row, 2, v.name, false, false)
		guiGridListSetItemData(offerItem.lista, row, 1, v.ID)
	end
end
addEvent("offerItem.gCreate", true)
addEventHandler("offerItem.gCreate", root, offerItem.gCreate)

function offerItem.gDelete()
	if isElement(offerItem.okno) then destroyElement(offerItem.okno) end
	exports.titan_cursor:hideCustomCursor("offersOfferItem")
end

function offerItem.gOffer()
	local row = guiGridListGetSelectedItem(offerItem.lista)
	if not row or row == -1 then return end
	local data = guiGridListGetItemData(offerItem.lista, row, 1)
	if not tonumber(data) then return end
	local price = guiGetText(offerItem.cena)
	if not tonumber(price) or tonumber(price) < 0 then return exports.titan_noti:showBox("Musisz podać cenę, która będzie większa lub równa 0.") end
	offerItem.gDelete()
	triggerServerEvent("gFunc.itemOffer", localPlayer, offerItem.target, tonumber(data), tonumber(price))
end