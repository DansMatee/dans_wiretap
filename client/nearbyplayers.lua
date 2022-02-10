function GetNearestPlayers()
    local playerPed = PlayerPedId()
    local playerTable = {}
    local playerCoords = GetEntityCoords(playerPed)

    local players, _ = GetPlayersInArea(playerCoords, Config.ScanDistance)
    for i = 1, #players, 1 do
        local playerServerId = GetPlayerServerId(players[i])
        local player = GetPlayerFromServerId(playerServerId)
        local ped = GetPlayerPed(player)
        table.insert(playerTable, { playerId = playerServerId })
    end
   
    return playerTable
end

function GetPlayersInArea(coords, area)
	local players, playersInArea = GetPlayers(), {}
	local coords = vector3(coords.x, coords.y, coords.z)
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)

		if #(coords - targetCoords) <= area then
			table.insert(playersInArea, players[i])
		end
	end
	return playersInArea
end

function GetPlayers()
    local players = {}
    for _, player in ipairs(GetActivePlayers()) do
        local ped = GetPlayerPed(player)
        if DoesEntityExist(ped) then
            table.insert(players, player)
        end
    end
    return players
end