ITEM.name = "Улучшенная палица"
ITEM.desc = "Гвозди заменены на заточенные шипы."
ITEM.class = "nut_club_paliza1"
ITEM.weaponCategory = "secondary"
ITEM.price = 150
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/spiked/club/w_spiked_club.mdl"
ITEM.width = 3
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1.0206956863403, 48.483875274658, 3.9612326622009),
	ang = Angle(0, 270, -97.630584716797),
	fov = 45
}
ITEM.damage = {1, 6}
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
						["Arguments"] = "nut_club_paliza1",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(13.882658958435, 139.22515869141, 110.72068786621),
				["UniqueID"] = "732790205",
				["Position"] = Vector(3.4730834960938, -3.9169921875, -1.3170166015625),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/spiked/club/w_spiked_club.mdl",
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