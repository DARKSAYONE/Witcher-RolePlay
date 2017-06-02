ITEM.name = "Длинный стальной меч"
ITEM.desc = "Качественная сталь и хорошая заточка позволяют эффективно использовать его в бою."
ITEM.class = "nut_long_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 550
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/longsword/w_steel_longsword.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 62.247676849365, 12.610820770264),
	ang = Angle(0, 270, -99.911315917969),
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
						["Arguments"] = "nut_long_steel",
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
				["Model"] = "models/morrowind/steel/longsword/w_steel_longsword.mdl",
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