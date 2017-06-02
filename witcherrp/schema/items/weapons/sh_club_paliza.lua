ITEM.name = "Палица"
ITEM.desc = "Увесистая ветка дерева, которая может использоваться в бою."
ITEM.class = "nut_club_paliza"
ITEM.weaponCategory = "secondary"
ITEM.price = 50
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/iron/club/w_iron_club.mdl"
ITEM.width = 3
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(-1.0090365409851, 36.107559204102, 3.008686542511),
	ang = Angle(0, 270, 84.588394165039),
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
						["Arguments"] = "nut_club_paliza",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(13.882658958435, 139.22515869141, 110.72068786621),
				["UniqueID"] = "732790205",
				["Position"] = Vector(3.9833984375, -3.5576171875, -1.9090576171875),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/iron/club/w_iron_club.mdl",
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