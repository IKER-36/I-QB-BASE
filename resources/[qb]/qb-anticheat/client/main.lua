local group = Config.Group

-- Check if is decorating --

local IsDecorating = false

RegisterNetEvent('qb-anticheat:client:ToggleDecorate')
AddEventHandler('qb-anticheat:client:ToggleDecorate', function(bool)
  IsDecorating = bool
end)

-- Few frequently used locals --

local flags = 0 
local player = PlayerId()
local ped = PlayerPedId()

local isLoggedIn = false

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-anticheat:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
    isLoggedIn = true
end)

-- Superjump --

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(500)
 
        local ped = PlayerPedId()
        local pedId = PlayerPedId()

        if group == Config.Group and isLoggedIn then 
            if IsPedJumping(pedId) then
                local firstCoord = GetEntityCoords(ped)
  
                while IsPedJumping(pedId) do
                    Citizen.Wait(0)
                end
        
                local secondCoord = GetEntityCoords(ped)
                local lengthBetweenCoords = #(firstCoord - secondCoord)

                if (lengthBetweenCoords > Config.SuperJumpLength) then
                    flags = flags + 1      
                    TriggerServerEvent("qb-log:server:CreateLog", "Anticheat", "Hacker detectado!", "orange", "** @everyone " ..GetPlayerName(player).. "** a sido detectado por el anticheat **(Flag "..flags.." /"..Config.FlagsForBan.." | Superjump)**")         
                end
            end
        end
    end
end)

-- Speedhack --

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(700)

        local ped = PlayerPedId()
        local speed = GetEntitySpeed(ped) 
        local inveh = IsPedInAnyVehicle(ped, false)
        local ragdoll = IsPedRagdoll(ped)
        local jumping = IsPedJumping(ped)
        local falling = IsPedFalling(ped)
 
        if group == Config.Group and isLoggedIn then 
            if not inveh then
                if not ragdoll then 
                    if not falling then 
                        if not jumping then 
                            if speed > Config.MaxSpeed then 
                                flags = flags + 1 
                                TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheater detectado!", "orange", "** @everyone " ..GetPlayerName(player).. "** a sido detectado por el anticheat! **(Flag "..flags.." /"..Config.FlagsForBan.." | Speedhack)**")   
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- Invisibility --

Citizen.CreateThread(function()
    while true do      
        Citizen.Wait(10000)

        local ped = PlayerPedId()

        if group == Config.Group and isLoggedIn then 
            if not IsDecorating then 
                if not IsEntityVisible(ped) then
                    SetEntityVisible(ped, 1, 0)
                    TriggerEvent('QBCore:Notify', "QB-ANTICHEAT: ¡Eras invisible y has vuelto a ser visible!")
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Jugador visible", "green", "** @everyone " ..GetPlayerName(player).. "** era invisible y ha sido pillado nuevamente por QB-Anticheat")            
                end 
            end
        end
    end
end)

-- Nightvision --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        local ped = PlayerPedId()

        if group == Config.Group and isLoggedIn then 
            if GetUsingnightvision(true) then 
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1 
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheater detectado!", "orange", "** @everyone " ..GetPlayerName(player).. "** a sido pillado por el anticheat **(Flag "..flags.." /"..Config.FlagsForBan.." | Ponerse vision de noche)**")
                end
            end
        end
    end
end)

-- Thermalvision --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)

        local ped = PlayerPedId()

        if group == Config.Group and isLoggedIn then 
            if GetUsingseethrough(true) then 
                if not IsPedInAnyHeli(ped) then
                    flags = flags + 1
                    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheater detectado!", "orange", "** @everyone " ..GetPlayerName(player).. "** a sido pillado por el anticheat **(Flag "..flags.." /"..Config.FlagsForBan.." | Thermalvision)**") 
                end
            end
        end
    end
end)

-- Spawned car --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        local DriverSeat = GetPedInVehicleSeat(veh, -1)
        local plate = GetVehicleNumberPlateText(veh)

        if isLoggedIn then
            if group == Config.Group then
                if IsPedInAnyVehicle(ped, true) then
                    for _, BlockedPlate in pairs(Config.BlacklistedPlates) do
                        if plate == BlockedPlate then
                            if DriverSeat == ped then 
                                DeleteVehicle(veh)               
                                TriggerServerEvent("qb-anticheat:server:banPlayer", "Deja los cheats anda")
                                TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Cheater detectado!", "red", "** @everyone " ..GetPlayerName(player).. "** ha sido banneado por hacer trampa (se spawneo un vehiculo spawneado con matrícula **"..BlockedPlate.."**")         
                            end   
                        end
                    end
                else
                    Citizen.Wait(2000)
                end
            end
        end
    end
end)

-- Check if ped has weapon in inventory --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)

        if isLoggedIn then

            local PlayerPed = PlayerPedId()
            local CurrentWeapon = GetSelectedPedWeapon(PlayerPed)
            local WeaponInformation = QBCore.Shared.Weapons[CurrentWeapon]

            if WeaponInformation["name"]  ~= "weapon_unarmed" then
                QBCore.Functions.TriggerCallback('qb-anticheat:server:HasWeaponInInventory', function(HasWeapon)
                    if not HasWeapon then
                        RemoveAllPedWeapons(PlayerPed, false)
                        TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Armas quitadas", "orange", "** @everyone " ..GetPlayerName(player).. "**tenía un arma sobre ellos que no tenían en su inventario. QB Anticheat ha eliminado el arma.")  
                    end
                end, WeaponInformation)
            end

        end
    end
end)

-- Max flags reached = ban, log, explosion & break --

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)

        local coords = GetEntityCoords(ped, true)
        
        if flags >= Config.FlagsForBan then
            -- TriggerServerEvent("qb-anticheat:server:banPlayer", "Cheating")
            -- AddExplosion(coords, EXPLOSION_GRENADE, 1000.0, true, false, false, true)
            TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Jugador baneado! (En realidad no, por supuesto, esta es una prueba duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "**  a sido detectado por el anti-cheats y prohibido preventivamente del servidor")  
            flags = 0 
        end
    end
end)

RegisterNetEvent('qb-anticheat:client:NonRegisteredEventCalled')
AddEventHandler('qb-anticheat:client:NonRegisteredEventCalled', function(reason, CalledEvent)
    local player = PlayerId()
    local ped = PlayerPedId()

    TriggerServerEvent('qb-anticheat:server:banPlayer', reason)
    TriggerServerEvent("qb-log:server:CreateLog", "anticheat", "Jugador banneado! (En realidad no, por supuesto, esta es una prueba duuuhhhh)", "red", "** @everyone " ..GetPlayerName(player).. "** hizo el evento **"..CalledEvent.."intento triggear con un lua injector vaya noob xD")  
end)