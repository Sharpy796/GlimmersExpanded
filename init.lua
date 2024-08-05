
-- -- Pixel Scene things
-- ---@type nxml
-- local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
-- local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
-- local xml = nxml.parse(content)
-- local newContent = ModTextFileGetContent("mods/GlimmersExpanded/data/biome_impl/spliced/pixelSceneTest.xml")
-- -- local newContent = ModTextFileGetContent("mods/GlimmersExpanded/pixelSceneTestFile.xml")
-- local newXml = nxml.parse(newContent)
-- local newContent2 = ModTextFileGetContent("mods/GlimmersExpanded/pixelSceneTestFile.xml")
-- local newXml2 = nxml.parse(newContent)

-- -- xml:all_of("PixelScenes")[1]:all_of("PixelSceneFiles")[1]:add_child(newXml)
-- -- xml.children["PixelScenes"].children["PixelSceneFiles"]:add_child(newXml)

-- -- for _,v in ipairs(xml.children) do
--     -- if v.name == "PixelScenes" then
--         for __, w in ipairs(v.children) do
--             if w.name == "mBufferedPixelScenes" then
--                 -- for ___, u in ipairs(newXml.children) do
--                     -- if u.name == "PixelScenes" then
--                         for ____, t in ipairs(u.children) do
--                             if t.name == "mBufferedPixelScenes" then
--                                 -- table.insert(xml.children[v].children[w].children, newXml.children[u].children[t].children)
--                                 table.insert(xml.children[w].children, newXml.children[t].children)
--                             end
--                         end
--                     -- end
--                 -- end
--             elseif w.name == "PixelSceneFiles" then
--                 -- table.insert(xml.children[v].children[w], newXml2)
--                 table.insert(xml.children[w], newXml2)
--             end
--         end
--     -- end
-- -- end
-- 
-- ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

-- -- Pixel Scene things
-- ---@type nxml
-- local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
-- local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
-- local xml = nxml.parse(content)
-- local newContent = ModTextFileGetContent("mods/GlimmersExpanded/data/biome_impl/spliced/pixelSceneTest.xml")
-- local newXml = nxml.parse(newContent)
-- local newContent2 = ModTextFileGetContent("mods/GlimmersExpanded/pixelSceneTestFile.xml")
-- local newXml2 = nxml.parse(newContent)

-- for _, w in ipairs(xml.children) do
--   if w.name == "mBufferedPixelScenes" then
--     for _, u in ipairs(newXml.children) do
--       if u.name == "PixelScenes" then
--         for _, t in ipairs(u.children) do
--           if t.name == "mBufferedPixelScenes" then
--             table.insert(xml.children[w].children, newXml.children[u].children[t].children)
--           end
--         end
--       end
--     end
-- --   elseif w.name == "PixelSceneFiles" then
--     -- table.insert(xml.children[v].children[w], newXml2)
--   end
-- end

-- ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

-- Pixel Scene things
-- ---@type nxml
-- local nxml = dofile_once("mods/GlimmersExpanded/luanxml/nxml.lua")
-- local content = ModTextFileGetContent("data/biome/_pixel_scenes.xml")
-- local xml = nxml.parse(content)
-- local newContent = ModTextFileGetContent("mods/GlimmersExpanded/data/biome_impl/spliced/pixelSceneTest.xml")
-- local newXml = nxml.parse(newContent)
-- local newContent2 = ModTextFileGetContent("mods/GlimmersExpanded/pixelSceneTestFile.xml")
-- local newXml2 = nxml.parse(newContent2)

-- for _, w in ipairs(xml.children) do
--   if w.name == "mBufferedPixelScenes" then
--     for _, v in ipairs(newXml.children) do
--         if v.name == "mBufferedPixelScenes" then
--             for _, u in ipairs(v.children) do
--                 table.insert(w.children, u)
--             end
--         end
--     end
--   elseif w.name == "PixelSceneFiles" then
--     table.insert(w.children, newXml2)
--   end
-- end
-- 
-- ModTextFileSetContent("data/biome/_pixel_scenes.xml", tostring(xml))

dofile_once( "data/scripts/lib/utilities.lua" )
ModMaterialsFileAdd("mods/GlimmersExpanded/files/materials.xml")
ModLuaFileAppend("data/scripts/biomes/hills.lua", "mods/GlimmersExpanded/files/scripts/glimmer_lab_scene.lua")
ModMagicNumbersFileAdd("mods/GlimmersExpanded/files/magic_numbers.xml") -- For testing purposes

-- colour_spell.lua things (for rainbow compat and more)
local path = "data/scripts/projectiles/colour_spell.lua"
local file = ModTextFileGetContent(path)

file = file:gsub("\"spark_purple_bright\"},", "\"spark_white\", \"mimic_liquid\", \"plasma_fading_pink\", \"spark_teal\", \"blood\", \"blood_cold\", \"acid\", \"magic_liquid_weakness\", \"lava\", \"material_darkness\", \"fungi\", \"magic_liquid_hp_regeneration_unstable\", \"midas\", \"glimmers_expanded_void_liquid_variant\", \"spark_purple_bright\"},")
file = file:gsub("rainbow", "white={particle=\"spark_white\",}, mimic={particle=\"mimic_liquid\",}, pink={particle=\"plasma_fading_pink\",}, teal={particle=\"spark_teal\",}, blood={particle=\"blood\",}, freezing={particle=\"blood_cold\",}, acid={particle=\"acid\",}, weakness={particle=\"magic_liquid_weakness\",}, lava={particle=\"lava\",}, darkness={particle=\"material_darkness\",}, fungi={particle=\"fungi\",}, lc={particle=\"magic_liquid_hp_regeneration_unstable\",}, midas={particle=\"midas\",}, trueRainbow={particle=\"material_rainbow\",}, void={particle=\"glimmers_expanded_void_liquid_variant\",},rainbow")
ModTextFileSetContent(path, file)

local translations = ModTextFileGetContent("data/translations/common.csv")
local new_translations = ModTextFileGetContent("mods/GlimmersExpanded/translations.csv")
translations = translations .. new_translations
translations = translations:gsub("\r", ""):gsub("\n\n", "\n")
ModTextFileSetContent("data/translations/common.csv", translations)

function OnPlayerSpawned(player_id)
    local x, y = EntityGetTransform(player_id)
	if GameHasFlagRun("glimmers_expanded_spliced_chunks_spawned") == false then  --Rename the flag to something unique, this checks if the game has this flag
        -- TODO: Find a spot to spawn these
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/left/glimmer_lab_left.xml", 512*-23, 512*9)
		EntityLoad("mods/GlimmersExpanded/files/pixel_scenes/glimmer_lab/right/glimmer_lab_right.xml", 512*-23, 512*9)
		EntityLoad("mods/GlimmersExpanded/files/entities/portals/glimmer_lab_portal_in.xml", -12550, 396)
		GameAddFlagRun("glimmers_expanded_spliced_chunks_spawned")  --this tells the game to add this flag, the previous "if" statement won't spawn it every time you load the save now
	end
end

function OnWorldInitialized()
    -- LoadPixelScene( "mods/GlimmersExpanded/files/brickworkSquare.png", "", 0, 0, "", true, true )
end

-- This code runs when all mods' filesystems are registered
-- TODO: Inject spells in with other glimmers
ModLuaFileAppend( "data/scripts/gun/gun_actions.lua", "mods/GlimmersExpanded/files/scripts/gun/gun_actions.lua" ) -- Basically dofile("mods/example/files/actions.lua") will appear at the end of gun_actions.lua