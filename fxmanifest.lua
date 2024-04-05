fx_version 'cerulean'
game 'gta5'
lua54 'yes'
author 'Bob\'s Mods'
description 'Auto locks nearest configured doors when event is triggered'
version '0.02'


client_scripts {
  'client/client.lua'
}

server_script {
  'server/server.lua'
}

shared_scripts {
  'shared/config.lua',
  'shared/utils.lua'
}
