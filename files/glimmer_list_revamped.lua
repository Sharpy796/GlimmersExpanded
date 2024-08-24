local glimmer_list_revamped = {}
local mod_id = "GLIMMERS_EXPANDED_COLOUR_"

function addGlimmer(name, materials, cast_delay, spawn_tiers)
    if cast_delay == nil then cast_delay = 8 end
    if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end

    local id = mod_id..name:upper():gsub(" ","_")
    glimmer_list_revamped[id] = {
        name = name.." Glimmer",
        materials = materials,
        cast_delay = cast_delay,
        spawn_tiers = spawn_tiers,
    }
end

-- Normal colors
addGlimmer("White", {"spark_white"})
addGlimmer("Pink", {"plasma_fading_pink"})
addGlimmer("Teal", {"spark_teal"})

-- Material colors
addGlimmer("Mimicium", {"mimic_liquid"})
addGlimmer("Blood", {"blood","blood_fading","blood_fading_slow","cloud_blood",})
addGlimmer("Freezing Liquid", {"blood_cold"}, 15)
addGlimmer("Acid", {"acid"}, 15)
addGlimmer("Diminution", {"magic_liquid_weakness"}, 15)
addGlimmer("Lava", {"lava"}, 15)
addGlimmer("Ominous", {"material_darkness"}, 15)
addGlimmer("Weird Fungus", {"fungi","blood_fungi",})
addGlimmer("Lively Concoction", {"magic_liquid_hp_regeneration_unstable"}, 4)
addGlimmer("Midas", {"midas"}, 4)
addGlimmer("True Rainbow", {"material_rainbow"})
addGlimmer("Void", {"void_liquid"})

return glimmer_list_revamped