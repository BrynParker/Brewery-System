--#NoSimplerr#
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
    self:SetModel(self.Model)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
    self.nexttouch = 0
    self.finish = 0
    self.nextaction = 0
end



util.AddNetworkString("NBrew_linear_process_base")


function ENT:Think()
    if not self.recipie or self.nextaction > CurTime() then return end
    self.nextaction = CurTime() + 1
    self:Process()
end

function ENT:Process()
    if CurTime() > self.finish then
        local ent = ents.Create(NBrew_Info[self.recipie].ent)
        ent:SetPos(self.DumpPos + self:GetPos())
        ent.Contents = {[self.recipie] = self.Amount}
        ent.Quality = self.quality
        if NBrew_Info[self.recipie].candanger then
            ent.Danger = -math.min(ent.Quality + 0.5,1) * 2 + 2
        end
        ent:Spawn()
        if ent.PostEntityPaste then ent:PostEntityPaste() end
        self.recipie = nil
    end
end

function ENT:StartTouch(ent)
    if self.recipie then return end
    if not ent.IsNBrewIngredient then return end
    local cont, amnt
    for k, v in pairs(ent.Contents) do
        cont = k
        amnt = v
    end

    for k, v in pairs(NBrew_Recipies) do
        if not (v.processor == self:GetClass()) or table.Count(v.ingredients) != 1 then continue end
        if v.ingredients[1] == cont then
            self.recipie = k
            break
        end
    end
    if not self.recipie then return end
    self.content = cont
    self.Amount = amnt
    self.quality = ent.Quality

    self.finish = CurTime() + 10

    ent:Remove()

    net.Start("NBrew_linear_process_base")
        net.WriteEntity(self)
        net.WriteDouble(self.finish)
    net.Broadcast()
end

