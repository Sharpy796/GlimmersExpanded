dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )


local p = EntityGetInRadiusWithTag( x, y, 300, "player_unit" )

if ( #p > 0 ) and GameHasFlagRun( "fishing_hut_a" ) then
    EntityLoad("mods/GlimmersExpanded/files/entities/buildings/glimmer_lab_workshop_temporary.xml", x, y)

    EntityKill( entity_id )
end