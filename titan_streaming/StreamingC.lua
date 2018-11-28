local StreamDistance = 150 -- Radze nie zmieniac optymalna liczba
local Memory = {} -- Tutaj przechowuja sie wszystkie dane dla klienta

function setMemmoryStreaming(data)
	Memory = data
	addEventHandler("onClientRender", root, onElementStreamFrame)
end
addEvent( "setMemmoryStreaming:client", true )
addEventHandler( "setMemmoryStreaming:client", root, setMemmoryStreaming)

local screenW, screenH = guiGetScreenSize()
local renderData = {}
local baseX = 1920
local zoom = 1.0
local minZoom = 2
if screenW < baseX then
	zoom = math.min(minZoom, baseX/screenW)
end

renderData.Text = {
	x=(screenW/2)-(600/zoom)/2+920/zoom, 
	y=(screenH/2)-(600/zoom)/2-190/zoom, 
	w=1900/zoom, 
	h=125/zoom,
}





function onElementStreamFrame()
dxDrawText ( "Stream Object: "..#getElementsByType("object").."\n Memory use: ".. collectgarbage("count")*1024 .."kb" , renderData.Text.x , renderData.Text.y, renderData.Text.w, renderData.Text.h, tocolor ( 255, 255, 255, 255 ), 0.9, "bankgothic", "right" )

local camX, camY, camZ = getCameraMatrix()
local interior, dimension = getElementInterior(localPlayer), getElementDimension(localPlayer)
	for i,v in ipairs(Memory) do
	if v.x and v.y and v.z then
		local distance = getDistanceBetweenPoints3D(camX, camY, camZ, v.x, v.y, v.z)
			if distance < StreamDistance and v.int == interior and v.dim == dimension then
				if not isElement(v.object) and not v.stream then
					v.object = createObject(v.model, v.x, v.y, v.z, v.rx, v.ry, v.rz)
					v.object:setDimension(v.dim)
					v.object:setInterior(v.int)
					v.object:setRotation(v.rx, v.ry, v.rz)
					setElementDoubleSided( v.object, v.double )
					setObjectBreakable( v.object, false )
					setObjectScale( v.object, v.scale )
					setElementCollisionsEnabled( v.object, v.colission )
					v.stream = true
				end
			elseif (distance > StreamDistance or v.int ~= interior or v.dim ~= dimension) and v.stream == true and isElement(v.object) then
				destroyElement( v.object )
				v.stream = false
			end
		end
	end
end