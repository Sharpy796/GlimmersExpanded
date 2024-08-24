
dofile("mods/GlimmersExpanded/files/lib/glimmer_list_revamped.lua")
local mod_id = "GLIMMERS_EXPANDED_COLOUR_"

function addGlimmer(name, desc, materials, image, cast_delay, spawn_tiers)
    if name == nil then error("attempted to call addGlimmer() with 'name' as nil") end
    if desc == nil then error("attempted to call addGlimmer() with 'desc' as nil") end
    if materials == nil then error("attempted to call addGlimmer() with 'materials' as nil") end
    if image == nil then image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png" end
    if cast_delay == nil then cast_delay = 8 end
    if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end

    local id = mod_id..name:upper():gsub(" ","_")
    local newGlimmer = {
        name = name.." Glimmer",
        desc = desc,
        image = image,
        materials = materials,
        cast_delay = cast_delay,
        spawn_tiers = spawn_tiers,
    }
    print("Adding '"..newGlimmer.name.."' with material '"..newGlimmer.materials[1].."' to glimmer_list_revamped")
    glimmer_list_revamped[id] = newGlimmer
end

-- Normal colors
addGlimmer("White", "Gives a projectile a white sparkly trail", {"spark_white"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_white.png")
addGlimmer("Pink", "Gives a projectile a pink sparkly trail", {"plasma_fading_pink"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_pink.png")
addGlimmer("Teal", "Gives a projectile a teal sparkly trail", {"spark_teal"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_teal.png")

-- Material colors
addGlimmer("Mimicium", "Gives a projectile an iridescent sparkly trail", {"mimic_liquid"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_mimicium.png")
addGlimmer("Blood", "Gives a projectile a bloody sparkly trail", {"blood","blood_fading","blood_fading_slow","cloud_blood",}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_blood.png")
addGlimmer("Freezing Liquid", "Gives a projectile a frozen sparkly trail", {"blood_cold"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_freezing_liquid.png", 15)
addGlimmer("Acid", "Gives a projectile a caustic sparkly trail", {"acid"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_acid.png", 15)
addGlimmer("Diminution", "Gives a projectile a weakened sparkly trail", {"magic_liquid_weakness"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_diminution.png", 15)
addGlimmer("Lava", "Gives a projectile a molten sparkly trail", {"lava"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lava.png", 15)
addGlimmer("Ominous", "Gives a projectile an ominous sparkly trail", {"material_darkness"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_ominous.png", 15)
addGlimmer("Weird Fungus", "Gives a projectile a trippy sparkly trail", {"fungi","blood_fungi",}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_weird_fungus.png")
addGlimmer("Lively Concoction", "Gives a projectile a regenerative sparkly trail", {"magic_liquid_hp_regeneration_unstable"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lively_concoction.png", 4)
addGlimmer("Midas", "Gives a projectile a wealthy sparkly trail", {"midas"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_midas.png", 4)
addGlimmer("True Rainbow", "Gives a projectile a truly rainbow sparkly trail", {"material_rainbow"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_true_rainbow.png")
addGlimmer("Void", "Gives a projectile a trail darker than the void itself", {"void_liquid"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_void.png")
addGlimmer("Biome", "Gives a projectile a sparkly trail that changes depending on the biome you are in!", {"material_rainbow"}, "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_biome.png")

-- print("ALL THINGS IN GLIMMER_LIST_REVAMPED")
-- for id,data in pairs(glimmer_list_revamped) do
--     print("'"..id.."' with material '"..data.materials[1].."'")
-- end
addGlimmer("Vomit", "Gives a projectile a sickeningly sparkly trail", {"vomit"})