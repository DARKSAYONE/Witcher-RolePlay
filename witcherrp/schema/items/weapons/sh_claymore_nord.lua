ITEM.name = "Северный двуручный меч"
ITEM.desc = "Весь покрыт гравировками."
ITEM.class = "nut_claymore_nord"
ITEM.weaponCategory = "primary"
ITEM.price = 450
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/nordic/claymore/w_nordic_claymore.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(2.0513939857483, 89.78955078125, 17.869310379028),
	ang = Angle(0, 270, 79.48104095459),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {1, 10}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_claymore_nord",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(5.3852696418762, -46.272087097168, -81.347999572754),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-4.2627868652344, -1.9063720703125, 3.006103515625),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/nordic/claymore/w_nordic_claymore.mdl",
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