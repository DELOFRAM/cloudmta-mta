addEvent("onPlayerExtendedChat", true)
addEventHandler("onPlayerExtendedChat", resourceRoot, function(plr, args, type)
	if type == 1 then -- IC [ME]

	elseif type == 2 then -- IC [DO]

	end
end)

addEvent("doExecuteCommandHandler", true)
addEventHandler("doExecuteCommandHandler", resourceRoot, function(cmd,plr,args)
	outputDebugString("[doExecuteCommandHandler] "..tostring(cmd).." - "..tostring(plr).." - "..tostring(args) )
  executeCommandHandler(cmd,plr,args)
end)