---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
local hexglobals

function update_local_hexglobals()
    hexglobals = ModSettingGet("GlimmersExpanded.hexglobals") or ""
end

update_local_hexglobals()
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_materials.lua")

function set_global()
    ModSettingSet("GlimmersExpanded.hexglobals",  hexglobals)
end

function add_hexglobal(filepath, dummyfilepath, color_value, datatype)
    hexglobals = hexglobals..[[,0
]]..filepath..[[,]]..dummyfilepath..[[,]]..color_value..[[,]]..datatype
    set_global()
end

function debug_hex(spritefilepath, dummyfilepath, color, datatype)
    print("spritefilepath:\t"..tostring(spritefilepath))
    print("dummyfilepath:\t"..tostring(dummyfilepath))
    print("color:\t\t"..tostring(color))
    print("datatype:\t\t"..tostring(datatype))
end

local function split_with_comma(str)
  local fields = {}
  for field in str:gmatch('([^,]+)') do
    fields[#fields+1] = field
  end
  return fields
end

function hex_projectiles(set_text_func)
    if set_text_func == nil then set_text_func = ModTextFileGetContent end
    update_local_hexglobals()
    local spritefilepath, dummyfilepath, color, datatype, words
    for line in hexglobals:gmatch("([^\n]*)\n?") do
        -- print("-------------")
        -- print("HEXING PROJECTILE:\t"..line)
        local r,g,b,a = 1,1,1,1
        words = split_with_comma(line)
        spritefilepath = words[1]
        dummyfilepath = words[2]
        color = words[3]
        datatype = words[4]
        -- debug_hex(spritefilepath, dummyfilepath, hex)
        if spritefilepath ~= nil and dummyfilepath ~= nil and color ~= nil then
			set_text_func( dummyfilepath, ModTextFileGetContent(spritefilepath) )
            if datatype == "hex" then
                r,g,b,a = hex_to_rgba(color)
            elseif datatype == "uint" then
                r,g,b = uint_to_rgb(color)
            else
                print("What datatype is this hexglobal's color????")
            end
            if ModDoesFileExist(dummyfilepath) then
                for xml in nxml.edit_file(dummyfilepath, ModTextFileGetContent, set_text_func) do
	            	xml:set("color_r",r)
	            	xml:set("color_g",g)
	            	xml:set("color_b",b)
	            	xml:set("color_a",a)
	            end
            end
        end
    end
end