# Array's Development | Discord Handler

Discord Handler script made for FiveM server which uses alot of Discord API Integration.
This script will save all data if user has access to a specific role in the configurable Discord server.

## Depedencies

These script will be needed if you want to use this script.
- [discordroles](https://github.com/logan-mcgee/discordroles)
- [es_extended](https://github.com/esx-framework/esx_core)

## Usage

Receive the discordId of the given player.
```lua
local discordId = exports['discord-handler']:getDiscordId(source)
```

Receive the Discord username and Discord profilepicture in a double variable.
```lua
local discordUsername, discordProfilePicture = exports['discord-handler']:getPlayerDiscordData(source)
```

Receive all roles of the player in a table.
```lua
local discordRoles = exports['discord-handler']:checkRoles(source)
```

Receive a specific role of the player in a boolean.
```lua
local discordRoles = exports['discord-handler']:checkSpecificRole(source)
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
