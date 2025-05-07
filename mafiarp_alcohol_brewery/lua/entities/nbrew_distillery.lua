--#NoSimplerr#
AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "nbrew_ingredient_base"
ENT.PrintName = "Distillery"
ENT.Spawnable = true
ENT.Author = "niumikus"
ENT.Instructions = "An ingredient"
ENT.Category = "Niums Brewery"
ENT.Model = "models/zerochain/props_yeastbeast/yb_distillery_cooler.mdl"
ENT.Contents = {}
ENT.IsNBrewIngredient = false
ENT.nextThink = 0
ENT.nextamount = 0
ENT.totaldanger = 0
ENT.totalabv = 0
ENT.startAmount = 0
ENT.Amount = 0
ENT.adddangertime = 0
ENT.ABVIN = 0
if CLIENT then return end

function ENT:Use()
    if not self.recipie then return end
    if self.nextamount == 0 then return end
    local ent = ents.Create(NBrew_Info[self.recipie].ent)
    ent:SetPos(self:GetRight() * 80 + self:GetPos())
    ent.Contents = {[self.recipie] = self.nextamount}
    self.nextamount = 0
    ent.Quality = self.Quality
    ent.Danger = self.Danger
    ent.ABV = self.ABV
    self.totaldanger = 0
    self.totalabv = 0
    if self.Amount == 0 then
        self.Contents = {}
        self.recipie = nil
    end
    self:UpdateContent()
    ent:Spawn()
    ent:UpdateContent()
    if ent.PostEntityPaste then ent:PostEntityPaste() end
end

function ENT:Think()
    if not self.recipie or CurTime() < self.nextThink then return end
    self.nextThink = CurTime() + 1
    if self.Amount > 0 then
        local min = math.min(1,self.Amount)
        self.Amount = math.Round(self.Amount - min,1)
        self.nextamount = self.nextamount + min
        self.totaldanger = self.totaldanger  + math.max((0.20 + self.adddangertime * 0.5) - ((self.startAmount - self.Amount) / self.startAmount),0) * 2 * (1 / self.qualitymult) * math.max(1 - math.max(self.ABVIN - self.adddangertime * 4,0) * 2,0)
        self.totalabv = self.totalabv + math.max(0.9 - ((self.startAmount - self.Amount) / self.startAmount),0.10)
        self.ABV = self.totalabv / self.nextamount
        self.Danger = self.totaldanger / self.nextamount
        self.Danger = math.min(self.Danger,1)
        self.Contents = {
            [self.content] = self.Amount,
            [self.recipie] = self.nextamount
        }
        self:UpdateContent()
    end

end

function ENT:StartTouch(ent)
    if self.recipie then return end
    if not ent.IsNBrewIngredient or table.Count(ent.Contents) != 1 then return end
    local cont, amnt
    for k, v in pairs(ent.Contents) do
        cont = k
        amnt = v
    end

    for k, v in pairs(NBrew_Recipies) do
        if not (v.processor == self:GetClass()) or (table.Count(v.ingredients) != 1) then continue end
        if v.ingredients[1] == cont then
            self.recipie = k
            break
        end
    end
    if not self.recipie then return end
    self.content = cont
    self.Amount = amnt
    self.startAmount = amnt
    self.qualitymult = ent.Quality
    self.Quality = ent.Quality
    self.adddangertime = ent.Danger
    self.ABVIN = ent.ABV or 0
    self.Danger = 0
    self.Contents = {
        [self.content] = self.Amount,
        [self.recipie] = self.nextamount
    }
    ent:Remove()
    self:UpdateContent()
end
