ITEM.name = "Стальная сабля"
ITEM.desc = "Длинное и искривленное лезвие позволяет наносить удары с неожиданных углов, что ценится многими фехтовальщиками."
ITEM.class = "nut_saber_steel"
ITEM.weaponCategory = "primary"
ITEM.price = 500
ITEM.category = "Оружие"
ITEM.model = "models/morrowind/steel/saber/w_steel_saber.mdl"
ITEM.width = 5
ITEM.height = 1
ITEM.iconCam = {
	pos = Vector(0.83510649204254, 69.086585998535, 12.093685150146),
	ang = Angle(0, 270, 78.782707214355),
	fov = 45
}
ITEM.damage = {1, 10}
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
						["Arguments"] = "nut_saber_steel",
						["UniqueID"] = "4011003967",
						["ClassName"] = "event",
					},
				},
			},
			["self"] = {
				["Angles"] = Angle(10.576568603516, 146.41220092773, 88.797355651855),
				["UniqueID"] = "732790205",
				["Position"] = Vector(-1.1302795410156, -3.126953125, 3.021484375),
				["EditorExpand"] = true,
				["Bone"] = "left thigh",
				["Model"] = "models/morrowind/steel/saber/w_steel_saber.mdl",
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