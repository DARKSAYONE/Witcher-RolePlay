ITEM.name = "Краснолюдская булава"
ITEM.desc = "Оружие прямиком из Махакама."
ITEM.class = "nut_mace_krasno"
ITEM.weaponCategory = "primary"
ITEM.price = 450
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/dwemer/mace/w_dwemer_mace.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1.1613028049469, 38.889915466309, 3.7850933074951),
	ang = Angle(0, 270, -99.830200195313),
	fov = 45
}
ITEM.damage = {1, 8}
ITEM.permit = "melee"
ITEM.pacData = {[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Arguments"] = "nut_mace_krasno",
						["UniqueID"] = "1438428583",
						["Event"] = "weapon_class",
						["ClassName"] = "event",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-0.22193902730942, -60.532604217529, -89.131080627441),
				["UniqueID"] = "3565616645",
				["Position"] = Vector(5.0057983398438, 0.21484375, 3.443359375),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/dwemer/mace/w_dwemer_mace.mdl",
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