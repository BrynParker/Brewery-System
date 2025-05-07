--#NoSimplerr#

NBREW_INGREDIENT_UI_INFO = {time = 0, entity = nil}
function NBrew_Ingredient_Tooltip(self)
    --local trace = LocalPlayer():GetEyeTrace()
    --AddWorldTip(nil, str, SysTime() + 0.05, trace["HitPos"])
    NBREW_INGREDIENT_UI_INFO.entity = self
    NBREW_INGREDIENT_UI_INFO.time = CurTime() + 0.05
end

hook.Add("HUDPaint","NBREW_IngredientUI",function()
    if NBREW_INGREDIENT_UI_INFO.time > CurTime() and IsValid(NBREW_INGREDIENT_UI_INFO.entity) then
        local w = ScrW()
        local wx = w / 2 - w / 12
        local width = w - (wx * 2)
        local h = ScrH()
        local hx = h / 2 - ScrH() / 5
        local height = h - (hx * 2)
        draw.RoundedBox(16,wx,hx,width,height,Color(139,139,129,238))

        local cury = 24
        for k, v in pairs(NBREW_INGREDIENT_UI_INFO.entity.Contents) do
            local ingredient = NBrew_Loc[k] .. ": "
            local amount = v .. NBrew_Info[k].unit
            draw.DrawText(ingredient,"Trebuchet24",wx + 24,hx + cury,Color(255,255,255),TEXT_ALIGN_LEFT)
            draw.DrawText(amount,"Trebuchet24",wx + width -24,hx + cury,Color(255,255,255),TEXT_ALIGN_RIGHT)
            cury = cury + 24 + 8
        end

        local side_wx = wx + width + wx / 12
        local side_width = width
        local side_height = height / 2

        draw.RoundedBox(16,side_wx,hx,side_width,side_height,Color(139,139,129,238))
        draw.DrawText("Quality: " .. math.Round(NBREW_INGREDIENT_UI_INFO.entity.Quality * 100) .. "%","Trebuchet24",side_wx + 24, hx + 24)
        draw.DrawText("Danger: " .. math.Round(NBREW_INGREDIENT_UI_INFO.entity.Danger * 100) .. "%","Trebuchet24",side_wx + 24, hx + 56)
        if NBREW_INGREDIENT_UI_INFO.entity.ABV != 0 then
            draw.DrawText("ABV    : " .. math.Round(NBREW_INGREDIENT_UI_INFO.entity.ABV * 100) .. "%","Trebuchet24",side_wx + 24, hx + 88)
        end

        --draw.RoundedBox(16,side_wx + side_width / 2,hx + 24,(side_width - (side_width / 2) - 24 ) * NBREW_INGREDIENT_UI_INFO.entity.Quality + 12,24,Color(81 * (1-NBREW_INGREDIENT_UI_INFO.entity.Quality) + 81,110 * NBREW_INGREDIENT_UI_INFO.entity.Quality + 110,158,238))
        --draw.RoundedBox(16,side_wx + side_width / 2,hx + 56,(side_width - (side_width / 2) - 24 ) * NBREW_INGREDIENT_UI_INFO.entity.Danger + 12,24,Color(81 * NBREW_INGREDIENT_UI_INFO.entity.Danger + 81,110 * (1 - NBREW_INGREDIENT_UI_INFO.entity.Danger) + 110,158,238))
    end
end)

function NBrew_Ingredient_UI(self)
    if self:BeingLookedAtByLocalPlayer() then
        NBrew_Ingredient_Tooltip(self)
    end
end




local NBrew_ingredients_frame
function NBrew_TakeFrom()
    local ent = net.ReadEntity()

    if IsValid(NBrew_ingredients_frame) then return end

    NBrew_ingredients_frame = vgui.Create("DFrame")
    NBrew_ingredients_frame:SetTitle("How Much to Split?")
    NBrew_ingredients_frame:SetSize(200,100)
    NBrew_ingredients_frame:Center()
    NBrew_ingredients_frame:MakePopup()

    local wang = vgui.Create("DNumberWang",NBrew_ingredients_frame)
    wang:HideWang()
    wang:SetSize(100,30)
    wang:Center()
    wang:SetMin(0)
    local max = 0
    for k,v in pairs(ent.Contents) do
        max = max + v
    end
    wang:SetMax(max)

    local button = vgui.Create("DButton",NBrew_ingredients_frame)
    button:SetSize(100,25)
    button:SetPos(50,70)
    button:SetText("Confirm")
    button.DoClick = function()
        NBrew_ingredients_frame:Close()
        if wang:GetValue() > 0 and wang:GetValue() < max then
            net.Start("NBrew_TakeFromIngredient")
               net.WriteEntity(ent)
               net.WriteDouble(math.Round(wang:GetValue(),1))
            net.SendToServer()
        end
    end


end

net.Receive("NBrew_TakeFromIngredient",NBrew_TakeFrom)