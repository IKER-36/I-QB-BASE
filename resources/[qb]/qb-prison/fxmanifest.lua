fx_version 'cerulean'
game 'gta5'

description 'QB-CORE Prison TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
	'client/main.lua',
	'client/jobs.lua',
	'client/prisonbreak.lua'
}

server_script 'server/main.lua'