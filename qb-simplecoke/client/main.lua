local NeededAttempts = 0
local SucceededAttempts = 0
local FailedAttemps = 0
local weedpicking = false
local weedprocess = false
local nearDealer = false
local QBCore = exports['qb-core']:GetCoreObject()


DrawText3Ds = function(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance = #(PlayerPos - vector3(1487.76, 1128.55, 114.34))
 --        local distance2 = #(PlayerPos - vector3(-695.59, 61.27, 69.69)) -- YOUR COORDS HERE
 --        local distance3 = #(PlayerPos - vector3(-695.59, 61.27, 69.69)) -- YOUR COORDS HERE
        
        if distance < 6 then
            inRange = true

            if distance < 2 then
                DrawText3Ds(-695.53, 61.38, 69.69, "[G] Break Down The Cocaine")
                if IsControlJustPressed(0, 47) then
					TriggerServerEvent("apolo_weed:server:processcoca_leaf")
                end
            end
			
 --           if distance2 < 2 then
 --               DrawText3Ds(-695.59, 61.27, 69.69, "[G] Break Down The Cocaine")
 --               if IsControlJustPressed(0, 47) then
 --                   TriggerServerEvent("apolo_weed:server:processcoca_leaf")
 --
 --               end
 --          end
			
 --          if distance3 < 2 then
 --             DrawText3Ds(-695.59, 61.27, 69.69, "[G] Break Down The Cocaine")
 --               if IsControlJustPressed(0, 47) then
 --                   TriggerServerEvent("apolo_weed:server:processcoca_leaf")
 --
 --              end
 --           end
            
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance = #(PlayerPos - vector3(-307.01, 203.1, 175.49))
        
        if distance < 6 then
            inRange = true

            if distance < 2 then
                DrawText3Ds(974.08, -192.22, 73.2, "[G] Sell Weed")
                if IsControlJustPressed(0, 47) then
                    TriggerServerEvent("apolo_weed:server:weedsell")

                end
            end
            
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

Citizen.CreateThread(function()
    while true do
        local inRange = false

        local PlayerPed = PlayerPedId()
        local PlayerPos = GetEntityCoords(PlayerPed)

        local distance1 = #(PlayerPos - vector3(1910.48, 4814.05, 45.13))
        local distance2 = #(PlayerPos - vector3(1788.5, 4953.41, 44.81))
        local distance3 = #(PlayerPos - vector3(1793.48, 4957.7, 45.26))
        
        if distance1 < 15 then
            inRange = true

            if distance1 < 2 then
                DrawText3Ds(1910.48, 4814.05, 45.12, "[G] Start Picking")
                if IsControlJustPressed(0, 47) then
                    PrepareAnim()
                    pickProcess()
                end
            end
			
            if distance2 < 2 then
                DrawText3Ds(1908.62, 4816.03, 45.29, "[G] Start Picking")
                if IsControlJustPressed(0, 47) then
                    PrepareAnim()
                    pickProcess()
                end
            end
			

            if distance3 < 2 then
                DrawText3Ds(1908.93, 4818.97, 45.43, "[G] Start Picking")
                if IsControlJustPressed(0, 47) then
                    PrepareAnim()
                    pickProcess()
                end
            end
			
        end

        if not inRange then
            Citizen.Wait(2000)
        end
        Citizen.Wait(3)
    end
end)

RegisterNetEvent('apolo_weed:client:pickcoca_leaf')
AddEventHandler('apolo_weed:client:pickcoca_leaf', function(source)
    PrepareProcessAnim()
    pickProcess()
end)


RegisterNetEvent('apolo_weed:client:coca_leafprocess')
AddEventHandler('apolo_weed:client:coca_leafprocess', function(source)
	PrepareProcessAnim()
    weedProcess()
end)

function pickProcess()
    QBCore.Functions.Progressbar("pick_coca_leaf", "Picking Coca Leaf...", math.random(5000,7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("apolo_weed:server:getcoca_leaf")
        ClearPedTasks(PlayerPedId())
        cannabispicking = false
    end, function() -- Cancel
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Cancelled", "error")
    end)
end

function coca_leafProcess()
    QBCore.Functions.Progressbar("coca_leaf_process", "Process Cocaine...", math.random(5000, 7000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- Done
        TriggerServerEvent("apolo_weed:server:getcoca_leaf")
        ClearPedTasks(PlayerPedId())
        cannabispicking = false
    end, function() -- Cancel
        openingDoor = false
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify("Process Cancelled", "error")
    end)
end

function PickMinigame()
    local Skillbar = exports['reload-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
    end

    local maxwidth = 30
    local maxduration = 3500

    Skillbar.Start({
        duration = math.random(2000, 3000),
        pos = math.random(10, 30),
        width = math.random(20, 30),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            pickProcess()
            QBCore.Functions.Notify("You picked a coca leaf", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(2000, 3000),
                pos = math.random(10, 30),
                width = math.random(20, 30),
            })
        end
                
        
	end, function()

            QBCore.Functions.Notify("You messed up the leaf!", "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            cannabispicking = false
       
    end)
end

function ProcessMinigame(source)
    local Skillbar = exports['reload-skillbar']:GetSkillbarObject()
    if NeededAttempts == 0 then
        NeededAttempts = math.random(3, 5)
    end

    local maxwidth = 30
    local maxduration = 3000

    Skillbar.Start({
        duration = math.random(2000, 3000),
        pos = math.random(10, 30),
        width = math.random(20, 30),
    }, function()

        if SucceededAttempts + 1 >= NeededAttempts then
            coca_leafprocess()
            QBCore.Functions.Notify("You made some cocaine!", "success")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
        else    
            SucceededAttempts = SucceededAttempts + 1
            Skillbar.Repeat({
                duration = math.random(2000, 3000),
                pos = math.random(10, 30),
                width = math.random(20, 30),
            })
        end
                
        
	end, function()

            QBCore.Functions.Notify("You messed up the process!", "error")
            FailedAttemps = 0
            SucceededAttempts = 0
            NeededAttempts = 0
            coca_leafprocess = false
       
    end)
end


function PrepareProcessAnim()
    local ped = PlayerPedId()
    LoadAnim('mini@repair')
    TaskPlayAnim(ped, 'mini@repair', 'fixing_a_ped', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    PreparingProcessAnimCheck()
end

function PreparingProcessAnimCheck()
    coca_leafprocess = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if coca_leafprocess then
            else
                ClearPedTasksImmediately(ped)
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function PrepareAnim()
    local ped = PlayerPedId()
    TaskStartScenarioInPlace(ped, "WORLD_HUMAN_GARDENER_PLANT", 0, true)
    PreparingAnimCheck()
end

function ProcessPrepareAnim()
    local ped = PlayerPedId()
    LoadAnim('amb@prop_human_bbq@male@idle_a')
    TaskPlayAnim(ped, 'amb@prop_human_bbq@male@idle_a', 'idle_b', 6.0, -6.0, -1, 47, 0, 0, 0, 0)
    PreparingAnimCheck()
end

function PreparingAnimCheck()
    cannabispicking = true
    Citizen.CreateThread(function()
        while true do
            local ped = PlayerPedId()

            if cannabispicking then
            else
                ClearPedTasksImmediately(ped)
                break
            end

            Citizen.Wait(200)
        end
    end)
end

function LoadAnim(dict)
    while not HasAnimDictLoaded(dict) do
        RequestAnimDict(dict)
        Citizen.Wait(1)
    end
end

function LoadModel(model)
    while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(1)
    end
end
