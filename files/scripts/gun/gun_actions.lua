local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"

local function createGlimmer (Name)
	local MOD_ID = Mod_Id:upper()
	local mod_id = Mod_Id:lower()
	local NAME = Name:upper()
	local name = Name:lower()

	local newGlimmer = 
	{
		id = MOD_ID .. NAME,
		name = "$action_" .. mod_id .. name,
		description = "$actiondesc_" .. mod_id .. name,
		sprite = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_" .. name .. ".png",
		sprite_unidentified = "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities = { "mods/GlimmersExpanded/files/entities/misc/colour_" .. name .. ".xml" },
		-- data/entities/particles/tinyspark_red.xml
		type = ACTION_TYPE_MODIFIER,
		spawn_level = "1,2,3,4,5,6", -- HOMING
		spawn_probability = "0.2,0.2,0.4,0.2,0.2,0.2", -- HOMING
		spawn_requires_flag = "card_unlocked_paint",
		price = 40,
		mana = 0,
		action = function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/colour_" .. name .. ".xml,"
			-- data/entities/particles/tinyspark_red.xml
			c.fire_rate_wait = c.fire_rate_wait - 8
			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	} return newGlimmer
end

local myFancyNewColors = {
	createGlimmer("pink"),
	createGlimmer("acid"),
	createGlimmer("lava"),
	createGlimmer("lc"),
	createGlimmer("midas"),
	createGlimmer("trueRainbow"),
	createGlimmer("void")
}

for _, color in ipairs(myFancyNewColors) do 
	table.insert(actions,color) 
end