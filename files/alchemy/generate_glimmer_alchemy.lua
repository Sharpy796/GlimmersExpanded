local materials_xml = [[<Materials>
]]
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_materials.lua")

-- REACTION GENERATION START
for liquid,color in pairs(ge_alchemic_materials) do
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