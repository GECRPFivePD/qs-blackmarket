if Config.Framework ~= 'qb' then
    return
end

QBCore = exports['qb-core']:GetCoreObject()

local useOxInventory = GetResourceState('ox_inventory') == 'started'

function buy(player, itemData, source, obj)
    local function handlePurchase(paymentType)
        local noFundsMsg
        local totalValue = 0

        if paymentType == "cash" then
            if player.Functions.GetMoney("cash") < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        elseif paymentType == "bank" then
            if player.Functions.GetMoney("bank") < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        elseif paymentType == "item" then
            if player.Functions.GetItemByName(itemData.paymentItem).amount < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        elseif paymentType == "blackmoney" then
            totalValue = getDirtyMoneyWorth(player)
            print(totalValue)
            if totalValue < itemData.price then
                noFundsMsg = 'BLACKMARKET_NOTIFICATION_NO_MONEY'
            end
        end
        
        if noFundsMsg then
            TriggerClientEvent('blackmarket:client:sendTextMessage', source, _U(noFundsMsg), 'error')
            return false
        end

        local existingItem = player.Functions.GetItemByName(itemData.label)
        if existingItem and existingItem.amount >= itemData.maxquantity then 
            TriggerClientEvent('blackmarket:client:sendTextMessage', source, _U('BLACKMARKET_NOTIFICATION_NO_BUY_MORE'), 'error')
            return false
        end

        TriggerClientEvent('blackmarket:client:sendTextMessage', source, _U('BLACKMARKET_NOTIFICATION_PURCHASED'), 'success')
        if paymentType == "cash" then
            player.Functions.RemoveMoney("cash", itemData.price)
        elseif paymentType == "bank" then
            player.Functions.RemoveMoney("bank", itemData.price)
        elseif paymentType == "item" then
            player.Functions.RemoveItem(itemData.paymentItem, itemData.price)
        elseif paymentType == "blackmoney" then
            if useOxInventory then
                exports.ox_inventory:RemoveItem(player.PlayerData.source, 'black_money', totalValue)
            else
                local newBalance = totalValue - itemData.price
                updateDirtyMoney(newBalance, player)
            end
        end
        
        player.Functions.AddItem(itemData.label, 1)
        
        if Webhooks.Active then 
            local playerId = player.PlayerData.citizenid
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

function getDirtyMoneyWorth(player)
    local dirtyMoneyAmount = 0
    local dirtyMoneyItems = player.Functions.GetItemsByName('markedbills')

    if dirtyMoneyItems then
        for _, item in pairs(dirtyMoneyItems) do
            if item and item.info and item.info.worth then
                dirtyMoneyAmount = dirtyMoneyAmount + item.info.worth
            end
        end
    end

    return dirtyMoneyAmount
end


function updateDirtyMoney(newBalance, player)
    local dirtyMoneyItems = player.Functions.GetItemsByName('markedbills')

    if not dirtyMoneyItems or #dirtyMoneyItems == 0 then
        return
    end

    for _, item in pairs(dirtyMoneyItems) do
        if newBalance <= 0 then
            player.Functions.RemoveItem('markedbills', item.amount, false, item.slot)
        elseif item.info and item.info.worth then
            if newBalance >= item.info.worth then
                player.Functions.RemoveItem('markedbills', item.amount, false, item.slot)
                newBalance = newBalance - item.info.worth
            else
                local updatedItemInfo = item.info
                updatedItemInfo.worth = newBalance

                player.Functions.RemoveItem('markedbills', item.amount, false, item.slot)

                player.Functions.AddItem('markedbills', 1, item.slot, updatedItemInfo)

                newBalance = 0
            end
        end
    end
end

function GetPlayerFromId(source)
    return QBCore.Functions.GetPlayer(source)
end
