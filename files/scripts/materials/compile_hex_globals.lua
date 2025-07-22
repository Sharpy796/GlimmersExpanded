---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
local hexglobals

function update_local_hexglobals()
    -- print("UPDATING LOCAL HEXGLOBALS:")
    hexglobals = ModSettingGet("GlimmersExpanded.hexglobals") or ""
    -- print(hexglobals)
end

update_local_hexglobals()
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_materials.lua")

function set_global()
    -- print("SETTING NEW GLOBAL:")
    ModSettingSet("GlimmersExpanded.hexglobals",  hexglobals)
end

function add_hex(filepath, dummyfilepath, hex_value, datatype)
    hexglobals = hexglobals..[[,0
]]..filepath..[[,]]..dummyfilepath..[[,]]..hex_value..[[,]]..datatype
    -- print("ADDING NEW HEX:\t'"..filepath..[[,]]..dummyfilepath..[[,]]..hex_value.."'")
    set_global()
end

function debug_hex(spritefilepath, dummyfilepath, hex)
    print("spritefilepath:\t"..(spritefilepath or "nil"))
    print("dummyfilepath:\t"..(dummyfilepath or "nil"))
    print("hex:\t\t"..(hex or "nil"))
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
    local spritefilepath, dummyfilepath, hex, datatype, words
    for line in hexglobals:gmatch("([^\n]*)\n?") do
        -- print("-------------")
        -- print("HEXING PROJECTILE:\t"..line)
        local r,g,b,a = 1,1,1,1
        words = split_with_comma(line)
        spritefilepath = words[1]
        dummyfilepath = words[2]
        hex = words[3]
        datatype = words[4]
        -- debug_hex(spritefilepath, dummyfilepath, hex)
        if spritefilepath ~= nil and dummyfilepath ~= nil and hex ~= nil then
			set_text_func( dummyfilepath, ModTextFileGetContent(spritefilepath) )
            if datatype == "hex" then
                r,g,b,a = hex_to_rgba(hex)
            elseif datatype == "uint" then
                r,g,b = uint_to_rgb(hex)
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
            -- else
            --     print("DUMMY FILE DOESN'T EXIST")
            end
        -- else
        --     print("--- SOME VALUES ARE NIL ---")
        end
    end
end