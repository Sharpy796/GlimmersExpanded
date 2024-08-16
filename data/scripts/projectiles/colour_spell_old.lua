dofile_once("data/scripts/lib/utilities.lua")
local devtesting = true
local _print = print
function print(any)
	if (devtesting) then _print(any) end
end

print("--- COLOUR START ---")

local entity_id = GetUpdatedEntityID()
local colour,particle

local comps = EntityGetComponent( entity_id, "VariableStorageComponent" )
if ( comps ~= nil ) then
	print("colour VariableStorageComponent exists!")
	for i,v in ipairs( comps ) do
		local name = ComponentGetValue2( v, "name" )
		
		if ( name == "colour_name" ) then
			colour = ComponentGetValue2( v, "value_string" )
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
	white 		= {particle = "spark_white",}, 
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

	if (particle ~= nil) then
		GamePrint("colour particle is '" .. particle .. "'")
	else
		GamePrint("you do not have a colour particle...")
	end
	
	comps = EntityGetComponent( entity_id, "ParticleEmitterComponent" )
	if ( comps ~= nil ) then
		for i,v in ipairs( comps ) do
			print("--- comp"..i.." ---")
			local cosmetic = ComponentGetValue2( v, "emit_cosmetic_particles" )

			-- Testing
			local particle_old = ComponentGetValue2( v, "emitted_material_name" )
			print("old colour particle is '" .. particle_old .. "'")
			if (particle ~= nil) then print("new colour particle is '" .. particle .. "'")
			else print ("new colour particle is 'nil'") end
			
			if cosmetic then
				if ( particle ~= nil ) then
					print("colour particle exists, changing from '" ..  particle_old .. "' to '" .. particle .. "'")
					-- ComponentSetValue2( v, "is_emitting", true )
					ComponentSetValue2( v, "emitted_material_name", particle )
				else
					print("colour particle is nil, setting 'is_emitting' to false")
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
print("---- COLOUR END ----")
print = _print