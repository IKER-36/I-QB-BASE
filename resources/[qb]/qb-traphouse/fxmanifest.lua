fx_version 'cerulean'
game 'gta5'

description 'QB-CORE Traphouse TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'

version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

server_exports {
    'AddHouseItem',
    'RemoveHouseItem',
    'GetInventoryData',
    'CanItemBeSaled'
}

files {
    'html/*'
}