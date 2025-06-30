---@type nxml
local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
local colors = {
    "blue",
    "green",
    "invis",
    "orange",
    "purple",
    "rainbow",
    "red",
    "yellow",
}

for i,v in ipairs(colors) do
    for xml in nxml.edit_file("data/entities/misc/colour_"..v..".xml") do
		-- remove the LuaComponent
		local luacomp = xml:first_of("LuaComponent")
        xml:remove_child(luacomp)
    end
end