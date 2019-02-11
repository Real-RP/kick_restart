--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!

--[[

		below of this green text is the config. If you set things to true then some functions will get added or changed.

--]]

debug.cfg = true --gives acces to use /checkperms, that will show if you are allowed to use the restart ressource or not.
debug.msg = false --gives a error message for players that are not allowed for a restart.

-- end of config

RegisterCommand("beginrestart", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
        	DropPlayer(source, "All Roleplay situations ended automatically. Your progress has been saved. Reason: Server restart.") --translate
    elseif debug.msg then
        TriggerClientEvent("chatMessage", source, "^1Insufficient Permissions.") --translate --do not translate "chatMessage" !!!!
	end
end)


RegisterCommand("closeconnect", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, "restart.cmds") then
		AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
			deferrals.done("The Server is restarting! please retry later.") --shows why you can't connect again. --translate
		end)
	end
end)


--This is a test, it checks if you have permissions and will tell you if you have it or not.
if debug.cfg then
RegisterCommand("checkperms", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
        	TriggerClientEvent("chatMessage", source, "^2You have permissions!") --translate --do not translate "chatMessage" !!!!
    else
        TriggerClientEvent("chatMessage", source, "^1You have no permssions.") --translate --do not translate "chatMessage" !!!!
		end
	end)
end