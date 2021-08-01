local banlength = nil
local banreason = 'Unknown'
local kickreason = 'Unknown'
local menu = MenuV:CreateMenu(false, 'Menu Administrador', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test')
local menu2 = MenuV:CreateMenu(false, 'Opciones Administrador', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test1')
local menu3 = MenuV:CreateMenu(false, 'Opciones Propias', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test2')
local menu4 = MenuV:CreateMenu(false, 'Lista Jugadores', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test3')
local menu5 = MenuV:CreateMenu(false, 'Configuración Servidor', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test4')
local menu6 = MenuV:CreateMenu(false, 'Opciones meteorológicas', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test5')
local menu7 = MenuV:CreateMenu(false, 'Comprobar/Añadir vendedores', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test6')
local menu8 = MenuV:CreateMenu(false, 'Banear', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test7')
local menu9 = MenuV:CreateMenu(false, 'Kickear', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test8')
local menu10 = MenuV:CreateMenu(false, 'Permisos', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv', 'test9')

RegisterNetEvent('qb-admin:client:openMenu')
AddEventHandler('qb-admin:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)

local menu_button = menu:AddButton({
    icon = '😃',
    label = 'Opciones de Administrador',
    value = menu2,
    description = 'Misc. Opciones de Administrador'
})
local menu_button2 = menu:AddButton({
    icon = '😃',
    label = 'Gestion Jugadores',
    value = menu4,
    description = 'Ver lista Jugadores'
})
local menu_button3 = menu:AddButton({
    icon = '😃',
    label = 'Gestión del servidor',
    value = menu5,
    description = 'Misc. Opciones Servidor'
})

local menu_button4 = menu2:AddButton({
    icon = '😃',
    label = 'Opciones Propias',
    value = menu3,
    description = 'Misc. Opciones Propias'
})
local menu_button5 = menu3:AddCheckbox({
    icon = '🎥',
    label = 'No-Clip',
    value = menu3,
    description = 'Activar/Desactivar NoClip'
})
local menu_button6 = menu3:AddButton({
    icon = '🏥',
    label = 'Revive',
    value = menu3,
    description = 'Revivir'
})
local menu_button7 = menu3:AddCheckbox({
    icon = '👻',
    label = 'Invisible',
    value = menu3,
    description = 'Activar/Desactivar Invisibilidad'
})
local menu_button8 = menu3:AddCheckbox({
    icon = '⚡',
    label = 'Inmortalidad',
    value = menu3,
    description = 'Activar/Desactivar Inmortalidad'
})
local menu_button9 = menu3:AddCheckbox({
    icon = '🔫',
    label = 'Borrar Laser',
    value = menu3,
    description = 'Activar/Desactivar Laser'
})
local menu_button11 = menu5:AddButton({
    icon = '🌡️',
    label = 'Opciones del tiempo',
    value = menu6,
    description = 'Cambiar el clima'
})
--[[ local menu_button12 = menu5:AddButton({
    icon = '😃',
    label = 'Gestionar concesionarios',
    value = menu7,
    description = 'Crear/Borrar Encargados'
}) ]]
local menu_button13 = menu5:AddSlider({
    icon = '⏲️',
    label = 'Tiempo de Servidor',
    value = GetClockHours(),
    values = {{
        label = '00',
        value = '00',
        description = 'Hora'
    }, {
        label = '01',
        value = '01',
        description = 'Hora'
    }, {
        label = '02',
        value = '02',
        description = 'Hora'
    }, {
        label = '03',
        value = '03',
        description = 'Hora'
    }, {
        label = '04',
        value = '04',
        description = 'Hora'
    }, {
        label = '05',
        value = '05',
        description = 'Hora'
    }, {
        label = '06',
        value = '06',
        description = 'Hora'
    }, {
        label = '07',
        value = '07',
        description = 'Hora'
    }, {
        label = '08',
        value = '08',
        description = 'Hora'
    }, {
        label = '09',
        value = '09',
        description = 'Hora'
    }, {
        label = '10',
        value = '10',
        description = 'Hora'
    }, {
        label = '11',
        value = '11',
        description = 'Hora'
    }, {
        label = '12',
        value = '12',
        description = 'Hora'
    }, {
        label = '13',
        value = '13',
        description = 'Hora'
    }, {
        label = '14',
        value = '14',
        description = 'Hora'
    }, {
        label = '15',
        value = '15',
        description = 'Hora'
    }, {
        label = '16',
        value = '16',
        description = 'Hora'
    }, {
        label = '17',
        value = '17',
        description = 'Hora'
    }, {
        label = '18',
        value = '18',
        description = 'Hora'
    }, {
        label = '19',
        value = '19',
        description = 'Hora'
    }, {
        label = '20',
        value = '20',
        description = 'Hora'
    }, {
        label = '21',
        value = '21',
        description = 'Hora'
    }, {
        label = '22',
        value = '22',
        description = 'Hora'
    }, {
        label = '23',
        value = '23',
        description = 'Hora'
    }}
})

menu_button11:On("select",function()
    local elements = {
        [1] = {
            icon = '☀️',
            label = 'Extra Soleado',
            value = "EXTRASUNNY",
            description = 'Me estoy derritiendo!'
        },
        [2] = {
            icon = '☀️',
            label = 'Soleado',
            value = "CLEAR",
            description = 'El día perfecto!'
        },
        [3] = {
            icon = '☀️',
            label = 'Neutral',
            value = "NEUTRAL",
            description = '¡Solo un día regular!'
        },
        [4] = {
            icon = '🌁',
            label = 'Niebla tóxica',
            value = "SMOG",
            description = 'Maquina de humo!'
        },
        [5] = {
            icon = '🌫️',
            label = 'Neblinoso',
            value = "FOGGY",
            description = 'Maquina de humo x2!'
        },
        [6] = {
            icon = '⛅',
            label = 'Nublado',
            value = "OVERCAST",
            description = 'No demasiado soleado!'
        },
        [7] = {
            icon = '☁️',
            label = 'Nubes',
            value = "CLOUDS",
            description = 'Dónde está el sol?'
        },
        [8] = {
            icon = '🌤️',
            label = 'Despejandose',
            value = "CLEARING",
            description = 'Las nubes comienzan a despejar!'
        },
        [9] = {
            icon = '☂️',
            label = 'Lluvia',
            value = "RAIN",
            description = 'Haz que llueva!'
        },
       
        [10] = {
            icon = '⛈️',
            label = 'Tormenta',
            value = "THUNDER",
            description = '¡Correr y esconderse!'
        },
        [11] = {
            icon = '❄️',
            label = 'Nieve',
            value = "SNOW",
            description = 'Hace frío aquí?'
        },
        [12] = {
            icon = '🌨️',
            label = 'Tormenta de nieve',
            value = "BLIZZARD",
            description = 'Maquina de nieve?'
        },
        [13] = {
            icon = '❄️',
            label = 'Nevada ligera',
            value = "SNOWLIGHT",
            description = 'Empezando a sentirse como la navidad!'
        },
        [14] = {
            icon = '🌨️',
            label = 'Fuertes nevadas (NAVIDAD)',
            value = "XMAS",
            description = 'Guerra de nieve!'
        },
        [15] = {
            icon = '🎃',
            label = 'Halloween',
            value = "HALLOWEEN",
            description = 'Que fue ese ruido?!'
        }
    }
    MenuV:OpenMenu(menu6)
    for k,v in ipairs(elements) do 
        local menu_button14 = menu6:AddButton({icon = v.icon,label = v.label,value = v,description = v.description,select = function(btn) 
        local selection = btn.Value
        print(selection.value)
        TriggerServerEvent('qb-weathersync:server:setWeather', selection.value)
            QBCore.Functions.Notify('El clima fue cambiado a: '..selection.label)
        end})
    end
end)

local menu_button29 = menu7:AddButton({
    icon = '🔌',
    label = 'Distribuidores existentes',
    value = menu7,
    description = 'Distribuidores creados'
})
local menu_button30 = menu7:AddButton({
    icon = '➕',
    label = 'Crear distribuidor',
    value = menu7,
    description = 'Hacer un nuevo distribuidor'
})

-- Player List
menu_button2:On('select', function(item)
    menu4:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for k, v in pairs(players) do
            local menu_button10 = menu4:AddButton({
                label = 'ID:' .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = 'Nombre del jugador',
                select = function(btn)
                    local select = btn.Value -- ¡Consigue todos los valores de V!
                    
                    OpenPlayerMenus(select) -- Solo pasa lo que no seleccionó nada más.

                end
            }) -- WORKS
        end
    end)
end)

menu_button13:On("select", function(item, value)
    TriggerServerEvent("qb-weathersync:server:sethour", value, value)
    QBCore.Functions.Notify("Hora cambiada a " .. value .. " hs 00 min")

end)

function OpenPlayerMenus(player)

    local Players = MenuV:CreateMenu(false, player.cid .. ' Opciones', 'topright', 155, 0, 0, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    elements = {
        [1] = {
            icon = '💀',
            label = "Matar",
            value = "kill",
            description = "Matar a " .. player.cid
        },
        [2] = {
            icon = '🏥',
            label = "Reanimar",
            value = "revive",
            description = "Reanimar a " .. player.cid
        },
        [3] = {
            icon = '🥶',
            label = "Freezear",
            value = "freeze",
            description = "Freezea a " .. player.cid
        },
        [4] = {
            icon = '👀',
            label = "Espectar",
            value = "spectate",
            description = "Espectar a " .. player.cid
        },
        [5] = {
            icon = '➡️',
            label = "Ir a",
            value = "goto",
            description = "Ir a la posición de " .. player.cid 
        },
        [6] = {
            icon = '⬅️',
            label = "Traer",
            value = "bring",
            description = "Trae a " .. player.cid .. " a tu posición"
        },
        [7] = {
            icon = '🎒',
            label = "Abrir el inventario",
            value = "inventory",
            description = "Abrir el inventario a " .. player.cid
        },
        [8] = {
            icon = '👕',
            label = "Dar menú de ropa",
            value = "cloth",
            description = "Dar el menú de ropa a " .. player.cid
        },
        [9] = {
            icon = '🥾',
            label = "Kickear",
            value = "kick",
            description = "Kickear a " .. player.cid .. " necesitas dar una razón"
        },
        [10] = {
            icon = '🚫',
            label = "Banear",
            value = "ban",
            description = "Banear a " .. player.cid .. " necesitas dar una razón"
        },
        [11] = {
            icon = '🎟️',
            label = "Permisos",
            value = "perms",
            description = "Dar a " .. player.cid .. " permisos"
        }
    }
    for k, v in ipairs(elements) do
        local menu_button10 = Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            value = v.value,
            description = v.description,
            select = function(btn)
                local values = btn.Value
                if values ~= "ban" and values ~= "kick" and values ~= "perms" then
                    TriggerServerEvent('qb-admin:server:'..values, player)
                elseif values == "ban" then
                    OpenBanMenu(player)
                elseif values == "kick" then
                    OpenKickMenu(player)
                elseif values == "perms" then
                    OpenPermsMenu(player)
                end
            end
        })
    end
end

function OpenBanMenu(banspeler)
    MenuV:OpenMenu(menu8)
    menu8:ClearItems()
    local menu_button15 = menu8:AddButton({
        icon = '',
        label = 'Razón',
        value = "reason",
        description = 'Razón del baneo',
        select = function(btn)
            banreason = LocalInput('Ban Reason', 255, 'Reason')
        end
    })

    local menu_button16 = menu8:AddSlider({
        icon = '⏲️',
        label = 'Longitud',
        value = '3600',
        values = {{
            label = '1 hora',
            value = '3600',
            description = 'Longitud del ban'
        }, {
            label = '6 horas',
            value ='21600',
            description = 'Longitud del ban'
        }, {
            label = '12 horas',
            value = '43200',
            description = 'Longitud del ban'
        }, {
            label = '1 dia',
            value = '86400',
            description = 'Longitud del ban'
        }, {
            label = '3 dias',
            value = '259200',
            description = 'Longitud del ban'
        }, {
            label = '1 semana',
            value = '604800',
            description = 'Longitud del ban'
        }, {
            label = '1 mes',
            value = '2678400',
            description = 'Longitud del ban'
        }, {
            label = '3 meses',
            value = '8035200',
            description = 'Longitud del ban'
        }, {
            label = '6 meses',
            value = '16070400',
            description = 'Longitud del ban'
        }, {
            label = '1 año',
            value = '32140800',
            description = 'Longitud del ban'
        }, {
            label = 'Permanente',
            value = '99999999999',
            description = 'Longitud del ban'
        }, {
            label = 'Modificado',
            value = "self",
            description = 'Longitud del ban'
        }},
        select = function(btn, newValue, oldValue)
            if newValue == "self" then
                banlength = LocalInputInt('Longitud del ban', 11, 'Segundos')
            else
                banlength = newValue
            end
        end
    })

    local menu_button17 = menu8:AddButton({
        icon = '',
        label = 'Confirmar',
        value = "ban",
        description = 'Confirmar el baneo',
        select = function(btn)
            if banreason ~= 'Unknown' and banlength ~= nil then
                TriggerServerEvent('qb-admin:server:ban', banspeler, banlength, banreason)
                banreason = 'Unknown'
                banlength = nil
            else
                QBCore.Functions.Notify('Debe dar una razón y establecer una longitud para el baneo.!', 'error')
            end
        end
    })
end

function OpenKickMenu(kickplayer)
    MenuV:OpenMenu(menu9)
    menu9:ClearItems()
    local menu_button19 = menu9:AddButton({
        icon = '',
        label = 'Razón',
        value = "reason",
        description = 'Razón del kickeo',
        select = function(btn)
            kickreason = LocalInput('Razón del kickeo', 255, 'Razón')
        end
    })

    local menu_button18 = menu9:AddButton({
        icon = '',
        label = 'Confirmar',
        value = "kick",
        description = 'Confirmar el kickeo',
        select = function(btn)
            if kickreason ~= 'Unknown' then
                TriggerServerEvent('qb-admin:server:kick', kickplayer, kickreason)
                kickreason = 'Unknown'
            else
                QBCore.Functions.Notify('Debes dar una razón!', 'error')
            end
        end
    })
end

function OpenPermsMenu(permsply)
    QBCore.Functions.TriggerCallback('qb-admin:server:getrank', function(rank)
        if rank then
            local selectedgroup = 'Unknown'
            MenuV:OpenMenu(menu10)
            menu10:ClearItems()
            local menu_button20 = menu10:AddSlider({
                icon = '',
                label = 'Grupo',
                value = 'user',
                values = {{
                    label = 'Usuario',
                    value = 'user',
                    description = 'Grupo'
                }, {
                    label = 'Admin',
                    value = 'admin',
                    description = 'Grupo'
                }, {
                    label = 'Dios',
                    value = 'god',
                    description = 'Grupo'
                }},
                select = function(btn)
                    local vcal = btn.Value
                    if vcal == 1 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "user", label = "Usuario"})
                    elseif vcal == 2 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "admin", label = "Admin"})
                    elseif vcal == 3 then
                        selectedgroup = {}
                        table.insert(selectedgroup, {rank = "god", label = "Dios"})
                    end
                end
            })

            local menu_button21 = menu10:AddButton({
                icon = '',
                label = 'Confirmar',
                value = "giveperms",
                description = 'Dar el grupo de permisos',
                select = function(btn)
                    if selectedgroup ~= 'Unknown' then
                        TriggerServerEvent('qb-admin:server:setPermissions', permsply.id, selectedgroup)
                        selectedgroup = 'Unknown'
                    else
                        QBCore.Functions.Notify('Elige un grupo!', 'error')
                    end
                end
            })
        else
            MenuV:CloseMenu(menu)
        end
    end)
end

-- Toggle NoClip

menu_button5:On('change', function(item, newValue, oldValue)
    ToggleNoClipMode()
end)

-- Revive Self

menu_button6:On('select', function(item)
    TriggerEvent('hospital:client:Revive', PlayerPedId())
end)

-- Invisible

local invisible = false
menu_button7:On('change', function(item, newValue, oldValue)
    if not invisible then
        invisible = true
        SetEntityVisible(PlayerPedId(), false, 0)
    else
        invisible = false
        SetEntityVisible(PlayerPedId(), true, 0)
    end
end)

-- Godmode

local godmode = false
menu_button8:On('change', function(item, newValue, oldValue)
    if not godmode then
        godmode = true
        SetPlayerInvincible(PlayerPedId(), true)
    else
        godmode = false
        SetPlayerInvincible(PlayerPedId(), false)
    end
end)

-- Delete Laser

local deleteLazer = false
menu_button9:On('change', function(item, newValue, oldValue)
    if not deleteLazer then
        deleteLazer = true
    else
        deleteLazer = false
    end
end)

function RotationToDirection(rotation)
	local adjustedRotation = 
	{ 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = 
	{
		x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)), 
		z = math.sin(adjustedRotation.x)
	}
	return direction
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
	local cameraCoord = GetGameplayCamCoord()
	local direction = RotationToDirection(cameraRotation)
	local destination = 
	{ 
		x = cameraCoord.x + direction.x * distance, 
		y = cameraCoord.y + direction.y * distance, 
		z = cameraCoord.z + direction.z * distance 
	}
	local a, b, c, d, e = GetShapeTestResult(StartShapeTestRay(cameraCoord.x, cameraCoord.y, cameraCoord.z, destination.x, destination.y, destination.z, -1, PlayerPedId(), 0))
	return b, c, e
end

function DrawEntityBoundingBox(entity, color)
    local model = GetEntityModel(entity)
    local min, max = GetModelDimensions(model)
    local rightVector, forwardVector, upVector, position = GetEntityMatrix(entity)

    -- Calculate size
    local dim = 
	{ 
		x = 0.5*(max.x - min.x), 
		y = 0.5*(max.y - min.y), 
		z = 0.5*(max.z - min.z)
	}

    local FUR = 
    {
		x = position.x + dim.y*rightVector.x + dim.x*forwardVector.x + dim.z*upVector.x, 
		y = position.y + dim.y*rightVector.y + dim.x*forwardVector.y + dim.z*upVector.y, 
		z = 0
    }

    local FUR_bool, FUR_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    FUR.z = FUR_z
    FUR.z = FUR.z + 2 * dim.z

    local BLL = 
    {
        x = position.x - dim.y*rightVector.x - dim.x*forwardVector.x - dim.z*upVector.x,
        y = position.y - dim.y*rightVector.y - dim.x*forwardVector.y - dim.z*upVector.y,
        z = 0
    }
    local BLL_bool, BLL_z = GetGroundZFor_3dCoord(FUR.x, FUR.y, 1000.0, 0)
    BLL.z = BLL_z

    -- DEBUG
    local edge1 = BLL
    local edge5 = FUR

    local edge2 = 
    {
        x = edge1.x + 2 * dim.y*rightVector.x,
        y = edge1.y + 2 * dim.y*rightVector.y,
        z = edge1.z + 2 * dim.y*rightVector.z
    }

    local edge3 = 
    {
        x = edge2.x + 2 * dim.z*upVector.x,
        y = edge2.y + 2 * dim.z*upVector.y,
        z = edge2.z + 2 * dim.z*upVector.z
    }

    local edge4 = 
    {
        x = edge1.x + 2 * dim.z*upVector.x,
        y = edge1.y + 2 * dim.z*upVector.y,
        z = edge1.z + 2 * dim.z*upVector.z
    }

    local edge6 = 
    {
        x = edge5.x - 2 * dim.y*rightVector.x,
        y = edge5.y - 2 * dim.y*rightVector.y,
        z = edge5.z - 2 * dim.y*rightVector.z
    }

    local edge7 = 
    {
        x = edge6.x - 2 * dim.z*upVector.x,
        y = edge6.y - 2 * dim.z*upVector.y,
        z = edge6.z - 2 * dim.z*upVector.z
    }

    local edge8 = 
    {
        x = edge5.x - 2 * dim.z*upVector.x,
        y = edge5.y - 2 * dim.z*upVector.y,
        z = edge5.z - 2 * dim.z*upVector.z
    }

    DrawLine(edge1.x, edge1.y, edge1.z, edge2.x, edge2.y, edge2.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge3.x, edge3.y, edge3.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge4.x, edge4.y, edge4.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
    DrawLine(edge5.x, edge5.y, edge5.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge6.x, edge6.y, edge6.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge7.x, edge7.y, edge7.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge1.x, edge1.y, edge1.z, edge7.x, edge7.y, edge7.z, color.r, color.g, color.b, color.a)
    DrawLine(edge2.x, edge2.y, edge2.z, edge8.x, edge8.y, edge8.z, color.r, color.g, color.b, color.a)
    DrawLine(edge3.x, edge3.y, edge3.z, edge5.x, edge5.y, edge5.z, color.r, color.g, color.b, color.a)
    DrawLine(edge4.x, edge4.y, edge4.z, edge6.x, edge6.y, edge6.z, color.r, color.g, color.b, color.a)
end

Citizen.CreateThread(function()	
	while true do
		Citizen.Wait(0)
        if deleteLazer then
            local color = {r = 255, g = 255, b = 255, a = 200}
            local position = GetEntityCoords(PlayerPedId())
            local hit, coords, entity = RayCastGamePlayCamera(1000.0)
            -- If entity is found then verifie entity
            if hit and (IsEntityAVehicle(entity) or IsEntityAPed(entity) or IsEntityAnObject(entity)) then
                local entityCoord = GetEntityCoords(entity)
                local minimum, maximum = GetModelDimensions(GetEntityModel(entity))
                DrawEntityBoundingBox(entity, color)
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                QBCore.Functions.DrawText3D(entityCoord.x, entityCoord.y, entityCoord.z, "Obj: " .. entity .. " Model: " .. GetEntityModel(entity).. " \nPresiona [~g~E~s~] para borrar el objeto!", 2)
                -- When E pressed then remove targeted entity
                if IsControlJustReleased(0, 38) then
                    -- Set as missionEntity so the object can be remove (Even map objects)
                    SetEntityAsMissionEntity(entity, true, true)
                    --SetEntityAsNoLongerNeeded(entity)
                    --RequestNetworkControl(entity)
                    DeleteEntity(entity)
                end
            -- Only draw of not center of map
            elseif coords.x ~= 0.0 and coords.y ~= 0.0 then
                -- Draws line to targeted position
                DrawLine(position.x, position.y, position.z, coords.x, coords.y, coords.z, color.r, color.g, color.b, color.a)
                DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 0.1, 0.1, 0.1, color.r, color.g, color.b, color.a, false, true, 2, nil, nil, false)
            end
        else
            Citizen.Wait(1000)
        end
	end
end)
