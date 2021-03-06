ITEM.name = "Стальная секира"
ITEM.desc = "Два заточенных лезвия, огромный вес. Это очень могучее оружие."
ITEM.class = "nut_axe_steel2"
ITEM.weaponCategory = "primary"
ITEM.price = 600
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/battleaxe/w_steelbattleaxe.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-1.5120005607605, 92.546844482422, 0),
	ang = Angle(0, 270, -97.969284057617),
	fov = 45
}
ITEM.type = "2h"
ITEM.permit = "melee"
ITEM.damage = {2, 6}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_axe_steel2",
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
				["Model"] = "models/morrowind/steel/battleaxe/w_steelbattleaxe.mdl",
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