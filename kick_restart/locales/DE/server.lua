--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!

--[[
		
	unterhalb dieses grünen textes befindet sich die config. 
	Wenn du den Wert auf "true" setzt, werden einige Funktionen hinzugefügt oder geändert.

--]]

debug.cfg = true --Erlaubt den Zugriff auf /checkperms, was anzeigt, ob du die retstart resource verwenden darfst oder nicht.
debug.msg = false --gibt eine Fehlermeldung für Spieler aus, die nicht in der server.cfg zugelassen sind.

-- end of config

RegisterCommand("beginrestart", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
        	DropPlayer(source, "Alle Rollenspiele wurden automatisch beendet. Dein Fortschritt wurde gespeichert. Grund: Server Neustart.") --translate
    elseif debug.msg then
        TriggerClientEvent("chatMessage", source, "^1Keine Berechtigungen.") --translate --do not translate "chatMessage" !!!!
	end
end)


RegisterCommand("closeconnect", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, "restart.cmds") then
		AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
			deferrals.done("Der Server startet Neu! bitte versuche es gleich nochmal.") --shows why you can't connect again. --translate
		end)
	end
end)


--Dies ist ein Test. Er prüft, ob du über Berechtigungen verfügst, und sagt dir, ob du über diese verfügst oder nicht.
if debug.cfg then
RegisterCommand("checkperms", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
        	TriggerClientEvent("chatMessage", source, "^2Du hast Berechtigungen!") --translate --do not translate "chatMessage" !!!!
    else
        TriggerClientEvent("chatMessage", source, "^1Du hast keine Berechtigungen.") --translate --do not translate "chatMessage" !!!!
		end
	end)
end