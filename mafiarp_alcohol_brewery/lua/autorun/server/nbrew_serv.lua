--#NoSimplerr#

util.AddNetworkString("NBrew_TakeFromIngredient")
function NBrew_Ingredient_Use(activator,ent)
    net.Start("NBrew_TakeFromIngredient")
        net.WriteEntity(ent)
    net.Send(activator)
end


util.AddNetworkString("NBrew_UpdateIngredient")

function NBrew_SplitIngredient()
    local ent = net.ReadEntity()
    local amount = net.ReadDouble()

    local max = 0
    for k,v in pairs(ent.Contents) do
        max = max + v
    end

    if amount == max or amount == 0 then return end

    local percent = amount / max

    local newent = ents.Create(ent:GetClass())
    newent:SetPos(ent:GetPos() + Vector(0,0,50))
    local newenttable = {}
    for k,v in pairs(ent.Contents) do
        local share = math.Round(v * percent,1)
        ent.Contents[k] = math.Round(v - share,1) --rounding so much due to floating point inaccuracy
        newenttable[k] = math.Round(share,1)
    end
    newent.Contents = newenttable
    newent.Quality = ent.Quality
    newent.Danger = ent.Danger
    newent.ABV = ent.ABV
    newent:Initialize()
    newent:Spawn()


    NBrew_Update_Ingredient_Content(ent)
    --NBrew_Update_Ingredient_Content(newent) Done in Initialization on clientside

end


net.Receive("NBrew_TakeFromIngredient",NBrew_SplitIngredient)


function NBrew_Update_Ingredient_Content(self)
    net.Start("NBrew_UpdateIngredient")
        net.WriteEntity(self)
        net.WriteFloat(self.Quality)
        net.WriteFloat(self.Danger)
        net.WriteFloat(self.ABV)
        local data = util.Compress(util.TableToJSON(self.Contents))
        net.WriteUInt(#data,16)
        net.WriteData(data)
    net.Broadcast()
end

function NBrew_UpdateIngredient()
    local ent = net.ReadEntity()
    NBrew_Update_Ingredient_Content(ent)
end

net.Receive("NBrew_UpdateIngredient",NBrew_UpdateIngredient)


