local afkTimeout = 1200
local timer = 0

local currentPosition = nil
local previousPosition = nil
local currentHeading = nil
local previousHeading = nil


Citizen.CreateThread(function()

    while true do
        Citizen.Wait(1000)

        playerPed = PlayerPedId()
        if playerPed then

            currentPosition = GetEntityCoords(playerPed, true)
            currentHeading = GetEntityHeading(playerPed)

            if currentPosition == previousPosition and currentHeading == previousHeading then
                if timer > 0 then
                    if timer == math.ceil(afkTimeout / 4) then
                        TriggerEvent("chat:addMessage", {
                           
                            template = '<div class="chat-message server"> [SYSTEM]: {0} </div>',
                            args = {"Looks like you are afk " .. timer .. "type this command if ur not afk /imhere"}

                        })
                    end

                    timer = timer  - 1

                else
                    TriggerServerEvent('afkkick:kickplayer')
                end

            else
                timer = afkTimeout
            end

            previousPosition = currentPosition
            previousHeading = currentHeading

        end
    end
end)

RegisterCommand("imhere", function()
    timer = afkTimeout

    TriggerEvent("chat:addMessage", {

        template = '<div class="chat-message"> [SYSTEM]: {0}</div>',
        args = {"your not afk anymore!"}

    })
end)