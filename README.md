# AR's World | Discord Handler

Discord Handler script made for FiveM server which uses alot of Discord API Integration.
This script will save all data if user has access to a specific role in the configurable Discord server.

## Depedencies

These script will be needed if you want to use this script.
- [discordroles](https://github.com/logan-mcgee/discordroles)

## Usage

Receive the discordId of the given player.
```lua
local discordId = exports['discord-handler']:checkRoles(source)
```

Receive all roles of the player in a table.
```lua
local discordRoles = exports['discord-handler']:getDiscordId(source)
```

## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
