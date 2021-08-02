version '1.0.0'
author 'Cfx.re <root@cfx.re>'
description 'Provides baseline chat functionality using a NUI-based interface.'
repository 'https://github.com/citizenfx/cfx-server-data'

ui_page 'html/index.html'

client_script 'cl_chat.lua'
server_script 'sv_chat.lua'


files {
    'html/index.html',
    'html/css/style.css',
    'html/js/config.default.js',
    'html/js/App.js',
    'html/js/Message.js',
    'html/js/Suggestions.js',
    'html/vendor/vue.2.3.3.min.js',
    'html/vendor/flexboxgrid.6.3.1.min.css',
    'html/vendor/animate.3.5.2.min.css',
    'html/vendor/latofonts.css',
    'html/vendor/fonts/LatoRegular.woff2',
    'html/vendor/fonts/LatoRegular2.woff2',
    'html/vendor/fonts/LatoLight2.woff2',
    'html/vendor/fonts/LatoLight.woff2',
    'html/vendor/fonts/LatoBold.woff2',
    'html/vendor/fonts/LatoBold2.woff2',
    'html/idcard.png',
    'html/image/CID.png',
    'html/image/F.png',
    'html/image/M.png',
  }

fx_version 'adamant'
games { 'rdr3', 'gta5' }

dependencies {
  'yarn',
  'webpack'
}