ITEM.name = "Киянка"
ITEM.desc = "Деревянный молоток. Может использоваться как в быту, так и в бою."
ITEM.class = "nut_hammer_iron"
ITEM.weaponCategory = "primary"
ITEM.price = 250
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/hammer/w_iron_hammer.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-1.1684904098511, 98.419136047363, 6),
	ang = Angle(0, 270, -98.040565490723),
	fov = 45
}
ITEM.type = "2h"
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
						["Arguments"] = "nut_hammer_iron",
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
				["Model"] = "models/morrowind/iron/hammer/w_iron_hammer.mdl",
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