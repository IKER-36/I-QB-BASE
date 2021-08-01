local Races = {}
RegisterServerEvent('qb-streetraces:NewRace')
AddEventHandler('qb-streetraces:NewRace', function(RaceTable)
    local src = source
    local RaceId = math.random(1000, 9999)
    local xPlayer = QBCore.Functions.GetPlayer(src)
    if xPlayer.Functions.RemoveMoney('cash', RaceTable.amount, "streetrace-created") then
        Races[RaceId] = RaceTable
        Races[RaceId].creator = QBCore.Functions.GetIdentifier(src, 'license')
        table.insert(Races[RaceId].joined, QBCore.Functions.GetIdentifier(src, 'license'))
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
        TriggerClientEvent('qb-streetraces:SetRaceId', src, RaceId)
        TriggerClientEvent('QBCore:Notify', src, "Entraste a la carrera por €"..Races[RaceId].amount..",-", 'success')
    end
end)

RegisterServerEvent('qb-streetraces:RaceWon')
AddEventHandler('qb-streetraces:RaceWon', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    xPlayer.Functions.AddMoney('cash', Races[RaceId].pot, "race-won")
    TriggerClientEvent('QBCore:Notify', src, "Ganaste la carrera "..Races[RaceId].pot..",-€ recibido", 'success')
    TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
    TriggerClientEvent('qb-streetraces:RaceDone', -1, RaceId, GetPlayerName(src))
end)

RegisterServerEvent('qb-streetraces:JoinRace')
AddEventHandler('qb-streetraces:JoinRace', function(RaceId)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)
    if zPlayer ~= nil then
        if xPlayer.PlayerData.money.cash >= Races[RaceId].amount then
            Races[RaceId].pot = Races[RaceId].pot + Races[RaceId].amount
            table.insert(Races[RaceId].joined, QBCore.Functions.GetIdentifier(src, 'license'))
            if xPlayer.Functions.RemoveMoney('cash', Races[RaceId].amount, "streetrace-joined") then
                TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
                TriggerClientEvent('qb-streetraces:SetRaceId', src, RaceId)
                TriggerClientEvent('QBCore:Notify', zPlayer.PlayerData.source, GetPlayerName(src).." Se unio a la carrera", 'primary')
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "No tienes suficiente dinero", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "La persona que creo la carrera se fue a dormir", 'error')
        Races[RaceId] = {}
    end
end)

QBCore.Commands.Add("crearcarrera", "Empezar una carrera", {{name="amount", help="El monto para la carrera."}}, false, function(source, args)
    local src = source
    local amount = tonumber(args[1])
    local Player = QBCore.Functions.GetPlayer(src)

    if GetJoinedRace(QBCore.Functions.GetIdentifier(src, 'license')) == 0 then
        TriggerClientEvent('qb-streetraces:CreateRace', src, amount)
    else
        TriggerClientEvent('QBCore:Notify', src, "Ya estas en una carrera", 'error')    
    end
end)

QBCore.Commands.Add("pararcarrera", "Para la carrera que estabas haciendo", {}, false, function(source, args)
    local src = source
    CancelRace(src)
end)

QBCore.Commands.Add("salircarrera", "Salte de la carrera. (No se te devolvera el dinero!)", {}, false, function(source, args)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local RaceId = GetJoinedRace(QBCore.Functions.GetIdentifier(src, 'license'))
    local zPlayer = QBCore.Functions.GetPlayer(Races[RaceId].creator)

    if RaceId ~= 0 then
        if GetCreatedRace(QBCore.Functions.GetIdentifier(src, 'license')) ~= RaceId then
            RemoveFromRace(QBCore.Functions.GetIdentifier(src, 'license'))
            TriggerClientEvent('QBCore:Notify', src, "¡Has salido de la carrera! Y perdiste tu dinero", 'error')
        else
            TriggerClientEvent('QBCore:Notify', src, "/salircarrera para parar la carrera", 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "No estas en ninguna carrera ", 'error')
    end
end)

QBCore.Commands.Add("empezarcarrera", "Empieza la carrera creada", {}, false, function(source, args)
    local src = source
    local RaceId = GetCreatedRace(QBCore.Functions.GetIdentifier(src, 'license'))
    
    if RaceId ~= 0 then
      
        Races[RaceId].started = true
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
        TriggerClientEvent("qb-streetraces:StartRace", -1, RaceId)
    else
        TriggerClientEvent('QBCore:Notify', src, "No ha comenzado una carrera", 'error')
        
    end
end)

function CancelRace(source)
    local RaceId = GetCreatedRace(QBCore.Functions.GetIdentifier(source, 'license'))
    local Player = QBCore.Functions.GetPlayer(source)

    if RaceId ~= 0 then
        for key, race in pairs(Races) do
            if Races[key] ~= nil and Races[key].creator == Player.PlayerData.license then
                if not Races[key].started then
                    for _, iden in pairs(Races[key].joined) do
                        local xdPlayer = QBCore.Functions.GetPlayer(iden)
                            xdPlayer.Functions.AddMoney('cash', Races[key].amount, "race-cancelled")
                            TriggerClientEvent('QBCore:Notify', xdPlayer.PlayerData.source, "La carrera se cancelo, se te devolvio $"..Races[key].amount.."", 'error')
                            TriggerClientEvent('qb-streetraces:StopRace', xdPlayer.PlayerData.source)
                            RemoveFromRace(iden)
                    end
                else
                    TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, "La carrera ya se creo", 'error')
                end
                TriggerClientEvent('QBCore:Notify', source, "Carrera cancelada!", 'error')
                Races[key] = nil
            end
        end
        TriggerClientEvent('qb-streetraces:SetRace', -1, Races)
    else
        TriggerClientEvent('QBCore:Notify', source, "No has empezado la carrera!", 'error')
    end
end

function RemoveFromRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for i, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    table.remove(Races[key].joined, i)
                end
            end
        end
    end
end

function GetJoinedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and not Races[key].started then
            for _, iden in pairs(Races[key].joined) do
                if iden == identifier then
                    return key
                end
            end
        end
    end
    return 0
end

function GetCreatedRace(identifier)
    for key, race in pairs(Races) do
        if Races[key] ~= nil and Races[key].creator == identifier and not Races[key].started then
            return key
        end
    end
    return 0
end
