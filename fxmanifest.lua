fx_version 'adamant'

game 'gta5'

ui_page 'html/index.html'

files {
	'html/*.html',
  	'html/css/*.css',
	'html/js/*.js',
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

server_scripts {
	'config.lua',
	'server/main.lua'
}
