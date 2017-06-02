ITEM.name = "Клевец"
ITEM.desc = "Колюще-ударное оружие."
ITEM.class = "nut_club_cleave"
ITEM.weaponCategory = "secondary"
ITEM.price = 200
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/daedric/club/w_daedric_club.mdl"
ITEM.width = 3
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(0, 29.25701713562, -1.5030181407928),
	ang = Angle(0, 270, 82.826560974121),
	fov = 45
}
ITEM.damage = {1, 4}
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
						["Arguments"] = "nut_club_cleave",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(13.882658958435, 139.22515869141, 110.72068786621),
				["UniqueID"] = "732790205",
				["Position"] = Vector(6.12890625, -1.48388671875, -3.0023193359375),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/daedric/club/w_daedric_club.mdl",
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