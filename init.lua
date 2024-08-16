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
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [["spark_purple_bright"},]],
		to		= [["spark_white", "mimic_liquid", "plasma_fading_pink", "spark_teal", "blood", "blood_cold", "acid", "magic_liquid_weakness", "lava", "material_darkness", "fungi", "magic_liquid_hp_regeneration_unstable", "midas", "void_liquid", "spark_purple_bright"},]],
	},
	{
        path    = "data/scripts/buildings/bunker_check.lua",
        from    = "EntityKill%( entity_id %)",
        to      = [[EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550]]..((isPrideGlimmersEnabled and [[+60,]]) or [[,]])..[[ 396]]..((isPrideGlimmersEnabled and [[-5)]]) or [[)]])..[[
		EntityKill%( entity_id %)]],
    },
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[rainbow]],
		to		= [[white = {particle = "spark_white",}, 
	mimic		= {particle = "mimic_liquid",},
	pink		= {particle = "plasma_fading_pink",},
	teal		= {particle = "spark_teal",},
	blood		= {particle = "blood",},
	freezing	= {particle="blood_cold",},
	acid		= {particle="acid",},
	weakness	= {particle="magic_liquid_weakness",},
	lava		= {particle="lava",},
	darkness	= {particle="material_darkness",},
	fungi		= {particle="fungi",},
	lc			= {particle="magic_liquid_hp_regeneration_unstable",},
	midas		= {particle="midas",},
	trueRainbow	= {particle="material_rainbow",},
	void		= {particle="void_liquid",},
	rainbow]],
	},
	{ -- Make glimmer spells work with plasma emitters. Thank you Conga Lyne!!!
        path    = "data/scripts/projectiles/colour_spell.lua",
        from    = "comps %= EntityGetComponent%( entity_id, \"ParticleEmitterComponent\" %)",
        to      = "comps = EntityGetComponent( entity_id, \"LaserEmitterComponent\" ) or {} for k=1,#comps do local v = comps[k] ComponentObjectSetValue2( v, \"laser\", \"beam_particle_type\", CellFactory_GetType(particle)) end comps = EntityGetComponent( entity_id, \"ParticleEmitterComponent\" )",
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

function OnPlayerSpawned(player_id)
    local x, y = EntityGetTransform(player_id)
	
	
	-- GameAddFlagRun( "fishing_hut_a" ) -- For testing purposes

	if GameHasFlagRun("glimmers_expanded_spliced_chunks_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/left/glimmer_lab_left.xml", 512*-24, 512*9)
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/right/glimmer_lab_right.xml", 512*-24, 512*9)
		GameAddFlagRun("glimmers_expanded_spliced_chunks_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now
	end
end

-- This code runs when all mods' filesystems are registered
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua