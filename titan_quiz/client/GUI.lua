GUIEditor = {
    window = {},
    label = {},
    radiobutton = {},
    button = {}
}

ClientQuiz = {}
ClientQuiz.Questions = {}
ClientQuiz.question = nil
ClientQuiz.good = nil
ClientQuiz.bad = nil


function createGUI()
	height = 0.10
	for i=1,#ClientQuiz.Questions[ClientQuiz.question].option do if i ~= 1 then height = height+0.10 end end
	GUIEditor.window[1] = guiCreateWindow(0.35, 0.26, 0.29, height+0.10, "Pytanie "..ClientQuiz.question.."/"..#ClientQuiz.Questions, true)
	guiWindowSetSizable(GUIEditor.window[1], false)
	GUIEditor.label[1] = guiCreateLabel(0.03, 0.07, 0.93, 0.10,ClientQuiz.Questions[ClientQuiz.question].name or "Pytanie Testowe", true, GUIEditor.window[1])
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiSetFont(GUIEditor.label[1], "default-bold-small")
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
	guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
	
	local height = 0
	local option = table.mix(ClientQuiz.Questions[ClientQuiz.question].option)
	for i=1,#option do
		local char = string.char( 65+(i-1) )
		if option[i][2] then
			ClientQuiz.index = i
		end

		GUIEditor.radiobutton[i] = guiCreateRadioButton(0.03, 0.22+height, 0.93, 0.07,char..") "..option[i][1], true, GUIEditor.window[1])
		height = height+0.10 
	end
	GUIEditor.button[1] = guiCreateButton(0.03, height+0.30, 0.93, 0.14, "Wybierz odpowiedz", true, GUIEditor.window[1])
	addEventHandler ( "onClientGUIClick", GUIEditor.button[1], nexQuestion, false )
	guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
	guiSetFont(GUIEditor.button[1], "default-bold-small")
end

function table.mix(Array)
newArray = {}
local i = 0
	while 0 < #Array do
		i = i+1
		index = math.random(1,#Array)
		newArray[i] = Array[index]
		table.remove(Array,index)
	end
	return newArray
end

function nexQuestion()
ClientQuiz.question = ClientQuiz.question+1
	if ClientQuiz.Questions[ClientQuiz.question] == nil then	
		local wynik = ClientQuiz.good/#ClientQuiz.Questions
		outputChatBox("Koniec Quizu twój wynik to: ".. wynik*100 .."%" )
		destroyElement( GUIEditor.window[1] )
		if wynik*100 >= ClientQuiz.data.passed then
			triggerServerEvent( "Quizzes.finishedForPlayer", getLocalPlayer(  ), getLocalPlayer(  ), ClientQuiz.data.finishedAction, true )
		else
			triggerServerEvent( "Quizzes.finishedForPlayer", getLocalPlayer(  ), getLocalPlayer(  ), ClientQuiz.data.finishedAction, false )
		end
		return false
	end

	if guiRadioButtonGetSelected( GUIEditor.radiobutton[ClientQuiz.index] ) then
		ClientQuiz.good = ClientQuiz.good+1
	else
		ClientQuiz.bad = ClientQuiz.bad+1
	end
	destroyElement( GUIEditor.window[1] )
	createGUI()
end

function startQuizPlayer(data)
	ClientQuiz.Questions = fromJSON(data.Questions)
	ClientQuiz.data = data
	ClientQuiz.question = 1
	ClientQuiz.good = 1
	ClientQuiz.bad = 0
	ClientQuiz.index = 0
	createGUI()
end
addEvent("Quizzes.startForPlayer", true)
addEventHandler("Quizzes.startForPlayer", root, startQuizPlayer)