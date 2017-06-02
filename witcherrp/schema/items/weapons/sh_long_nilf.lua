ITEM.name = "Нильфгаардский длинный меч"
ITEM.desc = "Распространенное оружие солдат Нильфгаарда."
ITEM.class = "nut_long_nilf"
ITEM.weaponCategory = "primary"
ITEM.price = 300
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/ebony/longsword/w_ebony_longsword.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.98789113759995, 66.344734191895, 13.418037414551),
	ang = Angle(0, 270, -101.77032470703),
	fov = 45
}

ITEM.damage = {2, 4}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Event"] = "weapon_class",
						["Arguments"] = "nut_long_nilf",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-4.3824439048767, 152.38891601563, 76.609886169434),
				["UniqueID"] = "732790205",
				["Position"] = Vector(2.84130859375, -3.77587890625, 1.6092834472656),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/ebony/longsword/w_ebony_longsword.mdl",
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