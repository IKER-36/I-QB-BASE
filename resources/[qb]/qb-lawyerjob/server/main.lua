QBCore.Commands.Add("setlawyer", "Registrar a alguien como abogado", {{name="id", help="Id of the player"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "judge" then
        if OtherPlayer ~= nil then 
            local lawyerInfo = {
                id = math.random(100000, 999999),
                firstname = OtherPlayer.PlayerData.charinfo.firstname,
                lastname = OtherPlayer.PlayerData.charinfo.lastname,
                citizenid = OtherPlayer.PlayerData.citizenid,
            }
            OtherPlayer.Functions.SetJob("lawyer", 0)
            OtherPlayer.Functions.AddItem("lawyerpass", 1, false, lawyerInfo)
            TriggerClientEvent("QBCore:Notify", source, "Tu tienes " .. OtherPlayer.PlayerData.charinfo.firstname .. " " .. OtherPlayer.PlayerData.charinfo.lastname .. " Contratado como abogado")
            TriggerClientEvent("QBCore:Notify", OtherPlayer.PlayerData.source, "Ahora eres abogado")
            TriggerClientEvent('inventory:client:ItemBox', OtherPlayer.PlayerData.source, QBCore.Shared.Items["lawyerpass"], "add")
        else
            TriggerClientEvent("QBCore:Notify", source, "La persona está presente", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No eres un juzgado.", "error")
    end
end)

QBCore.Commands.Add("removelawyer", "Quitar a alguien como abogado", {{name="id", help="ID of the player"}}, true, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local playerId = tonumber(args[1])
    local OtherPlayer = QBCore.Functions.GetPlayer(playerId)
    if Player.PlayerData.job.name == "judge" then
        if OtherPlayer ~= nil then
	    OtherPlayer.Functions.SetJob("unemployed", 0)
            TriggerClientEvent("QBCore:Notify", OtherPlayer.PlayerData.source, "Ahora estas sin trabajo")
            TriggerClientEvent("QBCore:Notify", source, "Tú tienes " .. OtherPlayer.PlayerData.charinfo.firstname .. " " .. OtherPlayer.PlayerData.charinfo.lastname .. "Despedir como abogado")
        else
            TriggerClientEvent("QBCore:Notify", source, "La persona no está presente", "error")
        end
    else
        TriggerClientEvent("QBCore:Notify", source, "No eres un juez ...", "error")
    end
end)

QBCore.Functions.CreateUseableItem("lawyerpass", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent("qb-justice:client:showLawyerLicense", -1, source, item.info)
    end
end)
