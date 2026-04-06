dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local mixing = ModSettingGet("GlimmersExpanded.glimmer_mixing")
local disable_lighting = ModSettingGet("GlimmersExpanded.disable_lighting")
local player_id = EntityGetWithTag("player_unit")[1]
local colour,particle
---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_materials.lua")
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_hex_globals.lua")

local function dummyfile_file(filepath, particle)
	return "mods/GlimmersExpanded/files/dummyFiles/"..particle.."/"..filepath
end

local function create_dummy_entry(spritefilepath, particle, pcolor, hex)
	local dummyfilepath = dummyfile_file(spritefilepath, particle)

	if not ModDoesFileExist(dummyfilepath) then
		ModTextFileSetContent( dummyfilepath, ModTextFileGetContent(spritefilepath) )
		if pcolor ~= nil then
			add_hexglobal(spritefilepath, dummyfilepath, pcolor, "uint")
		else
			add_hexglobal(spritefilepath, dummyfilepath, hex, "hex")
		end
	end
	return dummyfilepath
end

local function get_variations(path)
  	local variations = {}
  	local min, max = path:match("$%[(%d)%-(%d)%]")
  	if min then
  	  	for i=min, max do
  	  	  	local subbed = path:gsub("$%[%d%-%d%]", i)
  	  	  	table.insert(variations, subbed)
  	  	end
  	  	return variations
  	else
  	  	return { path }
  	end
end

local function edit_dummy_sprite(dummyfilepath, r, g, b, a)
	for xml in nxml.edit_file(dummyfilepath) do
		if xml ~= nil then
			xml:set("color_r",r)
			xml:set("color_g",g)
			xml:set("color_b",b)
			xml:set("color_a",a)
		end
	end
end

local function create_all_dummy_variations(spritefilepath, particle, pcolor, hex,r,g,b,a)
	local spritefilepaths = get_variations(spritefilepath)
	for _,spritefile in ipairs(spritefilepaths) do
		local dummyfilepath = create_dummy_entry(spritefile, particle, pcolor, hex)
		edit_dummy_sprite(dummyfilepath, r,g,b,a)
	end
	return dummyfile_file(spritefilepath, particle)
end

local function create_vsc(entity_id, comp_id, i, sprite_name, additive_name, tag, object_name)
	local spriteoriginal, additive, vsc
	if object_name ~= nil then
		spriteoriginal = ComponentObjectGetValue2(comp_id, object_name, sprite_name)
	else
		spriteoriginal = ComponentGetValue2(comp_id, sprite_name)
	end
	vsc = EntityGetFirstComponentIncludingDisabled(entity_id, "VariableStorageComponent", tag..i)
	if vsc ~= nil then
		additive = ComponentGetValue2(vsc, "value_bool")
	else
		if object_name ~= nil then
			additive = ComponentObjectGetValue2(comp_id, object_name, additive_name)
		else
			additive = ComponentGetValue2(comp_id, additive_name)
		end
		vsc = EntityAddComponent(entity_id, "VariableStorageComponent", {
			name=tag..i,
			value_string=spriteoriginal,
			value_bool=additive,
		})
		ComponentAddTag(vsc, tag..i)
	end
	return spriteoriginal, additive, vsc
end

local function set_additive(r,g,b, comp_id, additive_name, additive_value, object_name)
	if r <= 0.1 and g <= 0.1 and b <= 0.1 then
		if object_name ~= nil then
			ComponentObjectSetValue2( comp_id, object_name, additive_name, false)
		else
			ComponentSetValue2( comp_id, additive_name, false)
		end
	else
		if object_name ~= nil then
			ComponentObjectSetValue2( comp_id, object_name, additive_name, additive_value)
		else
			ComponentSetValue2( comp_id, additive_name, additive_value)
		end
	end
end

local function material_to_rgba(material)
	local hex = liquids[material]
	return hex, hex_to_rgba(hex)
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

	glimmers_expanded_colour_freezing_liquid = {particle = "blood_cold",},
	glimmers_expanded_cc_colour_dormant_crystal = {particle = "cc_dormant_crystal",},
	glimmers_expanded_aa_colour_static_charge = {particle = "aa_static_charge",},
	glimmers_expanded_aa_colour_chaotic_pandorium = {particle = "aa_chaotic_pandorium",},
	glimmers_expanded_aa_colour_condensed_gravity = {particle = "aa_condensed_gravity",},
	glimmers_expanded_aa_colour_dark_matter = {particle = "aa_dark_matter",},
	glimmers_expanded_colour_fire = {particle = "fire",},
	glimmers_expanded_colour_teal = {particle = "spark_teal",},
	glimmers_expanded_cc_colour_hydroxide = {particle = "cc_hydroxide",},
	glimmers_expanded_colour_midas = {particle = "midas",},
	glimmers_expanded_colour_weird_fungus = {particle = "fungi",},
	glimmers_expanded_cc_colour_slicing_liquid = {particle = "cc_slicing_liquid",},
	glimmers_expanded_colour_diminution = {particle = "magic_liquid_weakness",},
	glimmers_expanded_cc_colour_glittering_liquid = {particle = "cc_glittering_liquid",},
	glimmers_expanded_colour_pink = {particle = "plasma_fading_pink",},
	glimmers_expanded_colour_true_rainbow = {particle = "material_rainbow",},
	glimmers_expanded_colour_mimicium = {particle = "mimic_liquid",},
	glimmers_expanded_cc_colour_explode_player = {particle = "cc_explode_player",},
	glimmers_expanded_colour_white = {particle = "spark_white",},
	glimmers_expanded_colour_lively_concoction = {particle = "magic_liquid_hp_regeneration_unstable",},
	glimmers_expanded_cc_colour_uranium = {particle = "cc_uranium",},
	glimmers_expanded_colour_divine_ground = {particle = "grass_holy",},
	glimmers_expanded_colour_void = {particle = "void_liquid",},
	glimmers_expanded_cc_colour_antimatter = {particle = "cc_antimatter_liquid",},
	glimmers_expanded_cc_colour_nullium = {particle = "cc_nullium",},
	glimmers_expanded_colour_blood = {particle = "blood",},
	glimmers_expanded_colour_lava = {particle = "lava",},
	glimmers_expanded_colour_ominous = {particle = "material_darkness",},
	glimmers_expanded_colour_acid = {particle = "acid",},
	rainbow =
	{
		particles = {"spark_red", "spark", "spark_yellow", "spark_green", "plasma_fading", "blood_cold", "cc_dormant_crystal", "aa_static_charge", "aa_chaotic_pandorium", "aa_condensed_gravity", "aa_dark_matter", "fire", "spark_teal", "cc_hydroxide", "midas", "fungi", "cc_slicing_liquid", "magic_liquid_weakness", "cc_glittering_liquid", "plasma_fading_pink", "material_rainbow", "mimic_liquid", "cc_explode_player", "spark_white", "magic_liquid_hp_regeneration_unstable", "cc_uranium", "grass_holy", "void_liquid", "cc_antimatter_liquid", "cc_nullium", "blood", "lava", "material_darkness", "acid", "spark_purple_bright"},
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

	local hex,r,g,b,a
	if ( particle ~= nil ) then
		hex,r,g,b,a = material_to_rgba(particle)
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
						ComponentSetValue2( v, "is_emitting", true )
					else
						ComponentSetValue2( v, "is_emitting", false )
		    		end
				end
			end
		end
	end

	comps = EntityGetComponent( entity_id, "SpriteParticleEmitterComponent" )
	if ( comps ~= nil ) then
		if particle ~= nil then
			for i,v in ipairs( comps ) do
				ComponentSetValue2(v, "color", r,g,b,a)
				ComponentSetValue2( v, "is_emitting", true )
			end
		else
			for i,v in ipairs( comps ) do
				ComponentSetValue2( v, "is_emitting", false )
			end
		end
	end

	comps = EntityGetComponent( entity_id, "SpriteComponent" )
	if ( comps ~= nil ) then
		if (particle ~= nil) then
			local dummyfilepath, pcolor, potioncomp
			local hex,r,g,b,a = "FFFFFFFF",1,1,1,1

			-- Adding PotionComponent for the very first sprite 
			potioncomp = EntityGetFirstComponentIncludingDisabled( entity_id, "PotionComponent" )
			if ( potioncomp ~= nil ) then
				ComponentSetValue2( potioncomp, "custom_color_material", CellFactory_GetType(particle) )
			else
				potioncomp = EntityAddComponent2( entity_id, "PotionComponent", {
					custom_color_material = CellFactory_GetType(particle)
				})
			end

			pcolor = GameGetPotionColorUint( entity_id ) -- Checking the color for later & for additive check
			if pcolor ~= nil then
				r,g,b,a = uint_to_rgb(pcolor)
			end

			if potioncomp == nil or pcolor == nil or r == nil or g == nil or b == nil then
				hex,r,g,b,a = material_to_rgba(particle) -- If no potion stuff, then use hex instead
			end

			for i,v in ipairs( comps ) do
				ComponentSetValue2( v, "visible", true )

				local spritefilepath, additive = create_vsc(entity_id, v, i, "image_file", "additive", "spriteoriginal")
				set_additive(r,g,b,v,"additive",additive)

				if #comps <= 1 then
					EntityRefreshSprite( entity_id, v )
					break
				end

				dummyfilepath = create_all_dummy_variations(spritefilepath, particle, pcolor, hex,r,g,b,a)
				ComponentSetValue2( v, "image_file", dummyfilepath )

				EntityRefreshSprite( entity_id, v )
			end
		else
			for i,v in ipairs( comps ) do
				if (not ComponentGetValue( v, "fog_of_war_hole") or disable_lighting) then
					ComponentSetValue2( v, "visible", false )
				end
			end
		end
	end

	comps = EntityGetComponent( entity_id, "ProjectileComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			if (mixing and i == #comps) or (not mixing) or (colour == "invis") then
				if ( particle ~= nil ) then
					local spritefilepath, additive = create_vsc(entity_id, v, i, "explosion_sprite", "explosion_sprite_additive", "explosionspriteoriginal", "config_explosion")
					set_additive(r,g,b, v, "explosion_sprite_additive", additive, "config_explosion")

					if spritefilepath ~= nil and spritefilepath ~= "" then
						local dummyfilepath = create_all_dummy_variations(spritefilepath, particle, nil, hex,r,g,b,a)
						ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", dummyfilepath )
					end

					if mixing then
						ComponentSetValue2( v, "shoot_light_flash_r", (r+ComponentGetValue2(v,"shoot_light_flash_r"))/2*255 )
						ComponentSetValue2( v, "shoot_light_flash_g", (g+ComponentGetValue2(v,"shoot_light_flash_g"))/2*255 )
						ComponentSetValue2( v, "shoot_light_flash_b", (b+ComponentGetValue2(v,"shoot_light_flash_b"))/2*255 )
						ComponentObjectSetValue2( v, "config_explosion", "light_r", (r+ComponentObjectGetValue2(v,"config_explosion","light_r"))/2*255 )
						ComponentObjectSetValue2( v, "config_explosion", "light_g", (g+ComponentObjectGetValue2(v,"config_explosion","light_g"))/2*255 )
						ComponentObjectSetValue2( v, "config_explosion", "light_b", (b+ComponentObjectGetValue2(v,"config_explosion","light_b"))/2*255 )
					else
						ComponentSetValue2( v, "shoot_light_flash_r", r*255 )
						ComponentSetValue2( v, "shoot_light_flash_g", g*255 )
						ComponentSetValue2( v, "shoot_light_flash_b", b*255 )
						ComponentObjectSetValue2( v, "config_explosion", "light_r", r*255 )
						ComponentObjectSetValue2( v, "config_explosion", "light_g", g*255 )
						ComponentObjectSetValue2( v, "config_explosion", "light_b", b*255 )
					end
					ComponentObjectSetValue2( v, "config_explosion", "spark_material", particle )
					ComponentObjectSetValue2( v, "config_explosion", "material_sparks_enabled", true )
					ComponentObjectSetValue2( v, "config_explosion", "sparks_enabled", true )
				else
					if disable_lighting then
						ComponentSetValue2( v, "shoot_light_flash_r", 0 )
						ComponentSetValue2( v, "shoot_light_flash_g", 0 )
						ComponentSetValue2( v, "shoot_light_flash_b", 0 )
						ComponentObjectSetValue2( v, "config_explosion", "light_r", 0)
						ComponentObjectSetValue2( v, "config_explosion", "light_g", 0 )
						ComponentObjectSetValue2( v, "config_explosion", "light_b", 0 )
					end
					ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", "" )
					ComponentObjectSetValue2( v, "config_explosion", "material_sparks_enabled", false )
					ComponentObjectSetValue2( v, "config_explosion", "sparks_enabled", false )
			    end
			end
		end
	end

	comps = EntityGetComponentIncludingDisabled( entity_id, "LightComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			if ( particle ~= nil ) then
				if disable_lighting then
					EntitySetComponentIsEnabled(entity_id,v,true)
				end
				ComponentSetValue2(v, "update_properties", true)
				if mixing then
					ComponentSetValue2(v,"r",(r+ComponentGetValue2(v,"r"))/2*255)
					ComponentSetValue2(v,"g",(g+ComponentGetValue2(v,"g"))/2*255)
					ComponentSetValue2(v,"b",(b+ComponentGetValue2(v,"b"))/2*255)
				else
					ComponentSetValue2(v,"r",r*255)
					ComponentSetValue2(v,"g",g*255)
					ComponentSetValue2(v,"b",b*255)
				end
			else
				if disable_lighting then
					EntitySetComponentIsEnabled(entity_id,v,false)
				end
			end
		end
	end
end