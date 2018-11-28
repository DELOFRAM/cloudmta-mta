----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

local dbFunc = 
{
	queries = 0,
	connectDate = 0,

	--host 	= "localhost",
	--user 	= "root",
	--pass 	= "dupa",
	--db 	= "cmta",

	dbHandler = nil
}

function dbFunc.getCredientals()
	local xmlFile = xmlLoadFile("dbSecret.xml")
	if not xmlFile then return false end

	local host = xmlFindChild(xmlFile, "dbHost", 0)
	local user = xmlFindChild(xmlFile, "dbUser", 0)
	local pass = xmlFindChild(xmlFile, "dbPass", 0)
	local db = xmlFindChild(xmlFile, "dbDatabase", 0)

	if not host or not user or not pass or not db then return false end

	host = xmlNodeGetValue(host)
	user = xmlNodeGetValue(user)
	pass = xmlNodeGetValue(pass)
	db = xmlNodeGetValue(db)

	if not host or not user or not pass or not db then return false end
	xmlUnloadFile(xmlFile)

	return host, user, pass, db
end

function dbFunc.connect()

	local host, user, pass, db = dbFunc.getCredientals()
	if not host then
		outputDebugString("[DB] Nie można połączyć z bazą danych!")
		outputServerLog("[DB] Nie można połączyć z bazą danych!")
		return false
	end

	dbFunc.dbHandler = dbConnect("mysql", string.format("dbname=%s;host=%s;charset=utf8", db, host), user, pass, "share=1")
	if dbFunc.dbHandler then
		outputDebugString("[DB] Połączono z bazą danych.")
		query("SET NAMES utf8")
		dbFunc.connectDate = getRealTime().timestamp
	else
		outputDebugString("[DB] Błąd łączenia z bazą danych.")
	end
end
addEventHandler("onResourceStart", resourceRoot, dbFunc.connect)

function dbFunc.disconnect()
	if isElement(dbFunc.dbHandler) then
		destroyElement(dbFunc.dbHandler)
	end
	outputDebugString(string.format("[DB] Rozłączono z bazą danych. | Wykonano %d zapytań. | Połączenie trwało %d minut.", dbFunc.queries, math.floor((getRealTime().timestamp - dbFunc.connectDate) / 60)))
end
addEventHandler("onResourceStop", resourceRoot, dbFunc.disconnect)

function query(...)
	local time = getTickCount()
	local data = {...}
	dbFunc.queries = dbFunc.queries + 1
	local prepareString = dbPrepareString(dbFunc.dbHandler, ...)
	local queryHandler = dbQuery(dbFunc.dbHandler, prepareString)
	if not queryHandler then return false end
	local res, rows, lastID = dbPoll(queryHandler, -1)
	if res then
		--outputDebugString(string.format("[DB][TIME: %dms] query: [%s]", getTickCount() - time, prepareString), 3, 150, 180, 160)
		dbFree(queryHandler)
		return res, rows, lastID
	else
		outputDebugString(string.format("[DBERROR][TIME: %dms] query: [%s]", getTickCount() - time, prepareString), 1)
		dbFree(queryHandler)
		return false
	end
end

function query_free(...)
	local data = {...}
	dbFunc.queries = dbFunc.queries + 1
	local prepareString = dbPrepareString(dbFunc.dbHandler, ...)
	--outputDebugString(string.format("[DB] queryFree: [%s]", prepareString))
	local queryHandler = dbQuery(dbFunc.dbHandler, prepareString)
	if not queryHandler then
		outputDebugString(string.format("[DB][ERROR] queryFree: [%s]", prepareString))
		return false
	end
	if dbFree(queryHandler) then return true else return false end
end

function escapeStrings(str)
	local String = string.gsub(tostring(str),"'","")
	String = string.gsub(String,'"',"")
	String = string.gsub(String,';',"")
	String = string.gsub(String,"\\","")
	String = string.gsub(String,"/*","")
	String = string.gsub(String,"*/","")
	String = string.gsub(String,"'","")
	String = string.gsub(String,"`","")
	return String
end
