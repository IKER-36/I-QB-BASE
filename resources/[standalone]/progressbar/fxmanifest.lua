fx_version 'cerulean'
game 'gta5'

description 'QB-CORE progressbar TRANSLATED BY (Broncas#3949) COLABORATING IN I-QB PROJECT'

version '1.0.0'

ui_page('html/index.html') 

client_scripts {
    'client/main.lua',
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',

    'html/css/bootstrap.min.css',
    'html/js/jquery.min.js',
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}