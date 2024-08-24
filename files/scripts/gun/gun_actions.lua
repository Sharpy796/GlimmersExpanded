local glimmer_list_revamped = dofile_once("mods/GlimmersExpanded/files/glimmer_list_revamped.lua")
local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"

local myFancyNewColors = {
	-- createGlimmer("white", nil, {["1"]="0.4",["2"]="0.2",["3"]="0.4",["4"]="0.2"}),
	-- createGlimmer("pink", nil, {["2"]="0.4",["3"]="0.1",["4"]="0.1"}),
	-- createGlimmer("fungi", nil, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- -- red glimmer
	-- createGlimmer("blood", nil, {["2"]="0.2",["3"]="0.2",["4"]="0.4",["5"]="0.2",["6"]="0.2",["10"]="0.2"}),
	-- -- orange glimmer
	-- createGlimmer("lava", 15, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- -- createGlimmer("transmuted yellow??", nil, "2,3,4", "0.1,0.4,0.1"),
	-- -- green glimmer
	-- createGlimmer("acid", 15, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- createGlimmer("weakness", 15, {["3"]="0.1",["4"]="0.4",["5"]="0.1"}),
	-- createGlimmer("teal", nil, {["2"]="0.4",["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- -- createGlimmer("transmuted teal??", "2,3,4", "0.4,0.1,0.1"),
	-- -- blue glimmer
	-- createGlimmer("freezing", 15, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- -- purple glimmer
	-- createGlimmer("darkness", 15, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- createGlimmer("void", nil, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- createGlimmer("lc", 4, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- createGlimmer("midas", 4, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- -- rainbow glimmer
	-- createGlimmer("true_rainbow", nil, {["2"]="0.1",["3"]="0.1",["4"]="0.1",["10"]="0.2"}),
	-- createGlimmer("mimic", nil, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- createGlimmer("biome", nil, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
}

local organizedGlimmerList = {
	-- "GLIMMERS_EXPANDED_COLOUR_WHITE",
	-- "GLIMMERS_EXPANDED_COLOUR_PINK",
	-- "GLIMMERS_EXPANDED_COLOUR_FUNGI",
	"COLOUR_RED",
	-- "GLIMMERS_EXPANDED_COLOUR_BLOOD",
	"COLOUR_ORANGE",
	-- "GLIMMERS_EXPANDED_COLOUR_LAVA",
	"COLOUR_YELLOW",
	"COLOUR_GREEN",
	-- "GLIMMERS_EXPANDED_COLOUR_ACID",
	-- "GLIMMERS_EXPANDED_COLOUR_WEAKNESS",
	-- "GLIMMERS_EXPANDED_COLOUR_TEAL",
	"COLOUR_BLUE",
	-- "GLIMMERS_EXPANDED_COLOUR_FREEZING",
	"COLOUR_PURPLE",
	-- "GLIMMERS_EXPANDED_COLOUR_DARKNESS",
	-- "GLIMMERS_EXPANDED_COLOUR_VOID",
	-- "GLIMMERS_EXPANDED_COLOUR_MIMIC",
	"COLOUR_RAINBOW",
	-- "GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW",
	-- "GLIMMERS_EXPANDED_COLOUR_BIOME",
	-- "GLIMMERS_EXPANDED_COLOUR_MIDAS",
	-- "GLIMMERS_EXPANDED_COLOUR_LC",
	"COLOUR_INVIS",
}

local function createGlimmerAction (Name, wait_frames, spawn_tiers, unlock_flag)
	local MOD_ID = Mod_Id:upper()
	local mod_id = Mod_Id:lower()
	local NAME = Name:upper()
	local name = Name:lower()
	if wait_frames == nil then wait_frames = 8 end
	-- if spawn_list == nil then spawn_list = {["1"]="0.2",["2"]="0.2",["3"]="0.4",["4"]="0.2",["5"]="0.2",["6"]="0.2"} end
	if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end
	if unlock_flag == nil then unlock_flag = "card_unlocked_paint" end

	-- local spawn_tiers, spawn_probs = "", ""
	-- for tier, prob in pairs(spawn_list) do
	-- 	spawn_tiers = spawn_tiers .. tier
	-- 	spawn_probs = spawn_probs .. prob
	-- 	if spawn_list[tier] ~= spawn_list[#spawn_list] then
	-- 		spawn_tiers = spawn_tiers .. ","
	-- 		spawn_probs = spawn_probs .. ","
	-- 	end
	-- end
	

	-- TODO: Somehow add new glimmers into the organized list
	local newGlimmer = 
	{
		-- id 						= MOD_ID .. NAME,
		-- name 					= "$action_" .. mod_id .. name,
		-- description 			= "$actiondesc_" .. mod_id .. name,
		-- sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_" .. name .. ".png",
		-- related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/colour_" .. name .. ".xml" },
		id 						= NAME,
		name 					= "$action_" .. name,  -- TODO: Add translations dynamically
		description 			= "$actiondesc_" .. name,
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/" .. name .. ".png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/" .. name .. ".xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= spawn_tiers,
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= unlock_flag,
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/" .. name .. ".xml,"
			c.fire_rate_wait = c.fire_rate_wait - wait_frames
			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	}

	table.insert(myFancyNewColors, newGlimmer)
	return newGlimmer
end

for id, data in pairs(glimmer_list_revamped) do
	if not GameHasFlagRun("glimmers_expanded_initialized_glimmers") then
		-- createGlimmerAction(id, data.cast_delay, data.spawn_tiers)
		createGlimmerAction(id)
	end
end
GameAddFlagRun("glimmers_expanded_initialized_glimmers")


for _, color in ipairs(myFancyNewColors) do
	table.insert(actions,color)
end

if ModSettingGet("GlimmersExpanded.inject_spells") then

	local allGlimmerList = {}
	for pos, entry in ipairs(organizedGlimmerList) do
		allGlimmerList[entry] = pos
	end

	for pos, action in ipairs(actions) do
		if pos >= #actions then break end
		local id = action.id
		local isGlimmer = allGlimmerList[id]
		if isGlimmer then
			repeat
				id = actions[pos].id
				isGlimmer = allGlimmerList[id]
				if isGlimmer then
					organizedGlimmerList[isGlimmer] = table.remove(actions, pos)
				end
			until (not isGlimmer) or pos > #actions
		end
	end
	-- print("Finished populating glimmer_list and removing spells from list")

	for pos, action in ipairs(actions) do
		if pos > #actions then
			for _, entry in ipairs(organizedGlimmerList) do
				table.insert(actions, entry)
			end
		elseif action.id == "IF_ELSE" then
			for _, entry in ipairs(organizedGlimmerList) do
				-- print("inserting '"..id.."' at position "..(pos))
				if entry then
					pos = pos + 1
					table.insert(actions, pos, entry)
				end
			end
			break
		end
	end
	-- print("Finished inserting spells back into list")
end