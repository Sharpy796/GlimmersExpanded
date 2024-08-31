dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"

local originalGlimmers = {
	["COLOUR_RED"]=1,
	["COLOUR_ORANGE"]=2,
	["COLOUR_YELLOW"]=3,
	["COLOUR_GREEN"]=4,
	["COLOUR_BLUE"]=5,
	["COLOUR_PURPLE"]=6,
	["COLOUR_RAINBOW"]=7,
	["COLOUR_INVIS"]=8,
}

local function split(string)
	local myTable = {}
	for i in string.gmatch(string, "%P+") do
		table.insert(myTable, i)
	end
	return myTable
end

-- Add together all original glimmer spawn rates (hardcoded bc I did the math myself)
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

local myFancyNewColors = {}

local function createGlimmerAction(Id, image, wait_frames, spawn_probs, spawn_tiers, sort_after, unlock_flag, custom_action)
	local MOD_ID = Mod_Id:upper()
	local mod_id = Mod_Id:lower()
	local ID = Id:upper()
	local id = Id:lower()
	if image == nil then image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png" end
	if wait_frames == nil then wait_frames = 8 end
    if spawn_probs == nil then spawn_probs = "0.2,0.2,0.2,0.2,0.2,0.2" end
	if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end
    if sort_after == nil then sort_after = 100 end
	if unlock_flag == nil then unlock_flag = "card_unlocked_paint" end
    if type(custom_action) ~= "function" then custom_action = function(c) --[[Do nothing]] end end


    local action = function()
        c.extra_entities    = c.extra_entities .. "mods/GlimmersExpanded/files/entities/misc/"..id..".xml,"
        custom_action(c)
        c.fire_rate_wait    = c.fire_rate_wait - wait_frames
        c.screenshake       = math.max(0, c.screenshake - 2.5)
        draw_actions( 1, true )
    end

    local newGlimmer = {
        id                      = ID,
        name                    = "$action_"..id,
        description             = "$actiondesc_"..id,
        sprite                  = image,
        related_extra_entities  = { "mods/GlimmersExpanded/files/entities/misc/"..id..".xml" },
        type                    = ACTION_TYPE_MODIFIER,
        spawn_level             = spawn_tiers,
        spawn_probability       = spawn_probs,
        spawn_requires_flag     = unlock_flag,
        price                   = 40,
        mana                    = 0,
        action 					= action,
        sort_after              = sort_after,
    }
    table.insert(myFancyNewColors, newGlimmer)
	return newGlimmer
end

local function sortProgress(myTable)
	table.sort(myTable, sortGlimmers)
end

function sortGlimmers(entry1, entry2)
	return entry1.sort_after < entry2.sort_after
end

for id, data in pairs(glimmer_list_revamped) do
	createGlimmerAction(id, data.image, data.cast_delay, nil, data.spawn_tiers, data.sort_after, nil, data.custom_action)
end


local function parseSpawnProbs(action)
	-- replace spawn probs with averaged ones
	local spawn_levels = split(action.spawn_level)
	local new_probabilities = ""
	for index,level in ipairs(spawn_levels) do
		new_probabilities = new_probabilities..total_spawns[level].prob
		if index < #spawn_levels then
			new_probabilities = new_probabilities .. ","
		end
	end
    return new_probabilities
end

-- Add together the amount of spells in each tier
for _, color in ipairs(myFancyNewColors) do
	local spawn_levels = split(color.spawn_level)
	for index,level in ipairs(spawn_levels) do
        total_spawns[level].amt = total_spawns[level].amt+1
    end
end

-- Take the average of all glimmer spawn rates
for level,data in pairs(total_spawns) do
	total_spawns[level].prob = total_spawns[level].prob/(total_spawns[level].amt)
end

-- Fix spawn rates for modded glimmers
for _, color in ipairs(myFancyNewColors) do
	color.spawn_probability = parseSpawnProbs(color)
end

-- Fix spawn rates for vanilla glimmers
for _, action in ipairs(actions) do
    if originalGlimmers[action.id] then
        action.spawn_probability = parseSpawnProbs(action)
    end
end

if ModSettingGet("GlimmersExpanded.inject_spells") then
    -- Remove the original glimmers from actions, and insert them into myFancyNewColors
    for index, action in ipairs(actions) do
        if index >= #actions then break end
        local id = actions[index].id
        local isGlimmer = originalGlimmers[id]
        if isGlimmer then
            repeat
                local id = actions[index].id
                isGlimmer = originalGlimmers[id]
                if isGlimmer then
                    actions[index].sort_after = isGlimmer
                    table.insert(myFancyNewColors, table.remove(actions, index))
                end
            until (not isGlimmer) or index > #actions
        end
    end
end

-- Sort myFancyNewColors
sortProgress(myFancyNewColors)

-- Put myFancyNewColors into actions
if ModSettingGet("GlimmersExpanded.inject_spells") then
    for index, action in ipairs(actions) do
        if index > #actions then
            for _, color in ipairs(myFancyNewColors) do
                table.insert(actions, color)
            end
        elseif action.id == "IF_ELSE" then
            for _, color in ipairs(myFancyNewColors) do
                index = index + 1
                table.insert(actions, index, color)
            end
            break
        end
    end
else
    for _, color in ipairs(myFancyNewColors) do
        table.insert(actions, color)
    end
end