fx_version 'cerulean'
game 'gta5'

description 'QB-CORE Diving TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

server_scripts {
	'server/main.lua',
    'server/diving.lua'
}

client_scripts {
    'client/main.lua',
    'client/boatshop.lua',
    'client/diving.lua',
    'client/garage.lua',
    'client/gui.lua',
    'client/shop.lua'
}