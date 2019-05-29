ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sr_distress')
AddEventHandler('sr_distress', function(PedPosition,playerreply)  --stage 2
   
   TriggerClientEvent('sr_distress',-1, PedPosition,playerreply)
	print"testdistress2"
	print(playerreply)
end)


RegisterServerEvent('sr_distressreply')                             ---- stage 4 
AddEventHandler('sr_distressreply', function(PedPosition,playerreply)
TriggerClientEvent('esx:showNotification',playerreply, '~y~EMS is on the way!')
	print"testdistres4"
	print(playerreply)
end)



--notification
function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "emscall",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end