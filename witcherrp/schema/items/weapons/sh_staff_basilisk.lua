ITEM.name = "Магический посох с головой василиска"
ITEM.desc = "Не смотря на магическое происхождение, можно использовать его в бою."
ITEM.class = "nut_staff_vasilisk"
ITEM.weaponCategory = "primary"
ITEM.price = 1000
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/silver/staff/w_silver_staff.mdl"
ITEM.width = 6
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-2.5155670642853, 99.802474975586, 1.4461778402328),
	ang = Angle(0, 270, -97.522384643555),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {1, 4}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_staff_vasilisk",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-48.638862609863, -176.72184753418, -13.751992225647),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-10.67333984375, -1.381103515625, -4.8779296875),
				["EditorExpand"] = true,
				["Bone"] = "spine 4",
				["Model"] = "models/morrowind/silver/staff/w_silver_staff.mdl",
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