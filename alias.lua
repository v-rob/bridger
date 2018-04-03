local bridger_colors = {
	"Green",
	"Red",
	"Steel",
	"White"
}

for _, color in pairs(bridger_colors) do

	local oldname = color
	local newname =  string.lower(color)

	if minetest.get_modpath("moreblocks") then
		stairsplus:register_alias_all("bridges", "block_"..oldname, "bridger", "block_"..newname)
	elseif minetest.get_modpath("stairs") then
		minetest.register_alias("stairs:slab_block_"..oldname, "stairs:slab_block_"..newname)
		minetest.register_alias("stairs:stair_block_"..oldname, "stairs:stair_block_"..newname)
	end
	
	local bridger_error1 = {
		"step_",
		"suspension_top_",
		"suspension_cable_",
		"deck_",
		"deck_edge_",
		"train_deck_",
		"girder_mid_",
		"girder_right_",
		"truss_superstructure_right_slant_",
		"truss_superstructure_left_slant_",
		"small_upper_chord_",
		"medium_upper_chord_",
		"large_upper_chord_",
		"small_support_",
		"medium_support_",
		"large_support_",
		"truss_substructure_left_slant_",
		"truss_substructure_right_slant_",
		"truss_substructure_end_left_slant_",
		"truss_substructure_end_right_slant_"
	}
	
	
	for _, prefix in pairs (bridger_error1) do
		minetest.register_alias("bridges:"..prefix..oldname, "bridger:"..prefix..newname)
	end
	
	local bridger_error2 = {
		"truss_substructure_mid",
		"truss_substructure_simple",
		"truss_superstructure_end_left_slant",
		"truss_superstructure_end_right_slant",
		"truss_superstructure_right_slant",
		"truss_superstructure_left_slant",
		"truss_superstructure_mid",
		"truss_superstructure_simple",
		"truss_superstructure_simple_end_right"
	}
	
	for _, prefix in pairs (bridger_error2) do
		minetest.register_alias("bridges:"..prefix..oldname, "bridger:"..prefix.."_"..newname)
	end
	
	minetest.register_alias("bridges:truss_superstructure_simple_end"..oldname, "bridger:truss_superstructure_simple_end_left_"..newname)
	minetest.register_alias("bridges:girder_left_end"..oldname, "bridger:girder_left_"..newname)
	
end

minetest.register_alias("bridges:corrugated_steel", "bridger:corrugated_steel_steel")
minetest.register_alias("bridges:corrugated_steel_ceiling", "bridger:corrugated_steel_ceiling_steel")
minetest.register_alias("bridges:scaffolding", "bridger:scaffolding")
minetest.register_alias("bridges:zbridges_diagonal_steel_rod", "bridger:bridges_diagonal_steel_rod")
minetest.register_alias("bridges:zbridges_steel_rod", "bridger:bridges_steel_rod")