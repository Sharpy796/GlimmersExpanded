dofile_once("data/scripts/gun/gun_actions.lua")
dofile( "data/scripts/item_spawnlists.lua" )

-- function spawn_potions( x, y ) end

local sceneId = GetUpdatedEntityID()
local x, y = EntityGetTransform(sceneId)

local locations_spell = {
    ["GLIMMERS_EXPANDED_COLOUR_FUNGI"] = {72, 73},
    ["GLIMMERS_EXPANDED_COLOUR_BLOOD"] = {97, 73},
    ["GLIMMERS_EXPANDED_COLOUR_LAVA"] = {122, 73},
    ["GLIMMERS_EXPANDED_COLOUR_ACID"] = {147, 73},
    ["GLIMMERS_EXPANDED_COLOUR_WEAKNESS"] = {72, 73+29},
    ["GLIMMERS_EXPANDED_COLOUR_FREEZING"] = {97, 73+29},
    ["GLIMMERS_EXPANDED_COLOUR_DARKNESS"] = {122, 73+29},
    ["GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW"] = {147, 73+29},
    ["GLIMMERS_EXPANDED_COLOUR_LC"] = {72, 73+29+29},
    ["GLIMMERS_EXPANDED_COLOUR_MIDAS"] = {97, 73+29+29},
    ["GLIMMERS_EXPANDED_COLOUR_VOID"] = {122, 73+29+29},
    ["GLIMMERS_EXPANDED_COLOUR_MIMIC"] = {147, 73+29+29},
    ["GLIMMERS_EXPANDED_COLOUR_BIOME"] = {72, 73+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {97, 73+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {122, 73+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {147, 73+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {72, 73+29+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {97, 73+29+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {122, 73+29+29+29+29},
    -- ["GLIMMERS_EXPANDED_COLOUR_"] = {147, 73+29+29+29+29},
}

local locations_potion = {
    {194, 296},
    {194+11, 296},
    {194+9, 296+21},
    {194+9+10, 296+21},
    {194+9+35, 296+21},
    {194+9-11, 296+21+22},
    {194+9-11+29, 296+21+22},
    {194+9-11+29+20, 296+21+22},
}

local locations_book = {

}

local function spawnActions(locations)
    for spell, coordinates in pairs(locations) do
        CreateItemActionEntity(spell, x+coordinates[1], y+coordinates[2])
    end
end

local function spawnPotions(locations)
    for potion, coordinates in pairs(locations) do
		spawn_from_list( "potion_spawnlist", x+coordinates[1], x+coordinates[2] )
        -- spawn_potions(x+coordinates[1], x+coordinates[2])
    end
end

local function spawnActions(locations)
    for spell, coordinates in pairs(locations) do
        CreateItemActionEntity(spell, x+coordinates[1], y+coordinates[2])
    end
end

spawnActions(locations_spell)
spawnPotions(locations_potion)