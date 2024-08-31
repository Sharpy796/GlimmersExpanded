# GlimmersExpanded
Cast your spells with expanded flair!

This mod adds 17 new glimmer spells! 3 of them can be found in the usual bunker that the glimmer spells are at, but the other 14 have a bit of a... twist to them. Visit the glimmer bunker for more details!

This mod also adds glimmer alchemy! The process includes a recipe: Australium + any Glimmer spell + any liquid. (The secondary recipe for Australium is urine + pus + flummoxium, three materials that may be hard to come by.) The result of this is a glimmer that is similarly-colored to the material!

Please, especially give me feedback on the alchemy part of the mod! Depending on how difficult or tedious the alchemy ends up being, I may change the materials involved.

Also, for those wondering, this is compatible with a multitude of mods, the most notable being Pride Glimmers (which also adds spells and shelves inside of the glimmer bunker). However, make sure this mod goes *below* any mods that add glimmers through this one. When in doubt, place this mod at the bottom of the mod list.

If you find any bugs, please let me know and I'll look into patching it as soon as I can.

Here's the link to the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3316355233) version of the mod!

## Modding!!
For the modders out there, you might be wondering, "How can I create my own glimmers for this mod?" It's fairly easy! There's a few simple steps you have to follow: 
- Make sure your mod is *above* this one in the mod list.
- Create a file to contain your new glimmers.
- For each glimmer you want, fill out a glimmer appends table (explanation below).
- Next, place this bit of code in your `init.lua`:
```lua
if ModIsEnabled("GlimmersExpanded") then
	ModLuaFileAppend("mods/GlimmersExpanded/files/lib/glimmer_data.lua", "mods/your_mod/path/to/your/file.lua")
end
```

And that should be it!!

### Modding Methods
This is an example of a glimmer appends table:
```lua
local glimmer_appends = {
    {
        -- REQUIRED
        name            = "Vomit", -- The glimmer's name (i.e. "Vomit Glimmer"). Will also be used in the ID (i.e. "GLIIMMERS_EXPANDED_COLOUR_VOMIT")
        desc            = "Gives a projectile a sickeningly sparkly trail", -- The glimmer's description
        materials       = {"vomit"}, -- The material(s) involved. The first one will color the glimmer, and the rest are used in glimmer alchemy.
        -- OPTIONAL
        image           = "mods/GlimmersExpanded/files/gfx/ui_gfx/colour_vomit.png", -- The filepath to the spell icon
        cast_delay      = 15, -- The cast delay reduction
        spawn_tiers     = "1,2", -- The spell tiers this spawns in
        sort_after      = 4.21, -- Where this is sorted in the progress menu
        mod_prefix      = "EXAMPLE", -- Will be used in the ID (i.e. "GLIMMERS_EXPANDED_EXAMPLE_COLOUR_VOMIT")
        is_rare         = false, -- Determines whether the glimmer shows up in the glimmer lab
        custom_action   = function() -- A custom action, if you'd like to specify one
            c.fire_rate_wait = c.fire_rate_wait - 45
			current_reload_time = current_reload_time - 20
			c.speed_multiplier = c.speed_multiplier * 2.5
			c.extra_entities = c.extra_entities .. "data/entities/misc/clusterbomb.xml,"
        end,
        trail_mods = {
            count_min = "2",
            count_max = "5",
            trail_gap = "4",
            lifetime_min="8.0",
            lifetime_max="9.0",
        },
    },
}
```
- `name` is what you want this spell to be called. For example, `"Custom Material"` would end up naming the glimmer "Custom Material Glimmer". The spell's ID will also use this, and will be `GLIMMERS_EXPANDED_COLOUR_CUSTOM_MATERIAL` (unless you specify a `mod_prefix`).
- `desc` is the spell's description. This can be any string you want!
- `materials` is a table of material IDs. The first material inside the table will be used as the glimmer's color, but all of the materials will be used in the glimmer's alchemy. For example, `{"custom_mat1", "custom_mat2"}` would use `"custom_mat1"` as the glimmer's color, but both materials would be used for glimmer alchemy.
- `image` is the filepath to the image you want to use for your glimmer. This is optional, but will default to `"mods/GlimmersExpanded/files/gfx/ui_gfx/colour_unknown.png"` if you don't specify one.
- `cast_delay` is the number of frames of cast delay reduction you want the spell to have. This is optional, and will default to `8` frames (or 12.5 seconds).
- `spawn_tiers` is a string containing the spell tiers you want this spell to reside in, each number separated by commas. A few examples might be `"1,2,3"`, `"3,4,10"`, or `"1"`. The valid tiers you can put spells into are `"1,2,3,4,5,6,10"`. This is optional, and will default to `"1,2,3,4,5,6"`.
- `sort_after` is where you want this spell to reside in the progress menu. This mod sorts both its and vanilla's glimmer spells by number. `sort_after` should be somewhere above/between/below the following numbers. This is optional, and will default to `100`.
  - `COLOUR_RED` is 1
  - `COLOUR_ORANGE` is 2
  - `COLOUR_YELLOW` is 3
  - `COLOUR_GREEN` is 4
  - `COLOUR_BLUE` is 5
  - `COLOUR_PURPLE` is 6
  - `COLOUR_RAINBOW` is 7
  - `COLOUR_INVIS` is 8
- `mod_prefix` is a string that will be inserted into the ID of your glimmer. This is so I can credit you for glimmers that come from your mod! When specified, the ID of the spell will be `GLIMMERS_EXPANDED_[MOD_PREFIX]_COLOUR_CUSTOM_MATERIAL`. For example, if I wanted to specify the glimmer is from "My Awesome Mod," I might set the mod prefix as `"awesomeMod"`, and it would set the ID to `GLIMMERS_EXPANDED_AWESOMEMOD_COLOUR_CUSTOM_MATERIAL`. This is optional, and will default to `""`.
- `is_rare` is a boolean that will determine whether you can find this glimmer in the glimmer lab pixel scene I created. It is advised to set this to `true` if your glimmer uses a rare and potentially game-breaking material, like Lively Concoction and Draught of Midas. This is optional, and will default to `false`.
- `custom_action` is a function that will be called when the glimmer's action is called (when the spell is cast). A spell's action can do all sorts of things. If you know how to create custom spell actions, then feel free to use this. This is optional, and will default to `custom_action = function() end`.
- `trail_mods` is a table of string values that can modify how the trail of your glimmer looks. The tags below are the only ones that are modifiable at the moment. These values are optional, and will default to the following values:
  - `count_min = "1"`
  - `count_max = "1"`
  - `trail_gap = "1"`
  - `lifetime_min = "0.8"`
  - `lifetime_max = "2.0"`

After your glimmer appends table, place this below it:
```lua
for _,entry in ipairs(glimmer_appends) do
    table.insert(glimmer_data, entry)
end
```
Finally, don't forget to place this in your `init.lua`:
```lua
if ModIsEnabled("GlimmersExpanded") then
	ModLuaFileAppend("mods/GlimmersExpanded/files/lib/glimmer_data.lua", "mods/your_mod/path/to/your/file.lua")
end
```
### "Deprecated" Functions
This function has had functionality added to it, and is not very readable anymore. However, it is still usable, if you so prefer.
```lua
addGlimmer(name: string, desc: string, materials: table, image: string, cast_delay: number, spawn_tiers: string, sort_after: number, mod_prefix: string, is_rare: boolean, trail_mods: table)
```

You can check out `mods/GlimmersExpanded/files/lib/glimmer_data.lua` for more examples of creating glimmers.