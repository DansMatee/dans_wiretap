
RegisterNetEvent('d_wiretap:searchCalls')
AddEventHandler('d_wiretap:searchCalls', function(playerId)
    local currentCalls = {}
    local phoneFreq = nil

    if (playerId == nil) then
        --print('Player not found')
    else
        phoneFreq = Player(playerId).state.callChannel
    end
    
    if (phoneFreq == nil) then
        --print('PhoneFreq = nil')
    elseif (phoneFreq == 0) then
        --print('Player not on call')
    else
        --print(playerId, phoneFreq)
        table.insert(currentCalls, {playerId = playerId, phoneFreq = phoneFreq})
        
        TriggerClientEvent('d_wiretap:collectData', source, currentCalls)
    end
end)
