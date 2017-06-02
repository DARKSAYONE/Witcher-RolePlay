ITEM.name = "Лёгкий арбалет"
ITEM.desc = "Довольно мощное оружие дальнего боя."
ITEM.class = "nut_crossbow"
ITEM.weaponCategory = "primary"
ITEM.price = 100
ITEM.category = "Оружие"
ITEM.model = "models/dawnguardd/weapon_dawnguardcrossbow_dawnguardcrossbow.mdl"
ITEM.width = 4
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 0, 76.249076843262),
	ang = Angle(90, 0, -90),
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
						["Arguments"] = "nut_crossbow",
						["UniqueID"] = "3827507127",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(69.219139099121, -94.362457275391, 102.78860473633),
				["UniqueID"] = "2529926549",
				["Position"] = Vector(-8.2353515625, 0.16744613647461, -1.7010498046875),
				["EditorExpand"] = true,
				["Bone"] = "chest",
				["Model"] = "models/dawnguardd/weapon_dawnguardcrossbow_dawnguardcrossbow.mdl",
				["ClassName"] = "model",
			},
		},
		[2] = {
			["children"] = {
			},
			["self"] = {
				["Angles"] = Angle(77.822196960449, 88.085426330566, 178.31161499023),
				["UniqueID"] = "2292873076",
				["Position"] = Vector(5.3163452148438, -2.30712890625, 0.8992919921875),
				["Bone"] = "right thigh",
				["Model"] = "models/dawnguardd/weapon_dawnguardcrossbow_dawnguardquiver.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "3888997461",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}