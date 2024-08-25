# GlimmersExpanded
Cast your spells with expanded flair!

This mod adds 17 new glimmer spells! 3 of them can be found in the usual bunker that the glimmer spells are at, but the other 14 have a bit of a... twist to them. Visit the glimmer bunker for more details!
This mod also adds glimmer alchemy! The process includes:
- A recipe: Australium + any Glimmer spell + any liquid.
  - The secondary recipe for Australium is urine + pus + flummoxium, three materials that may be hard to come by.
This creates a glimmer colored similarly to the liquid involved.

Please, especially give me feedback on the alchemy part of the mod! Depending on how difficult or tedious the alchemy ends up being, I may change the materials involved.

Also, for those wondering, this is compatible with a multitude of mods, the most notable being Pride Glimmers (which also adds spells and shelves inside of the glimmer bunker). If you do find a bug, please let me know and I'll look into patching it as soon as I can.

Here's the link to the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3316355233)!

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