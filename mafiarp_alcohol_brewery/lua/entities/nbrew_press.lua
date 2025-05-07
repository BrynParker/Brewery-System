--#NoSimplerr#
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nbrew_linear_process_base"
ENT.PrintName = "Fruit Press"
ENT.Spawnable = true
ENT.Author = "niumikus"
ENT.Instructions = "A Fruit Press!"
ENT.Category = "Niums Brewery"
ENT.Model = "models/zerochain/props_yeastbeast/yb_grinder.mdl"


function ENT:Initialize()
    self.BaseClass.Initialize(self)
    self:SetSequence("idle")
    self.AutomaticFrameAdvance = false -- We'll manually advance
    self.finish = 0
end

function ENT:StartTouch(ent)
    local prevRecipe = self.recipie
    self.BaseClass.StartTouch(self, ent)

    if not prevRecipe and self.recipie then
        local seq = self:LookupSequence("spin")
        if seq ~= -1 then
            self:ResetSequence(seq)
            print("[nbrew_press] Playing animation: spin (seq #" .. seq .. ")")
        else
            print("[nbrew_press] Animation 'spin' not found!")
        end
    end
end

function ENT:Think()
    self.BaseClass.Think(self)

    -- Manually advance animation frame
    self:FrameAdvance(FrameTime())

    -- Reset to idle if processing is done
    if self.recipie == nil and self:GetSequenceName(self:GetSequence()) ~= "idle" then
        self:ResetSequence("idle")
    end

    self:NextThink(CurTime())
    return true
end
