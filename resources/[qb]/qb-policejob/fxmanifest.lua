fx_version 'cerulean'
game 'gta5'

description 'QB-CORE PoliceJob TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'

version '1.0.0'

shared_script { 
	'config.lua',
	'@qb-core/import.lua'
}

client_scripts {
	'client/main.lua',
	'client/camera.lua',
	'client/interactions.lua',
	'client/job.lua',
	'client/gui.lua',
	'client/heli.lua',
	--'client/anpr.lua',
	'client/evidence.lua',
	'client/objects.lua',
	'client/tracker.lua'
}

server_script 'server/main.lua'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/vue.min.js',
	'html/script.js',
	'html/tablet-frame.png',
	'html/fingerprint.png',
	'html/main.css',
	'html/vcr-ocd.ttf'
}

exports {
	'IsHandcuffed',
	'IsArmoryWhitelist'
}

-- dependency 'qb-core'
