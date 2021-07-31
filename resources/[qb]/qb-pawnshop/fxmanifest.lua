fx_version 'cerulean'
game 'gta5'

description 'QB-Pawnshop traduced to es by Raz#5398'
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