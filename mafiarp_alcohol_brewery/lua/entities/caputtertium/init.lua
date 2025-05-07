--#NoSimplerr#
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("NBREW_CAPUTTERTIUM")

function ENT:Initialize()
    self:SetModel("models/niumikus/nbrew/caputtertium.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:Use(ply)
    if not ply:IsPlayer() then return end
    net.Start("NBREW_CAPUTTERTIUM")
    net.Send(ply)
end