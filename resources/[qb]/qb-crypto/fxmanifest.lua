fx_version 'cerulean'
game 'gta5'

description 'QB-CORE Crypto TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'

version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

server_script 'server/main.lua'
client_script 'client/main.lua'

dependency 'mhacking'