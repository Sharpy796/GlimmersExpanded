dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local biome,particle,comps
local player_id = EntityGetWithTag("player_unit")[1]

-- TODO: This needs to be the part where we identify the current biome we are in
if ( player_id ~= nil ) then
    comps = EntityGetComponent( player_id, "BiomeTrackerComponent" )
end

if ( comps ~= nil ) then
	for i,v in ipairs( comps ) do
		-- local name = ComponentGetValue2( v, "name" )
		
		-- if ( name == "colour_name" ) then
			biome = ComponentGetValue2( v, "current_biome_name" )
		-- end
	end
end

local data =
{
	forest =
	{
		particle = "spark_green",
	},
	desert =
	{
		particle = "spark_yellow",
	},
	lake =
	{
		particle = "plasma_fading",
	},
	-- green =
	-- {
	-- 	particle = "spark_green",
	-- },
	-- blue =
	-- {
	-- 	particle = "plasma_fading",
	-- },
	-- purple =
	-- {
	-- 	particle = "spark_purple_bright",
	-- },
	-- rainbow =
	-- {
	-- 	particles = {"spark_red", "spark", "spark_yellow", "spark_green", "plasma_fading", "spark_purple_bright"},
	-- },
	-- invis =
	-- {
	-- },
}

if ( biome ~= nil ) then
	local d = data[biome] or {}
	particle = d.particle
	
	-- if ( d.particles ~= nil ) then
	-- 	SetRandomSeed( entity_id, entity_id )
	-- 	local rnd = Random( 1, #d.particles )
	-- 	particle = d.particles[rnd]
	-- end
	
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