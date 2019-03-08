--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!

--[[

		below of this green text is the config. If you set things to true then some functions will get added or changed.

--]]

lang = 'en' -- languages are: en = english, de = deutsch, fr = französisch

debug.cfg = true --gives acces to use /checkperms, that will show if you are allowed to use the restart ressource or not.
debug.msg = false --gives a error message for players that are not allowed for a restart.

--Locales: English
if lang == 'en' then
kick_message = "All Roleplay situations ended automatically. Your progress has been saved. Reason: Server restart."
kick_message_before_join = "The Server is restarting! please retry later."
end

--Locales: Deutsch
if lang == 'de' then
kick_message = "Alle RP Situationen wurden automatisch beendet, dein Fortschritt wurde gespeichert, Grund: Server Neustart"
kick_message_before_join = "Der Server startet gerade Neu, bitte connecte später erneut."
end

--Locales: français
if lang == 'fr' then
kick_message = "Toutes les situations RP ont pris fin automatiquement, votre progression a été enregistrée, motif: redémarrage du serveur"
kick_message_before_join = "Le serveur est en train de démarrer, veuillez vous reconnecter plus tard."
end


-- end of config

local kick = false



RegisterCommand("beginrestart", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
		kick = true
	end
end)


RegisterServerEvent("kickForRestart")
AddEventHandler("kickForRestart", function()
	if kick == true then
	DropPlayer(source, kick_message)
	end
end)


RegisterCommand("closeconnect", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, "restart.cmds") then
		AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
			deferrals.done(kick_message_before_join) --shows why you can't connect again. --translate
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
