-- Variables
local frozen = false
local permissions = {
    ["kill"] = "god",
    ["ban"] = "admin",
    ["noclip"] = "admin",
    ["kickall"] = "admin",
    ["kick"] = "admin"
}

-- Get Players

QBCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        table.insert(players, {
            name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname .. " | (" .. GetPlayerName(v) .. ")",
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source

        })
    end
    cb(players)
end)

QBCore.Functions.CreateCallback('qb-admin:server:getrank', function(source, cb)
    if QBCore.Functions.HasPermission(source, "god") then
        cb(true)
    else
        cb(false)
    end
end)

-- Functions

function tablelength(table)
    local count = 0
    for _ in pairs(table) do 
        count = count + 1 
    end
    return count
end

-- Events

RegisterNetEvent("qb-admin:server:kill")
AddEventHandler("qb-admin:server:kill", function(player)
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
end)

RegisterNetEvent("qb-admin:server:revive")
AddEventHandler("qb-admin:server:revive", function(player)
    TriggerClientEvent('hospital:client:Revive', player.id)
end)

RegisterNetEvent("qb-admin:server:kick")
AddEventHandler("qb-admin:server:kick", function(player, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["kick"]) then
        DropPlayer(player.id, "Has sido kickeado del servidor.:\n" .. reason .. "\n\n🔸 Únete al servidor de discord para más información.: https://discord.gg/cambiarserverluaadminmenulinea66")
    end
end)

RegisterNetEvent("qb-admin:server:ban")
AddEventHandler("qb-admin:server:ban", function(player, time, reason)
    local src = source
    if QBCore.Functions.HasPermission(src, permissions["ban"]) then
        local time = tonumber(time)
        local banTime = tonumber(os.time() + time)
        if banTime > 2147483647 then
            banTime = 2147483647
        end
        local timeTable = os.date("*t", banTime)
        exports.ghmattimysql:execute('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (@name, @license, @discord, @ip, @reason, @expire, @bannedby)', {
            ['@name'] = GetPlayerName(player.id),
            ['@license'] = QBCore.Functions.GetIdentifier(player.id, 'license'),
            ['@discord'] = QBCore.Functions.GetIdentifier(player.id, 'discord'),
            ['@ip'] = QBCore.Functions.GetIdentifier(player.id, 'ip'),
            ['@reason'] = reason,
            ['@expire'] = banTime,
            ['@bannedby'] = GetPlayerName(src)
        })
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div class="chat-message server"><strong>ANUNCIO | {0} ha sido baneado:</strong> {1}</div>',
            args = {GetPlayerName(player.id), reason}
        })
        if banTime >= 2147483647 then
            DropPlayer(player.id, "Has sido baneado:\n" .. reason .. "\n\nYour ban is permanent.\n🔸 Únete al servidor de discord para más información.: https://discord.gg/cambiarserverluaadminmenulinea94")
        else
            DropPlayer(player.id, "Has sido baneado:\n" .. reason .. "\n\nCaduca: " .. timeTable["day"] .. "/" .. timeTable["month"] .. "/" .. timeTable["year"] .. " " .. timeTable["hour"] .. ":" .. timeTable["min"] .. "\n🔸 Únete al servidor de discord para más información.: https://discord.gg/cambiarserverluaadminmenulinea96")
        end
    end
end)

RegisterNetEvent("qb-admin:server:spectate")
AddEventHandler("qb-admin:server:spectate", function(player)
    local src = source
    local targetped = GetPlayerPed(player.id)
    local coords = GetEntityCoords(targetped)
    TriggerClientEvent('qb-admin:client:spectate', src, player.id, coords)
end)

RegisterNetEvent("qb-admin:server:freeze")
AddEventHandler("qb-admin:server:freeze", function(player)
    local target = GetPlayerPed(player.id)
    if not frozen then
        frozen = true
        FreezeEntityPosition(target, true)
    else
        frozen = false
        FreezeEntityPosition(target, false)
    end
end)

RegisterNetEvent('qb-admin:server:goto')
AddEventHandler('qb-admin:server:goto', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(GetPlayerPed(player.id))
    SetEntityCoords(admin, coords)
end)

RegisterNetEvent('qb-admin:server:bring')
AddEventHandler('qb-admin:server:bring', function(player)
    local src = source
    local admin = GetPlayerPed(src)
    local coords = GetEntityCoords(admin)
    local target = GetPlayerPed(player.id)
    SetEntityCoords(target, coords)
end)

RegisterNetEvent("qb-admin:server:inventory")
AddEventHandler("qb-admin:server:inventory", function(player)
    local src = source
    TriggerClientEvent('qb-admin:client:inventory', src, player.id)
end)

RegisterNetEvent("qb-admin:server:cloth")
AddEventHandler("qb-admin:server:cloth", function(player)
	TriggerClientEvent("qb-clothing:client:openMenu", player.id)
end)

RegisterServerEvent('qb-admin:server:setPermissions')
AddEventHandler('qb-admin:server:setPermissions', function(targetId, group)
    QBCore.Functions.AddPermission(targetId, group[1].rank)
    TriggerClientEvent('QBCore:Notify', targetId, 'Su nivel de permiso es ahora '..group[1].label)
end)

RegisterServerEvent('qb-admin:server:SendReport')
AddEventHandler('qb-admin:server:SendReport', function(name, targetSrc, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "REPORTE - "..name.." ("..targetSrc..")", "report", msg)
        end
    end
end)

RegisterServerEvent('qb-admin:server:StaffChatMessage')
AddEventHandler('qb-admin:server:StaffChatMessage', function(name, msg)
    local src = source
    local Players = QBCore.Functions.GetPlayers()

    if QBCore.Functions.HasPermission(src, "admin") then
        if QBCore.Functions.IsOptin(src) then
            TriggerClientEvent('chatMessage', src, "CHAT STAFF - "..name, "error", msg)
        end
    end
end)

RegisterServerEvent('qb-admin:server:SaveCar')
AddEventHandler('qb-admin:server:SaveCar', function(mods, vehicle, hash, plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.ghmattimysql:executeSync('SELECT plate FROM player_vehicles WHERE plate=@plate', {['@plate'] = plate})
    if result[1] == nil then
        exports.ghmattimysql:execute('INSERT INTO player_vehicles (license, citizenid, vehicle, hash, mods, plate, state) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @state)', {
            ['@license'] = Player.PlayerData.license,
            ['@citizenid'] = Player.PlayerData.citizenid,
            ['@vehicle'] = vehicle.model,
            ['@hash'] = vehicle.hash,
            ['@mods'] = json.encode(mods),
            ['@plate'] = plate,
            ['@state'] = 0
        })
        TriggerClientEvent('QBCore:Notify', src, 'Este vehículo es ahora tuyo.!', 'success', 5000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Este vehículo ya era tuyo...', 'error', 3000)
    end
end)

-- Commands

QBCore.Commands.Add("apropiarsedecoche", "Guarda este vehículo a tu garaje (Solo Admin)", {}, false, function(source, args)
    local ply = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SaveCar', source)
end, "admin")

QBCore.Commands.Add("anuncio", "Hacer un anuncio (Solo Admin)", {}, false, function(source, args)
    local msg = table.concat(args, " ")
    for i = 1, 3, 1 do
        TriggerClientEvent('chatMessage', -1, "SISTEMA", "error", msg)
    end
end, "admin")

QBCore.Commands.Add("admin", "Abrir menú de administrador (Solo Admin)", {}, false, function(source, args)
    TriggerClientEvent('qb-admin:client:openMenu', source)
end, "admin")

QBCore.Commands.Add("report", "Reportar (Llega a administración)", {{name="mensaje", help="Mensaje"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent('qb-admin:client:SendReport', -1, GetPlayerName(source), source, msg)
    TriggerClientEvent('chatMessage', source, "REPORTE ENVIADO:", "normal", msg)
    TriggerEvent("qb-log:server:CreateLog", "report", "Reporte", "green", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Reporte:** " ..msg, false)
end)

QBCore.Commands.Add("chatstaff", "Enviar mensaje al chat de staff (Solo Admin)", {{name="mensaje", help="Mensaje"}}, true, function(source, args)
    local msg = table.concat(args, " ")
    TriggerClientEvent('qb-admin:client:SendStaffChat', -1, GetPlayerName(source), msg)
end, "admin")

QBCore.Commands.Add("darfocusnui", "Dar a un jugador enfoque de nui (Solo Admin)", {{name="id", help="ID Del Jugador"}, {name="focus", help="Enfocar on/off"}, {name="raton", help="Poner el raton on/off"}}, true, function(source, args)
    local playerid = tonumber(args[1])
    local focus = args[2]
    local mouse = args[3]
    TriggerClientEvent('qb-admin:client:GiveNuiFocus', playerid, focus, mouse)
end, "admin")

QBCore.Commands.Add("warn", "Warnea a un jugador (Solo Admin)", {{name="ID", help="Jugador"}, {name="Razón", help="Menciona una razón"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local senderPlayer = QBCore.Functions.GetPlayer(source)
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local myName = senderPlayer.PlayerData.name
    local warnId = "WARN-"..math.random(1111, 9999)
    if targetPlayer ~= nil then
        TriggerClientEvent('chatMessage', targetPlayer.PlayerData.source, "SISTEMA", "error", "Has sido warneado por: "..GetPlayerName(source)..", Razón: "..msg)
        TriggerClientEvent('chatMessage', source, "SISTEMA", "error", "Has warneado a "..GetPlayerName(targetPlayer.PlayerData.source).." por: "..msg)
        exports.ghmattimysql:execute('INSERT INTO player_warns (senderIdentifier, targetIdentifier, reason, warnId) VALUES (@senderIdentifier, @targetIdentifier, @reason, @warnId)', {
            ['@senderIdentifier'] = senderPlayer.PlayerData.license,
            ['@targetIdentifier'] = targetPlayer.PlayerData.license,
            ['@reason'] = msg,
            ['@warnId'] = warnId
        })
    else
        TriggerClientEvent('QBCore:Notify', source, 'Este jugador no esta en línea', 'error')
    end 
end, "admin")

QBCore.Commands.Add("checkwarns", "Revise los warnings de un jugador (Solo Admin)", {{name="ID", help="Jugador"}, {name="Warnings", help="Numero de warnings, (1, 2, 3 etc..)"}}, false, function(source, args)
    if args[2] == nil then
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local result = exports.ghmattimysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier=@targetIdentifier', {['@targetIdentifier'] = targetPlayer.PlayerData.license})
            TriggerClientEvent('chatMessage', source, "SISTEMA", "warning", targetPlayer.PlayerData.name.." tiene "..tablelength(result).." warnings!")
    else
        local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
        local warnings = exports.ghmattimysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier=@targetIdentifier', {['@targetIdentifier'] = targetPlayer.PlayerData.license})
        local selectedWarning = tonumber(args[2])
        if warnings[selectedWarning] ~= nil then
            local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
            TriggerClientEvent('chatMessage', source, "SISTEMA", "warning", targetPlayer.PlayerData.name.." ha sido warneado por "..sender.PlayerData.name..", Razón: "..warnings[selectedWarning].reason)
        end
    end
end, "admin")

QBCore.Commands.Add("borrarwarn", "Borrar warning a jugador (Solo Admin)", {{name="ID", help="ID Del Jugador"}, {name="Warning", help="Número de warnings, (1, 2, 3 etc..)"}}, true, function(source, args)
    local targetPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
    local warnings = exports.ghmattimysql:executeSync('SELECT * FROM player_warns WHERE targetIdentifier=@targetIdentifier', {['@targetIdentifier'] = targetPlayer.PlayerData.license})
    local selectedWarning = tonumber(args[2])
    if warnings[selectedWarning] ~= nil then
        local sender = QBCore.Functions.GetPlayer(warnings[selectedWarning].senderIdentifier)
        TriggerClientEvent('chatMessage', source, "SISTEMA", "warning", "Has borrado el warning ("..selectedWarning..") , Razón: "..warnings[selectedWarning].reason)
        exports.ghmattimysql:execute('DELETE FROM player_warns WHERE warnId=@warnId', {['@warnId'] = warnings[selectedWarning].warnId})
    end
end, "admin")
QBCore.Commands.Add("reportr", "Responde a un reporte (Solo Admin)", {}, false, function(source, args)
    local playerId = tonumber(args[1])
    table.remove(args, 1)
    local msg = table.concat(args, " ")
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    local Player = QBCore.Functions.GetPlayer(source)
    if OtherPlayer ~= nil then
        TriggerClientEvent('chatMessage', playerId, "ADMIN - "..GetPlayerName(source), "warning", msg)
        TriggerClientEvent('QBCore:Notify', source, "Respuesta enviada")
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            if QBCore.Functions.HasPermission(v, "admin") then
                if QBCore.Functions.IsOptin(v) then
                    TriggerClientEvent('chatMessage', v, "Respuesta Reporte("..source..") - "..GetPlayerName(source), "warning", msg)
                    TriggerEvent("qb-log:server:CreateLog", "report", "Respuesta a reporte", "red", "**"..GetPlayerName(source).."** respondió a: **"..OtherPlayer.PlayerData.name.. " **(ID: "..OtherPlayer.PlayerData.source..") **Mensaje:** " ..msg, false)
                end
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "El jugador no esta en línea", "error")
    end
end, "admin")

QBCore.Commands.Add("setmodelo", "CAMBIAR MODELO PED (Solo Admin)", {{name="modelo", help="Nombre del modelo"}, {name="id", help="ID del jugador (vacío si es para ti mismo)"}}, false, function(source, args)
    local model = args[1]
    local target = tonumber(args[2])
    if model ~= nil or model ~= "" then
        if target == nil then
            TriggerClientEvent('qb-admin:client:SetModel', source, tostring(model))
        else
            local Trgt = QBCore.Functions.GetPlayer(target)
            if Trgt ~= nil then
                TriggerClientEvent('qb-admin:client:SetModel', target, tostring(model))
            else
                TriggerClientEvent('QBCore:Notify', source, "Esta persona no esta en línea..", "error")
            end
        end
    else
        TriggerClientEvent('QBCore:Notify', source, "No estableciste un modelo..", "error")
    end
end, "admin")

QBCore.Commands.Add("setvelocidad", "Establecer la velocidad de tu personaje (Solo Admin)", {}, false, function(source, args)
    local speed = args[1]
    if speed ~= nil then
        TriggerClientEvent('qb-admin:client:SetSpeed', source, tostring(speed))
    else
        TriggerClientEvent('QBCore:Notify', source, "No estableciste una velocidad.. (`fast` para super-run, `normal` para normal)", "error")
    end
end, "admin")

QBCore.Commands.Add("activarreportes", "Alternar que te entren reportes (Solo Admin)", {}, false, function(source, args)
    QBCore.Functions.ToggleOptin(source)
    if QBCore.Functions.IsOptin(source) then
        TriggerClientEvent('QBCore:Notify', source, "Estas recibiendo reportes", "success")
    else
        TriggerClientEvent('QBCore:Notify', source, "Usted ya no está recibiendo reportes", "error")
    end
end, "admin")

RegisterCommand("kickeartodos", function(source, args, rawCommand)
    local src = source
    if src > 0 then
        local reason = table.concat(args, ' ')
        local Player = QBCore.Functions.GetPlayer(src)

        if QBCore.Functions.HasPermission(src, "god") then
            if args[1] ~= nil then
                for k, v in pairs(QBCore.Functions.GetPlayers()) do
                    local Player = QBCore.Functions.GetPlayer(v)
                    if Player ~= nil then 
                        DropPlayer(Player.PlayerData.source, reason)
                    end
                end
            else
                TriggerClientEvent('chatMessage', src, 'SISTEMA', 'error', 'Menciona una razón..')
            end
        else
            TriggerClientEvent('chatMessage', src, 'SISTEMA', 'error', 'No puedes hacer esto..')
        end
    else
        for k, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then 
                DropPlayer(Player.PlayerData.source, "Reinicio del servidor, comprueba nuestro discord¡ para más información.! (discord.gg/cambiarenqb-adminmenu;server;linea375)")
            end
        end
    end
end, false)

QBCore.Commands.Add("setmunicion", "Setea tu cantidad de munición (Solo Admin)", {{name="cantidad", help="Cantidad de balas, por ejemplo: 20"}, {name="arma", help="Nombre del arma, por ejemplo: WEAPON_VINTAGEPISTOL"}}, false, function(source, args)
    local src = source
    local weapon = args[2]
    local amount = tonumber(args[1])

    if weapon ~= nil then
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, weapon, amount)
    else
        TriggerClientEvent('qb-weapons:client:SetWeaponAmmoManual', src, "current", amount)
    end
end, 'admin')
