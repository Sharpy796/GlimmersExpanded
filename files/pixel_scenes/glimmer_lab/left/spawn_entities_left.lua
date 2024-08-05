dofile_once("data/scripts/gun/gun_actions.lua")
dofile_once("data/scripts/item_spawnlists.lua")
dofile_once("data/scripts/biome_scripts.lua")


-- function spawn_potions( x, y )
-- 	SetRandomSeed( x, y )
-- 	local rnd = Random( 1, 1000 )
-- 	if (rnd <= 995) or (y < 512 * 3) then
--         EntityLoad( "data/entities/items/pickup/potion.xml", x, y )
-- 	else
-- 		EntityLoad( "data/entities/items/pickup/potion_mimic.xml", x, y)
-- 	end
-- end

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

local function spawnGlimmerLabPotion( potionX, potionY )
    SetRandomSeed( potionX, potionY ) --TODO: Make this slightly more random, but seed-based?
    local rnd = Random( 1, 1000 )
    if (rnd <= 0001) then -- 00.1%
        EntityLoad( "data/entities/items/pickup/potion_secret.xml", potionX, potionY )
    elseif (rnd <= 0010) then -- 00.9%
        EntityLoad( "data/entities/items/pickup/potion_mimic.xml", potionX, potionY )
    elseif (rnd <= 0100) then -- 09.0%
        EntityLoad( "data/entities/items/pickup/potion_random_material.xml", potionX, potionY )
    else -- 90.0%
        EntityLoad( "data/entities/items/pickup/potion.xml", potionX, potionY )
    end
end

local potionX = 194
local potionY = 296-2
local locations_potion = {
    {potionX, potionY},
    {potionX+11, potionY},
    {potionX+9, potionY+21},
    {potionX+9+10, potionY+21},
    {potionX+9+35, potionY+21},
    {potionX+9-11, potionY+21+22},
    {potionX+9-11+29, potionY+21+22},
    {potionX+9-11+29+20, potionY+21+22},
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
		-- spawn_from_list( "potion_spawnlist", x+coordinates[1], x+coordinates[2] )
        -- spawn_potions(x+coordinates[1], x+coordinates[2])
        -- EntityLoad( "data/entities/items/pickup/potion.xml", x+coordinates[1], y+coordinates[2] )
        spawnGlimmerLabPotion(x+coordinates[1], y+coordinates[2])
    end
end

local function spawnActions(locations)
    for spell, coordinates in pairs(locations) do
        CreateItemActionEntity(spell, x+coordinates[1], y+coordinates[2])
    end
end

spawnActions(locations_spell)
spawnPotions(locations_potion)