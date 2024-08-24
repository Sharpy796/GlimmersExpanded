-- local glimmer_list_revamped = dofile_once("mods/GlimmersExpanded/files/glimmer_list_revamped.lua")
local Mod_Id = "GLIMMERS_EXPANDED_COLOUR_"
-- local myFancyNewColors, organizedGlimmerList = dofile_once("mods/GlimmersExpanded/files/lib/myFancyNewColors.lua")
dofile("mods/GlimmersExpanded/files/lib/glimmer_list_revamped.lua")


print("PRINTING ALL FANCY COLORS")
for _, color in ipairs(myFancyNewColors) do
	print("inserting spell '"..color.id.."' into actions")
	table.insert(actions,color)
end

if ModSettingGet("GlimmersExpanded.inject_spells") then

	local allGlimmerList = {}
	for pos, entry in ipairs(organizedGlimmerList) do
		allGlimmerList[entry] = pos
	end

	for pos, action in ipairs(actions) do
		if pos >= #actions then break end
		local id = action.id
		local isGlimmer = allGlimmerList[id]
		if isGlimmer then
			repeat
				id = actions[pos].id
				isGlimmer = allGlimmerList[id]
				if isGlimmer then
					organizedGlimmerList[isGlimmer] = table.remove(actions, pos)
				end
			until (not isGlimmer) or pos > #actions
		end
	end
	-- print("Finished populating glimmer_list and removing spells from list")

	for pos, action in ipairs(actions) do
		if pos > #actions then
			for _, entry in ipairs(organizedGlimmerList) do
				table.insert(actions, entry)
			end
		elseif action.id == "IF_ELSE" then
			for _, entry in ipairs(organizedGlimmerList) do
				-- print("inserting '"..id.."' at position "..(pos))
				if entry then
					pos = pos + 1
					table.insert(actions, pos, entry)
				end
			end
			break
		end
	end
	-- print("Finished inserting spells back into list")
end