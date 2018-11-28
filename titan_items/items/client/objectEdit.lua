----------------------------------------------------
-- cloudMTA.pl
-- Skrypt Multi Theft Auto RolePlay
-- Autor: Kubas
----------------------------------------------------

objectEdit = {}
objectEditFunc = {}

function objectEditFunc.edit(model, boneID)
	objectEdit.object = createObject(model, 0, 0, 0)
	exports.titan_boneAttach:attachElementToBone(objectEdit.object, localPlayer, boneID, 0, 0, 0, 0, 0, 0)
	objectEdit.pos = {1, 1, 1, 0, 0, 0}
	addEventHandler("onClientRender", root, objectEditFunc.renderEdit)
	exports.titan_cursor:showCustomCursor("itemsObjectEdit")
end

addCommandHandler("bone", function() objectEditFunc.edit(1853, 4) end, false, false)

function objectEditFunc.renderEdit()
	if(not isElement(objectEdit.object) or not exports.titan_boneAttach:isElementAttachedToBone(objectEdit.object)) then 
		removeEventHandler("onClientRender", root, objectEditFunc.renderEdit)
		return
	end

	local x, y, z, rx, ry, rz = unpack(objectEdit.pos)
	if(isCursorShowing()) then
		if(getKeyState("arrow_u")) then
			if(getKeyState("lshift")) then
				z = z + 0.1
			else
				z = z + 0.01
			end
		end
		if(getKeyState("arrow_d")) then
			if(getKeyState("lshift")) then
				z = z - 0.1
			else
				z = z - 0.01
			end
		end
		if(getKeyState("arrow_l")) then
			if(getKeyState("lctrl")) then
				if(getKeyState("lshift")) then
					y = y + 0.1
				else
					y = y + 0.01
				end
			else
				if(getKeyState("lshift")) then
					x = x + 0.1
				else
					x = x + 0.01
				end
			end
		end
		if(getKeyState("arrow_r")) then
			if(getKeyState("lctrl")) then
				if(getKeyState("lshift")) then
					y = y - 0.1
				else
					y = y - 0.01
				end
			else
				if(getKeyState("lshift")) then
					x = x - 0.1
				else
					x = x - 0.01
				end
			end
		end
	end
	if(x > 2) then x = 2 end
	if(x < -2) then x = -2 end
	if(y > 2) then y = 2 end
	if(y < -2) then y = -2 end
	if(z > 2) then z = 2 end
	if(z < -2) then z = -2 end
	if(getKeyState("space")) then
		if(isCursorShowing()) then
			exports.titan_cursor:hideCustomCursor("itemsObjectEdit")
		end
	else
		if(not isCursorShowing()) then
			exports.titan_cursor:showCustomCursor("itemsObjectEdit")
		end
	end

	if(getKeyState("q")) then
		removeEventHandler("onClientRender", root, objectEditFunc.renderEdit)
		destroyElement(objectEdit.object)
		exports.titan_cursor:hideCustomCursor("itemsObjectEdit")
		return
	end
	
	--setObjectScale(objectEdit.object, x, y, z)
	exports.titan_boneAttach:setElementBonePositionOffset(objectEdit.object, x, y, z)
	--exports.titan_boneAttach:setElementBoneRotationOffset(objectEdit.object, rx, ry, rz)
	objectEdit.pos = {x, y, z, rx, ry, rz}
end