fx_version 'cerulean'
game 'gta5'

description 'QB-Justice traduced to es by Raz#5398'
version '1.0.0'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

exports {
	'GetVehicleStatusList',
	'GetVehicleStatus',
	'SetVehicleStatus'
}
