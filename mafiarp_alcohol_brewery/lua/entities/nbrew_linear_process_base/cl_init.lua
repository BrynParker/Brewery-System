--#NoSimplerr#
include("shared.lua")

ENT.Finish = 0
ENT.Start = 0
function ENT:Initialize()
    self:SetSequence(0)
end

function ENT:Draw()
    self:DrawModel()
    if self:BeingLookedAtByLocalPlayer() then
        self:DrawUI()
    end
end

function ENT:Think()
    if CurTime() < self.Finish then
        self:SetCycle(math.sin(CurTime() * 2))
    end
end

function NBrew_linear_process_base()
    local ent = net.ReadEntity()
    ent.Finish = net.ReadDouble()
    ent.Start = CurTime()
end
net.Receive("NBrew_linear_process_base",NBrew_linear_process_base)

NBREW_LINEAR_PROCESS_BASE_ENT = nil
NBREW_LINEAR_PROCESS_BASE_TIME = 0

function ENT:DrawUI()
    NBREW_LINEAR_PROCESS_BASE_TIME = CurTime() + 0.05
    NBREW_LINEAR_PROCESS_BASE_ENT = self
end

hook.Add("HUDPaint","NBREW_linear_process",function()
    if not IsValid(NBREW_LINEAR_PROCESS_BASE_ENT) or NBREW_LINEAR_PROCESS_BASE_TIME < CurTime() then return end
    local W = ScrW() / 4
    local wx = ScrW() / 2 - W / 2
    local H = ScrH() / 20
    local hy = ScrH() / 2 - H / 2

    local barw = ScrW() / 4.2
    local barwx =  ScrW() / 2 - barw / 2
    local barh = ScrH() / 24
    local barhy = ScrH() / 2 - barh / 2
    draw.RoundedBox(16,wx,hy,W,H,Color(125,125,125,240))
    if CurTime() > NBREW_LINEAR_PROCESS_BASE_ENT.Finish then return end
    draw.RoundedBox(16,barwx,barhy,24 + (barw-24) * ( 1 - (NBREW_LINEAR_PROCESS_BASE_ENT.Finish - CurTime()) / NBREW_LINEAR_PROCESS_BASE_ENT.NeededTime),barh,Color(21,255,0,240))
end)