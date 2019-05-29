-- CONFIGURATION--

-- this will kick players after they do a while nothing (in seconds)
Kicktime = 0 --set on 1 second to only kick players that have done their RP situations (when they don't move), or 0 seconds to make a instant restart.

--Do not edit if you do not know what you do--
--											--
	--			 Decoration <3			--
		--							--
			--					--
				--			--
					--	--
					
--locales in server.lua

AddEventHandler("playerSpawned", function(display)
	TriggerEvent('chat:addSuggestion', '/planrestart', 'HOUR:MINUTE:SECOND')
	TriggerEvent('chat:addSuggestion', '/stopplan', 'if a reboot has been scheduled, it will be canceled')
	TriggerEvent('chat:addSuggestion', '/kcheckperms', 'Check if you have the rights to use '..GetCurrentResourceName())
	TriggerEvent('chat:addSuggestion', '/closeconnect', 'closes the connection of users to the server if they want to reconnect')
	TriggerEvent('chat:addSuggestion', '/dorestart', 'Do a direct restart')
end)
					
Citizen.CreateThread(function()
	while true do
		Wait(1000)

		playerPed = GetPlayerPed(-1)
		if playerPed then
			currentPos = GetEntityCoords(playerPed, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time == math.ceil(Kicktime / 4) then
						TriggerEvent("chatMessage", "Warning", {255, 0, 0}, "IGNORE THIS " .. time .. " IF YOU DO NO KNOW WHAT YOU DO, PLACEFILLER")
					end

					time = time - 1
				else
					TriggerServerEvent("kickForRestart")
				end
			else
				time = Kicktime
			end

			prevPos = currentPos
		end
	end
end)
