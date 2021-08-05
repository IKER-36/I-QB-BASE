QBCore.Commands = {}
QBCore.Commands.List = {}

QBCore.Commands.Add = function(name, help, arguments, argsrequired, callback, permission) -- [name] = command name (ex. /givemoney), [help] = help text, [arguments] = arguments that need to be passed (ex. {{name="id", help="ID of a player"}, {name="cantidad", help="cantidad of money"}}), [argsrequired] = set arguments required (true or false), [callback] = function(source, args) callback, [permission] = rank or job of a player
	QBCore.Commands.List[name:lower()] = {
		name = name:lower(),
		permission = permission ~= nil and permission:lower() or "user",
		help = help,
		arguments = arguments,
		argsrequired = argsrequired,
		callback = callback,
	}
end

QBCore.Commands.Refresh = function(source)
	local Player = QBCore.Functions.GetPlayer(tonumber(source))
	if Player ~= nil then
		for command, info in pairs(QBCore.Commands.List) do
			if QBCore.Functions.HasPermission(source, "god") or QBCore.Functions.HasPermission(source, QBCore.Commands.List[command].permission) then
				TriggerClientEvent('chat:addSuggestion', source, "/"..command, info.help, info.arguments)
			end
		end
	end
end

QBCore.Commands.Add("tp", "Hacer tp a jugador o coordenadas (Solo Administrador)", {{name="id/x", help="ID del jugador o coordenadas"}, {name="y", help="Y posicion"}, {name="z", help="Z posicion"}}, false, function(source, args)
	if (args[1] ~= nil and (args[2] == nil and args[3] == nil)) then
		local player = GetPlayerPed(source)
		local target = GetPlayerPed(tonumber(args[1]))
		if target ~= 0 then
			local coords = GetEntityCoords(target)
			TriggerClientEvent('QBCore:Command:TeleportToPlayer', source, coords)
		else
			TriggerClientEvent('QBCore:Notify', source, "Jugador no encontrado", "Error")
		end
	else
		if args[1] ~= nil and args[2] ~= nil and args[3] ~= nil then
			local player = GetPlayerPed(source)
			local x = tonumber(args[1])
			local y = tonumber(args[2])
			local z = tonumber(args[3])
			if (x ~= 0) and (y ~= 0) and (z ~= 0) then
				TriggerClientEvent('QBCore:Command:TeleportToCoords', source, x, y, z)
			else
				TriggerClientEvent('QBCore:Notify', source, "Formato Erroneo", "Error")
			end
		else
			TriggerClientEvent('QBCore:Notify', source, "No se han introducido todos los argumentos (x, y, z)", "Error")
		end
	end
end, "admin")

QBCore.Commands.Add("añadirpermisos", "Dar permisos de jugador (Solo Administradores)", {{name="id", help="ID of player"}, {name="permission", help="Permission level"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	local permission = tostring(args[2]):lower()
	if Player ~= nil then
		QBCore.Functions.AddPermission(Player.PlayerData.source, permission)
	else
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")	
	end
end, "god")

QBCore.Commands.Add("quitarpermisos", "Remove Players Permissions (God Only)", {{name="id", help="ID of player"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		QBCore.Functions.RemovePermission(Player.PlayerData.source)
	else
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")	
	end
end, "god")

QBCore.Commands.Add("car", "Spawnear vehiculo (Solo Administradores)", {{name="model", help="Modelo vehiculo (t20,zentorno....)"}}, true, function(source, args)
	TriggerClientEvent('QBCore:Command:SpawnVehicle', source, args[1])
end, "admin")

QBCore.Commands.Add("debug", "Activar modo Debug (Solo Administradores)", {}, false, function(source, args)
	TriggerClientEvent('koil-debug:toggle', source)
end, "admin")

QBCore.Commands.Add("dv", "Borrar vehiculo (Solo Administradores)", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:DeleteVehicle', source)
end, "admin")

QBCore.Commands.Add("tpm", "TP a un marcador (Solo Administradores)", {}, false, function(source, args)
	TriggerClientEvent('QBCore:Command:GoToMarker', source)
end, "admin")

QBCore.Commands.Add("givemoney", "Dar dinero a un jugador (Solo Administradores)", {{name="id", help="ID Jugador"},{name="tipo", help="Tipo de dinero (cash, bank, crypto)"}, {name="cantidad", help="Cantidad de dinero"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.AddMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")
	end
end, "admin")

QBCore.Commands.Add("setmoney", "Establecer cantidad de dinero al jugador (Solo Administradores)", {{name="id", help="ID Jugador"},{name="tipo", help="Tipo de dinero (cash, bank, crypto)"}, {name="cantidad", help="Cantidad de dinero"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetMoney(tostring(args[2]), tonumber(args[3]))
	else
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")
	end
end, "admin")

QBCore.Commands.Add("setjob", "Set A Players Job (Solo Administradores)", {{name="id", help="ID Jugador"}, {name="job", help="Job name"}, {name="grade", help="Grade"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if (args[1] == nil) or (args[2] == nil) or (args[3] == nil) then
		TriggerClientEvent('QBCore:Notify', source, "Todos los argumentos deben ser rellenados", "Error")
	elseif Player == nil then
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")
	else
		Player.Functions.SetJob(tostring(args[2]), tonumber(args[3]))
	end
end, "admin")


QBCore.Commands.Add("trabajo", "Chomprueba tu trabajo actual", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)
	TriggerClientEvent('QBCore:Notify', source, "Trabajo: "..Player.PlayerData.job.label.. " Grado: "..Player.PlayerData.job.grade.name)
end)

QBCore.Commands.Add("setgang", "Establecer una mafia / banda a un jugador (Solo Administradores)", {{name="id", help="ID Jugador"}, {name="banda", help="Nombre de la banda"}}, true, function(source, args)
	local Player = QBCore.Functions.GetPlayer(tonumber(args[1]))
	if Player ~= nil then
		Player.Functions.SetGang(tostring(args[2]))
	else
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")
	end
end, "admin")

QBCore.Commands.Add("banda", "Checkea tu banda", {}, false, function(source, args)
	local Player = QBCore.Functions.GetPlayer(source)

	if Player.PlayerData.gang.name ~= "none" then
		TriggerClientEvent('QBCore:Notify', source, "Banda: "..Player.PlayerData.gang.label)
	else
		TriggerClientEvent('QBCore:Notify', source, "No estas en ninguna mafia / banda", "Error")
	end
end)

QBCore.Commands.Add("vaciarinv", "Vaciar Inventario de jugadores (Solo Administradores)", {{name="id", help="ID Jugador"}}, false, function(source, args)
	local playerId = args[1] ~= nil and args[1] or source 
	local Player = QBCore.Functions.GetPlayer(tonumber(playerId))
	if Player ~= nil then
		Player.Functions.ClearInventory()
	else
		TriggerClientEvent('QBCore:Notify', source, "El Jugador no esta en el servidor", "Error")
	end
end, "admin")

QBCore.Commands.Add("ooc", "Mensaje OOC (fuera de rol)", {}, false, function(source, args)
	local message = table.concat(args, " ")
	TriggerClientEvent("QBCore:Client:LocalOutOfCharacter", -1, source, GetPlayerName(source), message)
	local Players = QBCore.Functions.GetPlayers()
	local Player = QBCore.Functions.GetPlayer(source)

	for k, v in pairs(QBCore.Functions.GetPlayers()) do
		if QBCore.Functions.HasPermission(v, "admin") then
			if QBCore.Functions.IsOptin(v) then
				TriggerClientEvent('chatMessage', v, "OOC " .. GetPlayerName(source), "normal", message)
				TriggerEvent("qb-log:server:CreateLog", "ooc", "OOC", "white", "**"..GetPlayerName(source).."** (CitizenID: "..Player.PlayerData.citizenid.." | ID: "..source..") **Mensaje:** " ..message, false)
			end
		end
	end
end)
