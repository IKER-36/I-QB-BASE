fx_version 'cerulean'
game 'gta5'

description 'QB-CORE BANKROBBERY TRANSLATED BY CherryozZ#0420 COLABORATING IN I-QB PROJECT'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    'client/fleeca.lua',
    'client/pacific.lua',
    'client/powerstation.lua',
    'client/doors.lua',
    'client/paleto.lua',
}

server_script 'server/main.lua'

files {
    'html/*',
}
