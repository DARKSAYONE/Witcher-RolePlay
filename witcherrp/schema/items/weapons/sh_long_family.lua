ITEM.name = "Фамильный длинный меч"
ITEM.desc = "Весь покрыт гравировками. Похож на семейную реликвию."
ITEM.class = "nut_long_family"
ITEM.weaponCategory = "primary"
ITEM.price = 600
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/silver/longsword/w_silver_longsword.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.5, 71.682510375977, 11.756512641907),
	ang = Angle(0, 270, -98.883293151855),
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
						["Arguments"] = "nut_long_family",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-5.4428701400757, 152.64366149902, 74.911987304688),
				["UniqueID"] = "732790205",
				["Position"] = Vector(3.51318359375, -4.351318359375, 1.10107421875),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/silver/longsword/w_silver_longsword.mdl",
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