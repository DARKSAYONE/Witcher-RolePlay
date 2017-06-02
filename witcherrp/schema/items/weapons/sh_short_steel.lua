ITEM.name = "Стальной короткий меч"
ITEM.desc = "Удобен в ближнем бою."
ITEM.class = "nut_short_steel"
ITEM.weaponCategory = "secondary"
ITEM.price = 450
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/imperial/shortsword/w_imperial_shortsword.mdl"
ITEM.width = 4
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0, 54.813533782959, 6.730562210083),
	ang = Angle(0, 270, 76.969116210938),
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
						["Event"] = "weapon_class",
						["Arguments"] = "nut_short_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(20.576623916626, 141.9306640625, 111.52377319336),
				["UniqueID"] = "732790205",
				["Position"] = Vector(3.4730834960938, -3.9169921875, -1.3170166015625),
				["EditorExpand"] = true,
				["Bone"] = "right thigh",
				["Model"] = "models/morrowind/imperial/shortsword/w_imperial_shortsword.mdl",
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