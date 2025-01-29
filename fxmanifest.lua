fx_version 'cerulean'

game 'gta5'

version "1.0.5"

lua54 'yes'

dependencies {
	'ox_lib'
}

ui_page 'html/index.html'

shared_scripts {
	'@ox_lib/init.lua',
	'config.lua',
	'utils/*.lua',
	'locales/*.lua'
}

client_scripts {
	'client/custom/**/**.lua',
	'client/*.lua'
}

server_scripts {
	'server/custom/**/**.lua',
	'server/*.lua'
}

files {
	'html/**/**/**'
}

escrow_ignore {
	'config.lua',
	'locales/*.lua',
	'client/custom/**/**.lua',
	'server/custom/**/**.lua',
}


dependency '/assetpacks'