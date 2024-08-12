RegisterSpawnFunction( 0xffff00e6, "spawn_glimmer_lab_potion" )
RegisterSpawnFunction( 0xffff004c, "spawn_glimmer_lab_portal_exit" )
RegisterSpawnFunction( 0xff0400ff, "spawn_glimmer_lab_spell" )
RegisterSpawnFunction( 0xff3692ff, "spawn_glimmer_lab_fish_small" )
RegisterSpawnFunction( 0xffff366d, "spawn_glimmer_lab_fish_big" )
RegisterSpawnFunction( 0xffa8ff36, "spawn_glimmer_lab_fish_eel" )
RegisterSpawnFunction( 0xff875a00, "spawn_glimmer_lab_temporary_workshop" )

function spawn_glimmer_lab_potion( x, y )
    SetRandomSeed( x, y )
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

function spawn_glimmer_lab_temporary_workshop( x, y )
    EntityLoad( "mods/GlimmersExpanded/files/entities/buildings/glimmer_lab_check.xml", x, y )
end