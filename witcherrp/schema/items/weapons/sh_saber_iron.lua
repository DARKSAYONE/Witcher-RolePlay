ITEM.name = "Железная сабля"
ITEM.desc = "Меч с искривленным лезвием."
ITEM.class = "nut_saber_iron"
ITEM.weaponCategory = "primary"
ITEM.price = 200
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/saber/w_iron_saber.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.06674175709486, 70.663093566895, 10.824563026428),
	ang = Angle(0, 270, -100.06994628906),
	fov = 45
}

ITEM.permit = "melee"
ITEM.damage = {2, 4}
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_saber_iron",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-8.4964141845703, 121.16206359863, 87.364044189453),
				["UniqueID"] = "732790205",
				["Position"] = Vector(0.82049560546875, -1.4083251953125, 2.66357421875),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/iron/saber/w_iron_saber.mdl",
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