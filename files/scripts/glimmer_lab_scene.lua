RegisterSpawnFunction( 0xffff004c, "spawn_glimmer_lab_portal_exit" )
RegisterSpawnFunction( 0xff3692ff, "spawn_glimmer_lab_fish_small" )
RegisterSpawnFunction( 0xffff366d, "spawn_glimmer_lab_fish_big" )
RegisterSpawnFunction( 0xffa8ff36, "spawn_glimmer_lab_fish_eel" )
RegisterSpawnFunction( 0xff875a00, "spawn_glimmer_lab_temporary_workshop" )

function spawn_glimmer_lab_portal_exit( x, y )
    EntityLoad( "mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_out.xml", x, y )
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