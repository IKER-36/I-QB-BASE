isLoggedIn = false
PlayerJob = {}

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    QBCore.Functions.TriggerCallback('qb-diving:server:GetBusyDocks', function(Docks)
        QBBoatshop.Locations["berths"] = Docks
    end)

    QBCore.Functions.TriggerCallback('qb-diving:server:GetDivingConfig', function(Config, Area)
        QBDiving.Locations = Config
        TriggerEvent('qb-diving:client:SetDivingLocation', Area)
    end)

    PlayerJob = QBCore.Functions.GetPlayerData().job

    isLoggedIn = true

    if PlayerJob.name == "police" then
        if PoliceBlip ~= nil then
            RemoveBlip(PoliceBlip)
        end
        PoliceBlip = AddBlipForCoord(QBBoatshop.PoliceBoat.x, QBBoatshop.PoliceBoat.y, QBBoatshop.PoliceBoat.z)
        SetBlipSprite(PoliceBlip, 410)
        SetBlipDisplay(PoliceBlip, 4)
        SetBlipScale(PoliceBlip, 0.8)
        SetBlipAsShortRange(PoliceBlip, true)
        SetBlipColour(PoliceBlip, 29)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Barcos de la policía")
        EndTextCommandSetBlipName(PoliceBlip)
        PoliceBlip = AddBlipForCoord(QBBoatshop.PoliceBoat2.x, QBBoatshop.PoliceBoat2.y, QBBoatshop.PoliceBoat2.z)
        SetBlipSprite(PoliceBlip, 410)
        SetBlipDisplay(PoliceBlip, 4)
        SetBlipScale(PoliceBlip, 0.8)
        SetBlipAsShortRange(PoliceBlip, true)
        SetBlipColour(PoliceBlip, 29)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Barcos de la policía")
        EndTextCommandSetBlipName(PoliceBlip)
    end
end)

-- Code

DrawText3D = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('qb-diving:client:UseJerrycan')
AddEventHandler('qb-diving:client:UseJerrycan', function()
    local ped = PlayerPedId()
    local boat = IsPedInAnyBoat(ped)
    if boat then
        local curVeh = GetVehiclePedIsIn(ped, false)
        QBCore.Functions.Progressbar("reful_boat", "Repostando barcos ..", 20000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            exports['LegacyFuel']:SetFuel(curVeh, 100)
            QBCore.Functions.Notify('El barco ha sido repostado', 'success')
            TriggerServerEvent('qb-diving:server:RemoveItem', 'jerry_can', 1)
            TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items['jerry_can'], "remove")
        end, function() -- Cancel
            QBCore.Functions.Notify('Se canceló el repostaje!', 'error')
        end)
    else
        QBCore.Functions.Notify('No estas en un barco', 'error')
    end
end)
