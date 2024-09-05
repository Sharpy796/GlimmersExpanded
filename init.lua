dofile_once("data/scripts/lib/utilities.lua")
-- dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
ModMaterialsFileAdd("mods/GlimmersExpanded/files/material_override.xml")
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModLuaFileAppend("data/scripts/biomes/lake_deep.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
local testing = false;
if testing then ModMagicNumbersFileAdd("mods/GlimmersExpanded/files/magic_numbers.xml") end -- For testing purposes

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/GlimmersExpanded/translations.csv")

local isPrideGlimmersEnabled = ModIsEnabled("pride_glimmers")

-- Thanks Graham for this bit of code, it looks very useful
local patches = {
	-- { -- Dummy line
    --     path    = "data/scripts/buildings/bunker_check.lua",
    --     from    = "EntityKill%( entity_id %)",
    --     to      = [[EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550]]..((isPrideGlimmersEnabled and [[+60,]]) or [[,]])..[[ 396]]..((isPrideGlimmersEnabled and [[-5)]]) or [[)]])..[[
	-- 	EntityKill%( entity_id %)]],
    -- },
	{ -- This can break if someone else modifies this file. TODO: Find a way to append this, rather than gsubbing
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
		to		= [["spark_purple_bright"},]],
	},
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[rainbow]],
		to		= [[-- BIOMES
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
	["$biome_watchtower"]		= {particle  = "lava",}, -- Watchtower
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
		to		= [[if ( colour == "glimmers_expanded_colour_biome" ) then
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

local function createTranslation(id, data)
	-- print("creating translations for '"..id:lower().."' with name '"..data.name.."'")
	new_translations = new_translations..[[,
action_]]..id:lower()..[[,"]]..data.name..[[",,,,,,,,,,,,,
actiondesc_]]..id:lower()..[[,"]]..data.desc..[[",,,,,,,,,,,,,]]
end

local function createGlimmerXML(id, data)
	local trail_mods = data.trail_mods
	local template = ModTextFileGetContent("mods/GlimmersExpanded/files/entities/misc/colour_template.xml")
	local filepath = "mods/GlimmersExpanded/files/entities/misc/"..id:lower()..".xml"
	ModTextFileSetContent(filepath, template)

    ---@type nxml
    local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
	for xml in nxml.edit_file(filepath) do
		-- edit the VariableStorageComponent
		local vscomp = xml:first_of("VariableStorageComponent")
		if vscomp then vscomp:set("value_string", id:lower()) end

		-- edit the ParticleEmitterComponent
		local pecomp = xml:first_of("ParticleEmitterComponent")
		if pecomp then
			pecomp:set("emitted_material_name", data.materials[1])
			if trail_mods then
				for k_mods,v_mods in pairs(trail_mods) do
					pecomp:set(tostring(k_mods),tostring(v_mods))
				end
			end
			pecomp:set("create_real_particles","0")
		end
	end
end

local function createColourSpellLuaEntry(id, data)
	if id ~= "GLIMMERS_EXPANDED_COLOUR_BIOME" then
		-- print("Creating colour_spell.lua entry for '"..id:lower()..[[ = {particle = "]]..data.materials[1]..[[",},]])
		patches[4].to = [["]]..data.materials[1]..[[", ]]..patches[4].to
		patches[5].to = id:lower()..[[ = {particle = "]]..data.materials[1]..[[",},
	]]..patches[5].to
	end
end

local function loadGlimmers()
	for id, data in pairs(glimmer_list_revamped) do
		createTranslation(id, data)
		createGlimmerXML(id, data)
		createColourSpellLuaEntry(id, data)
	end
end

local function updateTranslations()
	translations = translations .. new_translations
	translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
	ModTextFileSetContent("data/translations/common.csv", translations)
end

local function patchFiles()
	-- Thanks Graham for this bit of code, it looks very useful
	for i=1, #patches do
	    local patch = patches[i]
	    local content = ModTextFileGetContent(patch.path)
		if content ~= nil then
			content = content:gsub(patch.from, patch.to, 1)
			content = content:gsub("\r","")
			ModTextFileSetContent(patch.path, content)
		end
	end
end

function OnModPreInit()
	dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
	loadGlimmers()
	updateTranslations()
	patchFiles()
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua
end

function OnPlayerSpawned(player_id)
    -- local x, y = EntityGetTransform(player_id)
	if testing then GameAddFlagRun( "fishing_hut_a" ) end -- For testing purposes
	if GameHasFlagRun("glimmers_expanded_spliced_chunks_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/left/glimmer_lab_left.xml", 512*-24, 512*9)
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/right/glimmer_lab_right.xml", 512*-24, 512*9)
		GameAddFlagRun("glimmers_expanded_spliced_chunks_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now
	end
end

function OnMagicNumbersAndWorldSeedInitialized()
	if (ModSettingGet("GlimmersExpanded.allow_alchemy")) then dofile("mods/GlimmersExpanded/files/alchemy/generate_glimmer_alchemy.lua") end
end

function OnWorldInitialized()
	if (ModIsEnabled("kae_waypoint")) then
    	dofile_once("mods/kae_waypoint/data/kae/poi.lua")
    	add_poi("Glimmer Lab", -12015, 4990)
	end
end


-- This code runs when all mods' filesystems are registered
ModMaterialsFileAdd("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml")