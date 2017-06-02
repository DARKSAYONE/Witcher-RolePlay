ITEM.name = "Нильфгаардский посох"
ITEM.desc = "Используется имперскими магами."
ITEM.class = "nut_staff_nilf"
ITEM.weaponCategory = "primary"
ITEM.price = 750
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/ebony/staff/w_ebony_staff.mdl"
ITEM.width = 6
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-104.2232131958, -0.49471011757851, -2.9791252613068),
	ang = Angle(0, -0, -88.792282104492),
	fov = 45
}
ITEM.damage = {1, 6}
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
						["Arguments"] = "nut_staff_nilf",
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
				["Model"] = "models/morrowind/ebony/staff/w_ebony_staff.mdl",
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