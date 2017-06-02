ITEM.name = "Кирка"
ITEM.desc = "Используется для добычи руд."
ITEM.class = "nut_pickaxe"
ITEM.weaponCategory = "primary"
ITEM.price = 150
ITEM.category = "Оружие"
ITEM.model = "models/weapons/w_stone_pickaxe.mdl"
ITEM.width = 5
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 77.815528869629, 0),
	ang = Angle(0, 270, 0),
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
						["Arguments"] = "nut_pickaxe",
						["UniqueID"] = "2195922949",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(18.034879684448, -138.15878295898, -108.83853149414),
				["UniqueID"] = "73731660",
				["Position"] = Vector(10.297485351563, 0.77573394775391, 4.05419921875),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/weapons/w_stone_pickaxe.mdl",
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