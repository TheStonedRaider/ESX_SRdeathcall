
--- esx
ESX                           = nil
local PlayerData              = {}

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(15)
 	PlayerData = ESX.GetPlayerData()
	
  end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

AddEventHandler('esx:onPlayerDeath', function(reason)
	WaitforGpress()
	IsDead = true
end)





function WaitforGpress()
	Citizen.CreateThread(function()
msgsent = false
		while IsDead do
			Citizen.Wait(0)
			if Config.displaymessage == true then 
			drawTxt(0.540, 0.56, 1.0,1.0,1.2, "Press ~g~G~w~ to Call for Help", 255, 255, 255, 255)
			end
			if IsControlPressed(0, 47) and msgsent == false then
			msgsent = true
				SendDistressSignals()
				break
				
			end
		end
	end)
end

function SendDistressSignals()
	local player = PlayerId()
		local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed) -- stage 1
--local PlayerId = PlayerPedId()	
local PlayerServerID = GetPlayerServerId(player) 
TriggerServerEvent('sr_distress',PedPosition,PlayerServerID)
print"PlayerId"
print(PlayerId)
print"PlayerServerID"
print(PlayerServerID)

end


RegisterNetEvent('sr_distress')
AddEventHandler('sr_distress', function(PedPosition,PlayerServerID)   ----- stage 3
print"testdistress31"
        local PlayerData = ESX.GetPlayerData(_source)
--		ESX.PlayerData.job = job
		  if PlayerData.job ~= nil and (PlayerData.job.name == 'fire' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'policeambulance') then
		  print"testdistress3"
--sendNotification(_U('Unconcious Citizen'), 'success', 2500)    
distressmessage(PedPosition,PlayerServerID)	

end
end)

	function distressmessage(PedPosition,PlayerServerID)
	accepted = false
--	sendNotification(_U('Unconcious_Citizen'), 'success', 2500)  
	repeat
	Wait(10)

    drawTxt(0.540, 0.56, 1.0,1.0,1.2, "Citizen Unconsious", 255, 255, 255, 255)
	drawTxt(0.540, 0.63, 1.0,1.0,1.0, "Y", 0, 255, 0, 255)
    drawTxt(0.540, 0.69, 1.0,1.0,1.0, "N", 255, 0, 0, 255)
	drawTxt(0.559, 0.63, 1.0,1.0,1.0, "to accept Call", 255, 100, 100, 255)
    drawTxt(0.559, 0.69, 1.0,1.0,1.0, "to dismiss Call", 255, 100, 100, 255)
	if IsControlPressed(0, 246) then
	SetNewWaypoint(PedPosition)
	
print(PlayerServerID)
TriggerServerEvent('sr_distressreply',PedPosition,PlayerServerID)
	accepted = true
	end
	if IsControlPressed(0, 249) then
--	SetNewWaypoint(PedPosition)
	accepted = true
	end
	until accepted == true
	end

	
	function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function sendNotification(message, messageType, messageTimeout)
	TriggerEvent("pNotify:SendNotification", {
		text = message,
		type = messageType,
		queue = "duty",
		timeout = messageTimeout,
		layout = "bottomCenter"
	})
end


	

	
	
