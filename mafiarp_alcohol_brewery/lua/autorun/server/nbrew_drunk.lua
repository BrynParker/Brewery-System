util.AddNetworkString("NBrew_Passing_out")



function NBrew_Passout(len,ply)
    if ply.canPassOut and ply.canPassOut > CurTime() then return end
    local up = util.QuickTrace(Vector(0,0,0),Vector(0,0,9999999))
    if up.HitNonWorld then return end
    local z = up.HitPos.z
    local xa = util.TraceLine( {start = up.HitPos, endpos = up.HitPos + Vector(9999999,0,0)}).HitPos.x
    local xb = util.TraceLine( {start = up.HitPos, endpos = up.HitPos + Vector(-9999999,0,0)}).HitPos.x
    local ya = util.TraceLine( {start = up.HitPos, endpos = up.HitPos + Vector(0,9999999,0)}).HitPos.y
    local yb = util.TraceLine( {start = up.HitPos, endpos = up.HitPos + Vector(0,-9999999,0)}).HitPos.y

    local xpos = math.random(xa,xb)
    local ypos = math.random(ya,yb)

    local finpos = util.QuickTrace(Vector(xpos,ypos,z),Vector(0,0,-99999))
    ply:SetPos(finpos.HitPos)
end

net.Receive("NBrew_Passing_out",NBrew_Passout)

util.AddNetworkString("NBrew_SoberUp")
hook.Add("PlayerDeath","NBrew_SoberUp",function(ply)
    ply.canPassOut = CurTime() + 30
    net.Start("NBrew_SoberUp")
    net.Send(ply)
end)