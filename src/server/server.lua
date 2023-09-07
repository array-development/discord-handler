-- // [VARIABLES] \\ --

local hasRoles = {}
local tmpData = {}

-- // [JOINING] \\ --

AddEventHandler('esx:playerLoaded', function(src, PlayerData)
    if source == 0 or source == '' then
        for i=1, #Shared.ReceiveRoles do 
            exports[Shared.Options['Discord Integration']]:isRolePresent(getDiscordId(src), { Shared.ReceiveRoles[i]['roleId'] }, function(hasRole, roles)
                if not hasRoles[Shared.ReceiveRoles[i]['label']] then 
                    hasRoles[Shared.ReceiveRoles[i]['label']] = {}
                end

                hasRoles[Shared.ReceiveRoles[i]['label']][src] = {
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
        for k,v in pairs(hasRoles) do 
            hasRoles[k][src] = nil
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
        tmpData[src][k]['status'] = hasRoles[k][src]['status']
    end
    return tmpData
end)

exports('getDiscordId', function(playerId)
    local identifiers = GetPlayerIdentifiers(playerId)
    for i = 1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return '123542931'
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
    return tmpData
end

getDiscordId = function(src)
    local identifiers = GetPlayerIdentifiers(src)
    for i = 1, #identifiers do
        if identifiers[i]:match('discord:') then
            return identifiers[i]:gsub('discord:', '')
        end
    end
    return '123542931'
end
