--[[


    ██████╗░██╗░░░░░░█████╗░░█████╗░██╗░░██╗  ███╗░░░███╗░█████╗░██████╗░██╗░░██╗███████╗████████╗
    ██╔══██╗██║░░░░░██╔══██╗██╔══██╗██║░██╔╝  ████╗░████║██╔══██╗██╔══██╗██║░██╔╝██╔════╝╚══██╔══╝
    ██████╦╝██║░░░░░███████║██║░░╚═╝█████═╝░  ██╔████╔██║███████║██████╔╝█████═╝░█████╗░░░░░██║░░░
    ██╔══██╗██║░░░░░██╔══██║██║░░██╗██╔═██╗░  ██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗░██╔══╝░░░░░██║░░░
    ██████╦╝███████╗██║░░██║╚█████╔╝██║░╚██╗  ██║░╚═╝░██║██║░░██║██║░░██║██║░╚██╗███████╗░░░██║░░░
    ╚═════╝░╚══════╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░╚═╝╚══════╝░░░╚═╝░░░
    

    Welcome to the qs-blackmarket configuration!
    To start configuring your new asset, please read carefully
    each step in the documentation that we will attach at the end of this message.

    Each important part of the configuration will be highlighted with a box.
    like this one you are reading now, where I will explain step by step each
    configuration available within this file.

    This is not all, most of the settings, you are free to modify it
    as you wish and adapt it to your framework in the most comfortable way possible.
    The configurable files you will find all inside client/custom/*
    or inside server/custom/*.

    Direct link to the resource documentation, read it before you start:
    https://docs.quasar-store.com/information/welcome
]]

Config = Config or {}
Locales = Locales or {}

--[[

    ██╗░░░░░░█████╗░███╗░░██╗░██████╗░██╗░░░██╗░█████╗░░██████╗░███████╗
    ██║░░░░░██╔══██╗████╗░██║██╔════╝░██║░░░██║██╔══██╗██╔════╝░██╔════╝
    ██║░░░░░███████║██╔██╗██║██║░░██╗░██║░░░██║███████║██║░░██╗░█████╗░░
    ██║░░░░░██╔══██║██║╚████║██║░░╚██╗██║░░░██║██╔══██║██║░░╚██╗██╔══╝░░
    ███████╗██║░░██║██║░╚███║╚██████╔╝╚██████╔╝██║░░██║╚██████╔╝███████╗
    ╚══════╝╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░░╚═════╝░╚═╝░░╚═╝░╚═════╝░╚══════╝

    The first thing will be to choose our main language, here you can choose
    between the default languages that you will find within locales/*,
    if yours is not there, feel free to create it!

	Languages available by default:
        'ar'
        'bg'
        'ca'
        'da'
        'de'
    	'en'
    	'es'
        'fa'
        'fr'
        'he'
        'hi'
        'it'
        'jp'
        'ko'
        'pt'
        'ru'
        'tr'
        'zh'
]]

Config.Language = 'en' -- 'en' or 'es' by default (you can create more)

--[[

    ███████╗██████╗░░█████╗░███╗░░░███╗███████╗░██╗░░░░░░░██╗░█████╗░██████╗░██╗░░██╗
    ██╔════╝██╔══██╗██╔══██╗████╗░████║██╔════╝░██║░░██╗░░██║██╔══██╗██╔══██╗██║░██╔╝
    █████╗░░██████╔╝███████║██╔████╔██║█████╗░░░╚██╗████╗██╔╝██║░░██║██████╔╝█████═╝░
    ██╔══╝░░██╔══██╗██╔══██║██║╚██╔╝██║██╔══╝░░░░████╔═████║░██║░░██║██╔══██╗██╔═██╗░
    ██║░░░░░██║░░██║██║░░██║██║░╚═╝░██║███████╗░░╚██╔╝░╚██╔╝░╚█████╔╝██║░░██║██║░╚██╗
    ╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝╚══════╝░░░╚═╝░░░╚═╝░░░╚════╝░╚═╝░░╚═╝╚═╝░░╚═╝

    Framework configuration and tools of your server!
    Please read the usable options carefully, in case they
    are not here you can add more or modify the default ones
    in the client/custom/* and server/custom/* directories.

    Please choose from the following options:

    Framework:
        'esx'
        'qb'

]]

local esxHas = GetResourceState('es_extended') == 'started'
local qbHas = GetResourceState('qb-core') == 'started'

Config.Framework = esxHas and 'esx' or qbHas and 'qb' or 'esx' -- You can change to 'qb' or 'esx'

Config.UseTarget = false  -- true/false

Config.HideMinimap = true -- true: hide the minimap while using the script ; false: I won't hide it
Config.Ped = "cs_chengsr" -- model ped
Config.RandomWeapons = true -- true: A set of random weapons/item will be released that you add in Blackmarket > Weapon/Item; false: same weapons will always come out

Config.Payment = {
    option = "cash", -- cash/bank/black_money/item
    item_name = "" -- if you use <option = "item"> then put here the name of the item you will pay with.
}

Webhooks = {  -- Here you can configure webhooks for discord

    Active = false, -- true: you will activate the webhooks; false: you will disable webhooks

    Config = {
        Webhook = "", -- webhook link
        Color = 65280, -- webhook color
    },

    Text = { -- webhook text
        NewBuy = "**# Player Name:** ```{name}``` " .. "\n" .. "**# Player Identifier:** ```{identifier}```" .. "\n" .. "**# INFO:** ```{name} has bought a {weapon} 📦```",
    },
}

BlackMarket = {
    -- You can add multiple locations for the truck, you just have to copy and paste this same code below
    {
        spawnCoords = vec4(-268.76, 2193.12, 129.0, 54.08), -- truck spawn coords
        ActionCoord = vec3(-265.08, 2190.44, 129.8), -- action coords
        CamCoord = vec3(-261.4, 2188.32, 130.88), -- coordinates of the camera that focuses on the doors of the truck
        PedCoord = vec4(-266.72, 2191.68, 129.96,240.12), -- ped spawn coords
        ItemProp = {0.0, 1.23, 0.0, 0.0, 0.0, 0.0}, -- Prop item spawn coords

        Weapon = {

            --

            {
                {
                    coord={1.0, -1.60, 0.0, 0.0, 0.0, -90.0}, -- attach prop coords
                    prop="w_ar_assaultrifle", -- prop model
                    name="weapon_assaultrifle", -- name give weapon
                    label="ASSAULT RIFLE", -- label weapon
                    price=1200, -- price weapon
                    maxquantity = 1, -- the amount of item you can have in your inventory, in this case if you have 1 you will not be able to buy another
                },
                {coord={1.0, -0.64, 0.0, 0.0, 0.0, -90.0},prop="w_pi_combatpistol",name="weapon_combatpistol",label="COMBAT PISTOL",price=200,maxquantity = 1,},
                {coord={1.0, 0.34, 0.0, 0.0, 0.0, -90.0},prop="w_pi_pistol",name="weapon_pistol",label="PISTOL",price=100,maxquantity = 1,},
                {coord={-1.0, 0.34, 0.0, 0.0, 0.0, 90.0},prop="w_ar_advancedrifle",name="weapon_advancedrifle",label="ADVANCED RIFLE",price=800,maxquantity = 1,},
                {coord={-1.0, -0.64, 0.0, 0.0, 0.0, 90.0},prop="w_ar_carbinerifle",name="weapon_carbinerifle",label="CARBINE RIFLE",price=500,maxquantity = 1,},
                {coord={-1.0, -1.60, 0.0, 0.0, 0.0, 90.0},prop="w_sb_assaultsmg",name="weapon_assaultsmg",label="ASSAULT SMG",price=900,maxquantity = 1,},
            },

            -- If you use "Config.RandomWeapons" you can add several sets of random weapons, here is an example:

            -- { 
            --     {coord={1.0, -1.60, 0.0, 0.0, 0.0, -90.0},prop="w_ar_assaultrifle",name="weapon_assaultrifle",label="ASSAULT RIFLE",price=1200,maxquantity = 1,},
            --     {coord={1.0, -0.64, 0.0, 0.0, 0.0, -90.0},prop="w_pi_combatpistol",name="weapon_combatpistol",label="COMBAT PISTOL",price=200,maxquantity = 1,},
            --     {coord={1.0, 0.34, 0.0, 0.0, 0.0, -90.0},prop="w_pi_pistol",name="weapon_pistol",label="PISTOL",price=100,maxquantity = 1,},
            --     {coord={-1.0, 0.34, 0.0, 0.0, 0.0, 90.0},prop="w_ar_advancedrifle",name="weapon_advancedrifle",label="ADVANCED RIFLE",price=800,maxquantity = 1,},
            --     {coord={-1.0, -0.64, 0.0, 0.0, 0.0, 90.0},prop="w_ar_carbinerifle",name="weapon_carbinerifle",label="CARBINE RIFLE",price=500,maxquantity = 1,},
            --     {coord={-1.0, -1.60, 0.0, 0.0, 0.0, 90.0},prop="w_sb_assaultsmg",name="weapon_assaultsmg",label="ASSAULT SMG",price=900,maxquantity = 1,},
            -- },
   
        },

        Item = {
            {
                {coord={0.8, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="bread",label="c4",price=1200, maxquantity = 1,
                    desc = "This powerful adhesive explosive is designed for sabotage and ambushes, offering remote detonation capabilities for precise and devastating outcomes."
                },
                {coord={0.3, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_gas_mask_hang_01bb",name="MASK",label="MASK",price=1200, maxquantity = 1,
                    desc = "Essential protection against toxic gases and harmful chemicals. Ideal for operations in hazardous environments and gas attacks."
                },
                {coord={-0.3, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.8, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },

                {coord={0.8, 0.0, 1.5, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={0.3, 0.0, 1.5, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.3, 0.0, 1.5, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.8, 0.0, 1.5, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },

                {coord={0.8, 0.0, 1.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={0.3, 0.0, 1.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.3, 0.0, 1.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.8, 0.0, 1.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },

                {coord={0.8, 0.0, 0.50, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={0.3, 0.0, 0.50, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.3, 0.0, 0.50, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
                {coord={-0.8, 0.0, 0.50, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
                   desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
                },
            }, 

            -- If you use "Config.RandomWeapons" you can add several sets of random items, here is an example:
            -- {
            --     {coord={0.8, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="bread",label="c4",price=1200, maxquantity = 1,
            --         desc = "This powerful adhesive explosive is designed for sabotage and ambushes, offering remote detonation capabilities for precise and devastating outcomes."
            --     },
            --     {coord={0.3, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_gas_mask_hang_01bb",name="MASK",label="MASK",price=1200, maxquantity = 1,
            --         desc = "Essential protection against toxic gases and harmful chemicals. Ideal for operations in hazardous environments and gas attacks."
            --     },
            --     {coord={-0.3, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
            --        desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
            --     },
            --     {coord={-0.8, 0.0, 2.0, 0.0, 0.0, 0.0},prop="prop_c4_final",name="c4",label="c4",price=1200, maxquantity = 1,
            --        desc = "High-powered adhesive explosive, ideal for sabotage and ambushes. Remote detonation for maximum precision and destruction."
            --     },
            -- },
        }
    },
}
