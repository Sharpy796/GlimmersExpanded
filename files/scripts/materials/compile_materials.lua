
---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
dofile_once("mods/GlimmersExpanded/files/addGlimmers.lua")
colors = dofile("mods/GlimmersExpanded/files/alchemy/glimmer_colors.lua")
liquids = {}
materials = nxml.parse_file("data/materials.xml")
all_materials = {}
local original_glimmer_materials = {"spark_red", "spark", "spark_yellow", "spark_green", "plasma_fading", "spark_purple_bright"}

function hex_to_rgba(hex)
    -- convert ARGB hex to rgba
    local a, r, g, b
    if #hex == 8 then
        a = tonumber("0x"..string.sub(hex, 1, 2)) / 255
        r = tonumber("0x"..string.sub(hex, 3, 4)) / 255
        g = tonumber("0x"..string.sub(hex, 5, 6)) / 255
        b = tonumber("0x"..string.sub(hex, 7, 8)) / 255
    else
        r = tonumber("0x"..string.sub(hex, 1, 2)) / 255
        g = tonumber("0x"..string.sub(hex, 3, 4)) / 255
        b = tonumber("0x"..string.sub(hex, 5, 6)) / 255
        a = 1
    end
    return r, g, b, a
end

function rgb_to_hex(r,g,b)
    r = r*255
    g = g*255
    b = b*255
    local rgb = (r * 0x10000) + (g * 0x100) + b
    return string.format("%x", rgb)
    -- local hex
    -- if a == nil then a = 1 end
    -- a = 
end

-- Returns r, g, b, and a = 1
function uint_to_rgb(uint)
    if uint ~= 0 then
        local b = bit.rshift(bit.band(uint, 0xFF0000), 16) / 0xFF
        local g = bit.rshift(bit.band(uint, 0xFF00), 8) / 0xFF
        local r = bit.band(uint, 0xFF) / 0xFF
        return r, g, b, 1
    else return nil, nil, nil, nil end
end

function find_closest_color_name_rgb(r, g, b)
    local closest_color = nil
    local closest_distance = 99999
    for color_name, color in pairs(colors) do
        local distance = math.sqrt((color[1] - r)^2 + (color[2] - g)^2 + (color[3] - b)^2)
        if(distance < closest_distance)then
            closest_distance = distance
            closest_color = color_name:gsub("%A","")
        end
    end
    return closest_color
end

function find_closest_color_name_hex(hex)
    local r, g, b, a = hex_to_rgba(hex)
    return find_closest_color_name_rgb(r, g, b)
end

function find_closest_color_name_uint(uint)
    local r,g,b = uint_to_rgb(uint)
    return find_closest_color_name_rgb(r,g,b)
end

function get_elem_data(elem, data)
    if elem then
        local _parent = elem:get("_parent")
        local dt = elem:get(data)
        if dt then
            return dt
        else
            if _parent then
                return get_elem_data(all_materials[_parent], data)
            else
                if (data == "cell_type") then return "liquid"
                else return "0" end
            end
        end
    end
end

function lamas_stats_get_graphics_info(elem)
    local graphics = elem:first_of("Graphics")
    if graphics == nil then
        return get_elem_data(elem, "wang_color")
    else
        local graphicsColor = graphics:get("color")
        if graphicsColor == nil then return get_elem_data(elem, "wang_color")
        else return graphicsColor end
    end
end

function get_modded_material_files()
    local root = nxml.new_element("none")
    local files = ModMaterialFilesGet()

    for _, file in ipairs(files) do
        for comp in nxml.parse_file(file):each_child() do
            root:add_child(comp)
        end
    end
    return root
end

function lamas_stats_gather_material()
    local xml = get_modded_material_files()

    for _,element_name in ipairs({"CellData","CellDataChild"}) do
        for elem in xml:each_of(element_name) do
            local name = elem:get("name")
            if name ~= nil then
                all_materials[name] = elem
            end
        end
    end
end

function lamas_stats_gather_liquids()
    local xml = get_modded_material_files()

    repeat
        -- print("start of loop")
        local actualLiquids = {}
        local liquidLength = 0
        for _,element_name in ipairs({"CellData","CellDataChild"}) do
            for elem in xml:each_of(element_name) do
                if elem ~= nil then
                    local name = elem:get("name")
                    if liquids[name] == nil and name ~= "air" and name ~= nil then -- if we haven't already accepted this material
                        local cell_type = get_elem_data(elem, "cell_type")
                        local liquid_sand = get_elem_data(elem, "liquid_sand")
                        local liquid_static = get_elem_data(elem, "liquid_static")
                        local is_just_particle_fx = get_elem_data(elem, "is_just_particle_fx")
                        local isLiquid = cell_type == "liquid" and liquid_sand == "0" and liquid_static == "0" and is_just_particle_fx == "0"

                        if (isLiquid) then
                            local hex = lamas_stats_get_graphics_info(elem) -- in will return color, use color_abgr_split or whatever
                            actualLiquids[name] = hex
                            liquidLength = liquidLength + 1
                            -- print("inserting valid material: '"..name.."'")
                        end
                    end
                end
            end
        end
        for liquid,hex in pairs(actualLiquids) do
            liquids[liquid] = hex
        end
    until liquidLength <= 0

    for id,data in pairs(glimmer_list_revamped) do
        local materials = data.materials
        for id,material in ipairs(materials) do
            if not liquids[material] and all_materials[material] then
                local missingMaterial = all_materials[material]
                local hex = lamas_stats_get_graphics_info(missingMaterial)
                liquids[material] = hex
            end
        end
    end

    for _,material in ipairs(original_glimmer_materials) do
        if not liquids[material] and all_materials[material] then
            local missingMaterial = all_materials[material]
            local hex = lamas_stats_get_graphics_info(missingMaterial)
            liquids[material] = hex
        end
    end
end

lamas_stats_gather_material()
lamas_stats_gather_liquids()