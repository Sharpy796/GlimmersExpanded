local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"

local function createGlimmer (Name, wait_frames, spawn_tiers, spawn_probs, unlock_flag)
	local MOD_ID = Mod_Id:upper()
	local mod_id = Mod_Id:lower()
	local NAME = Name:upper()
	local name = Name:lower()
	if wait_frames == nil then wait_frames = 8 end
	if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end
	if spawn_probs == nil then spawn_probs = "0.2,0.2,0.4,0.2,0.2,0.2" end
	if unlock_flag == nil then unlock_flag = "card_unlocked_paint" end

	local newGlimmer = 
	{
		id 						= MOD_ID .. NAME,
		name 					= "$action_" .. mod_id .. name,
		description 			= "$actiondesc_" .. mod_id .. name,
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_" .. name .. ".png",
		sprite_unidentified 	= "data/ui_gfx/gun_actions/homing_unidentified.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/colour_" .. name .. ".xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= spawn_tiers,
		spawn_probability 		= spawn_probs,
		spawn_requires_flag 	= unlock_flag,
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/colour_" .. name .. ".xml,"
			c.fire_rate_wait = c.fire_rate_wait - wait_frames
			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	} return newGlimmer
end

-- local myFancyNewColors = { -- TODO: Make the transmuted glimmers locked behind unique unlock flags
-- 	createGlimmer("white", nil, "2,3,4", "0.1,0.4,0.1"),
-- 	createGlimmer("pink", nil, "2,3,4", "0.4,0.1,0.1"),
-- 	createGlimmer("fungi", nil, "3,4,5", "0.4,0.1,0.1"),
-- 	-- red glimmer
-- 	-- createGlimmer("blood", nil, "2,3,4,5,6,10", "0.2,0.2,0.4,0.2,0.2,0.2"),
-- 	-- orange glimmer
-- 	createGlimmer("lava", 15, "3,4,5", "0.1,0.1,0.4"),
-- 	-- createGlimmer("transmuted yellow??", nil, "2,3,4", "0.1,0.4,0.1"),
-- 	-- green glimmer
-- 	createGlimmer("acid", 15, "3,4,5", "0.4,0.1,0.1"),
-- 	createGlimmer("teal", nil, "2,3,4", "0.4,0.1,0.1"),
-- 	-- createGlimmer("transmuted teal??", "2,3,4", "0.4,0.1,0.1"),
-- 	-- blue glimmer
-- 	-- createGlimmer("transmuted blue??", "2,3,4", "0.4,0.1,0.1"),
-- 	-- purple glimmer
-- 	createGlimmer("darkness", 15, "3,4,5", "0.1,0.4,0.1"),
-- 	-- rainbow glimmer
-- 	createGlimmer("true_rainbow", "2,3,4,10", "0.1,0.1,0.1,0.2"),
-- 	createGlimmer("lc", 4, "5,6,10", "0.1,0.1,0.2"),
-- 	createGlimmer("midas", 4, "5,6,10", "0.1,0.1,0.2"),
-- 	createGlimmer("void", nil, "3,4,5", "0.1,0.4,0.1"),
-- 	-- createGlimmer("neon_green"),
-- }

-- TODO: Make the transmuted glimmers locked behind unique unlock flags
-- TODO: Make spawn tiers and probabilities into a table
local myFancyNewColors = {
	createGlimmer("white"),
	createGlimmer("mimic"),
	createGlimmer("pink"),
	createGlimmer("fungi"),
	-- red glimmer
	createGlimmer("blood"),
	-- orange glimmer
	createGlimmer("lava", 15),
	-- createGlimmer("transmuted yellow??", nil, "2,3,4", "0.1,0.4,0.1"),
	-- green glimmer
	createGlimmer("acid", 15),
	createGlimmer("weakness", 15),
	createGlimmer("teal"),
	-- createGlimmer("transmuted teal??", "2,3,4", "0.4,0.1,0.1"),
	-- blue glimmer
	createGlimmer("freezing", 15),
	-- purple glimmer
	createGlimmer("darkness", 15),
	-- rainbow glimmer
	createGlimmer("true_rainbow"),
	createGlimmer("lc", 4),
	createGlimmer("midas", 4),
	createGlimmer("void"),
	-- createGlimmer("neon_green"),
}

for _, color in ipairs(myFancyNewColors) do 
	table.insert(actions,color) 
end