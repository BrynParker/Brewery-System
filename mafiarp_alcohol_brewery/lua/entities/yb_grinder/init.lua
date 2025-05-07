--#NoSimplerr#
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("NBrew_grinder_start")

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        phys:Wake()
    end

    self.finish = 0
    self.recipie = nil
    self.AutomaticFrameAdvance = false
end

function ENT:Think()
    self:FrameAdvance(FrameTime()) -- Animate manually

    if self.recipie and CurTime() > self.finish then
        -- Spawn product
        local info = NBrew_Info[self.recipie]
        local ent = ents.Create(info.ent)
        ent:SetPos(self:GetPos() + self.DumpPos)
        ent.Contents = {[self.recipie] = self.Amount}
        ent.Quality = self.quality
        if info.candanger then
            ent.Danger = -math.min(ent.Quality + 0.5, 1) * 2 + 2
        end
        ent:Spawn()
        if ent.PostEntityPaste then ent:PostEntityPaste() end

        -- Reset
        self.recipie = nil
        self:ResetSequence("idle")
    end

    self:NextThink(CurTime())
    return true
end

function ENT:StartTouch(ent)
    if self.recipie or not ent.IsNBrewIngredient then return end

    local cont, amnt
    for k, v in pairs(ent.Contents) do
        cont = k
        amnt = v
    end

    for k, v in pairs(NBrew_Recipies) do
        if v.processor ~= self:GetClass() or #v.ingredients ~= 1 then continue end
        if v.ingredients[1] == cont then
            self.recipie = k
            break
        end
    end

    if not self.recipie then return end

    self.Amount = amnt
    self.quality = ent.Quality
    self.finish = CurTime() + self.NeededTime

    -- Play spin animation
    self:ResetSequence("spin")

    ent:Remove()

    -- Send info to client
    net.Start("NBrew_grinder_start")
        net.WriteEntity(self)
        net.WriteDouble(self.finish)
    net.Broadcast()
end
