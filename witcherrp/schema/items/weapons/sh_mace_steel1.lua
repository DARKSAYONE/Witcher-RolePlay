ITEM.name = "Стальная булава с шипами"
ITEM.desc = "На ее конце закреплено несколько острых шипов."
ITEM.class = "nut_mace_steel1"
ITEM.weaponCategory = "primary"
ITEM.price = 500
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/molagbal/mace/w_molagbal_mace.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 53.455486297607, 4.5332536697388),
	ang = Angle(0, 270, 80.354904174805),
	fov = 45
}
ITEM.damage = {1, 8}
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
						["Arguments"] = "nut_mace_steel1",
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
				["Model"] = "models/morrowind/molagbal/mace/w_molagbal_mace.mdl",
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