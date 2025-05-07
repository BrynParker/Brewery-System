--#NoSimplerr#
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Spawnable = false
ENT.Author = "niumikus"

ENT.Quality = 1
ENT.ABV = 0
ENT.Danger = 0
ENT.Model = "models/props_borealis/bluebarrel001.mdl"
ENT.IsNBrewIngredient = true

if SERVER then
    function ENT:Initialize()
        self:SetModel(self.Model)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)
        local phys = self:GetPhysicsObject()
        if phys:IsValid() then phys:Wake() end
    end
    function ENT:Use(activator)
        if not activator:IsPlayer() then return end
        NBrew_Ingredient_Use(activator,self)
    end
    function ENT:UpdateContent()
        NBrew_Update_Ingredient_Content(self)
    end
    function ENT:SpawnFunction(ply,tr,classname)
        if  not tr.Hit  then return end

        local pos = tr.HitPos
        local ang = ply:EyeAngles()
        ang.p = 0
        ang.y = ang.y + 180

        local ent = ents.Create( ClassName )
        ent:SetPos(pos)
        ent:SetAngles(ang)
        if not ent.Contents then ent.Contents = ent.SpawnContents else ent.Contents = {} end
        ent:Spawn()
        ent:Activate()

        return ent
    end
elseif CLIENT then
    function ENT:Initialize()
        self.Contents = {}
        NBrew_Request_Update_Ingredient_Content(self)
    end
    function ENT:Draw()
        self:DrawModel()
        NBrew_Ingredient_UI(self)
    end
end