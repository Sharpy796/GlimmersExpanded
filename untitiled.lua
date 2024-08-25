local originalGlimmers = {
	["COLOUR_RED"]=true,
	["COLOUR_ORANGE"]=true,
	["COLOUR_YELLOW"]=true,
	["COLOUR_GREEN"]=true,
	["COLOUR_BLUE"]=true,
	["COLOUR_PURPLE"]=true,
	["COLOUR_RAINBOW"]=true,
	["COLOUR_INVIS"]=true,
}

local function split(string)
	local myTable = {}
	for i in string.gmatch(string, "%P+") do
		table.insert(myTable, i)
	end
	return myTable
end

-- -- Gather & parse spawn rates
-- local glimmer_spawns = {}
-- for _,action in ipairs(actions) do
-- 	if originalGlimmers[action.id] then
-- 		local spawn_level = split(action.spawn_level, ",")
-- 		local spawn_probability = split(action.spawn_probability, ",")
-- 		local spawns = {}
-- 		for index, probability in ipairs(spawn_probability) do
-- 			spawns[spawn_level[index]] = probability
-- 		end
-- 		glimmer_spawns[action.id] = spawns
-- 	end
-- end

-- Add together all spawn rates (hardcoded bc I did the math myself)
local total_spawns = {
	["1"]={prob=0.2,amt=1},
	["2"]={prob=1.5,amt=8},
	["3"]={prob=1.4,amt=8},
	["4"]={prob=1.5,amt=8},
	["5"]={prob=0.2,amt=1},
	["6"]={prob=0.2,amt=1},
	["7"]={prob=0,amt=0},
	["10"]={prob=0.3,amt=2},
}
-- for id,spawns in pairs(glimmer_spawns) do
-- 	for level,probability in ipairs(glimmer_spawns) do
-- 		if probability then 
-- 			total_spawns[level] = total_spawns[level] + tonumber(probability)
-- 		end
-- 	end
-- end

local myFancyNewColors = {	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_ACID",
		name 					= "$action_glimmers_expanded_colour_acid",
		description 			= "$actiondesc_glimmers_expanded_colour_acid",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_acid.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_acid.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_acid.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_OMINOUS",
		name 					= "$action_glimmers_expanded_colour_ominous",
		description 			= "$actiondesc_glimmers_expanded_colour_ominous",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_ominous.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_ominous.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_ominous.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_LAVA",
		name 					= "$action_glimmers_expanded_colour_lava",
		description 			= "$actiondesc_glimmers_expanded_colour_lava",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lava.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_lava.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_lava.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_VOMIT",
		name 					= "$action_glimmers_expanded_colour_vomit",
		description 			= "$actiondesc_glimmers_expanded_colour_vomit",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_vomit.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3,4,5,6",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_vomit.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_BLOOD",
		name 					= "$action_glimmers_expanded_colour_blood",
		description 			= "$actiondesc_glimmers_expanded_colour_blood",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_blood.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_blood.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_blood.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_VOID",
		name 					= "$action_glimmers_expanded_colour_void",
		description 			= "$actiondesc_glimmers_expanded_colour_void",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_void.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_void.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_void.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_LIVELY_CONCOCTION",
		name 					= "$action_glimmers_expanded_colour_lively_concoction",
		description 			= "$actiondesc_glimmers_expanded_colour_lively_concoction",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_lively_concoction.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_lively_concoction.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_lively_concoction.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 4			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_MIMICIUM",
		name 					= "$action_glimmers_expanded_colour_mimicium",
		description 			= "$actiondesc_glimmers_expanded_colour_mimicium",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_mimicium.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_mimicium.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_mimicium.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW",
		name 					= "$action_glimmers_expanded_colour_true_rainbow",
		description 			= "$actiondesc_glimmers_expanded_colour_true_rainbow",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_true_rainbow.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_true_rainbow.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_true_rainbow.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_PINK",
		name 					= "$action_glimmers_expanded_colour_pink",
		description 			= "$actiondesc_glimmers_expanded_colour_pink",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_pink.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_pink.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_pink.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_DIMINUTION",
		name 					= "$action_glimmers_expanded_colour_diminution",
		description 			= "$actiondesc_glimmers_expanded_colour_diminution",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_diminution.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_diminution.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_diminution.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_WEIRD_FUNGUS",
		name 					= "$action_glimmers_expanded_colour_weird_fungus",
		description 			= "$actiondesc_glimmers_expanded_colour_weird_fungus",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_weird_fungus.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_weird_fungus.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_weird_fungus.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_MIDAS",
		name 					= "$action_glimmers_expanded_colour_midas",
		description 			= "$actiondesc_glimmers_expanded_colour_midas",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_midas.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_midas.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_midas.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 4			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_FREEZING_LIQUID",
		name 					= "$action_glimmers_expanded_colour_freezing_liquid",
		description 			= "$actiondesc_glimmers_expanded_colour_freezing_liquid",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_freezing_liquid.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_freezing_liquid.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_freezing_liquid.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 15			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_BIOME",
		name 					= "$action_glimmers_expanded_colour_biome",
		description 			= "$actiondesc_glimmers_expanded_colour_biome",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_biome.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_biome.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_biome.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_TEAL",
		name 					= "$action_glimmers_expanded_colour_teal",
		description 			= "$actiondesc_glimmers_expanded_colour_teal",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_teal.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_teal.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_teal.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},	{
		id 						= "GLIMMERS_EXPANDED_COLOUR_WHITE",
		name 					= "$action_glimmers_expanded_colour_white",
		description 			= "$actiondesc_glimmers_expanded_colour_white",
		sprite 					= "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_white.png",
		related_extra_entities 	= { "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_white.xml" },
		type 					= ACTION_TYPE_MODIFIER,
		spawn_level 			= "1,2,3",
		spawn_probability 		= "0.2,0.2,0.2,0.2,0.2,0.2", -- TODO: Make this more dynamic and averaged
		spawn_requires_flag 	= "card_unlocked_paint",
		price 					= 40,
		mana 					= 0,
		action 					= function()
			c.extra_entities = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/glimmers_expanded_colour_white.xml,"
			c.fire_rate_wait = c.fire_rate_wait - 8			c.screenshake = c.screenshake - 2.5
			if ( c.screenshake < 0 ) then
				c.screenshake = 0
			end
			draw_actions( 1, true )
		end,
	},}
local organizedGlimmerList = {"COLOUR_RED",
"COLOUR_ORANGE",
"COLOUR_YELLOW",
"COLOUR_GREEN",
"COLOUR_BLUE",
"COLOUR_PURPLE",
"COLOUR_RAINBOW",
"COLOUR_INVIS",
"GLIMMERS_EXPANDED_COLOUR_ACID",
"GLIMMERS_EXPANDED_COLOUR_OMINOUS",
"GLIMMERS_EXPANDED_COLOUR_LAVA",
"GLIMMERS_EXPANDED_COLOUR_VOMIT",
"GLIMMERS_EXPANDED_COLOUR_BLOOD",
"GLIMMERS_EXPANDED_COLOUR_VOID",
"GLIMMERS_EXPANDED_COLOUR_LIVELY_CONCOCTION",
"GLIMMERS_EXPANDED_COLOUR_MIMICIUM",
"GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW",
"GLIMMERS_EXPANDED_COLOUR_PINK",
"GLIMMERS_EXPANDED_COLOUR_DIMINUTION",
"GLIMMERS_EXPANDED_COLOUR_WEIRD_FUNGUS",
"GLIMMERS_EXPANDED_COLOUR_MIDAS",
"GLIMMERS_EXPANDED_COLOUR_FREEZING_LIQUID",
"GLIMMERS_EXPANDED_COLOUR_BIOME",
"GLIMMERS_EXPANDED_COLOUR_TEAL",
"GLIMMERS_EXPANDED_COLOUR_WHITE",
}

-- Take the average of all spawn rates
for level,data in pairs(total_spawns) do
	total_spawns[level].prob = total_spawns[level].prob/(total_spawns[level].amt)
end


local function setSpawnProbs(action)
    print("----------- "..action.id.." -----------")
	-- replace spawn probs with averaged ones
	local spawn_levels = split(action.spawn_level)
	-- local spawn_probability = split(color.spawn_probability, ",")
	local new_probabilities = ""
	for index,level in ipairs(spawn_levels) do
        print("'"..action.id.."', tier '"..level.."', probability '"..total_spawns[level].prob.."', amount '"..total_spawns[level].amt.."'")
		new_probabilities = new_probabilities..total_spawns[level].prob
		if index < #spawn_levels then
			new_probabilities = new_probabilities .. ","
		end
	end
    return new_probabilities
end

-- Find averages
for _, color in ipairs(myFancyNewColors) do
	local spawn_levels = split(color.spawn_level)
	for index,level in ipairs(spawn_levels) do
        total_spawns[level].prob = total_spawns[level].prob * total_spawns[level].amt
        total_spawns[level].amt = total_spawns[level].amt+1
        total_spawns[level].prob = total_spawns[level].prob / total_spawns[level].amt
    end
end

for _, color in ipairs(myFancyNewColors) do
	color.spawn_probability = setSpawnProbs(color)

	-- print("inserting spell '"..color.id.."' into actions")
	table.insert(actions,color)
end

for _, action in ipairs(actions) do
    if originalGlimmers[action.id] then
        action.spawn_probability = setSpawnProbs(action)
    end
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