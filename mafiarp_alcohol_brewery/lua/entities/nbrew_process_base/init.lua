--#NoSimplerr#
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("NBrew_Process_Base")
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
    self.nextaction = 0
    self.currentquality = 0
    self.qualityprocess = 0
    self.qualityingredients = 0
    self.ratiosconsumption = {}
end

function ENT:Think()
    if not self.recipie or self.nextaction > CurTime() then return end
    self.nextaction = CurTime() + 1
    self:Process()
end

function ENT:Use(activator)
    if not activator:IsPlayer() then return end
    self:ContentToUser(activator,true)
end

function ENT:ContentToUser(player,openUI)
    local dat = util.Compress(util.TableToJSON({content = self.Contents,quality = self.Qualities}))
    net.Start("NBrew_Process_Base")
        net.WriteEntity(self)
        net.WriteBool(openUI)
        net.WriteBool(false)
        net.WriteBool(self.recipie and true or false)
        net.WriteFloat(self.currentquality)
        net.WriteFloat(self.qualityprocess)
        net.WriteFloat(self.qualityingredients)
        net.WriteUInt(#dat,16)
        net.WriteData(dat)
    net.Send(player)
end

function Process_base_ContentToUser(len,pl)
    local ent = net.ReadEntity()
    local sendback = net.ReadBool()
    local shouldlock = net.ReadBool()
    local lockstatus = net.ReadBool()
    if shouldlock then ent.IsLocked = lockstatus end
    if net.ReadBool() then
        ent:DumpContent()
    end
    if sendback then
        ent:ContentToUser(pl,false)
    end
end

net.Receive("NBrew_Process_Base",Process_base_ContentToUser)


function ENT:DumpContent()
    if self.recipie then return end
    if table.Count(self.Contents) != 1 then return end
    for k, v in pairs(self.Contents) do --this should only be one
        local ent = ents.Create(NBrew_Info[k].ent)
        ent:SetPos(self.DumpPos + self:GetPos())
        ent.Contents = {[k] = v}
        ent.Quality = self.Qualities[k]
        if NBrew_Info[k].candanger then
            ent.Danger = -math.min(ent.Quality + 0.5,1) * 2 + 2
        end
        if NBrew_Info[k].abv then
            ent.ABV = NBrew_Info[k].abv
        end
        ent:Spawn()
        if ent.PostEntityPaste then ent:PostEntityPaste() end
        self.IsLocked = false
        self.Contents[k] = nil
    end
end

function ENT:Process()
    local quantqual = self.Contents[self.recipie] * self.Qualities[self.recipie]
    local amnt = 0
    local done = false
    for k, v in pairs(self.Contents) do
        local ratio = self.ratiosconsumption[k]
        local consume = ratio * NBrew_Recipies[self.recipie].modifiers.time
        self.Contents[k] = v - consume
        amnt = amnt + consume
        if self.Contents[k] < 0 then
            done = true
        end
    end
    self.Contents[self.recipie] = self.Contents[self.recipie] + amnt
    quantqual = quantqual + amnt * self.qualityprocess * self.qualityingredients
    self.currentquality = quantqual / self.Contents[self.recipie]
    self.Qualities[self.recipie] = self.currentquality
    if done then
        local cont = self.Contents[self.recipie]
        self.Contents[self.recipie] = nil
        for k, v in pairs(self.Contents) do
            cont = cont + v
        end
        self.Contents = {}
        self.Contents[self.recipie] = cont
        self.recipie = nil
    end
end

function ENT:PostEntityPaste()
    self.nexttouch = 0
    self.nextaction = 0
    --self:SetModel(self.Model)
end

function ENT:StartProcess()
    local possible = {}
    for k, v in pairs(NBrew_Recipies) do
        if v.processor != self:GetClass() then continue end
        local can = true
        for ingredient, am in pairs(v.ingredients) do
            if not self.Contents[ingredient] then can = false break end
        end
        if can then table.insert(possible,k) end
    end
    if #possible == 0 then self.recipie = nil return end

    local recipie
    local s
    local scalePossible = {}

    for k, v in pairs (possible) do

        local scaleContent = 0
        for ing, cont in pairs(self.Contents) do
            if ing == v then continue end
            scaleContent = scaleContent + math.pow(cont,2)
        end
        scaleContent = math.sqrt(scaleContent)
        local amnt = 0
        for ing, cont in pairs(NBrew_Recipies[v].ingredients) do
            amnt = amnt + math.pow(cont,2)
        end
        scalePossible[v] = { scalar = scaleContent / math.sqrt(amnt) ,scalecontent = scaleContent }

    end

    for k, v in pairs(possible) do
        local amnt = 0
        local scalar = scalePossible[v].scalar
        for ing, cont in pairs(self.Contents) do
            if ing == v then continue end
            local shouldbe = (NBrew_Recipies[v].ingredients[ing] or 1) * scalar
            local diff = math.Round(shouldbe - cont,2)
            local mult = math.Round(cont / shouldbe,2)
            if mult < 1 then mult = 1 / mult end
            amnt = amnt + math.pow(diff * mult,2)
        end
        amnt = math.sqrt(amnt)
        if not s or amnt < s then s = amnt recipie = v end
    end
    self.qualityprocess = 1 / (s / scalePossible[recipie].scalecontent + 1)
    self.recipie = recipie
    if not self.Contents[recipie] then self.Contents[recipie] = 0 self.Qualities[self.recipie] = 0 end

    --maybe here? look comment below AAA

    local total_ingredients = 0
    self.qualityingredients = 1
    for k, v in pairs(self.Contents) do
        if k == self.recipie then continue end
        total_ingredients = total_ingredients + v
        self.qualityingredients = self.qualityingredients * self.Qualities[k]
    end

    for k, v in pairs(self.Contents) do
        self.ratiosconsumption[k] = v / total_ingredients
    end

    self.ratiosconsumption[self.recipie] = 0
    self:ChangeLogo()
end

function ENT:ChangeLogo()
    local mat = self:GetMaterials()
    local ind = table.KeyFromValue(mat,"niumikus/nbrew/barrel/logo")
    if not ind then return end
    self:SetSubMaterial(ind-1,NBrew_HotTextures[NBrew_Recipies[self.recipie].logo])
end


function ENT:StartTouch(ent)
    if self.nexttouch > CurTime() or self.IsLocked then return end
    self.nexttouch = CurTime() + 0.5
    --if baseclass.Get(ent:GetClass()).Base != "nbrew_ingredient_base" then return end
    if not ent.IsNBrewIngredient then return end

    for k, v in pairs(ent.Contents) do
        if not self.Contents[k] then self.Contents[k] = v self.Qualities[k] = ent.Quality continue end

        local amntself = self.Contents[k] * self.Qualities[k]
        self.Contents[k] = self.Contents[k] + v

        local qualamntself = self.Qualities[k] * amntself * (1 - ent.Danger or 0)
        local qualamntent = ent.Quality * v

        self.Qualities[k] = (qualamntself + qualamntent) / (amntself + v)
    end




    ent:Remove()
    self:StartProcess()
end

