ITEM.name = "Топор"
ITEM.desc = "Используется для рубки деревьев."
ITEM.class = "nut_axe_hatchet"
ITEM.weaponCategory = "primary"
ITEM.price = 100
ITEM.category = "Оружие"
ITEM.model = "models/weapons/hl2meleepack/w_axe.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-0.0090725440531969, 1.017750620842, 76.024772644043),
	ang = Angle(90, 0, 89.952346801758),
	fov = 45
}
ITEM.type = "1h"
ITEM.damage = {1, 5}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_axe_hatchet",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-4.2934250831604, 20.52303314209, 9.2424583435059),
				["UniqueID"] = "732790205",
				["Position"] = Vector(12.271240234375, 2.880126953125, 3.5009765625),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/weapons/hl2meleepack/w_axe.mdl",
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