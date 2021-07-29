QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Functions.CreateCallback("qb-gangs:server:FetchConfig", function(source, cb)
    cb(json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json")))
end)

QBCore.Commands.Add("creategang", "Crea un trabajo de pandillas en la lista blanca con un alijo y spawn de autos", {{name = "gang", help = "Nombre de la pandilla"}, {name = "label", help = "Gang Nombre"}}, true, function(source, args)
    name = args[1]
    table.remove(args, 1)
    label = table.concat(args, " ")
    
    TriggerClientEvent("qb-gangs:client:BeginGangCreation", source, name, label)
end, "admin")

RegisterServerEvent("qb-gangs:server:creategang", function(newGang, gangName, gangLabel)
    local permission = QBCore.Functions.GetPermission(source)

    if permission == "admin" or permission == "god" then
        local gangConfig = json.decode(LoadResourceFile(GetCurrentResourceName(), "config.json"))
        gangConfig[gangName] = newGang

        local gangs = json.decode(LoadResourceFile(GetCurrentResourceName(), "gangs.json"))
        gangs[gangName] = {
            label = gangLabel
        }

        SaveResourceFile(GetCurrentResourceName(), "config.json", json.encode(gangConfig), -1)
        TriggerClientEvent("qb-gangs:client:UpdateGangs", -1, gangConfig)

        SaveResourceFile(GetCurrentResourceName(), "gangs.json", json.encode(gangs), -1)
        TriggerClientEvent("QBCore:Client:UpdateGangs", -1, gangs)
        TriggerEvent("QBCore:Server:UpdateGangs", gangs)

        TriggerClientEvent("QBCore:Notify", source, "Pandilla: "..gangName.." creado con éxito", "success")
    else
        QBCore.Functions.Kick(source, "Intentar crear una pandilla")
    end
end)

function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


QBCore.Commands.Add("invitegang", "Invita a un jugador a tu pandilla", {{name = "ID", help = "ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local gang = Player.PlayerData.gang.name

    if gang == "none" then 
        TriggerClientEvent("QBCore:Notify", source, "No estas en una pandilla", "error")
        return 
    end
    if Config["GangLeaders"][gang] ~= nil and has_value(Config["GangLeaders"][gang], Player.PlayerData.citizenid) then
        local id = tonumber(args[1])
        if id == source then return end

        local OtherPlayer = QBCore.Functions.GetPlayer(id)
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetGang(gang)
            TriggerClientEvent("QBCore:Notify", source, string.format("% ha sido invitado a tu pandilla", GetPlayerName(id)))
            TriggerClientEvent("QBCore:Notify", id, string.format("% te ha invitado a %s", GetPlayerName(source), QBCore.Shared.Gangs[gang].label))
        else
            TriggerClientEvent("QBCore:Notify", source, "Este jugador no está en línea", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No eres el líder de esta pandilla", "error")
    end
end)

QBCore.Commands.Add("removegang", "Elimina a un jugador de tu pandilla", {{name = "ID", help = "ID"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local gang = Player.PlayerData.gang.name

    if gang == "none" then 
        TriggerClientEvent("QBCore:Notify", source, "No estas en una pandilla", "error")
        return 
    end
    if Config["GangLeaders"][gang] ~= nil and has_value(Config["GangLeaders"][gang], Player.PlayerData.citizenid) then
        local id = tonumber(args[1])
        if id == source then return end

        local OtherPlayer = QBCore.Functions.GetPlayer(id)
        if OtherPlayer ~= nil then
            OtherPlayer.Functions.SetGang("none")
            TriggerClientEvent("QBCore:Notify", source, string.format("% ha sido eliminado de tu pandilla", GetPlayerName(id)))
            TriggerClientEvent("QBCore:Notify", id, string.format("% te ha quitado de %s", GetPlayerName(source), QBCore.Shared.Gangs[gang].label))
        else
            TriggerClientEvent("QBCore:Notify", source, "Este jugador no está en línea", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No eres el líder de esta pandilla", "error")
    end
end)
