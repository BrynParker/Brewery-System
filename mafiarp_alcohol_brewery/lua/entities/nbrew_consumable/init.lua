--#NoSimplerr#
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("NBrew_ConsumableTrigger")

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local mat = self:GetMaterials()
    if self.content and NBrew_Info[self.content].materials then
        for k, v in pairs(NBrew_Info[self.content].materials) do
            local ind = table.KeyFromValue(mat,NBrew_HotTextures[k])
            self:SetSubMaterial(ind-1,NBrew_HotTextures[v])
        end
    end
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end
end


function ENT:StartTouch(ent)
    if self.Sips != 0 or ent:GetClass() != self.RefillFrom then return end
    local contkey = table.GetKeys(ent.Contents)[1]
    ent.Contents[contkey] = ent.Contents[contkey] - 1
    self.ABV = ent.ABV
    self.Danger = ent.Danger
    if ent.Contents[contkey] < 1 then
        ent:Remove()
    else
        ent:UpdateContent()
    end
    self.Sips = 3
    self:FillLevel(1)
end

util.AddNetworkString("NBrew_SetFillLevel")

function ENT:FillLevel(level)
    net.Start("NBrew_SetFillLevel")
    net.WriteEntity(self)
    net.WriteFloat(level)
    net.Broadcast()
end


function ENT:Use(activator)
    if not activator:IsPlayer() or self.Sips == 0 then return end
    net.Start("NBrew_ConsumableTrigger")
        net.WriteFloat(self.ABV * self.Capacity)
    net.Send(activator)
    if self.Danger and self.Danger != 0 then activator:TakeDamage(self.Danger * 33) end
    self.Sips = self.Sips - 1
    self:FillLevel(self.Sips / self.MAXSips)
    if self.DestroyConsumption and self.Sips == 0 then self:Remove() end
end
