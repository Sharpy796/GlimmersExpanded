dofile_once("data/scripts/lib/utilities.lua")
ModMaterialsFileAdd("mods/GlimmersExpanded/files/material_override.xml")
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModLuaFileAppend("data/scripts/biomes/lake_deep.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModMagicNumbersFileAdd("mods/GlimmersExpanded/files/magic_numbers.xml") -- For testing purposes

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/GlimmersExpanded/translations.csv")
translations = translations .. new_translations
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)

local isPrideGlimmersEnabled = ModIsEnabled("pride_glimmers")

-- Thanks Graham for this bit of code, it looks very useful
local patches = {
	-- { -- Dummy line
    --     path    = "data/scripts/buildings/bunker_check.lua",
    --     from    = "EntityKill%( entity_id %)",
    --     to      = [[EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550]]..((isPrideGlimmersEnabled and [[+60,]]) or [[,]])..[[ 396]]..((isPrideGlimmersEnabled and [[-5)]]) or [[)]])..[[
	-- 	EntityKill%( entity_id %)]],
    -- },
	{ -- This can break if someone else modifies this file.
        path    = "data/scripts/buildings/bunker_check.lua",
        from    = [[CreateItemActionEntity%( "COLOUR_RED"]],
        to      = [[CreateItemActionEntity%( "GLIMMERS_EXPANDED_COLOUR_WHITE", x %+ 14, y %- 7%)
	CreateItemActionEntity%( "GLIMMERS_EXPANDED_COLOUR_PINK", x %+ 26, y %- 8%)
	CreateItemActionEntity%( "COLOUR_RED"]]
    },
	{
		path	= "data/scripts/buildings/bunker_check.lua",
		from	= [[CreateItemActionEntity%( "COLOUR_BLUE"]],
		to		= [[CreateItemActionEntity%( "GLIMMERS_EXPANDED_COLOUR_TEAL", x %+ 74, y %- 11%)
	CreateItemActionEntity%( "COLOUR_BLUE"]],
	},
	{
        path    = "data/scripts/buildings/bunker_check.lua",
        from    = "EntityKill%( entity_id %)",
        to      = [[EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550]]..((isPrideGlimmersEnabled and [[+60,]]) or [[,]])..[[ 396]]..((isPrideGlimmersEnabled and [[-5)]]) or [[)]])..[[
		EntityKill%( entity_id %)]],
    },
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [["spark_purple_bright"},]],
		to		= [["spark_white", "mimic_liquid", "plasma_fading_pink", "spark_teal", "blood", "blood_cold", "acid", "magic_liquid_weakness", "lava", "material_darkness", "fungi", "magic_liquid_hp_regeneration_unstable", "midas", "void_liquid", "spark_purple_bright"},]],
	},
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[rainbow]],
		to		= [[white 	= {particle = "spark_white",}, 
	mimic		= {particle = "mimic_liquid",},
	pink		= {particle = "plasma_fading_pink",},
	teal		= {particle = "spark_teal",},
	blood		= {particle = "blood",},
	freezing	= {particle = "blood_cold",},
	acid		= {particle = "acid",},
	weakness	= {particle = "magic_liquid_weakness",},
	lava		= {particle = "lava",},
	darkness	= {particle = "material_darkness",},
	fungi		= {particle = "fungi",},
	lc			= {particle = "magic_liquid_hp_regeneration_unstable",},
	midas		= {particle = "midas",},
	trueRainbow	= {particle = "material_rainbow",},
	void		= {particle = "void_liquid",},

    -- BIOMES
	-- Main Path
	["$biome_hills"]			= {particle  = "grass",}, -- Forest (radioactive_liquid?)
	["$biome_coalmine"]			= {particle  = "liquid_fire",}, -- Mines
	["$biome_excavationsite"]	= {particle  = "slime",}, -- Coal Pits
	["$biome_snowcave"]			= {particle  = "blood_cold",}, -- Snowy Depths
	["$biome_snowcastle"]		= {particle  = "blood_cold",}, -- Hiisi Base (or steel_static?)
	["$biome_rainforest"]		= {particle  = "liquid_fire",}, -- Underground Jungle (poison maybe?)
	["$biome_vault"]			= {particle  = "acid",}, -- The Vault
	["$biome_crypt"]			= {particle  = "magic_liquid_polymorph",}, -- Temple of the Art
	["$biome_boss_arena"]		= {particle  = "spark_red",}, -- The Laboratory
	["$biome_boss_victoryroom"]	= {particle  = "gold",}, -- The Work (End)

	["$biome_holymountain"]		= {particle  = "glowstone_altar",}, -- Holy Mountain

	-- Side Biomes
	["$biome_greed_room"]		= {particle  = "gold",}, -- Hall of Wealth
	["$biome_coalmine_alt"]		= {particle  = "liquid_fire",}, -- Collapsed Mines
	["$biome_fungicave"]		= {particle  = "fungi",}, -- Fungal Caverns
	["$biome_wandcave"]			= {particle  = "radioactive_liquid",}, -- Magical Temple
	["$biome_shop_room"]		= {particle  = "gold",}, -- Secret Shop (in Hiisi Base)
	["$biome_rainforest_dark"]	= {particle  = "material_darkness",}, -- Lukki Lair

	-- West
	["$biome_winter"]			= {particle  = "blood_cold",}, -- Snowy Wasteland
	["$biome_winter_caves"]		= {particle  = "blood_cold",}, -- Snowy Chasm
	["$biome_liquidcave"]		= {particles = {"magic_liquid_berserk","magic_liquid_charm","magic_liquid_unstable_polymorph","magic_liquid_teleportation","magic_liquid_mana_regeneration"},}, -- Ancient Laboratory
	["$biome_vault_frozen"]		= {particle  = "ice_radioactive_static",}, -- Frozen Vault
	["$biome_lake"]				= {particle  = "spark_blue_dark",}, -- Lake

	-- East
	["$biome_desert"]			= {particle  = "sand",}, -- Desert
	["$biome_pyramid"]			= {particle  = "magic_liquid_random_polymorph",}, -- Pyramid
	["$biome_sandcave"]			= {particle  = "fire",}, -- Sandcave
	["$biome_watchtower"]		= {particle  = "lava",}, -- Watchtowre
	["$biome_fun"]				= {particle  = "fungi",}, -- Overgrown Cavern
	["$biome_fungiforest"]		= {particle  = "fungi",}, -- Overgrown Cavern
	["$biome_robobase"]			= {particle  = "spark_electric",}, -- Power Plant
	["$biome_meat"]				= {particle  = "pus",}, -- Meat Realm
	["$biome_wizardcave"]		= {particles   ={"magic_liquid_polymorph","magic_liquid_weakness","magic_liquid_berserk","magic_liquid_charm","magic_liquid_mana_regeneration","magic_liquid_teleportation","magic_liquid_movement_faster","magic_liquid_protection_all","magic_liquid_random_polymorph","magic_liquid_faster_levitation_and_movement","magic_liquid_invisibility","magic_liquid_faster_levitation","magic_liquid_unstable_teleportation","magic_liquid_worm_attractor",},}, -- Wizards' Den

	-- North
	["$biome_barren"]			= {particle  = "grass_holy",}, -- Barren Temple
	["$biome_potion_mimics"]	= {particle  = "mimic_liquid",}, -- Henkevä Temple
	["$biome_darkness"]			= {particle  = "material_darkness",}, -- Ominous Temple
	["$biome_clouds"]			= {particle  = "glimmers_expanded_void_liquid_variant",}, -- Cloudscape
	["$biome_the_sky"]			= {particle  = "glimmers_expanded_void_liquid_variant",}, -- The Work (Sky)

	-- South
	["$biome_lava"]				= {particle  = "lava",}, -- Volcanic Lake
	["$biome_the_end"]			= {particle  = "lava",}, -- The Work (Hell)

	-- Boss Arenas
	["$biome_secret_lab"]		= {particles = {"magic_liquid_berserk","magic_liquid_charm","magic_liquid_unstable_polymorph","magic_liquid_teleportation","magic_liquid_mana_regeneration"},}, -- Abandoned Alchemy Lab (High Alchemist)
	["$biome_dragoncave"]		= {particle  = "spark_red",}, -- Dragoncave (Dragon)
	["$biome_mestari_secret"]	= {particles = {"magic_liquid_polymorph","magic_liquid_weakness","magic_liquid_berserk","magic_liquid_charm","magic_liquid_mana_regeneration","magic_liquid_teleportation","magic_liquid_movement_faster","magic_liquid_protection_all","magic_liquid_random_polymorph","magic_liquid_faster_levitation_and_movement","magic_liquid_invisibility","magic_liquid_faster_levitation","magic_liquid_unstable_teleportation","magic_liquid_worm_attractor",},}, -- Throne Room (Master of Masters)
	["$biome_ghost_secret"]		= {particle  = "smoke",}, -- Forgotten Cave (The Forgotten)
	["$biome_boss_sky2"]		= {particle  = "spark_red",}, -- Kivi Temple

	-- Secret Locations
	["$biome_orbroom"]			= {particle  = "material_confusion",}, -- Orb Room
	["$biome_gold"]				= {particle  = "gold",}, -- The Gold
	["$biome_water"]			= {particle  = "water",}, -- Water
	["$biome_tower"]			= {particle  = "spark_red",}, -- Tower
	["$biome_null_room"]		= {particle  = "silver",}, -- Nullifying Altar"

	["???"]						= {particle  = "material_confusion",},

	["_EMPTY_"]					= {},

	[""]						= {particle  = "vomit",},
	
	rainbow]],
	},
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[local data]],
		to		= [[if ( colour == "biome" ) then
    if ( player_id ~= nil ) then
        local x, y = EntityGetTransform(player_id)
        colour = BiomeMapGetName(x,y)
        if colour == "$biome_boss_victoryroom" then
            local endroom = EntityGetWithTag("ending_sampo_spot_underground")[1]
            if endroom == nil then
                if y < 0 then 
                    colour = "$biome_the_sky"
                else
                    colour = "$biome_the_end"
                end
            end
        end
    end
end

local data]],
	},
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[comps = EntityGetComponent%( entity_id, "ParticleEmitterComponent" %)]],
		to		= [[if ( particle == "" ) then
		particle = "material_rainbow"
	end
	
	comps = EntityGetComponent( entity_id, "ParticleEmitterComponent" )]],
	},
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[local colour,particle]],
		to		= [[local player_id = EntityGetWithTag("player_unit")[1]
local colour,particle]],
	},
	{ -- Make glimmer spells work with plasma emitters. Thank you Conga Lyne!!!
        path    = "data/scripts/projectiles/colour_spell.lua",
        from    = "comps %= EntityGetComponent%( entity_id, \"ParticleEmitterComponent\" %)",
		to      = [[comps = EntityGetComponent( entity_id, "LaserEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
		-- for k=1,#comps do
			-- local v = comps[k]
			if ( particle ~= nil ) then
				ComponentObjectSetValue2( v, "laser", "beam_particle_type", CellFactory_GetType(particle))
				ComponentObjectSetValue2( v, "laser", "beam_particle_chance", 90)
			else
				ComponentObjectSetValue2( v, "laser", "beam_particle_chance", 0)
			end
		end
	end
	
	comps = EntityGetComponentIncludingDisabled( entity_id, "ParticleEmitterComponent" )]],
    },
}


-- Thanks Graham for this bit of code, it looks very useful
for i=1, #patches do
    local patch = patches[i]
    local content = ModTextFileGetContent(patch.path)
	if content ~= nil then
		content = content:gsub(patch.from, patch.to)
		content = content:gsub("\r","")
		ModTextFileSetContent(patch.path, content)
	end
end

-- function OnModInit()
	set_content = ModTextFileSetContent
	append_materials = ModMaterialsFileAdd
-- end

-- function OnBiomeConfigLoaded()
-- end

function OnPlayerSpawned(player_id)
    local x, y = EntityGetTransform(player_id)
	
	
	GameAddFlagRun( "fishing_hut_a" ) -- For testing purposes

	if GameHasFlagRun("glimmers_expanded_spliced_chunks_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
		-- CreateItemActionEntity( "COLOUR_INVIS", x, y )
		-- CreateItemActionEntity( "LASER_EMITTER", x, y )
		-- CreateItemActionEntity( "LASER_EMITTER_CUTTER", x, y )

		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/left/glimmer_lab_left.xml", 512*-24, 512*9)
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/right/glimmer_lab_right.xml", 512*-24, 512*9)
		GameAddFlagRun("glimmers_expanded_spliced_chunks_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now
	end
end

-- This code runs when all mods' filesystems are registered
-- ModMaterialsFileAdd( "mods/GlimmersExpanded/files/materials.xml" )
dofile("mods/GlimmersExpanded/files/alchemy/generate_glimmer_alchemy.lua")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua