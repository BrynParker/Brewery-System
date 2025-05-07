--#NoSimplerr#

list.Set( "ContentCategoryIcons", "Niums Brewery", "niumikus/nbrew/categoryicon.png" )

function NBrew_UpdateIngredient()
    local ent = net.ReadEntity()
    ent.Quality = net.ReadFloat()
    ent.Danger = net.ReadFloat()
    ent.ABV = net.ReadFloat()
    local length = net.ReadUInt(16)
    local tab = util.JSONToTable(util.Decompress(net.ReadData(length)))
    ent.Contents = tab
end

net.Receive("NBrew_UpdateIngredient", NBrew_UpdateIngredient)

function NBrew_Request_Update_Ingredient_Content(self)
    net.Start("NBrew_UpdateIngredient")
        net.WriteEntity(self)
    net.SendToServer()
end