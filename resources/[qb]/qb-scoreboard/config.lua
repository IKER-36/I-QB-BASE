Config = Config or {}

-- Open scoreboard key
Config.OpenKey = 213

-- Max Server Players
Config.MaxPlayers = GetConvarInt('sv_maxclients', 256) -- It returnes 64 if it cant find the Convar Int

-- Minimum Police for Actions
Config.IllegalActions = {
    ["storerobbery"] = {
        minimum = 2,
        busy = false,
    },
    ["bankrobbery"] = {
        minimum = 3,
        busy = false,
    },
    ["jewellery"] = {
        minimum = 3,
        busy = false,
    },
    ["pacific"] = {
        minimum = 5,
        busy = false,
    },
}

-- Current Cops Online
Config.CurrentCops = 0

-- Current Ambulance / Doctors Online
Config.CurrentAmbulance = 0