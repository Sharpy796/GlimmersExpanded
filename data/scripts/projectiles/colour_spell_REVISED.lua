dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local mixing = ModSettingGet("GlimmersExpanded.glimmer_mixing")
local player_id = EntityGetWithTag("player_unit")[1]
local colour,particle
local colors = dofile("mods/GlimmersExpanded/files/alchemy/glimmer_colors.lua")
---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_materials.lua")
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_hex_globals.lua")

local function create_dummy_entry(spritefilepath, particle, pcolor, hex)
	local dummyfilepath = "mods/GlimmersExpanded/files/dummyFiles/"..particle.."/"..spritefilepath

	if not ModDoesFileExist(dummyfilepath) then
		ModTextFileSetContent( dummyfilepath, ModTextFileGetContent(spritefilepath) )
		if pcolor ~= nil then
			add_hex(spritefilepath, dummyfilepath, pcolor)
		else
			add_hex(spritefilepath, dummyfilepath, hex)
		end
	end
	return dummyfilepath
end

local function edit_dummy_sprite(dummyfilepath, r, g, b, a)
	for xml in nxml.edit_file(dummyfilepath) do
		if xml ~= nil then
			-- print("XML IS BEING EDITED")
			-- print("R:\t"..(r or "nil"))
			-- print("G:\t"..(g or "nil"))
			-- print("B:\t"..(b or "nil"))
			-- print("A:\t"..(a or "nil"))
			xml:set("color_r",r)
			xml:set("color_g",g)
			xml:set("color_b",b)
			xml:set("color_a",a)
		end
	end
end

local function material_to_rgba(material)
	local hex
	for mat in materials:each_child() do
		if get_elem_data(mat,"name") == material then
			hex = lamas_stats_get_graphics_info(mat)
			if hex ~= nil then
				-- print("-- HEX RAN")
				return hex, hex_to_rgba(hex)
			end
		end
	end
end

local comps = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		local name = ComponentGetValue2( v, "name" )
		
		if ( name == "colour_name" ) then
			colour = ComponentGetValue2( v, "value_string" )
		end
	end
end

if ( colour == "glimmers_expanded_colour_biome" ) then
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


local data =
{
	red =
	{
		particle = "spark_red",
	},
	orange =
	{
		particle = "spark",
	},
	yellow =
	{
		particle = "spark_yellow",
	},
	green =
	{
		particle = "spark_green",
	},
	blue =
	{
		particle = "plasma_fading",
	},
	purple =
	{
		particle = "spark_purple_bright",
	},
	glimmers_expanded_colour_freezing_liquid = {particle = "blood_cold",},
	glimmers_expanded_colour_white = {particle = "spark_white",},
	glimmers_expanded_colour_teal = {particle = "spark_teal",},
	glimmers_expanded_colour_fire = {particle = "fire",},
	glimmers_expanded_colour_midas = {particle = "midas",},
	glimmers_expanded_colour_weird_fungus = {particle = "fungi",},
	glimmers_expanded_colour_diminution = {particle = "magic_liquid_weakness",},
	glimmers_expanded_colour_pink = {particle = "plasma_fading_pink",},
	glimmers_expanded_colour_true_rainbow = {particle = "material_rainbow",},
	glimmers_expanded_colour_mimicium = {particle = "mimic_liquid",},
	glimmers_expanded_colour_lively_concoction = {particle = "magic_liquid_hp_regeneration_unstable",},
	glimmers_expanded_colour_divine_ground = {particle = "grass_holy",},
	glimmers_expanded_colour_void = {particle = "void_liquid",},
	glimmers_expanded_colour_blood = {particle = "blood",},
	glimmers_expanded_colour_lava = {particle = "lava",},
	glimmers_expanded_colour_ominous = {particle = "material_darkness",},
	glimmers_expanded_colour_acid = {particle = "acid",},
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
	
	rainbow =
	{
		particles = {"spark_red", "spark", "spark_yellow", "spark_green", "plasma_fading", "blood_cold", "spark_white", "spark_teal", "fire", "midas", "fungi", "magic_liquid_weakness", "plasma_fading_pink", "material_rainbow", "mimic_liquid", "magic_liquid_hp_regeneration_unstable", "grass_holy", "void_liquid", "blood", "lava", "material_darkness", "acid", "spark_purple_bright"},
	},
	invis =
	{
	},
}

if ( colour ~= nil ) then
	local d = data[colour] or {}
	particle = d.particle
	
	if ( d.particles ~= nil ) then
		SetRandomSeed( entity_id, entity_id )
		local rnd = Random( 1, #d.particles )
		particle = d.particles[rnd]
	end
	
	if ( particle == "" ) then
		particle = "material_rainbow"
	end
	
	comps = EntityGetComponent( entity_id, "LaserEmitterComponent" )
	if ( comps ~= nil ) then
		if mixing and colour ~= "invis" then
			local beam_particle_chance = 90
			local bpc = 0
			for i,v in ipairs(comps) do
				bpc = ComponentObjectGetValue2(v, "laser", "beam_particle_chance")
				if bpc > 0 then
					beam_particle_chance = bpc
					break
				end
			end
			local lec = EntityAddComponent2( entity_id, "LaserEmitterComponent")
			comps = EntityGetComponent( entity_id, "LaserEmitterComponent" )

			ComponentSetValue2( lec, "laser_angle_add_rad", ComponentGetValue2(comps[1], "laser_angle_add_rad"))
			ComponentObjectSetValue2( lec, "laser", "beam_particle_type", CellFactory_GetType(particle))
			ComponentObjectSetValue2( lec, "laser", "max_cell_durability_to_destroy", 0)
			ComponentObjectSetValue2( lec, "laser", "damage_to_cells", 0)
			ComponentObjectSetValue2( lec, "laser", "damage_to_entities", 0)
			ComponentObjectSetValue2( lec, "laser", "hit_particle_chance", 0)
			ComponentObjectSetValue2( lec, "laser", "audio_enabled", false)
			ComponentObjectSetValue2( lec, "laser", "max_length", ComponentObjectGetValue2(comps[1], "laser", "max_length"))
			ComponentObjectSetValue2( lec, "laser", "beam_radius", ComponentObjectGetValue2(comps[1], "laser", "beam_radius"))
			
			for i,v in ipairs( comps ) do
				if ComponentObjectGetValue2( v, "laser", "beam_particle_chance") > 0 then
					ComponentObjectSetValue2( v, "laser", "beam_particle_chance", beam_particle_chance-(2*(i-1)))
				end
			end
		else
			for i,v in ipairs( comps ) do
				if ( particle ~= nil ) then
					ComponentObjectSetValue2( v, "laser", "beam_particle_type", CellFactory_GetType(particle))
				else
					ComponentObjectSetValue2( v, "laser", "beam_particle_chance", 0)
				end
			end
		end
	end
	
	comps = EntityGetComponent( entity_id, "ParticleEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			if (mixing and i == #comps) or (not mixing) or (colour == "invis") then
		    	local cosmetic = ComponentGetValue2( v, "emit_cosmetic_particles" )
			
			if cosmetic then
				if ( particle ~= nil ) then
					ComponentSetValue2( v, "emitted_material_name", particle )
				else
					ComponentSetValue2( v, "is_emitting", false )
		    		end
				end
			end
		end
	end
	
	comps = EntityGetComponent( entity_id, "SpriteParticleEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			ComponentSetValue2( v, "is_emitting", false )
		end
	end

	comps = EntityGetComponent( entity_id, "SpriteComponent" )
	if ( comps ~= nil ) then
		if (particle ~= nil) then
			local spritefilepath, dummyfilepath, spriteoriginal, pcolor, potioncomp
			local hex = "FFFFFFFF"
			local r,g,b,a = 1,1,1,1

			-- Adding PotionComponent for the very first sprite 
			potioncomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PotionComponent" )
			if ( potioncomp ~= nil ) then
				ComponentSetValue2( potioncomp, "custom_color_material", CellFactory_GetType(particle) )
			else
				potioncomp = EntityAddComponent2( entity_id, "PotionComponent", {
					custom_color_material = CellFactory_GetType(particle)
				})
			end

			-- Checking the color for later & for additive check
			pcolor = GameGetPotionColorUint( entity_id )
			if pcolor ~= nil then
				r,g,b = uint_to_rgb(pcolor)
			end

			-- If no potion stuff, then use hex instead
			if potioncomp == nil or pcolor == nil or r == nil or g == nil or b == nil then
				hex,r,g,b,a = material_to_rgba(particle)
			end

			-- Loop through SpriteComponents
			for i,v in ipairs( comps ) do
				ComponentSetValue2( v, "visible", true )

				local additive = ComponentGetValue2(v, "additive") -- Only used the first time
				-- Creates vsc to hold information between glimmers
				local vsc = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "spriteoriginal"..i)
				if vsc ~= nil then
					additive = ComponentGetValue2(vsc, "value_bool")
					-- print("ADDITIVE:\t"..tostring(additive or "nil"))
				end

				-- Additive check
				if r <= 0.1 and g <= 0.1 and b <= 0.1 then
					ComponentSetValue2( v, "additive", false)
				else
					ComponentSetValue2( v, "additive", additive)
				end

				if #comps <= 1 then
					if vsc == nil then
						vsc = EntityAddComponent(entity_id, "VariableStorageComponent", {
							name="spriteoriginal"..i,
							value_bool=additive,
						})
						ComponentAddTag(vsc, "spriteoriginal"..i)
					end
					EntityRefreshSprite( entity_id, v )
					break
				end

				spritefilepath = ComponentGetValue2( v, "image_file" )
				spriteoriginal = spritefilepath

				if vsc == nil then
					vsc = EntityAddComponent(entity_id, "VariableStorageComponent", {
						name="spriteoriginal"..i,
						value_string=spriteoriginal,
						value_bool=additive,
					})
					ComponentAddTag(vsc, "spriteoriginal"..i)
				end

				

				spritefilepath = ComponentGetValue(vsc, "value_string")
				dummyfilepath = create_dummy_entry(spritefilepath, particle, pcolor, hex)
				ComponentSetValue2( v, "image_file", dummyfilepath )

				edit_dummy_sprite(dummyfilepath, r, g, b, a)

				EntityRefreshSprite( entity_id, v )
			end
		else
			for i,v in ipairs( comps ) do
				ComponentSetValue2( v, "visible", false )
			end
		end
	end
	
	comps = EntityGetComponent( entity_id, "ProjectileComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			if (mixing and i == #comps) or (not mixing) or (colour == "invis") then
				local spriteoriginal = ComponentObjectGetValue2(v, "config_explosion", "explosion_sprite")
				-- print("SPRITEORIGINAL:\t"..tostring(spriteoriginal))
				local additive = ComponentObjectGetValue2(v, "config_explosion", "explosion_sprite_additive") -- Only used the first time
				-- Creates vsc to hold information between glimmers
				local vsc = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", "explosionspriteoriginal"..i)
				if vsc ~= nil then -- else we will create one later
					additive = ComponentGetValue2(vsc, "value_bool")
				end
				local hex,r,g,b,a
				if particle ~= nil then
					hex,r,g,b,a = material_to_rgba(particle)
					-- Additive check
					if r <= 0.1 and g <= 0.1 and b <= 0.1 then
						ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite_additive", false)
					else
						ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite_additive", additive)
					end
				end
				if vsc == nil then
					vsc = EntityAddComponent(entity_id, "VariableStorageComponent", {
						name="explosionspriteoriginal"..i,
						value_string=spriteoriginal,
						value_bool=additive,
					})
					ComponentAddTag(vsc, "explosionspriteoriginal"..i)
				end


				if ( particle ~= nil ) then
					local spritefilepath = ComponentGetValue2(vsc, "value_string")
					local spritefilepaths = {}
					local post = false
					local prefix, postfix = "", ""
					local found, num = false, "0"
					local min, max = 1, 1
					for c in spritefilepath:gmatch"." do
						if c == "$" then
							found = true
						elseif post then
							postfix = postfix..c
						elseif found then
							if c == "]" then
								if tonumber(num) ~= nil then
									max = tonumber(num)
									print("MAX:\t"..tostring(max))
								end
								post = true
							elseif c == "-" then
								if tonumber(num) ~= nil then
									min = tonumber(num)
									print("MIN:\t"..tostring(max))
								end
								num = "0"
							else
								num = num..c
							end
						else
							prefix = prefix..c
						end
					end

					print("PREFIX:\t"..prefix)
					print("POSTFIX:\t"..postfix)

					if found then
						local dummyfilepath
						for x=tonumber(min), tonumber(max) do
							dummyfilepath = create_dummy_entry(prefix..x..postfix, particle, nil, hex)
							edit_dummy_sprite(dummyfilepath, r,g,b,a)
						end
						ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", "mods/GlimmersExpanded/files/dummyFiles/"..particle.."/"..spritefilepath )
					else
						local dummyfilepath = create_dummy_entry(spritefilepath, particle, nil, hex)
						edit_dummy_sprite(dummyfilepath, r,g,b,a)
						ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", dummyfilepath )
					end


					ComponentObjectSetValue2( v, "config_explosion", "spark_material", particle )
					ComponentObjectSetValue2( v, "config_explosion", "material_sparks_enabled", true )
					ComponentObjectSetValue2( v, "config_explosion", "sparks_enabled", true )
				else
					ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", "" )
					ComponentObjectSetValue2( v, "config_explosion", "material_sparks_enabled", false )
					ComponentObjectSetValue2( v, "config_explosion", "sparks_enabled", false )
			    end
			end
		end
	end
end