fx_version "adamant"
game "gta5"
use_fxv2_oal "yes"
lua54 "yes"

name "aw-discordhandler"
author "AR's World | Array"
version "1.1.0"
description "Discord Handler script made for FiveM server which uses alot of Discord API Integration"

shared_scripts { '@es_extended/imports.lua' }
server_scripts { '@oxmysql/lib/MySQL.lua', 'shared/*.lua', 'src/server/*.lua' }
dependencies { 'discordroles', 'es_extended' }