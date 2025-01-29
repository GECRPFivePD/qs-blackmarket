if Config.Framework ~= 'esx' then
    return
end

ESX = exports['es_extended']:getSharedObject()

CreateTarget = function(data)
    if data.targetType == 'AddBoxZone' then
        if data.distance == nil then
            distance = 3.0
        else
            distance = data.distance
        end

        exports["qtarget"]:AddBoxZone(data.identifier, data.coords, data.length, data.width, {
            name=data.identifier,
            heading=data.heading,
            debugPoly=false,
            minZ=data.coords.z-0.7,
            maxZ=data.coords.z+1.5,
        }, {
            options = data.options,
            distance = distance,
        })
    end
end

openui = function(ped,npc,vehicle)
    FreezeEntityPosition(ped,true)
    Wait(2000)
    local px, py, pz = table.unpack(GetEntityCoords(npc, true))
    local x, y, z = px + GetEntityForwardX(npc) * 1.5, py + GetEntityForwardY(npc) * 0.7, pz + 0.42                   
    camCoords = vector3(x, y, z)
    SetCamParams(camHandle, camCoords, GetEntityRotation(vehicle, 2), 50.0, 1300, 1, 3, 1)
    SetVehicleDoorOpen(vehicle, 2, false, false)
    SetVehicleDoorOpen(vehicle, 3, false, false)
    Citizen.Wait(1200)
    SendNUIMessage({ type = "2", type2 = "show2"})
    SetNuiFocus(true, true)  
end

closeui = function(ped, npc, vehicle)
    SendNUIMessage({ type = "2", type2 = "hide2"})
    EndCam()
    Wait(700)
    SetVehicleDoorShut(vehicle, 2, false, false)
    SetVehicleDoorShut(vehicle, 3, false, false)
    Wait(200)
    FreezeEntityPosition(ped,false)
    DeleteEntity(npc)   
end

forcedclosingui = function(ped,npc,vehicle)
    SendNUIMessage({ type = "2", type2 = "hide2"})
    Wait(1000)
    SendNUIMessage({ type = "1", type2 = "hide"})
    SendNUIMessage({ type = "3", type2 = "hide3"})
    EndCam()
    SetVehicleDoorShut(vehicle, 2, false, false)
    SetVehicleDoorShut(vehicle, 3, false, false)
    Wait(200)
    FreezeEntityPosition(ped,false)
    DeleteEntity(npc)  
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, false, -1)
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'error' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
    if type == 'success' then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0, 1)
    end
end

function hintToDisplay(text,coords)
	local dist = #(vec3(coords.x,coords.y,coords.z) - GetEntityCoords(PlayerPedId()))
    if dist < 1.5 then
        DrawText3D(coords.x,coords.y,coords.z + 1.05,text, 0, 0.1, 0.1,255)
    else
        DrawText3D(coords.x,coords.y,coords.z + 1.05,text, 0, 0.1, 0.1,100)
    end
end

function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry('STRING')
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    local factor = string.len(text) / 370
    DrawRect(0.0, 0.0125, 0.017 + factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end
