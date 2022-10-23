local QBCore = exports['qb-core']:GetCoreObject()



RegisterServerEvent('dollar:harvest:grape:getitem', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(1,3) 
    if Player ~= nil then   
        Player.Functions.AddItem(Config.GrapeItem, amount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.GrapeItem], 'add', amount)
    end


end)

QBCore.Functions.CreateCallback('dollar:process:getitem', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.GrapeItem)
    if item  ~= nil then

    cb(tonumber(item.amount))
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Locale['no_grapes_toprocess'], "error")

    end
end)

QBCore.Functions.CreateCallback('dollar:process:getitem:wine', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local item = Player.Functions.GetItemByName(Config.WineItem)
    if item  ~= nil then

    cb(tonumber(item.amount))
    else
        TriggerClientEvent('QBCore:Notify', src, Config.Locale['no_wines_tosell'], "error")

    end
end)

RegisterServerEvent('dollar:process:grape:server', function (cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local amount = math.random(1,3) 

    print(cb)
    if Player ~= nil then   
        Player.Functions.RemoveItem(Config.GrapeItem, cb)
        Citizen.Wait(100)
        Player.Functions.AddItem(Config.WineItem, cb)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WineItem], 'add', cb)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.GrapeItem], 'remove', cb)
    end
    

end)

RegisterNetEvent('dollar:process:wine:server', function (cb, level)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local  payment = 0
     if Config.Skill then

    if level >= 100  and level <= 200 then
     payment = payment  + 10
 
 elseif level >= 200 and level <= 400 then
     payment = payment  + 15
 
 elseif level >= 400 and level <= 800 then
     payment = payment  + 20
 elseif level >= 800 and level <= 1600 then
     payment = payment  + 25
 
 elseif level >= 1600 and level <= 3200 then
     payment = payment  + 25
 
 elseif level >= 3200 and level <= 6400 then
     payment = payment  + 30
 
 elseif level >= 6400 and level <= 12800 then
     payment = payment  + 50
 elseif level > 12800 then
     payment = payment  + 100
 
 end
 if Player ~= nil then   
    Player.Functions.RemoveItem(Config.WineItem, cb)
    Player.Functions.AddMoney('cash', cb * Config.WinePrice + payment * cb) 
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WineItem], 'remove', cb)
end
else

end

    if Player ~= nil then   
        Player.Functions.RemoveItem(Config.WineItem, cb)
        Player.Functions.AddMoney('cash', cb * Config.WinePrice ) 
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[Config.WineItem], 'remove', cb)
    end
end)

