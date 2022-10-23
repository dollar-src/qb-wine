local QBCore = exports['qb-core']:GetCoreObject()

local peds = {} 



Citizen.CreateThread(function()

        for k in pairs(Config.targetloc) do
    
    
        exports[Config.targetExport]:AddBoxZone(Config.targetloc[k].name, vector3(Config.targetloc[k].x, Config.targetloc[k].y, Config.targetloc[k].z),  2, 2, {
            name = Config.targetloc[k].name,
            debugPoly = false,
        }, {
            options = {
                {
                    event = "dollar:harvest:grape:client",
                    icon = "fa-solid fa-wheat-awn",
                    label = Config.Locale["target_label_collect"]
                    
                },
    
            },
            distance = 2.5
        })
    
    end
  
    
    exports[Config.targetExport]:AddTargetModel("a_m_m_farmer_01", {
        options = {
            {
                event = "dollar:Process:grape:client",
                icon = "fa-solid fa-wheat-awn",
                label = Config.Locale['target_process_grape'],
            },
        },
        distance = 10.0
    })
    exports[Config.targetExport]:AddTargetModel("a_m_y_business_02", {
        options = {
            {
                event = "dollar:sell:grape:client",
                icon = "fa-solid fa-wheat-awn",
                label = Config.Locale['target_sell_wines'],
            },
        },
        distance = 10.0
    })


   

    


end)


RegisterNetEvent('dollar:Process:grape:client', function ()
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('dollar:process:getitem', function(cb)
    local itemamount = cb
   
    QBCore.Functions.Progressbar("üzümisle", Config.Locale["progressbar_process"],itemamount * 500 + 5000 , false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_car_bomb",
        anim = "car_bomb_mechanic",
        flags = 49,
    }, {
        model = "",
        bone = 0,
        coords = { x = 0.05, y = -0.4, z = -0.10 },
        rotation = { x = 80.0, y = -20.0, z = 175.0 },
    }, {}, function() 
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        ClearPedTasksImmediately(ped)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('dollar:process:grape:server', cb)
        QBCore.Functions.Notify(Config.Locale["process_grape"] , "success")
        if Config.Skill then
        
        exports["mz-skills"]:UpdateSkill('Harvest', 10)

    end
    end, function() 
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        ClearPedTasksImmediately(ped)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify(Config.Locale["cancel"], "error")
    end, Config.WineItem)





    end)
end)




RegisterNetEvent('dollar:harvest:grape:client', function ()
    local ped = PlayerPedId()

    QBCore.Functions.Progressbar("picking_grapes", Config.Locale["picking_grapes"], math.random(5000, 6000), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_car_bomb",
        anim = "car_bomb_mechanic",
        flags = 49,
    }, {
        model = "",
        bone = 0,
        coords = { x = 0.05, y = -0.4, z = -0.10 },
        rotation = { x = 80.0, y = -20.0, z = 175.0 },
    }, {}, function() 
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        ClearPedTasksImmediately(ped)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('dollar:harvest:grape:getitem')
        QBCore.Functions.Notify(Config.Locale["grape_gather"], "success")
        if Config.Skill then
            
    
        exports["mz-skills"]:UpdateSkill('Harvest', 10)
    end
    end, function() 
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        ClearPedTasksImmediately(ped)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify(Config.Locale["cancel"], "error")
    end, Config.GrapeItem)
    
end)


RegisterNetEvent('dollar:sell:grape:client', function ()
    local ped = PlayerPedId()
    QBCore.Functions.TriggerCallback('dollar:process:getitem:wine', function(cb)
    local itemamount = cb
    local level =  exports["mz-skills"]:GetCurrentSkill('Harvest')
    local currentlevel = level.Current
   
    QBCore.Functions.Progressbar("sellwine", Config.Locale["selling_grapes"],itemamount * 500 + 5000 , false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "mp_car_bomb",
        anim = "car_bomb_mechanic",
        flags = 49,
    }, {
        model = "",
        bone = 0,
        coords = { x = 0.05, y = -0.4, z = -0.10 },
        rotation = { x = 80.0, y = -20.0, z = 175.0 },
    }, {}, function() 
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        ClearPedTasksImmediately(ped)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('dollar:process:wine:server', cb, currentlevel)
        QBCore.Functions.Notify(Config.Locale["sell_wines"] , "success")

    end, function() 
        StopAnimTask(GetPlayerPed(-1), "anim@gangops@facility@servers@", "hotwire", 1.0)
        ClearPedTasksImmediately(ped)
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify(Config.Locale["cancel"], "error")
    end, Config.WineItem)





    end)
end)


CreateThread(function()
	while true do
		Wait(500)
		for k = 1, #Config.PedList, 1 do
			v = Config.PedList[k]
			local playerCoords = GetEntityCoords(PlayerPedId())
			local dist = #(playerCoords - v.coords)

			if dist < 50.0 and not peds[k] then
				local ped = nearPed(v.model, v.coords, v.heading, v.gender, v.animDict, v.animName, v.scenario)
				peds[k] = {ped = ped}
			end

			if dist >= 50.0 and peds[k] then
				for i = 255, 0, -51 do
					Wait(50)
					SetEntityAlpha(peds[k].ped, i, false)
				end
				DeletePed(peds[k].ped)
				peds[k] = nil
			end
		end
	end
end)

nearPed = function(model, coords, heading, gender, animDict, animName, scenario)
	RequestModel(GetHashKey(model))
	while not HasModelLoaded(GetHashKey(model)) do
		Wait(1)
	end

	if gender == 'male' then
		genderNum = 4
	elseif gender == 'female' then 
		genderNum = 5
	else
		print("No gender provided! Check your configuration!")
	end	

	ped = CreatePed(genderNum, GetHashKey(v.model), coords, heading, false, true)
	SetEntityAlpha(ped, 0, false)

	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Wait(1)
		end
		TaskPlayAnim(ped, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end
	if scenario then
		TaskStartScenarioInPlace(ped, scenario, 0, true) 
	end
	for i = 0, 255, 51 do
		Wait(50)
		SetEntityAlpha(ped, i, false)
	end

	return ped
end


Citizen.CreateThread(function()
    for k, v in pairs(Config.JobBlips) do
        joblipsfunction(v.x,v.y, v.sprite, v.colour, v.scale, v.info)
      end
end)


function joblipsfunction(x, y, sprite, colour, scale, text)
    local clotehtable = {}
    local blip = AddBlipForCoord(x, y)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    table.insert(clotehtable, blip)
end

RegisterCommand('ab', function ()
    exports["mz-skills"]:UpdateSkill('Harvest', 10000)

end)