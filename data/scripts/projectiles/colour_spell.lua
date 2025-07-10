dofile_once("data/scripts/lib/utilities.lua")

local entity_id = GetUpdatedEntityID()
local mixing = ModSettingGet("GlimmersExpanded.glimmer_mixing")
local player_id = EntityGetWithTag("player_unit")[1]
local colour,particle

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
	rainbow =
	{
		particles = {"spark_red", "spark", "spark_yellow", "spark_green", "plasma_fading", "spark_purple_bright"},
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
			for i,v in ipairs( comps ) do
				ComponentSetValue2( v, "visible", true )
			end
			comps = EntityGetComponent( entity_id, "PotionComponent" )
			if ( comps ~= nil ) then
				for i,v in ipairs( comps ) do
					ComponentSetValue2( v, "custom_color_material", CellFactory_GetType(particle) )
				end
			else
				EntityAddComponent2( entity_id, "PotionComponent", {
					custom_color_material = CellFactory_GetType(particle)
				})
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
end