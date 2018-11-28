Camera = {}

function getMatrixPosition(m)
    return m[4][1], m[4][2], m[4][3]
end

Camera.Tick = getTickCount(  )
Camera.dx, Camera.dy, Camera.dz = getMatrixPosition( getElementMatrix( getLocalPlayer(  ) ) )
Camera.Index = 1
Camera.Index_add = true
Camera.Rotation = 0
Camera.Ped = false

function getIndexCamera()
if Camera.Index_add then
  index1 = Camera.Index
  index2 = Camera.Index+1
else
  index1 = Camera.Index
  index2 = Camera.Index-1
end
return Camera.Position[index1], Camera.Position[index2]
end

function nextCameraMatrix(progress)
  if progress > 1 and Camera.Index_add then
    Camera.Index = Camera.Index+1
    Camera.Tick = getTickCount(  )
    if Camera.Index >= #Camera.Position then
      Camera.Index_add = not Camera.Index_add
    end
  elseif progress > 1 and not(Camera.Index_add) then
    Camera.Index = Camera.Index-1
    Camera.Tick = getTickCount(  )
    if Camera.Index <= 1 then
      Camera.Index = 1
      Camera.Index_add = not Camera.Index_add
    end
  end
end



function RenderCameraPosition()
    local c1,c2 = getIndexCamera(Camera.Index_add)
    local now = getTickCount()
    local endTime = Camera.Tick + getDistanceBetweenPoints3D( c1[1], c1[2], c1[3], c2[1], c2[2], c2[3] )*50
    local elapsedTime = now - Camera.Tick
    local duration = endTime - Camera.Tick
    local progress = elapsedTime / duration
    local x,y,z = interpolateBetween ( c1[1], c1[2], c1[3], c2[1], c2[2], c2[3], progress, "Linear")
    local lx,ly,lz = interpolateBetween ( c1[4], c1[5], c1[6], c2[4], c2[5], c2[6], progress, "Linear")
    setCameraMatrix(x,y,z,lx,ly,lz)
    nextCameraMatrix(progress)
    local px,py,pz = getElementPosition( Camera.Ped )
    local lx,ly,lz = getMatrixPosition( getElementMatrix( Camera.Ped ) )
    local distance = 5
    Camera.Rotation = Camera.Rotation + 0.0001
    local x = px + math.cos(Camera.Rotation / math.pi * 180) * distance;
    local y = py + math.sin(Camera.Rotation / math.pi * 180) * distance;
    local z = pz+3
    setCameraMatrix(x,y,z,lx,ly,lz)
end



function odtworz()
addEventHandler("onClientRender",root, RenderCameraPosition)
end
addCommandHandler( "odtworz",odtworz )


--- NAGRYWANIE INTRO ----
setCameraTarget(localPlayer)

Camera.text = {}
Camera.time = getTickCount(  )
Camera.Save = 1

function setMatrix()
if ( getTickCount(  )-Camera.time )/100 > 1 then
  local x, y, z, lx, ly, lz = getCameraMatrix ()
  table.insert(Camera.text,{x,y,z,lx,ly,lz})
  Camera.time = getTickCount(  )
  end
end

function getRecords()
local newFile = fileCreate("Zapisy/Zapis-"..#Camera.text..".txt")
for i,v in ipairs(Camera.text) do
  fileWrite( newFile,"{"..v[1]..","..v[2]..","..v[3]..","..v[4]..","..v[5]..","..v[6].."},\n" )
end
fileClose(newFile) 
outputChatBox("Stop nagrywania.")
removeEventHandler("onClientRender",root, setMatrix)
end
addCommandHandler( "zatrzymaj",getRecords )

function setRecord(Value)
Camera.Save = Value
outputChatBox("Start nagrywania = "..Value.." ms.")
addEventHandler("onClientRender",root, setMatrix)
end
addCommandHandler( "nagraj", setRecord )