function NBREW_DEFAULT_SENT_GENERATION()
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
    end

end

hook.Add("NBrew_Generate_SENTs","NBREW_DEFAULT_SENT_GENERATION",NBREW_DEFAULT_SENT_GENERATION)