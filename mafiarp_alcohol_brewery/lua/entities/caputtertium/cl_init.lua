--#NoSimplerr#
include("shared.lua")

function ENT:Draw()
    self:DrawModel()
end

local NBREW_CAPUTTERTIUM_FRAME


local NBREW_EXTENSIONS_OFFICIAL = {
    {
        name = "Niums Extra Spirits",
        desc = "Adds new Spirits, Models and White Wine!",
        URL = "https://steamcommunity.com/sharedfiles/filedetails/?id=3197670991",
    }
}


function NBREW_CAPUTTERTIUM()
    if IsValid(NBREW_CAPUTTERTIUM_FRAME) then return end
    NBREW_CAPUTTERTIUM_FRAME = vgui.Create("XPFrame")
    NBREW_CAPUTTERTIUM_FRAME:SetTitle("Jim's Recipe Book")
    NBREW_CAPUTTERTIUM_FRAME:SetSize(ScrW() / 6,ScrH() / 2)
    NBREW_CAPUTTERTIUM_FRAME:Center()
    NBREW_CAPUTTERTIUM_FRAME:MakePopup()

    local sheet = vgui.Create("XPPropertySheet",NBREW_CAPUTTERTIUM_FRAME)
    sheet:Dock(FILL)


    local recipies_panel = vgui.Create("DPanel",sheet) --recipies panel
    recipies_panel:Dock(FILL)

    local quicksearch = vgui.Create("XPTextEntry",recipies_panel) --quicksearch bar for recipies
    quicksearch:SetPlaceholderText("Quick Search")
    quicksearch:Dock(TOP)
    quicksearch:DockMargin(4,4,4,4)

    local recipies = vgui.Create("XPCategoryList",recipies_panel) --category lists
    recipies:Dock(FILL)
    local catalogue = vgui.Create("XPCategoryList",sheet)
    catalogue:Dock(FILL)

    local filter = ""

    local function PopulateRECIPIES() --function to populate recipie category list
        recipies:Clear()
        for k, v in pairs(NBrew_Recipies) do
            if not string.StartsWith(string.lower(NBrew_Loc[k]),string.lower(filter)) then continue end
            local re = recipies:Add(NBrew_Loc[k])
            local panel = vgui.Create("DPanel")
            local l = vgui.Create("DLabel",panel)
            l:Dock(TOP)
            l:DockMargin(8,0,0,0)
            l:SetColor(Color(250,250,250))
            l:SetText("Ingredients: (Used in: " .. NBrew_Loc[v.processor] .. ")")
            for m, n in pairs(v.ingredients) do
                local ing = vgui.Create("DLabel",panel)
                ing:Dock(TOP)
                ing:DockMargin(4,0,0,0)
                ing:SetColor(Color(250,250,250))
                ing:SetText(NBrew_Loc[isstring(m) and m or n])
            end
            re:SetExpanded(true)
            re:SetContents(panel)
        end

    end

    PopulateRECIPIES()

    quicksearch.OnTextChanged = function() --re-populate when filter is changed
        filter = quicksearch:GetText()
        PopulateRECIPIES()
    end




    local catalogue_spirits = catalogue:Add("Bottled") --Add spirits category to catalogue categorylist
    local cat_spir = vgui.Create("DPanel")
    for k, v in pairs(NBrew_Info) do
        if not v.consumable then continue end
        local l = vgui.Create("DLabel",cat_spir)
        l:Dock(TOP)
        l:DockMargin(4,0,4,0)
        l:SetColor(Color(250,250,250))
        l:SetText(NBrew_Loc[k])
    end
    catalogue_spirits:SetContents(cat_spir) --set contents of this category to that list


    local catalogue_brewed = catalogue:Add("Barrelled") --Add beerbarrel category to catalogue categorylist

    local cat_brew = vgui.Create("DPanel")
    for k, v in pairs(NBrew_Info) do
        if (v.ent or "") != "nbrew_beer_finished" then continue end
        local l = vgui.Create("DLabel",cat_brew)
        l:Dock(TOP)
        l:DockMargin(4,0,4,0)
        l:SetColor(Color(250,250,250))
        l:SetText(NBrew_Loc[k])
    end

    catalogue_brewed:SetContents(cat_brew)




    sheet:AddSheet("Recipes",recipies_panel)
    sheet:AddSheet("Catalogue",catalogue)
    --sheet:AddSheet("Extensions",extensions)


end

net.Receive("NBREW_CAPUTTERTIUM",NBREW_CAPUTTERTIUM)