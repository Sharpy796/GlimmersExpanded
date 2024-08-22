dofile_once("mods/GlimmersExpanded/files/alchemy/all_liquids.lua")
dofile_once("mods/GlimmersExpanded/files/glimmer_list.lua")
local debug = true
-- local _print = print
-- function print(...)
--     if (debug) then print(...) end
-- end

-- print("Start of alchemy script")
local materials_xml = [[<Materials>
]]
-- local liquids = CellFactory_GetAllLiquids(false, false) or {}
-- local liquids = all_liquids
local liquids = {}
local all_materials = {}
local colors = dofile("mods/GlimmersExpanded/files/alchemy/glimmer_colors.lua")
-- local dummy_potion_id = EntityLoad("mods/GlimmersExpanded/files/alchemy/dummy_material_comp.xml")
-- print("Initialized variables")

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

local function lamas_stats_get_graphics_info(elem)
    local graphics = elem:first_of("Graphics")
    if graphics == nil then
        return elem.attr["wang_color"]
    else
        --color
        if graphics.attr["color"] == nil then return elem.attr["wang_color"]
        else return graphics.attr["color"] end
    end
end

local function lamas_stats_gather_material() --function to get table of material and whatever
    local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
    local materials = "data/materials.xml"
    local xml = nxml.parse(ModTextFileGetContent(materials))
    
    local files = ModMaterialFilesGet()
    for _, file in ipairs(files) do --add modded materials
        if file ~= materials then
            for _, comp in ipairs(nxml.parse(ModTextFileGetContent(file)).children) do
                xml.children[#xml.children+1] = comp
            end
        end
    end
        
    for _,element_name in ipairs({"CellData","CellDataChild"}) do
        for elem in xml:each_of(element_name) do
            local name = elem.attr["name"]
            if name ~= nil then
                all_materials[name] = elem
            end
        end
    end
end

local function lamas_stats_gather_liquids() --function to get table of material and whatever
    local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
    local materials = "data/materials.xml"
    local xml = nxml.parse(ModTextFileGetContent(materials))
    
    local files = ModMaterialFilesGet()
    for _, file in ipairs(files) do --add modded materials
        if file ~= materials then
            for _, comp in ipairs(nxml.parse(ModTextFileGetContent(file)).children) do
                xml.children[#xml.children+1] = comp
            end
        end
    end
    
    -- local liquidsTagged = {}
    -- for _,element_name in ipairs({"CellData","CellDataChild"}) do
    --     for elem in xml:each_of(element_name) do
    --         local name = elem:get("name")
    --         local tags = elem:get("tags")
    --         local isLiquid
    --         if tags ~= nil then -- TODO: Find a way to gather liquids that inherit the [liquid] tag
    --             isLiquid = tags:find("%[liquid%]")
    --         end
    --         if (elem:get("ui_name") ~= nil and tags and isLiquid) then
    --             local hex = lamas_stats_get_graphics_info(elem) -- in will return color, use color_abgr_split or whatever
    --             -- table.insert(liquids, name, hex)
    --             liquidsTagged[name] = name
    --             print("inserting tagged material: '"..name.."'")
    --             liquids[name] = hex
    --         end
    --     end
    -- end

    -- for _,element_name in ipairs({"CellData","CellDataChild"}) do
    --     for elem in xml:each_of(element_name) do
    --         local parent = elem:get("_parent")
    --         local isLiquid = false
    --         if parent ~= nil then
    --             isLiquid = liquidsTagged[parent]
    --         end
    --         print("-----")
    --         print("parent: '"..tostring(parent).."'")
    --         print("isLiquid: '"..tostring(isLiquid).."'")
    --         if not isLiquid then print("'"..elem:get("name").."' is not isLiquid")
    --         else print("'"..elem:get("name").."' is indeed isLiquid") end
    --         if (elem:get("ui_name") ~= nil and parent ~= nil and isLiquid) then
    --             local name = elem:get("name")
    --             local hex = lamas_stats_get_graphics_info(elem)
    --             liquids[name] = hex
    --         end
    --     end
    -- end
    repeat
        print("start of loop")
        local actualLiquids = {}
        local liquidLength = 0
        for _,element_name in ipairs({"CellData","CellDataChild"}) do
            for elem in xml:each_of(element_name) do
                local name = elem.attr["name"]
                if liquids[name] == nil and name ~= "air" and name ~= nil then -- if we haven't already accepted this material
                    local cell_type = elem.attr["cell_type"] -- if this is nil, then check if it inherits.
                    local liquid_sand = elem.attr["liquid_sand"] -- if this is nil, then check if it inherits.
                    local liquid_static = elem.attr["liquid_static"]

                    if cell_type == nil or liquid_sand == nil or liquid_static == nil then -- if either of these are empty
                        -- does it inherit?
                        local _parent = elem.attr["_parent"]
                        
                        if _parent == nil then -- if it doens't inherit, if either is nil, set it to default
                            if cell_type == nil then cell_type = "liquid" end
                            if liquid_sand == nil then liquid_sand = "0" end
                            if liquid_static == nil then liquid_static = "0" end
                        elseif liquids[_parent] == nil then -- if it inherits from something that is not a valid liquid
                            -- check the parent's value
                            -- TODO: this needs to be recursive
                            repeat
                                local _parent_cell_type = all_materials[_parent].attr["cell_type"]
                                local _parent_liquid_sand = all_materials[_parent].attr["liquid_sand"]
                                local _parent_liquid_static = all_materials[_parent].attr["liquid_static"]
                            _parent = elem.attr["_parent"]
                            until _parent == nil

                            if cell_type == nil then
                                if _parent_cell_type ~= nil then cell_type = _parent_cell_type
                                end
                                -- else cell_type = "liquid" end
                            end
                            if liquid_sand == nil then
                                if _parent_liquid_sand ~= nil then liquid_sand = _parent_liquid_sand
                                end
                                -- else liquid_sand = "0" end
                            end
                            if liquid_static == nil then
                                if _parent_liquid_static ~= nil then liquid_static = _parent_liquid_static
                                end
                                -- else liquid_static = "0" end
                            end
                        elseif liquids[_parent] ~= nil then -- if the parent is a valid liquid
                            -- if it doesn't override it, then we assume it follows the valid liquid guidelines
                            if cell_type == nil then cell_type = "liquid" end
                            if liquid_sand == nil then liquid_sand = "0" end
                            if liquid_static == nil then liquid_static = "0" end
                        end
                        
                        -- after everything, if it's still nil, then set to default
                        -- if cell_type == nil then cell_type = "liquid" end
                        -- if liquid_sand == nil then liquid_sand = "0" end
                        -- if liquid_static == nil then liquid_static = "0" end
                    end

                    local isLiquid = cell_type == "liquid" and liquid_sand == "0" and liquid_static == "0"

                    if (isLiquid) then
                        local hex = lamas_stats_get_graphics_info(elem) -- in will return color, use color_abgr_split or whatever
                        -- table.insert(liquids, name, hex)
                        actualLiquids[name] = hex
                        liquidLength = liquidLength + 1
                        print("inserting valid material: '"..name.."'")
                        -- liquids[name] = hex
                    end
                end
            end
        end
        for liquid,hex in pairs(actualLiquids) do
            liquids[liquid] = hex
        end
    until liquidLength <= 0
end

-- print("Initialized helper functions")
lamas_stats_gather_material()
lamas_stats_gather_liquids()
-- print("gathered liquids:")


-- REACTION GENERATION START
-- for _,liquid in ipairs(liquids) do
for liquid,color in pairs(liquids) do
    -- print("Liquid is '"..liquid.."'")
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
    -- print("Did it get past transmuted?")
    if not transmuted then
        -- AddMaterialInventoryMaterial(dummy_potion_id, liquid, 1)
        -- print("added inventory material")
        -- local mat_color = GameGetPotionColorUint(dummy_potion_id)
        -- local mat_color = all_liquids[liquid]
        -- print("got material color")
        -- print("got game potion color uint")
        -- local mat_color_name = find_closest_color_name_uint(mat_color)
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
    if false then print(reaction_xml) end
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

    -- ModTextFileSetContent("data/alchemy/entities/glimmer_alchemy_" .. liquid .. ".xml", entity_xml)
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

print(materials_xml)

ModTextFileSetContent("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml", materials_xml)
-- print("set materials.xml in the mod")

ModMaterialsFileAdd("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml")

print("Generated Glimmers Expanded alchemy content.")
-- print = _print