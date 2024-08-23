journal_entries = {
    {
        id = "entry_1",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_1",
        -- description supports color tags (ARGB) <c ffff0000>, which will color everything after it, until the next color tag or the end of a line.
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_1",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_2",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_2",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_2",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_3",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_3",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_3",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_4",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_4",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_4",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_5",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_5",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_5",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_6",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_6",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_6",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_7",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_7",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_7",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    {
        id = "entry_8",
        category = "Alchemist's Diary",
        title = "$bookname_glimmers_expanded_hidden_alchemy_8",
        description = "$bookdesc_glimmers_expanded_hidden_alchemy_8",
        unlocked_default = true,
        generate_notes = false,
        icon = nil,
    },
    -- Alchemy
    -- {
    --     id = "gate_opener_recipe",
    --     category = "Alchemy",
    --     title = "gate opener title",
    --     description = "gate opener desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- {
    --     id = "australium_recipe",
    --     category = "Alchemy",
    --     title = "australium title",
    --     description = "australium desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- Materials
    -- {
    --     id = "gate_opener",
    --     category = "Materials",
    --     title = "gate opener title",
    --     description = "gate opener desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- {
    --     id = "australium",
    --     category = "Materials",
    --     title = "australium title",
    --     description = "australium desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- {
    --     id = "lava",
    --     category = "Materials",
    --     title = "lava title",
    --     description = "lava desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- {
    --     id = "pus",
    --     category = "Materials",
    --     title = "pus title",
    --     description = "pus desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- {
    --     id = "urine",
    --     category = "Materials",
    --     title = "urine title",
    --     description = "urine desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    -- {
    --     id = "flummoxium",
    --     category = "Materials",
    --     title = "flummoxium title",
    --     description = "flummoxium desc",
    --     unlocked_default = true,
    --     generate_notes = false,
    --     icon = nil,
    -- },
    --[[{
        id = "test_entry",
        category = "Materials",
        title = "$mat_mm_ephemeral_ether",
        description = "$desc_mm_ephemeral_ether",    
        custom_unlock_flag = nil,
        unlocked_default = true,
        generate_notes = true,
        icon = nil,
        image = "mods/Hydroxide/files/mystical_mixtures/journal/gfx/ether.png",
        weight = 1, -- probabilty of note spawning, 1 is default. 
    },]]
}

category_order = {
    "Alchemist's Diary",
    "Alchemy",
    "Materials",
}

dofile("mods/GlimmersExpanded/files/journal/glimmer_alchemical_content.lua")

local colors = dofile("mods/GlimmersExpanded/files/journal/colors.lua")

local function hex_to_rgba(hex)
    -- convert ARGB hex to rgba
    local a = tonumber("0x"..string.sub(hex, 1, 2)) / 255
    local r = tonumber("0x"..string.sub(hex, 3, 4)) / 255
    local g = tonumber("0x"..string.sub(hex, 5, 6)) / 255
    local b = tonumber("0x"..string.sub(hex, 7, 8)) / 255
    return r, g, b, a
end


local function find_closest_color_name(r, g, b)
    local closest_color = nil
    local closest_distance = 99999
    for color_name, color in pairs(colors) do
        local distance = math.sqrt((color[1] - r)^2 + (color[2] - g)^2 + (color[3] - b)^2)
        if(distance < closest_distance)then
            closest_distance = distance
            closest_color = color_name
        end
    end
    return closest_color
end

for i, v in ipairs(glimmer_alchemical_materials)do
    local r, g, b, a = hex_to_rgba(v.color)
    local closest_color = find_closest_color_name(r, g, b)

    if(not v.generate_notes)then
        goto continue
    end

    table.insert(journal_entries, {
        id = "mat_"..v.id,
        category = "Materials",
        title = v.name,
        description = GameTextGetTranslatedOrNot(v.description).."\n \n<c ff2b2b2b>Color: \n<c "..v.color..">"..closest_color.."\n<c ff2b2b2b>Type: \n"..v.type.."\n<c ff2b2b2b>Flammable: \n"..(v.burnable and "true" or "false"),
        unlocked_default = v.unlocked_default or false,
        generate_notes = v.generate_notes or false,
    })

    ::continue::
end 

for i, v in ipairs(glimmer_alchemical_recipes)do
    if(not v.generate_notes)then
        goto continue
    end

    table.insert(journal_entries, {
        id = "recipe_"..v.id,
        category = "Alchemy",
        title = v.name,
        description = GameTextGetTranslatedOrNot(v.description),
        unlocked_default = v.unlocked_default or false,
        generate_notes = v.generate_notes or false,
    })

    ::continue::
end