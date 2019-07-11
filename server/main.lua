ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)




RegisterServerEvent('sr_distress')
AddEventHandler('sr_distress', function(PedPosition,PlayerServerID)  --stage 2
   
   TriggerClientEvent('sr_distress',-1, PedPosition,PlayerServerID)
	print"testdistress2"
	print(PlayerServerID)
end)


RegisterServerEvent('sr_distressreply')                             ---- stage 4 
AddEventHandler('sr_distressreply', function(PedPosition,PlayerServerID)
TriggerClientEvent('esx:showNotification',PlayerServerID, '~y~EMS has your location and is on the way!')
	print"testdistres4"
	print(PlayerServerID)
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
