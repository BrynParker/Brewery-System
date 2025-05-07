--#NoSimplerr#
include("shared.lua")

function ENT:Initialize()
    self:SetSequence("idle")
    self.Finish = 0
end

function ENT:Draw()
    self:DrawModel()
    if self:BeingLookedAtByLocalPlayer() then
        self:DrawUI()
    end
end

function ENT:Think()
    if self.Finish > CurTime() then
        self:SetCycle(math.sin(CurTime() * 2)) -- just visual
    end
end

local function OnGrinderStart()
    local ent = net.ReadEntity()
    ent.Finish = net.ReadDouble()
    ent.Start = CurTime()
end
net.Receive("NBrew_grinder_start", OnGrinderStart)

local activeGrinder, uiTime = nil, 0
function ENT:DrawUI()
    activeGrinder = self
    uiTime = CurTime() + 0.05
end

hook.Add("HUDPaint", "NBREW_Grinder_UI", function()
    if not IsValid(activeGrinder) or uiTime < CurTime() then return end

    local W = ScrW() / 4
    local wx = ScrW() / 2 - W / 2
    local H = ScrH() / 20
    local hy = ScrH() / 2 - H / 2

    local barw = ScrW() / 4.2
    local barwx = ScrW() / 2 - barw / 2
    local barh = ScrH() / 24
    local barhy = ScrH() / 2 - barh / 2

    draw.RoundedBox(16, wx, hy, W, H, Color(125, 125, 125, 240))
    if CurTime() > activeGrinder.Finish then return end

    local progress = 1 - (activeGrinder.Finish - CurTime()) / activeGrinder.NeededTime
    draw.RoundedBox(16, barwx, barhy, 24 + (barw - 24) * progress, barh, Color(21, 255, 0, 240))
end)
