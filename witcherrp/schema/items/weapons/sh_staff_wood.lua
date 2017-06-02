ITEM.name = "Походный посох"
ITEM.desc = "Используется при долгих путешествиях."
ITEM.class = "nut_staff_wood"
ITEM.weaponCategory = "primary"
ITEM.price = 100
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/wooden/staff/w_wooden_staff.mdl"
ITEM.width = 6
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-2.6501636505127, 89.012596130371, 0),
	ang = Angle(0, 270, 78.337577819824),
	fov = 45
}
ITEM.damage = {1, 4}
ITEM.type = "2h"
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
						["Arguments"] = "nut_staff_wood",
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
				["Model"] = "models/morrowind/wooden/staff/w_wooden_staff.mdl",
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