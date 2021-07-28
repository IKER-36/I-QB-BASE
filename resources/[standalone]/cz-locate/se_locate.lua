QBCore = nil

TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)

RegisterNetEvent("cz-locate:locate", function(phone)
    local ply = QBCore.Functions.GetPlayerByPhone(phone)
    TriggerClientEvent("cz-locate:resolve",source, (ply and ply.Functions.GetItemByName("phone")) and GetEntityCoords(GetPlayerPed(ply.PlayerData.source)) or false)
end) 

RegisterCommand("track", function(source)
    local src = source
    local plyData = QBCore.Functions.GetPlayer(src)
    if plyData.PlayerData.job.name == "police" then
        TriggerClientEvent("cz-locate:open", source)
    else
        TriggerClientEvent('chat:addMessage', src , {
            template = '<div class="chat-message server"><b>{0}</b></div>',
            args = { "You are not authorized to use this command"}
        })
    end
end)