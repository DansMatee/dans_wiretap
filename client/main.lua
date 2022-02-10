local activeCalls = {}
local listening = false
local listenTime = Config.WaitTime
--###########################################################
--###########################################################
--########                                           ########
--########              WIRETAP SCRIPT               ########
--########                                           ########
--###########################################################
--###########################################################

Citizen.CreateThread(function()
	while true do
		if IsControlJustReleased(0, Config.Key) then
			TriggerEvent('d_wiretap:openWiretap')
		end
		if (listening == true) then
			if (listenTime == 0) then
				removeCalls()
				sendNoti('inform', 'Phone line unstable, rescan and reconnect!', '#0f3685', '#ffffff')
				listening = false
				exports['pma-voice']:setCallChannel(0)
				listenTime = Config.WaitTime
			else
				Citizen.Wait(1000)
				listenTime = listenTime - 1
			end
		end
		Citizen.Wait(10)
	end
end)

RegisterNetEvent('d_wiretap:openWiretap')
AddEventHandler('d_wiretap:openWiretap', function()
	SetNuiFocus(true,true)
	SendNUIMessage({
		display = true
	})
	display = true
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		display = false
	})
	display = false
end)

RegisterNUICallback('WantCalls', function()
	getCalls()
end)

RegisterNUICallback('SetCall', function(data, cb)
	setPhoneFreq(data.phoneFreq)
end)



RegisterNetEvent('d_wiretap:collectData')
AddEventHandler('d_wiretap:collectData', function(data)
	table.insert(activeCalls, data)
end)

-- HELPER COMMANDS FOR PMA-VOICE | DO NOT ENABLE THIS UNLESS TESTING

--RegisterCommand('radio', function(source, args)
--	local channel = args[1]

--	if (channel == "off") then
--		exports['pma-voice']:setRadioChannel(0)
--	else 
--		channel = tonumber(args[1])
--		exports['pma-voice']:setRadioChannel(channel)
--	end
--end)

--RegisterCommand('call', function(source, args)
--	local call = args[1]

--	if (call == "end") then
--		exports['pma-voice']:setCallChannel(0)
--	else
--		call = tonumber(args[1])
--		exports['pma-voice']:setCallChannel(call)
--	end
--end)

function getCalls()
	activeCalls = {}
	for k, v in pairs(GetNearestPlayers()) do
		playerId = v.playerId
		TriggerServerEvent('d_wiretap:searchCalls', playerId)
	end
	Wait(1000)
	for k,v in pairs(activeCalls) do
		AddCurrentCall(v[1].playerId, v[1].phoneFreq)
	end
end

function AddCurrentCall(playerId, phoneFreq)
	SendNUIMessage({
		type = 'add_item',
		player = playerId,
		freq = phoneFreq
	})
end

function setPhoneFreq(phoneFreq)
	freq = tonumber(phoneFreq)

	if (freq == nil) then
	elseif (freq == 0) then
		listening = false
		exports['pma-voice']:setCallChannel(freq)
	else
		listening = true
		exports['pma-voice']:setCallChannel(freq)
	end	
end

function removeCalls()
	SendNUIMessage({
		type = 'clear_items'
	})
end

function sendNoti(type, info, bkgColor, color)
	exports['mythic_notify']:DoLongHudText(type, info, { ['background-color'] = bkgColor, ['color'] = color })
end