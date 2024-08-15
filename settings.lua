dofile("data/scripts/lib/mod_settings.lua")

function mod_setting_bool_custom( mod_id, gui, in_main_menu, im_id, setting )
	local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
	local text = setting.ui_name .. " - " .. GameTextGet( value and "$option_on" or "$option_off" )

	-- if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text, 1, "data/fonts/font_pixel_runes.xml", true ) then
    if GuiButton( gui, im_id, mod_setting_group_x_offset, 0, text, 1, "data/fonts/font_pixel_runes.xml", true ) then
		ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
	end

	mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
end

function mod_setting_change_callback( mod_id, gui, in_main_menu, setting, old_value, new_value  )
	print( tostring(new_value) )
end

-- Thank you Graham for this bit of code (even though I want to make this myself eventually)
local function copypaste(setting, gui, options, im_id, offset_x, name, desc)
	local id = "GlimmersExpanded." .. setting
	local id_fake = "GlimmersExpanded.fake_" .. setting
	GuiLayoutBeginHorizontal(gui, 0, 0, false, 0, 0)
	local current = ModSettingGet(id_fake)
	if current == nil then
		ModSettingSet(id_fake, 1)
		ModSettingSet(id, options[1])
		current = 1
	end

	GuiColorSetForNextWidget(gui, 0.8, 0.8, 0.8, 0.6)
	GuiText(gui, offset_x, 0, name)
	GuiTooltip(gui, desc, "")

	local lmb, rmb = GuiButton(gui, im_id, 0, 0, tostring(options[current]))
	if lmb then
		local next = (current % #options) + 1
		ModSettingSet(id_fake, next)
		ModSettingSet(id, options[next])
	end
	if rmb then
		local next = 1
		ModSettingSet(id_fake, next)
		ModSettingSet(id, options[next])
	end
	GuiLayoutEnd(gui)
end

local mod_id = "GlimmersExpanded" -- This should match the name of your mod's folder.
mod_settings_version = 1 -- This is a magic global that can be used to migrate settings to new mod versions. call mod_settings_get_version() before mod_settings_update() to get the old value. 
mod_settings =
{
	{ -- TODO: Make this work
		id = "glimmers_inject_spells",
		ui_name = "Inject Spells",
		ui_description = "If enabled, spells will be placed between vanilla spells in progress.",
		value_default = true,
		scope = MOD_SETTING_SCOPE_RUNTIME,
        ui_fn = function( mod_id, gui, in_main_menu, im_id, setting )
			copypaste("glimmers_inject_spells", gui, {true, false}, im_id, 0,
			"Inject Spells: ",
			-- "If enabled, spells will be placed between vanilla spells in progress. (Applies upon restarting the game.)"
			"If enabled, spells will be placed between vanilla spells in progress. (Currently doesn't work.)"
			)



            -- GuiLayoutBeginHorizontal(gui, 0, 0, false, 0, 0)
            --     GuiColorSetForNextWidget(gui, 1.0, 1.0, 1.0, 0.5)
            --     GuiText(gui, mod_setting_group_x_offset, 0, "Inject Spells: ")
            --     local value = ModSettingGetNextValue( mod_setting_get_id(mod_id,setting) )
            --     local lmb, rmb = GuiButton(gui, im_id, 0, 0, value and "[Yes]" or "[No]")
            --     if lmb then
            --         ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), not value, false )
            --         mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, not value )
            --     end
            --     if rmb then
            --         local new_value = setting.value_default or false
            --         ModSettingSetNextValue( mod_setting_get_id(mod_id,setting), new_value, false )
            --         mod_setting_handle_change_callback( mod_id, gui, in_main_menu, setting, value, new_value )
            --     end
            --     mod_setting_tooltip( mod_id, gui, in_main_menu, setting )
            -- GuiLayoutEnd(gui)

        end
	},
    {
        id   = "progress_reset",
        ui_name = "Reset Spell Progress",
        ui_description = "Resets all spell progress, therefore removing any spells that spawn by default in a certain spot. Cannot be undone! (Currently doesn't do anything.)",
        lock = true,
        -- func = function(lmb, rmb)
        --     if lmb then
        --         RemoveFlagPersistent("glimmers_expanded_used_unlock_all")
        --         for i = 1, #progress do
        --             RemoveFlagPersistent(progress[i])
        --         end
        --     end
        -- end
    },
    {
        id   = "progress_unlock",
        ui_name = "Unlock Spell Progress",
        ui_description = "Unlocks all spell progress, therefore allowing all spells to spawn by default in a certain spot. Cannot be undone! (Currently doesn't do anything.)",
        lock = true,
        -- func = function(lmb, rmb)
        --     if lmb then
        --         AddFlagPersistent("glimmers_expanded_used_unlock_all")
        --         for i = 1, #progress do
        --             AddFlagPersistent(progress[i])
        --         end
        --     end
        -- end
    },
}

function ModSettingsUpdate( init_scope )
	local old_version = mod_settings_get_version( mod_id ) -- This can be used to migrate some settings between mod versions.
	mod_settings_update( mod_id, mod_settings, init_scope )
end

function ModSettingsGuiCount()
	return mod_settings_gui_count( mod_id, mod_settings )
end

-- This function is called to display the settings UI for this mod. Your mod's settings wont be visible in the mod settings menu if this function isn't defined correctly.
function ModSettingsGui( gui, in_main_menu )
	mod_settings_gui( mod_id, mod_settings, gui, in_main_menu )
end