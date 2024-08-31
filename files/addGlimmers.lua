dofile("mods/GlimmersExpanded/files/lib/glimmer_data.lua")
local mod_id = "GLIMMERS_EXPANDED_"
glimmer_list_revamped = {}
organizedGlimmerList = {
	{id="COLOUR_RED",sort_after=1},
	{id="COLOUR_ORANGE",sort_after=2},
	{id="COLOUR_YELLOW",sort_after=3},
	{id="COLOUR_GREEN",sort_after=4},
	{id="COLOUR_BLUE",sort_after=5},
	{id="COLOUR_PURPLE",sort_after=6},
	{id="COLOUR_RAINBOW",sort_after=7},
	{id="COLOUR_INVIS",sort_after=8},
}

-- Adds a new glimmer to the game.
---@param name string
---@param desc string
---@param materials string[]
---@param image string? '"mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png"'
---@param cast_delay integer? 8
---@param spawn_tiers string? '"1,2,3,4,5,6"'
---@param sort_after number? 100
---@param mod_prefix string? '""'
---@param is_rare boolean? false
function addGlimmer(name, desc, materials, image, cast_delay, spawn_tiers, sort_after, mod_prefix, is_rare)
    if name == nil then error("attempted to call addGlimmer() with 'name' as nil") end
    if desc == nil then error("attempted to call addGlimmer() with 'desc' as nil") end
    if materials == nil then error("attempted to call addGlimmer() with 'materials' as nil") end
    if image == nil then image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png" end
    if cast_delay == nil then cast_delay = 8 end
    if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end
    if sort_after == nil then sort_after = 100 end
    if not mod_prefix then mod_prefix = "" else
    mod_prefix = mod_prefix:upper():gsub("%W","_").."_" end
    if is_rare == nil then is_rare = false end

    local id = mod_id..mod_prefix.."COLOUR_"..name:upper():gsub("%W","_")
    local newGlimmer = {
        id = id,
        name = name.." Glimmer",
        desc = desc,
        image = image,
        materials = materials,
        cast_delay = cast_delay,
        spawn_tiers = spawn_tiers,
        sort_after = sort_after,
        is_rare = is_rare
    }
    -- print("Adding '"..newGlimmer.name.."' with material '"..newGlimmer.materials[1].."' to glimmer_list_revamped")
    glimmer_list_revamped[id] = newGlimmer
end

-- addGlimmer("White", "Gives a projectile a white sparkly trail", {"spark_white"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_white.png", nil, "2,3,4", -100, nil, false)
-- addGlimmer("Pink", "Gives a projectile a pink sparkly trail", {"plasma_fading_pink"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_pink.png", nil, "1,2,3", 0, nil, false)
-- addGlimmer("Weird Fungus", "Gives a projectile a trippy sparkly trail", {"fungi","blood_fungi",}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_weird_fungus.png", nil, "2,3,4,5", 0.1, nil, false)
-- -- COLOUR_RED - sort_after = 1
-- addGlimmer("Blood", "Gives a projectile a bloody sparkly trail", {"blood","blood_fading","blood_fading_slow","cloud_blood",}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_blood.png", nil, "1,2,3,4,5,6", 1.1, nil, false)
-- -- COLOUR_ORANGE - sort_after = 2
-- addGlimmer("Lava", "Gives a projectile a molten sparkly trail", {"lava"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lava.png", 15, "2,3,4,5,6", 2.1, nil, false)
-- -- COLOUR_YELLOW - sort_after = 3
-- -- COLOUR_GREEN - sort_after = 4
-- addGlimmer("Acid", "Gives a projectile a caustic sparkly trail", {"acid"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_acid.png", 15, "2,3,4,5,6", 4.1, nil, false)
-- addGlimmer("Diminution", "Gives a projectile a weakened sparkly trail", {"magic_liquid_weakness"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_diminution.png", 15, "2,3,4,5", 4.2, nil, false)
-- addGlimmer("Teal", "Gives a projectile a teal sparkly trail", {"spark_teal"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_teal.png", nil, "1,2,3,4", 4.3, nil, false)
-- -- COLOUR_BLUE - sort_after = 5
-- addGlimmer("Freezing Liquid", "Gives a projectile a frozen sparkly trail", {"blood_cold"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_freezing_liquid.png", 15, "2,3,4,5", 5.1, nil, false)
-- -- COLOUR_PURPLE - sort_after = 6
-- addGlimmer("Ominous", "Gives a projectile an ominous sparkly trail", {"material_darkness"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_ominous.png", 15, "3,4,5", 6.1, nil, false)
-- addGlimmer("Void", "Gives a projectile a trail darker than the void itself", {"void_liquid"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_void.png", nil, "3,4,5,6", 6.2, nil, false)
-- addGlimmer("Mimicium", "Gives a projectile an iridescent sparkly trail", {"mimic_liquid"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_mimicium.png", nil, "4,5,6,10", 6.3, nil, false)
-- -- COLOUR_RAINBOW - sort_after = 7
-- addGlimmer("True Rainbow", "Gives a projectile a truly rainbow sparkly trail", {"material_rainbow"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_true_rainbow.png", nil, "4,5,6,10", 7.1, nil, false)
-- addGlimmer("Midas", "Gives a projectile a wealthy sparkly trail", {"midas"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_midas.png", 4, "4,5,6,10", 7.2, nil, true)
-- addGlimmer("Lively Concoction", "Gives a projectile a regenerative sparkly trail", {"magic_liquid_hp_regeneration_unstable"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lively_concoction.png", 4, "4,5,6,10", 7.3, nil, true)
-- addGlimmer("Divine Ground", "Gives a projectile a holy sparkly trail", {"grass_holy"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_divine_ground.png", 4, "4,5,6,10", 7.31, nil, true)
-- addGlimmer("Biome", "Gives a projectile a sparkly trail that changes depending on the biome you are in!", {"sand","sand_surface","sandstone","sandstone_surface","snow","snow_sticky","slush","water","water_ice","water_salt","water_fading","water_temp","water","water_swamp","grass",}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_biome.png", nil, "4,5,6,10", 7.4, nil, false)
-- -- COLOUR_INVIS - sort_after = 8

-- Example Line:
-- addGlimmer("Vomit", "Gives a projectile a sickeningly sparkly trail", {"vomit"}, nil, 15, "1,2", 4.21, "EXAMPLE")
-- function addGlimmer(name, desc, materials, image, cast_delay, spawn_tiers, sort_after, mod_prefix)

for _,glimmer in ipairs(glimmer_data) do
    addGlimmer(glimmer.name,
            glimmer.desc,
            glimmer.materials,
            glimmer.image,
            glimmer.cast_delay,
            glimmer.spawn_tiers,
            glimmer.sort_after,
            glimmer.mod_prefix,
            glimmer.is_rare)
end