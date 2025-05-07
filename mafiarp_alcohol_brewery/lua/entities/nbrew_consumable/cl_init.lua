--#NoSimplerr#
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    self:SetSequence(0)
    self:SetCycle(1)
end

function ENT:Think()
    self:SetCycle(self.FillLevel)
end

function NBrew_ReceiveDrink()
    local abv = net.ReadFloat()
    NBrew_Drunkness = NBrew_Drunkness + abv * 0.5
end

function NBrew_ReceiveFillLevel()
    local ent = net.ReadEntity()
    ent.FillLevel = net.ReadFloat()
end

net.Receive("NBrew_SetFillLevel",NBrew_ReceiveFillLevel)

net.Receive("NBrew_ConsumableTrigger",NBrew_ReceiveDrink)