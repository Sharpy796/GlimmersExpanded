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

local organizedGlimmerList = {
	["GLIMMERS_EXPANDED_COLOUR_WHITE"]={},
	["GLIMMERS_EXPANDED_COLOUR_PINK"]={},
	["GLIMMERS_EXPANDED_COLOUR_FUNGI"]={},
	["COLOUR_RED"]={},
	["GLIMMERS_EXPANDED_COLOUR_BLOOD"]={},
	["COLOUR_ORANGE"]={},
	["GLIMMERS_EXPANDED_COLOUR_LAVA"]={},
	["COLOUR_YELLOW"]={},
	["COLOUR_GREEN"]={},
	["GLIMMERS_EXPANDED_COLOUR_ACID"]={},
	["GLIMMERS_EXPANDED_COLOUR_WEAKNESS"]={},
	["GLIMMERS_EXPANDED_COLOUR_TEAL"]={},
	["COLOUR_BLUE"]={},
	["GLIMMERS_EXPANDED_COLOUR_FREEZING"]={},
	["COLOUR_PURPLE"]={},
	["GLIMMERS_EXPANDED_COLOUR_DARKNESS"]={},
	["GLIMMERS_EXPANDED_COLOUR_VOID"]={},
	["GLIMMERS_EXPANDED_COLOUR_MIMIC"]={},
	["COLOUR_RAINBOW"]={},
	["GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW"]={},
	["GLIMMERS_EXPANDED_COLOUR_BIOME"]={},
	["GLIMMERS_EXPANDED_COLOUR_MIDAS"]={},
	["GLIMMERS_EXPANDED_COLOUR_LC"]={},
	["COLOUR_INVIS"]={},
}


for _, color in ipairs(myFancyNewColors) do
	table.insert(actions,color)
end

if ModSettingGet("GlimmersExpanded.inject_spells") then

	-- local glimmer_list = {}

	for pos, action in ipairs(actions) do
		if pos >= #actions then break end
		local id = action.id
		local isGlimmer = string.find(id, "COLOUR")
		if isGlimmer then
			repeat
				id = actions[pos].id
				isGlimmer = string.find(id, "COLOUR")
				-- store the action & remove it
				if isGlimmer or organizedGlimmerList[id] then
					print("'"..id.."' is a glimmer, removing ("..pos.."/"..#actions..")")
					organizedGlimmerList[id] = table.remove(actions, pos)
				end
				-- check if the new action at that position is a glimmer
				-- if so, repeat until it's not or we reach the end
			until (not isGlimmer) or pos > #actions

			-- print("Found '"..action.id.."' at pos "..pos)
			-- glimmer_list[action.id] = {
			-- 	action = action,
			-- 	position = pos
			-- }
		end
	end
	print("Finished populating glimmer_list and removing spells from list")
	-- print("Finished populating glimmer_list")

	-- for pos, action in ipairs(actions) do
	-- 	if pos >= #actions then
	-- 		break
	-- 	elseif glimmer_list[action.id] then
	-- 		repeat
	-- 			print("removing '"..actions[pos].id.."' at position "..pos)
	-- 			table.remove(actions, pos)
	-- 		until (not glimmer_list[actions[pos].id]) or pos >= #actions
	-- 	end
	-- end
	-- print("Finished removing spells from the list")

	for pos, action in ipairs(actions) do
		if pos > #actions then
			for id, action_glimmer in pairs(organizedGlimmerList) do
				table.insert(actions, action_glimmer)
			end
		elseif action.id == "IF_ELSE" then
			for id, action_glimmer in pairs(organizedGlimmerList) do
				-- print("inserting '"..id.."' at position "..(pos))
				if action_glimmer then
					pos = pos + 1
					table.insert(actions, pos, action_glimmer)
				end
			end
			break
		end
	end
	-- print("Finished inserting spells back into list")
end