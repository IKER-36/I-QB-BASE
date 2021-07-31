local ItemList = {
    ["cocaleaf"] = "cocaleaf"
}

local DrugList = {
    ["cokebaggy"] = "cokebaggy"
}


RegisterServerEvent('qb-coke:server:grindleaves')
AddEventHandler('qb-coke:server:grindleaves', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cocaleaf = Player.Functions.GetItemByName('cocaleaf')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if cocaleaf ~= nil then
                if ItemList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "cocaleaf" and Player.PlayerData.items[k].amount >= 2 then 
                        Player.Functions.RemoveItem("cocaleaf", 2)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cocaleaf'], "remove")

                        TriggerClientEvent("qb-coke:client:grindleavesMinigame", src)
                    else
                        TriggerClientEvent('QBCore:Notify', src, "No tienes suficientes hojas de coca", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "No tienes hojas de coca", 'error')
                break
            end
        end
    end
end)

RegisterServerEvent('qb-coke:server:processCrack')
AddEventHandler('qb-coke:server:processCrack', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cokebaggy = Player.Functions.GetItemByName('cokebaggy')

    if Player.PlayerData.gang.name == "ballas" then
        if Player.PlayerData.items ~= nil then 
            if cokebaggy ~= nil then 
                if cokebaggy.amount >= 2 then 

                    Player.Functions.RemoveItem("cokebaggy", 2, false)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['cokebaggy'], "remove")

                    TriggerClientEvent("qb-coke:client:processCrack", src)
                else
                    TriggerClientEvent('QBCore:Notify', src, "No tienes los objetos correctos", 'error')   
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "No tienes los objetos correctos", 'error')   
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "No tienes nada...", "error")
        end
    else
        TriggerClientEvent('QBCore:Notify', src, "Es posible que deba hablar con un miembro de una pandilla...", 'error')   
        
    end
end)

RegisterServerEvent('qb-coke:server:cokesell')
AddEventHandler('qb-coke:server:cokesell', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cokebaggy = Player.Functions.GetItemByName('cokebaggy')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if cokebaggy ~= nil then
                if DrugList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "cokebaggy" and Player.PlayerData.items[k].amount >= 1 then 
                        local random = math.random(50, 65)
                        local amount = Player.PlayerData.items[k].amount * random

                        TriggerClientEvent('chatMessage', source, "Camello Johnny", "normal", 'Tu '..Player.PlayerData.firstname..', maldita sea que tienes '..Player.PlayerData.items[k].amount..'bolsas de coca')
                        TriggerClientEvent('chatMessage', source, "Camello Johnny", "normal", 'Lo compraré todo por $'..amount )

                        Player.Functions.RemoveItem("cokebaggy", Player.PlayerData.items[k].amount)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cokebaggy'], "remove")
                        Player.Functions.AddMoney("cash", amount)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "No tienes coca", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "No tienes coca", 'error')
                break
            end
        end
    end
end)


RegisterServerEvent('qb-coke:server:getleaf')
AddEventHandler('qb-coke:server:getleaf', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("cocaleaf", 10)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cocaleaf'], "add")
end)

RegisterServerEvent('qb-coke:server:getcoke')
AddEventHandler('qb-coke:server:getcoke', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("cokebaggy", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cokebaggy'], "add")
end)

RegisterServerEvent('qb-coke:server:getcrack')
AddEventHandler('qb-coke:server:getcrack', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("crack_baggy", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['crack_baggy'], "add")
end)

