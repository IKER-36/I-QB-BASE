fx_version 'bodacious'
games { 'rdr3', 'gta5' }
version '1.0.0'

client_script { 
    'cl_locate.lua'
}

server_script {
    'se_locate.lua'
}

ui_page('interface/index.html')

files {
    'interface/index.html',
   'interface/style.css',
   'interface/script.js'
}