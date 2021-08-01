fx_version 'cerulean'
game 'gta5'

description 'QB-CORE Logs TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'
version '1.0.0'

ui_page 'html/index.html'

shared_script '@qb-core/import.lua'

server_scripts {
    'server/server.lua',
    'config.lua'
}

client_scripts {
    'client/client.lua'
}

files {
    'html/index.html',
    'html/script.js'
}