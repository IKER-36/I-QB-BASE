fx_version 'cerulean'
game 'gta5'

author 'QB-CORE CUSTOMS TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/css/menu.css',
    'html/js/ui.js',
    'html/imgs/logo.png',
    'html/sounds/wrench.ogg',
    'html/sounds/respray.ogg'
}

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    'client/cl_ui.lua',
    'client/cl_bennys.lua'
}

server_script 'server/sv_bennys.lua'