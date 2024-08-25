myFancyNewColors = {
	-- createGlimmer("white", nil, {["1"]="0.4",["2"]="0.2",["3"]="0.4",["4"]="0.2"}),
	-- createGlimmer("pink", nil, {["2"]="0.4",["3"]="0.1",["4"]="0.1"}),
	-- createGlimmer("fungi", nil, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- -- red glimmer
	-- createGlimmer("blood", nil, {["2"]="0.2",["3"]="0.2",["4"]="0.4",["5"]="0.2",["6"]="0.2",["10"]="0.2"}),
	-- -- orange glimmer
	-- createGlimmer("lava", 15, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- -- createGlimmer("transmuted yellow??", nil, "2,3,4", "0.1,0.4,0.1"),
	-- -- green glimmer
	-- createGlimmer("acid", 15, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- createGlimmer("weakness", 15, {["3"]="0.1",["4"]="0.4",["5"]="0.1"}),
	-- createGlimmer("teal", nil, {["2"]="0.4",["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- -- createGlimmer("transmuted teal??", "2,3,4", "0.4,0.1,0.1"),
	-- -- blue glimmer
	-- createGlimmer("freezing", 15, {["3"]="0.4",["4"]="0.1",["5"]="0.1"}),
	-- -- purple glimmer
	-- createGlimmer("darkness", 15, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- createGlimmer("void", nil, {["3"]="0.1",["4"]="0.1",["5"]="0.4"}),
	-- createGlimmer("lc", 4, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- createGlimmer("midas", 4, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- -- rainbow glimmer
	-- createGlimmer("true_rainbow", nil, {["2"]="0.1",["3"]="0.1",["4"]="0.1",["10"]="0.2"}),
	-- createGlimmer("mimic", nil, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
	-- createGlimmer("biome", nil, {["5"]="0.1",["6"]="0.1",["10"]="0.2"}),
}

organizedGlimmerList = {
	-- "GLIMMERS_EXPANDED_COLOUR_WHITE",
	-- "GLIMMERS_EXPANDED_COLOUR_PINK",
	-- "GLIMMERS_EXPANDED_COLOUR_FUNGI",
	{id="COLOUR_RED",sort_after=1},
	-- "GLIMMERS_EXPANDED_COLOUR_BLOOD",
	{id="COLOUR_ORANGE",sort_after=2},
	-- "GLIMMERS_EXPANDED_COLOUR_LAVA",
	{id="COLOUR_YELLOW",sort_after=3},
	{id="COLOUR_GREEN",sort_after=4},
	-- "GLIMMERS_EXPANDED_COLOUR_ACID",
	-- "GLIMMERS_EXPANDED_COLOUR_WEAKNESS",
	-- "GLIMMERS_EXPANDED_COLOUR_TEAL",
	{id="COLOUR_BLUE",sort_after=5},
	-- "GLIMMERS_EXPANDED_COLOUR_FREEZING",
	{id="COLOUR_PURPLE",sort_after=6},
	-- "GLIMMERS_EXPANDED_COLOUR_DARKNESS",
	-- "GLIMMERS_EXPANDED_COLOUR_VOID",
	-- "GLIMMERS_EXPANDED_COLOUR_MIMIC",
	{id="COLOUR_RAINBOW",sort_after=7},
	-- "GLIMMERS_EXPANDED_COLOUR_TRUE_RAINBOW",
	-- "GLIMMERS_EXPANDED_COLOUR_BIOME",
	-- "GLIMMERS_EXPANDED_COLOUR_MIDAS",
	-- "GLIMMERS_EXPANDED_COLOUR_LC",
	{id="COLOUR_INVIS",sort_after=8},
}

return myFancyNewColors, organizedGlimmerList