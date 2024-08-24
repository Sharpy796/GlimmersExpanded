dofile("data/scripts/lib/mod_settings.lua")

local mod_id = "GlimmersExpanded" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings =
{
    {
        id = "inject_spells",
        ui_name = "Inject Spells",
        ui_description = "Injects the new glimmer spells into their appropriate spots in the progress menu.\nIt also organizes all of the glimmer spells in color order.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_RUNTIME_RESTART
    },
    {
        id = "allow_alchemy",
        ui_name = "Allow Glimmer Alchemy",
        ui_description = "Adds new reactions to create glimmer spells.",
        value_default = true,
        scope = MOD_SETTING_SCOPE_NEW_GAME,
    },
}


function ModSettingsUpdate( init_scope )
    local old_version = mod_settings_get_version( mod_id )
    mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
    return mod_settings_gui_count( mod_id, mod_settings )
end

function ModSettingsGui( gui, in_main_menu )
    mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end