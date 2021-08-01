fx_version 'cerulean'
game 'gta5'

description 'QB-Pawnshop TRANSLATED BY (Raz#5398) COLABORATING IN I-QB PROJECT'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

server_script 'server/main.lua'

client_scripts {
	'client/main.lua',
	'client/melt.lua'
}