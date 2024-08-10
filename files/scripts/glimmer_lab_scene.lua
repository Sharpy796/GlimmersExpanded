-- RegisterSpawnFunction( 0xffd795e3, "spawn_hatch")
-- RegisterSpawnFunction( 0xff6ab83a, "spawn_door")
-- RegisterSpawnFunction( 0xfff6c71f, "spawn_chandelier")
-- RegisterSpawnFunction( 0xffd49910, "spawn_lantern")
-- RegisterSpawnFunction( 0xff4d69d6, "spawn_table")
-- RegisterSpawnFunction( 0xffcd94dd, "spawn_desk")
-- RegisterSpawnFunction( 0xff8b2ea4, "spawn_bedroom")
-- RegisterSpawnFunction( 0xff33338a, "spawn_warderobe")
-- RegisterSpawnFunction( 0xff9875bf, "spawn_potion")
RegisterSpawnFunction( 0xffff00e6, "spawn_glimmer_lab_potion" )
RegisterSpawnFunction( 0xffff004c, "spawn_glimmer_lab_portal_exit" )
RegisterSpawnFunction( 0xff0400ff, "spawn_glimmer_lab_spell" )
RegisterSpawnFunction( 0xff3692ff, "spawn_glimmer_lab_fish_small" )
RegisterSpawnFunction( 0xffff366d, "spawn_glimmer_lab_fish_big" )
RegisterSpawnFunction( 0xffa8ff36, "spawn_glimmer_lab_fish_eel" )

-- local old_init = init

-- init = function(x, y, w, h)
--     LoadPixelScene("mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house.png", "mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house_visual.png", x + 88, y - 189, "mods/Hydroxide/files/mystical_mixtures/scenes/alchemist_house_bg.png", true, false, nil, nil, true)

--     old_init(x, y, w, h)
-- end

-- function spawn_hatch ( x, y )
--     EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/hatch.xml", x + 13.5, y + 3 )
-- end

-- function spawn_door ( x, y )
--     EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/door/door.xml", x + 0.5, y + 1 )
-- end

-- function spawn_chandelier ( x, y )
--     EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/chandelier.xml", x, y + 4 )
-- end

-- function spawn_lantern ( x, y )
--     EntityLoad( "data/entities/props/physics/lantern_small.xml", x, y )
-- end

-- function spawn_table ( x, y )
--     x = x + 1
--     EntityLoad( "data/entities/props/furniture_wood_table.xml", x, y )
--     EntityLoad( "data/entities/props/physics_chair_1.xml", x - 18, y )
--     EntityLoad( "data/entities/props/physics_chair_2.xml", x + 18, y )
-- end

-- function spawn_desk ( x, y )
--     x = x + 6
--     EntityLoad( "mods/Hydroxide/files/mystical_mixtures/entities/desk.xml", x, y )
--     EntityLoad( "data/entities/props/physics_chair_2.xml", x + 10, y )
--     EntityLoad( "mods/Hydroxide/files/mystical_mixtures/journal/journal_entity.xml", x, y - 13 )
-- end

-- function spawn_bedroom ( x, y )
--     --GamePrint("Bedroom")
--     EntityLoad( "data/entities/props/furniture_bed.xml", x + 7, y )
--     --EntityLoad( "data/entities/props/furniture_wardrobe.xml", x - 2, y )
-- end

-- function spawn_warderobe ( x, y )
--     EntityLoad( "data/entities/props/furniture_wardrobe.xml", x - 5, y )
-- end

-- function spawn_potion ( x, y )
--     if(Random(0, 100) < 30)then
--         EntityLoad( "mods/Hydroxide/files/arcane_alchemy/items/vials/vial.xml", x, y - 3 )
--     else
--         EntityLoad( "data/entities/items/pickup/potion.xml", x + 3, y - 3 )
--     end
-- end

function spawn_glimmer_lab_potion( x, y )
    SetRandomSeed( x, y ) --TODO: Make this slightly more random, but seed-based?
    local rnd = Random( 1, 1000 )
    if (rnd <= 0001) then -- 00.1%
        EntityLoad( "data/entities/items/pickup/potion_secret.xml", x, y )
    elseif (rnd <= 0010) then -- 00.9%
        EntityLoad( "data/entities/items/pickup/potion_mimic.xml", x, y )
    elseif (rnd <= 0100) then -- 9.0%
        EntityLoad( "data/entities/items/pickup/potion_random_material.xml", x, y )
    else -- 90.0%
        EntityLoad( "data/entities/items/pickup/potion.xml", x, y )
    end
end

function spawn_glimmer_lab_portal_exit( x, y )
    EntityLoad( "mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_out.xml", x, y )
end

local glimmer_lab_spells = {
    "GLIMMERS_EXPANDED_COLOUR_FUNGI",
    "GLIMMERS_EXPANDED_COLOUR_BLOOD",
    "GLIMMERS_EXPANDED_COLOUR_LAVA",
    "GLIMMERS_EXPANDED_COLOUR_ACID",
    "GLIMMERS_EXPANDED_COLOUR_WEAKNESS",
    "GLIMMERS_EXPANDED_COLOUR_FREEZING",
    "GLIMMERS_EXPANDED_COLOUR_DARKNESS",
    "GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW",
    "GLIMMERS_EXPANDED_COLOUR_LC",
    "GLIMMERS_EXPANDED_COLOUR_MIDAS",
    "GLIMMERS_EXPANDED_COLOUR_VOID",
    "GLIMMERS_EXPANDED_COLOUR_MIMIC",
    "GLIMMERS_EXPANDED_COLOUR_BIOME",
}

local totalSpellsGenerated = 0

function spawn_glimmer_lab_spell( x, y )
    totalSpellsGenerated = totalSpellsGenerated + 1

    -- glimmer_lab_spell_locations[totalSpellsGenerated] = { x, y }

    -- CreateItemActionEntity( "GLIMMERS_EXPANDED_COLOUR_LAVA", x, y )
    local glimmer_name = glimmer_lab_spells[totalSpellsGenerated]
    if glimmer_name ~= nil then
        CreateItemActionEntity( glimmer_lab_spells[totalSpellsGenerated], x, y )
    end
end

function spawn_glimmer_lab_fish_small( x, y )
    EntityLoad( "data/entities/animals/fish.xml", x, y )
end

function spawn_glimmer_lab_fish_big( x, y )
    EntityLoad( "data/entities/animals/fish_large.xml", x, y )
end

function spawn_glimmer_lab_fish_eel( x, y )
    EntityLoad( "data/entities/animals/eel.xml", x, y )
end