# GlimmersExpanded
A Noita mod that adds new glimmer colors!


## Modding!!
For the modders out there, you might be wondering, "how can I create my own glimmers for this mod?" It's fairly easy! There's a few simple steps you have to follow:
- Make sure your mod is *above* this one in the mod list.
- Create a file to contain your new glimmers.
- For each glimmer you want, fill out an `addGlimmer()` function (explanation below).
- Next, place this bit of code in your `init.lua`:
```
if ModIsEnabled("GlimmersExpanded") then
	ModLuaFileAppend("mods/GlimmersExpanded/files/addGlimmers.lua", "mods/your_mod/path/to/your/file.lua")
end
```

And that should be it!!

### Modding Functions
```
addGlimmer(name: string, desc: string, materials: table, image: string, cast_delay: number, spawn_tiers: string, sort_after: number)
```
- `string` is what you want this spell to be called. For example, `"Custom Material"` would end up naming the glimmer "Custom Material Glimmer". The spell's ID will also use this, and will be `GLIMMERS_EXPANDED_COLOUR_CUSTOM_MATERIAL`.
- `desc` is the spell's description. This can be any string you want!
- `materials` is a table of material IDs. The first material inside the table will be used as the glimmer's color, but all of the materials will be used in the glimmer's alchemy. For example, `{"custom_mat1", "custom_mat2"}` would use `"custom_mat1"` as the glimmer's color, but both materials would be used for glimmer alchemy.
- `image` is the filepath to the image you want to use for your glimmer. This is optional, but will default to an "unknown" image if you don't specify one.
- `cast_delay` is the number of frames of cast delay reduction you want the spell to have. This is optional, and will default to 8 frames (or 12.5 seconds).
- `spawn_tiers` is a string containing the spell tiers you want this spell to reside in, each number separated by commas. A few examples might be `"1,2,3"`, `"3,4,10"`, or `"1"`. The valid tiers you can put spells into are `"1,2,3,4,5,6,10"`. This is optional, and will default to `"1,2,3,4,5,6"`.
- `sort_after` is where you want this spell to reside in the progress menu. This mod sorts both its and vanilla's glimmer spells by number. `sort_after` should be somewhere above/between/below these numbers:
  - `COLOUR_RED` is 1
  - `COLOUR_ORANGE` is 2
  - `COLOUR_YELLOW` is 3
  - `COLOUR_GREEN` is 4
  - `COLOUR_BLUE` is 5
  - `COLOUR_PURPLE` is 6
  - `COLOUR_RAINBOW` is 7
  - `COLOUR_INVIS` is 8

You can check out `mods/GlimmersExpanded/files/addGlimmers.lua` for examples of using `addGlimmer()`.