local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"

local function createGlimmer (Name, Matchup, wait_frames, spawn_list, unlock_flag)
	local MOD_ID = Mod_Id:upper()
	local mod_id = Mod_Id:lower()
	local NAME = Name:upper()
	local name = Name:lower()
	if Matchup == nil then Matchup = "COLOUR_INVIS" end
	local MATCHUP = Matchup:upper()
	if wait_frames == nil then wait_frames = 8 end
	if spawn_list == nil then spawn_list = {["1"]="0.2",["2"]="0.2",["3"]="0.4",["4"]="0.2",["5"]="0.2",["6"]="0.2"} end
	if unlock_flag == nil then unlock_flag = "card_unlocked_paint" end

	local spawn_tiers, spawn_probs = "", ""
	for tier, prob in pairs(spawn_list) do
		spawn_tiers = spawn_tiers .. tier
		spawn_probs = spawn_probs .. prob
		if spawn_list[tier] ~= spawn_list[#spawn_list] then
			spawn_tiers = spawn_tiers .. ","
			spawn_probs = spawn_probs .. ","
		end
	end

	local newGlimmer = 
	{
		id 						= MOD_ID .. NAME,
		id_matchup				= MATCHUP,
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

local myFancyNewColors = {
	createGlimmer("white", "IF_ELSE", nil, {["1"]="0.4",["2"]="0.2",["3"]="0.4",["4"]="0.2"}),
	createGlimmer("pink", Mod_Id .. "white", nil, {["2"]="0.4",["3"]="0.1",["4"]="0.1"}),
	createGlimmer("fungi", Mod_Id .. "pink", nil, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- red glimmer
	createGlimmer("blood", "COLOUR_RED", nil, {["2"]="0.2",["3"]="0.2",["4"]="0.4",["5"]="0.2",["6"]="0.2",["10"]="0.2"}),
	-- orange glimmer
	createGlimmer("lava", "COLOUR_ORANGE", 15, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- createGlimmer("transmuted yellow??", nil, "2,3,4", "0.1,0.4,0.1"),
	-- green glimmer
	createGlimmer("acid", "COLOUR_GREEN", 15, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	createGlimmer("weakness", Mod_Id .. "acid", 15, {["3"]="0.1",["4"]="0.4",["5"]="0.1"}),
	createGlimmer("teal", Mod_Id .. "weakness", nil, {["2"]="0.4",["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- createGlimmer("transmuted teal??", "2,3,4", "0.4,0.1,0.1"),
	-- blue glimmer
	createGlimmer("freezing", "COLOUR_BLUE", 15, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- purple glimmer
	createGlimmer("darkness", "COLOUR_PURPLE", 15, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	createGlimmer("void", Mod_Id .. "darkness", nil, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	createGlimmer("lc", Mod_Id .. "void", 4, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	createGlimmer("midas", Mod_Id .. "lc", 4, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- rainbow glimmer
	createGlimmer("true_rainbow", "COLOUR_RAINBOW", nil, {["2"]="0.1",["3"]="0.1",["4"]="0.1",["10"]="0.2"}),
	createGlimmer("mimic", Mod_Id .. "true_rainbow", nil, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	createGlimmer("biome", Mod_Id .. "mimic", nil, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
}


for k=1,#myFancyNewColors do -- TODO: Organize all the glimmers in rainbow order
	local v = myFancyNewColors[k]
	v.author    = v.author  or "Sharpy796"
	v.mod       = v.mod     or "Glimmers Expanded"


	if v.id_matchup == nil then
		table.insert(actions,v)
	else
		for z=1,#actions do
			c = actions[z]
			if c.id == v.id_matchup or z == #actions then
				table.insert(actions,z + 1,v)
				break
			end
		end
	end
end

-- for _, color in ipairs(myFancyNewColors) do 
-- 	table.insert(actions,color) 
-- end