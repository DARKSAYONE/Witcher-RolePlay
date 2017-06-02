ITEM.name = "Длинный железный меч"
ITEM.desc = "Грубо выкованный меч из железа."
ITEM.class = "nut_long_iron"
ITEM.weaponCategory = "primary"
ITEM.price = 200
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/longsword/w_iron_longsword.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.46913310885429, 82.85099029541, 15.043271064758),
	ang = Angle(0, 270, 80.517555236816),
	fov = 45
}
ITEM.damage = {1, 6}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Arguments"] = "nut_long_iron",
						["UniqueID"] = "1438428583",
						["Event"] = "weapon_class",
						["ClassName"] = "event",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(5.23894739151, 124.98949432373, 89.698127746582),
				["UniqueID"] = "3565616645",
				["Position"] = Vector(0.38162231445313, -3.521728515625, 3.783203125),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/iron/longsword/w_iron_longsword.mdl",
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