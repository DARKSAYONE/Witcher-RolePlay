ITEM.name = "Железный боевой топор"
ITEM.desc = "Лёгкий боевой топор. Часто используется из-за своей универсальности"
ITEM.class = "nut_axe_iron"
ITEM.weaponCategory = "secondary"
ITEM.price = 150
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/axe/w_ironaxe.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(3.0455455780029, 39.652866363525, 3.9546694755554),
	ang = Angle(0, 270, 78.958641052246),
	fov = 45
}
ITEM.type = "1h"
ITEM.permit = "melee"
ITEM.damage = {1, 6}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_axe_iron",
						["UniqueID"] = "1438428583",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(1.6851960420609, 99.599006652832, -92.047691345215),
				["UniqueID"] = "3565616645",
				["Position"] = Vector(9.1797485351563, 4.4708251953125, 3.572265625),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/iron/axe/w_ironaxe.mdl",
				["ClassName"] = "model",
			},
		},
	},
	["self"] = {
		["EditorExpand"] = true,
		["UniqueID"] = "3535041505",
		["ClassName"] = "group",
		["Name"] = "my outfit",
		["Description"] = "add parts to me!",
	},
},
}