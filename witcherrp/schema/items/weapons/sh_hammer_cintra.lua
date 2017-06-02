ITEM.name = "Цинтрийский боевой молот"
ITEM.desc = "Обладает характерной окраской и гравировками."
ITEM.class = "nut_hammer_cintra"
ITEM.weaponCategory = "primary"
ITEM.price = 700
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/orcish/hammer/w_orcish_hammer.mdl"
ITEM.width = 6
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-1.0792573690414, 95.007904052734, 4.5090727806091),
	ang = Angle(0, 270, -97.564643859863),
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
						["Arguments"] = "nut_hammer_cintra",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-40.770183563232, -174.94778442383, -9.7712001800537),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-6.2412414550781, -2.2978515625, -3.2152099609375),
				["EditorExpand"] = true,
				["Bone"] = "spine 4",
				["Model"] = "models/morrowind/orcish/hammer/w_orcish_hammer.mdl",
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