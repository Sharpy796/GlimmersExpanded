dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local biome,particle,comps
local player_id = EntityGetWithTag("player_unit")[1]

-- TODO: This needs to be the part where we identify the current biome we are in
if ( player_id ~= nil ) then
	local x, y = EntityGetTransform(player_id)
	biome = BiomeMapGetName(x,y)
	if biome == "$biome_boss_victoryroom" then
		local endroom = EntityGetWithTag("ending_sampo_spot_underground")[1]
		if endroom == nil then
			if y < 0 then 
				biome = "$biome_the_sky"
			else 
				biome = "$biome_the_end" 
			end
		end
	end
end

local data =
{
	-- Main Path
	["$biome_hills"] = {particle = "grass",}, -- Forest (radioactive_liquid?)
	["$biome_coalmine"] = {particle="liquid_fire",}, -- Mines
	["$biome_excavationsite"] = {particle="slime",}, -- Coal Pits
	["$biome_snowcave"] = {particle="blood_cold",}, -- Snowy Depths
	["$biome_snowcastle"] = {particle="blood_cold",}, -- Hiisi Base (or steel_static?)
	["$biome_rainforest"] = {particle="liquid_fire",}, -- Underground Jungle (poison maybe?)
	["$biome_vault"] = {particle="acid",}, -- The Vault
	["$biome_crypt"] = {particle="magic_liquid_polymorph",}, -- Temple of the Art
	["$biome_boss_arena"] = {particle="spark_red",}, -- The Laboratory
	["$biome_boss_victoryroom"] = {particle="gold",}, -- The Work (End)

	["$biome_holymountain"] = {particle="glowstone_altar",}, -- Holy Mountain

	-- Side Biomes
	["$biome_greed_room"] = {particle="gold",}, -- Hall of Wealth
	["$biome_coalmine_alt"] = {particle="liquid_fire",}, -- Collapsed Mines
	["$biome_fungicave"] = {particle="fungi",}, -- Fungal Caverns
	["$biome_wandcave"] = {particle="radioactive_liquid",}, -- Magical Temple
	["$biome_shop_room"] = {particle="gold",}, -- Secret Shop (in Hiisi Base)
	["$biome_rainforest_dark"] = {particle="material_darkness",}, -- Lukki Lair

	-- West
	["$biome_winter"] = {particle="blood_cold",}, -- Snowy Wasteland
	["$biome_winter_caves"] = {particle="blood_cold",}, -- Snowy Chasm
	["$biome_liquidcave"] = {particles={"magic_liquid_berserk","magic_liquid_charm","magic_liquid_unstable_polymorph","magic_liquid_teleportation","magic_liquid_mana_regeneration"},}, -- Ancient Laboratory
	["$biome_vault_frozen"] = {particle="ice_radioactive_static",}, -- Frozen Vault
	["$biome_lake"] = {particle="spark_blue_dark",}, -- Lake

	-- East
	["$biome_desert"] = {particle = "sand",}, -- Desert
	["$biome_pyramid"] = {particle="magic_liquid_random_polymorph",}, -- Pyramid
	["$biome_sandcave"] = {particle="fire",}, -- Sandcave
	["$biome_watchtower"] = {particle="lava",}, -- Watchtowre
	["$biome_fun"] = {particle="fungi",}, -- Overgrown Cavern
	["$biome_fungiforest"] = {particle="fungi",}, -- Overgrown Cavern
	["$biome_robobase"] = {particle="spark_electric",}, -- Power Plant
	["$biome_meat"] = {particle="pus",}, -- Meat Realm
	["$biome_wizardcave"] = {particles={"magic_liquid_polymorph","magic_liquid_weakness","magic_liquid_berserk","magic_liquid_charm","magic_liquid_mana_regeneration","magic_liquid_teleportation","magic_liquid_movement_faster","magic_liquid_protection_all","magic_liquid_random_polymorph","magic_liquid_faster_levitation_and_movement","magic_liquid_invisibility","magic_liquid_faster_levitation","magic_liquid_unstable_teleportation","magic_liquid_worm_attractor",},}, -- Wizards' Den

	-- North
	["$biome_barren"] = {particle="grass_holy",}, -- Barren Temple
	["$biome_potion_mimics"] = {particle="mimic_liquid",}, -- Henkevä Temple
	["$biome_darkness"] = {particle="material_darkness",}, -- Ominous Temple
	["$biome_clouds"] = {particle="glimmers_expanded_void_liquid_variant",}, -- Cloudscape
	["$biome_the_sky"] = {particle="glimmers_expanded_void_liquid_variant",}, -- The Work (Sky)

	-- South
	["$biome_lava"] = {particle="lava",}, -- Volcanic Lake
	["$biome_the_end"] = {particle="lava",}, -- The Work (Hell)

	-- Boss Arenas
	["$biome_secret_lab"] = {particles={"magic_liquid_berserk","magic_liquid_charm","magic_liquid_unstable_polymorph","magic_liquid_teleportation","magic_liquid_mana_regeneration"},}, -- Abandoned Alchemy Lab (High Alchemist)
	["$biome_dragoncave"] = {particle="spark_red",}, -- Dragoncave (Dragon)
	["$biome_mestari_secret"] = {particles={"magic_liquid_polymorph","magic_liquid_weakness","magic_liquid_berserk","magic_liquid_charm","magic_liquid_mana_regeneration","magic_liquid_teleportation","magic_liquid_movement_faster","magic_liquid_protection_all","magic_liquid_random_polymorph","magic_liquid_faster_levitation_and_movement","magic_liquid_invisibility","magic_liquid_faster_levitation","magic_liquid_unstable_teleportation","magic_liquid_worm_attractor",},}, -- Throne Room (Master of Masters)
	["$biome_ghost_secret"] = {particle="smoke",}, -- Forgotten Cave (The Forgotten)
	["$biome_boss_sky2"] = {particle="spark_red",}, -- Kivi Temple

	-- Secret Locations
	["$biome_orbroom"] = {particle="material_confusion",}, -- Orb Room
	["$biome_gold"] = {particle="gold",}, -- The Gold
	["$biome_water"] = {particle="water",}, -- Water
	["$biome_tower"] = {particle="spark_red",}, -- Tower
	["$biome_null_room"] = {particle="silver",}, -- Nullifying Altar"

	["???"] = {particle="material_confusion",},

	["_EMPTY_"] = {particle=""},

	[""] = {particle="vomit",},
}

if ( biome ~= nil ) then

	GamePrint("shooting, biome is '" .. biome .. "'")

	local d = data[biome] or {}
	particle = d.particle
	
	if ( d.particles ~= nil ) then
		SetRandomSeed( entity_id, entity_id )
		local rnd = Random( 1, #d.particles )
		particle = d.particles[rnd]
	end

	if ( particle == "" ) then
		particle = "material_rainbow"
	end

	if (particle ~= nil) then
		GamePrint("particle is '" .. particle .. "'")
	else
		GamePrint("you do not have a particle...")
	end
	
	comps = EntityGetComponent( entity_id, "ParticleEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
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
	
	comps = EntityGetComponent( entity_id, "SpriteParticleEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			ComponentSetValue2( v, "is_emitting", false )
		end
	end

	comps = EntityGetComponent( entity_id, "SpriteComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			ComponentSetValue2( v, "visible", false )
		end
	end
	
	comps = EntityGetComponent( entity_id, "ProjectileComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			ComponentObjectSetValue2( v, "config_explosion", "explosion_sprite", "" )
			
			if ( particle ~= nil ) then
				ComponentObjectSetValue2( v, "config_explosion", "spark_material", particle )
			else
				ComponentObjectSetValue2( v, "config_explosion", "material_sparks_enabled", false )
				ComponentObjectSetValue2( v, "config_explosion", "sparks_enabled", false )
			end
		end
	end
end