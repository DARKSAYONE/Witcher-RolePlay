ITEM.name = "Стальной боевой молот"
ITEM.desc = "Воин должен обладать неимоверной силой, чтобы лишь поднять это оружие."
ITEM.class = "nut_hammer_nord"
ITEM.weaponCategory = "primary"
ITEM.price = 700
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/nordic/hammer/w_nordic_hammer.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-1.0030722618103, 95.334526062012, 5.5181088447571),
	ang = Angle(0, 270, -95.459320068359),
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
						["Arguments"] = "nut_hammer_nord",
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
				["Model"] = "models/morrowind/nordic/hammer/w_nordic_hammer.mdl",
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