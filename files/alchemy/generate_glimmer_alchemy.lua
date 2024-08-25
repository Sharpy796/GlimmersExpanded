dofile_once("mods/GlimmersExpanded/files/lib/glimmer_list_revamped.lua")

local materials_xml = [[<Materials>
]]
local liquids = {}
local all_materials = {}
local colors = dofile("mods/GlimmersExpanded/files/alchemy/glimmer_colors.lua")

local function hex_to_rgba(hex)
    -- convert ARGB hex to rgba
    local a, r, g, b
    if #hex == 8 then
        a = tonumber("0x"..string.sub(hex, 1, 2)) / 255
        r = tonumber("0x"..string.sub(hex, 3, 4)) / 255
        g = tonumber("0x"..string.sub(hex, 5, 6)) / 255
        b = tonumber("0x"..string.sub(hex, 7, 8)) / 255
    else
        r = tonumber("0x"..string.sub(hex, 1, 2)) / 255
        g = tonumber("0x"..string.sub(hex, 3, 4)) / 255
        b = tonumber("0x"..string.sub(hex, 5, 6)) / 255
    end
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

local function get_elem_data(elem, data)
    if elem then
        local _parent = elem:get("_parent")
        local dt = elem:get(data)
        if dt then
            return dt
        else
            if _parent then
                return get_elem_data(all_materials[_parent], data)
            else
                if (data == "cell_type") then return "liquid"
                else return "0" end
            end
        end
    end
end

local function lamas_stats_get_graphics_info(elem)
    local graphics = elem:first_of("Graphics")
    if graphics == nil then
        return elem:get("wang_color")
    else
        if graphics:get("color") == nil then return elem:get("wang_color")
        else return graphics:get("color") end
    end
end

local function get_modded_material_files()
    local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
    local materials = "data/materials.xml"
    local xml = nxml.parse(ModTextFileGetContent(materials))

    local files = ModMaterialFilesGet()

    for _, file in ipairs(files) do
        -- print("modded material files: "..file)
        if file ~= materials then
            for _, comp in ipairs(nxml.parse(ModTextFileGetContent(file)).children) do
                xml.children[#xml.children+1] = comp
            end
        end
    end
    return xml
end

local function lamas_stats_gather_material()
    local xml = get_modded_material_files()
        
    for _,element_name in ipairs({"CellData","CellDataChild"}) do
        for elem in xml:each_of(element_name) do
            local name = elem:get("name")
            if name ~= nil then
                all_materials[name] = elem
            end
        end
    end
end

local function lamas_stats_gather_liquids()
    local xml = get_modded_material_files()

    repeat
        -- print("start of loop")
        local actualLiquids = {}
        local liquidLength = 0
        for _,element_name in ipairs({"CellData","CellDataChild"}) do
            for elem in xml:each_of(element_name) do
                if elem ~= nil then
                    local name = elem:get("name")
                    if liquids[name] == nil and name ~= "air" and name ~= nil then -- if we haven't already accepted this material
                        local cell_type = get_elem_data(elem, "cell_type")
                        local liquid_sand = get_elem_data(elem, "liquid_sand")
                        local liquid_static = get_elem_data(elem, "liquid_static")
                        local is_just_particle_fx = get_elem_data(elem, "is_just_particle_fx")
                        local isLiquid = cell_type == "liquid" and liquid_sand == "0" and liquid_static == "0" and is_just_particle_fx == "0"

                        if (isLiquid) then
                            local hex = lamas_stats_get_graphics_info(elem) -- in will return color, use color_abgr_split or whatever
                            actualLiquids[name] = hex
                            liquidLength = liquidLength + 1
                            -- print("inserting valid material: '"..name.."'")
                        end
                    end
                end
            end
        end
        for liquid,hex in pairs(actualLiquids) do
            liquids[liquid] = hex
        end
    until liquidLength <= 0

    for id,data in pairs(glimmer_list_revamped) do
        local materials = data.materials
        for id,material in ipairs(materials) do
            if not liquids[material] then
                local missingMaterial = all_materials[material]
                local hex = lamas_stats_get_graphics_info(missingMaterial)
                liquids[material] = hex
            end
        end
    end
end

lamas_stats_gather_material()
lamas_stats_gather_liquids()

-- REACTION GENERATION START
for liquid,color in pairs(liquids) do
    -- print("Liquid is '"..liquid.."'")
    -- Find the appropriate glimmer to spawn
    local transmuted = false
    local glimmer_to_spawn

    for id,data in pairs(glimmer_list_revamped) do
        local materials = data.materials
        for _,material in ipairs(materials) do
            transmuted = material == liquid
            if transmuted then break end
        end
        if transmuted then
            glimmer_to_spawn = data.id
            -- glimmer_to_spawn = "GLIMMERS_EXPANDED_COLOUR_" .. glimmer_tag:upper()
            break
        end
    end
    -- print("Did it get past transmuted?")
    if not transmuted then
        local mat_color_name = find_closest_color_name_hex(color)
        -- print("got closest color name")
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
        -- print("Glimmer to spawn is '"..glimmer_to_spawn.."'")
    else
        -- print("Glimmer to spawn is nil")
        glimmer_to_spawn = "COLOUR_INVIS"
    end

    -- Generate a list of reactions for materials.xml
    local reaction_xml = [[<Reaction probability="25"
    input_cell1="static_magic_material"    input_cell2="]] .. liquid .. [["
    output_cell1="static_magic_material"   output_cell2="]] .. liquid .. [["
    convert_all="1"
    entity="mods/GlimmersExpanded/files/alchemy/entities/glimmer_alchemy_]] .. liquid .. [[.xml"
/>
]]
    -- if false then print(reaction_xml) end
    materials_xml = materials_xml .. reaction_xml

    -- print("Generated reaction for '"..liquid.."'")

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

    -- print("compiled entity for '"..liquid.."'")

    ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/entities/glimmer_alchemy_" .. liquid .. ".xml", entity_xml)

    -- print("generated entity for '"..liquid.."'")

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
        print("Spawning ']]..glimmer_to_spawn:upper()..[[' using ']]..liquid..[['")
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

    -- print("Compiled script for '"..liquid.."'")

    ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/scripts/glimmer_alchemy_" .. liquid .. ".lua", script_lua)

    -- print("Generated script for '"..liquid.."'")

    -- print("Finished generating things for '"..liquid.."'")
end

materials_xml = materials_xml .. "</Materials>"
-- print("Finished generating all reactions!")

-- print(materials_xml)

ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml", materials_xml)
-- print("set materials.xml in the mod")

ModMaterialsFileAdd("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml")

print("Generated Glimmers Expanded alchemy content.")