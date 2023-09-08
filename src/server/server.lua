-- // [VARIABLES] \\ --

local hasRoles = {}
local tmpData = {}

-- // [JOINING] \\ --

AddEventHandler('esx:playerLoaded', function(src, PlayerData)
    if source == 0 or source == '' then
        for i=1, #Shared.ReceiveRoles do 
            exports[Shared.Options['Discord Integration']]:isRolePresent(getDiscordId(src), { Shared.ReceiveRoles[i]['roleId'] }, function(hasRole, roles)
                if not hasRoles[src] then 
                    hasRoles[src] = {}
                end

                hasRoles[src][Shared.ReceiveRoles[i]['label']] = {
                    status = hasRole
                }
            end)
        end
    end
end)

-- // [LEAVING] \\ --

RegisterNetEvent('esx:playerDropped')
AddEventHandler('esx:playerDropped', function(src, reason, PlayerData)
    if source == 0 or source == '' then
        for k,v in pairs(hasRoles[src]) do 
            hasRoles[src][k] = nil
        end
    end
end)

-- // [EXPORTS] \\ --

exports('checkRoles', function(src)
    tmpData[src] = {}
    for i=1, #Shared.ReceiveRoles do 
        tmpData[src][Shared.ReceiveRoles[i]['label']] = {
            status = false
        }
    end
    for k,v in pairs(hasRoles) do 
        tmpData[src][k]['status'] = hasRoles[src][k]['status']
    end
    return tmpData[src]
end)

exports('checkSpecificRole', function(src, role)
    return hasRoles[src][role]['status']
end)

exports('getDiscordId', function(src)
    local identifiers = GetPlayerIdentifiers(src)
    for i=1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return nil
end)

exports('getPlayerDiscordData', function(src)
    local discordId = getDiscordId(src)
    if not discordId then return end

    local p = promise.new()
    PerformHttpRequest(('https://discordapp.com/api/users/%s'):format(discordId), function(err, result, headers)
        p:resolve({data=result, code=err, headers = headers})
    end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = 'Bot ' .. Shared.Options['Bot Token']})
    local result = Citizen.Await(p)
    if not result then return end
    if result.code ~= 200 then return print('Error: Something went wrong with error code - ' .. result.code) end

    local data = json.decode(result.data)
    if data and data.avatar and data.username then 
        return data.username, ('https://cdn.discordapp.com/avatars/%s/%s'):format(discordId, data.avatar)
    end
end)

-- // [FUNCTIONS] \\ --

checkRoles = function(src)
    tmpData[src] = {}
    for i=1, #Shared.ReceiveRoles do 
        tmpData[src][Shared.ReceiveRoles[i]['label']] = {
            status = false
        }
    end
    for k,v in pairs(hasRoles) do 
        tmpData[src][k]['status'] = hasRoles[k][src]['status']
    end
    return tmpData[src]
end

checkSpecificRole = function(src, role)
    return hasRoles[src][role]['status']
end

getDiscordId = function(src)
    local identifiers = GetPlayerIdentifiers(src)
    for i=1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return nil
end

getPlayerDiscordData = function(src)
    local discordId = getDiscordId(src)
    if not discordId then return end

    local p = promise.new()
    PerformHttpRequest(('https://discordapp.com/api/users/%s'):format(discordId), function(err, result, headers)
        p:resolve({data=result, code=err, headers = headers})
    end, "GET", "", {["Content-Type"] = "application/json", ["Authorization"] = 'Bot ' .. Shared.Options['Bot Token']})
    local result = Citizen.Await(p)
    if not result then return end
    if result.code ~= 200 then return print('Error: Something went wrong with error code - ' .. result.code) end

    local data = json.decode(result.data)
    if data and data.avatar and data.username then 
        return data.username, ('https://cdn.discordapp.com/avatars/%s/%s'):format(discordId, data.avatar)
    end
end