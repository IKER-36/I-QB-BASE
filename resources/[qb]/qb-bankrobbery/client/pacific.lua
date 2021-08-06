local requiredItemsShowed = false
local requiredItemsShowed2 = false
local requiredItemsShowed3 = false
local requiredItemsShowed4 = false

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    local requiredItems3 = {
        [1] = {name = QBCore.Shared.Items["thermite"]["name"], image = QBCore.Shared.Items["thermite"]["image"]},
    }
    local requiredItems2 = {
        [1] = {name = QBCore.Shared.Items["electronickit"]["name"], image = QBCore.Shared.Items["electronickit"]["image"]},
        [2] = {name = QBCore.Shared.Items["trojan_usb"]["name"], image = QBCore.Shared.Items["trojan_usb"]["image"]},
    }
    local requiredItems = {
        [1] = {name = QBCore.Shared.Items["security_card_02"]["name"], image = QBCore.Shared.Items["security_card_02"]["image"]},
    }
    while true do
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        if QBCore ~= nil then
            if #(pos - vector3(Config.BigBanks["pacific"]["coords"][1]["x"], Config.BigBanks["pacific"]["coords"][1]["y"], Config.BigBanks["pacific"]["coords"][1]["z"])) < 10.0 then
                inRange = true
                if not Config.BigBanks["pacific"]["isOpened"] then
                    local dist = #(pos - vector3(Config.BigBanks["pacific"]["coords"][1]["x"], Config.BigBanks["pacific"]["coords"][1]["y"], Config.BigBanks["pacific"]["coords"][1]["z"]))
                    if dist < 1 then
                        if not requiredItemsShowed then
                            requiredItemsShowed = true
                            TriggerEvent('inventory:client:requiredItems', requiredItems, true)
                        end
                    else
                        if requiredItemsShowed then
                            requiredItemsShowed = false
                            TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                        end
                    end
                end
            end
            if #(pos - vector3(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"])) < 10.0 then
                inRange = true
                if not Config.BigBanks["pacific"]["isOpened"] then
                    local dist = #(pos - vector3(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"]))
                    if dist < 1 then
                        if not requiredItemsShowed2 then
                            requiredItemsShowed2 = true
                            TriggerEvent('inventory:client:requiredItems', requiredItems2, true)
                        end
                    else
                        if requiredItemsShowed2 then
                            requiredItemsShowed2 = false
                            TriggerEvent('inventory:client:requiredItems', requiredItems2, false)
                        end
                    end
                end
            end
            if #(pos - vector3(Config.BigBanks["pacific"]["thermite"][1]["x"], Config.BigBanks["pacific"]["thermite"][1]["y"], Config.BigBanks["pacific"]["thermite"][1]["z"])) < 10.0 then
                inRange = true
                if not Config.BigBanks["pacific"]["thermite"][1]["isOpened"] then
                    local dist = #(pos - vector3(Config.BigBanks["pacific"]["thermite"][1]["x"], Config.BigBanks["pacific"]["thermite"][1]["y"], Config.BigBanks["pacific"]["thermite"][1]["z"]))
                    if dist < 1 then
                        currentThermiteGate = Config.BigBanks["pacific"]["thermite"][1]["doorId"]
                        if not requiredItemsShowed3 then
                            requiredItemsShowed3 = true
                            TriggerEvent('inventory:client:requiredItems', requiredItems3, true)
                        end
                    else
                        currentThermiteGate = 0
                        if requiredItemsShowed3 then
                            requiredItemsShowed3 = false
                            TriggerEvent('inventory:client:requiredItems', requiredItems3, false)
                        end
                    end
                end
            end

            if Config.BigBanks["pacific"]["isOpened"] then
                for k, v in pairs(Config.BigBanks["pacific"]["lockers"]) do
                    local lockerDist = #(pos - vector3(Config.BigBanks["pacific"]["lockers"][k].x, Config.BigBanks["pacific"]["lockers"][k].y, Config.BigBanks["pacific"]["lockers"][k].z))
                    if not Config.BigBanks["pacific"]["lockers"][k]["isBusy"] then
                        if not Config.BigBanks["pacific"]["lockers"][k]["isOpened"] then
                            if lockerDist < 5 then
                                inRange = true
                                DrawMarker(2, Config.BigBanks["pacific"]["lockers"][k].x, Config.BigBanks["pacific"]["lockers"][k].y, Config.BigBanks["pacific"]["lockers"][k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.05, 255, 255, 255, 255, false, false, false, 1, false, false, false)
                                if lockerDist < 0.5 then
                                    DrawText3Ds(Config.BigBanks["pacific"]["lockers"][k].x, Config.BigBanks["pacific"]["lockers"][k].y, Config.BigBanks["pacific"]["lockers"][k].z + 0.3, '[E] Revienta la cafa fuerte')
                                    if IsControlJustPressed(0, 38) then
                                        if CurrentCops >= Config.MinimumPacificPolice then
                                            openLocker("pacific", k)
                                        else
                                            QBCore.Functions.Notify('Se necesitan mínimo '..Config.MinimumPacificPolice..' pulisias', "error")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if not inRange then
                Citizen.Wait(2500)
            end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(2000)
    local requiredItems4 = {
        [1] = {name = QBCore.Shared.Items["thermite"]["name"], image = QBCore.Shared.Items["thermite"]["image"]},
    }
    while true do 
        Citizen.Wait(1)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local inRange = false
        if QBCore ~= nil then
            if #(pos - vector3(Config.BigBanks["pacific"]["thermite"][2]["x"], Config.BigBanks["pacific"]["thermite"][2]["y"], Config.BigBanks["pacific"]["thermite"][2]["z"])) < 10.0 then
                inRange = true
                if not Config.BigBanks["pacific"]["thermite"][1]["isOpened"] then
                    local dist = #(pos - vector3(Config.BigBanks["pacific"]["thermite"][2]["x"], Config.BigBanks["pacific"]["thermite"][2]["y"], Config.BigBanks["pacific"]["thermite"][2]["z"]))
                    if dist < 1 then
                        currentThermiteGate = Config.BigBanks["pacific"]["thermite"][2]["doorId"]
                        if not requiredItemsShowed4 then
                            requiredItemsShowed4 = true
                            TriggerEvent('inventory:client:requiredItems', requiredItems4, true)
                        end
                    else
                        currentThermiteGate = 0
                        if requiredItemsShowed4 then
                            requiredItemsShowed4 = false
                            TriggerEvent('inventory:client:requiredItems', requiredItems4, false)

                        end
                    end
                end
            else
                Citizen.Wait(700)
            end
        end
    end
end)

RegisterNetEvent('electronickit:UseElectronickit')
AddEventHandler('electronickit:UseElectronickit', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"]))
    if dist < 1.5 then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isRobberyActive', function(isBusy)
            if not isBusy then
                local dist = #(pos - vector3(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"]))
                if dist < 1.5 then
                    if CurrentCops >= Config.MinimumPacificPolice then
                        if not Config.BigBanks["pacific"]["isOpened"] then 
                            QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
                                if result then 
                                    TriggerEvent('inventory:client:requiredItems', requiredItems, false)
                                    QBCore.Functions.Progressbar("hack_gate", "Conectando el dispositivo de piratería. ..", math.random(5000, 10000), false, true, {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "anim@gangops@facility@servers@",
                                        anim = "hotwire",
                                        flags = 16,
                                    }, {}, {}, function() -- Done
                                        TriggerServerEvent("QBCore:Server:RemoveItem", "electronickit", 1)
                                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["electronickit"], "remove")
                                        TriggerServerEvent("QBCore:Server:RemoveItem", "trojan_usb", 1)
                                        TriggerEvent('inventory:client:ItemBox', QBCore.Shared.Items["trojan_usb"], "remove")
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                        TriggerEvent("mhacking:show")
                                        TriggerEvent("mhacking:start", math.random(5, 9), math.random(10, 15), OnHackPacificDone)
                                
                                        if not copsCalled then
                                            local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                                            local street1 = GetStreetNameFromHashKey(s1)
                                            local street2 = GetStreetNameFromHashKey(s2)
                                            local streetLabel = street1
                                            if street2 ~= nil then 
                                                streetLabel = streetLabel .. " " .. street2
                                            end
                                            if Config.BigBanks["pacific"]["alarm"] then
                                                TriggerServerEvent("qb-bankrobbery:server:callCops", "pacific", 0, streetLabel, pos)
                                                copsCalled = true
                                            end
                                        end
                                    end, function() -- Cancel
                                        StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                                        QBCore.Functions.Notify("Cancelado", "error")
                                    end)
                                else
                                    QBCore.Functions.Notify("Te falta algún objeto ..", "error")
                                end
                            end, "trojan_usb")
                        else
                            QBCore.Functions.Notify("Parece que el banco ya está abierto", "error")
                        end
                    else
                        QBCore.Functions.Notify('Se necesitan mínimo '..Config.MinimumPacificPolice..' pulisias', "error")
                    end
                end
            else
                QBCore.Functions.Notify("El bloqueo de seguridad está activo, la apertura de la puerta no es actualmente posible.", "error", 5500)
            end
        end)
    end
end)

RegisterNetEvent('qb-bankrobbery:UseBankcardB')
AddEventHandler('qb-bankrobbery:UseBankcardB', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local dist = #(pos - vector3(Config.BigBanks["pacific"]["coords"][1]["x"], Config.BigBanks["pacific"]["coords"][1]["y"],Config.BigBanks["pacific"]["coords"][1]["z"]))
    if math.random(1, 100) <= 85 and not IsWearingHandshoes() then
        TriggerServerEvent("evidence:server:CreateFingerDrop", pos)
    end
    if dist < 1.5 then
        QBCore.Functions.TriggerCallback('qb-bankrobbery:server:isRobberyActive', function(isBusy)
            if not isBusy then
                if CurrentCops >= Config.MinimumPacificPolice then
                    if not Config.BigBanks["pacific"]["isOpened"] then 
                        TriggerEvent('inventory:client:requiredItems', requiredItems2, false)
                        QBCore.Functions.Progressbar("security_pass", "Por favor valide ..", math.random(5000, 10000), false, true, {
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@gangops@facility@servers@",
                            anim = "hotwire",
                            flags = 16,
                        }, {}, {}, function() -- Done
                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            TriggerServerEvent('qb-doorlock:server:updateState', 76, false)
                            TriggerServerEvent("QBCore:Server:RemoveItem", "security_card_02", 1)
                            if not copsCalled then
                                local s1, s2 = Citizen.InvokeNative(0x2EB41072B4C1E4C0, pos.x, pos.y, pos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt())
                                local street1 = GetStreetNameFromHashKey(s1)
                                local street2 = GetStreetNameFromHashKey(s2)
                                local streetLabel = street1
                                if street2 ~= nil then 
                                    streetLabel = streetLabel .. " " .. street2
                                end
                                if Config.BigBanks["pacific"]["alarm"] then
                                    TriggerServerEvent("qb-bankrobbery:server:callCops", "pacific", 0, streetLabel, pos)
                                    copsCalled = true
                                end
                            end
                        end, function() -- Cancel
                            StopAnimTask(PlayerPedId(), "anim@gangops@facility@servers@", "hotwire", 1.0)
                            QBCore.Functions.Notify("Cancelado..", "error")
                        end)
                    else
                        QBCore.Functions.Notify("Parece que el banco ya está abierto ..", "error")
                    end
                else
                    QBCore.Functions.Notify('Se necesitan mínimo '..Config.MinimumPacificPolice..' pulisias', "error")
                end
            else
                QBCore.Functions.Notify("El bloqueo de seguridad está activo, la apertura de la puerta no es actualmente posible.", "error", 5500)
            end
        end)
    end 
end)

function OnHackPacificDone(success, timeremaining)
    if success then
        TriggerEvent('mhacking:hide')
        TriggerServerEvent('qb-bankrobbery:server:setBankState', "pacific", true)
    else
		TriggerEvent('mhacking:hide')
	end
end

function OpenPacificDoor()
    local object = GetClosestObjectOfType(Config.BigBanks["pacific"]["coords"][2]["x"], Config.BigBanks["pacific"]["coords"][2]["y"], Config.BigBanks["pacific"]["coords"][2]["z"], 20.0, Config.BigBanks["pacific"]["object"], false, false, false)
    local timeOut = 10
    local entHeading = Config.BigBanks["pacific"]["heading"].closed

    if object ~= 0 then
        Citizen.CreateThread(function()
            while true do

                if entHeading > Config.BigBanks["pacific"]["heading"].open then
                    SetEntityHeading(object, entHeading - 10)
                    entHeading = entHeading - 0.5
                else
                    break
                end

                Citizen.Wait(10)
            end
        end)
    end
end
