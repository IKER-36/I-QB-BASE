QBCore.Commands.Add("binds", "Abrir menú de bindeo de comandos", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent("qb-commandbinding:client:openUI", source)
end)

RegisterServerEvent('qb-commandbinding:server:setKeyMeta')
AddEventHandler('qb-commandbinding:server:setKeyMeta', function(keyMeta)
    local src = source
    local ply = QBCore.Functions.GetPlayer(src)

    ply.Functions.SetMetaData("commandbinds", keyMeta)
end)