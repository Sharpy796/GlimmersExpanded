---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
dofile_once("mods/GlimmersExpanded/files/scripts/materials/compile_materials.lua")

local sprite_hex_list_global = GlobalsGetValue( "sprite_hex_list" )
print("BEFORE NIL CHECK")
print("'"..GlobalsGetValue( "sprite_hex_list" ).."'")
if sprite_hex_list_global == nil or sprite_hex_list_global == "" then
    sprite_hex_list_global = ModTextFileGetContent("mods/GlimmersExpanded/files/entities/misc/sprite_hex_list.xml")
    GlobalsSetValue("sprite_hex_list", sprite_hex_list_global)
end
print("AFTER NIL CHECK")
print("'"..GlobalsGetValue( "sprite_hex_list" ).."'")
local sprite_hex_list_parsed = nxml.parse(sprite_hex_list_global)

function get_list_count()
    return tonumber(sprite_hex_list_parsed:get("listcount"))
end
function increment_list_count()
    sprite_hex_list_parsed:set("listcount", get_list_count()+1)
end

function add_hex( entity_id, comp_id, filepath, dummyfilepath, hex_value )
    local element = nxml.new_element("Projectile", {
        entity_id=entity_id,
        comp_id=comp_id,
        filepath=filepath,
        dummyfilepath=dummyfilepath,
        hex_value=hex_value
    })
    debug_hex(entity_id, comp_id, filepath, dummyfilepath, hex_value)
    print("element:")
    print(tostring(element))
    sprite_hex_list_parsed:add_child(element)
    -- increment_list_count()
    set_global()
end

-- Thanks Evasia for this bit of code, it is incredibly useful
local function escape(str) 
	return str:gsub("[%(%)%.%%%+%-%*%?%[%^%$%]]", "%%%1")
end

function set_global()
    sprite_hex_list_global = escape(tostring(sprite_hex_list_parsed)):gsub("\n"," ")
    GlobalsSetValue( "sprite_hex_list",  sprite_hex_list_global)
    print("SETTING NEW GLOBAL:")
    print(GlobalsGetValue( "sprite_hex_list" ))
end

function debug_hex(entity_id, comp_id, spritefilepath, dummyfilepath, hex)
    print("-------------")
    print("entity_id:\t"..(entity_id or "nil"))
    print("comp_id:\t"..(comp_id or "nil"))
    print("spritefilepath:\t"..(spritefilepath or "nil"))
    print("dummyfilepath:\t"..(dummyfilepath or "nil"))
    print("hex:\t"..(hex or "nil"))
end

function print_parsed()
    print(tostring(sprite_hex_list_parsed or "------ PARSED IS NIL ------"))
end

function hex_projectiles()
    print_parsed()
    local entity_id, comp_id, spritefilepath, dummyfilepath, hex
    local r,g,b,a = 1,1,1,1
    for elem in sprite_hex_list_parsed:each_child() do
        entity_id = elem:get("entity_id")
        comp_id = elem:get("comp_id")
        spritefilepath = elem:get("filepath")
        dummyfilepath = elem:get("dummyfilepath")
        hex = elem:get("hex_value")
        debug_hex(entity_id, comp_id, spritefilepath, dummyfilepath, hex)
        if entity_id ~= nil and comp_id ~= nil and spritefilepath ~= nil and dummyfilepath ~= nil and hex ~= nil then
            ModTextFileSetContent( dummyfilepath, ModTextFileGetContent(spritefilepath) )
            r,g,b,a = hex_to_rgba(hex)
            for xml in nxml.edit_file(dummyfilepath) do
	        	xml:set("color_r",r)
	        	xml:set("color_g",g)
	        	xml:set("color_b",b)
	        	xml:set("color_a",a)
	        end
            EntityRefreshSprite( tonumber(entity_id), tonumber(comp_id) )
        else
            print("--- SOME VALUES ARE NIL ---")
        end
    end
end