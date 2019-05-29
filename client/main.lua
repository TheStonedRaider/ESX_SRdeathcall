local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
}

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

		while IsDead do
			Citizen.Wait(0)
			if IsControlPressed(0, Keys['G']) then
				SendDistressSignals()
				break
				
			end
		end
	end)
end

function SendDistressSignals()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed) -- stage 1
local playerreply = PlayerPedId()		
TriggerServerEvent('sr_distress',PedPosition,playerreply)
print(playerreply)
end



RegisterNetEvent('sr_distress')
AddEventHandler('sr_distress', function(PedPosition,playerreply)   ----- stage 3
print"testdistress31"
        local PlayerData = ESX.GetPlayerData(_source)
--		ESX.PlayerData.job = job
		  if PlayerData.job ~= nil and (PlayerData.job.name == 'fire' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'policeambulance') then
		  print"testdistress3"
--sendNotification(_U('Unconcious Citizen'), 'success', 2500)    
distressmessage(PedPosition,playerreply)	

end
end)

	function distressmessage(PedPosition,playerreply)
	accepted = false
--	sendNotification(_U('Unconcious_Citizen'), 'success', 2500)  
	repeat
	Wait(10)

    drawTxt(0.540, 0.56, 1.0,1.0,1.2, "Citizen Unconsious", 20, 20, 100, 255)
	drawTxt(0.540, 0.63, 1.0,1.0,1.0, "Y", 0, 255, 0, 255)
    drawTxt(0.540, 0.69, 1.0,1.0,1.0, "N", 255, 0, 0, 255)
	drawTxt(0.559, 0.63, 1.0,1.0,1.0, "to accept Call", 255, 100, 100, 255)
    drawTxt(0.559, 0.69, 1.0,1.0,1.0, "to dismiss Call", 255, 100, 100, 255)
	if IsControlPressed(0, Keys['Y']) then
	SetNewWaypoint(PedPosition)
	
print(playerreply)
TriggerServerEvent('sr_distressreply',PedPosition,playerreply)
	accepted = true
	end
	if IsControlPressed(0, Keys['N']) then
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