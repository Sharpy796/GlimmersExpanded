glimmer_alchemical_materials = {
    -- { -- Dummy Entry
    --     id = "static_magic_material", -- id of the material
    --     name = "$mat_static_magic_material", -- name of the material
    --     description = "$desc_static_magic_material",
    --     generate_notes = true,
    --     color = "FF72BFD8", -- visual color
    --     texture="mods/Hydroxide/files/mystical_mixtures/gfx/materials/arcane_metal.png", -- texture path
    --     type = "liquid",
    --     tags = "[alchemical],[ingredient]",
    --     density = 1.1,
    --     lifetime = 200,
    --     burnable = true,
    --     fire_hp = 100,
    --     glow = 250,
    -- },
    {
        id = "static_magic_material", -- id of the material
        name = "$mat_static_magic_material", -- name of the material
        description = "$desc_static_magic_material",
        generate_notes = true,
        unlocked_default = true,
        color = "ffD7D684", -- visual color
        texture ="data/materials_gfx/static_magic_material.png",
        type = "solid",
        -- tags = "[static],[corrodible],[alchemy],[solid]",
        tags = "[alchemical],[ingredient]",
	    glow="200",
	    -- density="10",
    },
    {
        id = "magic_liquid",
        name = "$mat_magic_liquid",
        description = "$desc_magic_liquid",
        generate_notes = true,
        unlocked_default = true,
        -- color = "80fffea2",
        color = "fffffea2",
        texture = nil, -- texture path
        type = "liquid",
        -- tags = "[liquid],[water],[magic_liquid],[impure]",
        tags = "[alchemical],[ingredient]",
        glow = 150,
	    density="5.23",
        lifetime = 300,
    },
    {
        id = "lava",
        name = "$mat_lava",
        description = "$desc_lava",
        generate_notes = true,
        unlocked_default = true,
        color = "ffff6000",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[fire_lava],[liquid],[lava],[liquid_common],[chaotic_transmutation]",
	    density="6",
	    glow="150",
    },
    {
        id = "pus",
        name = "$mat_pus",
        description = "$desc_pus",
        generate_notes = true,
        unlocked_default = true,
        -- color = "44695642",
        color = "FF695642",
        texture = "data/materials_gfx/pus.png", -- texture path
        type = "liquid",
        tags = "[liquid],[water],[magic_liquid],[impure]",
	    density="1.2434",
    },
    {
        id = "urine",
        name = "$mat_urine",
        description = "$desc_urine",
        generate_notes = true,
        unlocked_default = true,
        -- color = "33FFEE00",
        color = "FFFFEE00",
        texture = nil, -- texture path
        type = "liquid",
        tags = "[liquid],[corrodible],[soluble],[liquid_common]",
	    density="3",
    },
    {
        id = "material_confusion",
        name = "$mat_confusion",
        description = "$desc_confusion",
        generate_notes = true,
        unlocked_default = true,
        -- color = "88E8BD5C",
        color = "FFE8BD5C",
        texture = "data/materials_gfx/confusion.png", -- texture path
        type = "liquid",
        tags = "[liquid],[water],[magic_liquid],[impure]",
	    glow="150",
	    density="1.2",
    },
}

glimmer_alchemical_recipes = {
    {
        id = "australium_creation",
        name = "$reac_australium_creation",
        description = "$reac_desc_australium_creation",
        generate_notes = true,
        unlocked_default = true,
        probability = 80,
        inputs = {
            "[lava]",
            "magic_liquid",
        },
        outputs = {
            "static_magic_material",
            "steam",
        },
    },
    {
        id = "gate_opener_creation",
        name = "$reac_gate_opener_creation",
        description = "$reac_desc_gate_opener_creation",
        generate_notes = true,
        unlocked_default = true,
        probability = 80,
        inputs = {
            "pus",
            "urine",
            "material_confusion",
        },
        outputs = {
            "magic_liquid",
            "magic_liquid",
        },
    },
    {
        id = "glimmer_creation",
        name = "$reac_glimmer_creation",
        description = "$reac_desc_glimmer_creation",
        generate_notes = true,
        unlocked_default = true,
        probability = 100,
        inputs = {
            "certain liquids",
            "certain glimmers",
            "australium",
        },
        outputs = {
            "air",
            "new glimmer",
            "air glimmer",
        },
    },
    -- {
    --     id = "gold_solution",
    --     name = "$reac_gold_solution",
    --     description = "$reac_desc_gold_solution",
    --     generate_notes = true,
    --     probability = 100, 
    --     inputs = { -- three ingredients is the limit
    --         "[gold]",
    --         "[gold]",
    --         "mm_alchemical_solvent",
    --     },
    --     outputs = {
    --         "mm_gold_solution",
    --         "mm_gold_solution",
    --         "mm_ephemeral_ether",
    --     },
    -- },
    -- {
    --     id = "mana_dilution",
    --     name = "$reac_mana_dilution",
    --     description = "$reac_desc_mana_dilution",
    --     generate_notes = true,
    --     probability = 100, 
    --     inputs = { -- three ingredients is the limit
    --         "magic_liquid_mana_regeneration",
    --         "magic_liquid_mana_regeneration",
    --         "mm_alchemical_base",
    --     },
    --     outputs = {
    --         "mm_diluted_mana",
    --         "mm_diluted_mana",
    --         "mm_ephemeral_ether",
    --     },
    -- },
    -- {
    --     id = "mana_refining",
    --     name = "$reac_mana_refining",
    --     description = "$reac_desc_mana_refining",
    --     generate_notes = true,
    --     probability = 100, 
    --     inputs = { -- three ingredients is the limit
    --         "mm_diluted_mana",
    --         "mm_diluted_mana",
    --         "cc_hydroxide",
    --     },
    --     outputs = {
    --         "mm_refined_mana",
    --         "mm_ephemeral_ether",
    --         "mm_ephemeral_ether",
    --     },
    -- },
}