dofile_once( "data/scripts/lib/utilities.lua" )

local path = "data/scripts/projectiles/colour_spell.lua"
local file = ModTextFileGetContent(path)
-- local pathModded = "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua"
-- local fileModded = ModTextFileGetContent(path)




file = file:gsub("\"spark_purple_bright\"},", "\"plasma_fading_pink\", \"acid\", \"lava\", \"magic_liquid_hp_regeneration_unstable\", \"midas\", \"void\", \"spark_purple_bright\"},")
file = file:gsub("rainbow", "pink={particle=\"plasma_fading_pink\",},acid={particle=\"acid\",}, lava={particle=\"lava\",}, lc={particle=\"magic_liquid_hp_regeneration_unstable\",}, midas={particle=\"midas\",}, trueRainbow={particle=\"material_rainbow\",}, void={particle=\"void\",},rainbow")
ModTextFileSetContent(path, file)

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/GlimmersExpanded/translations.csv")
translations = translations .. new_translations
translations = translations:gsub("\r", ""):gsub("\n\n", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)

-- This code runs when all mods' filesystems are registered
-- TODO: Inject spells in with other glimmers
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua

