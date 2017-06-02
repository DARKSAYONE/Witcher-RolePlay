ITEM.name = "Имперская стальная булава"
ITEM.desc = "Булава с характерным чёрным окрасом."
ITEM.class = "nut_mace_nilf"
ITEM.weaponCategory = "primary"
ITEM.price = 250
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/ebony/mace/w_ebony_mace.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1.0090725421906, 53.753803253174, 5.0151271820068),
	ang = Angle(0, 270, -101.70430755615),
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
						["Event"] = "weapon_class",
						["Arguments"] = "nut_mace_nilf",
						["UniqueID"] = "2195922949",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(-63.254837036133, -66.692153930664, -52.068050384521),
				["UniqueID"] = "73731660",
				["Position"] = Vector(-1.28466796875, -3.9662475585938, 1.72412109375),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/ebony/mace/w_ebony_mace.mdl",
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