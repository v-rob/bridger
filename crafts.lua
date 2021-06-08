minetest.register_craftitem("bridger:bridges_wooden_rod", {
	description = "Wooden Rod",
	inventory_image = "bridges_wooden_rod.png",
})

minetest.register_craft({
	output = 'default:stick',
	recipe = {
		{'bridger:bridges_wooden_rod'},
	}
})

minetest.register_craft({
	output = 'bridger:bridges_wooden_rod 3',
	recipe = {
		{'group:stick'},
		{'group:stick'},
		{'group:stick'},
	}
})

minetest.register_craft({
	output = 'bridger:scaffolding 2',
	recipe = {
		{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
		{'','group:stick',''},
		{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
	}
})

if minetest.settings:get_bool("bridger_enable_trusses") then

	minetest.register_craftitem("bridger:bridges_steel_rod", {
		description = "Steel Rod",
		inventory_image = "bridges_steel_rod.png",
	})

	minetest.register_craftitem("bridger:bridges_diagonal_steel_rod", {
		description = "Steel Rod",
		inventory_image = "bridges_diagonal_steel_rod.png",
	})

	minetest.register_craft({
		output = 'bridger:bridges_steel_rod 3',
		recipe = {
			{'default:steel_ingot'},
		}
	})

	minetest.register_craft({
		output = 'bridger:bridges_diagonal_steel_rod 3',
		recipe = {
			{'','','bridger:bridges_steel_rod'},
			{'','bridger:bridges_steel_rod',''},
			{'bridger:bridges_steel_rod','',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:train_deck_white',
		type = 'shapeless',
		recipe = {'bridger:bridges_diagonal_steel_rod','bridger:bridges_diagonal_steel_rod'},
	})

	minetest.register_craft({
		output = 'bridger:block_white',
		recipe = {
			{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
			{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
			{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
		}
	})

	local bridge_colors = {
		"green",
		"red",
		"steel",
		"white",
	}

	for c in ipairs(bridge_colors) do
		local bridge_colors = bridge_colors[c]

		minetest.register_craft({
			output = 'bridger:deck_'..bridge_colors..' 8',
			recipe = {
				{'bridger:block_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:deck_edge_'..bridge_colors..' 14',
			recipe = {
				{'','bridger:block_'..bridge_colors},
				{'bridger:block_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:step_'..bridge_colors..' 12',
			recipe = {
				{'','bridger:block_'..bridge_colors},
				{'bridger:block_'..bridge_colors,'bridger:block_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:step_'..bridge_colors..' 12',
			recipe = {
				{'bridger:block_'..bridge_colors,''},
				{'bridger:block_'..bridge_colors,'bridger:block_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:block_'..bridge_colors,
			recipe = {
				{'bridger:step_'..bridge_colors,'bridger:step_'..bridge_colors},
				{'bridger:step_'..bridge_colors,'bridger:step_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:suspension_cable_'..bridge_colors..' 16',
			recipe = {
				{'bridger:block_'..bridge_colors},
				{'bridger:block_'..bridge_colors},
				{'bridger:block_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:suspension_top_'..bridge_colors..' 8',
			recipe = {
				{'bridger:block_'..bridge_colors,'bridger:block_'..bridge_colors,'bridger:block_'..bridge_colors},
				{'','bridger:block_'..bridge_colors,''},
				{'','bridger:block_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:girder_mid_'..bridge_colors..' 4',
			recipe = {
				{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
				{'bridger:bridges_steel_rod','bridger:block_'..bridge_colors,'bridger:bridges_steel_rod'},
				{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:girder_left_end_'..bridge_colors..' 4',
			recipe = {
				{'','','bridger:bridges_steel_rod'},
				{'','bridger:block_'..bridge_colors,'bridger:bridges_steel_rod'},
				{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:girder_right_'..bridge_colors..' 4',
			recipe = {
				{'bridger:bridges_steel_rod','',''},
				{'bridger:bridges_steel_rod','bridger:block_'..bridge_colors,''},
				{'bridger:bridges_steel_rod','bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:corrugated_steel_'..bridge_colors,
			type = 'shapeless',
			recipe = {'bridger:deck_'..bridge_colors,'default:coal_lump'},
		})

		minetest.register_craft({
			output = 'bridger:corrugated_steel_ceiling_'..bridge_colors..' 3',
			recipe = {
				{'bridger:corrugated_steel'..bridge_colors,'bridger:corrugated_steel'..bridge_colors,'bridger:corrugated_steel'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_left_slant_white',
			recipe = {
				{'','bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod'},
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
				{'bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod',''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:corrugated_steel_ceiling_'..bridge_colors..' 3',
			recipe = {
				{'bridger:corrugated_steel'..bridge_colors,'bridger:corrugated_steel'..bridge_colors,'bridger:corrugated_steel'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_left_slant_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_right_slant_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_tall_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_tall_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_up_left_slant_'..bridge_colors,
			recipe = {
				{'','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_left_slant_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_up_right_slant_'..bridge_colors,
			recipe = {
				{'','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_right_slant_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_down_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','',''},
				{'','bridger:truss_superstructure_left_slant_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_down_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','',''},
				{'','bridger:truss_superstructure_right_slant_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_up_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_up_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_up_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_up_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_down_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_down_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_down_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_down_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_end_left_slant_white',
			recipe = {
				{'','','bridger:bridges_diagonal_steel_rod'},
				{'','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
				{'bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod',''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_end_right_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_end_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_end_left_'..bridge_colors,
			recipe = {
				{'bridger:truss_superstructure_end_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_mid_'..bridge_colors,
			type = 'shapeless',
			recipe = {'bridger:truss_superstructure_left_slant_'..bridge_colors,'bridger:truss_superstructure_right_slant_'..bridge_colors},
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_mid_'..bridge_colors,
			type = 'shapeless',
			recipe = {'bridger:truss_superstructure_tall_left_slant_'..bridge_colors,'bridger:truss_superstructure_tall_right_slant_'..bridge_colors},
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_mid_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_mid_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_up_mid_'..bridge_colors,
			recipe = {
				{'','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_mid_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_down_mid_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','',''},
				{'','bridger:truss_superstructure_mid_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_left_slant_white',
			recipe = {
				{'','bridger:bridges_steel_rod',''},
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
				{'','bridger:bridges_steel_rod',''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_right_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_substructure_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_left_slant_'..bridge_colors,
			recipe = {
				{'bridger:truss_substructure_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_end_left_slant_white',
			recipe = {
				{'','bridger:bridges_steel_rod'},
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_end_right_'..bridge_colors,
			recipe = {
				{'bridger:truss_substructure_end_left_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_end_left_'..bridge_colors,
			recipe = {
				{'bridger:truss_substructure_end_right_slant_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_mid_'..bridge_colors,
			type = 'shapeless',
			recipe = {'bridger:truss_substructure_left_slant_'..bridge_colors,'bridger:truss_substructure_right_slant_'..bridge_colors},
		})

		minetest.register_craft({
			output = 'bridger:truss_substructure_simple_white',
			recipe = {
				{'','bridger:bridges_steel_rod',''},
				{'bridger:bridges_diagonal_steel_rod','','bridger:bridges_diagonal_steel_rod'},
				{'','bridger:bridges_steel_rod',''},
			}
		})

		minetest.register_craft({
			output = 'bridger:small_upper_chord_white',
			recipe = {
				{'','bridger:bridges_steel_rod',''},
				{'','bridger:bridges_diagonal_steel_rod',''},
				{'','bridger:bridges_steel_rod',''},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_upper_chord_white',
			recipe = {
				{'','bridger:bridges_steel_rod',''},
				{'','bridger:bridges_diagonal_steel_rod',''},
				{'','bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_upper_chord_white',
			recipe = {
				{'bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod',''},
				{'','bridger:bridges_diagonal_steel_rod',''},
				{'','bridger:bridges_steel_rod',''},
			}
		})

		minetest.register_craft({
			output = 'bridger:small_upper_chord_slanted_'..bridge_colors,
			recipe = {
				{'bridger:small_upper_chord_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_upper_chord_slanted_'..bridge_colors,
			recipe = {
				{'bridger:medium_upper_chord_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_upper_chord_slanted_'..bridge_colors,
			recipe = {
				{'bridger:medium_upper_chord_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:small_upper_chord_'..bridge_colors,
			recipe = {
				{'bridger:small_upper_chord_slanted_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_upper_chord_'..bridge_colors,
			recipe = {
				{'bridger:medium_upper_chord_slanted_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_upper_chord_'..bridge_colors,
			recipe = {
				{'bridger:medium_upper_chord_slanted_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:large_upper_chord_white',
			recipe = {
				{'bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod',''},
				{'','bridger:bridges_diagonal_steel_rod',''},
				{'','bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:small_support_white',
			recipe = {
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:small_support_top_'..bridge_colors,
			recipe = {
				{'bridger:small_support_'..bridge_colors},
				{'bridger:small_support_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_support_white',
			recipe = {
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
				{'','','bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_support_white',
			recipe = {
				{'bridger:bridges_diagonal_steel_rod','',''},
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:medium_support_bot_white',
			recipe = {
				{'bridger:bridges_steel_rod','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:large_support_white',
			recipe = {
				{'bridger:bridges_diagonal_steel_rod','',''},
				{'bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod'},
				{'','','bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:large_support_bot_white',
			recipe = {
				{'bridger:bridges_steel_rod','','bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_simple_end_right_white',
			recipe = {
				{'bridger:bridges_steel_rod'},
				{'bridger:bridges_steel_rod'},
				{'bridger:bridges_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_simple_end_left_white',
			recipe = {
				{'bridger:bridges_diagonal_steel_rod'},
				{'bridger:bridges_diagonal_steel_rod'},
				{'bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_simple_white',
			recipe = {
				{'bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod'},
				{'bridger:bridges_diagonal_steel_rod','','bridger:bridges_diagonal_steel_rod'},
				{'bridger:bridges_diagonal_steel_rod','bridger:bridges_steel_rod','bridger:bridges_diagonal_steel_rod'},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_simple_end_right_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod'},
				{'bridger:truss_superstructure_tall_simple_end_right_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_simple_end_left_'..bridge_colors,
			recipe = {
				{'bridger:bridges_diagonal_steel_rod'},
				{'bridger:truss_superstructure_tall_simple_end_left_'..bridge_colors},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_simple_'..bridge_colors,
			recipe = {
				{'bridger:bridges_diagonal_steel_rod','','bridger:bridges_diagonal_steel_rod'},
				{'','bridger:truss_superstructure_simple_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_tall_simple_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_simple_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_up_simple_'..bridge_colors,
			recipe = {
				{'','','bridger:bridges_steel_rod'},
				{'','bridger:truss_superstructure_simple_'..bridge_colors,''},
			}
		})

		minetest.register_craft({
			output = 'bridger:truss_superstructure_down_mid_'..bridge_colors,
			recipe = {
				{'bridger:bridges_steel_rod','',''},
				{'','bridger:truss_superstructure_simple_'..bridge_colors,''},
			}
		})
	end

	local bridge_nodes = {
		"block_",
		"step_",
		"suspension_top_",
		"suspension_cable_",
		"deck_",
		"deck_edge_",
		"train_deck_",
		"girder_mid_",
		"girder_right_",
		"girder_left_end_",
		"truss_superstructure_right_slant_",
		"truss_superstructure_left_slant_",
		"truss_superstructure_end_right_slant_",
		"truss_superstructure_end_left_slant_",
		"truss_superstructure_mid_",
		"truss_superstructure_simple_",
		"truss_superstructure_simple_end_left_",
		"truss_superstructure_simple_end_right_",
		"truss_superstructure_tall_right_slant_",
		"truss_superstructure_tall_left_slant_",
		"truss_superstructure_tall_end_right_slant_",
		"truss_superstructure_tall_end_left_slant_",
		"truss_superstructure_tall_mid_",
		"truss_superstructure_tall_simple_",
		"truss_superstructure_tall_simple_end_left_",
		"truss_superstructure_tall_simple_end_right_",
		"truss_superstructure_up_right_slant_",
		"truss_superstructure_up_left_slant_",
		"truss_superstructure_up_mid_",
		"truss_superstructure_up_simple_",
		"truss_superstructure_down_right_slant_",
		"truss_superstructure_down_left_slant_",
		"truss_superstructure_down_mid_",
		"truss_superstructure_down_simple_",
		"truss_substructure_end_right_slant_",
		"truss_substructure_end_left_slant_",
		"truss_substructure_right_slant_",
		"truss_substructure_left_slant_",
		"truss_substructure_simple_",
		"truss_substructure_mid_",
		"truss_substructure_mid_simple_",
		"small_upper_chord_",
		"medium_upper_chord_",
		"large_upper_chord_",
		"small_upper_chord_slanted",
		"medium_upper_chord_slanted",
		"large_upper_chord_slanted",
		"small_support_",
		"small_support_top",
		"medium_support_",
		"large_support_",
		"medium_support_bot",
		"large_support_bot",
		"corrugated_steel_",
		"corrugated_steel_ceiling_",
	}

	for c in ipairs(bridge_nodes) do
		local bridge_nodes = bridge_nodes[c]

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'white',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'yellow','dye:white'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'white',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'steel','dye:white'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'white',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'green','dye:white'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'white',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'red','dye:white'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'red',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'white','dye:red'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'red',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'steel','dye:red'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'red',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'green','dye:red'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'red',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'yellow','dye:red'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'green',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'white','dye:green'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'green',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'steel','dye:green'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'green',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'yellow','dye:green'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'green',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'red','dye:green'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'white','dye:black'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'yellow','dye:black'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'green','dye:black'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'red','dye:black'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'white','dye:dark_grey'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'yellow','dye:dark_grey'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'green','dye:dark_grey'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'steel',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'red','dye:dark_grey'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'yellow',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'white','dye:yellow'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'yellow',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'steel','dye:yellow'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'yellow',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'green','dye:yellow'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'yellow',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'red','dye:yellow'},
		})

		minetest.register_craft({
			output = 'bridger:'..bridge_nodes..'red',
			type = 'shapeless',
			recipe = {'bridger:'..bridge_nodes..'yellow','dye:red'},
		})
	end
end

if minetest.settings:get_bool("bridger_enable_trestles") then
	minetest.register_craft({
		output = 'bridger:trestle_support_small',
		recipe = {
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
		}
	})

	minetest.register_craft({
		output = 'bridger:trestle_support_small',
		recipe = {
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','group:stick','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
		}
	})

	minetest.register_craft({
		output = 'bridger:trestle_deck',
		recipe = {
			{'bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod'},
		}
	})

	minetest.register_craft({
		output = 'bridger:trestle_side',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'','group:stick',''},
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
		}
	})

	minetest.register_craft({
		output = 'bridger:trestle_substructure_small',
		recipe = {
			{'group:stick','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'','group:stick','bridger:bridges_wooden_rod'},
			{'','','group:stick'},
		}
	})

	minetest.register_craft({
		output = 'bridger:trestle_substructure_large',
		recipe = {
			{'group:stick','','bridger:bridges_wooden_rod'},
			{'group:stick','group:stick','bridger:bridges_wooden_rod'},
			{'','group:stick','group:stick'},
		}
	})

	minetest.register_craft({
		output = 'bridger:lattice_truss',
		recipe = {
			{'group:stick','','group:stick'},
			{'','bridger:bridges_wooden_rod',''},
			{'group:stick','','group:stick'},
		}
	})

	minetest.register_craft({
		output = 'bridger:deck_wood',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
		}
	})
end

if minetest.settings:get_bool("bridger_enable_wooden_bridges") then
	minetest.register_craft({
		output = 'bridger:small_beam',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam_mid',
		recipe = {
			{'','bridger:bridges_wooden_rod',''},
			{'','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam_end',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
			{'','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam_corner',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','',''},
			{'','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam_3',
		recipe = {
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
			{'','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam_4',
		recipe = {
			{'bridger:bridges_wooden_rod','','bridger:bridges_wooden_rod'},
			{'','',''},
			{'','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam_stair',
		recipe = {
			{'','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','','group:wood'},
			{'bridger:bridges_wooden_rod','group:wood',''},
		}
	})

	minetest.register_craft({
		output = 'bridger:large_beam',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','group:wood','bridger:bridges_wooden_rod'},
		}
	})

	minetest.register_craft({
		output = 'bridger:large_fancy_beam',
		recipe = {
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','group:wood','bridger:bridges_wooden_rod'},
			{'bridger:bridges_wooden_rod','bridger:bridges_wooden_rod','bridger:bridges_wooden_rod'},
		}
	})

	minetest.register_craft({
		output = 'bridger:large_beam_swivel_normal',
		recipe = {
			{'bridger:large_beam'},
		}
	})

	minetest.register_craft({
		output = 'bridger:large_beam',
		recipe = {
			{'bridger:large_beam_swivel_normal'},
		}
	})

	minetest.register_craft({
		output = 'bridger:large_drawbridge_normal',
		recipe = {
			{'bridger:small_beam','bridger:small_beam'},
		}
	})

	minetest.register_craft({
		output = 'bridger:small_beam 2',
		recipe = {
			{'bridger:large_drawbridge_normal'},
		}
	})

	minetest.register_craft({
		output = 'bridger:foundation 3',
		recipe = {
			{'','default:clay',''},
			{'default:clay','default:clay','default:clay'},
		}
	})
end