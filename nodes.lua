local bridge_colors = {
	{"Green", "green"},
	{"Red", "red"},
	{"Steel", "steel"},
	{"White", "white"},
	{"Yellow", "yellow"},
}

for _, row in ipairs(bridge_colors) do
	local bridge_desc = row[1]
	local bridge_colors = row[2]

minetest.register_node("bridger:block_"..bridge_colors, {
	description = bridge_desc.." Block",
	drawtype = "normal",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

stairs.register_stair_and_slab(
	"block_"..bridge_colors,
	"bridger:block_"..bridge_colors,
	{cracky=3},
	{"bridges_"..bridge_colors..".png"},
	bridge_desc.." Stair",
	bridge_desc.." Slab",
	default.node_sound_metal_defaults()
)

local function rotate_and_place(itemstack, placer, pointed_thing)
	local p0 = pointed_thing.under
	local p1 = pointed_thing.above
	local param2 = 0

	local placer_pos = placer:getpos()
	if placer_pos then
		param2 = minetest.dir_to_facedir(vector.subtract(p1, placer_pos))
	end

	local finepos = minetest.pointed_thing_to_face_pos(placer, pointed_thing)
	local fpos = finepos.y % 1

	if p0.y - 1 == p1.y or (fpos > 0 and fpos < 0.5)
			or (fpos < -0.5 and fpos > -0.999999999) then
		param2 = param2 + 20
		if param2 == 21 then
			param2 = 23
		elseif param2 == 23 then
			param2 = 21
		end
	end
	return minetest.item_place(itemstack, placer, pointed_thing, param2)
end

minetest.register_node("bridger:step_"..bridge_colors, {
	description = bridge_desc.." Step",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0, 0.5, 0, 0.5},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end
		return rotate_and_place(itemstack, placer, pointed_thing)
	end,
})

minetest.register_node("bridger:suspension_top_"..bridge_colors, {
	description = bridge_desc.." Cable Top",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0, -0.5, 0.5, 0.5, 0.5},
			{-0.125, -0.5, -0.125, 0.125, 0.4, 0.125},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return itemstack
		end
		return rotate_and_place(itemstack, placer, pointed_thing)
	end,
})

minetest.register_node("bridger:suspension_cable_"..bridge_colors, {
	description = bridge_desc.." Cable",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125, -0.5, -0.125, 0.125, 0.5, 0.125},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:deck_"..bridge_colors, {
	description = bridge_desc.." Deck",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:deck_edge_"..bridge_colors, {
	description = bridge_desc.." Deck Edge",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
			{-0.5, 0.375, -0.5, 0.5, 1.0625, -0.625},
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:train_deck_"..bridge_colors, {
	description = bridge_desc.." Train Deck",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, 0.375, 0.375, 0.5, 0.501, 0.5}, -- NodeBox1
			{0.3125, 0.375, 0.3125, 0.4375, 0.501, 0.4375}, -- NodeBox2
			{0.25, 0.375, 0.25, 0.375, 0.501, 0.375}, -- NodeBox3
			{0.1875, 0.375, 0.1875, 0.3125, 0.501, 0.3125}, -- NodeBox4
			{0.125, 0.375, 0.125, 0.25, 0.501, 0.25}, -- NodeBox5
			{0.0625, 0.375, 0.0625, 0.1875, 0.501, 0.1875}, -- NodeBox6
			{0, 0.375, 0, 0.125, 0.501, 0.125}, -- NodeBox7
			{-0.0625, 0.375, -0.0625, 0.0625, 0.501, 0.0625}, -- NodeBox8
			{-0.125, 0.375, -0.125, 0, 0.501, 0}, -- NodeBox9
			{-0.1875, 0.375, -0.1875, -0.0625, 0.501, -0.0625}, -- NodeBox10
			{-0.25, 0.375, -0.25, -0.125, 0.501, -0.125}, -- NodeBox11
			{-0.3125, 0.375, -0.3125, -0.1875, 0.501, -0.1875}, -- NodeBox12
			{-0.4375, 0.375, -0.4375, -0.3125, 0.501, -0.3125}, -- NodeBox13
			{-0.375, 0.375, -0.375, -0.25, 0.501, -0.25}, -- NodeBox14
			{-0.5, 0.375, -0.5, -0.375, 0.501, -0.375}, -- NodeBox15
			{-0.5, 0.375, 0.375, -0.375, 0.501, 0.5}, -- NodeBox16
			{-0.4375, 0.375, 0.3125, -0.3125, 0.501, 0.4375}, -- NodeBox17
			{-0.375, 0.375, 0.25, -0.25, 0.501, 0.375}, -- NodeBox18
			{-0.3125, 0.375, 0.1875, -0.1875, 0.501, 0.3125}, -- NodeBox19
			{-0.25, 0.375, 0.125, -0.125, 0.501, 0.25}, -- NodeBox20
			{-0.1875, 0.375, 0.0625, -0.0625, 0.501, 0.1875}, -- NodeBox21
			{-0.125, 0.375, 0, 0, 0.501, 0.125}, -- NodeBox22
			{0, 0.375, -0.125, 0.125, 0.501, 0}, -- NodeBox23
			{0.0625, 0.375, -0.1875, 0.1875, 0.501, -0.0625}, -- NodeBox24
			{0.125, 0.375, -0.25, 0.25, 0.501, -0.125}, -- NodeBox25
			{0.1875, 0.375, -0.3125, 0.3125, 0.501, -0.1875}, -- NodeBox26
			{0.25, 0.375, -0.375, 0.375, 0.501, -0.25}, -- NodeBox27
			{0.3125, 0.375, -0.4375, 0.4375, 0.501, -0.3125}, -- NodeBox28
			{0.375, 0.375, -0.5, 0.5, 0.501, -0.375}, -- NodeBox29
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:girder_mid_"..bridge_colors, {
	description = bridge_desc.." Girder Middle",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox194
			{-0.5, 0.4375, 0.375, 0.5, 0.5, 0.5}, -- NodeBox195
			{0.46875, -0.5, 0.375, 0.5, 0.5, 0.5}, -- NodeBox196
			{-0.5, -0.5, 0.375, -0.46875, 0.5, 0.5}, -- NodeBox197
			{-0.5, -0.5, 0.375, 0.5, -0.4375, 0.5}, -- NodeBox198
			{-0.5, -0.625, 0.4375, 0.5, -0.5, 0.5}, -- NodeBox213
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:girder_right_"..bridge_colors, {
	description = bridge_desc.." Girder Right End",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.4375, 0.375, -0.25, 0.5, 0.5}, -- NodeBox195
			{-0.5, -0.5, 0.375, -0.46875, 0.5, 0.5}, -- NodeBox197
			{-0.5, -0.5, 0.375, 0.5, -0.4375, 0.5}, -- NodeBox198
			{-0.3125, 0.375, 0.375, -0.0625, 0.4375, 0.5}, -- NodeBox199
			{-0.125, 0.3125, 0.375, 0.0625, 0.375, 0.5}, -- NodeBox200
			{0, 0.25, 0.375, 0.125, 0.3125, 0.5}, -- NodeBox201
			{0.4375, -0.5, 0.375, 0.5, -0.25, 0.5}, -- NodeBox202
			{0.375, -0.3125, 0.375, 0.4375, -0.0625, 0.5}, -- NodeBox203
			{0.3125, -0.125, 0.375, 0.375, 0.0625, 0.5}, -- NodeBox204
			{0.25, 0, 0.375, 0.3125, 0.125, 0.5}, -- NodeBox205
			{0.1875, 0.0625, 0.375, 0.25, 0.1875, 0.5}, -- NodeBox206
			{0.125, 0.125, 0.375, 0.1875, 0.25, 0.5}, -- NodeBox207
			{0.0625, 0.1875, 0.375, 0.1875, 0.25, 0.5}, -- NodeBox208
			{-0.5, -0.5, 0.4375, -0.0625, 0.4375, 0.5}, -- NodeBox209
			{-0.5, -0.5, 0.4375, 0.4375, -0.0625, 0.5}, -- NodeBox210
			{-0.5, -0.5, 0.4375, 0.125, 0.3125, 0.5}, -- NodeBox211
			{-0.5, -0.5, 0.4375, 0.3125, 0.125, 0.5}, -- NodeBox212
			{-0.5, -0.625, 0.4375, 0.5, -0.5, 0.5}, -- NodeBox213
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:girder_left_"..bridge_colors, {
	description = bridge_desc.." Girder Left End",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.25, 0.4375, 0.375, 0.5, 0.5, 0.5}, -- NodeBox195
			{0.46875, -0.5, 0.375, 0.5, 0.5, 0.5}, -- NodeBox197
			{-0.5, -0.5, 0.375, 0.5, -0.4375, 0.5}, -- NodeBox198
			{0.0625, 0.375, 0.375, 0.3125, 0.4375, 0.5}, -- NodeBox199
			{-0.0625, 0.3125, 0.375, 0.125, 0.375, 0.5}, -- NodeBox200
			{-0.125, 0.25, 0.375, -0, 0.3125, 0.5}, -- NodeBox201
			{-0.5, -0.5, 0.375, -0.4375, -0.25, 0.5}, -- NodeBox202
			{-0.4375, -0.3125, 0.375, -0.375, -0.0625, 0.5}, -- NodeBox203
			{-0.375, -0.125, 0.375, -0.3125, 0.0625, 0.5}, -- NodeBox204
			{-0.3125, 0, 0.375, -0.25, 0.125, 0.5}, -- NodeBox205
			{-0.25, 0.0625, 0.375, -0.1875, 0.1875, 0.5}, -- NodeBox206
			{-0.1875, 0.125, 0.375, -0.125, 0.25, 0.5}, -- NodeBox207
			{-0.1875, 0.1875, 0.375, -0.0625, 0.25, 0.5}, -- NodeBox208
			{0.0625, -0.5, 0.4375, 0.5, 0.4375, 0.5}, -- NodeBox209
			{-0.4375, -0.5, 0.4375, 0.5, -0.0625, 0.5}, -- NodeBox210
			{-0.125, -0.5, 0.4375, 0.5, 0.3125, 0.5}, -- NodeBox211
			{-0.3125, -0.5, 0.4375, 0.5, 0.125, 0.5}, -- NodeBox212
			{-0.5, -0.625, 0.4375, 0.5, -0.5, 0.5}, -- NodeBox213
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox215
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox217
			{-0.5, 2.375, 0.375, 1.5, 2.5, 0.5}, -- NodeBox218
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox215
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox217
			{-0.5, 2.375, 0.375, 1.5, 2.5, 0.5}, -- NodeBox218
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_end_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure End Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_end_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_end_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox215
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_end_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure End Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_end_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_end_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox217
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_mid_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Middle",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_mid.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_mid.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox215
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox217
			{-0.5, 2.375, 0.375, 1.5, 2.5, 0.5}, -- NodeBox218
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_tall_right_slant_"..bridge_colors, {
	description = bridge_desc.." Tall Truss Superstructure Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{-0.5, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 3.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 3.5, 0.5}, -- NodeBox4
			{-0.4375, 3.25, 0.375, -0.3125, 3.375, 0.5}, -- NodeBox5
			{-0.375, 3.125, 0.375, -0.25, 3.3125, 0.5}, -- NodeBox6
			{-0.3125, 3, 0.375, -0.1875, 3.1875, 0.5}, -- NodeBox7
			{-0.25, 2.875, 0.375, -0.125, 3.0625, 0.5}, -- NodeBox8
			{-0.1875, 2.75, 0.375, -0.0625, 2.9375, 0.5}, -- NodeBox9
			{-0.125, 2.625, 0.375, 1.11759e-008, 2.8125, 0.5}, -- NodeBox10
			{-0.0625, 2.5625, 0.375, 0.0625, 2.6875, 0.5}, -- NodeBox11
			{0, 2.4375, 0.375, 0.125, 2.625, 0.5}, -- NodeBox12
			{0.0625, 2.3125, 0.375, 0.1875, 2.5, 0.5}, -- NodeBox13
			{0.125, 2.1875, 0.375, 0.25, 2.375, 0.5}, -- NodeBox14
			{0.1875, 2.0625, 0.375, 0.3125, 2.25, 0.5}, -- NodeBox15
			{0.25, 2, 0.375, 0.375, 2.125, 0.5}, -- NodeBox16
			{0.3125, 1.875, 0.375, 0.4375, 2.0625, 0.5}, -- NodeBox17
			{0.375, 1.75, 0.375, 0.5, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.5, 1.5, 0.375, 0.625, 1.6875, 0.5}, -- NodeBox20
			{0.5625, 1.375, 0.375, 0.6875, 1.5625, 0.5}, -- NodeBox21
			{0.625, 1.3125, 0.375, 0.75, 1.4375, 0.5}, -- NodeBox22
			{0.6875, 1.1875, 0.375, 0.8125, 1.375, 0.5}, -- NodeBox23
			{0.75, 1.0625, 0.375, 0.875, 1.25, 0.5}, -- NodeBox24
			{0.8125, 0.9375, 0.375, 0.9375, 1.125, 0.5}, -- NodeBox25
			{0.875, 0.8125, 0.375, 1, 1, 0.5}, -- NodeBox26
			{0.9375, 0.75, 0.375, 1.0625, 0.875, 0.5}, -- NodeBox27
			{1, 0.625, 0.375, 1.125, 0.8125, 0.5}, -- NodeBox28
			{1.0625, 0.5, 0.375, 1.1875, 0.6875, 0.5}, -- NodeBox29
			{1.125, 0.375, 0.375, 1.25, 0.5625, 0.5}, -- NodeBox30
			{1.1875, 0.25, 0.375, 1.3125, 0.4375, 0.5}, -- NodeBox31
			{1.25, 0.125, 0.375, 1.375, 0.3125, 0.5}, -- NodeBox32
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_tall_left_slant_"..bridge_colors, {
	description = bridge_desc.." Tall Truss Superstructure Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{-0.5, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 3.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 3.5, 0.5}, -- NodeBox4
			{1.3125, 3.25, 0.375, 1.4375, 3.375, 0.5}, -- NodeBox5
			{1.25, 3.125, 0.375, 1.375, 3.3125, 0.5}, -- NodeBox6
			{1.1875, 3, 0.375, 1.3125, 3.1875, 0.5}, -- NodeBox7
			{1.125, 2.875, 0.375, 1.25, 3.0625, 0.5}, -- NodeBox8
			{1.0625, 2.75, 0.375, 1.1875, 2.9375, 0.5}, -- NodeBox9
			{1, 2.625, 0.375, 1.125, 2.8125, 0.5}, -- NodeBox10
			{0.9375, 2.5625, 0.375, 1.0625, 2.6875, 0.5}, -- NodeBox11
			{0.875, 2.4375, 0.375, 1, 2.625, 0.5}, -- NodeBox12
			{0.8125, 2.3125, 0.375, 0.9375, 2.5, 0.5}, -- NodeBox13
			{0.75, 2.1875, 0.375, 0.875, 2.375, 0.5}, -- NodeBox14
			{0.6875, 2.0625, 0.375, 0.8125, 2.25, 0.5}, -- NodeBox15
			{0.625, 2, 0.375, 0.75, 2.125, 0.5}, -- NodeBox16
			{0.5625, 1.875, 0.375, 0.6875, 2.0625, 0.5}, -- NodeBox17
			{0.5, 1.75, 0.375, 0.625, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.375, 1.5, 0.375, 0.5, 1.6875, 0.5}, -- NodeBox20
			{0.3125, 1.375, 0.375, 0.4375, 1.5625, 0.5}, -- NodeBox21
			{0.25, 1.3125, 0.375, 0.375, 1.4375, 0.5}, -- NodeBox22
			{0.1875, 1.1875, 0.375, 0.3125, 1.375, 0.5}, -- NodeBox23
			{0.125, 1.0625, 0.375, 0.25, 1.25, 0.5}, -- NodeBox24
			{0.0625, 0.9375, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox25
			{0, 0.8125, 0.375, 0.125, 1, 0.5}, -- NodeBox26
			{-0.0625, 0.75, 0.375, 0.0625, 0.875, 0.5}, -- NodeBox27
			{-0.125, 0.625, 0.375, -3.35276e-008, 0.8125, 0.5}, -- NodeBox28
			{-0.1875, 0.5, 0.375, -0.0625, 0.6875, 0.5}, -- NodeBox29
			{-0.25, 0.375, 0.375, -0.125, 0.5625, 0.5}, -- NodeBox30
			{-0.3125, 0.25, 0.375, -0.1875, 0.4375, 0.5}, -- NodeBox31
			{-0.375, 0.125, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox32
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_tall_mid_"..bridge_colors, {
	description = bridge_desc.." Tall Truss Superstructure Middle",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_mid.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_mid.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{-0.5, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 3.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 3.5, 0.5}, -- NodeBox4
			{1.3125, 3.25, 0.375, 1.4375, 3.375, 0.5}, -- NodeBox5
			{1.25, 3.125, 0.375, 1.375, 3.3125, 0.5}, -- NodeBox6
			{1.1875, 3, 0.375, 1.3125, 3.1875, 0.5}, -- NodeBox7
			{1.125, 2.875, 0.375, 1.25, 3.0625, 0.5}, -- NodeBox8
			{1.0625, 2.75, 0.375, 1.1875, 2.9375, 0.5}, -- NodeBox9
			{1, 2.625, 0.375, 1.125, 2.8125, 0.5}, -- NodeBox10
			{0.9375, 2.5625, 0.375, 1.0625, 2.6875, 0.5}, -- NodeBox11
			{0.875, 2.4375, 0.375, 1, 2.625, 0.5}, -- NodeBox12
			{0.8125, 2.3125, 0.375, 0.9375, 2.5, 0.5}, -- NodeBox13
			{0.75, 2.1875, 0.375, 0.875, 2.375, 0.5}, -- NodeBox14
			{0.6875, 2.0625, 0.375, 0.8125, 2.25, 0.5}, -- NodeBox15
			{0.625, 2, 0.375, 0.75, 2.125, 0.5}, -- NodeBox16
			{0.5625, 1.875, 0.375, 0.6875, 2.0625, 0.5}, -- NodeBox17
			{0.5, 1.75, 0.375, 0.625, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.375, 1.5, 0.375, 0.5, 1.6875, 0.5}, -- NodeBox20
			{0.3125, 1.375, 0.375, 0.4375, 1.5625, 0.5}, -- NodeBox21
			{0.25, 1.3125, 0.375, 0.375, 1.4375, 0.5}, -- NodeBox22
			{0.1875, 1.1875, 0.375, 0.3125, 1.375, 0.5}, -- NodeBox23
			{0.125, 1.0625, 0.375, 0.25, 1.25, 0.5}, -- NodeBox24
			{0.0625, 0.9375, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox25
			{0, 0.8125, 0.375, 0.125, 1, 0.5}, -- NodeBox26
			{-0.0625, 0.75, 0.375, 0.0625, 0.875, 0.5}, -- NodeBox27
			{-0.125, 0.625, 0.375, -3.35276e-008, 0.8125, 0.5}, -- NodeBox28
			{-0.1875, 0.5, 0.375, -0.0625, 0.6875, 0.5}, -- NodeBox29
			{-0.25, 0.375, 0.375, -0.125, 0.5625, 0.5}, -- NodeBox30
			{-0.3125, 0.25, 0.375, -0.1875, 0.4375, 0.5}, -- NodeBox31
			{-0.375, 0.125, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox32
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox33
			{-0.4375, 3.25, 0.375, -0.3125, 3.375, 0.5}, -- NodeBox5
			{-0.375, 3.125, 0.375, -0.25, 3.3125, 0.5}, -- NodeBox6
			{-0.3125, 3, 0.375, -0.1875, 3.1875, 0.5}, -- NodeBox7
			{-0.25, 2.875, 0.375, -0.125, 3.0625, 0.5}, -- NodeBox8
			{-0.1875, 2.75, 0.375, -0.0625, 2.9375, 0.5}, -- NodeBox9
			{-0.125, 2.625, 0.375, 1.11759e-008, 2.8125, 0.5}, -- NodeBox10
			{-0.0625, 2.5625, 0.375, 0.0625, 2.6875, 0.5}, -- NodeBox11
			{0, 2.4375, 0.375, 0.125, 2.625, 0.5}, -- NodeBox12
			{0.0625, 2.3125, 0.375, 0.1875, 2.5, 0.5}, -- NodeBox13
			{0.125, 2.1875, 0.375, 0.25, 2.375, 0.5}, -- NodeBox14
			{0.1875, 2.0625, 0.375, 0.3125, 2.25, 0.5}, -- NodeBox15
			{0.25, 2, 0.375, 0.375, 2.125, 0.5}, -- NodeBox16
			{0.3125, 1.875, 0.375, 0.4375, 2.0625, 0.5}, -- NodeBox17
			{0.375, 1.75, 0.375, 0.5, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.5, 1.5, 0.375, 0.625, 1.6875, 0.5}, -- NodeBox20
			{0.5625, 1.375, 0.375, 0.6875, 1.5625, 0.5}, -- NodeBox21
			{0.625, 1.3125, 0.375, 0.75, 1.4375, 0.5}, -- NodeBox22
			{0.6875, 1.1875, 0.375, 0.8125, 1.375, 0.5}, -- NodeBox23
			{0.75, 1.0625, 0.375, 0.875, 1.25, 0.5}, -- NodeBox24
			{0.8125, 0.9375, 0.375, 0.9375, 1.125, 0.5}, -- NodeBox25
			{0.875, 0.8125, 0.375, 1, 1, 0.5}, -- NodeBox26
			{0.9375, 0.75, 0.375, 1.0625, 0.875, 0.5}, -- NodeBox27
			{1, 0.625, 0.375, 1.125, 0.8125, 0.5}, -- NodeBox28
			{1.0625, 0.5, 0.375, 1.1875, 0.6875, 0.5}, -- NodeBox29
			{1.125, 0.375, 0.375, 1.25, 0.5625, 0.5}, -- NodeBox30
			{1.1875, 0.25, 0.375, 1.3125, 0.4375, 0.5}, -- NodeBox31
			{1.25, 0.125, 0.375, 1.375, 0.3125, 0.5}, -- NodeBox32
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_tall_simple_"..bridge_colors, {
	description = bridge_desc.." Tall Truss Superstructure Middle Simple",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_simple.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_simple.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{-0.5, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{1.3125, 3.25, 0.375, 1.4375, 3.375, 0.5}, -- NodeBox5
			{1.25, 3.125, 0.375, 1.375, 3.3125, 0.5}, -- NodeBox6
			{1.1875, 3, 0.375, 1.3125, 3.1875, 0.5}, -- NodeBox7
			{1.125, 2.875, 0.375, 1.25, 3.0625, 0.5}, -- NodeBox8
			{1.0625, 2.75, 0.375, 1.1875, 2.9375, 0.5}, -- NodeBox9
			{1, 2.625, 0.375, 1.125, 2.8125, 0.5}, -- NodeBox10
			{0.9375, 2.5625, 0.375, 1.0625, 2.6875, 0.5}, -- NodeBox11
			{0.875, 2.4375, 0.375, 1, 2.625, 0.5}, -- NodeBox12
			{0.8125, 2.3125, 0.375, 0.9375, 2.5, 0.5}, -- NodeBox13
			{0.75, 2.1875, 0.375, 0.875, 2.375, 0.5}, -- NodeBox14
			{0.6875, 2.0625, 0.375, 0.8125, 2.25, 0.5}, -- NodeBox15
			{0.625, 2, 0.375, 0.75, 2.125, 0.5}, -- NodeBox16
			{0.5625, 1.875, 0.375, 0.6875, 2.0625, 0.5}, -- NodeBox17
			{0.5, 1.75, 0.375, 0.625, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.375, 1.5, 0.375, 0.5, 1.6875, 0.5}, -- NodeBox20
			{0.3125, 1.375, 0.375, 0.4375, 1.5625, 0.5}, -- NodeBox21
			{0.25, 1.3125, 0.375, 0.375, 1.4375, 0.5}, -- NodeBox22
			{0.1875, 1.1875, 0.375, 0.3125, 1.375, 0.5}, -- NodeBox23
			{0.125, 1.0625, 0.375, 0.25, 1.25, 0.5}, -- NodeBox24
			{0.0625, 0.9375, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox25
			{0, 0.8125, 0.375, 0.125, 1, 0.5}, -- NodeBox26
			{-0.0625, 0.75, 0.375, 0.0625, 0.875, 0.5}, -- NodeBox27
			{-0.125, 0.625, 0.375, -3.35276e-008, 0.8125, 0.5}, -- NodeBox28
			{-0.1875, 0.5, 0.375, -0.0625, 0.6875, 0.5}, -- NodeBox29
			{-0.25, 0.375, 0.375, -0.125, 0.5625, 0.5}, -- NodeBox30
			{-0.3125, 0.25, 0.375, -0.1875, 0.4375, 0.5}, -- NodeBox31
			{-0.375, 0.125, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox32
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox33
			{-0.4375, 3.25, 0.375, -0.3125, 3.375, 0.5}, -- NodeBox5
			{-0.375, 3.125, 0.375, -0.25, 3.3125, 0.5}, -- NodeBox6
			{-0.3125, 3, 0.375, -0.1875, 3.1875, 0.5}, -- NodeBox7
			{-0.25, 2.875, 0.375, -0.125, 3.0625, 0.5}, -- NodeBox8
			{-0.1875, 2.75, 0.375, -0.0625, 2.9375, 0.5}, -- NodeBox9
			{-0.125, 2.625, 0.375, 1.11759e-008, 2.8125, 0.5}, -- NodeBox10
			{-0.0625, 2.5625, 0.375, 0.0625, 2.6875, 0.5}, -- NodeBox11
			{0, 2.4375, 0.375, 0.125, 2.625, 0.5}, -- NodeBox12
			{0.0625, 2.3125, 0.375, 0.1875, 2.5, 0.5}, -- NodeBox13
			{0.125, 2.1875, 0.375, 0.25, 2.375, 0.5}, -- NodeBox14
			{0.1875, 2.0625, 0.375, 0.3125, 2.25, 0.5}, -- NodeBox15
			{0.25, 2, 0.375, 0.375, 2.125, 0.5}, -- NodeBox16
			{0.3125, 1.875, 0.375, 0.4375, 2.0625, 0.5}, -- NodeBox17
			{0.375, 1.75, 0.375, 0.5, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.5, 1.5, 0.375, 0.625, 1.6875, 0.5}, -- NodeBox20
			{0.5625, 1.375, 0.375, 0.6875, 1.5625, 0.5}, -- NodeBox21
			{0.625, 1.3125, 0.375, 0.75, 1.4375, 0.5}, -- NodeBox22
			{0.6875, 1.1875, 0.375, 0.8125, 1.375, 0.5}, -- NodeBox23
			{0.75, 1.0625, 0.375, 0.875, 1.25, 0.5}, -- NodeBox24
			{0.8125, 0.9375, 0.375, 0.9375, 1.125, 0.5}, -- NodeBox25
			{0.875, 0.8125, 0.375, 1, 1, 0.5}, -- NodeBox26
			{0.9375, 0.75, 0.375, 1.0625, 0.875, 0.5}, -- NodeBox27
			{1, 0.625, 0.375, 1.125, 0.8125, 0.5}, -- NodeBox28
			{1.0625, 0.5, 0.375, 1.1875, 0.6875, 0.5}, -- NodeBox29
			{1.125, 0.375, 0.375, 1.25, 0.5625, 0.5}, -- NodeBox30
			{1.1875, 0.25, 0.375, 1.3125, 0.4375, 0.5}, -- NodeBox31
			{1.25, 0.125, 0.375, 1.375, 0.3125, 0.5}, -- NodeBox32
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox33
			
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_tall_simple_end_left_"..bridge_colors, {
	description = bridge_desc.." Tall Truss Superstructure Simple Left End",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_simple_end_left.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_simple_end_left.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, 0.375, 0.5, 3.5, 0.5},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_tall_simple_end_right_"..bridge_colors, {
	description = bridge_desc.." Tall Truss Superstructure Simple Right End",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_simple_end_right.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_tall_simple_end_right.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, 3.5, 0.5},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_simple_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Middle Simple",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_simple.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_simple.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, 2.375, 0.375, 1.5, 2.5, 0.5}, -- NodeBox218
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
			{-0.5, 2.3125, 0.375, -0.375, 2.4375, 0.5},
			
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_simple_end_left_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Simple Left End",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_simple_end_left.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_simple_end_left.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, 0.375, 0.5, 2.5, 0.5},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_simple_end_right_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Simple Right End",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_simple_end_right.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_simple_end_right.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, -0.375, 2.5, 0.5},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_up_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Up Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 3.5, 0.5}, -- NodeBox4
			{1.25, 3.3125, 0.375, 1.375, 3.4375, 0.5}, -- NodeBox34
			{1.125, 3.25, 0.375, 1.25, 3.375, 0.5}, -- NodeBox35
			{1, 3.1875, 0.375, 1.125, 3.3125, 0.5}, -- NodeBox36
			{0.875, 3.125, 0.375, 1, 3.25, 0.5}, -- NodeBox37
			{0.75, 3.0625, 0.375, 0.875, 3.1875, 0.5}, -- NodeBox38
			{0.625, 3, 0.375, 0.75, 3.125, 0.5}, -- NodeBox39
			{0.5, 2.9375, 0.375, 0.625, 3.0625, 0.5}, -- NodeBox40
			{0.375, 2.875, 0.375, 0.5, 3, 0.5}, -- NodeBox41
			{0.25, 2.8125, 0.375, 0.375, 2.9375, 0.5}, -- NodeBox42
			{0.125, 2.75, 0.375, 0.25, 2.875, 0.5}, -- NodeBox43
			{0, 2.6875, 0.375, 0.125, 2.8125, 0.5}, -- NodeBox44
			{-0.125, 2.625, 0.375, -1.2666e-007, 2.75, 0.5}, -- NodeBox45
			{-0.25, 2.5625, 0.375, -0.125, 2.6875, 0.5}, -- NodeBox46
			{-0.375, 2.5, 0.375, -0.25, 2.625, 0.5}, -- NodeBox47
			{-0.5, 2.4375, 0.375, -0.375, 2.5625, 0.5}, -- NodeBox48
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_up_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Up Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 3.5, 0.5}, -- NodeBox4
			{1.25, 3.3125, 0.375, 1.375, 3.4375, 0.5}, -- NodeBox34
			{1.125, 3.25, 0.375, 1.25, 3.375, 0.5}, -- NodeBox35
			{1, 3.1875, 0.375, 1.125, 3.3125, 0.5}, -- NodeBox36
			{0.875, 3.125, 0.375, 1, 3.25, 0.5}, -- NodeBox37
			{0.75, 3.0625, 0.375, 0.875, 3.1875, 0.5}, -- NodeBox38
			{0.625, 3, 0.375, 0.75, 3.125, 0.5}, -- NodeBox39
			{0.5, 2.9375, 0.375, 0.625, 3.0625, 0.5}, -- NodeBox40
			{0.375, 2.875, 0.375, 0.5, 3, 0.5}, -- NodeBox41
			{0.25, 2.8125, 0.375, 0.375, 2.9375, 0.5}, -- NodeBox42
			{0.125, 2.75, 0.375, 0.25, 2.875, 0.5}, -- NodeBox43
			{0, 2.6875, 0.375, 0.125, 2.8125, 0.5}, -- NodeBox44
			{-0.125, 2.625, 0.375, -1.2666e-007, 2.75, 0.5}, -- NodeBox45
			{-0.25, 2.5625, 0.375, -0.125, 2.6875, 0.5}, -- NodeBox46
			{-0.375, 2.5, 0.375, -0.25, 2.625, 0.5}, -- NodeBox47
			{-0.5, 2.4375, 0.375, -0.375, 2.5625, 0.5}, -- NodeBox48
			{1.3125, 3.25, 0.375, 1.4375, 3.375, 0.5}, -- NodeBox5
			{1.25, 3.125, 0.375, 1.375, 3.3125, 0.5}, -- NodeBox6
			{1.1875, 3, 0.375, 1.3125, 3.1875, 0.5}, -- NodeBox7
			{1.125, 2.875, 0.375, 1.25, 3.0625, 0.5}, -- NodeBox8
			{1.0625, 2.75, 0.375, 1.1875, 2.9375, 0.5}, -- NodeBox9
			{1, 2.625, 0.375, 1.125, 2.8125, 0.5}, -- NodeBox10
			{0.9375, 2.5625, 0.375, 1.0625, 2.6875, 0.5}, -- NodeBox11
			{0.875, 2.4375, 0.375, 1, 2.625, 0.5}, -- NodeBox12
			{0.8125, 2.3125, 0.375, 0.9375, 2.5, 0.5}, -- NodeBox13
			{0.75, 2.1875, 0.375, 0.875, 2.375, 0.5}, -- NodeBox14
			{0.6875, 2.0625, 0.375, 0.8125, 2.25, 0.5}, -- NodeBox15
			{0.625, 2, 0.375, 0.75, 2.125, 0.5}, -- NodeBox16
			{0.5625, 1.875, 0.375, 0.6875, 2.0625, 0.5}, -- NodeBox17
			{0.5, 1.75, 0.375, 0.625, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.375, 1.5, 0.375, 0.5, 1.6875, 0.5}, -- NodeBox20
			{0.3125, 1.375, 0.375, 0.4375, 1.5625, 0.5}, -- NodeBox21
			{0.25, 1.3125, 0.375, 0.375, 1.4375, 0.5}, -- NodeBox22
			{0.1875, 1.1875, 0.375, 0.3125, 1.375, 0.5}, -- NodeBox23
			{0.125, 1.0625, 0.375, 0.25, 1.25, 0.5}, -- NodeBox24
			{0.0625, 0.9375, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox25
			{0, 0.8125, 0.375, 0.125, 1, 0.5}, -- NodeBox26
			{-0.0625, 0.75, 0.375, 0.0625, 0.875, 0.5}, -- NodeBox27
			{-0.125, 0.625, 0.375, -3.35276e-008, 0.8125, 0.5}, -- NodeBox28
			{-0.1875, 0.5, 0.375, -0.0625, 0.6875, 0.5}, -- NodeBox29
			{-0.25, 0.375, 0.375, -0.125, 0.5625, 0.5}, -- NodeBox30
			{-0.3125, 0.25, 0.375, -0.1875, 0.4375, 0.5}, -- NodeBox31
			{-0.375, 0.125, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox32
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_up_mid_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Up Middle",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_mid.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_mid.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 3.5, 0.5}, -- NodeBox4
			{1.25, 3.3125, 0.375, 1.375, 3.4375, 0.5}, -- NodeBox34
			{1.125, 3.25, 0.375, 1.25, 3.375, 0.5}, -- NodeBox35
			{1, 3.1875, 0.375, 1.125, 3.3125, 0.5}, -- NodeBox36
			{0.875, 3.125, 0.375, 1, 3.25, 0.5}, -- NodeBox37
			{0.75, 3.0625, 0.375, 0.875, 3.1875, 0.5}, -- NodeBox38
			{0.625, 3, 0.375, 0.75, 3.125, 0.5}, -- NodeBox39
			{0.5, 2.9375, 0.375, 0.625, 3.0625, 0.5}, -- NodeBox40
			{0.375, 2.875, 0.375, 0.5, 3, 0.5}, -- NodeBox41
			{0.25, 2.8125, 0.375, 0.375, 2.9375, 0.5}, -- NodeBox42
			{0.125, 2.75, 0.375, 0.25, 2.875, 0.5}, -- NodeBox43
			{0, 2.6875, 0.375, 0.125, 2.8125, 0.5}, -- NodeBox44
			{-0.125, 2.625, 0.375, -1.2666e-007, 2.75, 0.5}, -- NodeBox45
			{-0.25, 2.5625, 0.375, -0.125, 2.6875, 0.5}, -- NodeBox46
			{-0.375, 2.5, 0.375, -0.25, 2.625, 0.5}, -- NodeBox47
			{-0.5, 2.4375, 0.375, -0.375, 2.5625, 0.5}, -- NodeBox48
			{1.3125, 3.25, 0.375, 1.4375, 3.375, 0.5}, -- NodeBox5
			{1.25, 3.125, 0.375, 1.375, 3.3125, 0.5}, -- NodeBox6
			{1.1875, 3, 0.375, 1.3125, 3.1875, 0.5}, -- NodeBox7
			{1.125, 2.875, 0.375, 1.25, 3.0625, 0.5}, -- NodeBox8
			{1.0625, 2.75, 0.375, 1.1875, 2.9375, 0.5}, -- NodeBox9
			{1, 2.625, 0.375, 1.125, 2.8125, 0.5}, -- NodeBox10
			{0.9375, 2.5625, 0.375, 1.0625, 2.6875, 0.5}, -- NodeBox11
			{0.875, 2.4375, 0.375, 1, 2.625, 0.5}, -- NodeBox12
			{0.8125, 2.3125, 0.375, 0.9375, 2.5, 0.5}, -- NodeBox13
			{0.75, 2.1875, 0.375, 0.875, 2.375, 0.5}, -- NodeBox14
			{0.6875, 2.0625, 0.375, 0.8125, 2.25, 0.5}, -- NodeBox15
			{0.625, 2, 0.375, 0.75, 2.125, 0.5}, -- NodeBox16
			{0.5625, 1.875, 0.375, 0.6875, 2.0625, 0.5}, -- NodeBox17
			{0.5, 1.75, 0.375, 0.625, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.375, 1.5, 0.375, 0.5, 1.6875, 0.5}, -- NodeBox20
			{0.3125, 1.375, 0.375, 0.4375, 1.5625, 0.5}, -- NodeBox21
			{0.25, 1.3125, 0.375, 0.375, 1.4375, 0.5}, -- NodeBox22
			{0.1875, 1.1875, 0.375, 0.3125, 1.375, 0.5}, -- NodeBox23
			{0.125, 1.0625, 0.375, 0.25, 1.25, 0.5}, -- NodeBox24
			{0.0625, 0.9375, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox25
			{0, 0.8125, 0.375, 0.125, 1, 0.5}, -- NodeBox26
			{-0.0625, 0.75, 0.375, 0.0625, 0.875, 0.5}, -- NodeBox27
			{-0.125, 0.625, 0.375, -3.35276e-008, 0.8125, 0.5}, -- NodeBox28
			{-0.1875, 0.5, 0.375, -0.0625, 0.6875, 0.5}, -- NodeBox29
			{-0.25, 0.375, 0.375, -0.125, 0.5625, 0.5}, -- NodeBox30
			{-0.3125, 0.25, 0.375, -0.1875, 0.4375, 0.5}, -- NodeBox31
			{-0.375, 0.125, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox32
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox33
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_up_simple_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Up Simple",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_simple.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_up_simple.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 3.375, 0.375, 1.5, 3.5, 0.5}, -- NodeBox2
			{1.25, 3.3125, 0.375, 1.375, 3.4375, 0.5}, -- NodeBox34
			{1.125, 3.25, 0.375, 1.25, 3.375, 0.5}, -- NodeBox35
			{1, 3.1875, 0.375, 1.125, 3.3125, 0.5}, -- NodeBox36
			{0.875, 3.125, 0.375, 1, 3.25, 0.5}, -- NodeBox37
			{0.75, 3.0625, 0.375, 0.875, 3.1875, 0.5}, -- NodeBox38
			{0.625, 3, 0.375, 0.75, 3.125, 0.5}, -- NodeBox39
			{0.5, 2.9375, 0.375, 0.625, 3.0625, 0.5}, -- NodeBox40
			{0.375, 2.875, 0.375, 0.5, 3, 0.5}, -- NodeBox41
			{0.25, 2.8125, 0.375, 0.375, 2.9375, 0.5}, -- NodeBox42
			{0.125, 2.75, 0.375, 0.25, 2.875, 0.5}, -- NodeBox43
			{0, 2.6875, 0.375, 0.125, 2.8125, 0.5}, -- NodeBox44
			{-0.125, 2.625, 0.375, -1.2666e-007, 2.75, 0.5}, -- NodeBox45
			{-0.25, 2.5625, 0.375, -0.125, 2.6875, 0.5}, -- NodeBox46
			{-0.375, 2.5, 0.375, -0.25, 2.625, 0.5}, -- NodeBox47
			{-0.5, 2.4375, 0.375, -0.375, 2.5625, 0.5}, -- NodeBox48
			{1.3125, 3.25, 0.375, 1.4375, 3.375, 0.5}, -- NodeBox5
			{1.25, 3.125, 0.375, 1.375, 3.3125, 0.5}, -- NodeBox6
			{1.1875, 3, 0.375, 1.3125, 3.1875, 0.5}, -- NodeBox7
			{1.125, 2.875, 0.375, 1.25, 3.0625, 0.5}, -- NodeBox8
			{1.0625, 2.75, 0.375, 1.1875, 2.9375, 0.5}, -- NodeBox9
			{1, 2.625, 0.375, 1.125, 2.8125, 0.5}, -- NodeBox10
			{0.9375, 2.5625, 0.375, 1.0625, 2.6875, 0.5}, -- NodeBox11
			{0.875, 2.4375, 0.375, 1, 2.625, 0.5}, -- NodeBox12
			{0.8125, 2.3125, 0.375, 0.9375, 2.5, 0.5}, -- NodeBox13
			{0.75, 2.1875, 0.375, 0.875, 2.375, 0.5}, -- NodeBox14
			{0.6875, 2.0625, 0.375, 0.8125, 2.25, 0.5}, -- NodeBox15
			{0.625, 2, 0.375, 0.75, 2.125, 0.5}, -- NodeBox16
			{0.5625, 1.875, 0.375, 0.6875, 2.0625, 0.5}, -- NodeBox17
			{0.5, 1.75, 0.375, 0.625, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.375, 1.5, 0.375, 0.5, 1.6875, 0.5}, -- NodeBox20
			{0.3125, 1.375, 0.375, 0.4375, 1.5625, 0.5}, -- NodeBox21
			{0.25, 1.3125, 0.375, 0.375, 1.4375, 0.5}, -- NodeBox22
			{0.1875, 1.1875, 0.375, 0.3125, 1.375, 0.5}, -- NodeBox23
			{0.125, 1.0625, 0.375, 0.25, 1.25, 0.5}, -- NodeBox24
			{0.0625, 0.9375, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox25
			{0, 0.8125, 0.375, 0.125, 1, 0.5}, -- NodeBox26
			{-0.0625, 0.75, 0.375, 0.0625, 0.875, 0.5}, -- NodeBox27
			{-0.125, 0.625, 0.375, -3.35276e-008, 0.8125, 0.5}, -- NodeBox28
			{-0.1875, 0.5, 0.375, -0.0625, 0.6875, 0.5}, -- NodeBox29
			{-0.25, 0.375, 0.375, -0.125, 0.5625, 0.5}, -- NodeBox30
			{-0.3125, 0.25, 0.375, -0.1875, 0.4375, 0.5}, -- NodeBox31
			{-0.375, 0.125, 0.375, -0.25, 0.3125, 0.5}, -- NodeBox32
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox33
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_down_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Down Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 2.4375, 0.375, 1.5, 2.5625, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 3.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox4
			{1.25, 2.5, 0.375, 1.375, 2.625, 0.5}, -- NodeBox34
			{1.125, 2.5625, 0.375, 1.25, 2.6875, 0.5}, -- NodeBox35
			{1, 2.625, 0.375, 1.125, 2.75, 0.5}, -- NodeBox36
			{0.875, 2.6875, 0.375, 1, 2.8125, 0.5}, -- NodeBox37
			{0.75, 2.75, 0.375, 0.875, 2.875, 0.5}, -- NodeBox38
			{0.625, 2.8125, 0.375, 0.75, 2.9375, 0.5}, -- NodeBox39
			{0.5, 2.875, 0.375, 0.625, 3, 0.5}, -- NodeBox40
			{0.375, 2.9375, 0.375, 0.5, 3.0625, 0.5}, -- NodeBox41
			{0.25, 3, 0.375, 0.375, 3.125, 0.5}, -- NodeBox42
			{0.125, 3.0625, 0.375, 0.25, 3.1875, 0.5}, -- NodeBox43
			{0, 3.125, 0.375, 0.125, 3.25, 0.5}, -- NodeBox44
			{-0.125, 3.1875, 0.375, -1.2666e-007, 3.3125, 0.5}, -- NodeBox45
			{-0.25, 3.25, 0.375, -0.125, 3.375, 0.5}, -- NodeBox46
			{-0.375, 3.3125, 0.375, -0.25, 3.4375, 0.5}, -- NodeBox47
			{-0.5, 3.375, 0.375, -0.375, 3.5, 0.5}, -- NodeBox48
			{-0.4375, 3.25, 0.375, -0.3125, 3.375, 0.5}, -- NodeBox5
			{-0.375, 3.125, 0.375, -0.25, 3.3125, 0.5}, -- NodeBox6
			{-0.3125, 3, 0.375, -0.1875, 3.1875, 0.5}, -- NodeBox7
			{-0.25, 2.875, 0.375, -0.125, 3.0625, 0.5}, -- NodeBox8
			{-0.1875, 2.75, 0.375, -0.0625, 2.9375, 0.5}, -- NodeBox9
			{-0.125, 2.625, 0.375, 1.11759e-008, 2.8125, 0.5}, -- NodeBox10
			{-0.0625, 2.5625, 0.375, 0.0625, 2.6875, 0.5}, -- NodeBox11
			{0, 2.4375, 0.375, 0.125, 2.625, 0.5}, -- NodeBox12
			{0.0625, 2.3125, 0.375, 0.1875, 2.5, 0.5}, -- NodeBox13
			{0.125, 2.1875, 0.375, 0.25, 2.375, 0.5}, -- NodeBox14
			{0.1875, 2.0625, 0.375, 0.3125, 2.25, 0.5}, -- NodeBox15
			{0.25, 2, 0.375, 0.375, 2.125, 0.5}, -- NodeBox16
			{0.3125, 1.875, 0.375, 0.4375, 2.0625, 0.5}, -- NodeBox17
			{0.375, 1.75, 0.375, 0.5, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.5, 1.5, 0.375, 0.625, 1.6875, 0.5}, -- NodeBox20
			{0.5625, 1.375, 0.375, 0.6875, 1.5625, 0.5}, -- NodeBox21
			{0.625, 1.3125, 0.375, 0.75, 1.4375, 0.5}, -- NodeBox22
			{0.6875, 1.1875, 0.375, 0.8125, 1.375, 0.5}, -- NodeBox23
			{0.75, 1.0625, 0.375, 0.875, 1.25, 0.5}, -- NodeBox24
			{0.8125, 0.9375, 0.375, 0.9375, 1.125, 0.5}, -- NodeBox25
			{0.875, 0.8125, 0.375, 1, 1, 0.5}, -- NodeBox26
			{0.9375, 0.75, 0.375, 1.0625, 0.875, 0.5}, -- NodeBox27
			{1, 0.625, 0.375, 1.125, 0.8125, 0.5}, -- NodeBox28
			{1.0625, 0.5, 0.375, 1.1875, 0.6875, 0.5}, -- NodeBox29
			{1.125, 0.375, 0.375, 1.25, 0.5625, 0.5}, -- NodeBox30
			{1.1875, 0.25, 0.375, 1.3125, 0.4375, 0.5}, -- NodeBox31
			{1.25, 0.125, 0.375, 1.375, 0.3125, 0.5}, -- NodeBox32
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_down_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Down Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 2.4375, 0.375, 1.5, 2.5625, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 3.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox4
			{1.25, 2.5, 0.375, 1.375, 2.625, 0.5}, -- NodeBox34
			{1.125, 2.5625, 0.375, 1.25, 2.6875, 0.5}, -- NodeBox35
			{1, 2.625, 0.375, 1.125, 2.75, 0.5}, -- NodeBox36
			{0.875, 2.6875, 0.375, 1, 2.8125, 0.5}, -- NodeBox37
			{0.75, 2.75, 0.375, 0.875, 2.875, 0.5}, -- NodeBox38
			{0.625, 2.8125, 0.375, 0.75, 2.9375, 0.5}, -- NodeBox39
			{0.5, 2.875, 0.375, 0.625, 3, 0.5}, -- NodeBox40
			{0.375, 2.9375, 0.375, 0.5, 3.0625, 0.5}, -- NodeBox41
			{0.25, 3, 0.375, 0.375, 3.125, 0.5}, -- NodeBox42
			{0.125, 3.0625, 0.375, 0.25, 3.1875, 0.5}, -- NodeBox43
			{0, 3.125, 0.375, 0.125, 3.25, 0.5}, -- NodeBox44
			{-0.125, 3.1875, 0.375, -1.2666e-007, 3.3125, 0.5}, -- NodeBox45
			{-0.25, 3.25, 0.375, -0.125, 3.375, 0.5}, -- NodeBox46
			{-0.375, 3.3125, 0.375, -0.25, 3.4375, 0.5}, -- NodeBox47
			{-0.5, 3.375, 0.375, -0.375, 3.5, 0.5}, -- NodeBox48
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_down_mid_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Down Middle",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_mid.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_mid.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 2.4375, 0.375, 1.5, 2.5625, 0.5}, -- NodeBox2
			{-0.5, -0.5, 0.375, -0.4375, 3.5, 0.5}, -- NodeBox3
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox4
			{1.25, 2.5, 0.375, 1.375, 2.625, 0.5}, -- NodeBox34
			{1.125, 2.5625, 0.375, 1.25, 2.6875, 0.5}, -- NodeBox35
			{1, 2.625, 0.375, 1.125, 2.75, 0.5}, -- NodeBox36
			{0.875, 2.6875, 0.375, 1, 2.8125, 0.5}, -- NodeBox37
			{0.75, 2.75, 0.375, 0.875, 2.875, 0.5}, -- NodeBox38
			{0.625, 2.8125, 0.375, 0.75, 2.9375, 0.5}, -- NodeBox39
			{0.5, 2.875, 0.375, 0.625, 3, 0.5}, -- NodeBox40
			{0.375, 2.9375, 0.375, 0.5, 3.0625, 0.5}, -- NodeBox41
			{0.25, 3, 0.375, 0.375, 3.125, 0.5}, -- NodeBox42
			{0.125, 3.0625, 0.375, 0.25, 3.1875, 0.5}, -- NodeBox43
			{0, 3.125, 0.375, 0.125, 3.25, 0.5}, -- NodeBox44
			{-0.125, 3.1875, 0.375, -1.2666e-007, 3.3125, 0.5}, -- NodeBox45
			{-0.25, 3.25, 0.375, -0.125, 3.375, 0.5}, -- NodeBox46
			{-0.375, 3.3125, 0.375, -0.25, 3.4375, 0.5}, -- NodeBox47
			{-0.5, 3.375, 0.375, -0.375, 3.5, 0.5}, -- NodeBox48
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
			{-0.4375, 3.25, 0.375, -0.3125, 3.375, 0.5}, -- NodeBox5
			{-0.375, 3.125, 0.375, -0.25, 3.3125, 0.5}, -- NodeBox6
			{-0.3125, 3, 0.375, -0.1875, 3.1875, 0.5}, -- NodeBox7
			{-0.25, 2.875, 0.375, -0.125, 3.0625, 0.5}, -- NodeBox8
			{-0.1875, 2.75, 0.375, -0.0625, 2.9375, 0.5}, -- NodeBox9
			{-0.125, 2.625, 0.375, 1.11759e-008, 2.8125, 0.5}, -- NodeBox10
			{-0.0625, 2.5625, 0.375, 0.0625, 2.6875, 0.5}, -- NodeBox11
			{0, 2.4375, 0.375, 0.125, 2.625, 0.5}, -- NodeBox12
			{0.0625, 2.3125, 0.375, 0.1875, 2.5, 0.5}, -- NodeBox13
			{0.125, 2.1875, 0.375, 0.25, 2.375, 0.5}, -- NodeBox14
			{0.1875, 2.0625, 0.375, 0.3125, 2.25, 0.5}, -- NodeBox15
			{0.25, 2, 0.375, 0.375, 2.125, 0.5}, -- NodeBox16
			{0.3125, 1.875, 0.375, 0.4375, 2.0625, 0.5}, -- NodeBox17
			{0.375, 1.75, 0.375, 0.5, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.5, 1.5, 0.375, 0.625, 1.6875, 0.5}, -- NodeBox20
			{0.5625, 1.375, 0.375, 0.6875, 1.5625, 0.5}, -- NodeBox21
			{0.625, 1.3125, 0.375, 0.75, 1.4375, 0.5}, -- NodeBox22
			{0.6875, 1.1875, 0.375, 0.8125, 1.375, 0.5}, -- NodeBox23
			{0.75, 1.0625, 0.375, 0.875, 1.25, 0.5}, -- NodeBox24
			{0.8125, 0.9375, 0.375, 0.9375, 1.125, 0.5}, -- NodeBox25
			{0.875, 0.8125, 0.375, 1, 1, 0.5}, -- NodeBox26
			{0.9375, 0.75, 0.375, 1.0625, 0.875, 0.5}, -- NodeBox27
			{1, 0.625, 0.375, 1.125, 0.8125, 0.5}, -- NodeBox28
			{1.0625, 0.5, 0.375, 1.1875, 0.6875, 0.5}, -- NodeBox29
			{1.125, 0.375, 0.375, 1.25, 0.5625, 0.5}, -- NodeBox30
			{1.1875, 0.25, 0.375, 1.3125, 0.4375, 0.5}, -- NodeBox31
			{1.25, 0.125, 0.375, 1.375, 0.3125, 0.5}, -- NodeBox32
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_down_simple_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Down Simple",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_simple.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_down_simple.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox1
			{1.375, 2.4375, 0.375, 1.5, 2.5625, 0.5}, -- NodeBox2
			{1.25, 2.5, 0.375, 1.375, 2.625, 0.5}, -- NodeBox34
			{1.125, 2.5625, 0.375, 1.25, 2.6875, 0.5}, -- NodeBox35
			{1, 2.625, 0.375, 1.125, 2.75, 0.5}, -- NodeBox36
			{0.875, 2.6875, 0.375, 1, 2.8125, 0.5}, -- NodeBox37
			{0.75, 2.75, 0.375, 0.875, 2.875, 0.5}, -- NodeBox38
			{0.625, 2.8125, 0.375, 0.75, 2.9375, 0.5}, -- NodeBox39
			{0.5, 2.875, 0.375, 0.625, 3, 0.5}, -- NodeBox40
			{0.375, 2.9375, 0.375, 0.5, 3.0625, 0.5}, -- NodeBox41
			{0.25, 3, 0.375, 0.375, 3.125, 0.5}, -- NodeBox42
			{0.125, 3.0625, 0.375, 0.25, 3.1875, 0.5}, -- NodeBox43
			{0, 3.125, 0.375, 0.125, 3.25, 0.5}, -- NodeBox44
			{-0.125, 3.1875, 0.375, -1.2666e-007, 3.3125, 0.5}, -- NodeBox45
			{-0.25, 3.25, 0.375, -0.125, 3.375, 0.5}, -- NodeBox46
			{-0.375, 3.3125, 0.375, -0.25, 3.4375, 0.5}, -- NodeBox47
			{-0.5, 3.375, 0.375, -0.375, 3.5, 0.5}, -- NodeBox48
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
			{-0.4375, 3.25, 0.375, -0.3125, 3.375, 0.5}, -- NodeBox5
			{-0.375, 3.125, 0.375, -0.25, 3.3125, 0.5}, -- NodeBox6
			{-0.3125, 3, 0.375, -0.1875, 3.1875, 0.5}, -- NodeBox7
			{-0.25, 2.875, 0.375, -0.125, 3.0625, 0.5}, -- NodeBox8
			{-0.1875, 2.75, 0.375, -0.0625, 2.9375, 0.5}, -- NodeBox9
			{-0.125, 2.625, 0.375, 1.11759e-008, 2.8125, 0.5}, -- NodeBox10
			{-0.0625, 2.5625, 0.375, 0.0625, 2.6875, 0.5}, -- NodeBox11
			{0, 2.4375, 0.375, 0.125, 2.625, 0.5}, -- NodeBox12
			{0.0625, 2.3125, 0.375, 0.1875, 2.5, 0.5}, -- NodeBox13
			{0.125, 2.1875, 0.375, 0.25, 2.375, 0.5}, -- NodeBox14
			{0.1875, 2.0625, 0.375, 0.3125, 2.25, 0.5}, -- NodeBox15
			{0.25, 2, 0.375, 0.375, 2.125, 0.5}, -- NodeBox16
			{0.3125, 1.875, 0.375, 0.4375, 2.0625, 0.5}, -- NodeBox17
			{0.375, 1.75, 0.375, 0.5, 1.9375, 0.5}, -- NodeBox18
			{0.4375, 1.625, 0.375, 0.5625, 1.8125, 0.5}, -- NodeBox19
			{0.5, 1.5, 0.375, 0.625, 1.6875, 0.5}, -- NodeBox20
			{0.5625, 1.375, 0.375, 0.6875, 1.5625, 0.5}, -- NodeBox21
			{0.625, 1.3125, 0.375, 0.75, 1.4375, 0.5}, -- NodeBox22
			{0.6875, 1.1875, 0.375, 0.8125, 1.375, 0.5}, -- NodeBox23
			{0.75, 1.0625, 0.375, 0.875, 1.25, 0.5}, -- NodeBox24
			{0.8125, 0.9375, 0.375, 0.9375, 1.125, 0.5}, -- NodeBox25
			{0.875, 0.8125, 0.375, 1, 1, 0.5}, -- NodeBox26
			{0.9375, 0.75, 0.375, 1.0625, 0.875, 0.5}, -- NodeBox27
			{1, 0.625, 0.375, 1.125, 0.8125, 0.5}, -- NodeBox28
			{1.0625, 0.5, 0.375, 1.1875, 0.6875, 0.5}, -- NodeBox29
			{1.125, 0.375, 0.375, 1.25, 0.5625, 0.5}, -- NodeBox30
			{1.1875, 0.25, 0.375, 1.3125, 0.4375, 0.5}, -- NodeBox31
			{1.25, 0.125, 0.375, 1.375, 0.3125, 0.5}, -- NodeBox32
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox33
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 3.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_substructure_end_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Substructure End Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_substructure_end_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_substructure_end_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 1.375, 0.375, 1.5, 1.5, 0.5}, -- NodeBox122
			{-0.4375, 1.3125, 0.375, -0.3125, 1.4375, 0.5}, -- NodeBox126
			{-0.375, 1.25, 0.375, -0.25, 1.375, 0.5}, -- NodeBox127
			{-0.3125, 1.1875, 0.375, -0.1875, 1.3125, 0.5}, -- NodeBox128
			{-0.25, 1.125, 0.375, -0.125, 1.25, 0.5}, -- NodeBox129
			{-0.1875, 1.0625, 0.375, -0.0625, 1.1875, 0.5}, -- NodeBox130
			{-0.125, 1, 0.375, 0, 1.125, 0.5}, -- NodeBox131
			{-0.0625, 0.9375, 0.375, 0.0625, 1.0625, 0.5}, -- NodeBox132
			{0, 0.875, 0.375, 0.125, 1, 0.5}, -- NodeBox133
			{0.0625, 0.8125, 0.375, 0.1875, 0.9375, 0.5}, -- NodeBox134
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox135
			{0.1875, 0.6875, 0.375, 0.3125, 0.8125, 0.5}, -- NodeBox136
			{0.25, 0.625, 0.375, 0.375, 0.75, 0.5}, -- NodeBox137
			{0.3125, 0.5625, 0.375, 0.4375, 0.6875, 0.5}, -- NodeBox138
			{0.375, 0.5, 0.375, 0.5, 0.625, 0.5}, -- NodeBox139
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox140
			{0.5, 0.375, 0.375, 0.625, 0.5, 0.5}, -- NodeBox141
			{0.5625, 0.3125, 0.375, 0.6875, 0.4375, 0.5}, -- NodeBox142
			{0.625, 0.25, 0.375, 0.75, 0.375, 0.5}, -- NodeBox143
			{0.6875, 0.1875, 0.375, 0.8125, 0.3125, 0.5}, -- NodeBox144
			{0.75, 0.125, 0.375, 0.875, 0.25, 0.5}, -- NodeBox145
			{0.8125, 0.0625, 0.375, 0.9375, 0.1875, 0.5}, -- NodeBox146
			{0.875, 0, 0.375, 1, 0.125, 0.5}, -- NodeBox147
			{0.9375, -0.0625, 0.375, 1.0625, 0.0625, 0.5}, -- NodeBox148
			{1, -0.125, 0.375, 1.125, 0, 0.5}, -- NodeBox149
			{1.0625, -0.1875, 0.375, 1.1875, -0.0625, 0.5}, -- NodeBox150
			{1.125, -0.25, 0.375, 1.25, -0.125, 0.5}, -- NodeBox151
			{1.1875, -0.3125, 0.375, 1.3125, -0.1875, 0.5}, -- NodeBox152
			{1.25, -0.375, 0.375, 1.375, -0.25, 0.5}, -- NodeBox153
			{1.3125, -0.4375, 0.375, 1.4375, -0.3125, 0.5}, -- NodeBox154
			{1.375, -0.5, 0.375, 1.5, -0.375, 0.5}, -- NodeBox189
			{1.4375, -0.5, 0.375, 1.5, 1.5, 0.5}, -- NodeBox190
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_substructure_end_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Substructure End Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_substructure_end_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_substructure_end_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 1.375, 0.375, 1.5, 1.5, 0.5}, -- NodeBox122
			{1.3125, 1.3125, 0.375, 1.4375, 1.4375, 0.5}, -- NodeBox126
			{1.25, 1.25, 0.375, 1.375, 1.375, 0.5}, -- NodeBox127
			{1.1875, 1.1875, 0.375, 1.3125, 1.3125, 0.5}, -- NodeBox128
			{1.125, 1.125, 0.375, 1.25, 1.25, 0.5}, -- NodeBox129
			{1.0625, 1.0625, 0.375, 1.1875, 1.1875, 0.5}, -- NodeBox130
			{1, 1, 0.375, 1.125, 1.125, 0.5}, -- NodeBox131
			{0.9375, 0.9375, 0.375, 1.0625, 1.0625, 0.5}, -- NodeBox132
			{0.875, 0.875, 0.375, 1, 1, 0.5}, -- NodeBox133
			{0.8125, 0.8125, 0.375, 0.9375, 0.9375, 0.5}, -- NodeBox134
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox135
			{0.6875, 0.6875, 0.375, 0.8125, 0.8125, 0.5}, -- NodeBox136
			{0.625, 0.625, 0.375, 0.75, 0.75, 0.5}, -- NodeBox137
			{0.5625, 0.5625, 0.375, 0.6875, 0.6875, 0.5}, -- NodeBox138
			{0.5, 0.5, 0.375, 0.625, 0.625, 0.5}, -- NodeBox139
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox140
			{0.375, 0.375, 0.375, 0.5, 0.5, 0.5}, -- NodeBox141
			{0.3125, 0.3125, 0.375, 0.4375, 0.4375, 0.5}, -- NodeBox142
			{0.25, 0.25, 0.375, 0.375, 0.375, 0.5}, -- NodeBox143
			{0.1875, 0.1875, 0.375, 0.3125, 0.3125, 0.5}, -- NodeBox144
			{0.125, 0.125, 0.375, 0.25, 0.25, 0.5}, -- NodeBox145
			{0.0625, 0.0625, 0.375, 0.1875, 0.1875, 0.5}, -- NodeBox146
			{0, 0, 0.375, 0.125, 0.125, 0.5}, -- NodeBox147
			{-0.0625, -0.0625, 0.375, 0.0625, 0.0625, 0.5}, -- NodeBox148
			{-0.125, -0.125, 0.375, 0, 0, 0.5}, -- NodeBox149
			{-0.1875, -0.1875, 0.375, -0.0625, -0.0625, 0.5}, -- NodeBox150
			{-0.25, -0.25, 0.375, -0.125, -0.125, 0.5}, -- NodeBox151
			{-0.3125, -0.3125, 0.375, -0.1875, -0.1875, 0.5}, -- NodeBox152
			{-0.375, -0.375, 0.375, -0.25, -0.25, 0.5}, -- NodeBox153
			{-0.4375, -0.4375, 0.375, -0.3125, -0.3125, 0.5}, -- NodeBox154
			{-0.5, -0.5, 0.375, -0.4375, 1.5, 0.5}, -- NodeBox188
			{-0.5, -0.5, 0.375, -0.375, -0.375, 0.5}, -- NodeBox192
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_substructure_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Substructure Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_substructure_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_substructure_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 1.375, 0.375, 1.5, 1.5, 0.5}, -- NodeBox122
			{-0.4375, 1.3125, 0.375, -0.3125, 1.4375, 0.5}, -- NodeBox126
			{-0.375, 1.25, 0.375, -0.25, 1.375, 0.5}, -- NodeBox127
			{-0.3125, 1.1875, 0.375, -0.1875, 1.3125, 0.5}, -- NodeBox128
			{-0.25, 1.125, 0.375, -0.125, 1.25, 0.5}, -- NodeBox129
			{-0.1875, 1.0625, 0.375, -0.0625, 1.1875, 0.5}, -- NodeBox130
			{-0.125, 1, 0.375, 0, 1.125, 0.5}, -- NodeBox131
			{-0.0625, 0.9375, 0.375, 0.0625, 1.0625, 0.5}, -- NodeBox132
			{0, 0.875, 0.375, 0.125, 1, 0.5}, -- NodeBox133
			{0.0625, 0.8125, 0.375, 0.1875, 0.9375, 0.5}, -- NodeBox134
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox135
			{0.1875, 0.6875, 0.375, 0.3125, 0.8125, 0.5}, -- NodeBox136
			{0.25, 0.625, 0.375, 0.375, 0.75, 0.5}, -- NodeBox137
			{0.3125, 0.5625, 0.375, 0.4375, 0.6875, 0.5}, -- NodeBox138
			{0.375, 0.5, 0.375, 0.5, 0.625, 0.5}, -- NodeBox139
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox140
			{0.5, 0.375, 0.375, 0.625, 0.5, 0.5}, -- NodeBox141
			{0.5625, 0.3125, 0.375, 0.6875, 0.4375, 0.5}, -- NodeBox142
			{0.625, 0.25, 0.375, 0.75, 0.375, 0.5}, -- NodeBox143
			{0.6875, 0.1875, 0.375, 0.8125, 0.3125, 0.5}, -- NodeBox144
			{0.75, 0.125, 0.375, 0.875, 0.25, 0.5}, -- NodeBox145
			{0.8125, 0.0625, 0.375, 0.9375, 0.1875, 0.5}, -- NodeBox146
			{0.875, 0, 0.375, 1, 0.125, 0.5}, -- NodeBox147
			{0.9375, -0.0625, 0.375, 1.0625, 0.0625, 0.5}, -- NodeBox148
			{1, -0.125, 0.375, 1.125, 0, 0.5}, -- NodeBox149
			{1.0625, -0.1875, 0.375, 1.1875, -0.0625, 0.5}, -- NodeBox150
			{1.125, -0.25, 0.375, 1.25, -0.125, 0.5}, -- NodeBox151
			{1.1875, -0.3125, 0.375, 1.3125, -0.1875, 0.5}, -- NodeBox152
			{1.25, -0.375, 0.375, 1.375, -0.25, 0.5}, -- NodeBox153
			{1.3125, -0.4375, 0.375, 1.4375, -0.3125, 0.5}, -- NodeBox154
			{-0.5, -0.5, 0.375, -0.4375, 1.5, 0.5}, -- NodeBox188
			{-0.5, -0.5, 0.375, 1.5, -0.375, 0.5}, -- NodeBox189
			{1.4375, -0.5, 0.375, 1.5, 1.5, 0.5}, -- NodeBox190
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_substructure_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Substructure Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_substructure_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_substructure_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 1.375, 0.375, 1.5, 1.5, 0.5}, -- NodeBox122
			{1.3125, 1.3125, 0.375, 1.4375, 1.4375, 0.5}, -- NodeBox126
			{1.25, 1.25, 0.375, 1.375, 1.375, 0.5}, -- NodeBox127
			{1.1875, 1.1875, 0.375, 1.3125, 1.3125, 0.5}, -- NodeBox128
			{1.125, 1.125, 0.375, 1.25, 1.25, 0.5}, -- NodeBox129
			{1.0625, 1.0625, 0.375, 1.1875, 1.1875, 0.5}, -- NodeBox130
			{1, 1, 0.375, 1.125, 1.125, 0.5}, -- NodeBox131
			{0.9375, 0.9375, 0.375, 1.0625, 1.0625, 0.5}, -- NodeBox132
			{0.875, 0.875, 0.375, 1, 1, 0.5}, -- NodeBox133
			{0.8125, 0.8125, 0.375, 0.9375, 0.9375, 0.5}, -- NodeBox134
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox135
			{0.6875, 0.6875, 0.375, 0.8125, 0.8125, 0.5}, -- NodeBox136
			{0.625, 0.625, 0.375, 0.75, 0.75, 0.5}, -- NodeBox137
			{0.5625, 0.5625, 0.375, 0.6875, 0.6875, 0.5}, -- NodeBox138
			{0.5, 0.5, 0.375, 0.625, 0.625, 0.5}, -- NodeBox139
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox140
			{0.375, 0.375, 0.375, 0.5, 0.5, 0.5}, -- NodeBox141
			{0.3125, 0.3125, 0.375, 0.4375, 0.4375, 0.5}, -- NodeBox142
			{0.25, 0.25, 0.375, 0.375, 0.375, 0.5}, -- NodeBox143
			{0.1875, 0.1875, 0.375, 0.3125, 0.3125, 0.5}, -- NodeBox144
			{0.125, 0.125, 0.375, 0.25, 0.25, 0.5}, -- NodeBox145
			{0.0625, 0.0625, 0.375, 0.1875, 0.1875, 0.5}, -- NodeBox146
			{0, 0, 0.375, 0.125, 0.125, 0.5}, -- NodeBox147
			{-0.0625, -0.0625, 0.375, 0.0625, 0.0625, 0.5}, -- NodeBox148
			{-0.125, -0.125, 0.375, 0, 0, 0.5}, -- NodeBox149
			{-0.1875, -0.1875, 0.375, -0.0625, -0.0625, 0.5}, -- NodeBox150
			{-0.25, -0.25, 0.375, -0.125, -0.125, 0.5}, -- NodeBox151
			{-0.3125, -0.3125, 0.375, -0.1875, -0.1875, 0.5}, -- NodeBox152
			{-0.375, -0.375, 0.375, -0.25, -0.25, 0.5}, -- NodeBox153
			{-0.4375, -0.4375, 0.375, -0.3125, -0.3125, 0.5}, -- NodeBox154
			{-0.5, -0.5, 0.375, -0.4375, 1.5, 0.5}, -- NodeBox188
			{-0.5, -0.5, 0.375, 1.5, -0.375, 0.5}, -- NodeBox189
			{1.4375, -0.5, 0.375, 1.5, 1.5, 0.5}, -- NodeBox190
			{-0.5, -0.5, 0.375, -0.375, -0.375, 0.5}, -- NodeBox192
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_substructure_simple_"..bridge_colors, {
	description = bridge_desc.." Truss Substructure Simple",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_substructure_simple.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_substructure_simple.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, -0.375, 0.5}, -- NodeBox121
			{-0.5, 1.375, 0.375, 1.5, 1.5, 0.5}, -- NodeBox122
			{-0.4375, 1.3125, 0.375, -0.3125, 1.4375, 0.5}, -- NodeBox126
			{-0.375, 1.25, 0.375, -0.25, 1.375, 0.5}, -- NodeBox127
			{-0.3125, 1.1875, 0.375, -0.1875, 1.3125, 0.5}, -- NodeBox128
			{-0.25, 1.125, 0.375, -0.125, 1.25, 0.5}, -- NodeBox129
			{-0.1875, 1.0625, 0.375, -0.0625, 1.1875, 0.5}, -- NodeBox130
			{-0.125, 1, 0.375, 0, 1.125, 0.5}, -- NodeBox131
			{-0.0625, 0.9375, 0.375, 0.0625, 1.0625, 0.5}, -- NodeBox132
			{0, 0.875, 0.375, 0.125, 1, 0.5}, -- NodeBox133
			{0.0625, 0.8125, 0.375, 0.1875, 0.9375, 0.5}, -- NodeBox134
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox135
			{0.1875, 0.6875, 0.375, 0.3125, 0.8125, 0.5}, -- NodeBox136
			{0.25, 0.625, 0.375, 0.375, 0.75, 0.5}, -- NodeBox137
			{0.3125, 0.5625, 0.375, 0.4375, 0.6875, 0.5}, -- NodeBox138
			{0.375, 0.5, 0.375, 0.5, 0.625, 0.5}, -- NodeBox139
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox140
			{0.5, 0.375, 0.375, 0.625, 0.5, 0.5}, -- NodeBox141
			{0.5625, 0.3125, 0.375, 0.6875, 0.4375, 0.5}, -- NodeBox142
			{0.625, 0.25, 0.375, 0.75, 0.375, 0.5}, -- NodeBox143
			{0.6875, 0.1875, 0.375, 0.8125, 0.3125, 0.5}, -- NodeBox144
			{0.75, 0.125, 0.375, 0.875, 0.25, 0.5}, -- NodeBox145
			{0.8125, 0.0625, 0.375, 0.9375, 0.1875, 0.5}, -- NodeBox146
			{0.875, 0, 0.375, 1, 0.125, 0.5}, -- NodeBox147
			{0.9375, -0.0625, 0.375, 1.0625, 0.0625, 0.5}, -- NodeBox148
			{1, -0.125, 0.375, 1.125, 0, 0.5}, -- NodeBox149
			{1.0625, -0.1875, 0.375, 1.1875, -0.0625, 0.5}, -- NodeBox150
			{1.125, -0.25, 0.375, 1.25, -0.125, 0.5}, -- NodeBox151
			{1.1875, -0.3125, 0.375, 1.3125, -0.1875, 0.5}, -- NodeBox152
			{1.25, -0.375, 0.375, 1.375, -0.25, 0.5}, -- NodeBox153
			{1.3125, -0.4375, 0.375, 1.4375, -0.3125, 0.5}, -- NodeBox154
			{1.3125, 1.3125, 0.375, 1.4375, 1.4375, 0.5}, -- NodeBox157
			{1.25, 1.25, 0.375, 1.375, 1.375, 0.5}, -- NodeBox158
			{1.1875, 1.1875, 0.375, 1.3125, 1.3125, 0.5}, -- NodeBox159
			{1.125, 1.125, 0.375, 1.25, 1.25, 0.5}, -- NodeBox160
			{1.0625, 1.0625, 0.375, 1.1875, 1.1875, 0.5}, -- NodeBox161
			{1, 1, 0.375, 1.125, 1.125, 0.5}, -- NodeBox162
			{0.9375, 0.9375, 0.375, 1.0625, 1.0625, 0.5}, -- NodeBox163
			{0.875, 0.875, 0.375, 1, 1, 0.5}, -- NodeBox164
			{0.8125, 0.8125, 0.375, 0.9375, 0.9375, 0.5}, -- NodeBox165
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox166
			{0.6875, 0.6875, 0.375, 0.8125, 0.8125, 0.5}, -- NodeBox167
			{0.625, 0.625, 0.375, 0.75, 0.75, 0.5}, -- NodeBox168
			{0.5625, 0.5625, 0.375, 0.6875, 0.6875, 0.5}, -- NodeBox169
			{0.375, 0.375, 0.375, 0.625, 0.625, 0.5}, -- NodeBox170
			{0.3125, 0.3125, 0.375, 0.4375, 0.4375, 0.5}, -- NodeBox171
			{0.25, 0.25, 0.375, 0.375, 0.375, 0.5}, -- NodeBox172
			{0.1875, 0.1875, 0.375, 0.3125, 0.3125, 0.5}, -- NodeBox173
			{0.125, 0.125, 0.375, 0.25, 0.25, 0.5}, -- NodeBox174
			{0.0625, 0.0625, 0.375, 0.1875, 0.1875, 0.5}, -- NodeBox175
			{0, 0, 0.375, 0.125, 0.125, 0.5}, -- NodeBox176
			{-0.0625, -0.0625, 0.375, 0.0625, 0.0625, 0.5}, -- NodeBox177
			{-0.125, -0.125, 0.375, 0, 0, 0.5}, -- NodeBox178
			{-0.1875, -0.1875, 0.375, -0.0625, -0.0625, 0.5}, -- NodeBox179
			{-0.25, -0.25, 0.375, -0.125, -0.125, 0.5}, -- NodeBox180
			{-0.3125, -0.3125, 0.375, -0.1875, -0.1875, 0.5}, -- NodeBox181
			{-0.375, -0.375, 0.375, -0.25, -0.25, 0.5}, -- NodeBox182
			{-0.4375, -0.4375, 0.375, -0.3125, -0.3125, 0.5}, -- NodeBox183
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_substructure_mid_"..bridge_colors, {
	description = bridge_desc.." Truss Substructure Middle",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_substructure_mid.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_substructure_mid.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, -0.375, 0.5}, -- NodeBox121
			{-0.5, 1.375, 0.375, 1.5, 1.5, 0.5}, -- NodeBox122
			{-0.4375, 1.3125, 0.375, -0.3125, 1.4375, 0.5}, -- NodeBox126
			{-0.375, 1.25, 0.375, -0.25, 1.375, 0.5}, -- NodeBox127
			{-0.3125, 1.1875, 0.375, -0.1875, 1.3125, 0.5}, -- NodeBox128
			{-0.25, 1.125, 0.375, -0.125, 1.25, 0.5}, -- NodeBox129
			{-0.1875, 1.0625, 0.375, -0.0625, 1.1875, 0.5}, -- NodeBox130
			{-0.125, 1, 0.375, 0, 1.125, 0.5}, -- NodeBox131
			{-0.0625, 0.9375, 0.375, 0.0625, 1.0625, 0.5}, -- NodeBox132
			{0, 0.875, 0.375, 0.125, 1, 0.5}, -- NodeBox133
			{0.0625, 0.8125, 0.375, 0.1875, 0.9375, 0.5}, -- NodeBox134
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox135
			{0.1875, 0.6875, 0.375, 0.3125, 0.8125, 0.5}, -- NodeBox136
			{0.25, 0.625, 0.375, 0.375, 0.75, 0.5}, -- NodeBox137
			{0.3125, 0.5625, 0.375, 0.4375, 0.6875, 0.5}, -- NodeBox138
			{0.375, 0.5, 0.375, 0.5, 0.625, 0.5}, -- NodeBox139
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox140
			{0.5, 0.375, 0.375, 0.625, 0.5, 0.5}, -- NodeBox141
			{0.5625, 0.3125, 0.375, 0.6875, 0.4375, 0.5}, -- NodeBox142
			{0.625, 0.25, 0.375, 0.75, 0.375, 0.5}, -- NodeBox143
			{0.6875, 0.1875, 0.375, 0.8125, 0.3125, 0.5}, -- NodeBox144
			{0.75, 0.125, 0.375, 0.875, 0.25, 0.5}, -- NodeBox145
			{0.8125, 0.0625, 0.375, 0.9375, 0.1875, 0.5}, -- NodeBox146
			{0.875, 0, 0.375, 1, 0.125, 0.5}, -- NodeBox147
			{0.9375, -0.0625, 0.375, 1.0625, 0.0625, 0.5}, -- NodeBox148
			{1, -0.125, 0.375, 1.125, 0, 0.5}, -- NodeBox149
			{1.0625, -0.1875, 0.375, 1.1875, -0.0625, 0.5}, -- NodeBox150
			{1.125, -0.25, 0.375, 1.25, -0.125, 0.5}, -- NodeBox151
			{1.1875, -0.3125, 0.375, 1.3125, -0.1875, 0.5}, -- NodeBox152
			{1.25, -0.375, 0.375, 1.375, -0.25, 0.5}, -- NodeBox153
			{1.3125, -0.4375, 0.375, 1.4375, -0.3125, 0.5}, -- NodeBox154
			{1.3125, 1.3125, 0.375, 1.4375, 1.4375, 0.5}, -- NodeBox157
			{1.25, 1.25, 0.375, 1.375, 1.375, 0.5}, -- NodeBox158
			{1.1875, 1.1875, 0.375, 1.3125, 1.3125, 0.5}, -- NodeBox159
			{1.125, 1.125, 0.375, 1.25, 1.25, 0.5}, -- NodeBox160
			{1.0625, 1.0625, 0.375, 1.1875, 1.1875, 0.5}, -- NodeBox161
			{1, 1, 0.375, 1.125, 1.125, 0.5}, -- NodeBox162
			{0.9375, 0.9375, 0.375, 1.0625, 1.0625, 0.5}, -- NodeBox163
			{0.875, 0.875, 0.375, 1, 1, 0.5}, -- NodeBox164
			{0.8125, 0.8125, 0.375, 0.9375, 0.9375, 0.5}, -- NodeBox165
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox166
			{0.6875, 0.6875, 0.375, 0.8125, 0.8125, 0.5}, -- NodeBox167
			{0.625, 0.625, 0.375, 0.75, 0.75, 0.5}, -- NodeBox168
			{0.5625, 0.5625, 0.375, 0.6875, 0.6875, 0.5}, -- NodeBox169
			{0.375, 0.375, 0.375, 0.625, 0.625, 0.5}, -- NodeBox170
			{0.3125, 0.3125, 0.375, 0.4375, 0.4375, 0.5}, -- NodeBox171
			{0.25, 0.25, 0.375, 0.375, 0.375, 0.5}, -- NodeBox172
			{0.1875, 0.1875, 0.375, 0.3125, 0.3125, 0.5}, -- NodeBox173
			{0.125, 0.125, 0.375, 0.25, 0.25, 0.5}, -- NodeBox174
			{0.0625, 0.0625, 0.375, 0.1875, 0.1875, 0.5}, -- NodeBox175
			{0, 0, 0.375, 0.125, 0.125, 0.5}, -- NodeBox176
			{-0.0625, -0.0625, 0.375, 0.0625, 0.0625, 0.5}, -- NodeBox177
			{-0.125, -0.125, 0.375, 0, 0, 0.5}, -- NodeBox178
			{-0.1875, -0.1875, 0.375, -0.0625, -0.0625, 0.5}, -- NodeBox179
			{-0.25, -0.25, 0.375, -0.125, -0.125, 0.5}, -- NodeBox180
			{-0.3125, -0.3125, 0.375, -0.1875, -0.1875, 0.5}, -- NodeBox181
			{-0.375, -0.375, 0.375, -0.25, -0.25, 0.5}, -- NodeBox182
			{-0.4375, -0.4375, 0.375, -0.3125, -0.3125, 0.5}, -- NodeBox183
			{1.4375, -0.5, 0.375, 1.5, 1.5, 0.5}, -- NodeBox184
			{-0.5, -0.5, 0.375, -0.4375, 1.5, 0.5}, -- NodeBox185
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:small_upper_chord_"..bridge_colors, {
	description = bridge_desc.." Small Upper Chord",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_small_upper_chord.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_small_upper_chord.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox250
			{0.4375, 0.375, -1.5, 0.5, 0.5, 0.5}, -- NodeBox251
			{-0.5, 0.375, -1.5, 0.5, 0.5, -1.4375}, -- NodeBox252
			{-0.5, 0.375, -1.5, -0.4375, 0.5, 0.5}, -- NodeBox253
			{-0.4375, 0.375, 0.25, -0.3125, 0.5, 0.4375}, -- NodeBox260
			{-0.375, 0.375, 0.125, -0.25, 0.5, 0.3125}, -- NodeBox261
			{-0.3125, 0.375, 0, -0.1875, 0.5, 0.1875}, -- NodeBox262
			{-0.25, 0.375, -0.125, -0.125, 0.5, 0.0625}, -- NodeBox263
			{-0.1875, 0.375, -0.25, -0.0625, 0.5, -0.0625}, -- NodeBox264
			{-0.4375, 0.375, -1.4375, -0.3125, 0.5, -1.25}, -- NodeBox265
			{-0.375, 0.375, -1.3125, -0.25, 0.5, -1.125}, -- NodeBox266
			{-0.3125, 0.375, -1.1875, -0.1875, 0.5, -1}, -- NodeBox267
			{-0.25, 0.375, -1.0625, -0.125, 0.5, -0.875}, -- NodeBox268
			{-0.1875, 0.375, -0.9375, -0.0625, 0.5, -0.75}, -- NodeBox269
			{-0.125, 0.375, -0.8125, 0, 0.5, -0.625}, -- NodeBox270
			{-0.125, 0.375, -0.375, 0, 0.5, -0.1875}, -- NodeBox271
			{0.3125, 0.375, 0.25, 0.4375, 0.5, 0.4375}, -- NodeBox272
			{0.25, 0.375, 0.125, 0.375, 0.5, 0.3125}, -- NodeBox273
			{0.1875, 0.375, 0, 0.3125, 0.5, 0.1875}, -- NodeBox274
			{0.125, 0.375, -0.125, 0.25, 0.5, 0.0625}, -- NodeBox275
			{0.0625, 0.375, -0.25, 0.1875, 0.5, -0.0625}, -- NodeBox276
			{0, 0.375, -0.375, 0.125, 0.5, -0.1875}, -- NodeBox277
			{-0.0625, 0.375, -0.625, 0.0625, 0.5, -0.375}, -- NodeBox278
			{0.3125, 0.375, -1.4375, 0.4375, 0.5, -1.25}, -- NodeBox279
			{0.25, 0.375, -1.3125, 0.375, 0.5, -1.125}, -- NodeBox280
			{0.1875, 0.375, -1.1875, 0.3125, 0.5, -1}, -- NodeBox281
			{0.125, 0.375, -1.0625, 0.25, 0.5, -0.875}, -- NodeBox282
			{0.0625, 0.375, -0.9375, 0.1875, 0.5, -0.75}, -- NodeBox283
			{0, 0.375, -0.8125, 0.125, 0.5, -0.625}, -- NodeBox284
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, 0, -1.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:small_upper_chord_slanted_"..bridge_colors, {
	description = bridge_desc.." Small Slanted Upper Chord",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_small_upper_chord_slanted.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_small_upper_chord_slanted.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5625, -1.5, -0.4375, -0.4375, -1.375}, -- NodeBox1
			{-0.5, -0.5625, -1.5, 0.5, -0.4375, -1.4375}, -- NodeBox2
			{0.4375, -0.5625, -1.5, 0.5, -0.4375, -1.375}, -- NodeBox3
			{0.4375, -0.5, -1.375, 0.5, -0.375, -1.25}, -- NodeBox4
			{0.4375, -0.4375, -1.25, 0.5, -0.3125, -1.125}, -- NodeBox5
			{0.4375, -0.375, -1.125, 0.5, -0.25, -1}, -- NodeBox6
			{0.4375, -0.3125, -1, 0.5, -0.1875, -0.875}, -- NodeBox7
			{0.4375, -0.25, -0.875, 0.5, -0.125, -0.75}, -- NodeBox8
			{0.4375, -0.1875, -0.75, 0.5, -0.0625, -0.625}, -- NodeBox9
			{0.4375, -0.125, -0.625, 0.5, -2.23517e-008, -0.5}, -- NodeBox10
			{0.4375, -0.0625, -0.5, 0.5, 0.0625, -0.375}, -- NodeBox11
			{0.4375, 0, -0.375, 0.5, 0.125, -0.25}, -- NodeBox12
			{0.4375, 0.0625, -0.25, 0.5, 0.1875, -0.125}, -- NodeBox13
			{0.4375, 0.125, -0.125, 0.5, 0.25, -1.04308e-007}, -- NodeBox14
			{0.4375, 0.1875, 0, 0.5, 0.3125, 0.125}, -- NodeBox15
			{0.4375, 0.25, 0.125, 0.5, 0.375, 0.25}, -- NodeBox16
			{0.4375, 0.3125, 0.25, 0.5, 0.4375, 0.375}, -- NodeBox17
			{0.4375, 0.375, 0.375, 0.5, 0.5, 0.5}, -- NodeBox18
			{-0.5, 0.375, 0.4375, 0.5, 0.5, 0.5}, -- NodeBox19
			{-0.5, -0.5, -1.375, -0.4375, -0.375, -1.25}, -- NodeBox20
			{-0.5, -0.4375, -1.25, -0.4375, -0.3125, -1.125}, -- NodeBox21
			{-0.5, -0.375, -1.125, -0.4375, -0.25, -1}, -- NodeBox22
			{-0.5, -0.3125, -1, -0.4375, -0.1875, -0.875}, -- NodeBox23
			{-0.5, -0.25, -0.875, -0.4375, -0.125, -0.75}, -- NodeBox24
			{-0.5, -0.1875, -0.75, -0.4375, -0.0625, -0.625}, -- NodeBox25
			{-0.5, -0.125, -0.625, -0.4375, 1.11759e-008, -0.5}, -- NodeBox26
			{-0.5, -0.0625, -0.5, -0.4375, 0.0625, -0.375}, -- NodeBox27
			{-0.5, 0, -0.375, -0.4375, 0.125, -0.25}, -- NodeBox28
			{-0.5, 0.0625, -0.25, -0.4375, 0.1875, -0.125}, -- NodeBox29
			{-0.5, 0.125, -0.125, -0.4375, 0.25, 1.41561e-007}, -- NodeBox30
			{-0.5, 0.1875, 0, -0.4375, 0.3125, 0.125}, -- NodeBox31
			{-0.5, 0.25, 0.125, -0.4375, 0.375, 0.25}, -- NodeBox32
			{-0.5, 0.3125, 0.25, -0.4375, 0.4375, 0.375}, -- NodeBox33
			{-0.5, 0.375, 0.375, -0.4375, 0.5, 0.5}, -- NodeBox34
			{-0.4375, -0.5625, -1.5, -0.3125, -0.4375, -1.375}, -- NodeBox35
			{-0.4375, -0.5, -1.375, -0.3125, -0.375, -1.25}, -- NodeBox36
			{-0.375, -0.5, -1.3125, -0.25, -0.375, -1.25}, -- NodeBox37
			{-0.375, -0.4375, -1.25, -0.25, -0.3125, -1.125}, -- NodeBox38
			{-0.3125, -0.4375, -1.1875, -0.1875, -0.3125, -1.125}, -- NodeBox39
			{-0.3125, -0.375, -1.125, -0.1875, -0.25, -1}, -- NodeBox40
			{-0.25, -0.375, -1.0625, -0.125, -0.25, -1}, -- NodeBox41
			{-0.25, -0.3125, -1, -0.125, -0.1875, -0.875}, -- NodeBox42
			{-0.1875, -0.3125, -0.9375, -0.0625, -0.1875, -0.875}, -- NodeBox43
			{-0.1875, -0.25, -0.875, -0.0624999, -0.125, -0.75}, -- NodeBox44
			{-0.125, -0.25, -0.8125, 0.125, -0.125, -0.75}, -- NodeBox45
			{-0.125, -0.1875, -0.75, 0.125, -0.0624999, -0.625}, -- NodeBox46
			{-0.0625, -0.125, -0.625, 0.0625, 9.31323e-008, -0.5}, -- NodeBox47
			{-0.0625, -0.0625, -0.5, 0.0625, 0.0625001, -0.375}, -- NodeBox48
			{-0.125, 0, -0.375, 0.125, 0.125, -0.25}, -- NodeBox49
			{-0.4375, 0.375, 0.375, -0.3125, 0.5, 0.4375}, -- NodeBox62
			{-0.4375, 0.3125, 0.25, -0.3125, 0.4375, 0.375}, -- NodeBox63
			{-0.375, 0.25, 0.125, -0.25, 0.375, 0.25}, -- NodeBox64
			{-0.375, 0.3125, 0.25, -0.25, 0.4375, 0.3125}, -- NodeBox65
			{-0.3125, 0.25, 0.125, -0.1875, 0.375, 0.1875}, -- NodeBox66
			{-0.3125, 0.1875, 0, -0.1875, 0.3125, 0.125}, -- NodeBox67
			{-0.25, 0.1875, 0, -0.125, 0.3125, 0.0625}, -- NodeBox68
			{-0.25, 0.125, -0.125, -0.125, 0.25, 1.30385e-008}, -- NodeBox69
			{-0.1875, 0.125, -0.125, -0.0625, 0.25, -0.0625}, -- NodeBox70
			{-0.1875, 0.0625, -0.25, -0.0625, 0.1875, -0.125}, -- NodeBox71
			{-0.125, 0.0625, -0.25, 0.125, 0.1875, -0.1875}, -- NodeBox72
			{0.0625, 0.0625, -0.25, 0.1875, 0.1875, -0.125}, -- NodeBox73
			{0.0625, 0.125, -0.125, 0.1875, 0.25, -0.0625}, -- NodeBox74
			{0.125, 0.125, -0.125, 0.25, 0.25, 0}, -- NodeBox75
			{0.125, 0.1875, 0, 0.25, 0.3125, 0.0625}, -- NodeBox76
			{0.1875, 0.1875, 0, 0.3125, 0.3125, 0.125}, -- NodeBox77
			{0.1875, 0.25, 0.125, 0.3125, 0.375, 0.1875}, -- NodeBox78
			{0.25, 0.25, 0.125, 0.375, 0.375, 0.25}, -- NodeBox79
			{0.25, 0.3125, 0.25, 0.375, 0.4375, 0.3125}, -- NodeBox80
			{0.3125, 0.3125, 0.3125, 0.4375, 0.4375, 0.375}, -- NodeBox81
			{0.3125, 0.375, 0.375, 0.4375, 0.5, 0.4375}, -- NodeBox82
			{0.3125, -0.5625, -1.4375, 0.4375, -0.4375, -1.375}, -- NodeBox83
			{0.3125, -0.5, -1.375, 0.4375, -0.375, -1.25}, -- NodeBox84
			{0.25, -0.5, -1.3125, 0.375, -0.375, -1.25}, -- NodeBox85
			{0.25, -0.4375, -1.25, 0.375, -0.3125, -1.125}, -- NodeBox86
			{0.1875, -0.4375, -1.1875, 0.3125, -0.3125, -1.125}, -- NodeBox87
			{0.1875, -0.375, -1.125, 0.3125, -0.25, -1}, -- NodeBox88
			{0.125, -0.375, -1.0625, 0.25, -0.25, -1}, -- NodeBox89
			{0.125, -0.3125, -1, 0.25, -0.1875, -0.875}, -- NodeBox90
			{0.0625, -0.3125, -0.9375, 0.1875, -0.1875, -0.875}, -- NodeBox91
			{0.0625, -0.25, -0.875, 0.1875, -0.125, -0.75}, -- NodeBox92
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, -1.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:medium_upper_chord_"..bridge_colors, {
	description = bridge_desc.." Medium Upper Chord",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_medium_upper_chord.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_medium_upper_chord.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, 0.375, 0.4375, 1.5, 0.5, 0.5}, -- NodeBox250
			{1.4375, 0.375, -1.5, 1.5, 0.5, 0.5}, -- NodeBox251
			{-1.5, 0.375, -1.5, 1.5, 0.5, -1.4375}, -- NodeBox252
			{-1.5, 0.375, -1.5, -1.4375, 0.5, 0.5}, -- NodeBox253
			{-1.4375, 0.375, 0.3125, -1.3125, 0.5, 0.4375}, -- NodeBox285
			{-1.375, 0.375, 0.25, -1.1875, 0.5, 0.375}, -- NodeBox286
			{-1.25, 0.375, 0.1875, -1.125, 0.5, 0.3125}, -- NodeBox287
			{-1.1875, 0.375, 0.125, -1, 0.5, 0.25}, -- NodeBox289
			{-1.0625, 0.375, 0.0625, -0.9375, 0.5, 0.1875}, -- NodeBox290
			{-1, 0.375, 0, -0.8125, 0.5, 0.125}, -- NodeBox291
			{-0.875, 0.375, -0.0625, -0.75, 0.5, 0.0625}, -- NodeBox292
			{-0.8125, 0.375, -0.125, -0.625, 0.5, 0}, -- NodeBox293
			{-0.6875, 0.375, -0.1875, -0.5625, 0.5, -0.0625}, -- NodeBox294
			{-0.625, 0.375, -0.25, -0.4375, 0.5, -0.125}, -- NodeBox295
			{-0.5, 0.375, -0.3125, -0.375, 0.5, -0.1875}, -- NodeBox296
			{-0.4375, 0.375, -0.375, -0.25, 0.5, -0.25}, -- NodeBox297
			{-0.3125, 0.375, -0.4375, -0.1875, 0.5, -0.3125}, -- NodeBox298
			{-0.25, 0.375, -0.5, -0.0625, 0.5, -0.375}, -- NodeBox299
			{-0.125, 0.375, -0.5625, 0.125, 0.5, -0.4375}, -- NodeBox300
			{1.3125, 0.375, -1.4375, 1.4375, 0.5, -1.3125}, -- NodeBox301
			{1.1875, 0.375, -1.375, 1.375, 0.5, -1.25}, -- NodeBox302
			{1.125, 0.375, -1.3125, 1.25, 0.5, -1.1875}, -- NodeBox303
			{1, 0.375, -1.25, 1.1875, 0.5, -1.125}, -- NodeBox304
			{0.9375, 0.375, -1.1875, 1.0625, 0.5, -1.0625}, -- NodeBox305
			{0.8125, 0.375, -1.125, 1, 0.5, -1}, -- NodeBox306
			{0.75, 0.375, -1.0625, 0.875, 0.5, -0.9375}, -- NodeBox307
			{0.625, 0.375, -1, 0.8125, 0.5, -0.875}, -- NodeBox308
			{0.5625, 0.375, -0.9375, 0.6875, 0.5, -0.8125}, -- NodeBox309
			{0.4375, 0.375, -0.875, 0.625, 0.5, -0.75}, -- NodeBox310
			{0.375, 0.375, -0.8125, 0.5, 0.5, -0.6875}, -- NodeBox311
			{0.25, 0.375, -0.75, 0.4375, 0.5, -0.625}, -- NodeBox312
			{0.1875, 0.375, -0.6875, 0.3125, 0.5, -0.5625}, -- NodeBox313
			{0.0625, 0.375, -0.625, 0.25, 0.5, -0.5}, -- NodeBox314
			{1.3125, 0.375, 0.3125, 1.4375, 0.5, 0.4375}, -- NodeBox315
			{1.1875, 0.375, 0.25, 1.375, 0.5, 0.375}, -- NodeBox316
			{1.125, 0.375, 0.1875, 1.25, 0.5, 0.3125}, -- NodeBox317
			{1, 0.375, 0.125, 1.1875, 0.5, 0.25}, -- NodeBox318
			{0.9375, 0.375, 0.0625, 1.0625, 0.5, 0.1875}, -- NodeBox319
			{0.8125, 0.375, 0, 1, 0.5, 0.125}, -- NodeBox320
			{0.75, 0.375, -0.0625, 0.875, 0.5, 0.0625}, -- NodeBox321
			{0.625, 0.375, -0.125, 0.8125, 0.5, 0}, -- NodeBox322
			{0.5625, 0.375, -0.1875, 0.6875, 0.5, -0.0625}, -- NodeBox323
			{0.4375, 0.375, -0.25, 0.625, 0.5, -0.125}, -- NodeBox324
			{0.375, 0.375, -0.3125, 0.5, 0.5, -0.1875}, -- NodeBox325
			{0.25, 0.375, -0.375, 0.4375, 0.5, -0.25}, -- NodeBox326
			{0.1875, 0.375, -0.4375, 0.3125, 0.5, -0.3125}, -- NodeBox327
			{0.0625, 0.375, -0.5, 0.25, 0.5, -0.375}, -- NodeBox328
			{-1.4375, 0.375, -1.4375, -1.3125, 0.5, -1.3125}, -- NodeBox329
			{-1.375, 0.375, -1.375, -1.1875, 0.5, -1.25}, -- NodeBox330
			{-1.25, 0.375, -1.3125, -1.125, 0.5, -1.1875}, -- NodeBox331
			{-1.1875, 0.375, -1.25, -1, 0.5, -1.125}, -- NodeBox332
			{-1.0625, 0.375, -1.1875, -0.9375, 0.5, -1.0625}, -- NodeBox333
			{-1, 0.375, -1.125, -0.8125, 0.5, -1}, -- NodeBox334
			{-0.875, 0.375, -1.0625, -0.75, 0.5, -0.9375}, -- NodeBox335
			{-0.8125, 0.375, -1, -0.625, 0.5, -0.875}, -- NodeBox336
			{-0.6875, 0.375, -0.9375, -0.5625, 0.5, -0.8125}, -- NodeBox337
			{-0.625, 0.375, -0.875, -0.4375, 0.5, -0.75}, -- NodeBox338
			{-0.5, 0.375, -0.8125, -0.375, 0.5, -0.6875}, -- NodeBox339
			{-0.4375, 0.375, -0.75, -0.25, 0.5, -0.625}, -- NodeBox340
			{-0.3125, 0.375, -0.6875, -0.1875, 0.5, -0.5625}, -- NodeBox341
			{-0.25, 0.375, -0.625, -0.0625, 0.5, -0.5}, -- NodeBox342
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-1.5, 0, -1.5, 1.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:medium_upper_chord_slanted_"..bridge_colors, {
	description = bridge_desc.." Medium Slanted Upper Chord",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_medium_upper_chord_slanted.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_medium_upper_chord_slanted.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, -0.5625, -1.5, -1.4375, -0.4375, -1.375}, -- NodeBox1
			{-1.5, -0.5625, -1.5, 1.5, -0.4375, -1.4375}, -- NodeBox2
			{1.4375, -0.5625, -1.5, 1.5, -0.4375, -1.375}, -- NodeBox3
			{1.4375, -0.5, -1.375, 1.5, -0.375, -1.25}, -- NodeBox4
			{1.4375, -0.4375, -1.25, 1.5, -0.3125, -1.125}, -- NodeBox5
			{1.4375, -0.375, -1.125, 1.5, -0.25, -1}, -- NodeBox6
			{1.4375, -0.3125, -1, 1.5, -0.1875, -0.875}, -- NodeBox7
			{1.4375, -0.25, -0.875, 1.5, -0.125, -0.75}, -- NodeBox8
			{1.4375, -0.1875, -0.75, 1.5, -0.0625, -0.625}, -- NodeBox9
			{1.4375, -0.125, -0.625, 1.5, -2.23517e-008, -0.5}, -- NodeBox10
			{1.4375, -0.0625, -0.5, 1.5, 0.0625, -0.375}, -- NodeBox11
			{1.4375, 0, -0.375, 1.5, 0.125, -0.25}, -- NodeBox12
			{1.4375, 0.0625, -0.25, 1.5, 0.1875, -0.125}, -- NodeBox13
			{1.4375, 0.125, -0.125, 1.5, 0.25, -9.68575e-008}, -- NodeBox14
			{1.4375, 0.1875, 0, 1.5, 0.3125, 0.125}, -- NodeBox15
			{1.4375, 0.25, 0.125, 1.5, 0.375, 0.25}, -- NodeBox16
			{1.4375, 0.3125, 0.25, 1.5, 0.4375, 0.375}, -- NodeBox17
			{1.4375, 0.375, 0.375, 1.5, 0.5, 0.5}, -- NodeBox18
			{-1.5, 0.375, 0.4375, 1.5, 0.5, 0.5}, -- NodeBox19
			{-1.5, -0.5, -1.375, -1.4375, -0.375, -1.25}, -- NodeBox20
			{-1.5, -0.4375, -1.25, -1.4375, -0.3125, -1.125}, -- NodeBox21
			{-1.5, -0.375, -1.125, -1.4375, -0.25, -1}, -- NodeBox22
			{-1.5, -0.3125, -1, -1.4375, -0.1875, -0.875}, -- NodeBox23
			{-1.5, -0.25, -0.875, -1.4375, -0.125, -0.75}, -- NodeBox24
			{-1.5, -0.1875, -0.75, -1.4375, -0.0625, -0.625}, -- NodeBox25
			{-1.5, -0.125, -0.625, -1.4375, 1.11759e-008, -0.5}, -- NodeBox26
			{-1.5, -0.0625, -0.5, -1.4375, 0.0625, -0.375}, -- NodeBox27
			{-1.5, 0, -0.375, -1.4375, 0.125, -0.25}, -- NodeBox28
			{-1.5, 0.0625, -0.25, -1.4375, 0.1875, -0.125}, -- NodeBox29
			{-1.5, 0.125, -0.125, -1.4375, 0.25, 1.49012e-007}, -- NodeBox30
			{-1.5, 0.1875, 0, -1.4375, 0.3125, 0.125}, -- NodeBox31
			{-1.5, 0.25, 0.125, -1.4375, 0.375, 0.25}, -- NodeBox32
			{-1.5, 0.3125, 0.25, -1.4375, 0.4375, 0.375}, -- NodeBox33
			{-1.5, 0.375, 0.375, -1.4375, 0.5, 0.5}, -- NodeBox34
			{-1.4375, -0.5625, -1.4375, -1.3125, -0.4375, -1.375}, -- NodeBox93
			{-1.4375, -0.5, -1.375, -1.1875, -0.375, -1.3125}, -- NodeBox94
			{-1.375, -0.5, -1.3125, -1.125, -0.375, -1.25}, -- NodeBox95
			{-1.25, -0.4375, -1.25, -1, -0.3125, -1.1875}, -- NodeBox96
			{-1.1875, -0.4375, -1.1875, -0.9375, -0.3125, -1.125}, -- NodeBox97
			{-1.0625, -0.375, -1.125, -0.8125, -0.25, -1.0625}, -- NodeBox98
			{-1, -0.375, -1.0625, -0.75, -0.25, -1}, -- NodeBox99
			{-0.875, -0.3125, -1, -0.625, -0.1875, -0.9375}, -- NodeBox100
			{-0.8125, -0.3125, -0.9375, -0.5625, -0.1875, -0.875}, -- NodeBox101
			{-0.6875, -0.25, -0.875, -0.4375, -0.125, -0.8125}, -- NodeBox102
			{-0.625, -0.25, -0.8125, -0.375, -0.125, -0.75}, -- NodeBox103
			{-0.5, -0.1875, -0.75, -0.25, -0.0625, -0.6875}, -- NodeBox104
			{-0.4375, -0.1875, -0.6875, -0.1875, -0.0625, -0.625}, -- NodeBox105
			{-0.3125, -0.125, -0.625, -0.0625, 3.35276e-008, -0.5625}, -- NodeBox106
			{-0.25, -0.125, -0.5625, 0.25, 3.35276e-008, -0.5}, -- NodeBox107
			{-0.25, -0.0625, -0.5, 0.25, 0.0625, -0.4375}, -- NodeBox108
			{-0.3125, -0.0625, -0.4375, -0.0625, 0.0625, -0.375}, -- NodeBox109
			{-0.4375, 0, -0.375, -0.1875, 0.125, -0.3125}, -- NodeBox110
			{-0.5, 0, -0.3125, -0.25, 0.125, -0.25}, -- NodeBox111
			{-0.625, 0.0625, -0.25, -0.375, 0.1875, -0.1875}, -- NodeBox112
			{-0.6875, 0.0625, -0.1875, -0.4375, 0.1875, -0.125}, -- NodeBox113
			{-0.8125, 0.125, -0.125, -0.5625, 0.25, -0.0625001}, -- NodeBox114
			{-0.875, 0.125, -0.0625, -0.625, 0.25, -9.87202e-008}, -- NodeBox115
			{-1, 0.1875, 0, -0.75, 0.3125, 0.0624999}, -- NodeBox116
			{-1.0625, 0.1875, 0.0625, -0.8125, 0.3125, 0.125}, -- NodeBox117
			{-1.1875, 0.25, 0.125, -0.9375, 0.375, 0.1875}, -- NodeBox118
			{-1.25, 0.25, 0.1875, -1, 0.375, 0.25}, -- NodeBox119
			{-1.375, 0.3125, 0.25, -1.125, 0.4375, 0.3125}, -- NodeBox120
			{-1.4375, 0.3125, 0.3125, -1.1875, 0.4375, 0.375}, -- NodeBox121
			{-1.4375, 0.375, 0.375, -1.3125, 0.5, 0.4375}, -- NodeBox122
			{1.3125, 0.375, 0.375, 1.4375, 0.5, 0.4375}, -- NodeBox123
			{1.1875, 0.3125, 0.3125, 1.4375, 0.4375, 0.375}, -- NodeBox124
			{1.125, 0.3125, 0.25, 1.375, 0.4375, 0.3125}, -- NodeBox125
			{1, 0.25, 0.1875, 1.25, 0.375, 0.25}, -- NodeBox126
			{0.9375, 0.25, 0.125, 1.1875, 0.375, 0.1875}, -- NodeBox127
			{0.8125, 0.1875, 0.0625, 1.0625, 0.3125, 0.125}, -- NodeBox128
			{0.75, 0.1875, 0, 1, 0.3125, 0.0624999}, -- NodeBox129
			{0.625, 0.125, -0.0625, 0.875, 0.25, -1.2666e-007}, -- NodeBox130
			{0.5625, 0.125, -0.125, 0.8125, 0.25, -0.0625001}, -- NodeBox131
			{0.4375, 0.0625, -0.1875, 0.6875, 0.1875, -0.125}, -- NodeBox132
			{0.375, 0.0625, -0.25, 0.625, 0.1875, -0.1875}, -- NodeBox133
			{0.25, 0, -0.3125, 0.5, 0.125, -0.25}, -- NodeBox134
			{0.1875, 0, -0.375, 0.4375, 0.125, -0.3125}, -- NodeBox135
			{0.0625, -0.0625, -0.4375, 0.3125, 0.0625, -0.375}, -- NodeBox136
			{0.0625, -0.125, -0.625, 0.3125, 3.72529e-009, -0.5625}, -- NodeBox137
			{0.1875, -0.1875, -0.6875, 0.4375, -0.0625, -0.625}, -- NodeBox138
			{0.25, -0.1875, -0.75, 0.5, -0.0625, -0.6875}, -- NodeBox139
			{0.375, -0.25, -0.8125, 0.625, -0.125, -0.75}, -- NodeBox140
			{0.4375, -0.25, -0.875, 0.6875, -0.125, -0.8125}, -- NodeBox141
			{0.5625, -0.3125, -0.9375, 0.8125, -0.1875, -0.875}, -- NodeBox142
			{0.625, -0.3125, -1, 0.875, -0.1875, -0.9375}, -- NodeBox143
			{0.75, -0.375, -1.0625, 1, -0.25, -1}, -- NodeBox144
			{0.8125, -0.375, -1.125, 1.0625, -0.25, -1.0625}, -- NodeBox145
			{0.9375, -0.4375, -1.1875, 1.1875, -0.3125, -1.125}, -- NodeBox146
			{1, -0.4375, -1.25, 1.25, -0.3125, -1.1875}, -- NodeBox147
			{1.125, -0.5, -1.3125, 1.375, -0.375, -1.25}, -- NodeBox148
			{1.1875, -0.5, -1.375, 1.4375, -0.375, -1.3125}, -- NodeBox149
			{1.3125, -0.5625, -1.4375, 1.4375, -0.4375, -1.375}, -- NodeBox150
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-1.5, -0.5, -1.5, 1.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:large_upper_chord_"..bridge_colors, {
	description = bridge_desc.." Large Upper Chord",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_large_upper_chord.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_large_upper_chord.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-2.5, 0.375, 0.4375, 2.5, 0.5, 0.5}, -- NodeBox250
			{2.4375, 0.375, -1.5, 2.5, 0.5, 0.5}, -- NodeBox251
			{-2.5, 0.375, -1.5, 2.5, 0.5, -1.4375}, -- NodeBox252
			{-2.5, 0.375, -1.5, -2.4375, 0.5, 0.5}, -- NodeBox253
			{-2.4375, 0.375, 0.3125, -2.1875, 0.5, 0.4375}, -- NodeBox343
			{-2.3125, 0.375, 0.25, -2, 0.5, 0.375}, -- NodeBox344
			{-2.125, 0.375, 0.1875, -1.875, 0.5, 0.3125}, -- NodeBox345
			{-2, 0.375, 0.125, -1.6875, 0.5, 0.25}, -- NodeBox346
			{-1.875, 0.375, 0.0625, -1.5, 0.5, 0.1875}, -- NodeBox347
			{-1.625, 0.375, 0, -1.375, 0.5, 0.125}, -- NodeBox348
			{-1.5, 0.375, -0.0625, -1.1875, 0.5, 0.0625}, -- NodeBox349
			{-1.3125, 0.375, -0.125, -1, 0.5, 0}, -- NodeBox350
			{-1.125, 0.375, -0.1875, -0.875, 0.5, -0.0625}, -- NodeBox351
			{-1, 0.375, -0.25, -0.6875, 0.5, -0.125}, -- NodeBox352
			{-0.8125, 0.375, -0.3125, -0.5, 0.5, -0.1875}, -- NodeBox353
			{-0.625, 0.375, -0.375, -0.375, 0.5, -0.25}, -- NodeBox354
			{-0.5, 0.375, -0.4375, -0.1875, 0.5, -0.3125}, -- NodeBox355
			{2.1875, 0.375, 0.3125, 2.4375, 0.5, 0.4375}, -- NodeBox356
			{2, 0.375, 0.25, 2.3125, 0.5, 0.375}, -- NodeBox357
			{1.875, 0.375, 0.1875, 2.125, 0.5, 0.3125}, -- NodeBox358
			{1.6875, 0.375, 0.125, 2, 0.5, 0.25}, -- NodeBox359
			{1.5, 0.375, 0.0625, 1.8125, 0.5, 0.1875}, -- NodeBox360
			{1.1875, 0.375, -0.0625, 1.5, 0.5, 0.0625}, -- NodeBox361
			{1.375, 0.375, 0, 1.625, 0.5, 0.125}, -- NodeBox362
			{1, 0.375, -0.125, 1.3125, 0.5, 0}, -- NodeBox363
			{0.875, 0.375, -0.1875, 1.125, 0.5, -0.0625}, -- NodeBox364
			{0.6875, 0.375, -0.25, 1, 0.5, -0.125}, -- NodeBox365
			{0.5, 0.375, -0.3125, 0.8125, 0.5, -0.1875}, -- NodeBox366
			{0.375, 0.375, -0.375, 0.625, 0.5, -0.25}, -- NodeBox367
			{0.1875, 0.375, -0.4375, 0.5, 0.5, -0.3125}, -- NodeBox368
			{-0.375, 0.375, -0.625, 0.3125, 0.5, -0.375}, -- NodeBox369
			{2.1875, 0.375, -1.4375, 2.4375, 0.5, -1.3125}, -- NodeBox370
			{2, 0.375, -1.375, 2.3125, 0.5, -1.25}, -- NodeBox371
			{1.875, 0.375, -1.3125, 2.125, 0.5, -1.1875}, -- NodeBox372
			{1.6875, 0.375, -1.25, 2, 0.5, -1.125}, -- NodeBox373
			{1.5, 0.375, -1.1875, 1.8125, 0.5, -1.0625}, -- NodeBox374
			{1.375, 0.375, -1.125, 1.625, 0.5, -1}, -- NodeBox375
			{1.1875, 0.375, -1.0625, 1.5, 0.5, -0.9375}, -- NodeBox376
			{1, 0.375, -1, 1.3125, 0.5, -0.875}, -- NodeBox377
			{0.875, 0.375, -0.9375, 1.125, 0.5, -0.8125}, -- NodeBox378
			{0.6875, 0.375, -0.875, 1, 0.5, -0.75}, -- NodeBox379
			{0.5, 0.375, -0.8125, 0.8125, 0.5, -0.6875}, -- NodeBox380
			{0.375, 0.375, -0.75, 0.625, 0.5, -0.625}, -- NodeBox381
			{0.1875, 0.375, -0.6875, 0.5, 0.5, -0.5625}, -- NodeBox382
			{-2.4375, 0.375, -1.4375, -2.1875, 0.5, -1.3125}, -- NodeBox383
			{-2.3125, 0.375, -1.375, -2, 0.5, -1.25}, -- NodeBox384
			{-2.125, 0.375, -1.3125, -1.875, 0.5, -1.1875}, -- NodeBox385
			{-2, 0.375, -1.25, -1.6875, 0.5, -1.125}, -- NodeBox386
			{-1.8125, 0.375, -1.1875, -1.5, 0.5, -1.0625}, -- NodeBox387
			{-1.625, 0.375, -1.125, -1.375, 0.5, -1}, -- NodeBox388
			{-1.5, 0.375, -1.0625, -1.1875, 0.5, -0.9375}, -- NodeBox389
			{-1.3125, 0.375, -1, -1, 0.5, -0.875}, -- NodeBox390
			{-1.125, 0.375, -0.9375, -0.875, 0.5, -0.8125}, -- NodeBox391
			{-1, 0.375, -0.875, -0.6875, 0.5, -0.75}, -- NodeBox392
			{-0.8125, 0.375, -0.8125, -0.5, 0.5, -0.6875}, -- NodeBox393
			{-0.625, 0.375, -0.75, -0.375, 0.5, -0.625}, -- NodeBox394
			{-0.5, 0.375, -0.6875, -0.1875, 0.5, -0.5625}, -- NodeBox395
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-2.5, 0, -1.5, 2.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:large_upper_chord_slanted_"..bridge_colors, {
	description = bridge_desc.." Large Slanted Upper Chord",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_large_upper_chord_slanted.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_large_upper_chord_slanted.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-2.5, -0.5625, -1.5, -2.4375, -0.4375, -1.375}, -- NodeBox1
			{-2.5, -0.5625, -1.5, 2.5, -0.4375, -1.4375}, -- NodeBox2
			{2.4375, -0.5625, -1.5, 2.5, -0.4375, -1.375}, -- NodeBox3
			{2.4375, -0.5, -1.375, 2.5, -0.375, -1.25}, -- NodeBox4
			{2.4375, -0.4375, -1.25, 2.5, -0.3125, -1.125}, -- NodeBox5
			{2.4375, -0.375, -1.125, 2.5, -0.25, -1}, -- NodeBox6
			{2.4375, -0.3125, -1, 2.5, -0.1875, -0.875}, -- NodeBox7
			{2.4375, -0.25, -0.875, 2.5, -0.125, -0.75}, -- NodeBox8
			{2.4375, -0.1875, -0.75, 2.5, -0.0625, -0.625}, -- NodeBox9
			{2.4375, -0.125, -0.625, 2.5, -2.23517e-008, -0.5}, -- NodeBox10
			{2.4375, -0.0625, -0.5, 2.5, 0.0625, -0.375}, -- NodeBox11
			{2.4375, 0, -0.375, 2.5, 0.125, -0.25}, -- NodeBox12
			{2.4375, 0.0625, -0.25, 2.5, 0.1875, -0.125}, -- NodeBox13
			{2.4375, 0.125, -0.125, 2.5, 0.25, -9.68575e-008}, -- NodeBox14
			{2.4375, 0.1875, 0, 2.5, 0.3125, 0.125}, -- NodeBox15
			{2.4375, 0.25, 0.125, 2.5, 0.375, 0.25}, -- NodeBox16
			{2.4375, 0.3125, 0.25, 2.5, 0.4375, 0.375}, -- NodeBox17
			{2.4375, 0.375, 0.375, 2.5, 0.5, 0.5}, -- NodeBox18
			{-2.5, 0.375, 0.4375, 2.5, 0.5, 0.5}, -- NodeBox19
			{-2.5, -0.5, -1.375, -2.4375, -0.375, -1.25}, -- NodeBox20
			{-2.5, -0.4375, -1.25, -2.4375, -0.3125, -1.125}, -- NodeBox21
			{-2.5, -0.375, -1.125, -2.4375, -0.25, -1}, -- NodeBox22
			{-2.5, -0.3125, -1, -2.4375, -0.1875, -0.875}, -- NodeBox23
			{-2.5, -0.25, -0.875, -2.4375, -0.125, -0.75}, -- NodeBox24
			{-2.5, -0.1875, -0.75, -2.4375, -0.0625, -0.625}, -- NodeBox25
			{-2.5, -0.125, -0.625, -2.4375, 1.11759e-008, -0.5}, -- NodeBox26
			{-2.5, -0.0625, -0.5, -2.4375, 0.0625, -0.375}, -- NodeBox27
			{-2.5, 0, -0.375, -2.4375, 0.125, -0.25}, -- NodeBox28
			{-2.5, 0.0625, -0.25, -2.4375, 0.1875, -0.125}, -- NodeBox29
			{-2.5, 0.125, -0.125, -2.4375, 0.25, 1.67638e-007}, -- NodeBox30
			{-2.5, 0.1875, 0, -2.4375, 0.3125, 0.125}, -- NodeBox31
			{-2.5, 0.25, 0.125, -2.4375, 0.375, 0.25}, -- NodeBox32
			{-2.5, 0.3125, 0.25, -2.4375, 0.4375, 0.375}, -- NodeBox33
			{-2.5, 0.375, 0.375, -2.4375, 0.5, 0.5}, -- NodeBox34
			{-2.4375, -0.5625, -1.4375, -2.1875, -0.4375, -1.375}, -- NodeBox164
			{-2.4375, -0.5625, -1.375, -2, -0.4375, -1.3125}, -- NodeBox165
			{-2.3125, -0.5625, -1.3125, -1.875, -0.4375, -1.25}, -- NodeBox166
			{-2.125, -0.4375, -1.25, -1.6875, -0.3125, -1.1875}, -- NodeBox167
			{-2, -0.4375, -1.1875, -1.5625, -0.3125, -1.125}, -- NodeBox168
			{-1.8125, -0.375, -1.125, -1.375, -0.25, -1.0625}, -- NodeBox169
			{-1.6875, -0.375, -1.0625, -1.25, -0.25, -1}, -- NodeBox170
			{-1.5, -0.3125, -1, -1.0625, -0.1875, -0.9375}, -- NodeBox171
			{-1.375, -0.3125, -0.9375, -0.937501, -0.1875, -0.875}, -- NodeBox172
			{-1.1875, -0.25, -0.875, -0.750001, -0.125, -0.8125}, -- NodeBox173
			{-1.0625, -0.25, -0.8125, -0.625001, -0.125, -0.75}, -- NodeBox174
			{-0.875, -0.1875, -0.75, -0.437501, -0.0624999, -0.6875}, -- NodeBox175
			{-0.75, -0.1875, -0.6875, -0.312501, -0.0624999, -0.625}, -- NodeBox176
			{-0.5625, -0.125, -0.625, -0.125001, 1.60187e-007, -0.5625}, -- NodeBox177
			{-0.4375, -0.125, -0.5625, 0.4375, 1.56462e-007, -0.5}, -- NodeBox178
			{-0.4375, -0.0625, -0.5, 0.4375, 0.0625001, -0.4375}, -- NodeBox179
			{-0.5625, -0.0625, -0.4375, -0.125, 0.0625001, -0.375}, -- NodeBox180
			{-0.75, 0, -0.375, -0.3125, 0.125, -0.3125}, -- NodeBox181
			{-0.875, 0, -0.3125, -0.4375, 0.125, -0.25}, -- NodeBox182
			{-1.0625, 0.0625, -0.25, -0.625, 0.1875, -0.1875}, -- NodeBox183
			{-1.1875, 0.0625, -0.1875, -0.75, 0.1875, -0.125}, -- NodeBox184
			{-1.375, 0.125, -0.125, -0.9375, 0.25, -0.0625001}, -- NodeBox185
			{-1.5, 0.125, -0.0625, -1.0625, 0.25, -7.07805e-008}, -- NodeBox186
			{-1.6875, 0.1875, 0, -1.25, 0.3125, 0.0624999}, -- NodeBox187
			{-1.8125, 0.1875, 0.0625, -1.375, 0.3125, 0.125}, -- NodeBox188
			{-2, 0.25, 0.125, -1.5625, 0.375, 0.1875}, -- NodeBox189
			{-2.125, 0.25, 0.1875, -1.6875, 0.375, 0.25}, -- NodeBox190
			{-2.3125, 0.3125, 0.25, -1.875, 0.4375, 0.3125}, -- NodeBox191
			{-2.4375, 0.3125, 0.3125, -2, 0.4375, 0.375}, -- NodeBox192
			{-2.4375, 0.375, 0.375, -2.1875, 0.5, 0.4375}, -- NodeBox193
			{2.1875, 0.375, 0.375, 2.4375, 0.5, 0.4375}, -- NodeBox194
			{2, 0.3125, 0.3125, 2.4375, 0.4375, 0.375}, -- NodeBox195
			{1.875, 0.3125, 0.25, 2.3125, 0.4375, 0.3125}, -- NodeBox196
			{1.6875, 0.25, 0.1875, 2.125, 0.375, 0.25}, -- NodeBox197
			{1.5625, 0.25, 0.125, 2, 0.375, 0.1875}, -- NodeBox198
			{1.375, 0.1875, 0.0625, 1.8125, 0.3125, 0.125}, -- NodeBox199
			{1.25, 0.1875, 0, 1.6875, 0.3125, 0.0624999}, -- NodeBox200
			{1.0625, 0.125, -0.0625, 1.5, 0.25, -6.70552e-008}, -- NodeBox201
			{0.9375, 0.125, -0.125, 1.375, 0.25, -0.0625001}, -- NodeBox202
			{0.75, 0.0625, -0.1875, 1.1875, 0.1875, -0.125}, -- NodeBox203
			{0.625, 0.0625, -0.25, 1.0625, 0.1875, -0.1875}, -- NodeBox204
			{0.4375, 0, -0.3125, 0.875, 0.125, -0.25}, -- NodeBox205
			{0.3125, 0, -0.375, 0.75, 0.125, -0.3125}, -- NodeBox206
			{0.125, 0, -0.4375, 0.5625, 0.125, -0.375}, -- NodeBox207
			{0.125, -0.125, -0.625, 0.5625, 1.22935e-007, -0.5625}, -- NodeBox208
			{0.3125, -0.1875, -0.6875, 0.75, -0.0624999, -0.625}, -- NodeBox209
			{0.4375, -0.1875, -0.75, 0.875, -0.0624999, -0.6875}, -- NodeBox210
			{0.625, -0.25, -0.8125, 1.0625, -0.125, -0.75}, -- NodeBox211
			{0.75, -0.25, -0.875, 1.1875, -0.125, -0.8125}, -- NodeBox212
			{0.9375, -0.3125, -0.9375, 1.375, -0.1875, -0.875}, -- NodeBox213
			{1.0625, -0.3125, -1, 1.5, -0.1875, -0.9375}, -- NodeBox214
			{1.25, -0.375, -1.0625, 1.6875, -0.25, -1}, -- NodeBox215
			{1.375, -0.375, -1.125, 1.8125, -0.25, -1.0625}, -- NodeBox216
			{1.5625, -0.4375, -1.1875, 2, -0.3125, -1.125}, -- NodeBox217
			{1.6875, -0.4375, -1.25, 2.125, -0.3125, -1.1875}, -- NodeBox218
			{1.875, -0.5, -1.3125, 2.3125, -0.375, -1.25}, -- NodeBox219
			{2, -0.5, -1.375, 2.4375, -0.375, -1.3125}, -- NodeBox220
			{2.1875, -0.5625, -1.4375, 2.4375, -0.4375, -1.375}, -- NodeBox221
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-2.5, -0.5, -1.5, 2.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:small_support_"..bridge_colors, {
	description = bridge_desc.." Small Support",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_small_support.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_small_support.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, -0.5, 0.5, 0.5, -0.375}, -- NodeBox1
			{-0.5, -0.5, -0.5, -0.375, 0.5, -0.375}, -- NodeBox2
			{-0.4375, -0.4375, -0.5, -0.3125, -0.3125, -0.375}, -- NodeBox3
			{-0.375, -0.375, -0.5, -0.25, -0.25, -0.375}, -- NodeBox4
			{-0.3125, -0.3125, -0.5, -0.1875, -0.1875, -0.375}, -- NodeBox5
			{-0.25, -0.25, -0.5, -0.125, -0.125, -0.375}, -- NodeBox6
			{-0.1875, -0.1875, -0.5, -0.0625, -0.0625, -0.375}, -- NodeBox7
			{-0.125, -0.125, -0.5, 0.125, 0.125, -0.375}, -- NodeBox8
			{0.0625, 0.0625, -0.5, 0.1875, 0.1875, -0.375}, -- NodeBox9
			{0.125, 0.125, -0.5, 0.25, 0.25, -0.375}, -- NodeBox10
			{0.1875, 0.1875, -0.5, 0.3125, 0.3125, -0.375}, -- NodeBox11
			{0.25, 0.25, -0.5, 0.375, 0.375, -0.375}, -- NodeBox12
			{0.3125, 0.3125, -0.5, 0.4375, 0.4375, -0.375}, -- NodeBox13
			{-0.4375, 0.3125, -0.5, -0.3125, 0.4375, -0.375}, -- NodeBox14
			{-0.375, 0.25, -0.5, -0.25, 0.375, -0.375}, -- NodeBox15
			{-0.3125, 0.1875, -0.5, -0.1875, 0.3125, -0.375}, -- NodeBox16
			{-0.25, 0.125, -0.5, -0.125, 0.25, -0.375}, -- NodeBox17
			{-0.1875, 0.0625, -0.5, -0.0625, 0.1875, -0.375}, -- NodeBox18
			{0.0625, -0.1875, -0.5, 0.1875, -0.0625, -0.375}, -- NodeBox19
			{0.125, -0.25, -0.5, 0.25, -0.125, -0.375}, -- NodeBox20
			{0.1875, -0.3125, -0.5, 0.3125, -0.1875, -0.375}, -- NodeBox21
			{0.25, -0.375, -0.5, 0.375, -0.25, -0.375}, -- NodeBox22
			{0.3125, -0.4375, -0.5, 0.4375, -0.3125, -0.375}, -- NodeBox23
			{-0.5, -0.4375, 0.3125, -0.375, -0.3125, 0.4375}, -- NodeBox3
			{-0.5, -0.375, 0.25, -0.375, -0.25, 0.375}, -- NodeBox4
			{-0.5, -0.3125, 0.1875, -0.375, -0.1875, 0.3125}, -- NodeBox5
			{-0.5, -0.25, 0.125, -0.375, -0.125, 0.25}, -- NodeBox6
			{-0.5, -0.1875, 0.0625, -0.375, -0.0625, 0.1875}, -- NodeBox7
			{-0.5, -0.125, -0.125, -0.375, 0.125, 0.125}, -- NodeBox8
			{-0.5, 0.0625, -0.1875, -0.375, 0.1875, -0.0625}, -- NodeBox9
			{-0.5, 0.125, -0.25, -0.375, 0.25, -0.125}, -- NodeBox10
			{-0.5, 0.1875, -0.3125, -0.375, 0.3125, -0.1875}, -- NodeBox11
			{-0.5, 0.25, -0.375, -0.375, 0.375, -0.25}, -- NodeBox12
			{-0.5, 0.3125, -0.4375, -0.375, 0.4375, -0.3125}, -- NodeBox13
			{-0.5, 0.3125, 0.3125, -0.375, 0.4375, 0.4375}, -- NodeBox14
			{-0.5, 0.25, 0.25, -0.375, 0.375, 0.375}, -- NodeBox15
			{-0.5, 0.1875, 0.1875, -0.375, 0.3125, 0.3125}, -- NodeBox16
			{-0.5, 0.125, 0.125, -0.375, 0.25, 0.25}, -- NodeBox17
			{-0.5, 0.0625, 0.0625, -0.375, 0.1875, 0.1875}, -- NodeBox18
			{-0.5, -0.1875, -0.1875, -0.375, -0.0625, -0.0625}, -- NodeBox19
			{-0.5, -0.25, -0.25, -0.375, -0.125, -0.125}, -- NodeBox20
			{-0.5, -0.3125, -0.3125, -0.375, -0.1875, -0.1875}, -- NodeBox21
			{-0.5, -0.375, -0.375, -0.375, -0.25, -0.25}, -- NodeBox22
			{-0.5, -0.4375, -0.4375, -0.375, -0.3125, -0.3125}, -- NodeBox23
			{0.3125, -0.4375, 0.375, 0.4375, -0.3125, 0.5}, -- NodeBox3
			{0.25, -0.375, 0.375, 0.375, -0.25, 0.5}, -- NodeBox4
			{0.1875, -0.3125, 0.375, 0.3125, -0.1875, 0.5}, -- NodeBox5
			{0.125, -0.25, 0.375, 0.25, -0.125, 0.5}, -- NodeBox6
			{0.0625, -0.1875, 0.375, 0.1875, -0.0625, 0.5}, -- NodeBox7
			{-0.125, -0.125, 0.375, 0.125, 0.125, 0.5}, -- NodeBox8
			{-0.1875, 0.0625, 0.375, -0.0625, 0.1875, 0.5}, -- NodeBox9
			{-0.25, 0.125, 0.375, -0.125, 0.25, 0.5}, -- NodeBox10
			{-0.3125, 0.1875, 0.375, -0.1875, 0.3125, 0.5}, -- NodeBox11
			{-0.375, 0.25, 0.375, -0.25, 0.375, 0.5}, -- NodeBox12
			{-0.4375, 0.3125, 0.375, -0.3125, 0.4375, 0.5}, -- NodeBox13
			{0.3125, 0.3125, 0.375, 0.4375, 0.4375, 0.5}, -- NodeBox14
			{0.25, 0.25, 0.375, 0.375, 0.375, 0.5}, -- NodeBox15
			{0.1875, 0.1875, 0.375, 0.3125, 0.3125, 0.5}, -- NodeBox16
			{0.125, 0.125, 0.375, 0.25, 0.25, 0.5}, -- NodeBox17
			{0.0625, 0.0625, 0.375, 0.1875, 0.1875, 0.5}, -- NodeBox18
			{-0.1875, -0.1875, 0.375, -0.0625, -0.0625, 0.5}, -- NodeBox19
			{-0.25, -0.25, 0.375, -0.125, -0.125, 0.5}, -- NodeBox20
			{-0.3125, -0.3125, 0.375, -0.1875, -0.1875, 0.5}, -- NodeBox21
			{-0.375, -0.375, 0.375, -0.25, -0.25, 0.5}, -- NodeBox22
			{-0.4375, -0.4375, 0.375, -0.3125, -0.3125, 0.5}, -- NodeBox23
			{0.375, -0.4375, -0.4375, 0.5, -0.3125, -0.3125}, -- NodeBox3
			{0.375, -0.375, -0.375, 0.5, -0.25, -0.25}, -- NodeBox4
			{0.375, -0.3125, -0.3125, 0.5, -0.1875, -0.1875}, -- NodeBox5
			{0.375, -0.25, -0.25, 0.5, -0.125, -0.125}, -- NodeBox6
			{0.375, -0.1875, -0.1875, 0.5, -0.0625, -0.0625}, -- NodeBox7
			{0.375, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox8
			{0.375, 0.0625, 0.0625, 0.5, 0.1875, 0.1875}, -- NodeBox9
			{0.375, 0.125, 0.125, 0.5, 0.25, 0.25}, -- NodeBox10
			{0.375, 0.1875, 0.1875, 0.5, 0.3125, 0.3125}, -- NodeBox11
			{0.375, 0.25, 0.25, 0.5, 0.375, 0.375}, -- NodeBox12
			{0.375, 0.3125, 0.3125, 0.5, 0.4375, 0.4375}, -- NodeBox13
			{0.375, 0.3125, -0.4375, 0.5, 0.4375, -0.3125}, -- NodeBox14
			{0.375, 0.25, -0.375, 0.5, 0.375, -0.25}, -- NodeBox15
			{0.375, 0.1875, -0.3125, 0.5, 0.3125, -0.1875}, -- NodeBox16
			{0.375, 0.125, -0.25, 0.5, 0.25, -0.125}, -- NodeBox17
			{0.375, 0.0625, -0.1875, 0.5, 0.1875, -0.0625}, -- NodeBox18
			{0.375, -0.1875, 0.0625, 0.5, -0.0625, 0.1875}, -- NodeBox19
			{0.375, -0.25, 0.125, 0.5, -0.125, 0.25}, -- NodeBox20
			{0.375, -0.3125, 0.1875, 0.5, -0.1875, 0.3125}, -- NodeBox21
			{0.375, -0.375, 0.25, 0.5, -0.25, 0.375}, -- NodeBox22
			{0.375, -0.4375, 0.3125, 0.5, -0.3125, 0.4375}, -- NodeBox23
			{-0.5, -0.5, 0.375, -0.375, 0.5, 0.5}, -- NodeBox1
			{0.375, -0.5, 0.375, 0.5, 0.5, 0.5}, -- NodeBox2
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:small_support_top_"..bridge_colors, {
	description = bridge_desc.." Small Support Top",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_small_support_top.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_small_support_top.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.375, -0.5, -0.5, 0.5, 1.5, -0.375}, -- NodeBox1
			{-0.5, -0.5, -0.5, -0.375, 1.5, -0.375}, -- NodeBox2
			{0.3125, -0.4375, -0.5, 0.4375, -0.3125, -0.375}, -- NodeBox3
			{0.25, -0.375, -0.5, 0.375, -0.25, -0.375}, -- NodeBox4
			{0.1875, -0.3125, -0.5, 0.3125, -0.1875, -0.375}, -- NodeBox5
			{0.125, -0.25, -0.5, 0.25, -0.125, -0.375}, -- NodeBox6
			{0.0625, -0.1875, -0.5, 0.1875, -0.0625, -0.375}, -- NodeBox7
			{-0.125, -0.125, -0.5, 0.125, 0.125, -0.375}, -- NodeBox8
			{-0.1875, -0.1875, -0.5, -0.0625, -0.0625, -0.375}, -- NodeBox9
			{-0.25, -0.25, -0.5, -0.125, -0.125, -0.375}, -- NodeBox10
			{-0.3125, -0.3125, -0.5, -0.1875, -0.1875, -0.375}, -- NodeBox11
			{-0.375, -0.375, -0.5, -0.25, -0.25, -0.375}, -- NodeBox12
			{-0.4375, -0.4375, -0.5, -0.3125, -0.3125, -0.375}, -- NodeBox13
			{0.0625, 0.0625, -0.5, 0.1875, 0.1875, -0.375}, -- NodeBox14
			{0.125, 0.125, -0.5, 0.25, 0.25, -0.375}, -- NodeBox15
			{0.1875, 0.1875, -0.5, 0.3125, 0.3125, -0.375}, -- NodeBox16
			{0.25, 0.25, -0.5, 0.375, 0.375, -0.375}, -- NodeBox17
			{0.3125, 0.3125, -0.5, 0.4375, 0.4375, -0.375}, -- NodeBox18
			{-0.1875, 0.0625, -0.5, -0.0625, 0.1875, -0.375}, -- NodeBox19
			{-0.25, 0.125, -0.5, -0.125, 0.25, -0.375}, -- NodeBox20
			{-0.3125, 0.1875, -0.5, -0.1875, 0.3125, -0.375}, -- NodeBox21
			{-0.375, 0.25, -0.5, -0.25, 0.375, -0.375}, -- NodeBox22
			{-0.4375, 0.3125, -0.5, -0.3125, 0.4375, -0.375}, -- NodeBox23
			{-0.4375, 0.5625, -0.5, -0.3125, 0.6875, -0.375}, -- NodeBox24
			{-0.375, 0.625, -0.5, -0.25, 0.75, -0.375}, -- NodeBox25
			{-0.3125, 0.6875, -0.5, -0.1875, 0.8125, -0.375}, -- NodeBox26
			{-0.25, 0.75, -0.5, -0.125, 0.875, -0.375}, -- NodeBox27
			{-0.1875, 0.8125, -0.5, -0.0625001, 0.9375, -0.375}, -- NodeBox28
			{0.3125, 0.5625, -0.5, 0.4375, 0.6875, -0.375}, -- NodeBox29
			{0.25, 0.625, -0.5, 0.375, 0.75, -0.375}, -- NodeBox30
			{0.1875, 0.6875, -0.5, 0.3125, 0.8125, -0.375}, -- NodeBox31
			{0.125, 0.75, -0.5, 0.25, 0.875, -0.375}, -- NodeBox32
			{0.0625, 0.8125, -0.5, 0.1875, 0.9375, -0.375}, -- NodeBox33
			{-0.125, 0.875, -0.5, 0.125, 1.125, -0.375}, -- NodeBox34
			{0.0625, 1.0625, -0.5, 0.1875, 1.1875, -0.375}, -- NodeBox35
			{0.125, 1.125, -0.5, 0.25, 1.25, -0.375}, -- NodeBox36
			{0.1875, 1.1875, -0.5, 0.3125, 1.3125, -0.375}, -- NodeBox37
			{0.25, 1.25, -0.5, 0.375, 1.375, -0.375}, -- NodeBox38
			{0.3125, 1.3125, -0.5, 0.4375, 1.4375, -0.375}, -- NodeBox39
			{-0.1875, 1.0625, -0.5, -0.0625, 1.1875, -0.375}, -- NodeBox40
			{-0.25, 1.125, -0.5, -0.125, 1.25, -0.375}, -- NodeBox41
			{-0.3125, 1.1875, -0.5, -0.1875, 1.3125, -0.375}, -- NodeBox42
			{-0.375, 1.25, -0.5, -0.25, 1.375, -0.375}, -- NodeBox43
			{-0.4375, 1.3125, -0.5, -0.3125, 1.4375, -0.375}, -- NodeBox44
			{-0.5, -0.5, 0.375, -0.375, 1.5, 0.5}, -- NodeBox1
			{0.375, -0.5, 0.375, 0.5, 1.5, 0.5}, -- NodeBox2
			{-0.4375, -0.4375, 0.375, -0.3125, -0.3125, 0.5}, -- NodeBox3
			{-0.375, -0.375, 0.375, -0.25, -0.25, 0.5}, -- NodeBox4
			{-0.3125, -0.3125, 0.375, -0.1875, -0.1875, 0.5}, -- NodeBox5
			{-0.25, -0.25, 0.375, -0.125, -0.125, 0.5}, -- NodeBox6
			{-0.1875, -0.1875, 0.375, -0.0625, -0.0625, 0.5}, -- NodeBox7
			{-0.125, -0.125, 0.375, 0.125, 0.125, 0.5}, -- NodeBox8
			{0.0625, -0.1875, 0.375, 0.1875, -0.0625, 0.5}, -- NodeBox9
			{0.125, -0.25, 0.375, 0.25, -0.125, 0.5}, -- NodeBox10
			{0.1875, -0.3125, 0.375, 0.3125, -0.1875, 0.5}, -- NodeBox11
			{0.25, -0.375, 0.375, 0.375, -0.25, 0.5}, -- NodeBox12
			{0.3125, -0.4375, 0.375, 0.4375, -0.3125, 0.5}, -- NodeBox13
			{-0.1875, 0.0625, 0.375, -0.0625, 0.1875, 0.5}, -- NodeBox14
			{-0.25, 0.125, 0.375, -0.125, 0.25, 0.5}, -- NodeBox15
			{-0.3125, 0.1875, 0.375, -0.1875, 0.3125, 0.5}, -- NodeBox16
			{-0.375, 0.25, 0.375, -0.25, 0.375, 0.5}, -- NodeBox17
			{-0.4375, 0.3125, 0.375, -0.3125, 0.4375, 0.5}, -- NodeBox18
			{0.0625, 0.0625, 0.375, 0.1875, 0.1875, 0.5}, -- NodeBox19
			{0.125, 0.125, 0.375, 0.25, 0.25, 0.5}, -- NodeBox20
			{0.1875, 0.1875, 0.375, 0.3125, 0.3125, 0.5}, -- NodeBox21
			{0.25, 0.25, 0.375, 0.375, 0.375, 0.5}, -- NodeBox22
			{0.3125, 0.3125, 0.375, 0.4375, 0.4375, 0.5}, -- NodeBox23
			{0.3125, 0.5625, 0.375, 0.4375, 0.6875, 0.5}, -- NodeBox24
			{0.25, 0.625, 0.375, 0.375, 0.75, 0.5}, -- NodeBox25
			{0.1875, 0.6875, 0.375, 0.3125, 0.8125, 0.5}, -- NodeBox26
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox27
			{0.0625001, 0.8125, 0.375, 0.1875, 0.9375, 0.5}, -- NodeBox28
			{-0.4375, 0.5625, 0.375, -0.3125, 0.6875, 0.5}, -- NodeBox29
			{-0.375, 0.625, 0.375, -0.25, 0.75, 0.5}, -- NodeBox30
			{-0.3125, 0.6875, 0.375, -0.1875, 0.8125, 0.5}, -- NodeBox31
			{-0.25, 0.75, 0.375, -0.125, 0.875, 0.5}, -- NodeBox32
			{-0.1875, 0.8125, 0.375, -0.0625, 0.9375, 0.5}, -- NodeBox33
			{-0.125, 0.875, 0.375, 0.125, 1.125, 0.5}, -- NodeBox34
			{-0.1875, 1.0625, 0.375, -0.0625, 1.1875, 0.5}, -- NodeBox35
			{-0.25, 1.125, 0.375, -0.125, 1.25, 0.5}, -- NodeBox36
			{-0.3125, 1.1875, 0.375, -0.1875, 1.3125, 0.5}, -- NodeBox37
			{-0.375, 1.25, 0.375, -0.25, 1.375, 0.5}, -- NodeBox38
			{-0.4375, 1.3125, 0.375, -0.3125, 1.4375, 0.5}, -- NodeBox39
			{0.0625, 1.0625, 0.375, 0.1875, 1.1875, 0.5}, -- NodeBox40
			{0.125, 1.125, 0.375, 0.25, 1.25, 0.5}, -- NodeBox41
			{0.1875, 1.1875, 0.375, 0.3125, 1.3125, 0.5}, -- NodeBox42
			{0.25, 1.25, 0.375, 0.375, 1.375, 0.5}, -- NodeBox43
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox44
			{0.375, -0.4375, 0.3125, 0.5, -0.3125, 0.4375}, -- NodeBox3
			{0.375, -0.375, 0.25, 0.5, -0.25, 0.375}, -- NodeBox4
			{0.375, -0.3125, 0.1875, 0.5, -0.1875, 0.3125}, -- NodeBox5
			{0.375, -0.25, 0.125, 0.5, -0.125, 0.25}, -- NodeBox6
			{0.375, -0.1875, 0.0625, 0.5, -0.0625, 0.1875}, -- NodeBox7
			{0.375, -0.125, -0.125, 0.5, 0.125, 0.125}, -- NodeBox8
			{0.375, -0.1875, -0.1875, 0.5, -0.0625, -0.0625}, -- NodeBox9
			{0.375, -0.25, -0.25, 0.5, -0.125, -0.125}, -- NodeBox10
			{0.375, -0.3125, -0.3125, 0.5, -0.1875, -0.1875}, -- NodeBox11
			{0.375, -0.375, -0.375, 0.5, -0.25, -0.25}, -- NodeBox12
			{0.375, -0.4375, -0.4375, 0.5, -0.3125, -0.3125}, -- NodeBox13
			{0.375, 0.0625, 0.0625, 0.5, 0.1875, 0.1875}, -- NodeBox14
			{0.375, 0.125, 0.125, 0.5, 0.25, 0.25}, -- NodeBox15
			{0.375, 0.1875, 0.1875, 0.5, 0.3125, 0.3125}, -- NodeBox16
			{0.375, 0.25, 0.25, 0.5, 0.375, 0.375}, -- NodeBox17
			{0.375, 0.3125, 0.3125, 0.5, 0.4375, 0.4375}, -- NodeBox18
			{0.375, 0.0625, -0.1875, 0.5, 0.1875, -0.0625}, -- NodeBox19
			{0.375, 0.125, -0.25, 0.5, 0.25, -0.125}, -- NodeBox20
			{0.375, 0.1875, -0.3125, 0.5, 0.3125, -0.1875}, -- NodeBox21
			{0.375, 0.25, -0.375, 0.5, 0.375, -0.25}, -- NodeBox22
			{0.375, 0.3125, -0.4375, 0.5, 0.4375, -0.3125}, -- NodeBox23
			{0.375, 0.5625, -0.4375, 0.5, 0.6875, -0.3125}, -- NodeBox24
			{0.375, 0.625, -0.375, 0.5, 0.75, -0.25}, -- NodeBox25
			{0.375, 0.6875, -0.3125, 0.5, 0.8125, -0.1875}, -- NodeBox26
			{0.375, 0.75, -0.25, 0.5, 0.875, -0.125}, -- NodeBox27
			{0.375, 0.8125, -0.1875, 0.5, 0.9375, -0.0625001}, -- NodeBox28
			{0.375, 0.5625, 0.3125, 0.5, 0.6875, 0.4375}, -- NodeBox29
			{0.375, 0.625, 0.25, 0.5, 0.75, 0.375}, -- NodeBox30
			{0.375, 0.6875, 0.1875, 0.5, 0.8125, 0.3125}, -- NodeBox31
			{0.375, 0.75, 0.125, 0.5, 0.875, 0.25}, -- NodeBox32
			{0.375, 0.8125, 0.0625, 0.5, 0.9375, 0.1875}, -- NodeBox33
			{0.375, 0.875, -0.125, 0.5, 1.125, 0.125}, -- NodeBox34
			{0.375, 1.0625, 0.0625, 0.5, 1.1875, 0.1875}, -- NodeBox35
			{0.375, 1.125, 0.125, 0.5, 1.25, 0.25}, -- NodeBox36
			{0.375, 1.1875, 0.1875, 0.5, 1.3125, 0.3125}, -- NodeBox37
			{0.375, 1.25, 0.25, 0.5, 1.375, 0.375}, -- NodeBox38
			{0.375, 1.3125, 0.3125, 0.5, 1.4375, 0.4375}, -- NodeBox39
			{0.375, 1.0625, -0.1875, 0.5, 1.1875, -0.0625}, -- NodeBox40
			{0.375, 1.125, -0.25, 0.5, 1.25, -0.125}, -- NodeBox41
			{0.375, 1.1875, -0.3125, 0.5, 1.3125, -0.1875}, -- NodeBox42
			{0.375, 1.25, -0.375, 0.5, 1.375, -0.25}, -- NodeBox43
			{0.375, 1.3125, -0.4375, 0.5, 1.4375, -0.3125}, -- NodeBox44
			{-0.5, -0.4375, -0.4375, -0.375, -0.3125, -0.3125}, -- NodeBox3
			{-0.5, -0.375, -0.375, -0.375, -0.25, -0.25}, -- NodeBox4
			{-0.5, -0.3125, -0.3125, -0.375, -0.1875, -0.1875}, -- NodeBox5
			{-0.5, -0.25, -0.25, -0.375, -0.125, -0.125}, -- NodeBox6
			{-0.5, -0.1875, -0.1875, -0.375, -0.0625, -0.0625}, -- NodeBox7
			{-0.5, -0.125, -0.125, -0.375, 0.125, 0.125}, -- NodeBox8
			{-0.5, -0.1875, 0.0625, -0.375, -0.0625, 0.1875}, -- NodeBox9
			{-0.5, -0.25, 0.125, -0.375, -0.125, 0.25}, -- NodeBox10
			{-0.5, -0.3125, 0.1875, -0.375, -0.1875, 0.3125}, -- NodeBox11
			{-0.5, -0.375, 0.25, -0.375, -0.25, 0.375}, -- NodeBox12
			{-0.5, -0.4375, 0.3125, -0.375, -0.3125, 0.4375}, -- NodeBox13
			{-0.5, 0.0625, -0.1875, -0.375, 0.1875, -0.0625}, -- NodeBox14
			{-0.5, 0.125, -0.25, -0.375, 0.25, -0.125}, -- NodeBox15
			{-0.5, 0.1875, -0.3125, -0.375, 0.3125, -0.1875}, -- NodeBox16
			{-0.5, 0.25, -0.375, -0.375, 0.375, -0.25}, -- NodeBox17
			{-0.5, 0.3125, -0.4375, -0.375, 0.4375, -0.3125}, -- NodeBox18
			{-0.5, 0.0625, 0.0625, -0.375, 0.1875, 0.1875}, -- NodeBox19
			{-0.5, 0.125, 0.125, -0.375, 0.25, 0.25}, -- NodeBox20
			{-0.5, 0.1875, 0.1875, -0.375, 0.3125, 0.3125}, -- NodeBox21
			{-0.5, 0.25, 0.25, -0.375, 0.375, 0.375}, -- NodeBox22
			{-0.5, 0.3125, 0.3125, -0.375, 0.4375, 0.4375}, -- NodeBox23
			{-0.5, 0.5625, 0.3125, -0.375, 0.6875, 0.4375}, -- NodeBox24
			{-0.5, 0.625, 0.25, -0.375, 0.75, 0.375}, -- NodeBox25
			{-0.5, 0.6875, 0.1875, -0.375, 0.8125, 0.3125}, -- NodeBox26
			{-0.5, 0.75, 0.125, -0.375, 0.875, 0.25}, -- NodeBox27
			{-0.5, 0.8125, 0.0625001, -0.375, 0.9375, 0.1875}, -- NodeBox28
			{-0.5, 0.5625, -0.4375, -0.375, 0.6875, -0.3125}, -- NodeBox29
			{-0.5, 0.625, -0.375, -0.375, 0.75, -0.25}, -- NodeBox30
			{-0.5, 0.6875, -0.3125, -0.375, 0.8125, -0.1875}, -- NodeBox31
			{-0.5, 0.75, -0.25, -0.375, 0.875, -0.125}, -- NodeBox32
			{-0.5, 0.8125, -0.1875, -0.375, 0.9375, -0.0625}, -- NodeBox33
			{-0.5, 0.875, -0.125, -0.375, 1.125, 0.125}, -- NodeBox34
			{-0.5, 1.0625, -0.1875, -0.375, 1.1875, -0.0625}, -- NodeBox35
			{-0.5, 1.125, -0.25, -0.375, 1.25, -0.125}, -- NodeBox36
			{-0.5, 1.1875, -0.3125, -0.375, 1.3125, -0.1875}, -- NodeBox37
			{-0.5, 1.25, -0.375, -0.375, 1.375, -0.25}, -- NodeBox38
			{-0.5, 1.3125, -0.4375, -0.375, 1.4375, -0.3125}, -- NodeBox39
			{-0.5, 1.0625, 0.0625, -0.375, 1.1875, 0.1875}, -- NodeBox40
			{-0.5, 1.125, 0.125, -0.375, 1.25, 0.25}, -- NodeBox41
			{-0.5, 1.1875, 0.1875, -0.375, 1.3125, 0.3125}, -- NodeBox42
			{-0.5, 1.25, 0.25, -0.375, 1.375, 0.375}, -- NodeBox43
			{-0.5, 1.3125, 0.3125, -0.375, 1.4375, 0.4375}, -- NodeBox44
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 1.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:medium_support_"..bridge_colors, {
	description = bridge_desc.." Medium Support",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_medium_support.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_medium_support.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, -0.5, 0.3125, -1.25, 2.5, 0.5625}, -- NodeBox1
			{1.25, -0.5, 0.3125, 1.5, 2.5, 0.5625}, -- NodeBox2
			{-1.4375, 2.3125, 0.375, -1.3125, 2.4375, 0.5}, -- NodeBox3
			{-1.375, 2.25, 0.375, -1.25, 2.375, 0.5}, -- NodeBox4
			{-1.3125, 2.1875, 0.375, -1.1875, 2.3125, 0.5}, -- NodeBox5
			{-1.25, 2.125, 0.375, -1.125, 2.25, 0.5}, -- NodeBox6
			{-1.1875, 2.0625, 0.375, -1.0625, 2.1875, 0.5}, -- NodeBox7
			{-1.125, 2, 0.375, -1, 2.125, 0.5}, -- NodeBox8
			{-1.0625, 1.9375, 0.375, -0.9375, 2.0625, 0.5}, -- NodeBox9
			{-1, 1.875, 0.375, -0.875, 2, 0.5}, -- NodeBox10
			{-0.9375, 1.8125, 0.375, -0.8125, 1.9375, 0.5}, -- NodeBox11
			{-0.875, 1.75, 0.375, -0.75, 1.875, 0.5}, -- NodeBox12
			{-0.8125, 1.6875, 0.375, -0.6875, 1.8125, 0.5}, -- NodeBox13
			{-0.75, 1.625, 0.375, -0.625, 1.75, 0.5}, -- NodeBox14
			{-0.6875, 1.5625, 0.375, -0.5625, 1.6875, 0.5}, -- NodeBox15
			{-0.625, 1.5, 0.375, -0.5, 1.625, 0.5}, -- NodeBox16
			{-0.5625, 1.4375, 0.375, -0.4375, 1.5625, 0.5}, -- NodeBox17
			{-0.5, 1.375, 0.375, -0.375, 1.5, 0.5}, -- NodeBox18
			{-0.4375, 1.3125, 0.375, -0.3125, 1.4375, 0.5}, -- NodeBox19
			{-0.375, 1.25, 0.375, -0.25, 1.375, 0.5}, -- NodeBox20
			{-0.3125, 1.1875, 0.375, -0.1875, 1.3125, 0.5}, -- NodeBox21
			{-0.25, 1.125, 0.375, -0.125, 1.25, 0.5}, -- NodeBox22
			{-0.1875, 1.0625, 0.375, -0.0625, 1.1875, 0.5}, -- NodeBox23
			{-0.125, 0.875, 0.375, 0.125, 1.125, 0.5}, -- NodeBox24
			{0.0625, 0.8125, 0.375, 0.1875, 0.9375, 0.5}, -- NodeBox25
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox26
			{0.1875, 0.6875, 0.375, 0.3125, 0.8125, 0.5}, -- NodeBox27
			{0.25, 0.625, 0.375, 0.375, 0.75, 0.5}, -- NodeBox28
			{0.3125, 0.5625, 0.375, 0.4375, 0.6875, 0.5}, -- NodeBox29
			{0.375, 0.5, 0.375, 0.5, 0.625, 0.5}, -- NodeBox30
			{0.4375, 0.4375, 0.375, 0.5625, 0.5625, 0.5}, -- NodeBox31
			{0.5, 0.375, 0.375, 0.625, 0.5, 0.5}, -- NodeBox32
			{0.5625, 0.3125, 0.375, 0.6875, 0.4375, 0.5}, -- NodeBox33
			{0.625, 0.25, 0.375, 0.75, 0.375, 0.5}, -- NodeBox34
			{0.6875, 0.1875, 0.375, 0.8125, 0.3125, 0.5}, -- NodeBox35
			{0.75, 0.125, 0.375, 0.875, 0.25, 0.5}, -- NodeBox36
			{0.8125, 0.0625, 0.375, 0.9375, 0.1875, 0.5}, -- NodeBox37
			{0.875, 0, 0.375, 1, 0.125, 0.5}, -- NodeBox38
			{0.9375, -0.0625, 0.375, 1.0625, 0.0625, 0.5}, -- NodeBox39
			{1, -0.125, 0.375, 1.125, 0, 0.5}, -- NodeBox40
			{1.0625, -0.1875, 0.375, 1.1875, -0.0625, 0.5}, -- NodeBox41
			{1.125, -0.25, 0.375, 1.25, -0.125, 0.5}, -- NodeBox42
			{1.1875, -0.3125, 0.375, 1.3125, -0.1875, 0.5}, -- NodeBox43
			{1.25, -0.375, 0.375, 1.375, -0.25, 0.5}, -- NodeBox44
			{1.3125, -0.4375, 0.375, 1.4375, -0.3125, 0.5}, -- NodeBox45
			{1.3125, 2.3125, 0.375, 1.4375, 2.4375, 0.5}, -- NodeBox3
			{1.25, 2.25, 0.375, 1.375, 2.375, 0.5}, -- NodeBox4
			{1.1875, 2.1875, 0.375, 1.3125, 2.3125, 0.5}, -- NodeBox5
			{1.125, 2.125, 0.375, 1.25, 2.25, 0.5}, -- NodeBox6
			{1.0625, 2.0625, 0.375, 1.1875, 2.1875, 0.5}, -- NodeBox7
			{1, 2, 0.375, 1.125, 2.125, 0.5}, -- NodeBox8
			{0.9375, 1.9375, 0.375, 1.0625, 2.0625, 0.5}, -- NodeBox9
			{0.875, 1.875, 0.375, 1, 2, 0.5}, -- NodeBox10
			{0.8125, 1.8125, 0.375, 0.9375, 1.9375, 0.5}, -- NodeBox11
			{0.75, 1.75, 0.375, 0.875, 1.875, 0.5}, -- NodeBox12
			{0.6875, 1.6875, 0.375, 0.8125, 1.8125, 0.5}, -- NodeBox13
			{0.625, 1.625, 0.375, 0.75, 1.75, 0.5}, -- NodeBox14
			{0.5625, 1.5625, 0.375, 0.6875, 1.6875, 0.5}, -- NodeBox15
			{0.5, 1.5, 0.375, 0.625, 1.625, 0.5}, -- NodeBox16
			{0.4375, 1.4375, 0.375, 0.5625, 1.5625, 0.5}, -- NodeBox17
			{0.375, 1.375, 0.375, 0.5, 1.5, 0.5}, -- NodeBox18
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox19
			{0.25, 1.25, 0.375, 0.375, 1.375, 0.5}, -- NodeBox20
			{0.1875, 1.1875, 0.375, 0.3125, 1.3125, 0.5}, -- NodeBox21
			{0.125, 1.125, 0.375, 0.25, 1.25, 0.5}, -- NodeBox22
			{0.0625, 1.0625, 0.375, 0.1875, 1.1875, 0.5}, -- NodeBox23
			{-0.1875, 0.8125, 0.375, -0.0625, 0.9375, 0.5}, -- NodeBox25
			{-0.25, 0.75, 0.375, -0.125, 0.875, 0.5}, -- NodeBox26
			{-0.3125, 0.6875, 0.375, -0.1875, 0.8125, 0.5}, -- NodeBox27
			{-0.375, 0.625, 0.375, -0.25, 0.75, 0.5}, -- NodeBox28
			{-0.4375, 0.5625, 0.375, -0.3125, 0.6875, 0.5}, -- NodeBox29
			{-0.5, 0.5, 0.375, -0.375, 0.625, 0.5}, -- NodeBox30
			{-0.5625, 0.4375, 0.375, -0.4375, 0.5625, 0.5}, -- NodeBox31
			{-0.625, 0.375, 0.375, -0.5, 0.5, 0.5}, -- NodeBox32
			{-0.6875, 0.3125, 0.375, -0.5625, 0.4375, 0.5}, -- NodeBox33
			{-0.75, 0.25, 0.375, -0.625, 0.375, 0.5}, -- NodeBox34
			{-0.8125, 0.1875, 0.375, -0.6875, 0.3125, 0.5}, -- NodeBox35
			{-0.875, 0.125, 0.375, -0.75, 0.25, 0.5}, -- NodeBox36
			{-0.9375, 0.0625, 0.375, -0.8125, 0.1875, 0.5}, -- NodeBox37
			{-1, 0, 0.375, -0.875, 0.125, 0.5}, -- NodeBox38
			{-1.0625, -0.0625, 0.375, -0.9375, 0.0625, 0.5}, -- NodeBox39
			{-1.125, -0.125, 0.375, -1, 0, 0.5}, -- NodeBox40
			{-1.1875, -0.1875, 0.375, -1.0625, -0.0625, 0.5}, -- NodeBox41
			{-1.25, -0.25, 0.375, -1.125, -0.125, 0.5}, -- NodeBox42
			{-1.3125, -0.3125, 0.375, -1.1875, -0.1875, 0.5}, -- NodeBox43
			{-1.375, -0.375, 0.375, -1.25, -0.25, 0.5}, -- NodeBox44
			{-1.4375, -0.4375, 0.375, -1.3125, -0.3125, 0.5}, -- NodeBox45
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-1.5, -0.5, 0, 1.5, 2.5, 0.625},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:medium_support_bot_"..bridge_colors, {
	description = bridge_desc.." Bottom Medium Support",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_medium_support_bot.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_medium_support_bot.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5625, -0.5, 0.25, -1.1875, 0.5, 0.625}, -- NodeBox1
			{1.1875, -0.5, 0.25, 1.5625, 0.5, 0.625}, -- NodeBox2
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-1.5, -0.5, 0, 1.5, 0.5, 0.625},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:large_support_"..bridge_colors, {
	description = bridge_desc.." Large Support",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_large_support.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_large_support.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-2.5, -0.5, 0.3125, -2.25, 2.5, 0.5625}, -- NodeBox1
			{2.25, -0.5, 0.3125, 2.5, 2.5, 0.5625}, -- NodeBox2
			{2.25, 2.375, 0.375, 2.375, 2.5, 0.5}, -- NodeBox48
			{2.125, 2.3125, 0.375, 2.3125, 2.4375, 0.5}, -- NodeBox49
			{2, 2.25, 0.375, 2.1875, 2.375, 0.5}, -- NodeBox50
			{1.9375, 2.1875, 0.375, 2.0625, 2.3125, 0.5}, -- NodeBox51
			{1.8125, 2.125, 0.375, 2, 2.25, 0.5}, -- NodeBox52
			{1.75, 2.0625, 0.375, 1.875, 2.1875, 0.5}, -- NodeBox53
			{1.625, 2, 0.375, 1.8125, 2.125, 0.5}, -- NodeBox54
			{1.5, 1.9375, 0.375, 1.6875, 2.0625, 0.5}, -- NodeBox55
			{1.4375, 1.875, 0.375, 1.5625, 2, 0.5}, -- NodeBox56
			{1.3125, 1.8125, 0.375, 1.5, 1.9375, 0.5}, -- NodeBox57
			{1.25, 1.75, 0.375, 1.375, 1.875, 0.5}, -- NodeBox58
			{1.125, 1.6875, 0.375, 1.3125, 1.8125, 0.5}, -- NodeBox59
			{1, 1.625, 0.375, 1.1875, 1.75, 0.5}, -- NodeBox60
			{0.9375, 1.5625, 0.375, 1.0625, 1.6875, 0.5}, -- NodeBox61
			{0.8125, 1.5, 0.375, 1, 1.625, 0.5}, -- NodeBox62
			{0.75, 1.4375, 0.375, 0.875, 1.5625, 0.5}, -- NodeBox63
			{0.625, 1.375, 0.375, 0.8125, 1.5, 0.5}, -- NodeBox64
			{0.5, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox65
			{0.4375, 1.25, 0.375, 0.5625, 1.375, 0.5}, -- NodeBox66
			{0.3125, 1.1875, 0.375, 0.5, 1.3125, 0.5}, -- NodeBox67
			{0.25, 1.125, 0.375, 0.375, 1.25, 0.5}, -- NodeBox68
			{0.125, 1.0625, 0.375, 0.3125, 1.1875, 0.5}, -- NodeBox69
			{0, 1, 0.375, 0.1875, 1.125, 0.5}, -- NodeBox70
			{-2.375, -0.5, 0.375, -2.25, -0.375, 0.5}, -- NodeBox71
			{-2.3125, -0.4375, 0.375, -2.125, -0.3125, 0.5}, -- NodeBox72
			{-2.1875, -0.375, 0.375, -2, -0.25, 0.5}, -- NodeBox73
			{-2.0625, -0.3125, 0.375, -1.9375, -0.1875, 0.5}, -- NodeBox74
			{-2, -0.25, 0.375, -1.8125, -0.125, 0.5}, -- NodeBox75
			{-1.875, -0.1875, 0.375, -1.75, -0.0625, 0.5}, -- NodeBox76
			{-1.8125, -0.125, 0.375, -1.625, 0, 0.5}, -- NodeBox77
			{-1.6875, -0.0625, 0.375, -1.5, 0.0625, 0.5}, -- NodeBox78
			{-1.5625, 0, 0.375, -1.4375, 0.125, 0.5}, -- NodeBox79
			{-1.5, 0.0625, 0.375, -1.3125, 0.1875, 0.5}, -- NodeBox80
			{-1.375, 0.125, 0.375, -1.25, 0.25, 0.5}, -- NodeBox81
			{-1.3125, 0.1875, 0.375, -1.125, 0.3125, 0.5}, -- NodeBox82
			{-1.1875, 0.25, 0.375, -1, 0.375, 0.5}, -- NodeBox83
			{-1.0625, 0.3125, 0.375, -0.9375, 0.4375, 0.5}, -- NodeBox84
			{-1, 0.375, 0.375, -0.8125, 0.5, 0.5}, -- NodeBox85
			{-0.875, 0.4375, 0.375, -0.75, 0.5625, 0.5}, -- NodeBox86
			{-0.8125, 0.5, 0.375, -0.625, 0.625, 0.5}, -- NodeBox87
			{-0.6875, 0.5625, 0.375, -0.5, 0.6875, 0.5}, -- NodeBox88
			{-0.5625, 0.625, 0.375, -0.4375, 0.75, 0.5}, -- NodeBox89
			{-0.5, 0.6875, 0.375, -0.3125, 0.8125, 0.5}, -- NodeBox90
			{-0.375, 0.75, 0.375, -0.25, 0.875, 0.5}, -- NodeBox91
			{-0.3125, 0.8125, 0.375, -0.125, 0.9375, 0.5}, -- NodeBox92
			{-0.1875, 0.875, 0.375, 0, 1, 0.5}, -- NodeBox93
			{-2.375, 2.375, 0.375, -2.25, 2.5, 0.5}, -- NodeBox48
			{-2.3125, 2.3125, 0.375, -2.125, 2.4375, 0.5}, -- NodeBox49
			{-2.1875, 2.25, 0.375, -2, 2.375, 0.5}, -- NodeBox50
			{-2.0625, 2.1875, 0.375, -1.9375, 2.3125, 0.5}, -- NodeBox51
			{-2, 2.125, 0.375, -1.8125, 2.25, 0.5}, -- NodeBox52
			{-1.875, 2.0625, 0.375, -1.75, 2.1875, 0.5}, -- NodeBox53
			{-1.8125, 2, 0.375, -1.625, 2.125, 0.5}, -- NodeBox54
			{-1.6875, 1.9375, 0.375, -1.5, 2.0625, 0.5}, -- NodeBox55
			{-1.5625, 1.875, 0.375, -1.4375, 2, 0.5}, -- NodeBox56
			{-1.5, 1.8125, 0.375, -1.3125, 1.9375, 0.5}, -- NodeBox57
			{-1.375, 1.75, 0.375, -1.25, 1.875, 0.5}, -- NodeBox58
			{-1.3125, 1.6875, 0.375, -1.125, 1.8125, 0.5}, -- NodeBox59
			{-1.1875, 1.625, 0.375, -1, 1.75, 0.5}, -- NodeBox60
			{-1.0625, 1.5625, 0.375, -0.9375, 1.6875, 0.5}, -- NodeBox61
			{-1, 1.5, 0.375, -0.8125, 1.625, 0.5}, -- NodeBox62
			{-0.875, 1.4375, 0.375, -0.75, 1.5625, 0.5}, -- NodeBox63
			{-0.8125, 1.375, 0.375, -0.625, 1.5, 0.5}, -- NodeBox64
			{-0.6875, 1.3125, 0.375, -0.5, 1.4375, 0.5}, -- NodeBox65
			{-0.5625, 1.25, 0.375, -0.4375, 1.375, 0.5}, -- NodeBox66
			{-0.5, 1.1875, 0.375, -0.3125, 1.3125, 0.5}, -- NodeBox67
			{-0.375, 1.125, 0.375, -0.25, 1.25, 0.5}, -- NodeBox68
			{-0.3125, 1.0625, 0.375, -0.125, 1.1875, 0.5}, -- NodeBox69
			{-0.1875, 1, 0.375, -0, 1.125, 0.5}, -- NodeBox70
			{2.25, -0.5, 0.375, 2.375, -0.375, 0.5}, -- NodeBox71
			{2.125, -0.4375, 0.375, 2.3125, -0.3125, 0.5}, -- NodeBox72
			{2, -0.375, 0.375, 2.1875, -0.25, 0.5}, -- NodeBox73
			{1.9375, -0.3125, 0.375, 2.0625, -0.1875, 0.5}, -- NodeBox74
			{1.8125, -0.25, 0.375, 2, -0.125, 0.5}, -- NodeBox75
			{1.75, -0.1875, 0.375, 1.875, -0.0625, 0.5}, -- NodeBox76
			{1.625, -0.125, 0.375, 1.8125, 0, 0.5}, -- NodeBox77
			{1.5, -0.0625, 0.375, 1.6875, 0.0625, 0.5}, -- NodeBox78
			{1.4375, 0, 0.375, 1.5625, 0.125, 0.5}, -- NodeBox79
			{1.3125, 0.0625, 0.375, 1.5, 0.1875, 0.5}, -- NodeBox80
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox81
			{1.125, 0.1875, 0.375, 1.3125, 0.3125, 0.5}, -- NodeBox82
			{1, 0.25, 0.375, 1.1875, 0.375, 0.5}, -- NodeBox83
			{0.9375, 0.3125, 0.375, 1.0625, 0.4375, 0.5}, -- NodeBox84
			{0.8125, 0.375, 0.375, 1, 0.5, 0.5}, -- NodeBox85
			{0.75, 0.4375, 0.375, 0.875, 0.5625, 0.5}, -- NodeBox86
			{0.625, 0.5, 0.375, 0.8125, 0.625, 0.5}, -- NodeBox87
			{0.5, 0.5625, 0.375, 0.6875, 0.6875, 0.5}, -- NodeBox88
			{0.4375, 0.625, 0.375, 0.5625, 0.75, 0.5}, -- NodeBox89
			{0.3125, 0.6875, 0.375, 0.5, 0.8125, 0.5}, -- NodeBox90
			{0.25, 0.75, 0.375, 0.375, 0.875, 0.5}, -- NodeBox91
			{0.125, 0.8125, 0.375, 0.3125, 0.9375, 0.5}, -- NodeBox92
			{-0, 0.875, 0.375, 0.1875, 1, 0.5}, -- NodeBox93
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-2.5, -0.5, 0, 2.5, 2.5, 0.625},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:large_support_bot_"..bridge_colors, {
	description = bridge_desc.." Bottom Large Support",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_large_support_bot.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_large_support_bot.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-2.5625, -0.5, 0.25, -2.1875, 0.5, 0.625}, -- NodeBox1
			{2.1875, -0.5, 0.25, 2.5625, 0.5, 0.625}, -- NodeBox2
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-2.5, -0.5, 0, 2.5, 0.5, 0.625},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_right_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Right Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_right_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_right_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox215
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox217
			{-0.5, 2.375, 0.375, 1.5, 2.5, 0.5}, -- NodeBox218
			{-0.4375, 2.25, 0.375, -0.3125, 2.375, 0.5}, -- NodeBox219
			{-0.375, 2.1875, 0.375, -0.25, 2.3125, 0.5}, -- NodeBox220
			{-0.3125, 2.0625, 0.375, -0.1875, 2.25, 0.5}, -- NodeBox221
			{-0.25, 2, 0.375, -0.125, 2.125, 0.5}, -- NodeBox222
			{-0.1875, 1.9375, 0.375, -0.0625, 2.0625, 0.5}, -- NodeBox223
			{-0.125, 1.875, 0.375, 0, 2, 0.5}, -- NodeBox224
			{-0.0625, 1.75, 0.375, 0.0625, 1.9375, 0.5}, -- NodeBox225
			{0, 1.6875, 0.375, 0.125, 1.8125, 0.5}, -- NodeBox226
			{0.0625, 1.625, 0.375, 0.1875, 1.75, 0.5}, -- NodeBox227
			{0.125, 1.5625, 0.375, 0.25, 1.6875, 0.5}, -- NodeBox228
			{0.1875, 1.4375, 0.375, 0.3125, 1.625, 0.5}, -- NodeBox229
			{0.25, 1.375, 0.375, 0.375, 1.5, 0.5}, -- NodeBox230
			{0.3125, 1.3125, 0.375, 0.4375, 1.4375, 0.5}, -- NodeBox231
			{0.375, 1.25, 0.375, 0.5, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.5, 1.0625, 0.375, 0.625, 1.1875, 0.5}, -- NodeBox234
			{0.5625, 1, 0.375, 0.6875, 1.125, 0.5}, -- NodeBox235
			{0.625, 0.9375, 0.375, 0.75, 1.0625, 0.5}, -- NodeBox236
			{0.6875, 0.8125, 0.375, 0.8125, 1, 0.5}, -- NodeBox237
			{0.75, 0.75, 0.375, 0.875, 0.875, 0.5}, -- NodeBox238
			{0.8125, 0.6875, 0.375, 0.9375, 0.8125, 0.5}, -- NodeBox239
			{0.875, 0.625, 0.375, 1, 0.75, 0.5}, -- NodeBox240
			{0.9375, 0.5, 0.375, 1.0625, 0.6875, 0.5}, -- NodeBox241
			{1, 0.4375, 0.375, 1.125, 0.5625, 0.5}, -- NodeBox242
			{1.0625, 0.375, 0.375, 1.1875, 0.5, 0.5}, -- NodeBox243
			{1.125, 0.3125, 0.375, 1.25, 0.4375, 0.5}, -- NodeBox244
			{1.1875, 0.1875, 0.375, 1.3125, 0.375, 0.5}, -- NodeBox245
			{1.25, 0.125, 0.375, 1.375, 0.25, 0.5}, -- NodeBox246
			{1.3125, 0.0625, 0.375, 1.4375, 0.1875, 0.5}, -- NodeBox247
			{1.375, 0, 0.375, 1.5, 0.125, 0.5}, -- NodeBox248
			{-0.4375, 2.3125, 0.375, -0.3125, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:truss_superstructure_left_slant_"..bridge_colors, {
	description = bridge_desc.." Truss Superstructure Left Slant",
	drawtype = "nodebox",
	tiles = {"bridges_"..bridge_colors..".png"},
	inventory_image = "bridges_"..bridge_colors..".png^bridges_superstructure_left_slant.png^[makealpha:255,126,126",
	wield_image = "bridges_"..bridge_colors..".png^bridges_superstructure_left_slant.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 1.5, 0.0625, 0.5}, -- NodeBox214
			{-0.5, -0.5, 0.375, -0.4375, 2.5, 0.5}, -- NodeBox215
			{1.4375, -0.5, 0.375, 1.5, 2.5, 0.5}, -- NodeBox217
			{-0.5, 2.375, 0.375, 1.5, 2.5, 0.5}, -- NodeBox218
			{1.3125, 2.25, 0.375, 1.4375, 2.375, 0.5}, -- NodeBox219
			{1.25, 2.1875, 0.375, 1.375, 2.3125, 0.5}, -- NodeBox220
			{1.1875, 2.0625, 0.375, 1.3125, 2.25, 0.5}, -- NodeBox221
			{1.125, 2, 0.375, 1.25, 2.125, 0.5}, -- NodeBox222
			{1.0625, 1.9375, 0.375, 1.1875, 2.0625, 0.5}, -- NodeBox223
			{1, 1.875, 0.375, 1.125, 2, 0.5}, -- NodeBox224
			{0.9375, 1.75, 0.375, 1.0625, 1.9375, 0.5}, -- NodeBox225
			{0.875, 1.6875, 0.375, 1, 1.8125, 0.5}, -- NodeBox226
			{0.8125, 1.625, 0.375, 0.9375, 1.75, 0.5}, -- NodeBox227
			{0.75, 1.5625, 0.375, 0.875, 1.6875, 0.5}, -- NodeBox228
			{0.6875, 1.4375, 0.375, 0.8125, 1.625, 0.5}, -- NodeBox229
			{0.625, 1.375, 0.375, 0.75, 1.5, 0.5}, -- NodeBox230
			{0.5625, 1.3125, 0.375, 0.6875, 1.4375, 0.5}, -- NodeBox231
			{0.5, 1.25, 0.375, 0.625, 1.375, 0.5}, -- NodeBox232
			{0.4375, 1.125, 0.375, 0.5625, 1.3125, 0.5}, -- NodeBox233
			{0.375, 1.0625, 0.375, 0.5, 1.1875, 0.5}, -- NodeBox234
			{0.3125, 1, 0.375, 0.4375, 1.125, 0.5}, -- NodeBox235
			{0.25, 0.9375, 0.375, 0.375, 1.0625, 0.5}, -- NodeBox236
			{0.1875, 0.8125, 0.375, 0.3125, 1, 0.5}, -- NodeBox237
			{0.125, 0.75, 0.375, 0.25, 0.875, 0.5}, -- NodeBox238
			{0.0625, 0.6875, 0.375, 0.1875, 0.8125, 0.5}, -- NodeBox239
			{0, 0.625, 0.375, 0.125, 0.75, 0.5}, -- NodeBox240
			{-0.0625, 0.5, 0.375, 0.0625, 0.6875, 0.5}, -- NodeBox241
			{-0.125, 0.4375, 0.375, 0, 0.5625, 0.5}, -- NodeBox242
			{-0.1875, 0.375, 0.375, -0.0625, 0.5, 0.5}, -- NodeBox243
			{-0.25, 0.3125, 0.375, -0.125, 0.4375, 0.5}, -- NodeBox244
			{-0.3125, 0.1875, 0.375, -0.1875, 0.375, 0.5}, -- NodeBox245
			{-0.375, 0.125, 0.375, -0.25, 0.25, 0.5}, -- NodeBox246
			{-0.4375, 0.0625, 0.375, -0.3125, 0.1875, 0.5}, -- NodeBox247
			{-0.5, 0, 0.375, -0.375, 0.125, 0.5}, -- NodeBox248
			{1.375, 2.3125, 0.375, 1.5, 2.4375, 0.5}, -- NodeBox249
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	collision_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0.375, 1.5, 2.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:corrugated_steel_"..bridge_colors, {
	description = bridge_desc.." Corrugated Steel",
	drawtype = "nodebox",
	tiles = {"bridges_corrugated_steel_"..bridge_colors..".png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, 0.375, 0.5, 0.5, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, 0, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

minetest.register_node("bridger:corrugated_steel_ceiling_"..bridge_colors, {
	description = bridge_desc.." Corrugated Steel Deck",
	drawtype = "nodebox",
	tiles = {"bridges_corrugated_steel_"..bridge_colors..".png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.5, 0.5},
		},
	},
	groups = {cracky=3},
	sounds = default.node_sound_metal_defaults(),
})

end

minetest.register_node("bridger:trestle_support", {
	description = "Trestle Support",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_trestle_support.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_trestle_support.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1, -0.5, -0.125, -0.75, 1.5, 0.125}, -- NodeBox1
			{0.75, -0.5, -0.125, 1, 1.5, 0.125}, -- NodeBox2
			{0.625, 1.375, -0.0625, 0.75, 1.5, 0.0625}, -- NodeBox3
			{0.5625, 1.25, -0.0625, 0.6875, 1.4375, 0.0625}, -- NodeBox4
			{0.5, 1.1875, -0.0625, 0.625, 1.3125, 0.0625}, -- NodeBox5
			{0.4375, 1.125, -0.0625, 0.5625, 1.25, 0.0625}, -- NodeBox6
			{0.375, 1, -0.0625, 0.5, 1.1875, 0.0625}, -- NodeBox7
			{0.3125, 0.9375, -0.0625, 0.4375, 1.0625, 0.0625}, -- NodeBox8
			{0.25, 0.875, -0.0625, 0.375, 1, 0.0625}, -- NodeBox9
			{0.1875, 0.75, -0.0625, 0.3125, 0.9375, 0.0625}, -- NodeBox10
			{0.125, 0.6875, -0.0625, 0.25, 0.8125, 0.0625}, -- NodeBox11
			{0.0625, 0.625, -0.0625, 0.1875, 0.75, 0.0625}, -- NodeBox12
			{0, 0.5, -0.0625, 0.125, 0.6875, 0.0625}, -- NodeBox13
			{-0.0625, 0.4375, -0.0625, 0.0625, 0.5625, 0.0625}, -- NodeBox14
			{-0.125, 0.3125, -0.0625, 0, 0.5, 0.0625}, -- NodeBox15
			{-0.1875, 0.25, -0.0625, -0.0625, 0.375, 0.0625}, -- NodeBox16
			{-0.25, 0.1875, -0.0625, -0.125, 0.3125, 0.0625}, -- NodeBox17
			{-0.3125, 0.0625, -0.0625, -0.1875, 0.25, 0.0625}, -- NodeBox18
			{-0.375, 0, -0.0625, -0.25, 0.125, 0.0625}, -- NodeBox19
			{-0.4375, -0.0625, -0.0625, -0.3125, 0.0625, 0.0625}, -- NodeBox20
			{-0.5, -0.1875, -0.0625, -0.375, 0, 0.0625}, -- NodeBox21
			{-0.5625, -0.25, -0.0625, -0.4375, -0.125, 0.0625}, -- NodeBox22
			{-0.625, -0.3125, -0.0625, -0.5, -0.1875, 0.0625}, -- NodeBox23
			{-0.6875, -0.4375, -0.0625, -0.5625, -0.25, 0.0625}, -- NodeBox24
			{-0.75, -0.5, -0.0625, -0.625, -0.375, 0.0625}, -- NodeBox25
			{-0.75, 1.375, -0.0625, -0.625, 1.5, 0.0625}, -- NodeBox3
			{-0.6875, 1.25, -0.0625, -0.5625, 1.4375, 0.0625}, -- NodeBox4
			{-0.625, 1.1875, -0.0625, -0.5, 1.3125, 0.0625}, -- NodeBox5
			{-0.5625, 1.125, -0.0625, -0.4375, 1.25, 0.0625}, -- NodeBox6
			{-0.5, 1, -0.0625, -0.375, 1.1875, 0.0625}, -- NodeBox7
			{-0.4375, 0.9375, -0.0625, -0.3125, 1.0625, 0.0625}, -- NodeBox8
			{-0.375, 0.875, -0.0625, -0.25, 1, 0.0625}, -- NodeBox9
			{-0.3125, 0.75, -0.0625, -0.1875, 0.9375, 0.0625}, -- NodeBox10
			{-0.25, 0.6875, -0.0625, -0.125, 0.8125, 0.0625}, -- NodeBox11
			{-0.1875, 0.625, -0.0625, -0.0625, 0.75, 0.0625}, -- NodeBox12
			{-0.125, 0.5, -0.0625, -0, 0.6875, 0.0625}, -- NodeBox13
			{-0, 0.3125, -0.0625, 0.125, 0.5, 0.0625}, -- NodeBox15
			{0.0625, 0.25, -0.0625, 0.1875, 0.375, 0.0625}, -- NodeBox16
			{0.125, 0.1875, -0.0625, 0.25, 0.3125, 0.0625}, -- NodeBox17
			{0.1875, 0.0625, -0.0625, 0.3125, 0.25, 0.0625}, -- NodeBox18
			{0.25, 0, -0.0625, 0.375, 0.125, 0.0625}, -- NodeBox19
			{0.3125, -0.0625, -0.0625, 0.4375, 0.0625, 0.0625}, -- NodeBox20
			{0.375, -0.1875, -0.0625, 0.5, 0, 0.0625}, -- NodeBox21
			{0.4375, -0.25, -0.0625, 0.5625, -0.125, 0.0625}, -- NodeBox22
			{0.5, -0.3125, -0.0625, 0.625, -0.1875, 0.0625}, -- NodeBox23
			{0.5625, -0.4375, -0.0625, 0.6875, -0.25, 0.0625}, -- NodeBox24
			{0.625, -0.5, -0.0625, 0.75, -0.375, 0.0625}, -- NodeBox25
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-1, -0.5, -0.1875, 1, 1.5, 0.1875},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:trestle_support_small", {
	description = "Small Trestle Support",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_trestle_support_small.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_trestle_support_small.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1, -0.5, -0.125, -0.75, 0.5, 0.125}, -- NodeBox1
			{0.75, -0.5, -0.125, 1, 0.5, 0.125}, -- NodeBox2
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-1, -0.5, -0.1875, 1, 0.5, 0.1875},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:trestle_side", {
	description = "Trestle Siding",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_trestle_side.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_trestle_side.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.875, -0.5, -0.0625, 0.875, -0.375, 0.0625}, -- NodeBox1
			{-0.875, 1.375, -0.0625, 0.875, 1.5, 0.0625}, -- NodeBox2
			{-1, 1.375, -0.0625, 1, 1.5, 0}, -- NodeBox30
			{-1, -0.5, -0.0625, 1, -0.375, 0}, -- NodeBox31
			{-0.9375, 1.3125, -0.0625, -0.8125, 1.4375, 0.0625}, -- NodeBox3
			{-0.875, 1.25, -0.0625, -0.75, 1.375, 0.0625}, -- NodeBox4
			{0.25, 0.125, -0.0625, 0.375, 0.25, 0.0625}, -- NodeBox5
			{-0.8125, 1.1875, -0.0625, -0.6875, 1.3125, 0.0625}, -- NodeBox6
			{-0.75, 1.125, -0.0625, -0.625, 1.25, 0.0625}, -- NodeBox7
			{-0.6875, 1.0625, -0.0625, -0.5625, 1.1875, 0.0625}, -- NodeBox8
			{-0.625, 1, -0.0625, -0.5, 1.125, 0.0625}, -- NodeBox9
			{-0.5625, 0.9375, -0.0625, -0.4375, 1.0625, 0.0625}, -- NodeBox10
			{-0.5, 0.875, -0.0625, -0.375, 1, 0.0625}, -- NodeBox11
			{-0.4375, 0.8125, -0.0625, -0.3125, 0.9375, 0.0625}, -- NodeBox12
			{-0.375, 0.75, -0.0625, -0.25, 0.875, 0.0625}, -- NodeBox13
			{-0.3125, 0.6875, -0.0625, -0.1875, 0.8125, 0.0625}, -- NodeBox14
			{-0.25, 0.625, -0.0625, -0.125, 0.75, 0.0625}, -- NodeBox15
			{-0.1875, 0.5625, -0.0625, -0.0625, 0.6875, 0.0625}, -- NodeBox16
			{-0.125, 0.375, -0.0625, 0.125, 0.625, 0.0625}, -- NodeBox17
			{0.0625, 0.3125, -0.0625, 0.1875, 0.4375, 0.0625}, -- NodeBox18
			{0.125, 0.25, -0.0625, 0.25, 0.375, 0.0625}, -- NodeBox19
			{0.1875, 0.1875, -0.0625, 0.3125, 0.3125, 0.0625}, -- NodeBox20
			{0.3125, 0.0625, -0.0625, 0.4375, 0.1875, 0.0625}, -- NodeBox21
			{0.375, 0, -0.0625, 0.5, 0.125, 0.0625}, -- NodeBox22
			{0.4375, -0.0625, -0.0625, 0.5625, 0.0625, 0.0625}, -- NodeBox23
			{0.5, -0.125, -0.0625, 0.625, 0, 0.0625}, -- NodeBox24
			{0.5625, -0.1875, -0.0625, 0.6875, -0.0625, 0.0625}, -- NodeBox25
			{0.625, -0.25, -0.0625, 0.75, -0.125, 0.0625}, -- NodeBox26
			{0.6875, -0.3125, -0.0625, 0.8125, -0.1875, 0.0625}, -- NodeBox27
			{0.75, -0.375, -0.0625, 0.875, -0.25, 0.0625}, -- NodeBox28
			{0.8125, -0.4375, -0.0625, 0.9375, -0.3125, 0.0625}, -- NodeBox29
			{0.8125, 1.3125, -0.0625, 0.9375, 1.4375, 0.0625}, -- NodeBox3
			{0.75, 1.25, -0.0625, 0.875, 1.375, 0.0625}, -- NodeBox4
			{-0.375, 0.125, -0.0625, -0.25, 0.25, 0.0625}, -- NodeBox5
			{0.6875, 1.1875, -0.0625, 0.8125, 1.3125, 0.0625}, -- NodeBox6
			{0.625, 1.125, -0.0625, 0.75, 1.25, 0.0625}, -- NodeBox7
			{0.5625, 1.0625, -0.0625, 0.6875, 1.1875, 0.0625}, -- NodeBox8
			{0.5, 1, -0.0625, 0.625, 1.125, 0.0625}, -- NodeBox9
			{0.4375, 0.9375, -0.0625, 0.5625, 1.0625, 0.0625}, -- NodeBox10
			{0.375, 0.875, -0.0625, 0.5, 1, 0.0625}, -- NodeBox11
			{0.3125, 0.8125, -0.0625, 0.4375, 0.9375, 0.0625}, -- NodeBox12
			{0.25, 0.75, -0.0625, 0.375, 0.875, 0.0625}, -- NodeBox13
			{0.1875, 0.6875, -0.0625, 0.3125, 0.8125, 0.0625}, -- NodeBox14
			{0.125, 0.625, -0.0625, 0.25, 0.75, 0.0625}, -- NodeBox15
			{0.0625, 0.5625, -0.0625, 0.1875, 0.6875, 0.0625}, -- NodeBox16
			{-0.1875, 0.3125, -0.0625, -0.0625, 0.4375, 0.0625}, -- NodeBox18
			{-0.25, 0.25, -0.0625, -0.125, 0.375, 0.0625}, -- NodeBox19
			{-0.3125, 0.1875, -0.0625, -0.1875, 0.3125, 0.0625}, -- NodeBox20
			{-0.4375, 0.0625, -0.0625, -0.3125, 0.1875, 0.0625}, -- NodeBox21
			{-0.5, 0, -0.0625, -0.375, 0.125, 0.0625}, -- NodeBox22
			{-0.5625, -0.0625, -0.0625, -0.4375, 0.0625, 0.0625}, -- NodeBox23
			{-0.625, -0.125, -0.0625, -0.5, 0, 0.0625}, -- NodeBox24
			{-0.6875, -0.1875, -0.0625, -0.5625, -0.0625, 0.0625}, -- NodeBox25
			{-0.75, -0.25, -0.0625, -0.625, -0.125, 0.0625}, -- NodeBox26
			{-0.8125, -0.3125, -0.0625, -0.6875, -0.1875, 0.0625}, -- NodeBox27
			{-0.875, -0.375, -0.0625, -0.75, -0.25, 0.0625}, -- NodeBox28
			{-0.9375, -0.4375, -0.0625, -0.8125, -0.3125, 0.0625}, -- NodeBox29
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-1, -0.5, -0.1875, 1, 1.5, 0.1875},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:trestle_deck", {
	description = "Trestle Deck",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_trestle_deck.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_trestle_deck.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.625, 0.25, -0.5, -0.5, 0.375, 0.5}, -- NodeBox1
			{0.5, 0.25, -0.5, 0.625, 0.375, 0.5}, -- NodeBox2
			{-1.125, 0.374, 0.3125, 1.125, 0.501, 0.4375}, -- NodeBox3
			{-1.125, 0.374, 0.0625, 1.125, 0.501, 0.1875}, -- NodeBox4
			{-1.125, 0.374, -0.1875, 1.125, 0.501, -0.0625}, -- NodeBox5
			{-1.125, 0.374, -0.4375, 1.125, 0.501, -0.3125}, -- NodeBox6
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-1.125, 0, -0.5, 1.125, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:trestle_substructure_small", {
	description = "Small Trestle Substructure",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_trestle_small.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_trestle_small.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, 1.375, -0.0625, 0.5, 1.499, 0.0625}, -- NodeBox0
			{-1.4375, 1.3125, -0.0625, -1.3125, 1.4375, 0.0625}, -- NodeBox2
			{-1.375, 1.25, -0.0625, -1.25, 1.375, 0.0625}, -- NodeBox3
			{-1.3125, 1.1875, -0.0625, -1.125, 1.3125, 0.0625}, -- NodeBox4
			{-1.1875, 1.125, -0.0625, -1.0625, 1.25, 0.0625}, -- NodeBox5
			{-1.125, 1.0625, -0.0625, -1, 1.1875, 0.0625}, -- NodeBox6
			{-1.0625, 1, -0.0625, -0.875, 1.125, 0.0625}, -- NodeBox7
			{-0.9375, 0.9375, -0.0625, -0.8125, 1.0625, 0.0625}, -- NodeBox8
			{-0.875, 0.875, -0.0625, -0.75, 1, 0.0625}, -- NodeBox9
			{-0.8125, 0.8125, -0.0625, -0.625, 0.9375, 0.0625}, -- NodeBox10
			{-0.6875, 0.75, -0.0625, -0.5625, 0.875, 0.0625}, -- NodeBox11
			{-0.625, 0.6875, -0.0625, -0.5, 0.8125, 0.0625}, -- NodeBox12
			{-0.5625, 0.625, -0.0625, -0.375, 0.75, 0.0625}, -- NodeBox13
			{-0.4375, 0.5625, -0.0625, -0.3125, 0.6875, 0.0625}, -- NodeBox14
			{-0.375, 0.5, -0.0625, -0.25, 0.625, 0.0625}, -- NodeBox15
			{-0.3125, 0.4375, -0.0625, -0.125, 0.5625, 0.0625}, -- NodeBox16
			{-0.1875, 0.375, -0.0625, -0.0625, 0.5, 0.0625}, -- NodeBox17
			{-0.125, 0.3125, -0.0625, 0, 0.4375, 0.0625}, -- NodeBox18
			{-0.0625, 0.25, -0.0625, 0.125, 0.375, 0.0625}, -- NodeBox19
			{0.0625, 0.1875, -0.0625, 0.1875, 0.3125, 0.0625}, -- NodeBox20
			{0.125, 0.125, -0.0625, 0.25, 0.25, 0.0625}, -- NodeBox21
			{0.1875, 0.0625, -0.0625, 0.375, 0.1875, 0.0625}, -- NodeBox22
			{0.3125, 0, -0.0625, 0.4375, 0.125, 0.0625}, -- NodeBox23
			{0.4375, 0, -0.0625, 0.5, 1.5, 0.0625}, -- NodeBox24
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-1.5, 0, -0.0625, 0.5, 1.5, 0.0625},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:trestle_substructure_large", {
	description = "Large Trestle Substructure",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_trestle_large.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_trestle_large.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{0.4375, -0.5, -0.0625, 0.5, 1.5, 0.0625}, -- NodeBox1
			{0.25, -0.5, -0.0625, 0.4375, -0.375, 0.0625}, -- NodeBox2
			{0.125, -0.4375, -0.0625, 0.3125, -0.3125, 0.0625}, -- NodeBox3
			{0, -0.375, -0.0625, 0.1875, -0.25, 0.0625}, -- NodeBox4
			{-0.125, -0.3125, -0.0625, 0.0625, -0.1875, 0.0625}, -- NodeBox5
			{-0.25, -0.25, -0.0625, -0.0625, -0.125, 0.0625}, -- NodeBox6
			{-0.375, -0.1875, -0.0625, -0.1875, -0.0625, 0.0625}, -- NodeBox7
			{-0.5, -0.125, -0.0625, -0.3125, 0, 0.0625}, -- NodeBox8
			{-0.625, -0.0625, -0.0625, -0.4375, 0.0625, 0.0625}, -- NodeBox9
			{-0.75, 0, -0.0625, -0.5625, 0.125, 0.0625}, -- NodeBox10
			{-0.875, 0.0625, -0.0625, -0.6875, 0.1875, 0.0625}, -- NodeBox11
			{-1, 0.125, -0.0625, -0.8125, 0.25, 0.0625}, -- NodeBox12
			{-1.125, 0.1875, -0.0625, -0.9375, 0.3125, 0.0625}, -- NodeBox13
			{-1.25, 0.25, -0.0625, -1.0625, 0.375, 0.0625}, -- NodeBox14
			{-1.375, 0.3125, -0.0625, -1.1875, 0.4375, 0.0625}, -- NodeBox15
			{-1.5, 0.375, -0.0625, -1.3125, 0.5, 0.0625}, -- NodeBox16
			{-1.625, 0.4375, -0.0625, -1.4375, 0.5625, 0.0625}, -- NodeBox17
			{-1.75, 0.5, -0.0625, -1.5625, 0.625, 0.0625}, -- NodeBox18
			{-1.875, 0.5625, -0.0625, -1.6875, 0.6875, 0.0625}, -- NodeBox19
			{-2, 0.625, -0.0625, -1.8125, 0.75, 0.0625}, -- NodeBox20
			{-2.125, 0.6875, -0.0625, -1.9375, 0.8125, 0.0625}, -- NodeBox21
			{-2.25, 0.75, -0.0625, -2.0625, 0.875, 0.0625}, -- NodeBox22
			{-2.375, 0.8125, -0.0625, -2.1875, 0.9375, 0.0625}, -- NodeBox23
			{-2.5, 0.875, -0.0625, -2.3125, 1, 0.0625}, -- NodeBox24
			{-2.625, 0.9375, -0.0625, -2.4375, 1.0625, 0.0625}, -- NodeBox25
			{-2.75, 1, -0.0625, -2.5625, 1.125, 0.0625}, -- NodeBox26
			{-2.875, 1.0625, -0.0625, -2.6875, 1.1875, 0.0625}, -- NodeBox27
			{-3, 1.125, -0.0625, -2.8125, 1.25, 0.0625}, -- NodeBox28
			{-3.125, 1.1875, -0.0625, -2.9375, 1.3125, 0.0625}, -- NodeBox29
			{-3.25, 1.25, -0.0625, -3.0625, 1.375, 0.0625}, -- NodeBox30
			{-3.375, 1.3125, -0.0625, -3.1875, 1.4375, 0.0625}, -- NodeBox31
			{-3.5, 1.375, -0.0625, -3.3125, 1.5, 0.0625}, -- NodeBox32
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-3.5, -0.5, -0.0625, 0.5, 1.5, 0.0625},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:lattice_truss_side", {
	description = "Lattice Truss",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_lattice_truss_side.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_lattice_truss_side.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.0625, -0.25, -0.25, 0.0625}, -- NodeBox1
			{-0.4375, -0.4375, -0.0625, -0.1875, -0.1875, 0.0625}, -- NodeBox2
			{-0.375, -0.375, -0.0625, -0.125, -0.125, 0.0625}, -- NodeBox3
			{-0.3125, -0.3125, -0.0625, -0.0625, -0.0625, 0.0625}, -- NodeBox4
			{0.0625, 0.0625, -0.0625, 0.3125, 0.3125, 0.0625}, -- NodeBox10
			{0.125, 0.125, -0.0625, 0.375, 0.375, 0.0625}, -- NodeBox11
			{0.1875, 0.1875, -0.0625, 0.4375, 0.4375, 0.0625}, -- NodeBox12
			{0.25, 0.25, -0.0625, 0.5, 0.5, 0.0625}, -- NodeBox13
			{0.25, -0.5, -0.0625, 0.5, -0.25, 0.0625}, -- NodeBox14
			{0.1875, -0.4375, -0.0625, 0.4375, -0.1875, 0.0625}, -- NodeBox15
			{-0.25, -0.25, -0.0625, 0.25, 0.25, 0.0625}, -- NodeBox16
			{0.125, -0.375, -0.0625, 0.375, -0.125, 0.0625}, -- NodeBox17
			{0.0625, -0.3125, -0.0625, 0.3125, -0.0625, 0.0625}, -- NodeBox18
			{-0.5, 0.25, -0.0625, -0.25, 0.5, 0.0625}, -- NodeBox19
			{-0.4375, 0.1875, -0.0625, -0.1875, 0.4375, 0.0625}, -- NodeBox20
			{-0.375, 0.125, -0.0625, -0.125, 0.375, 0.0625}, -- NodeBox21
			{-0.3125, 0.0625, -0.0625, -0.0625, 0.3125, 0.0625}, -- NodeBox22
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.125, 0.5, 0.5, 0.125},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:lattice_truss_top", {
	description = "Lattice Truss Upper Chord",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	inventory_image = "default_junglewood.png^bridges_lattice_truss_top.png^[makealpha:255,126,126",
	wield_image = "default_junglewood.png^bridges_lattice_truss_top.png^[makealpha:255,126,126",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1, 0.375, 0.25, -0.75, 0.501, 0.5}, -- NodeBox1
			{-0.25, 0.375, 0.25, 0.25, 0.501, 0.5}, -- NodeBox2
			{-0.25, 0.375, -0.5, 0.25, 0.501, -0.25}, -- NodeBox5
			{-1, 0.375, -0.5, -0.75, 0.501, -0.25}, -- NodeBox6
			{-0.9375, 0.375, -0.4375, -0.6875, 0.501, -0.1875}, -- NodeBox7
			{-0.875, 0.375, -0.375, -0.625, 0.501, -0.125}, -- NodeBox8
			{-0.8125, 0.375, -0.3125, -0.5625, 0.501, -0.0625}, -- NodeBox9
			{-0.3125, 0.375, -0.4375, -0.0625, 0.501, -0.1875}, -- NodeBox10
			{-0.375, 0.375, -0.375, -0.125, 0.501, -0.125}, -- NodeBox11
			{-0.4375, 0.375, -0.3125, -0.1875, 0.501, -0.0625}, -- NodeBox12
			{-0.75, 0.375, -0.25, -0.25, 0.501, 0.25}, -- NodeBox13
			{-0.9375, 0.375, 0.1875, -0.6875, 0.501, 0.4375}, -- NodeBox15
			{-0.875, 0.375, 0.125, -0.625, 0.501, 0.375}, -- NodeBox16
			{-0.8125, 0.375, 0.0625, -0.5625, 0.501, 0.3125}, -- NodeBox17
			{-0.4375, 0.375, 0.0625, -0.1875, 0.501, 0.3125}, -- NodeBox18
			{-0.375, 0.375, 0.125, -0.125, 0.501, 0.375}, -- NodeBox19
			{-0.3125, 0.375, 0.1875, -0.0625, 0.501, 0.4375}, -- NodeBox20
			{0.75, 0.375, -0.5, 1, 0.501, -0.25}, -- NodeBox1
			{0.75, 0.375, 0.25, 1, 0.501, 0.5}, -- NodeBox6
			{0.6875, 0.375, 0.1875, 0.9375, 0.501, 0.4375}, -- NodeBox7
			{0.625, 0.375, 0.125, 0.875, 0.501, 0.375}, -- NodeBox8
			{0.5625, 0.375, 0.0625, 0.8125, 0.501, 0.3125}, -- NodeBox9
			{0.0625, 0.375, 0.1875, 0.3125, 0.501, 0.4375}, -- NodeBox10
			{0.125, 0.375, 0.125, 0.375, 0.501, 0.375}, -- NodeBox11
			{0.1875, 0.375, 0.0625, 0.4375, 0.501, 0.3125}, -- NodeBox12
			{0.25, 0.375, -0.25, 0.75, 0.501, 0.25}, -- NodeBox13
			{0.6875, 0.375, -0.4375, 0.9375, 0.501, -0.1875}, -- NodeBox15
			{0.625, 0.375, -0.375, 0.875, 0.501, -0.125}, -- NodeBox16
			{0.5625, 0.375, -0.3125, 0.8125, 0.501, -0.0625}, -- NodeBox17
			{0.1875, 0.375, -0.3125, 0.4375, 0.501, -0.0625}, -- NodeBox18
			{0.125, 0.375, -0.375, 0.375, 0.501, -0.125}, -- NodeBox19
			{0.0625, 0.375, -0.4375, 0.3125, 0.501, -0.1875}, -- NodeBox20
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-1, 0.375, -0.5, 1, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:small_beam", {
	description = "Small Wooden Beam Bridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, -0.4375, 0.5}, -- NodeBox1
			{-0.5, -0.5, 0.40625, -0.40625, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.40625, 0.5, -0.40625}, -- NodeBox3
			{-0.5, 0.375, -0.5, -0.40625, 0.4375, 0.5}, -- NodeBox4
			{0.40625, 0.375, -0.5, 0.5, 0.4375, 0.5}, -- NodeBox5
			{0.40625, -0.5, -0.5, 0.5, 0.5, -0.40625}, -- NodeBox6
			{0.40625, -0.5, 0.40625, 0.5, 0.5, 0.5}, -- NodeBox7
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:small_beam_mid", {
	description = "Small Wooden Beam Bridge Middle",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, -0.4375, 0.5}, -- NodeBox1
			{-0.5, 0.375, -0.5, -0.40625, 0.4375, 0.5}, -- NodeBox4
			{0.40625, 0.375, -0.5, 0.5, 0.4375, 0.5}, -- NodeBox5
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:small_beam_end", {
	description = "Small Wooden Beam Bridge End",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, -0.4375, 0.4375}, -- NodeBox1
			{-0.5, -0.5, 0.40625, -0.40625, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.40625, 0.5, -0.40625}, -- NodeBox3
			{-0.5, 0.375, -0.5, -0.40625, 0.4375, 0.5}, -- NodeBox4
			{0.40625, 0.375, -0.5, 0.5, 0.4375, 0.5}, -- NodeBox5
			{0.40625, -0.5, -0.5, 0.5, 0.5, -0.40625}, -- NodeBox6
			{0.40625, -0.5, 0.40625, 0.5, 0.5, 0.5}, -- NodeBox7
			{-0.5, 0.375, 0.40625, 0.5, 0.4375, 0.5}, -- NodeBox8
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:small_beam_3", {
	description = "Small Wooden Beam Bridge Crossing",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.4375}, -- NodeBox1
			{-0.5, -0.5, 0.40625, -0.40625, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.40625, 0.5, -0.40625}, -- NodeBox3
			{0.40625, -0.5, -0.5, 0.5, 0.5, -0.40625}, -- NodeBox6
			{0.40625, -0.5, 0.40625, 0.5, 0.5, 0.5}, -- NodeBox7
			{-0.5, 0.375, 0.40625, 0.5, 0.4375, 0.5}, -- NodeBox8
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:small_beam_4", {
	description = "Small Wooden Beam Bridge Crossing",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5}, -- NodeBox1
			{-0.5, -0.5, 0.40625, -0.40625, 0.5, 0.5}, -- NodeBox2
			{-0.5, -0.5, -0.5, -0.40625, 0.5, -0.40625}, -- NodeBox3
			{0.40625, -0.5, -0.5, 0.5, 0.5, -0.40625}, -- NodeBox6
			{0.40625, -0.5, 0.40625, 0.5, 0.5, 0.5}, -- NodeBox7
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:small_beam_stair", {
	description = "Small Wooden Beam Bridge Stair",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.0625, -0.5, 0.4375, 0, 0}, -- NodeBox1
			{-0.4375, 0.4375, 0, 0.4375, 0.5, 0.5}, -- NodeBox2
			{0.40625, 0.4375, 0.40625, 0.5, 1.5, 0.5}, -- NodeBox3
			{0.40625, -0.5, -0.5, 0.5, 0.625, -0.40625}, -- NodeBox4
			{-0.5, -0.5, -0.5, -0.40625, 0.625, -0.40625}, -- NodeBox5
			{-0.5, 0.4375, 0.40625, -0.40625, 1.5, 0.5}, -- NodeBox6
			{-0.5, 1.3125, 0.375, -0.40625, 1.375, 0.5}, -- NodeBox7
			{-0.5, 1.25, 0.3125, -0.40625, 1.3125, 0.4375}, -- NodeBox8
			{-0.5, 1.1875, 0.25, -0.40625, 1.25, 0.375}, -- NodeBox9
			{-0.5, 1.125, 0.1875, -0.40625, 1.1875, 0.3125}, -- NodeBox10
			{-0.5, 1.0625, 0.125, -0.40625, 1.125, 0.25}, -- NodeBox11
			{-0.5, 1, 0.0625, -0.40625, 1.0625, 0.1875}, -- NodeBox12
			{-0.5, 0.9375, 0, -0.40625, 1, 0.125}, -- NodeBox13
			{-0.5, 0.875, -0.0625, -0.40625, 0.9375, 0.0625}, -- NodeBox14
			{-0.5, 0.8125, -0.125, -0.40625, 0.875, 0}, -- NodeBox15
			{-0.5, 0.75, -0.1875, -0.40625, 0.8125, -0.0625}, -- NodeBox16
			{-0.5, 0.6875, -0.25, -0.40625, 0.75, -0.125}, -- NodeBox17
			{-0.5, 0.625, -0.3125, -0.40625, 0.6875, -0.1875}, -- NodeBox18
			{-0.5, 0.5625, -0.375, -0.40625, 0.625, -0.25}, -- NodeBox19
			{-0.5, 0.5, -0.4375, -0.40625, 0.5625, -0.3125}, -- NodeBox20
			{-0.5, 0.4375, -0.5, -0.40625, 0.5, -0.375}, -- NodeBox21
			{0.40625, 0.4375, -0.5, 0.5, 0.5, -0.375}, -- NodeBox22
			{0.40625, 0.5, -0.4375, 0.5, 0.5625, -0.3125}, -- NodeBox23
			{0.40625, 0.5625, -0.375, 0.5, 0.625, -0.25}, -- NodeBox24
			{0.40625, 0.625, -0.3125, 0.5, 0.6875, -0.1875}, -- NodeBox25
			{0.40625, 0.6875, -0.25, 0.5, 0.75, -0.125}, -- NodeBox26
			{0.40625, 0.75, -0.1875, 0.5, 0.8125, -0.0625}, -- NodeBox27
			{0.40625, 0.8125, -0.125, 0.5, 0.875, 0}, -- NodeBox28
			{0.40625, 0.875, -0.0625, 0.5, 0.9375, 0.0625}, -- NodeBox29
			{0.40625, 0.9375, 0, 0.5, 1, 0.125}, -- NodeBox30
			{0.40625, 1, 0.0625, 0.5, 1.0625, 0.1875}, -- NodeBox31
			{0.40625, 1.0625, 0.125, 0.5, 1.125, 0.25}, -- NodeBox32
			{0.40625, 1.125, 0.1875, 0.5, 1.1875, 0.3125}, -- NodeBox33
			{0.40625, 1.1875, 0.25, 0.5, 1.25, 0.375}, -- NodeBox34
			{0.40625, 1.25, 0.3125, 0.5, 1.3125, 0.4375}, -- NodeBox35
			{0.40625, 1.3125, 0.375, 0.5, 1.375, 0.5}, -- NodeBox36
			{0.40625, -0.5, -0.5, 0.5, -0.4375, -0.375}, -- NodeBox38
			{0.40625, -0.4375, -0.4375, 0.5, -0.375, -0.3125}, -- NodeBox39
			{0.40625, -0.375, -0.375, 0.5, -0.3125, -0.25}, -- NodeBox40
			{0.40625, -0.3125, -0.3125, 0.5, -0.25, -0.1875}, -- NodeBox41
			{0.40625, -0.25, -0.25, 0.5, -0.1875, -0.125}, -- NodeBox42
			{0.40625, -0.1875, -0.1875, 0.5, -0.125, -0.0625}, -- NodeBox43
			{0.40625, -0.125, -0.125, 0.5, -0.0625, 0}, -- NodeBox44
			{0.40625, -0.0625, -0.0625, 0.5, 0, 0.0625}, -- NodeBox45
			{0.40625, 0, 0, 0.5, 0.0625, 0.125}, -- NodeBox46
			{0.40625, 0.0625, 0.0625, 0.5, 0.125, 0.1875}, -- NodeBox47
			{0.40625, 0.125, 0.125, 0.5, 0.1875, 0.25}, -- NodeBox48
			{0.40625, 0.1875, 0.1875, 0.5, 0.25, 0.3125}, -- NodeBox49
			{0.40625, 0.25, 0.25, 0.5, 0.3125, 0.375}, -- NodeBox50
			{0.40625, 0.3125, 0.3125, 0.5, 0.375, 0.4375}, -- NodeBox51
			{0.40625, 0.375, 0.375, 0.5, 0.4375, 0.5}, -- NodeBox52
			{-0.5, -0.5, -0.5, -0.40625, -0.4375, -0.375}, -- NodeBox53
			{-0.5, -0.4375, -0.4375, -0.40625, -0.375, -0.3125}, -- NodeBox54
			{-0.5, -0.375, -0.375, -0.40625, -0.3125, -0.25}, -- NodeBox55
			{-0.5, -0.3125, -0.3125, -0.40625, -0.25, -0.1875}, -- NodeBox56
			{-0.5, -0.25, -0.25, -0.40625, -0.1875, -0.125}, -- NodeBox57
			{-0.5, -0.1875, -0.1875, -0.40625, -0.125, -0.0625}, -- NodeBox58
			{-0.5, -0.125, -0.125, -0.40625, -0.0625, 0}, -- NodeBox59
			{-0.5, -0.0625, -0.0625, -0.40625, 0, 0.0625}, -- NodeBox60
			{-0.5, 0, 0, -0.40625, 0.0625, 0.125}, -- NodeBox61
			{-0.5, 0.0625, 0.0625, -0.40625, 0.125, 0.1875}, -- NodeBox62
			{-0.5, 0.125, 0.125, -0.40625, 0.1875, 0.25}, -- NodeBox63
			{-0.5, 0.1875, 0.1875, -0.40625, 0.25, 0.3125}, -- NodeBox64
			{-0.5, 0.25, 0.25, -0.40625, 0.3125, 0.375}, -- NodeBox65
			{-0.5, 0.3125, 0.3125, -0.40625, 0.375, 0.4375}, -- NodeBox66
			{-0.5, 0.375, 0.375, -0.40625, 0.4375, 0.5}, -- NodeBox67
			{-0.5, -0.5625, -0.5, -0.40625, -0.5, -0.4375}, -- NodeBox68
			{0.40625, -0.5625, -0.5, 0.5, -0.5, -0.4375}, -- NodeBox69
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:large_beam", {
	description = "Large Wooden Beam Bridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -1.5, 0.4375, -0.4375, 1.5}, -- NodeBox1
			{0.40625, -0.5, -0.6875, 0.5, 0.5, -0.59375}, -- NodeBox2
			{0.40625, -0.5, 0.59375, 0.5, 0.5, 0.6875}, -- NodeBox3
			{-0.5, -0.5, 0.59375, -0.40625, 0.5, 0.6875}, -- NodeBox4
			{-0.5, -0.5, -0.6875, -0.40625, 0.5, -0.59375}, -- NodeBox5
			{-0.5, 0.375, -1.5, -0.40625, 0.4375, 1.5}, -- NodeBox6
			{0.40625, 0.375, -1.5, 0.5, 0.4375, 1.5}, -- NodeBox7
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -1.5, 0.5, 0.5, 1.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:large_fancy_beam", {
	description = "Large Fancy Wooden Beam Bridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -1.5, 0.4375, -0.4375, -1.375}, -- NodeBox1
			{0.40625, -0.125, -0.6875, 0.5, 0.875, -0.59375}, -- NodeBox2
			{0.40625, -0.125, 0.59375, 0.5, 0.875, 0.6875}, -- NodeBox3
			{-0.5, -0.125, 0.59375, -0.40625, 0.875, 0.6875}, -- NodeBox4
			{-0.5, -0.125, -0.6875, -0.40625, 0.875, -0.59375}, -- NodeBox5
			{-0.5, 0.375, -1.5, -0.40625, 0.4375, -1.375}, -- NodeBox6
			{0.40625, 0.375, -1.5, 0.5, 0.4375, -1.375}, -- NodeBox7
			{-0.4375, -0.4375, -1.4375, 0.4375, -0.375, -1.3125}, -- NodeBox8
			{-0.4375, -0.375, -1.375, 0.4375, -0.3125, -1.25}, -- NodeBox9
			{-0.4375, -0.3125, -1.3125, 0.4375, -0.25, -1.125}, -- NodeBox10
			{-0.4375, -0.25, -1.1875, 0.4375, -0.1875, -1}, -- NodeBox11
			{-0.4375, -0.1875, -1.0625, 0.4375, -0.125, -0.75}, -- NodeBox12
			{-0.4375, -0.125, -0.8125, 0.4375, -0.0625, -0.4375}, -- NodeBox13
			{-0.4375, -0.125, 0.4375, 0.4375, -0.0625, 0.8125}, -- NodeBox14
			{-0.4375, -0.0625, -0.5, 0.4375, 0, 0.5}, -- NodeBox15
			{-0.4375, -0.1875, 0.75, 0.4375, -0.125, 1.0625}, -- NodeBox16
			{-0.4375, -0.25, 1, 0.4375, -0.1875, 1.1875}, -- NodeBox17
			{-0.4375, -0.3125, 1.125, 0.4375, -0.25, 1.3125}, -- NodeBox18
			{-0.4375, -0.375, 1.25, 0.4375, -0.3125, 1.375}, -- NodeBox19
			{-0.4375, -0.4375, 1.3125, 0.4375, -0.375, 1.4375}, -- NodeBox20
			{-0.4375, -0.5, 1.375, 0.4375, -0.4375, 1.5}, -- NodeBox21
			{-0.5, 0.4375, -1.4375, -0.40625, 0.5, -1.3125}, -- NodeBox22
			{-0.5, 0.5, -1.375, -0.40625, 0.5625, -1.25}, -- NodeBox23
			{-0.5, 0.5625, -1.3125, -0.40625, 0.625, -1.125}, -- NodeBox24
			{-0.5, 0.625, -1.1875, -0.40625, 0.6875, -1}, -- NodeBox25
			{-0.5, 0.6875, -1.0625, -0.40625, 0.75, -0.75}, -- NodeBox26
			{-0.5, 0.75, -0.8125, -0.40625, 0.8125, -0.4375}, -- NodeBox27
			{-0.5, 0.8125, -0.5, -0.40625, 0.875, 0.5}, -- NodeBox28
			{-0.5, 0.75, 0.4375, -0.40625, 0.8125, 0.8125}, -- NodeBox29
			{-0.5, 0.6875, 0.75, -0.40625, 0.75, 1.0625}, -- NodeBox30
			{-0.5, 0.625, 1, -0.40625, 0.6875, 1.1875}, -- NodeBox31
			{-0.5, 0.5625, 1.125, -0.40625, 0.625, 1.3125}, -- NodeBox32
			{-0.5, 0.5, 1.25, -0.40625, 0.5625, 1.375}, -- NodeBox33
			{-0.5, 0.4375, 1.3125, -0.40625, 0.5, 1.4375}, -- NodeBox34
			{-0.5, 0.375, 1.375, -0.40625, 0.4375, 1.5}, -- NodeBox35
			{0.40625, 0.4375, -1.4375, 0.5, 0.5, -1.3125}, -- NodeBox36
			{0.40625, 0.5, -1.375, 0.5, 0.5625, -1.25}, -- NodeBox37
			{0.40625, 0.5625, -1.3125, 0.5, 0.625, -1.125}, -- NodeBox38
			{0.40625, 0.625, -1.1875, 0.5, 0.6875, -1}, -- NodeBox39
			{0.40625, 0.6875, -1.0625, 0.5, 0.75, -0.75}, -- NodeBox40
			{0.40625, 0.75, -0.8125, 0.5, 0.8125, -0.4375}, -- NodeBox41
			{0.40625, 0.8125, -0.5, 0.5, 0.875, 0.5}, -- NodeBox42
			{0.40625, 0.75, 0.4375, 0.5, 0.8125, 0.8125}, -- NodeBox43
			{0.40625, 0.6875, 0.75, 0.5, 0.75, 1.0625}, -- NodeBox44
			{0.40625, 0.625, 1, 0.5, 0.6875, 1.1875}, -- NodeBox45
			{0.40625, 0.5625, 1.125, 0.5, 0.625, 1.3125}, -- NodeBox46
			{0.40625, 0.5, 1.25, 0.5, 0.5625, 1.375}, -- NodeBox47
			{0.40625, 0.4375, 1.3125, 0.5, 0.5, 1.4375}, -- NodeBox48
			{0.40625, 0.375, 1.375, 0.5, 0.4375, 1.5}, -- NodeBox49
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -1.5, 0.5, 0.5, 1.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:large_beam_swivel_normal", {
	description = "Large Wooden Swivel Bridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -1.5, 0.4375, -0.4375, 1.5}, -- NodeBox1
			{0.40625, -0.5, -0.6875, 0.5, 0.5, -0.59375}, -- NodeBox2
			{0.40625, -0.5, 0.59375, 0.5, 0.5, 0.6875}, -- NodeBox3
			{-0.5, -0.5, 0.59375, -0.40625, 0.5, 0.6875}, -- NodeBox4
			{-0.5, -0.5, -0.6875, -0.40625, 0.5, -0.59375}, -- NodeBox5
			{-0.5, 0.375, -1.5, -0.40625, 0.4375, 1.5}, -- NodeBox6
			{0.40625, 0.375, -1.5, 0.5, 0.4375, 1.5}, -- NodeBox7
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -1.5, 0.5, 0.5, 1.5},
		},
    },
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name = "bridger:large_beam_swivel_open", param2 = node.param2})
	end,
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:large_beam_swivel_open", {
	description = "Large Wooden Swivel Bridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png^[transformR90"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-1.5, -0.5, -0.4375, 1.5, -0.4375, 0.4375}, -- NodeBox1
			{-0.6875, -0.5, -0.5, -0.59375, 0.5, -0.40625}, -- NodeBox2
			{0.59375, -0.5, -0.5, 0.6875, 0.5, -0.40625}, -- NodeBox3
			{0.59375, -0.5, 0.40625, 0.6875, 0.5, 0.5}, -- NodeBox4
			{-0.6875, -0.5, 0.40625, -0.59375, 0.5, 0.5}, -- NodeBox5
			{-1.5, 0.375, 0.40625, 1.5, 0.4375, 0.5}, -- NodeBox6
			{-1.5, 0.375, -0.5, 1.5, 0.4375, -0.40625}, -- NodeBox7
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-1.5, -0.5, -0.5, 1.5, 0.5, 0.5},
		},
    },
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name = "bridger:large_beam_swivel_normal", param2 = node.param2})
	end,
	drop = "bridger:large_beam_swivel_normal",
	groups = {choppy=3, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:large_drawbridge_normal", {
	description = "Large Wooden Drawbridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, -0.4375, 1.5}, -- NodeBox1
			{0.40625, -0.5, -0.5, 0.5, 0.5, -0.40625}, -- NodeBox2
			{0.40625, -0.5, 0.59375, 0.5, 0.5, 0.6875}, -- NodeBox3
			{-0.5, -0.5, 0.59375, -0.40625, 0.5, 0.6875}, -- NodeBox4
			{-0.5, -0.5, -0.5, -0.40625, 0.5, -0.40625}, -- NodeBox5
			{-0.5, 0.375, -0.5, -0.40625, 0.4375, 1.5}, -- NodeBox6
			{0.40625, 0.375, -0.5, 0.5, 0.4375, 1.5}, -- NodeBox7
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 1.5},
		},
    },
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name = "bridger:large_drawbridge_open", param2 = node.param2})
	end,
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:large_drawbridge_open", {
	description = "Large Wooden Drawbridge",
	drawtype = "nodebox",
	tiles = {"default_wood.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.5, 0.4375, -0.3125, -0.4375}, -- NodeBox1
			{0.40625, -0.5, -0.5, 0.5, 0.5, -0.40625}, -- NodeBox2
			{0.40625, 0.875, 0.15625, 0.5, 2.125, 0.25}, -- NodeBox3
			{-0.5, 0.875, 0.15625, -0.40625, 2.125, 0.25}, -- NodeBox4
			{-0.5, -0.5, -0.5, -0.40625, 0.5, -0.40625}, -- NodeBox5
			{-0.5, 0.375, -0.5, -0.40625, 0.5625, -0.4375}, -- NodeBox6
			{0.40625, 0.375, -0.5, 0.5, 0.5625, -0.4375}, -- NodeBox7
			{-0.4375, -0.375, -0.4375, 0.4375, -0.1875, -0.375}, -- NodeBox8
			{-0.4375, -0.25, -0.375, 0.4375, -0.0625, -0.3125}, -- NodeBox9
			{-0.4375, -0.125, -0.3125, 0.4375, 0.0625, -0.25}, -- NodeBox10
			{-0.4375, 0, -0.25, 0.4375, 0.1875, -0.1875}, -- NodeBox11
			{-0.4375, 0.125, -0.1875, 0.4375, 0.3125, -0.125}, -- NodeBox12
			{-0.4375, 0.25, -0.125, 0.4375, 0.4375, -0.0625}, -- NodeBox13
			{-0.4375, 0.375, -0.0625, 0.4375, 0.5625, 0}, -- NodeBox14
			{-0.4375, 0.5, 0, 0.4375, 0.6875, 0.0625}, -- NodeBox15
			{-0.4375, 0.625, 0.0625, 0.4375, 0.8125, 0.125}, -- NodeBox16
			{-0.4375, 0.75, 0.125, 0.4375, 0.9375, 0.1875}, -- NodeBox17
			{-0.4375, 0.875, 0.1875, 0.4375, 1.0625, 0.25}, -- NodeBox18
			{-0.4375, 1, 0.25, 0.4375, 1.1875, 0.3125}, -- NodeBox19
			{-0.4375, 1.125, 0.3125, 0.4375, 1.3125, 0.375}, -- NodeBox20
			{-0.5, 0.5, -0.4375, -0.40625, 0.6875, -0.375}, -- NodeBox21
			{-0.5, 0.625, -0.375, -0.40625, 0.8125, -0.3125}, -- NodeBox22
			{-0.5, 0.75, -0.3125, -0.40625, 0.9375, -0.25}, -- NodeBox23
			{-0.5, 0.875, -0.25, -0.40625, 1.0625, -0.1875}, -- NodeBox24
			{-0.5, 1, -0.1875, -0.40625, 1.1875, -0.125}, -- NodeBox25
			{-0.5, 1.125, -0.125, -0.40625, 1.3125, -0.0625}, -- NodeBox26
			{-0.5, 1.25, -0.0625, -0.40625, 1.4375, 0}, -- NodeBox27
			{-0.5, 1.375, 0, -0.40625, 1.5625, 0.0625}, -- NodeBox28
			{-0.5, 1.5, 0.0625, -0.40625, 1.6875, 0.125}, -- NodeBox29
			{-0.5, 1.625, 0.125, -0.40625, 1.8125, 0.1875}, -- NodeBox30
			{-0.5, 1.75, 0.1875, -0.40625, 1.9375, 0.25}, -- NodeBox31
			{-0.5, 1.875, 0.25, -0.40625, 2.0625, 0.3125}, -- NodeBox32
			{-0.5, 2, 0.3125, -0.40625, 2.1875, 0.375}, -- NodeBox33
			{0.40625, 0.5, -0.4375, 0.5, 0.6875, -0.375}, -- NodeBox34
			{0.40625, 0.625, -0.375, 0.5, 0.8125, -0.3125}, -- NodeBox35
			{0.40625, 0.75, -0.3125, 0.5, 0.9375, -0.25}, -- NodeBox36
			{0.40625, 0.875, -0.25, 0.5, 1.0625, -0.1875}, -- NodeBox37
			{0.40625, 1, -0.1875, 0.5, 1.1875, -0.125}, -- NodeBox38
			{0.40625, 1.125, -0.125, 0.5, 1.3125, -0.0625}, -- NodeBox39
			{0.40625, 1.25, -0.0625, 0.5, 1.4375, 0}, -- NodeBox40
			{0.40625, 1.375, 0, 0.5, 1.5625, 0.0625}, -- NodeBox41
			{0.40625, 1.5, 0.0625, 0.5, 1.6875, 0.125}, -- NodeBox42
			{0.40625, 1.625, 0.125, 0.5, 1.8125, 0.1875}, -- NodeBox43
			{0.40625, 1.75, 0.1875, 0.5, 1.9375, 0.25}, -- NodeBox44
			{0.40625, 1.875, 0.25, 0.5, 2.0625, 0.3125}, -- NodeBox45
			{0.40625, 2, 0.3125, 0.5, 2.1875, 0.375}, -- NodeBox46
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
			{-0.5, -0.5, -0.5, 0.5, 2.1875, 0.5},
		},
    },
	on_rightclick = function(pos, node)
		minetest.set_node(pos, {name = "bridger:large_drawbridge_normal", param2 = node.param2})
	end,
	drop = "bridger:large_drawbridge_normal",
	groups = {choppy=3, not_in_creative_inventory=1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:deck_wood", {
	description = "Wooden Deck",
	drawtype = "nodebox",
	tiles = {"default_junglewood.png"},
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, 0.375, -0.5, 0.5, 0.501, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, 0, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_node("bridger:foundation", {
	description = "Bridge Foundation",
	drawtype = "nodebox",
	tiles = {"default_clay.png"},
	paramtype = "light",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.75, 0.5, 0.501, 0.75}, -- NodeBox1
			{-0.501, -0.5, -0.501, 0.501, 0.6876, 0.501}, -- NodeBox2
			{-0.75, -0.5, -0.5, 0.75, 0.501, 0.5}, -- NodeBox3
			{-0.75, -0.5, -0.75, 0.75, 0.499, 0.75}, -- NodeBox4
		},
	},
	selection_box = {
		type = "fixed",
        fixed = {
            {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
    },
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})