fx_version 'cerulean'
game 'gta5'

description 'QB-CORE Scoreboard TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'
version '1.0.0'

ui_page 'html/ui.html'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_script 'client.lua'
server_script 'server.lua'

files {
    'html/*'
}