glimmer_data = {
    {
        name = "White",
        desc = "Gives a projectile a white sparkly trail",
        materials = {"spark_white"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_white.png",
        cast_delay = nil,
        spawn_tiers = "2,3,4",
        sort_after = -100,
        mod_prefix = nil,
        is_rare = false,
    },
    {
        name = "Pink",
        desc = "Gives a projectile a pink sparkly trail",
        materials = {"plasma_fading_pink"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_pink.png",
        cast_delay = nil,
        spawn_tiers = "1,2,3",
        sort_after = 0,
        mod_prefix = nil,
        is_rare = false,
        trail_mods = {
            count_max = "3",
            lifetime_min = "0.25",
            lifetime_max = "0.75",
        },
    },
    {
        name = "Weird Fungus",
        desc = "Gives a projectile a trippy sparkly trail",
        materials = {"fungi","blood_fungi"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_weird_fungus.png",
        cast_delay = nil,
        spawn_tiers = "2,3,4,5",
        sort_after = 0.1,
        mod_prefix = nil,
        is_rare = false,
    },
    -- COLOUR_RED - sort_after = 1
    {
        name = "Blood",
        desc = "Gives a projectile a bloody sparkly trail",
        materials = {"blood","blood_fading","blood_fading_slow","cloud_blood",},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_blood.png",
        cast_delay = nil,
        spawn_tiers = "1,2,3,4,5,6",
        sort_after = 1.1,
        mod_prefix = nil,
        is_rare = false,
        trail_mods = {
            count_max = "2",
            trail_gap = "0.7"
        },
    },
    -- COLOUR_ORANGE - sort_after = 2
    {
        name = "Lava",
        desc = "Gives a projectile a molten sparkly trail",
        materials = {"lava"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lava.png",
        cast_delay = 15,
        spawn_tiers = "2,3,4,5,6",
        sort_after = 2.1,
        mod_prefix = nil,
        is_rare = false,
    },
    -- COLOUR_YELLOW - sort_after = 3
    -- COLOUR_GREEN - sort_after = 4
    {
        name = "Acid",
        desc = "Gives a projectile a caustic sparkly trail",
        materials = {"acid"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_acid.png",
        cast_delay = 15,
        spawn_tiers = "2,3,4,5,6",
        sort_after = 4.1,
        mod_prefix = nil,
        is_rare = false,
        trail_mods = {
            trail_gap = "0.5",
        },
    },
    {
        name = "Diminution",
        desc = "Gives a projectile a weakened sparkly trail",
        materials = {"magic_liquid_weakness"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_diminution.png",
        cast_delay = 15,
        spawn_tiers = "2,3,4,5,6",
        sort_after = 4.2,
        mod_prefix = nil,
        is_rare = false,
    },
    {
        name = "Teal",
        desc = "Gives a projectile a teal sparkly trail",
        materials = {"spark_teal"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_teal.png",
        cast_delay = nil,
        spawn_tiers = "1,2,3,4",
        sort_after = 4.3,
        mod_prefix = nil,
        is_rare = false,
    },
    -- COLOUR_BLUE - sort_after = 5
    {
        name = "Freezing Liquid",
        desc = "Gives a projectile a frozen sparkly trail",
        materials = {"blood_cold"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_freezing_liquid.png",
        cast_delay = 15,
        spawn_tiers = "2,3,4,5",
        sort_after = 5.1,
        mod_prefix = nil,
        is_rare = false,
    },
    -- COLOUR_PURPLE - sort_after = 6
    {
        name = "Ominous",
        desc = "Gives a projectile an ominous sparkly trail",
        materials = {"material_darkness"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_ominous.png",
        cast_delay = 15,
        spawn_tiers = "3,4,5",
        sort_after = 6.1,
        mod_prefix = nil,
        is_rare = false,
    },
    {
        name = "Void",
        desc = "Gives a projectile a trail darker than the void itself",
        materials = {"void_liquid"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_void.png",
        cast_delay =  nil,
        spawn_tiers = "3,4,5,6",
        sort_after = 6.2,
        mod_prefix = nil,
        is_rare = false,
    },
    {
        name = "Mimicium",
        desc = "Gives a projectile an iridescent sparkly trail",
        materials = {"mimic_liquid"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_mimicium.png",
        cast_delay = nil,
        spawn_tiers = "4,5,6,10",
        sort_after = 6.3,
        mod_prefix = nil,
        is_rare = false,
    },
    -- COLOUR_RAINBOW - sort_after = 7
    {
        name = "True Rainbow",
        desc = "Gives a projectile a truly rainbow sparkly trail",
        materials = {"material_rainbow"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_true_rainbow.png",
        cast_delay = nil,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.1,
        mod_prefix = nil,
        is_rare = false,
    },
    {
        name = "Midas",
        desc = "Gives a projectile a wealthy sparkly trail",
        materials = {"midas"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_midas.png",
        cast_delay = 4,
        spawn_tiers = "5,6,10",
        sort_after = 7.2,
        mod_prefix = nil,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
    {
        name = "Lively Concoction",
        desc = "Gives a projectile a regenerative sparkly trail",
        materials = {"magic_liquid_hp_regeneration_unstable"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lively_concoction.png",
        cast_delay = 4,
        spawn_tiers = "5,6,10",
        sort_after = 7.3,
        mod_prefix = nil,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
    {
        name = "Divine Ground",
        desc = "Gives a projectile a holy sparkly trail",
        materials = {"grass_holy"},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_divine_ground.png",
        cast_delay = 4,
        spawn_tiers = "5,6,10",
        sort_after = 7.31,
        mod_prefix = nil,
        is_rare = true, -- Is a rare material, won't show up in the glimmer lab
    },
    {
        name = "Biome",
        desc = "Gives a projectile a sparkly trail that changes depending on the biome you are in!",
        materials = {"sand","sand_surface","sandstone","sandstone_surface","snow","snow_sticky","slush","water","water_ice","water_salt","water_fading","water_temp","water","water_swamp","grass",},
        image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_biome.png",
        cast_delay = nil,
        spawn_tiers = "4,5,6,10",
        sort_after = 7.4,
        mod_prefix = nil,
        is_rare = false,
    },
    -- COLOUR_INVIS - sort_after = 8
}

-- An example entry of a modded glimmer
local glimmer_appends = {
    {
        -- REQUIRED
        name            = "Vomit", -- The glimmer's name (i.e. "Vomit Glimmer"). Will also be used in the ID (i.e. "GLIIMMERS_EXPANDED_COLOUR_VOMIT")
        desc            = "Gives a projectile a sickeningly sparkly trail", -- The glimmer's description
        materials       = {"vomit"}, -- The material(s) involved. The first one will color the glimmer, and the rest are used in glimmer alchemy.
        -- OPTIONAL
        image           = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_vomit.png", -- The filepath to the spell icon
        cast_delay      = 15, -- The cast delay reduction
        spawn_tiers     = "1,2", -- The spell tiers this spawns in
        sort_after      = 4.21, -- Where this is sorted in the progress menu
        mod_prefix      = "EXAMPLE", -- Will be used in the ID (i.e. "GLIMMERS_EXPANDED_EXAMPLE_COLOUR_VOMIT")
        is_rare         = false, -- Determines whether the glimmer shows up in the glimmer lab
        custom_action   = function() -- A custom action, if you'd like to specify one
            c.fire_rate_wait = c.fire_rate_wait - 45
			current_reload_time = current_reload_time - 20
			c.speed_multiplier = c.speed_multiplier * 2.5
			c.extra_entities = c.extra_entities .. "data/entities/misc/clusterbomb.xml,"
        end,
        trail_mods = {
            count_min = "2",
            count_max = "5",
            trail_gap = "4",
            lifetime_min="8.0",
            lifetime_max="9.0",
        },
    },
}

-- This is what adds all of your new glimmers into glimmer_data
-- for _,entry in ipairs(glimmer_appends) do
--     table.insert(glimmer_data, entry)
-- end