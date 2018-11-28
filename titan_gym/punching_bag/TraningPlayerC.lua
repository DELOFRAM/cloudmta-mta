local panchBag = {}
panchBag.Timer = nil
panchBag.Hit = 0
panchBag.Combo = 0
panchBag.Point = 0

function punchBagTraningDamage(loss)
	if getElementModel(source) == 1985 then
		panchBag.Timer = getTickCount(  )
		panchBag.Hit = panchBag.Hit+1
		if panchBag.Hit == 10 then
			panchBag.Hit = 0
			panchBag.Combo = panchBag.Combo+1
			panchBag.Point = panchBag.Point+(math.random(1,2)/5)*panchBag.Combo
		end
	end
end

function punchBagTraningCombo()
	if type( panchBag.Timer ) == "number" and getTickCount(  )-panchBag.Timer > 1000 then
		panchBag.Timer = false
		panchBag.Combo = 0
		panchBag.Hit = 0
	end
end

function startPlayerTraningPunchBag()
	addEventHandler ( "onClientRender", root, punchBagTraningCombo )
	addEventHandler("onClientObjectDamage", root, punchBagTraningDamage)
end
addEvent( "startTraningPlayerPunchBag", true )
addEventHandler( "startTraningPlayerPunchBag", root, startPlayerTraningPunchBag )

function stopPlayerTraningPunchBag()
	removeEventHandler ( "onClientRender", root, punchBagTraningCombo )
	removeEventHandler("onClientObjectDamage", root, punchBagTraningDamage)
end
addEvent( "stopTraningPunchBag", true )
addEventHandler( "stopTraningPunchBag", root, stopPlayerTraningPunchBag )