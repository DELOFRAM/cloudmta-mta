----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local Class =
{
	func = {},

	files = 
	{
		{"files/compiled/8981.colcmta", "col", 8981},
		{"files/compiled/8981.txdcmta", "txd", 8981},
		{"files/compiled/8981.dffcmta", "dff", 8981},

		{"files/compiled/9352.colcmta", "col", 9352},
		{"files/compiled/9352.txdcmta", "txd", 9352},
		{"files/compiled/9352.dffcmta", "dff", 9352},

		{"files/compiled/9558.colcmta", "col", 9558},
		{"files/compiled/9558.txdcmta", "txd", 9558},
		{"files/compiled/9558.dffcmta", "dff", 9558},

		{"files/compiled/9567.colcmta", "col", 9567},
		{"files/compiled/9567.txdcmta", "txd", 9567},
		{"files/compiled/9567.dffcmta", "dff", 9567},

		{"files/compiled/9568.colcmta", "col", 9568},
		{"files/compiled/9568.txdcmta", "txd", 9568},
		{"files/compiled/9568.dffcmta", "dff", 9568},

		{"files/compiled/9589.colcmta", "col", 9589},
		{"files/compiled/9589.txdcmta", "txd", 9589},
		{"files/compiled/9589.dffcmta", "dff", 9589},

		{"files/compiled/galeria.colcmta", "col", 4016},
		{"files/compiled/galeria.txdcmta", "txd", 4016},
		{"files/compiled/galeria.dffcmta", "dff", 4016},

		{"files/compiled/lod_galeria.dffcmta", "dff", 4026},

		{"files/compiled/remiza.colcmta", "col", 3986},
		{"files/compiled/remiza.txdcmta", "txd", 3986},
		{"files/compiled/remiza.dffcmta", "dff", 3986},

		{"files/compiled/lod_remiza.dffcmta", "dff", 4070},

		{"files/compiled/komisariat.colcmta", "col", 5136},
		{"files/compiled/komisariat.txdcmta", "txd", 5136},
		{"files/compiled/komisariat.dffcmta", "dff", 5136},

		{"files/compiled/lanbloki.txdcmta", "txd", 3984},
		{"files/compiled/FBI.dffcmta", "dff", 3984},

		{"files/compiled/midranhus_LAS.colcmta", "col", 3617},
		{"files/compiled/midranhus_LAS.txdcmta", "txd", 3617},
		{"files/compiled/midranhus_LAS.dffcmta", "dff", 3617},
	},
	queue =  {},
	stateText = "Dekompilator CloudMTA 1.0a",

	cipher = "3627dw",
	cipher2 = "h8cshdvls9oef3th"
}

function Class.func.decompileFunc()
	local filesCompiled = 0
	addEventHandler("onClientRender", root, Class.func.render)
	-- Sprawdzanie, czy pliki istnieja
	Class.stateText = "Sprawdzam, czy pliki istnieja..."
	for k, v in ipairs(Class.files) do
		if fileExists(v[1]) then
			Class.stateText = string.format("%d/%d | Plik [%s] istnieje!", k, #Class.files, v[1])
			table.insert(Class.queue, v)
		else
			Class.stateText = string.format("%d/%d | Plik [%s] nie istnieje!", k, #Class.files, v[1])
		end
	end
	if #Class.queue > 0 then
		for k, v in ipairs(Class.queue) do
			Class.stateText = string.format("Dekompiluję plik [%s]...", v[1])
			local fileContent = Class.func.decompiler(v[1])
			if fileContent then
				if v[2] == "dff" then
					local dff = engineLoadDFF(fileContent)
					if dff then
						engineReplaceModel(dff, v[3])
						filesCompiled = filesCompiled + 1
					end
				elseif v[2] == "txd" then
					local txd = engineLoadTXD(fileContent)
					if txd then
						engineImportTXD(txd, v[3])
						filesCompiled = filesCompiled + 1
					end
				elseif v[2] == "col" then
					local col = engineLoadCOL(fileContent)
					if col then
						engineReplaceCOL(col, v[3])
						filesCompiled = filesCompiled + 1
					end
				end
				fileContent = nil
			else
				Class.stateText = string.format("Wystapił bład podczas dekompilacji pliku [%s]...", v[1])
				outputDebugString(Class.stateText)
			end
		end
	end
	Class.stateText = string.format("Dekompilacja zakonczona. Zdekompilowano %d/%d plików.", filesCompiled, #Class.files)
	setTimer(function()
		removeEventHandler("onClientRender", root, Class.func.render)
		exports.titan_login:onResStart()
	end, 2000, 1)
end

function Class.func.decompiler(fileDir)
	local file = fileOpen(fileDir, true)
	if not file then return false end
	local fContent = fileRead(file, fileGetSize(file))
	fileClose(file)
	if not fContent then return false end
	fContent = teaDecodeBinary(fContent, Class.cipher2)
	fContent = string.sub(fContent, 0, string.len(fContent) - string.len(Class.cipher) * 2)
	return fContent
end

function Class.func.render()
	dxDrawText(Class.stateText, 0, 0)
end

function teaDecodeBinary( data, key )
	return base64Decode( teaDecode( data, key ) )
end

addEventHandler("onClientResourceStart", resourceRoot, Class.func.decompileFunc)
--Class.func.decompileFunc()