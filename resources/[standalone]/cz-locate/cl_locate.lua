local p;

RegisterNUICallback("locate", function(data)
    p = promise:new()
    TriggerServerEvent("cz-locate:locate", data.phone)
    local ply = Citizen.Await(p)
    if ply then
        SendNUIMessage({
            action = "locate"
        })
        SetNuiFocus(false, false)
        TriggerScreenblurFadeOut(0)
        blip = AddBlipForCoord(ply['x'], ply['z'], ply['x'])
        SetBlipSprite(blip, 1)
        SetBlipColour(blip, 1)
        SetNewWaypoint(ply['x'], ply['y'])
        CreateThread(function()
            while true do
                Wait(500)
                if #(GetEntityCoords(PlayerPedId()) - ply) < 10.0 then
                    RemoveBlip(blip)
                end
            end
        end)
    else
        SendNUIMessage({
            action = "error"
        })
    end
end)

RegisterNetEvent("cz-locate:open", function()
    SendNUIMessage({
        action = "open"
    })
    SetNuiFocus(true, true)
    TriggerScreenblurFadeIn(0)
end)

RegisterNetEvent("cz-locate:resolve", function(data)
    p:resolve(data);
end)