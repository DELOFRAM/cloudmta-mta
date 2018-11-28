----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local function onResStart()
	local txd, dff, col
	-----------------------
	-- ODZNAKA POLICYJNA --
	-----------------------	
	dff = engineLoadDFF("customModels/files/badge.dff", 0)
	txd = engineLoadTXD("customModels/files/badge.txd")
	engineImportTXD(txd, 1853)
	engineReplaceModel(dff, 1853)

	--------------
	-- HALLIGAN --
	--------------
	dff = engineLoadDFF("customModels/files/halligan.dff", 0)
	txd = engineLoadTXD("customModels/files/halligan.txd")
	engineImportTXD(txd, 3944)
	engineReplaceModel(dff, 3944)

	-----------
	-- KOGUT --
	-----------
	dff = engineLoadDFF("customModels/files/kogut.dff", 0)
	txd = engineLoadTXD("customModels/files/kogut.txd")
	col = engineLoadCOL("customModels/files/kogut.col")

 	engineReplaceCOL(col, 1854)
	engineImportTXD(txd, 1854)
	engineReplaceModel(dff, 1854)

	local object = createObject(3944, 1497.78, -1730.96, 13.5)
	setElementCollisionsEnabled(object, false)
end
addEventHandler("onClientResourceStart", resourceRoot, onResStart)