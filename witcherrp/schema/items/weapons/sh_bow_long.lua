ITEM.name = "Длинный лук"
ITEM.desc = "Позволяет стрелять на большие расстояния."
ITEM.class = "nut_bow_long"
ITEM.weaponCategory = "primary"
ITEM.price = 250
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/artifacts/longbow/w_bow_of_shadows.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-5.689178943634, 68.602279663086, -2.0434617996216),
	ang = Angle(0, 270, -103.06331634521),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {1, 7}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_bow_long",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(1.5164324045181, 100.70363616943, 93.428733825684),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-6.0897827148438, -3.43212890625, 5.567626953125),
				["EditorExpand"] = true,
				["Bone"] = "spine 4",
				["Model"] = "models/morrowind/artifacts/longbow/w_bow_of_shadows.mdl",
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
},}