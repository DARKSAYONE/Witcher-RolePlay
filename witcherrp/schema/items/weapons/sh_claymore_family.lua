ITEM.name = "Фамильный двуручный меч"
ITEM.desc = "Покрыт множеством гравировок и белых пятен. Похоже, это семенная реликвия."
ITEM.class = "nut_claymore_family"
ITEM.weaponCategory = "primary"
ITEM.price = 750
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/silver/claymore/w_silver_claymore.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(1.5029816627502, 89.312103271484, 18.768417358398),
	ang = Angle(0, 270, 81.526420593262),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {2, 6}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_claymore_family",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-5.4428701400757, 152.64366149902, 74.911987304688),
				["UniqueID"] = "732790205",
				["Position"] = Vector(0.375244140625, -10.05615234375, -0.64794921875),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/silver/claymore/w_silver_claymore.mdl",
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