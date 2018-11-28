----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

function groupMessageIC(groupID, groupName, message)
	local time = getRealTime()
	local day, month, year = time.monthday, time.month + 1, time.year + 1900
	local filePath = string.format("logfiles/group/chat/%d/IC/%0.2d-%0.2d-%0.4d.txt", groupID, day, month, year)
	if(not fileExists(filePath)) then
		local newFile = fileCreate(filePath)
		fileClose(newFile)
	end
	local logFile = fileOpen(filePath)
	if(not logFile) then
		outputDebugString("Nie udało się otworzyć pliku z logami.")
		return
	end
	fileSetPos(logFile, fileGetSize(logFile))
	fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d] %s\n", time.hour, time.minute, time.second, message))
	fileClose(logFile)
	return
end

function groupMessageOOC(groupID, groupName, message)
	local time = getRealTime()
	local day, month, year = time.monthday, time.month + 1, time.year + 1900
	local filePath = string.format("logfiles/group/chat/%d/OOC/%0.2d-%0.2d-%0.4d.txt", groupID, day, month, year)
	if(not fileExists(filePath)) then
		local newFile = fileCreate(filePath)
		fileClose(newFile)
	end
	local logFile = fileOpen(filePath)
	if(not logFile) then
		outputDebugString("Nie udało się otworzyć pliku z logami.")
		return
	end
	fileSetPos(logFile, fileGetSize(logFile))
	fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d] %s\n", time.hour, time.minute, time.second, message))
	fileClose(logFile)
	return
end

function adminLog(playerName, message)
	adminLogPlayer(playerName, message)
	local day, month, year = getRealTime().monthday, getRealTime().month + 1, getRealTime().year + 1900
	if(day < 10) then day = string.format("0%d", day) end
	if(month < 10) then month = string.format("0%d", month) end

	local filePath = string.format("logfiles/admin/%s-%s-%s.txt", tostring(day), tostring(month), tostring(year))

	if(not fileExists(filePath)) then
		local newFile = fileCreate(filePath)
		fileClose(newFile)
	end

	local logFile = fileOpen(filePath)
	if(not logFile) then
		outputDebugString("Nie udało się otworzyć pliku z logami.")
		return
	end

	local time = getRealTime()
	message = string.format("[%0.2d:%0.2d:%0.2d] %s", time.hour, time.minute, time.second, message)

	fileSetPos(logFile, fileGetSize(logFile))
	fileWrite(logFile, string.format("%s\n", message))
	fileClose(logFile)
	return
end

function adminLogPlayer(playerName, message)
	local day, month, year = getRealTime().monthday, getRealTime().month + 1, getRealTime().year + 1900
	if(day < 10) then day = string.format("0%d", day) end
	if(month < 10) then month = string.format("0%d", month) end

	local filePath = string.format("logfiles/admin_individual/%s/%s-%s-%s.txt", tostring(playerName), tostring(day), tostring(month), tostring(year))

	if(not fileExists(filePath)) then
		local newFile = fileCreate(filePath)
		fileClose(newFile)
	end

	local logFile = fileOpen(filePath)
	if(not logFile) then
		outputDebugString("Nie udało się otworzyć pliku z logami.")
		return
	end

	local time = getRealTime()
	message = string.format("[%0.2d:%0.2d:%0.2d] %s", time.hour, time.minute, time.second, message)

	fileSetPos(logFile, fileGetSize(logFile))
	fileWrite(logFile, string.format("%s\n", message))
	fileClose(logFile)
	return
end

function playerWhisperLog(player, message)
	local time = getRealTime()
	local day, month, year = time.monthday, time.month + 1, time.year + 1900
	local filePath = string.format("logfiles/player/whisper/%s/%0.2d-%0.2d-%0.4d.txt", player:getData("globalName"), day, month, year)
	if(not fileExists(filePath)) then
		local newFile = fileCreate(filePath)
		fileClose(newFile)
	end
	local logFile = fileOpen(filePath)
	if(not logFile) then
		outputDebugString("Nie udało się otworzyć pliku z logami.")
		return
	end
	fileSetPos(logFile, fileGetSize(logFile))
	fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d] %s\n", time.hour, time.minute, time.second, message))
	fileClose(logFile)
	return
end

function playerLog(player, category, message)
	if isElement(player) and getElementType(player) == "player" then
		local time = getRealTime()
		local day, month, year = time.monthday, time.month + 1, time.year + 1900
		local filePath = string.format("logfiles/player/%s/%d/%0.2d-%0.2d-%0.4d.txt", category, player:getData("charID"), day, month, year)
		if(not fileExists(filePath)) then
			local newFile = fileCreate(filePath)
			fileClose(newFile)
		end
		local logFile = fileOpen(filePath)
		if(not logFile) then
			outputDebugString("Nie udało się otworzyć pliku z logami.")
			return
		end
		fileSetPos(logFile, fileGetSize(logFile))
		fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d] %s\n", time.hour, time.minute, time.second, message))
		fileClose(logFile)
		return
	end
end

function adminChatLog(message)
	local time = getRealTime()
	local day, month, year = time.monthday, time.month + 1, time.year + 1900
	if(day < 10) then day = string.format("0%d", day) end
	if(month < 10) then month = string.format("0%d", month) end

	local filePath = string.format("logfiles/admin/chat/%s-%s-%s.txt", tostring(day), tostring(month), tostring(year))

	if(not fileExists(filePath)) then
		local newFile = fileCreate(filePath)
		fileClose(newFile)
	end

	local logFile = fileOpen(filePath)
	if(not logFile) then
		outputDebugString("Nie udało się otworzyć pliku z logami.")
		return
	end

	fileSetPos(logFile, fileGetSize(logFile))
	fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d] %s\n", time.hour, time.minute, time.second, message))
	fileClose(logFile)
	return
end

------------------
-- LOGI KOMEND ADMINISTRACJA --
------------------

function commandLog(player,command,arg,player2)
    local time = getRealTime()
    local day, month, year = time.monthday, time.month + 1, time.year + 1900
    local filePath = string.format("logfiles/admin/commands/%0.2d-%0.2d-%0.4d.txt", day, month, year)
    local arg=table.concat(arg, " ")
    if(not fileExists(filePath)) then
        local newFile = fileCreate(filePath)
        fileClose(newFile)
    end
    local logFile = fileOpen(filePath)
    if(not logFile) then
        outputDebugString("Nie udało się otworzyć pliku z logami.")
        return
    end
    fileSetPos(logFile, fileGetSize(logFile))
    if player2 then
        fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d](%s) %s %s: /%s %s || %s %s: %d\n", time.hour, time.minute, time.second, player:getData("globalName"), player:getData("name"), player:getData("lastname"), command, arg, player2:getData("name"), player2:getData("lastname"), player2:getData("charID")))
    else
        fileWrite(logFile, string.format("[%0.2d:%0.2d:%0.2d] (%s) %s %s: /%s %s\n", time.hour, time.minute, time.second, player:getData("globalName"), player:getData("name"), player:getData("lastname"), command, arg))
    end
    fileClose(logFile)
    return
end

------------------
-- LOGI LOGOWAŃ --
------------------

function createLoginLog(player, charID)
	if(isElement(player)) then
		local query, rows, lastID = exports.titan_db:query("INSERT INTO _login_logs SET charID = ?, ip = ?, serial = ?, time = UNIX_TIMESTAMP()", charID, getPlayerIP(player), getPlayerSerial(player))
		setElementData(player, "loginLogID", lastID)
	end
end

function saveLoginLogQuit(player)
	local logID = getElementData(player, "loginLogID")
	if tonumber(logID) then
		exports.titan_db:query_free("UPDATE _login_logs SET time_exit = UNIX_TIMESTAMP() WHERE ID = ?", logID)
	end
end