ITEM.name = "Ясеневый лук"
ITEM.desc = "Обладает неимоверной мощностью."
ITEM.class = "nut_bow_ash"
ITEM.weaponCategory = "primary"
ITEM.price = 350
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/normal/longbow/w_longbow.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-5.0461688041687, 88.328254699707, -1.5115215778351),
	ang = Angle(0, 270, -100.15674591064),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {1, 8}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_bow_ash",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(1.5164324045181, 100.70363616943, 93.428733825684),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-6.4049682617188, -3.70751953125, 5.5918579101563),
				["EditorExpand"] = true,
				["Bone"] = "spine 4",
				["Model"] = "models/morrowind/normal/longbow/w_longbow.mdl",
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
