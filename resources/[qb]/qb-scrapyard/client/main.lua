local closestScrapyard = 0
local emailSend = false
local isBusy = false

RegisterNetEvent("QBCore:Client:OnPlayerLoaded")
AddEventHandler("QBCore:Client:OnPlayerLoaded", function()
    TriggerServerEvent("qb-scrapyard:server:LoadVehicleList")
end)

Citizen.CreateThread(function()
	for id, scrapyard in pairs(Config.Locations) do
		local blip = AddBlipForCoord(Config.Locations[id]["main"].x, Config.Locations[id]["main"].y, Config.Locations[id]["main"].z)
        SetBlipSprite(blip, 380)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.7)
        SetBlipAsShortRange(blip, true)
        SetBlipColour(blip, 9)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Depósito de chatarra")
        EndTextCommandSetBlipName(blip)
	end
    Citizen.Wait(1000)
    while true do
        SetClosestScrapyard()
        Citizen.Wait(10000)
    end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)
		local sleep = true
		if closestScrapyard ~= 0 then
			local pos = GetEntityCoords(PlayerPedId())
			if #(pos - vector3(Config.Locations[closestScrapyard]["deliver"].x, Config.Locations[closestScrapyard]["deliver"].y, Config.Locations[closestScrapyard]["deliver"].z)) < 10.0 then
				sleep = false
				if IsPedInAnyVehicle(PlayerPedId()) then
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
					if vehicle ~= 0 and vehicle ~= nil then 
						local vehpos = GetEntityCoords(vehicle)
						if #(pos - vector3(vehpos.x, vehpos.y, vehpos.z)) < 2.5 and not isBusy then
							DrawText3Ds(vehpos.x, vehpos.y, vehpos.z, "~g~E~w~ - Desmontar vehículo")
							if IsControlJustReleased(0, 38) then
								if GetPedInVehicleSeat(vehicle, -1) == PlayerPedId() then
									if IsVehicleValid(GetEntityModel(vehicle)) then 
										ScrapVehicle(vehicle)
									else
										QBCore.Functions.Notify("Este vehículo no puede ser desguazado.", "error")
									end
								else
									QBCore.Functions.Notify("No eres el conductor", "error")
								end
							end
						end
					end
				end
			end
			if #(pos - vector3(Config.Locations[closestScrapyard]["list"].x, Config.Locations[closestScrapyard]["list"].y, Config.Locations[closestScrapyard]["list"].z)) < 1.5 then
				sleep = false
				if not IsPedInAnyVehicle(PlayerPedId()) and not emailSend then
					DrawText3Ds(Config.Locations[closestScrapyard]["list"].x, Config.Locations[closestScrapyard]["list"].y, Config.Locations[closestScrapyard]["list"].z, "~g~E~w~ - Lista de vehículos por correo electrónico")
					if IsControlJustReleased(0, 38) then
						CreateListEmail()
					end
				end
			end
		end
		if sleep then Citizen.Wait(222) end
	end
end)

RegisterNetEvent('qb-scapyard:client:setNewVehicles')
AddEventHandler('qb-scapyard:client:setNewVehicles', function(vehicleList)
	Config.CurrentVehicles = vehicleList
end)

function CreateListEmail()
	if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then 
		emailSend = true
		local vehicleList = ""
		for k, v in pairs(Config.CurrentVehicles) do
			if Config.CurrentVehicles[k] ~= nil then 
				local vehicleInfo = QBCore.Shared.Vehicles[v]
				if vehicleInfo ~= nil then 
					vehicleList = vehicleList  .. vehicleInfo["brand"] .. " " .. vehicleInfo["name"] .. "<br />"
				end
			end
		end
		SetTimeout(math.random(15000, 20000), function()
			emailSend = false
			TriggerServerEvent('qb-phone:server:sendNewMail', {
				sender = "Destrucción automática de Turner",
				subject = "Lista de Vehiculos",
				message = "Solo puedes descuartizar varios vehículos.<br />Puedes quedarte con todo lo que descuartizes mientras no me molestes.<br /><br /><strong>Lista de Vehiculos:</strong><br />".. vehicleList,
				button = {}
			})
		end)
	else
		QBCore.Functions.Notify("No está permitido descuartizar vehículos ahora", "error")
	end
end

function ScrapVehicle(vehicle)
	isBusy = true
	local scrapTime = math.random(28000, 37000)
	ScrapVehicleAnim(scrapTime)
	QBCore.Functions.Progressbar("scrap_vehicle", "Desguazando el vehículo....", scrapTime, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
		TriggerServerEvent("qb-scrapyard:server:ScrapVehicle", GetVehicleKey(GetEntityModel(vehicle)))
		SetEntityAsMissionEntity(vehicle, true, true)
		DeleteVehicle(vehicle)
		isBusy = false
	end, function() -- Cancel
		StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
		isBusy = false
		QBCore.Functions.Notify("Cancelado", "error")
	end)
end

function IsVehicleValid(vehicleModel)
	local retval = false
	if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then 
		for k, v in pairs(Config.CurrentVehicles) do
			if Config.CurrentVehicles[k] ~= nil and GetHashKey(Config.CurrentVehicles[k]) == vehicleModel then 
				retval = true
			end
		end
	end
	return retval
end

function GetVehicleKey(vehicleModel)
	local retval = 0
	if Config.CurrentVehicles ~= nil and next(Config.CurrentVehicles) ~= nil then 
		for k, v in pairs(Config.CurrentVehicles) do
			if GetHashKey(Config.CurrentVehicles[k]) == vehicleModel then 
				retval = k
			end
		end
	end
	return retval
end

function SetClosestScrapyard()
	local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
	for id, scrapyard in pairs(Config.Locations) do
		if current ~= nil then
			if #(pos - vector3(Config.Locations[id]["main"].x, Config.Locations[id]["main"].y, Config.Locations[id]["main"].z)) < dist then
				current = id
				dist = #(pos - vector3(Config.Locations[id]["main"].x, Config.Locations[id]["main"].y, Config.Locations[id]["main"].z))
			end
		else
			dist = #(pos - vector3(Config.Locations[id]["main"].x, Config.Locations[id]["main"].y, Config.Locations[id]["main"].z))
			current = id
		end
	end
	closestScrapyard = current
end

function ScrapVehicleAnim(time)
    time = (time / 1000)
    loadAnimDict("mp_car_bomb")
    TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic" ,3.0, 3.0, -1, 16, 0, false, false, false)
    openingDoor = true
    Citizen.CreateThread(function()
        while openingDoor do
            TaskPlayAnim(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 3.0, 3.0, -1, 16, 0, 0, 0, 0)
            Citizen.Wait(2000)
			time = time - 2
            if time <= 0 then
                openingDoor = false
                StopAnimTask(PlayerPedId(), "mp_car_bomb", "car_bomb_mechanic", 1.0)
            end
        end
    end)
end

function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(5)
    end
end

function DrawText3Ds(x, y, z, text)
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

