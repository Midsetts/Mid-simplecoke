local QBCore = exports['qb-core']:GetCoreObject()


local ItemList = {
    ["coca_leaf"] = "coca_leaf"
}

local DrugList = {
    ["cokebaggy"] = "cokebaggy"
}


RegisterServerEvent('apolo_weed:server:processcoca_leaf')
AddEventHandler('apolo_weed:server:processcoca_leaf', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local cannabis = Player.Functions.GetItemByName('coca_leaf')

        if Player.PlayerData.items ~= nil then 
            if coca_leaf ~= nil then 
                if cannabis.amount >= 2 then 

                    Player.Functions.RemoveItem("coca_leaf", 2, false)
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['coca_leaf'], "remove")

                    TriggerClientEvent("apolo_weed:client:coca_leafprocess", src)
                else
                    TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')   
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have the correct items", 'error')   
            end
        else
            TriggerClientEvent('QBCore:Notify', src, "You Have Nothing...", "error")
        end
        
end)


RegisterServerEvent('apolo_weed:server:coca_leafsell')
AddEventHandler('apolo_weed:server:coca_leafsell', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local weed = Player.Functions.GetItemByName('coca_leaf')

    if Player.PlayerData.items ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if weed ~= nil then
                if DrugList[Player.PlayerData.items[k].name] ~= nil then 
                    if Player.PlayerData.items[k].name == "cokebaggy" and Player.PlayerData.items[k].amount >= 1 then 
                        local random = math.random(50, 65)
                        local amount = Player.PlayerData.items[k].amount * random

                        TriggerClientEvent('chatMessage', source, "Dealer Johnny", "normal", 'Damn you got '..Player.PlayerData.items[k].amount..'bricks of weed')
                        TriggerClientEvent('chatMessage', source, "Dealer Johnny", "normal", 'Ill buy all of it for $'..amount )

                        Player.Functions.RemoveItem("coca_leaf", Player.PlayerData.items[k].amount)
                        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['cokebaggy'], "remove")
                        Player.Functions.AddMoney("cash", amount)
                        break
                    else
                        TriggerClientEvent('QBCore:Notify', src, "You do not have coca leaves.", 'error')
                        break
                    end
                end
            else
                TriggerClientEvent('QBCore:Notify', src, "You do not have coca leaves", 'error')
                break
            end
        end
    end
end)


RegisterServerEvent('apolo_weed:server:getcoca_leaf')
AddEventHandler('apolo_weed:server:getcoca_leaf', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("cannabis", 10)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['coca_leaf'], "add")
end)

RegisterServerEvent('apolo_weed:server:getcoca_leaf')
AddEventHandler('apolo_weed:server:getcoca_leaf', function()
    local Player = QBCore.Functions.GetPlayer(source)
    Player.Functions.AddItem("coca_leaf", 1)
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['coca_leaf'], "add")
end)


