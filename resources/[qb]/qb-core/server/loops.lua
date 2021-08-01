QBCore.Functions.StartPayCheck = function()
    GivePayCheck = function()
        local Players = QBCore.Functions.GetPlayers()

        for i=1, #Players, 1 do
            local Player = QBCore.Functions.GetPlayer(Players[i])

            if Player.PlayerData.job ~= nil and Player.PlayerData.job.payment > 0 then
                Player.Functions.AddMoney('bank', Player.PlayerData.job.payment)
                TriggerClientEvent('QBCore:Notify', Players[i], "Has recibido tu salario de $"..Player.PlayerData.job.payment)
            end
        end
        SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), GivePayCheck)
    end
    SetTimeout(QBCore.Config.Money.PayCheckTimeOut * (60 * 1000), GivePayCheck)
end
