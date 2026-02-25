dofile_once("data/scripts/lib/utilities.lua")
-- dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
ModMaterialsFileAdd("mods/GlimmersExpanded/files/material_override.xml")
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModLuaFileAppend("data/scripts/biomes/lake_deep.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
local set_text = ModTextFileSetContent
local testing = false;
if testing then ModMagicNumbersFileAdd("mods/GlimmersExpanded/files/magic_numbers.xml") end -- For testing purposes

local new_translations = ModTextFileGetContent("mods/GlimmersExpanded/translations.csv")

local isPrideGlimmersEnabled = ModIsEnabled("pride_glimmers")

-- Thanks Graham for this bit of code, it looks very useful
local patches = {
	-- { -- Dummy line
    --     path    = "data/scripts/buildings/bunker_check.lua",
    --     from    = "EntityKill( entity_id )",
    --     to      = [[EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550]]..((isPrideGlimmersEnabled and [[+60,]]) or [[,]])..[[ 396]]..((isPrideGlimmersEnabled and [[-5)]]) or [[)]])..[[
	-- 	EntityKill( entity_id )]],
    -- },
	{ -- This can break if someone else modifies this file. TODO: Find a way to append this, rather than gsubbing
        path    = "data/scripts/buildings/bunker_check.lua",
        from    = [[CreateItemActionEntity( "COLOUR_RED"]],
        to      = [[CreateItemActionEntity( "GLIMMERS_EXPANDED_COLOUR_WHITE", x + 14, y - 7)
	CreateItemActionEntity( "GLIMMERS_EXPANDED_COLOUR_PINK", x + 26, y - 8)
	CreateItemActionEntity( "COLOUR_RED"]]
    },
	{
		path	= "data/scripts/buildings/bunker_check.lua",
		from	= [[CreateItemActionEntity( "COLOUR_BLUE"]],
		to		= [[CreateItemActionEntity( "GLIMMERS_EXPANDED_COLOUR_TEAL", x + 74, y - 11)
	CreateItemActionEntity( "COLOUR_BLUE"]],
	},
	{
        path    = "data/scripts/buildings/bunker_check.lua",
        from    = "EntityKill( entity_id )",
        to      = [[EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550]]..((isPrideGlimmersEnabled and [[+60,]]) or [[,]])..[[ 396]]..((isPrideGlimmersEnabled and [[-5)]]) or [[)]])..[[
		EntityKill( entity_id )]],
    },
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [["spark_purple_bright"},]],
		to		= [["spark_purple_bright"},]],
	},
	{
		path	= "data/scripts/projectiles/colour_spell.lua",
		from	= [[rainbow]],
		to		= [[rainbow]],
	},
}

local function recursive_translation(string)
    local pattern = "%$%w[%w_]+"
    string = string:gsub(pattern, GameTextGetTranslatedOrNot, 1)
    if string:find(pattern) then
        return recursive_translation(string)
    else
        return string
    end
end

local function createTranslation(id, data)
	-- print("creating translations for '"..id:lower().."' with name '"..data.name.."'")
	-- print("is "..data.name.." a translation? "..tostring(geIsTranslation(data.name)))
	if not geIsTranslation(data.name) then
		new_translations = new_translations..[[,
action_]]..id:lower()..[[,"]]..data.name..[[",,,,,,,,,,,,,]]
	end
	if not geIsTranslation(data.desc) then
		new_translations = new_translations..[[,
actiondesc_]]..id:lower()..[[,"]]..data.desc..[[",,,,,,,,,,,,,]]
	end
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
		-- patches[4].to = [["]]..data.materials[1]..[[", ]]..patches[4].to
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
	local translations = ModTextFileGetContent("data/translations/common.csv")
	translations = translations .. new_translations
	translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
	ModTextFileSetContent("data/translations/common.csv", translations)
end

-- Thanks Evasia for this bit of code, it is incredibly useful
local function escape(str) 
	return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
end

local function patchFiles()
	-- Thanks Graham for this bit of code, it looks very useful
	for i=1, #patches do
	    local patch = patches[i]
	    local content = ModTextFileGetContent(patch.path)
		if content ~= nil then
			content = content:gsub(escape(patch.from), escape(patch.to), 1)
			content = content:gsub("\r","")
			ModTextFileSetContent(patch.path, content)
		end
	end
end

function OnModPreInit()
	dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
	loadGlimmers()
	updateTranslations()
	print("CATCH YOUR HAMIS")
	patchFiles()
	dofile_once("mods/GlimmersExpanded/files/scripts/gun/fix_glimmers.lua")
	ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua
end

function OnModPostInit()
	dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_hex_globals.lua")
	hex_projectiles(set_text)
	print("Hexed projectiles.")
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