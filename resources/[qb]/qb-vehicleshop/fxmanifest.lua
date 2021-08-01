fx_version 'cerulean'
game 'gta5'

description 'QB-VehicleShop TRANSLATED BY Raz#5398 FOR THE QB-BASE PROYECT'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts { 
	'@qb-core/import.lua',
	'config.lua'
}

client_scripts {
    'client/main.lua',
    'client/showroom.lua',
    'client/customshowroom.lua',
}

server_script 'server/main.lua'

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/script.js',
    'html/img/*.png',
    'html/img/site-bg.jpg',
}