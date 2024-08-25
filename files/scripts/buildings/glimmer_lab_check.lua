dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")

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
    ["GLIMMERS_EXPANDED_COLOUR_BIOME"] = { 178, -79 },
}

local glimmer_lab_spell_locations = {
    { 96, 2 },
    { 146, 6 },
    { 121, 4 },
    { 171, 8 },
    { 173, -21 },
    { 148, -23 },
    { 124, -25 },
    { 99, -27 },
    { 176, -50 },
    { 151, -52 },
    { 126, -54 },
    { 101, -56 },
    { 103, -81 },
    { 128, -77 },
    { 153, -75 },
    { 178, -73 },
}
local spell_ids = {}

local function gather_spell_ids()
    for id,data in pairs(glimmer_list_revamped) do
        if id ~= "GLIMMERS_EXPANDED_COLOUR_PINK" and id ~= "GLIMMERS_EXPANDED_COLOUR_WHITE" and id ~= "GLIMMERS_EXPANDED_COLOUR_TEAL" then
            table.insert(spell_ids, id)
        end
    end
end
gather_spell_ids()

local function spawn_glimmer_lab_spell( spell_id, x, y )
    CreateItemActionEntity( spell_id, x, y )
end

local function spawn_glimmer_lab_spells( locations )
    for index,coordinates in ipairs(locations) do
        local spell_id = spell_ids[index]
        if spell_id ~= nil then
            if (ModSettingGet("GlimmersExpanded.allow_alchemy") and spell_id == "GLIMMERS_EXPANDED_COLOUR_LAVA") then
                spawn_glimmer_lab_spell("COLOUR_ORANGE", x+80, y+90)
            elseif spell_id ~= "GLIMMERS_EXPANDED_COLOUR_PINK" and spell_id ~= "GLIMMERS_EXPANDED_COLOUR_WHITE" and spell_id ~= "GLIMMERS_EXPANDED_COLOUR_TEAL" then
                spawn_glimmer_lab_spell(spell_id, x+coordinates[1], y+coordinates[2])
            end
        end
        
    end
    -- for spell,coordinates in pairs(locations) do
    --     spawn_glimmer_lab_spell(spell, x+coordinates[1], y+coordinates[2])
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