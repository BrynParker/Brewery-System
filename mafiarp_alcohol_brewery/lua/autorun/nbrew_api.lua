

function NBrew_AddRecipie(tab)
    for k, v in pairs(tab) do
        NBrew_Recipies[k] = v
    end
end

function NBrew_AddLoc(tab)
    for k, v in pairs(tab) do
        NBrew_Loc[k] = v
    end
end

function NBrew_AddIngredient(tab)
    for k, v in pairs(tab) do
        NBrew_Info[k] = v
    end
end

function NBrew_AddSpawnable(tab)
    for k, v in pairs(tab) do
        NBrew_Spawnables[k] = v
    end
end

function NBrew_AddHotTexture(tab)
    for k, v in pairs(tab) do
        NBrew_HotTextures[k] = v
    end
end