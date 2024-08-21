dofile_once("mods/GlimmersExpanded/files/alchemy/all_liquids.lua")
dofile_once("mods/GlimmersExpanded/files/glimmer_list.lua")
local debug = false
local _print = print
function print(...)
    if (debug) then print(...) end
end

print("Start of alchemy script")
local materials_xml = [[<Materials>
]]
-- local liquids = CellFactory_GetAllLiquids(false, false) or {}
local liquids = all_liquids
local colors = dofile("mods/GlimmersExpanded/files/alchemy/glimmer_colors.lua")
-- local dummy_potion_id = EntityLoad("mods/GlimmersExpanded/files/alchemy/dummy_material_comp.xml")
print("Initialized variables")

local function hex_to_rgba(hex)
    -- convert ARGB hex to rgba
    local a = tonumber("0x"..string.sub(hex, 1, 2)) / 255
    local r = tonumber("0x"..string.sub(hex, 3, 4)) / 255
    local g = tonumber("0x"..string.sub(hex, 5, 6)) / 255
    local b = tonumber("0x"..string.sub(hex, 7, 8)) / 255
    return r, g, b, a
end

local function uint_to_rgb(uint)
    if uint ~= 0 then
        local b = bit.rshift(bit.band(uint, 0xFF0000), 16) / 0xFF
        local g = bit.rshift(bit.band(uint, 0xFF00), 8) / 0xFF
        local r = bit.band(uint, 0xFF) / 0xFF
        return r, g, b
    else return nil, nil, nil end
end

local function find_closest_color_name_rgb(r, g, b)
    local closest_color = nil
    local closest_distance = 99999
    for color_name, color in pairs(colors) do
        local distance = math.sqrt((color[1] - r)^2 + (color[2] - g)^2 + (color[3] - b)^2)
        if(distance < closest_distance)then
            closest_distance = distance
            closest_color = color_name:gsub("%A","")
        end
    end
    return closest_color
end

local function find_closest_color_name_hex(hex)
    local r, g, b, a = hex_to_rgba(hex)
    return find_closest_color_name_rgb(r, g, b)
end

local function find_closest_color_name_uint(uint)
    local r, g, b = uint_to_rgb(uint)
    return find_closest_color_name_rgb(r, g, b)
end

print("Initialized helper functions")

-- REACTION GENERATION START
-- for _,liquid in ipairs(liquids) do
for liquid,color in pairs(liquids) do
    print("Liquid is '"..liquid.."'")
    -- Find the appropriate glimmer to spawn
    local transmuted = false
    local glimmer_to_spawn

    for glimmer_tag,materials in pairs(glimmer_list) do
        for _,material in ipairs(materials) do
            transmuted = material == liquid
            if transmuted then break end
        end
        if transmuted then
            glimmer_to_spawn = "GLIMMERS_EXPANDED_COLOUR_" .. glimmer_tag:upper()
            break
        end
    end
    print("Did it get past transmuted?")
    if not transmuted then
        -- AddMaterialInventoryMaterial(dummy_potion_id, liquid, 1)
        -- print("added inventory material")
        -- local mat_color = GameGetPotionColorUint(dummy_potion_id)
        -- local mat_color = all_liquids[liquid]
        -- print("got material color")
        -- print("got game potion color uint")
        -- local mat_color_name = find_closest_color_name_uint(mat_color)
        local mat_color_name = find_closest_color_name_hex(color)
        print("got closest color name")
        if (mat_color_name ~= nil) then
            glimmer_to_spawn = "COLOUR_" .. mat_color_name:upper()
            if (mat_color_name == "pink" or mat_color_name == "white" or mat_color_name == "teal") then
                glimmer_to_spawn = "GLIMMERS_EXPANDED_" .. glimmer_to_spawn
            end
        else
            glimmer_to_spawn = "COLOUR_INVIS"
        end
    end
    if (glimmer_to_spawn ~= nil) then
        print("Glimmer to spawn is '"..glimmer_to_spawn.."'")
    else
        print("Glimmer to spawn is nil")
        glimmer_to_spawn = "COLOUR_INVIS"
    end

    -- Generate a list of reactions for materials.xml
    local reaction_xml = [[<Reaction probability="10"
    input_cell1="static_magic_material"    input_cell2="]] .. liquid .. [["
    output_cell1="static_magic_material"   output_cell2="]] .. liquid .. [["
    convert_all="1"
    entity="mods/GlimmersExpanded/files/alchemy/entities/glimmer_alchemy_]] .. liquid .. [[.xml"
/>
]]
--     local reaction_xml = [[<Reaction probability="10"
--     input_cell_1="static_magic_material"    input_cell_2="]] .. liquid .. [["
--     output_cell_1="air"                     output_cell_2="]] .. liquid .. [["
-- />]]
    -- local reaction_xml = [[<Reaction probability="10" input_cell_1="static_magic_material" input_cell_2="lava" output_cell_1="acid" output_cell_2="lava"></Reaction>]]
    print(reaction_xml)
    materials_xml = materials_xml .. reaction_xml

    print("Generated reaction for '"..liquid.."'")

    -- Generate scripts for those reactions
    local entity_xml = [[
    <Entity name="glimmers_expanded_alchemy_handler">
        <LifetimeComponent lifetime="2"/>
        <LuaComponent
            script_source_file="mods/GlimmersExpanded/files/alchemy/scripts/glimmer_alchemy_]] .. liquid .. [[.lua"
            execute_on_added="1"
            execute_every_n_frame="0"
            execute_times="-1"
        />
    </Entity>
    ]]

    print("compiled entity for '"..liquid.."'")

    -- ModTextFileSetContent("data/alchemy/entities/glimmer_alchemy_" .. liquid .. ".xml", entity_xml)
    ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/entities/glimmer_alchemy_" .. liquid .. ".xml", entity_xml)

    print("generated entity for '"..liquid.."'")

    local script_lua = [[
    local entity_id = GetUpdatedEntityID()
    local x, y = EntityGetTransform(entity_id)

    local function isGlimmer(spell_id)
        local iacomp = EntityGetComponent(spell_id, "ItemActionComponent")
        if (iacomp ~= nil) then
            local action_id = ComponentGetValue2(iacomp[1], "action_id")
            return string.find(action_id, "COLOUR")
        else return nil end
    end
    
    -- Look for spells nearby
    local spells = EntityGetInRadiusWithTag(x, y, 30, "card_action") or {}
    local valid_spells = {}
    local chosen_spell_old

    -- Figure out which spells are glimmers
    for _,spell in ipairs(spells) do
        local root = EntityGetRootEntity(spell)
        if (root == spell) then
            if (isGlimmer(spell)) then
                table.insert(valid_spells, spell)
            end
        end
    end

    -- Choose the first glimmer spell there
    if (#spells > 0) then
        chosen_spell_old = valid_spells[1]
    end

    if (#valid_spells > 0 and valid_spells ~= nil) then
        -- Remove the old glimmer spell
        EntityKill(chosen_spell_old)
        -- Explosion gfx
        EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
        -- Get rid of australium
        EntityLoad("mods/GlimmersExpanded/files/alchemy/glimmer_effect.xml", x, y - 10)
        -- Spawn new glimmer
        CreateItemActionEntity( "]] .. glimmer_to_spawn:upper() .. [[", x, y )
    end
    ]]

    print("Compiled script for '"..liquid.."'")

    ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/scripts/glimmer_alchemy_" .. liquid .. ".lua", script_lua)

    print("Generated script for '"..liquid.."'")

    print("Finished generating things for '"..liquid.."'")
end

materials_xml = materials_xml .. "</Materials>"
print("Finished generating all reactions!")

print(materials_xml)

ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml", materials_xml)
print("set materials.xml in the mod")

ModMaterialsFileAdd("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml")

print("Generated Glimmers Expanded alchemy content.")
print = _print