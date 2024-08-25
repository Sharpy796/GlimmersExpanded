dofile_once("data/scripts/lib/utilities.lua")
dofile_once("mods/GlimmersExpanded/files/lib/myFancyNewColors.lua")
dofile_once("mods/GlimmersExpanded/files/lib/glimmer_list_revamped.lua")
dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
ModMaterialsFileAdd("mods/GlimmersExpanded/files/material_override.xml")
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModLuaFileAppend("data/scripts/biomes/lake_deep.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModMagicNumbersFileAdd("mods/GlimmersExpanded/files/magic_numbers.xml") -- For testing purposes

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

local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"

local function createGlimmerXML(id, data)
	-- print("Creating 'mods/GlimmersExpanded/files/entities/misc/"..id:lower()..".xml' with value_string '"..id:lower().."'")
	local xml = [[<Entity>
   
	<LuaComponent
		script_source_file="data/scripts/projectiles/colour_spell.lua"
		execute_every_n_frame="1"
		remove_after_executed="1"
		>
	</LuaComponent>
	
	<LuaComponent
		script_source_file="data/scripts/projectiles/colour_spell.lua"
		execute_on_added="1"
		remove_after_executed="1"
		>
	</LuaComponent>
	
	<VariableStorageComponent
		name="colour_name"
		value_string="]]..id:lower()..[["
		>
	</VariableStorageComponent>
  
    <ParticleEmitterComponent 
          emitted_material_name="]]..data.materials[1]..[["
          offset.x="0"
          offset.y="0"
          x_pos_offset_min="-1"
          x_pos_offset_max="1"
          y_pos_offset_min="-1"
          y_pos_offset_max="1"
          gravity.y="0"
          x_vel_min="-2"
          x_vel_max="2"
          y_vel_min="-2"
          y_vel_max="2"
          count_min="1"
          count_max="1"
          is_trail="1"
          trail_gap="1"
          fade_based_on_lifetime="1"
          lifetime_min="0.8"
          lifetime_max="2.0"
          airflow_force="1.5"
          airflow_time="0.401"
          airflow_scale="0.05"
          create_real_particles="0"
          emit_cosmetic_particles="1"
          render_on_grid="1"
          emission_interval_min_frames="1"
          emission_interval_max_frames="2"
          is_emitting="1" >
      </ParticleEmitterComponent>
</Entity>]]
	ModTextFileSetContent("mods/GlimmersExpanded/files/entities/misc/"..id:lower()..".xml", xml)
	return xml
end

local function createColourSpellLuaEntry(id, data)
	if id ~= "GLIMMERS_EXPANDED_COLOUR_BIOME" then
		-- print("Creating colour_spell.lua entry for '"..id:lower()..[[ = {particle = "]]..data.materials[1]..[[",},]])
		patches[4].to = [["]]..data.materials[1]..[[", ]]..patches[4].to
		patches[5].to = id:lower()..[[ = {particle = "]]..data.materials[1]..[[",},
	]]..patches[5].to
	end
end

local function createTranslation(id, data)
	-- print("creating translations for '"..id:lower().."' with name '"..data.name.."'")
	new_translations = new_translations..[[,
action_]]..id:lower()..[[,"]]..data.name..[[",,,,,,,,,,,,,
actiondesc_]]..id:lower()..[[,"]]..data.desc..[[",,,,,,,,,,,,,]]
end

local function insertIntoProgress(id, data)
	local sort_after = data.sort_after
	local entry = {id=id, sort_after=sort_after}
	print("Inserting '"..id.."' into '"..sort_after.."' in progress")
	table.insert(organizedGlimmerList, entry)
end

local function checkForSameSortTag(list, entry, index)
	if index-1 < 1 and entry.sort_after == "FIRST" then
		return true
	elseif index-1 < 1 then
		return false
	else
		
	end


	return entry.sort_after == list[index-1]
end

local function sortProgress()
	table.sort(organizedGlimmerList, sortingFunction)
end

function sortingFunction(entry1, entry2)
	return entry1.sort_after < entry2.sort_after
end

-- local function sortProgress()
-- 	repeat
-- 		local isSorted = true
-- 		-- take the organized table...
-- 		-- then loop through it...
-- 		for index1,entry1 in ipairs(organizedGlimmerList) do
-- 			-- when we encounter one of the spells...
-- 			-- check what it should actually be after
-- 			local sort_after = entry1.sort_after
-- 			-- if it's not after what it should be after...
-- 			if sort_after ~= "" then
-- 				if sort_after == "FIRST" and index1-1 > 1 then
-- 					local misplaced_entry = table.remove(organizedGlimmerList, index1)
-- 					table.insert(organizedGlimmerList, 1, misplaced_entry)
-- 					isSorted = false
-- 					break
-- 				-- elseif(index1-1 < 1 and sort_after ~= "FIRST") or (index1-1 > 0 and organizedGlimmerList[index1-1].id ~= sort_after ) then
-- 				elseif(index1-1 < 1 and sort_after ~= "FIRST") or (index1-1 > 0 and organizedGlimmerList[index1-1].id ~= sort_after ) then
-- 					-- remove it from the list
-- 					local misplaced_entry = table.remove(organizedGlimmerList, index1)
-- 					-- find where it should be
-- 					for index2,entry2 in ipairs(organizedGlimmerList) do
-- 						if entry2.id == sort_after then
-- 							-- put it back
-- 							-- print("Moving '"..entry1.id.."' from after '"..tostring(organizedGlimmerList[index1-1].id).."' to after '"..entry2.id.."' (sort_after is '"..sort_after.."')")
-- 							table.insert(organizedGlimmerList, index2+1, misplaced_entry)
-- 							isSorted = false
-- 							break
-- 						end
-- 					end
-- 					isSorted = false
-- 					break
-- 				end
-- 			end
-- 		end
-- 	until isSorted
-- end

local action_appends = [[local originalGlimmers = {
	["COLOUR_RED"]=true,
	["COLOUR_ORANGE"]=true,
	["COLOUR_YELLOW"]=true,
	["COLOUR_GREEN"]=true,
	["COLOUR_BLUE"]=true,
	["COLOUR_PURPLE"]=true,
	["COLOUR_RAINBOW"]=true,
	["COLOUR_INVIS"]=true,
}

local function split(string)
	local myTable = {}
	for i in string.gmatch(string, "%P+") do
		table.insert(myTable, i)
	end
	return myTable
end

-- Add together all spawn rates (hardcoded bc I did the math myself)
local total_spawns = {
	["1"]={prob=0.2,amt=1},
	["2"]={prob=1.5,amt=8},
	["3"]={prob=1.4,amt=8},
	["4"]={prob=1.5,amt=8},
	["5"]={prob=0.2,amt=1},
	["6"]={prob=0.2,amt=1},
	["7"]={prob=0,amt=0},
	["10"]={prob=0.3,amt=2},
}

local myFancyNewColors = {]]
local function createGlimmerAction (Id, image, wait_frames, spawn_tiers, unlock_flag)
	local MOD_ID = Mod_Id:upper()
	local mod_id = Mod_Id:lower()
	local ID = Id:upper()
	local id = Id:lower()
	if wait_frames == nil then wait_frames = 8 end
	if image == nil then image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png" end
	-- if spawn_list == nil then spawn_list = {["1"]="0.2",["2"]="0.2",["3"]="0.4",["4"]="0.2",["5"]="0.2",["6"]="0.2"} end
	if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end
	if unlock_flag == nil then unlock_flag = "card_unlocked_paint" end

	-- local spawn_tiers, spawn_probs = "", ""
	-- for tier, prob in pairs(spawn_list) do
	-- 	spawn_tiers = spawn_tiers .. tier
	-- 	spawn_probs = spawn_probs .. prob
	-- 	if spawn_list[tier] ~= spawn_list[#spawn_list] then
	-- 		spawn_tiers = spawn_tiers .. ","
	-- 		spawn_probs = spawn_probs .. ","
	-- 	end
	-- end


	local newGlimmer = [[
	{
		id 						= "]]..ID..[[",
		name 					= "$action_]]..id..[[",
		description 			= "$actiondesc_]]..id..[[",
		sprite 					= "]]..image..[[",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/]]..id..[[.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "]]..spawn_tiers..[[",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2",
		spawn_requires_flag 	= "]]..unlock_flag..[[",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/]]..id..[[.xml,"
			c.fire_rate_wait = c.fire_rate_wait - ]]..wait_frames..[[
			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},]]
	action_appends = action_appends .. newGlimmer
	return newGlimmer
end

for id, data in pairs(glimmer_list_revamped) do
	createTranslation(id, data)
	createGlimmerXML(id, data)
	createColourSpellLuaEntry(id, data)
	insertIntoProgress(id, data)
	createGlimmerAction(id, data.image, data.cast_delay, data.spawn_tiers)
end

sortProgress()

action_appends = action_appends..[[}
local organizedGlimmerList = {]]
for _,entry in ipairs(organizedGlimmerList) do
	action_appends = action_appends..[["]].. entry.id ..[[",
]]
end

action_appends = action_appends..[[}

-- Take the average of all spawn rates
for level,data in pairs(total_spawns) do
	total_spawns[level].prob = total_spawns[level].prob/(total_spawns[level].amt)
end


local function setSpawnProbs(action)
    -- print("----------- "..action.id.." -----------")
	-- replace spawn probs with averaged ones
	local spawn_levels = split(action.spawn_level)
	-- local spawn_probability = split(color.spawn_probability, ",")
	local new_probabilities = ""
	for index,level in ipairs(spawn_levels) do
        -- print("'"..action.id.."', tier '"..level.."', probability '"..total_spawns[level].prob.."', amount '"..total_spawns[level].amt.."'")
		new_probabilities = new_probabilities..total_spawns[level].prob
		if index < #spawn_levels then
			new_probabilities = new_probabilities .. ","
		end
	end
    return new_probabilities
end

-- Find averages
for _, color in ipairs(myFancyNewColors) do
	local spawn_levels = split(color.spawn_level)
	for index,level in ipairs(spawn_levels) do
        total_spawns[level].prob = total_spawns[level].prob * total_spawns[level].amt
        total_spawns[level].amt = total_spawns[level].amt+1
        total_spawns[level].prob = total_spawns[level].prob / total_spawns[level].amt
    end
end

for _, color in ipairs(myFancyNewColors) do
	color.spawn_probability = setSpawnProbs(color)

	-- print("inserting spell '"..color.id.."' into actions")
	table.insert(actions,color)
end

for _, action in ipairs(actions) do
    if originalGlimmers[action.id] then
        action.spawn_probability = setSpawnProbs(action)
    end
end

if ModSettingGet("GlimmersExpanded.inject_spells") then

	local allGlimmerList = {}
	for pos, entry in ipairs(organizedGlimmerList) do
		allGlimmerList[entry] = pos
	end

	for pos, action in ipairs(actions) do
		if pos >= #actions then break end
		local id = action.id
		local isGlimmer = allGlimmerList[id]
		if isGlimmer then
			repeat
				id = actions[pos].id
				isGlimmer = allGlimmerList[id]
				if isGlimmer then
					organizedGlimmerList[isGlimmer] = table.remove(actions, pos)
				end
			until (not isGlimmer) or pos > #actions
		end
	end
	-- print("Finished populating glimmer_list and removing spells from list")

	for pos, action in ipairs(actions) do
		if pos > #actions then
			for _, entry in ipairs(organizedGlimmerList) do
				table.insert(actions, entry)
			end
		elseif action.id == "IF_ELSE" then
			for _, entry in ipairs(organizedGlimmerList) do
				-- print("inserting '"..id.."' at position "..(pos))
				if entry then
					pos = pos + 1
					table.insert(actions, pos, entry)
				end
			end
			break
		end
	end
	-- print("Finished inserting spells back into list")
end]]

local function tableToString(name, table)
	local string = "local "..name.." = "
	for k,v in pairs(table) do
		string = string..[[
		[]]..k..[[] = ]]..v
	end
end

translations = translations .. new_translations
translations = translations:gsub("\r", ""):gsub("\n\n+", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)
ModTextFileSetContent("mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua", action_appends)

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

function OnPlayerSpawned(player_id)
    -- local x, y = EntityGetTransform(player_id)
	GameAddFlagRun( "fishing_hut_a" ) -- For testing purposes
	if GameHasFlagRun("glimmers_expanded_spliced_chunks_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/left/glimmer_lab_left.xml", 512*-24, 512*9)
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/right/glimmer_lab_right.xml", 512*-24, 512*9)
		GameAddFlagRun("glimmers_expanded_spliced_chunks_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now
	end
end

function OnMagicNumbersAndWorldSeedInitialized()
	if (ModSettingGet("GlimmersExpanded.allow_alchemy")) then dofile("mods/GlimmersExpanded/files/alchemy/generate_glimmer_alchemy.lua") end
end

-- This code runs when all mods' filesystems are registered
ModMaterialsFileAdd("mods/GlimmersExpanded/files/alchemy/glimmer_alchemy_materials.xml")
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua