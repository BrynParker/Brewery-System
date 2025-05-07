--#NoSimplerr#
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

function Process_base_ContentReceive()
    local ent = net.ReadEntity()
    local openUI = net.ReadBool()
    ent.IsLocked = net.ReadBool()
    ent.ShowStats = net.ReadBool()
    ent.currentquality = net.ReadFloat()
    ent.qualityprocess = net.ReadFloat()
    ent.qualityingredients = net.ReadFloat()
    local len = net.ReadUInt(16)
    local tab =  util.JSONToTable(util.Decompress(net.ReadData(len)))
    ent.Contents = tab.content
    ent.Qualities = tab.quality
    local total = 0
    ent.ratios = {}
    for k,v in pairs(ent.Contents) do
        total = total + v
    end
    for k,v in pairs(ent.Contents) do
        ent.ratios[k] = v / total
    end
    if openUI then
        ent:OpenUI()
    end
end

local nbrew_process_base_frame
local nbrew_process_base_frame_time
function ENT:OpenUI()
    if IsValid(nbrew_process_base_frame) then return end
    nbrew_process_base_frame_time = CurTime() + 1
    nbrew_process_base_frame = vgui.Create("DFrame")
    nbrew_process_base_frame:SetSize(350,400)
    nbrew_process_base_frame:Center()
    nbrew_process_base_frame:MakePopup()
    nbrew_process_base_frame:SetTitle("Brewing Barrel")
    nbrew_process_base_frame.Paint = function(se,w,h)
        draw.RoundedBox(8,0,0,w,h,Color(0,0,0,200))

        local offset = 50
        for k, v in pairs(self.ratios) do
            local len = v * 340
            local textoff = len / 2 + offset
            surface.SetDrawColor(NBrew_Info[k].color)
            surface.DrawRect(5,offset,40,len + 1)
            draw.DrawText(NBrew_Loc[k] .. " (" .. math.Round(self.Contents[k],1) .. NBrew_Info[k].unit .. " " .. math.Round(self.Qualities[k] * 100,0) .. "%Q)","DermaDefault",50,textoff-12,NBrew_Info[k].color)
            offset = offset + len
        end

        if self.ShowStats then
            draw.DrawText("Current Quality:    " .. math.Round(self.currentquality * 100) .. "%","DermaDefault",210,50,Color(255,255,255,255))
            draw.DrawText("Process Quality:    " .. math.Round(self.qualityprocess * 100) .. "%","DermaDefault",210,70,Color(255,255,255,255))
            draw.DrawText("Ingredient Quality: " .. math.Round(self.qualityingredients * 100) .. "%","DermaDefault",210,90,Color(255,255,255,255))
        end

        if nbrew_process_base_frame_time < CurTime() then
            net.Start("NBrew_Process_Base")
                net.WriteEntity(self)
                net.WriteBool(true)
                net.WriteBool(false)
                net.WriteBool(false)
                net.WriteBool(false)
            net.SendToServer()
            nbrew_process_base_frame_time = CurTime() + 0.8
        end
    end
    local lock = vgui.Create("DCheckBoxLabel",nbrew_process_base_frame)
    lock:SetPos(7,20)
    lock:SetChecked(self.IsLocked)
    lock:SetText("Lock")
    lock:SizeToContents()
    nbrew_process_base_frame.OnClose = function()
        net.Start("NBrew_Process_Base")
            net.WriteEntity(self) --self
            net.WriteBool(false) --send an update back
            net.WriteBool(true) --update the lock
            net.WriteBool(lock:GetChecked()) -- lockvar
            net.WriteBool(false) --dump contents
        net.SendToServer()
    end
    if not self.ShowStats then
        local dump = vgui.Create("DButton",nbrew_process_base_frame)
        dump:SetPos(260,350)
        dump:SetSize(80,40)
        dump:SetText("Dump Contents")
        dump.DoClick = function()
            lock:SetChecked(true)
            net.Start("NBrew_Process_Base")
                net.WriteEntity(self)
                net.WriteBool(true)
                net.WriteBool(false)
                net.WriteBool(false)
                net.WriteBool(true)
            net.SendToServer()
        end
    end
end

net.Receive("NBrew_Process_Base",Process_base_ContentReceive)