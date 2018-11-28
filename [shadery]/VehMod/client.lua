function applySkin()
	
	txd = engineLoadTXD("mod.txd", 541)
	
	engineImportTXD(txd, 541)
	
	dff = engineLoadDFF("mod.dff", 541)
	
	engineReplaceModel(dff, 541)
	
end

addEventHandler("onClientResourceStart", resourceRoot, applySkin)