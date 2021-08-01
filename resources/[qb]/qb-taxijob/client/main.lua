local isLoggedIn = false
local PlayerData = {}

local meterIsOpen = false

local meterActive = false
local currentTaxi = nil

local lastLocation = nil

local meterData = {
    fareAmount = 6,
    currentFare = 0,
    distanceTraveled = 0,
}

local dutyPlate = nil

local NpcData = {
    Active = false,
    CurrentNpc = nil,
    LastNpc = nil,
    CurrentDeliver = nil,
    LastDeliver = nil,
    Npc = nil,
    NpcBlip = nil,
    DeliveryBlip = nil,
    NpcTaken = false,
    NpcDelivered = false,
    CountDown = 180
}

function TimeoutNpc()
    Citizen.CreateThread(function()
        while NpcData.CountDown ~= 0 do
            NpcData.CountDown = NpcData.CountDown - 1
            Citizen.Wait(1000)
        end
        NpcData.CountDown = 180
    end)
end

RegisterNetEvent('qb-taxi:client:DoTaxiNpc')
AddEventHandler('qb-taxi:client:DoTaxiNpc', function()
    if whitelistedVehicle() then
       -- if NpcData.CountDown == 180 then
            if not NpcData.Active then
                NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                if NpcData.LastNpc ~= nil then
                    while NpcData.LastNpc ~= NpcData.CurrentNpc do
                        NpcData.CurrentNpc = math.random(1, #Config.NPCLocations.TakeLocations)
                    end
                end

                local Gender = math.random(1, #Config.NpcSkins)
                local PedSkin = math.random(1, #Config.NpcSkins[Gender])
                local model = GetHashKey(Config.NpcSkins[Gender][PedSkin])
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Citizen.Wait(0)
                end
                NpcData.Npc = CreatePed(3, model, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z - 0.98, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].w, false, true)
                PlaceObjectOnGroundProperly(NpcData.Npc)
                FreezeEntityPosition(NpcData.Npc, true)
                if NpcData.NpcBlip ~= nil then
                    RemoveBlip(NpcData.NpcBlip)
                end
                QBCore.Functions.Notify('Se te marco en el GPS el NPC', 'success')
                NpcData.NpcBlip = AddBlipForCoord(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z)
                SetBlipColour(NpcData.NpcBlip, 3)
                SetBlipRoute(NpcData.NpcBlip, true)
                SetBlipRouteColour(NpcData.NpcBlip, 3)
                NpcData.LastNpc = NpcData.CurrentNpc
                NpcData.Active = true

                Citizen.CreateThread(function()
                    while not NpcData.NpcTaken do

                        local ped = PlayerPedId()
                        local pos = GetEntityCoords(ped)
                        local dist = #(pos - vector3(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z))

                        if dist < 20 then
                            DrawMarker(2, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
                        
                            if dist < 5 then
                                local npccoords = GetEntityCoords(NpcData.Npc)
                                DrawText3D(Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].x, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].y, Config.NPCLocations.TakeLocations[NpcData.CurrentNpc].z, '[E] Llamar NPC')
                                if IsControlJustPressed(0, 38) then
                                    local veh = GetVehiclePedIsIn(ped, 0)
                                    local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

                                    for i=maxSeats - 1, 0, -1 do
                                        if IsVehicleSeatFree(vehicle, i) then
                                            freeSeat = i
                                            break
                                        end
                                    end

                                    meterIsOpen = true
                                    meterActive = true
                                    lastLocation = GetEntityCoords(PlayerPedId())
                                    SendNUIMessage({
                                        action = "openMeter",
                                        toggle = true,
                                        meterData = Config.Meter
                                    })
                                    SendNUIMessage({
                                        action = "toggleMeter"
                                    })

                                    ClearPedTasksImmediately(NpcData.Npc)
                                    FreezeEntityPosition(NpcData.Npc, false)
                                    TaskEnterVehicle(NpcData.Npc, veh, -1, freeSeat, 1.0, 0)
                                    QBCore.Functions.Notify('Lleva al NPC a la ubicación especificada')
                                    if NpcData.NpcBlip ~= nil then
                                        RemoveBlip(NpcData.NpcBlip)
                                    end
                                    GetDeliveryLocation()
                                    NpcData.NpcTaken = true
                                end
                            end
                        end

                        Citizen.Wait(1)
                    end
                end)
            else
                QBCore.Functions.Notify('Ya estás haciendo una misión de NPC')
            end
      --  else
         --   QBCore.Functions.Notify('No NPCs Are Available')
       -- end
    else
        QBCore.Functions.Notify('No estas en un taxi')
    end
end)

function GetDeliveryLocation()
    NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
    if NpcData.LastDeliver ~= nil then
        while NpcData.LastDeliver ~= NpcData.CurrentDeliver do
            NpcData.CurrentDeliver = math.random(1, #Config.NPCLocations.DeliverLocations)
        end
    end

    if NpcData.DeliveryBlip ~= nil then
        RemoveBlip(NpcData.DeliveryBlip)
    end
    NpcData.DeliveryBlip = AddBlipForCoord(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z)
    SetBlipColour(NpcData.DeliveryBlip, 3)
    SetBlipRoute(NpcData.DeliveryBlip, true)
    SetBlipRouteColour(NpcData.DeliveryBlip, 3)
    NpcData.LastDeliver = NpcData.CurrentDeliver

    Citizen.CreateThread(function()
        while true do

            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            local dist = #(pos - vector3(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z))

            if dist < 20 then
                DrawMarker(2, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 255, 255, 255, 255, 0, 0, 0, 1, 0, 0, 0)
            
                if dist < 5 then
                    local npccoords = GetEntityCoords(NpcData.Npc)
                    DrawText3D(Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].x, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].y, Config.NPCLocations.DeliverLocations[NpcData.CurrentDeliver].z, '[E] Drop Off NPC')
                    if IsControlJustPressed(0, 38) then
                        local veh = GetVehiclePedIsIn(ped, 0)
                        TaskLeaveVehicle(NpcData.Npc, veh, 0)
                        SetEntityAsMissionEntity(NpcData.Npc, false, true)
                        SetEntityAsNoLongerNeeded(NpcData.Npc)
                        local targetCoords = Config.NPCLocations.TakeLocations[NpcData.LastNpc]
                        TaskGoStraightToCoord(NpcData.Npc, targetCoords.x, targetCoords.y, targetCoords.z, 1.0, -1, 0.0, 0.0)
                        SendNUIMessage({
                            action = "toggleMeter"
                        })
                        TriggerServerEvent('qb-taxi:server:NpcPay', meterData.currentFare)
                        QBCore.Functions.Notify('La Persona fue dejada', 'success')
                        if NpcData.DeliveryBlip ~= nil then
                            RemoveBlip(NpcData.DeliveryBlip)
                        end
                        local RemovePed = function(ped)
                            SetTimeout(60000, function()
                                DeletePed(ped)
                            end)
                        end
                       -- TimeoutNpc()
                        RemovePed(NpcData.Npc)
                        ResetNpcTask()
                        break
                    end
                end
            end

            Citizen.Wait(1)
        end
    end)
end

function ResetNpcTask()
    NpcData = {
        Active = false,
        CurrentNpc = nil,
        LastNpc = nil,
        CurrentDeliver = nil,
        LastDeliver = nil,
        Npc = nil,
        NpcBlip = nil,
        DeliveryBlip = nil,
        NpcTaken = false,
        NpcDelivered = false,
    }
end

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerData = QBCore.Functions.GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerData.job = JobInfo
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        calculateFareAmount()
    end
end)

function calculateFareAmount()
    if meterIsOpen and meterActive then
        start = lastLocation
  
        if start then
            current = GetEntityCoords(PlayerPedId())
            distance = #(start - current) --Not the best result but work
            meterData['distanceTraveled'] = distance
    
            fareAmount = (meterData['distanceTraveled'] / 400.00) * meterData['fareAmount']
    
            meterData['currentFare'] = math.ceil(fareAmount)

            SendNUIMessage({
                action = "updateMeter",
                meterData = meterData
            })
        end
    end
end

Citizen.CreateThread(function()
    while true do

        inRange = false

        if QBCore ~= nil then
            if isLoggedIn then

                if PlayerData.job.name == "taxi" then
                    local ped = PlayerPedId()
                    local pos = GetEntityCoords(ped)

                    local vehDist = #(pos - vector3(Config.Location.x, Config.Location.y, Config.Location.z))

                    if vehDist < 30 then
                        inRange = true

                        DrawMarker(2, Config.Location.x, Config.Location.y, Config.Location.z, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 0.3, 0.5, 0.2, 200, 0, 0, 222, false, false, false, true, false, false, false)

                        if vehDist < 1.5 then
                            if whitelistedVehicle() then
                                DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z + 0.3, '[E] Parking de Vehiculos')
                                if IsControlJustReleased(0, 38) then
                                    if IsPedInAnyVehicle(PlayerPedId(), false) then
                                        DeleteVehicle(GetVehiclePedIsIn(PlayerPedId()))
                                    end
                                end
                            else
                                DrawText3D(Config.Location.x, Config.Location.y, Config.Location.z + 0.3, '[E] Vehiculos de el trabajo')
                                if IsControlJustReleased(0, 38) then
                                    TaxiGarage()
                                    Menu.hidden = not Menu.hidden
                                end
                            end
                            Menu.renderGUI()
                        end
                    end
                end
            end
        end

        if not inRange then
            Citizen.Wait(3000)
        end

        Citizen.Wait(3)
    end
end)

RegisterNetEvent('qb-taxi:client:toggleMeter')
AddEventHandler('qb-taxi:client:toggleMeter', function()
    local ped = PlayerPedId()
    
    if IsPedInAnyVehicle(ped, false) then
        if whitelistedVehicle() then
            if not meterIsOpen then
                SendNUIMessage({
                    action = "openMeter",
                    toggle = true,
                    meterData = Config.Meter
                })
                meterIsOpen = true
            else
                SendNUIMessage({
                    action = "openMeter",
                    toggle = false
                })
                meterIsOpen = false
            end
        else
            QBCore.Functions.Notify('Este vehiculos no tiene un Taxímetro', 'error')
        end
    else
        QBCore.Functions.Notify('No estas en un vehiculo', 'error')
    end
end)

RegisterNetEvent('qb-taxi:client:enableMeter')
AddEventHandler('qb-taxi:client:enableMeter', function()
    local ped = PlayerPedId()

    if meterIsOpen then
        SendNUIMessage({
            action = "toggleMeter"
        })
    else
        QBCore.Functions.Notify('El taximetro no esta Activado', 'error')
    end
end)

RegisterNUICallback('enableMeter', function(data)
    meterActive = data.enabled

    if not data.enabled then
        SendNUIMessage({
            action = "resetMeter"
        })
    end
    lastLocation = GetEntityCoords(PlayerPedId())
end)

RegisterNetEvent('qb-taxi:client:toggleMuis')
AddEventHandler('qb-taxi:client:toggleMuis', function()
    Citizen.Wait(400)
    if meterIsOpen then
        if not mouseActive then
            SetNuiFocus(true, true)
            mouseActive = true
        end
    else
        QBCore.Functions.Notify('No hay taxímetro a la vista', 'error')
    end
end)

RegisterNUICallback('hideMouse', function()
    SetNuiFocus(false, false)
    mouseActive = false
end)

function whitelistedVehicle()
    local ped = PlayerPedId()
    local veh = GetEntityModel(GetVehiclePedIsIn(ped))
    local retval = false

    for i = 1, #Config.AllowedVehicles, 1 do
        if veh == GetHashKey(Config.AllowedVehicles[i].model) then
            retval = true
        end
    end

    if veh == GetHashKey("dynasty") then
        retval = true
    end
    
    return retval
end

function TaxiGarage()
    ped = PlayerPedId();
    MenuTitle = "Garaje"
    ClearMenu()
    Menu.addButton("Vehiculos", "VehicleList", nil)
    Menu.addButton("Cerrar Menu", "closeMenuFull", nil) 
end

function VehicleList()
    ped = PlayerPedId();
    MenuTitle = "Vehiculos:"
    ClearMenu()
    for k, v in pairs(Config.AllowedVehicles) do
        Menu.addButton(Config.AllowedVehicles[k].label, "TakeVehicle", k, "Garaje", " Motor: 100%", " Dañado: 0%", " Gasolina: 100%")
    end
        
    Menu.addButton("Vuelve atras", "TaxiGarage",nil)
end

function TakeVehicle(k)
    local coords = Config.Location
    QBCore.Functions.SpawnVehicle(Config.AllowedVehicles[k].model, function(veh)
        SetVehicleNumberPlateText(veh, "TAXI"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        closeMenuFull()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        SetVehicleEngineOn(veh, true, true)
        dutyPlate = GetVehicleNumberPlateText(veh)
    end, coords, true)
end

function closeMenuFull()
    Menu.hidden = true
    currentGarage = nil
    ClearMenu()
end

function DrawText3D(x, y, z, text)
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

Citizen.CreateThread(function()
    TaxiBlip = AddBlipForCoord(Config.Location)

    SetBlipSprite (TaxiBlip, 198)
    SetBlipDisplay(TaxiBlip, 4)
    SetBlipScale  (TaxiBlip, 0.6)
    SetBlipAsShortRange(TaxiBlip, true)
    SetBlipColour(TaxiBlip, 5)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("Central de Taxis")
    EndTextCommandSetBlipName(TaxiBlip)
end)
