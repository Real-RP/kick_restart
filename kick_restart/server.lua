--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!
--DO NOT EDIT THE CODE YOURSELF! TRANSLATE ONLY IF IT IS NEEDED!

--[[

		below of this green text is the config. If you set things to true then some functions will get added or changed.

--]]

lang = 'de' -- languages are: en = english, de = deutsch, fr = français
userestartplanner = false --change to true to activate the table planner below:

restarttimes = {	'17:25:00', '18:00:00'	} --add your restart times here. [FORMAT: HOUR:MINUTE:SECOND]


debug.cfg = true --gives acces to use /checkperms, that will show if you are allowed to use the restart ressource or not.
debug.msg = true --gives a error message for players that are not allowed for a restart.
-------------------------------------------------------------------------------------------------------------------------------------



--Locales: English
if lang == 'en' then
kick_message = "All Roleplay situations ended automatically. Your progress has been saved. Reason: Server restart."
kick_message_before_join = "The Server is restarting! please retry later."
permissions = "^3SYSTEM: ^1You have no permissions!"
have_permissions = "^3SYSTEM: ^2You have permissions!"
norestart_planned = "No restart was planned!"
stopped_restart = "you've stopped the restart."
planned_at = "You've planned a restart at "
curr_time = " current time is: "
planned_at_2 = "Planned a restart at "
stopp_rp = "please stop all RP situations in time!"
no_past_restart = "^1You can't make a restart in the past!"
end

--Locales: Deutsch
if lang == 'de' then
kick_message = "Alle RP Situationen wurden automatisch beendet, dein Fortschritt wurde gespeichert, Grund: Server Neustart"
kick_message_before_join = "Der Server startet gerade Neu, bitte connecte später erneut."
permissions = "^3SYSTEM: ^1Du hast keine Berechtigungen!"
have_permissions = "^3SYSTEM: ^2Du hast Berechtigungen!"
norestart_planned = "Kein Neustart wurde geplant!"
stopped_restart = "Du hast den Neustart beendet."
planned_at = "Dein Neustart wurde geplant für "
curr_time = " derzeitige Uhrzeit ist: "
planned_at_2 = "Neustart wurde geplant um "
stopp_rp = "bitte beende alle RP Situationen rechtzeitig!"
no_past_restart = "^1Du kannst keinen Neustart in der Vergangenheit machen!"
end

--Locales: français
if lang == 'fr' then
kick_message = "Toutes les situations RP ont pris fin automatiquement, votre progression a été enregistrée, motif: redémarrage du serveur"
kick_message_before_join = "Le serveur est en train de démarrer, veuillez vous reconnecter plus tard."
permissions = "^3SYSTEM: ^1Vous n'avez aucune permission!"
have_permissions = "^3SYSTEM: ^2Vous avez des permissions!"
norestart_planned = "Aucun redémarrage n'était prévu!"
stopped_restart = "Vous avez terminé le redémarrage."
planned_at = "Votre redémarrage commencera à"
curr_time = " l'heure actuelle est: "
planned_at_2 = "Le redémarrage était prévu autour "
stopp_rp = "veuillez terminer toutes les situations de RP à temps!"
no_past_restart = "Vous ne pouvez pas faire un redémarrage dans le passé!"
end


-- end of config

local kick = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500) --every half second
		
		for i=1, #restarttimes, 1 do
			if restarttimes[i] == os.date("%X") then
				kick = true
			else
				Wait(10000)
				kick = false
			end
		end
		
	end
end)

RegisterCommand("dorestart", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
		kick = true
		Wait(10000)
		--os.execute("kick_restart.bat")
	else
		TriggerClientEvent("chatMessage", source, permissions)
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
			deferrals.done(kick_message_before_join)
		end)
	end
end)


--This is a test, it checks if you have permissions and will tell you if you have it or not.
if debug.cfg then
RegisterCommand("kcheckperms", function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
        	TriggerClientEvent("chatMessage", source, have_permissions)
		else
			TriggerClientEvent("chatMessage", source, permissions)
		end
	end)
end

local planning = false

RegisterCommand("stopplan", function(source, rawCommand)
    if IsPlayerAceAllowed(source, "restart.cmds") then
		if planning ~= true then
			TriggerClientEvent("chatMessage", source, "^1".. norestart_planned)
		else
			planning = false
			TriggerClientEvent("chatMessage", source, "^2".. stopped_restart)
		end
		
		else
			TriggerClientEvent("chatMessage", source, permissions)
	end
end)

	RegisterCommand("planrestart", function(source, args, rawCommand)
	if IsPlayerAceAllowed(source, "restart.cmds") then
	args = table.concat(args, " ")
		if args == "" then
			TriggerClientEvent("chatMessage", source, "^2usage: hour:minute:second^7")
		else
			if IsPlayerAceAllowed(source, "restart.cmds") then
			planning = true
				if args > os.date("%X") then
				TriggerClientEvent("chatMessage", source, "^2"..planned_at..args..curr_time..os.date("%X"))
				TriggerClientEvent("chatMessage", -1, "^2"..planned_at_2..args.." "..stopp_rp)
					Citizen.CreateThread(function()
						while planning do
						Wait(0)
				
							wantedtime = args
							if wantedtime == os.date("%X") then
							kick = true
									Wait(1000)
				
									--os.execute("restart.bat")

									planning = false
							end
						end
					end)
				else
					TriggerClientEvent("chatMessage", source, no_past_restart)
				end
			end
		end
	  end
	end)

