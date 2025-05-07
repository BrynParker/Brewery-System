--#NoSimplerr#
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nbrew_ingredient_base"
ENT.PrintName = "Aging Barrel"
ENT.Spawnable = false
ENT.Author = "niumikus"
ENT.Instructions = "An ingredient"
ENT.Category = "Niums Brewery"
ENT.Model = "models/niumikus/nbrew/barrel.mdl"
ENT.Contents = {}
ENT.IsNBrewIngredient = false
ENT.ABV = 0.4
if CLIENT then return end

function ENT:Initialize()
    self:SetModel("models/niumikus/nbrew/barrel.mdl")
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    self:SetSubMaterial(0,NBrew_HotTextures["barrel_age"])
    self:SetSubMaterial(1,NBrew_HotTextures["barrel_age_wood"])
    self:SetSubMaterial(2,NBrew_HotTextures["barrel_age_wood"])
    local phys = self:GetPhysicsObject()
    phys:SetMass(40)
    if phys:IsValid() then phys:Wake() end
end

function ENT:Use()
    local contkey = table.GetKeys(self.Contents)[1]
    if not NBrew_Info[contkey].consumable then return end
    local ent = ents.Create(NBrew_Info[contkey].consumable)
    ent:SetPos(Vector(0,0,50) + self:GetPos())
    self.Contents[contkey] = self.Contents[contkey] - 1
    ent.content = contkey
    ent.ABV = self.ABV
    ent.Danger = self.Danger
    ent.Sips = 3
    ent:Spawn()
    if self.Contents[contkey] < 1 then
        self:Remove()
    else
        self:UpdateContent()
    end
end

