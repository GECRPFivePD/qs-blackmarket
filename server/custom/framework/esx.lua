if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

local useOxInventory = GetResourceState('ox_inventory') == 'started'

function buy(player, itemData, source, obj)
    local function handlePurchase(paymentType)
        local noFundsMsg
        local totalValue = 0

        if paymentType == "cash" then
            if player.getMoney() < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        elseif paymentType == "bank" then
            if player.getAccount('bank').money < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        elseif paymentType == "item" then
            local item = player.getInventoryItem(itemData.paymentItem)
            if item.count < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        elseif paymentType == "blackmoney" then
            if player.getAccount('black_money').money < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        end
        
        if noFundsMsg then
            TriggerClientEvent('esx:showNotification', source, _U(noFundsMsg))
            return false
        end

        local existingItem = player.getInventoryItem(itemData.label)
        if existingItem and existingItem.count >= itemData.maxquantity then 
            TriggerClientEvent('esx:showNotification', source, _U('BLACKMARKET_NOTIFICATION_NO_BUY_MORE'))
            return false
        end

        TriggerClientEvent('esx:showNotification', source, _U('BLACKMARKET_NOTIFICATION_PURCHASED'))
        if paymentType == "cash" then
            player.removeMoney(itemData.price)
        elseif paymentType == "bank" then
            player.removeAccountMoney('bank', itemData.price)
        elseif paymentType == "item" then
            player.removeInventoryItem(itemData.paymentItem, itemData.price)
        elseif paymentType == "blackmoney" then
            player.removeAccountMoney('black_money', itemData.price)
        end

        if obj == "weapon" then
            if useOxInventory then
                player.addInventoryItem(itemData.label, 1)
            else
                player.addWeapon(itemData.label, 1)
            end
        elseif obj == "item" then
            player.addInventoryItem(itemData.label, 1)
        end

        if Webhooks.Active then 
            local playerId = player.identifier
            local boughtItem = itemData.label
            local logMessage = Webhooks.Text.NewBuy:gsub("{name}", tostring(GetPlayerName(source)))
                                                 :gsub("{identifier}", tostring(playerId))
                                                 :gsub("{weapon}", tostring(boughtItem))
            Log(logMessage)
        end
        
        return true
    end

    local paymentMethods = {
        cash = "cash",
        bank = "bank",
        item = "item",
        black_money = "blackmoney"
    }

    handlePurchase(paymentMethods[Config.Payment.option])
end

function GetPlayerFromId(source)
    return ESX.GetPlayerFromId(source)
end
