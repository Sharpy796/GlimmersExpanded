dofile("mods/GlimmersExpanded/files/lib/glimmer_data.lua")
local mod_id = "GLIMMERS_EXPANDED_"
glimmer_list_revamped = {}

-- Adds a new glimmer to the game.
---@param name string
---@param desc string
---@param materials string[]
---@param image string? '"mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png"'
---@param cast_delay integer? 8
---@param spawn_tiers string? '"1,2,3,4,5,6"'
---@param sort_after number? 100
---@param mod_prefix string? '""'
---@param is_rare boolean? false
---@param custom_action function? function custom_action() end
---@param trail_mods table? nil
function addGlimmer(name, desc, materials, image, cast_delay, spawn_tiers, sort_after, mod_prefix, is_rare, custom_action, trail_mods)
    if name == nil then error("attempted to call addGlimmer() with 'name' as nil") end
    if desc == nil then error("attempted to call addGlimmer() with 'desc' as nil") end
    if materials == nil then error("attempted to call addGlimmer() with 'materials' as nil") end
    if image == nil then image = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png" end
    if cast_delay == nil then cast_delay = 8 end
    if spawn_tiers == nil then spawn_tiers = "1,2,3,4,5,6" end
    if sort_after == nil then sort_after = 100 end
    if not mod_prefix then mod_prefix = "" else
    mod_prefix = mod_prefix:upper():gsub("%W","_").."_" end
    if is_rare == nil then is_rare = false end
    if type(custom_action) ~= "function" then custom_action = function() --[[Do nothing]] end end
    if type(trail_mods) ~= "table" then trail_mods = nil end

    local id = mod_id..mod_prefix.."COLOUR_"..name:upper():gsub("%W","_")
    local newGlimmer = {
        id = id,
        name = name.." Glimmer",
        desc = desc,
        image = image,
        materials = materials,
        cast_delay = cast_delay,
        spawn_tiers = spawn_tiers,
        sort_after = sort_after,
        is_rare = is_rare,
        custom_action = custom_action,
        trail_mods = trail_mods,
    }
    glimmer_list_revamped[id] = newGlimmer
end

for _,glimmer in ipairs(glimmer_data) do
    addGlimmer(glimmer.name,
            glimmer.desc,
            glimmer.materials,
            glimmer.image,
            glimmer.cast_delay,
            glimmer.spawn_tiers,
            glimmer.sort_after,
            glimmer.mod_prefix,
            glimmer.is_rare,
            glimmer.custom_action,
            glimmer.trail_mods)
end