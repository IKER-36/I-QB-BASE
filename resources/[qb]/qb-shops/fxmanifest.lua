fx_version 'cerulean'
game 'gta5'

descriptions 'QB-CORE Shops TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

dependencies {
	'qb-inventory'
}