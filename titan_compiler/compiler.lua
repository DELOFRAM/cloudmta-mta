----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local files = 
{
	"galeria.col",
	"galeria.txd",
	"galeria.dff",

	"komisariat.col",
	"komisariat.txd",
	"komisariat.dff",

	"midranhus_LAS.col",
	"midranhus_LAS.txd",
	"midranhus_LAS.dff",

	"midranhus_LAS.col",
	"midranhus_LAS.txd",
	"midranhus_LAS.dff",

	"remiza.col",
	"remiza.txd",
	"remiza.dff",

	"lod_galeria.dff",
	"lod_remiza.dff",

	"FBI.dff",

	"lanbloki.txd"
}

local cipher = "3627dw"
local cipher2 = "h8cshdvls9oef3th"


function teaEncodeBinary( data, key )
    return teaEncode( base64Encode( data ), key )
end

function compileThisShit()
	local time = getTickCount()
	if type(files) == "table" then
		for k, v in ipairs(files) do
			outputConsole("")
			outputConsole("*")
			outputConsole("**")
			local dir = string.format("files/%s", v)
			if fileExists(dir) then
				local file = fileOpen(dir, true)
				if file then
					outputConsole("*** Wczytano plik ["..dir.."]")
					-- DZIEJE SIĘ MAGIA
					local fContent = fileRead(file, fileGetSize(file))
					if fContent then
						outputConsole("*** Pobrano zawartość pliku ["..dir.."]")
						fContent = fContent..cipher..cipher
						local newDir = "files/tempcompiled/"..v.."cmta"
						if fileExists(newDir) then fileDelete(newDir) end
						local newFile = fileCreate(newDir)
						if newFile then
							outputConsole("*** Stworzono plik ["..newDir.."]")
							fContent = teaEncodeBinary(fContent, cipher2)
							if fileWrite(newFile, fContent) then
								outputConsole("*** Zapisano zawartość pliku ["..newDir.."]")
							else
								outputConsole("*** Wystapił bład podczas zapisywania zawartości pliku ["..newDir.."]")
							end
							fileClose(newFile)
							outputConsole("*** Plik ["..newDir.."] został zamknięty.")
						else
							outputConsole("*** Nie udało się stworzyć pliku ["..newDir.."]")
						end
					else
						outputConsole("*** Nie udało się pobrać zawartości pliku ["..dir.."]")
					end
					fileClose(file)
					outputConsole("*** Plik ["..dir.."] został zamknięty")

				else
					outputConsole("*** Nie udało się wczytać pliku ["..dir.."]")
				end

			else
				outputConsole("*** Plik ["..dir.."] nie istnieje")
			end
		end
	end
	outputDebugString("[COMPILER] Kompilacja zajęła "..getTickCount() - time.."ms.")
end
compileThisShit()
--decompileShit("files/compiled/badge.txdcmta")