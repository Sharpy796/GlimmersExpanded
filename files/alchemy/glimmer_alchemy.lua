local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform(entity_id)
-- CreateItemActionEntity( "COLOUR_RED", x, y )
-- EntityLoad("data/entities/particles/image_emitters/shop_effect.xml", x, y-8)
-- EntityLoad("data/entities/particles/image_emitters/magical_symbol.xml", x, y - 5)

-- detect which material is nearby
-- if that material matches one in the list of my glimmers, create the glimmer
-- otherwise, find the color that matches the material most closely, then create an appropriate glimmer


local function isGlimmer(spell_id)
    local iacomp = EntityGetComponent(spell_id, "ItemActionComponent")
    if (iacomp ~= nil) then
        local action_id = ComponentGetValue2(iacomp[1], "action_id")
        return string.find(action_id, "COLOUR")
    else return nil end
end

local function isGlimmerTransmuted(material_name)
    local glimmer = glimmer_list[material_name]
    if glimmer ~= nil then
        glimmer = "GLIMMERS_EXPANDED_COLOUR_" .. glimmer:upper()
    else
        -- Identify which color is closest to the material's color
        -- glimmer = "COLOUR_" .. X:upper()
    end
    return glimmer
end

-- Look for spells nearby
local spells = EntityGetInRadiusWithTag(x, y, 50, "card_action") or {}
local valid_spells = {}
local chosen_spell_old

-- Figure out which spells are glimmers
for _,spell in ipairs(spells) do
    local root = EntityGetRootEntity(spell)
    if (root == spell) then
        if (isGlimmer(spell)) then
            table.insert(valid_spells, spell)
        end
    end
end

-- Choose the first glimmer spell there
if (#spells > 0) then
    chosen_spell_old = valid_spells[1]
end

-- Kill the glimmer spell
EntityKill(chosen_spell_old)
-- Explosion gfx
EntityLoad("data/entities/projectiles/explosion.xml", x, y - 10)
-- Spawn the new glimmer spell
CreateItemActionEntity( "COLOUR_RED", x, y )
