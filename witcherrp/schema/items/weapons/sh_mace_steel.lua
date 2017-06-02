ITEM.name = "Стальная булава"
ITEM.desc = "Сталь придает изрядный вес этому оружию."
ITEM.class = "nut_mace_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 400
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/mace/w_steel_mace.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.95461708307266, 41.463924407959, 4.9945607185364),
	ang = Angle(0, 270, -99.56852722168),
	fov = 45
}
ITEM.damage = {2, 4}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_mace_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(0.69784027338028, -69.158134460449, -84.150405883789),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-0.352294921875, 3.044677734375, 3.6806640625),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/steel/mace/w_steel_mace.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "2083764954",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}