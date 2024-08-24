dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )


local p = EntityGetInRadiusWithTag( x, y, 300, "player_unit" )

local glimmer_lab_potion_locations = {
    {-5, 28},
    {-13, 27},
    {-5, 50},
    {21, 52},
    {-28, 70},
    {7, 73},
    {-94, 20},
    {-118, 40},
    {-142, 38},
    {-107, 63},
    {-132, 61},
    {-143, 60},
}

local function spawn_glimmer_lab_potion( x, y )
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

local function spawn_glimmer_lab_potions( locations )
    for _, coordinates in ipairs(locations) do
        spawn_glimmer_lab_potion(x+coordinates[1], y+coordinates[2])
    end
end

local glimmer_lab_spell_locations = {
    ["GLIMMERS_EXPANDED_COLOUR_WEIRD_FUNGUS"] = { 171, 8 },
    ["GLIMMERS_EXPANDED_COLOUR_BLOOD"] = { 146, 6 },
    -- ["GLIMMERS_EXPANDED_COLOUR_LAVA"] = { 121, 4 },
    -- ["COLOUR_ORANGE"] = { 80, 90 },
    ["GLIMMERS_EXPANDED_COLOUR_ACID"] = { 96, 2 },
    ["GLIMMERS_EXPANDED_COLOUR_DIMINUTION"] = { 173, -21 },
    ["GLIMMERS_EXPANDED_COLOUR_FREEZING_LIQUID"] = { 148, -23 },
    ["GLIMMERS_EXPANDED_COLOUR_OMINOUS"] = { 124, -25 },
    ["GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW"] = { 99, -27 },
    ["GLIMMERS_EXPANDED_COLOUR_LIVELY_CONCOCTION"] = { 176, -50 },
    ["GLIMMERS_EXPANDED_COLOUR_MIDAS"] = { 151, -52 },
    ["GLIMMERS_EXPANDED_COLOUR_VOID"] = { 126, -54 },
    ["GLIMMERS_EXPANDED_COLOUR_MIMICIUM"] = { 101, -56 },
    -- ["GLIMMERS_EXPANDED_COLOUR_BIOME"] = { 178, -79 }, -- TODO: Enable this once it is done
}

if (ModSettingGet("GlimmersExpanded.allow_alchemy")) then
    glimmer_lab_spell_locations["COLOUR_ORANGE"] = { 80, 90 }
else
    glimmer_lab_spell_locations["GLIMMERS_EXPANDED_COLOUR_LAVA"] = { 121, 4 }
end

local function spawn_glimmer_lab_spell( spell_id, x, y )
    CreateItemActionEntity( spell_id, x, y )
end

local totalSpellsGenerated = 0
local function spawn_glimmer_lab_spells( locations )
    for spell_id, coordinates in pairs(locations) do
        spawn_glimmer_lab_spell(spell_id, x+coordinates[1], y+coordinates[2])
    end


    -- totalSpellsGenerated = totalSpellsGenerated + 1
    -- local glimmer_name = glimmer_lab_spells[totalSpellsGenerated]
    -- if glimmer_name ~= nil then
    -- end
end

if ( #p > 0 ) and GameHasFlagRun( "fishing_hut_a" ) then
    -- Thank you Evasia for this journal from Chemical Curiosities! It works *really* well as a condensed place for several pieces of lore.
    EntityLoad("mods/GlimmersExpanded/files/journal/journal_entity.xml", x+22, y+28)

    spawn_glimmer_lab_potions(glimmer_lab_potion_locations)
    spawn_glimmer_lab_spells(glimmer_lab_spell_locations)
    
    EntityLoad("mods/GlimmersExpanded/files/entities/buildings/glimmer_lab_workshop_temporary.xml", x, y)

    EntityKill( entity_id )
end