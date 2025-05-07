--#NoSimplerr#
NBrew_Recipies = {
    nium_beer = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["hops"] = 0.3,
            ["malt"] = 20,
            ["yeast"] = 0.1,
        },
        logo = "barrel_beer_nium",
        processor = "nbrew_brewingbarrel"
    },
    shochu_mash = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["potato_mash"] = 100,
            ["water"] = 100,
            ["rice"] = 100,
            ["malt"] = 50,
            ["yeast"] = 0.1,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    mead = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["honey"] = 100,
            ["water"] = 100,
            ["yeast"] = 0.2,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    red_wine = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["grape_juice"] = 100,
            ["yeast"] = 0.1,
        },
        logo = "barrel_wine",
        processor = "nbrew_brewingbarrel"
    },
    cider = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["apple_juice"] = 100,
            ["yeast"] = 0.1,
        },
        logo = "barrel_wine",
        processor = "nbrew_brewingbarrel"
    },
    agave_juice_fermented = {
        modifiers = {
            time = 3
        },
        ingredients = {
            ["agave_juice"] = 100,
            ["water"] = 100,
            ["yeast"] = 0.1,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    potato_mash_fermented = {
        modifiers = {
            time = 3
        },
        ingredients = {
            ["potato_mash"] = 100,
            ["water"] = 100,
            ["yeast"] = 0.1,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    malt_fermented = {
        modifiers = {
            time = 3
        },
        ingredients = {
            ["malt"] = 100,
            ["barley"] = 50,
            ["yeast"] = 0.1,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    sugarcane_juice_fermented = {
        modifiers = {
            time = 3
        },
        ingredients = {
            ["sugarcane_juice"] = 100,
            ["yeast"] = 0.1,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    beer_pilsner = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["hops"] = 0.2,
            ["malt"] = 20,
            ["yeast"] = 0.1,
        },
        logo = "barrel_beer",
        processor = "nbrew_brewingbarrel"
    },
    beer_asar = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["hops"] = 0.5,
            ["malt"] = 40,
            ["yeast"] = 0.4,
        },
        logo = "barrel_beer",
        processor = "nbrew_brewingbarrel"
    },
    beer_ale_traditional = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["malt"] = 30,
            ["yeast"] = 0.1,
        },
        logo = "barrel_beer",
        processor = "nbrew_brewingbarrel"
    },
    beer_stout = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["barley"] = 22,
            ["hops"] = 0.3,
            ["yeast"] = 0.1,
        },
        logo = "barrel_beer",
        processor = "nbrew_brewingbarrel"
    },
    beer_stout_imperial = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["barley"] = 50,
            ["hops"] = 0.35,
            ["yeast"] = 0.1,
        },
        logo = "barrel_beer",
        processor = "nbrew_brewingbarrel"
    },
    beer_porter = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 100,
            ["malt"] = 30,
            ["hops"] = 0.8,
            ["yeast"] = 0.1,
        },
        logo = "barrel_beer",
        processor = "nbrew_brewingbarrel"
    },
    malt = {
        modifiers = {
            time = 2
        },
        ingredients = {
            ["water"] = 1,
            ["barley"] = 2,
        },
        logo = "barrel_default",
        processor = "nbrew_brewingbarrel"
    },
    grape_juice = {
        ingredients = {
            "grapes"
        },
        processor = "yb_grinder"
    },
    agave_juice = {
        ingredients = {
            "agave"
        },
        processor = "yb_grinder"
    },
    sugarcane_juice = {
        ingredients = {
            "sugarcane"
        },
        processor = "yb_grinder"
    },
    apple_juice = {
        ingredients = {
            "apples"
        },
        processor = "yb_grinder"
    },
    potato_mash = {
        ingredients = {
            "potatoes"
        },
        processor = "yb_grinder"
    },
    spirit_tequilla = {
        ingredients = {
            "agave_juice_fermented"
        },
        processor = "nbrew_distillery"
    },
    spirit_vodka = {
        ingredients = {
            "potato_mash_fermented"
        },
        processor = "nbrew_distillery"
    },
    spirit_rum = {
        ingredients = {
            "sugarcane_juice_fermented"
        },
        processor = "nbrew_distillery"
    },
    spirit_whiskey = {
        ingredients = {
            "malt_fermented"
        },
        processor = "nbrew_distillery"
    },
    spirit_shochu = {
        ingredients = {
            "shochu_mash"
        },
        processor = "nbrew_distillery"
    },
}

NBrew_HotTextures = {
    barrel_default = "niumikus/nbrew/barrel/barrelsinc",
    barrel_wine = "niumikus/nbrew/barrel/wine",
    barrel_beer_nium = "niumikus/nbrew/barrel/Niumpilsner",
    barrel_beer = "niumikus/nbrew/barrel/beer",
    barrel_age = "niumikus/nbrew/barrel/barrelage",
    barrel_age_wood = "niumikus/nbrew/barrel/barrelagewood",
    spiritbottle_orange = "niumikus/nbrew/spiritbottle/bottlemain",
    spiritbottle_grey = "niumikus/nbrew/spiritbottle/bottlegrey",
    spiritbottle_brown = "niumikus/nbrew/spiritbottle/bottlebrown",
    spiritbottle_blue = "niumikus/nbrew/spiritbottle/bottleblue",
    spiritbottle_white = "niumikus/nbrew/spiritbottle/bottlewhite",
    label_whiskey = "niumikus/nbrew/spiritbottle/label",
    label_rum = "niumikus/nbrew/spiritbottle/rum",
    label_tequilla = "niumikus/nbrew/spiritbottle/tequilla",
    label_vodka = "niumikus/nbrew/spiritbottle/vodka",
    label_shochu = "niumikus/nbrew/spiritbottle/shochu",
    label_default = "niumikus/nbrew/spiritbottle/default_label",
    wine_bottle_black = "niumikus/nbrew/winebottle/glass",
    wine_bottle_green = "niumikus/nbrew/winebottle/glassgreen",
    label_red_wine = "niumikus/nbrew/winebottle/label",
    label_cider = "niumikus/nbrew/winebottle/cider",
}

NBrew_Spawnables = {
    barrel = {
        icon = "materials/entities/nbrew_barrel.png",
        model = "models/props_borealis/bluebarrel001.mdl",
    },
    package = {
        icon = "materials/entities/nbrew_package.png",
        model = "models/props_junk/cardboard_box001a.mdl",
    },
    crate = {
        icon = "materials/entities/nbrew_crate.png",
        model = "models/props_junk/wood_crate001a.mdl",
    }
}

NBrew_Info = {
    nium_beer = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.05,
        logo = "beer_nium",
        color = Color(235, 187, 64, 240),
    },
    beer_asar = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.1,
        logo = "barrel_beer",
        color = Color(255, 208, 0, 240),
    },
    beer_ale_traditional = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.05,
        logo = "barrel_beer",
        color = Color(255, 166, 0, 240),
    },
    beer_stout = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.055,
        logo = "barrel_beer",
        color = Color(126, 80, 12, 240),
    },
    beer_stout_imperial = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.12,
        logo = "barrel_beer",
        color = Color(112, 84, 42, 240),
    },
    beer_porter = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.07,
        logo = "barrel_beer",
        color = Color(66, 52, 31, 240),
    },
    mead = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.20,
        logo = "barrel_default",
        color = Color(207, 124, 0, 240),
    },
    beer_pilsner = {
        ent = "nbrew_beer_finished",
        unit = "L",
        candanger = true,
        abv = 0.049,
        logo = "barrel_beer",
        color = Color(255, 208, 0, 240),
    },
    spirit_whiskey = {
        consumable = "nbrew_spirit_bottled",
        ent = "nbrew_agingbarrel",
        unit = "L",
        candanger = true,
        color = Color(228,170,12,240),
        materials = {
            ["spiritbottle_orange"] = "spiritbottle_orange",
            ["label_whiskey"] = "label_whiskey"
        }
    },
    spirit_rum = {
        consumable = "nbrew_spirit_bottled",
        ent = "nbrew_agingbarrel",
        unit = "L",
        candanger = true,
        color = Color(228,170,12,240),
        materials = {
            ["spiritbottle_orange"] = "spiritbottle_brown",
            ["label_whiskey"] = "label_rum"
        }
    },
    spirit_tequilla = {
        consumable = "nbrew_spirit_bottled",
        ent = "nbrew_agingbarrel",
        unit = "L",
        candanger = true,
        color = Color(228,170,12,240),
        materials = {
            ["spiritbottle_orange"] = "spiritbottle_blue",
            ["label_whiskey"] = "label_tequilla"
        }
    },
    spirit_vodka = {
        consumable = "nbrew_spirit_bottled",
        ent = "nbrew_agingbarrel",
        unit = "L",
        candanger = true,
        color = Color(228,170,12,240),
        materials = {
            ["spiritbottle_orange"] = "spiritbottle_grey",
            ["label_whiskey"] = "label_vodka"
        }
    },
    spirit_shochu = {
        consumable = "nbrew_spirit_bottled",
        ent = "nbrew_agingbarrel",
        unit = "L",
        candanger = true,
        color = Color(156,156,156,240),
        materials = {
            ["spiritbottle_orange"] = "spiritbottle_grey",
            ["label_whiskey"] = "label_shochu"
        }
    },
    red_wine = {
        ent = "nbrew_agingbarrel",
        consumable = "nbrew_wine_bottled",
        unit = "L",
        abv = 0.11,
        candanger = true,
        color = Color(70, 13, 20, 240)
    },
    cider = {
        ent = "nbrew_agingbarrel",
        consumable = "nbrew_wine_bottled",
        materials = {
            ["wine_bottle_black"] = "wine_bottle_green",
            ["label_red_wine"] = "label_cider"
        },
        unit = "L",
        abv = 0.11,
        candanger = true,
        color = Color(178, 255, 175, 240)
    },
    grape_juice = {
        ent = "nbrew_water",
        unit = "L",
        candanger = false,
        color = Color(87, 18, 64, 240)
    },
    agave_juice = {
        ent = "nbrew_water",
        unit = "L",
        candanger = false,
        color = Color(160, 190, 180, 240)
    },
    agave_juice_fermented = {
        ent = "nbrew_water",
        unit = "L",
        candanger = true,
        color = Color(121, 148, 139, 240)
    },
    malt = {
        ent = "nbrew_barley",
        unit = "Kg",
        candanger = false,
        color = Color(195, 179, 139, 240)
    },
    sugarcane_juice = {
        ent = "nbrew_water",
        unit = "L",
        candanger = false,
        color = Color(124, 212, 168, 240)
    },
    apple_juice = {
        ent = "nbrew_water",
        unit = "L",
        candanger = false,
        color = Color(124, 212, 168, 240)
    },
    sugarcane_juice_fermented = {
        ent = "nbrew_water",
        unit = "L",
        candanger = true,
        color = Color(65, 107, 86, 240)
    },
    potato_mash = {
        ent = "nbrew_water",
        unit = "L",
        candanger = false,
        color = Color(182, 154, 72, 240)
    },
    potato_mash_fermented = {
        ent = "nbrew_water",
        unit = "L",
        candanger = true,
        color = Color(129, 107, 39, 240)
    },
    malt_fermented = {
        ent = "nbrew_water",
        unit = "Kg",
        candanger = true,
        color = Color(136, 124, 95, 240)
    },
    shochu_mash = {
        ent = "nbrew_water",
        unit = "L",
        candanger = true,
        color = Color(141, 131, 107, 240)
    },
    sugarcane = {
        --ent is auto-generated for spawnable ingredients
        spawnable = {
            type = "package",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(61, 139, 100, 240)
    },
    potatoes = {
        spawnable = {
            type = "crate",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(139, 119, 61, 240)
    },
    grapes = {
        spawnable = {
            type = "package",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(212, 65, 65, 240)
    },
    agave = {
        spawnable = {
            type = "package",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(22, 179, 100, 240)
    },
    water = {
        spawnable = {
            type = "barrel",
            amount = 80,
        },
        unit = "L",
        candanger = false,
        color = Color(128, 197, 222, 240)
    },
    yeast = {
        spawnable = {
            type = "package",
            amount = 5,
        },
        unit = "Kg",
        candanger = false,
        color = Color(225, 198, 153, 240)
    },
    hops = {
        spawnable = {
            type = "package",
            amount = 10,
        },
        unit = "Kg",
        candanger = false,
        color = Color(159, 188, 126, 240)
    },
    barley = {
        spawnable = {
            type = "crate",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(223, 206, 163, 240)
    },
    honey = {
        spawnable = {
            type = "barrel",
            amount = 50,
        },
        unit = "L",
        candanger = false,
        color = Color(255, 183, 0, 240)
    },
    rice = {
        spawnable = {
            type = "package",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(177, 177, 177, 240)
    },
    apples = {
        spawnable = {
            type = "package",
            amount = 50,
        },
        unit = "Kg",
        candanger = false,
        color = Color(177, 177, 177, 240)
    },
}

NBrew_Loc = {
    apples = "Apples",
    apple_juice = "Apple juice",
    cider = "Apple Cider",
    rice = "Rice",
    shochu_mash = "Shochu Mash",
    spirit_shochu = "Shochu",
    malt_fermented = "Fermented Malt",
    sugarcane = "Sugarcane",
    sugarcane_juice = "Sugarcane Juice",
    sugarcane_juice_fermented = "Fermented S. Juice",
    potatoes = "Potatoes",
    potato_mash = "Potato Mash",
    potato_mash_fermented = "Fermented Potato Mash",
    agave_juice_fermented = "Fermented Agave Juice",
    red_wine = "Red Wine",
    agave = "Agave",
    agave_juice = "Agave Juice",
    grapes = "Red Grapes",
    grape_juice = "Grape Juice",
    spirit_whiskey = "Whiskey",
    spirit_vodka = "Vodka",
    spirit_rum = "Rum",
    spirit_tequilla = "Tequilla",
    beer_pilsner = "Pilsner",
    beer_ale_traditional = "Ale (Traditional)",
    beer_stout = "Stout",
    beer_stout_imperial = "Imperial Stout",
    beer_porter = "Porter",
    water = "Water",
    hops = "Hops",
    malt = "Malt",
    yeast = "Yeast",
    barley = "Barley",
    nium_beer = "Pilsner (Nium Pilsner)",
    beer_asar = "Beer (Asar)",
    honey = "Honey",
    mead = "Mead",
    nbrew_distillery = "Distillery",
    yb_grinder = "Fruit Press",
    nbrew_brewingbarrel = "Brewing Barrel",
}


hook.Add("PreGamemodeLoaded","NBrew_HooksAndSetups",function()
hook.Call("NBREW_Extensions")
hook.Call("NBrew_Generate_SENTs")
end)

--GENERATE SENT CLASSES
--[[

local E = {}
E.Type = "anim"
E.Base = "nbrew_ingredient_base"
--E.PrintName = "Agave"
E.Spawnable = true
E.Author = "niumikus"
E.Instructions = "An ingredient"
E.Category = "Niums Brewery"


--E.Model = "models/props_junk/cardboard_box001a.mdl"
--E.Contents = { ["agave"] = 50 }

for k,v in pairs(NBrew_Info) do
  if v.spawnable then
    local tab = table.Copy(E)
    tab.IconOverride = NBrew_Spawnables[v.spawnable.type].icon
    tab.PrintName = NBrew_Loc[k]
    tab.Model = NBrew_Spawnables[v.spawnable.type].model
    tab.SpawnContents = { [k] = v.spawnable.amount}
    local classname = "nbrew_" .. k
    NBrew_Info[k].ent = classname
    scripted_ents.Register(tab,classname)
    end
end]]
