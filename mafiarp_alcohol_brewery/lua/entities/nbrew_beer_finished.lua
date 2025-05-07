--#NoSimplerr#
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nbrew_ingredient_base"
ENT.PrintName = "Beer"
ENT.Spawnable = false
ENT.Author = "niumikus"
ENT.Instructions = "None"
ENT.Category = "Niums Brewery"
ENT.Model = "models/niumikus/nbrew/barrel.mdl"
ENT.Contents = {}
ENT.IsNBrewIngredient = false

if SERVER then
    function ENT:PostEntityPaste()
        local mat = self:GetMaterials()
        local ind = table.KeyFromValue(mat,"niumikus/nbrew/barrel/logo")
        if not ind then return end
        local cont = table.GetKeys(self.Contents)[1]
        self:SetSubMaterial(ind-1,NBrew_HotTextures[NBrew_Info[cont].logo])
        self.ABV = NBrew_Info[cont].abv
    end
end